Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE97D810A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjJZKoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjJZKoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 06:44:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BA18D;
        Thu, 26 Oct 2023 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698317060; x=1729853060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=g6PHcyX+BxdsjOxK6Qb79pmghZfKJjmtsQ0SokdEivA=;
  b=nBzTgKZF1gPHpHloUlUDOvwbaL9hnVOPrDfy+2Ki614UNq/fx3vJAhxR
   KR77JItONgkOR1d0qJlkKtyAaqtmgGHvK0kRHzu9L6dQTntjg7QeeZwHe
   Clfft/kLxKgttq44dg7/eQU2uTbK51W8wzJWGIKqWMCl7BzyvTYHabfC+
   hoqkT8sdR+2mUmFXJY/Y8BcSBcuWqYEXZzqYe8xmkbe/5KysOaAyGgJ6d
   4uuBFCuhDlro8a/XdTkFd4OoGSK2P0pA9Uo7B+Bqr0MqMbeeAdQEgIwWy
   W8UIr76EoF4L8m/L7TDpIzq0TkaSnWi6Lmb2/ZeHCt7HzJG5WmUusc4b/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418634485"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="418634485"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 03:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="849882927"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="849882927"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 03:44:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:44:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:44:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 03:44:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 03:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXBrv4U97HI16C2Oll6nf1mvSAcZBQn5NKfE5blCmiEvSe+ObSUNTJznwEc935I07SsckrCNs+eU3MDiEw+iG2945r5ActZ+d5y1mrhjeQQs9+7zTrxt08aopplC07Q3lmt6lSB6rVAEHFSja/veeTt+xe3F14DLoorGnaOT1OdhyXaONHVh5Yb60/IGSYR8Qiq3DriHEb/1pFyQpYJh06ZNld+JaeOdv1m49q47Z7ICpKzkQz67ckBXREksv3Tc/UVgrI1nA0dG/NwtfTZmKuWDfL4U88kzrcmt+uPjuupjPeESB0tzSbMajAeKivU1xzasIseR2zNBIdh+EU3eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZlvlUY+X7yPTL1dJ3MNzUflQlOCXvIOtjY6HOzTCK4=;
 b=Oy+qspmADqmvkVdFwB5wOQ4X9eb71N6jOrjtWENVt0y2xIEn05swE6HowkFtYB3+glAaKIfSLRPMAxjxjdVNqeK/5/GdzzbrXCJR03qxP46Brc7LIM+44MvvfF8TKa+A5/nNtOltkTKEGm8aPqtyjnGrZ2K+Ld/yQaco6+IjeT9r/3O1V6QtHce/K06G3JisW6wI2hecvv0ydoYauS8h1gFmcRsefviRxv8Lk7J3HS3eEWK5gxdtNimRXrqtYuvplW14m3120gqI0/X1jUgupgQOcYlrx/ASQZp48UrIku8sUNvtiws9ku1vHQgk88RPmpVKXPwxjT+LG6sQi4ooEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 10:44:16 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::35a6:148a:9c70:cfe6]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::35a6:148a:9c70:cfe6%6]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 10:44:16 +0000
From:   "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
CC:     Kalle Valo <kvalo@kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Triebitz, Shaul" <shaul.triebitz@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_mld_add_sta()
Thread-Topic: [PATCH] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_mld_add_sta()
Thread-Index: AQHZ8UAGpV4OYGX8XUOLDHDRXa2MybBcD5kAgAAAWBA=
Date:   Thu, 26 Oct 2023 10:44:16 +0000
Message-ID: <MW5PR11MB58102E1897D7437CD8E1DF27A3DDA@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <75e4ea09-db58-462f-bd4e-5ad4e5e5dcb5@moroto.mountain>
 <79f70bb6-ca33-48fc-ab33-6a6cd8ba2e1d@kadam.mountain>
In-Reply-To: <79f70bb6-ca33-48fc-ab33-6a6cd8ba2e1d@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|LV8PR11MB8582:EE_
x-ms-office365-filtering-correlation-id: 0c7383fc-53fe-4a4f-e9b3-08dbd610807d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuWgnqYbN6X2ffzc5YXe5zTgkwTLaFy7pyW6Xn21nqZmN4OZqiv6naz4mZ18bkwDz513Bw4eZj+JwXgYC4V2AcV38qu2glitS2Qmiw7AJx6dkOeqtanFd5LYjp2oKIMhCETI1Jofkp/i2qZd8mOo8kJNbQCwlOI+AT+IMj9sqHA5PmzFlVGVj9UaqvOIp61kiFm3RDVbPbjZfRRXSd3/IpaZmGcFYcJn7aLmWjtGQ/sZmFBkygm/9m68zcUeBPf4HMMSINrmZkUovKwO2n2WyrktkXsaD96m4o9kenpO/mhTQyWUVaiGswwquKqqA6d5+MAWfVEFuUA8iNCbWtLVSmgij4ku9qmxcZDwb7Te8xfIgOXsJ5Q0m9DoS+2nM4A28rSPNoKMNA8VcUN7JDr6MT7dOAkaffoK4SIR7At+nH0JTAKK7yULx8jLShCJ8Iigx5KDBplx7xPq8UOI/yyRahfiNjFyekX+iaoRIRIluQv5mHSBuDsyCtRcDp9qQ8zPL0ohWcT9rPsZ6h4lXHxjsyxWSIlDUTJn7pF+PxjBqMrCqXZRkt2FS6ecH7EpTD0uhImCPI3/l/HYsN0zTXA74tld1r0+UIntLSzdagn44AM8NAwCWTZgBUoUhZf4H0ti
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(26005)(38100700002)(5660300002)(2906002)(55016003)(41300700001)(86362001)(52536014)(316002)(8936002)(8676002)(33656002)(4326008)(64756008)(7696005)(478600001)(76116006)(6506007)(66446008)(71200400001)(122000001)(6636002)(66946007)(66476007)(110136005)(82960400001)(54906003)(66556008)(83380400001)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GrsxCxoWX+bbzlfwQA0ZRhaEpFTFSdjPGrUw3Xlt3F6eIQ4W1ZU77tHFSlz7?=
 =?us-ascii?Q?kBLoBmi60ehM4H6KChNaAvZThm9UmwHnKRg3mDtCh8yFb9WXyVfCcbChXAIs?=
 =?us-ascii?Q?AMdRgqu7Rkp0eHtWLuUxiW+Hip3e0UcS5Nx9FiwfFudSVzy5ryiNlcYvgXh+?=
 =?us-ascii?Q?RIcAR7hETjw4cXLSKRAmqbdw8W/lsmYkoRjZPp/GxXALf0PKgO+29uRBfuMQ?=
 =?us-ascii?Q?8FvA5xvIjtp6JKC4A48lojdrPOOrPNrMXV7MH0yZGEUzC40qmrpLYUKANkE3?=
 =?us-ascii?Q?T0WzHEmvXwlD/ZZXBOqQr8S73hZQ2XVUmjocpQU9nfE+3Tjj0QbiHkHXwLwZ?=
 =?us-ascii?Q?1VvjX4PDMY9H7KqE6/1B3LhvRiJgJHWdqY7gBHOiX2eQbCzC+Eq+RPRdGEGl?=
 =?us-ascii?Q?DHoiv+BR6a+kl+po6lfj5yiHjjx5IqHQVIX/IjVD+LN5txDs1q3pxnhgZgR5?=
 =?us-ascii?Q?uCq0UANO5a+7Tfowpxs6m4ZA9BiZqJnKh5l5oEJA4evUe9h7LebzuvOcH4L1?=
 =?us-ascii?Q?g/cQJF2xklLCBARzLvoaDtc35iAlUW656z6Ltrl3/DolMLKTQGRmZPiwPBEV?=
 =?us-ascii?Q?3oHs3Y1TVJGpfUZHYntudtMcHlIqZeNfmTOg6M8YxWKXb7+y1Voi6S2gsICK?=
 =?us-ascii?Q?txh9UrREJyBruiC3eBBv9JtD6YCEOcP4ZBCQl3hAnCgq76N3uKnFxbiXtSjs?=
 =?us-ascii?Q?xP/jLQlV2twW4i2/3SrYbMrVoZ4ONDkOMAZxRfFM18pAf7v+hLvE36XvvPXi?=
 =?us-ascii?Q?DoWtrXSCb6BaL2YxXKDTsIUzhqiqd2T1oafKpRyqoA8hnxDShRAu9gGXHd32?=
 =?us-ascii?Q?93ffdACTSVae04cYq348U5ycouqs+C8/mw0k1igVRNRGycl/B/T0j7pyzKUV?=
 =?us-ascii?Q?nDZo7QbEtbLHyCDBTmVFgFHdp7q+Ny2801Gr5OUqED3BNJtXcDLtY+EkNmK7?=
 =?us-ascii?Q?4xWm3gVlLPECFHONN7N1UtsSY8Yf6Qy2Kzb05PzuESeOARvQNdkd6nJxK1Yy?=
 =?us-ascii?Q?92VJKspEZ5O/WhRg0Q/DFJXDBQdAXZ6/k/4gvGZSmICyy4oLmS4yNgGi5myd?=
 =?us-ascii?Q?KzYmegpH679uwQDmpKUUYF5TgbufczBNLz/esT8ysrV448kVBDO9r11bCiGx?=
 =?us-ascii?Q?b+HYQAIhgYT9W3aspOY57ePNK3JDlv6yCf8oGK+U9gvs8Tzkf6X9+/83qlcH?=
 =?us-ascii?Q?LRBzaezp/HJmuZDggODHMKjir8o+VZCJoXWBYg/DdlI9S8hwWrjlpxe9VHps?=
 =?us-ascii?Q?+4VN08JISO1JYA8cGEd1NG/JCe/VpSfKH+PckiM5na+1+vCARe6IOW4fhB/d?=
 =?us-ascii?Q?fGJyyQSoZtftsQvB7YgnkMnGXyBtNAcW5rXwpNlsEXc9xEya914xNFmudoIE?=
 =?us-ascii?Q?rY+wWCbyD8lodtxQOl9c9pS1+IE5HGrExRtiK+r7J1LbyPKoozw91xR02kUv?=
 =?us-ascii?Q?mKBdsS0sSYbIxVJeYkJav7B8jbsqTjhVIcRaf4L1tMtLrXqLZ22Q0WgjWmEp?=
 =?us-ascii?Q?MtedXfoyA9GHsFB29Xdi2TZZ3vaZa7Es1TUHQAIJyoiwkTXwXg4T9xlI2zaP?=
 =?us-ascii?Q?cjQ5lW19uvFuRZ0+L+BmRSBI9McJMdEvVieI/6Y6eZBfEfo2uXHatMVh9w+U?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7383fc-53fe-4a4f-e9b3-08dbd610807d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 10:44:16.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBWW8muyvcLZaXMFWsZkaa8ZheAUeamsCka9qMjuxSIBzAIp31pzT7l9NQZY4htJES2oLM6TAKFOKGPIE37MRfXSGjXwY1itf/lPTEmjxwYiho25ngon3xwUE0a1VqI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Sorry for the delay,
I am fixing it.

Thanks,
Miri

Miri Korenblit | CCG | WCS | WCD
Office: +972 2 589-7724 | Cell Phone: +972 54 846 3803

-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org> =

Sent: Thursday, October 26, 2023 13:42
To: Greenman, Gregory <gregory.greenman@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>; Berg, Johannes <johannes.berg@intel.com>=
; Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; Triebitz, S=
haul <shaul.triebitz@intel.com>; linux-wireless@vger.kernel.org; kernel-jan=
itors@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_a=
dd_sta()

Ping?

regards,
dan carpenter

On Wed, Sep 27, 2023 at 03:40:41PM +0300, Dan Carpenter wrote:
> This error path should return -EINVAL instead of success.
> =

> Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_=
common()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I copy and pasted this approach from similar code in the same patch.
> =

>  drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/n=
et/wireless/intel/iwlwifi/mvm/mld-sta.c
> index 1464aad039e1..f2e952481ff8 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
> @@ -707,8 +707,10 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct =
ieee80211_vif *vif,
>  			rcu_dereference_protected(mvm_sta->link[link_id],
>  						  lockdep_is_held(&mvm->mutex));
>  =

> -		if (WARN_ON(!link_conf || !mvm_link_sta))
> +		if (WARN_ON(!link_conf || !mvm_link_sta)) {
> +			ret =3D -EINVAL;
>  			goto err;
> +		}
>  =

>  		ret =3D iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
>  					  mvm_link_sta);
> -- =

> 2.39.2
---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

