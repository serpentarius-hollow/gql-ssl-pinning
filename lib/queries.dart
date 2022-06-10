const homePageQuery = '''
fragment productSet on ProductSet {
  code
  name
  status
  start
  end
  products {
    code
    name
    description
    finalPrice{
        promo
        setoko
        stock
    }
    medias {
      kind
      filename
      url
    }
    attributes {
      kind
    }
    brand {
      name
    }
    primaryCategory{
        name
    }
    length
    width
    height
    weight
    merchant{
        store
        active
    }
    stock
    ratingAverage
    sold
    reviewCount
    flashSale
    flashSaleDescription{
      normal
      promo
      promoDiscount
      stock
    }
    categoryLv1
    categoryLv2
    categoryLv3
    categoryLv4
    categoryLv5
  }
}

fragment product on Product {
  code
  name
  finalPrice {
    setoko
    promo
    stock
  }
  medias {
      kind
      filename
      url
  }
  merchant{
        store
        active
    }
  attributes {
    kind
  }
  flashSale
  flashSaleDescription{
    normal
    promo
    promoDiscount
    stock
  }
}

fragment bannerSet on BannerSet {
  code
  name
  banners {
    code
    name
    creativeName
    ordering
    visible
    target
    targetKind
    status
    variants {
      key
      kind
      filename
    }
  }
}

fragment brand on Brand {
  code
  name
  logo {
    kind
    filename
    url
  }
}

fragment brandSet on BrandSet {
  code
  name
  start
  end
  brands {
    code
    name
    creativeName
    bannerImage{
        url
        filename
        kind
    }
    featuredBanner{
        url
        filename
        kind
    }
    thumbnailBanner{
        url
        filename
        kind
    }
    ordering
    visible
    featured
    target
    logo {
      kind
      filename
      url
    }
  }
}

fragment setting on Setting {
      value
  }

fragment categorySet on CategorySet {
  code
  name
  categories {
    code
    name
    ordering
    visible
    logo{
        kind
        filename
        url
    }
  }
}

fragment orderStatus on OrderStateDetailKind {
    code
    en
    id
}

fragment ticketStatus on TicketDetailStatus {
    code
    descEn
    descId
}

fragment highlightSet on HighlightSet {
	code
	name
    start
    end
	highlights {
		code
		status
		start
		end
		banner {
            labelColor
			label {
				en
				id
			}
            backgroundColor
            backgroundImages {
                kind
                url
                filename
            }
            button {
                label {
                    en
                    id
                }
                backgroundColor
                labelColor
                target
                targetKind
            }
		}
        items {
            image {
                kind
                url
                filename
            }
            label {
                en
                id
            }
            target
            targetKind
        }
	}
}

fragment blog on Blog {
    code
    title
    shortDescription
    status
    viewed
    minuteReads
    url
    language
    thumbnailImages {
         kind
         url
         filename
    }
    categories {
      code
      name
		  status
	}
} 

fragment promotion on Promotion {
    code
    name
    title
    bannerImage{
        kind
        filename
        url
    }
    start
    end
    minimumTransaction
    termConditions{
        en
        id
    }
    benefitType
    coupons{
        code
    }
}

{
  orderStatus: orderStatus {
        ...orderStatus
  }

  ticketStatus: ticketStatus {
        ...ticketStatus
  }
  
  homepageBanners: bannerSets(criteria: { section: "Home-Main-Banner-Set" }) {
    ...bannerSet
  }

  homepageCategories: categorySets(criteria: { section: "Home-Main-Category-Set" }) {
    ...categorySet
  }

  homepageBrands: brandSets(criteria: { section: "Home-Main-Brand-Set" }) {
    ...brandSet
  }

  bannerDirectoryBrands: brandSets(criteria: { section: "brands-directory-brand-set" }) {
    ...brandSet
  }

  middleBanners: bannerSets(criteria: { section: "HOME-MIDDLE-BANNER-SET" }) {
    ...bannerSet
  }

  uspBanners: bannerSets(criteria: { section: "HOME-USP-BANNER-SET" }) {
    ...bannerSet
  }

  highlightProductHomepage: highlightSets(criteria: { 
	    section : "Home-Setoko-Highlights",
	    status : ACTIVE
    }) {
	    ...highlightSet 
    }

  productRecommendation: products(criteria: { categoryCode:
    "recommendation"}) {
    ...product
  }

  productRecommendationHomepage: productSets(criteria: { section:
    "Home-Main-Recommendation-Set"}) {
    ...productSet
  }

  homepageCoupons: bannerSets(criteria: { section: "HOMEPAGE COUPONS" }) {
    ...bannerSet
  }

  homepageSubscription: bannerSets(criteria: { section: "HOMEPAGE SUBSCRIPTIONS" }) {
    ...bannerSet
  }

  forYouProductSets: productSets(criteria: { section: 
    "FOR YOU" }) {
    ...productSet
  }

  productForYou: products(criteria: { categoryCode:
    "FOR YOU"}) {
    ...product
  }

  productBestsellers: products(criteria: { categoryCode:
    "bestsellers"}) {
    ...product
  }

  productPromos: products(criteria: { categoryCode:
    "promos"}) {
    ...product
  }
  
  superProductSets: productSets(criteria: { section: 
    "HOME-SUPER-PRODUCT-LIST-SET" }) {
    ...productSet
  }

  brands {
    ...brand
  }

  searchboxPlaceholder: settings(criteria: { code: 
    "SEARCH_BOX_PLACEHOLDER" }) {
    ...setting
  }

  helpCenter: settings(criteria: { code:
    "HELP_CENTER" }) {
        ...setting
    }
  
  aboutSetoko: settings(criteria:
    { code: "ABOUT_SETOKO" })
      { ...setting },
  
  ctCorpInformation: settings(criteria: { code: "CT_CORP_INFORMATION" }) { ...setting },

  howToShop: settings(criteria:{ code: "HOW_TO_SHOP" }){ ...setting },

  safeShoppingGuarantee: settings(criteria: { code: "SAFE_SHOPPING_GUARANTEE" }) { ...setting },
 
  privacyPolicy: settings(criteria:{ code: "PRIVACY_POLICY" }){ ...setting },

  returnRefund: settings(criteria: { code: "RETURN_AND_REFUND" }) { ...setting },
 
  termConditions: settings(criteria:{ code: "TERM_CONDITIONS" }){ ...setting },

  howToPay: settings(criteria:{ code: "PAYMENT_METHOD" }){ ...setting },

  deliveryInformation: settings(criteria: { code: "DELIVERY_INFORMATION" }) { ...setting },
  
  megaCreditCard: settings(criteria: { code: "MEGA_CREDIT_CARD" }) { ...setting },

  seeAllBlog: settings(criteria: { code: "BLOG" }) { ...setting },
  
  homepageBlog: blogs(criteria: {
        status : 2,
        language : "all"
    }) {
        ...blog
    }
  
  homepagePromotion: promotions(criteria: { tagCode: "", key: "", sort: "LATEST_DEALS", categoryCode : "", option: "WITH_COUPONS" }, offset: 0 , limit :10) {
    ...promotion
    }
}
''';
