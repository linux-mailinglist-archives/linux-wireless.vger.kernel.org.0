Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86794537065
	for <lists+linux-wireless@lfdr.de>; Sun, 29 May 2022 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiE2Ixe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 May 2022 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiE2Ixc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 May 2022 04:53:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439C47AF1
        for <linux-wireless@vger.kernel.org>; Sun, 29 May 2022 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653814411; x=1685350411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G27LoM74ufVxTJT2w8I6VMt0YNrbj6QBhRF6VVkJseA=;
  b=OoKpRy5pAU5us2RWhzKUZm8nHYRrIUIKcWbwYE9o+f+0RoaXxamVWbKj
   kK/xCk8gbqdRDbtc2MeRgkRg7d69osnNQD4olzgFgLYVHgqZnPfYGj4hQ
   yHGugRja1RwMZArlHB92i7KH3Mv1qMVdRYKH1R1CynUgS5Hs/QogtiAdk
   8hEyEeoOFgE26QnTfWUv4OPd+UwHM7TpmuxA10UfgdKdiBi1524iI4IGG
   z80MnijR0MgspaBV2wVb1qEr0Xe9gC7R1dUYGZi2UH7bw7SFDSDa8OSct
   OIWZot6HRmBCZrrpJJ9rdPqDE478U8TZIqp87k+9dJxzgC1UgJqaqf9uV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="273585109"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="273585109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 01:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="666075540"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2022 01:53:31 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 01:53:31 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 01:53:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 29 May 2022 01:53:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 29 May 2022 01:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjJSjJOHeNof7uWiYggNSJowWrlrxA6AXe9aaP6ztj6OylZApgCe2/Fsbv/jsUODQIDwf6or+H53Kpb+iR0XPCj1u5JNRy+KX/nPp5FdGJdocGz7YcCEy3eboxw4H9+ehU02XrtNUuOm/pUKZVqYA0VUnmWFpoEIxk4tLTcKebF7dMp8YS/fUvwtJviK5D4pShFQjDSursRvNGSlVUKqCafnqdiE8rGobh168BKO/m/w19F80LviLTQlJM7HiBors+z6U/q6RIu43nFBSUPu1/mDKWOfQgj+igRXRzjIbFkZLk8imeZho/c6928uK1VqEf7gMOxMVuYPSoXjAE9Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G27LoM74ufVxTJT2w8I6VMt0YNrbj6QBhRF6VVkJseA=;
 b=X3xOPANXqw+xUaJMbBFZZxDngNeVcqLUPD1S3pdj8N2BlxOMCVqER/kmCQ1BWyCSJKlSCmvflDdvE/ob16LZKweQdFGeriBpwo/2NuW7YEnK8tlPizMfRrfTn7z6d2Zlcy5EoJDY6j12pblkfpP2QNFiOhqmGqjJ9QQtjP2M6Zoo48an9Tn2AX0da4nnYCaShzgc1i41DjPkoo4qdF4/A4DZymGaWEgKZD2TFdliT4Kz49fLXuBCjqlNGf6bFpvoIYv7My6x2morLP0LCUPqVTiMivqA6BFVh6SOpqxWlWTM01OOpVfYQTvM9WDeVJlv6z2yxOYeuhz/jYkTyJ35mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CY5PR11MB6510.namprd11.prod.outlook.com (2603:10b6:930:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Sun, 29 May
 2022 08:53:29 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::e5b2:f15a:9bbd:1ca7]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::e5b2:f15a:9bbd:1ca7%6]) with mapi id 15.20.5293.017; Sun, 29 May 2022
 08:53:28 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH] iwlwifi: pcie: rename CAUSE macro
Thread-Topic: [PATCH] iwlwifi: pcie: rename CAUSE macro
Thread-Index: AQHYbuAoDtmmToajPUuvEzlRW3Nkmq01jriAgAAGpgA=
Date:   Sun, 29 May 2022 08:53:28 +0000
Message-ID: <494aafda0d4cdd8540de7e97e962597513dbb70b.camel@intel.com>
References: <20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid>
         <165381296442.13565.7947896885459495012.kvalo@kernel.org>
In-Reply-To: <165381296442.13565.7947896885459495012.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01bc40d9-9a9f-410d-aaf5-08da4150b328
x-ms-traffictypediagnostic: CY5PR11MB6510:EE_
x-microsoft-antispam-prvs: <CY5PR11MB6510421B9C8B3CD0347C2C8D8BDA9@CY5PR11MB6510.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Wc3V8eGAKLPcaQMNbaay3AkmowS55J2Y3C70rEOQS2QMhWworCOl6PygrSwQGwZM5Nnu4SEaLcrh9Gf4LXB28CMn+3R5FuxVFxEsal7kVzN//dY0LV5Eg4+mMvYs7LLIWWzT+qBx/D6PDV8uZ8cMwOZZSmxh2tBgW9vFnbOdFzESQiMrbzhHXa+L9crbpkEsiewI2qS7gxPSV4oDdwXTS7xyilzR1EEdmbyy4zbD6Iz1ihyemfYZIkcNq34lx1HjAtbrbXLxzqcV8tG6tK51TBxfFGG4b4xEHsl+ysXpMcrmGa3CCSdJ/N+Sg07BZzpwAEsKuzxnJpsIo5EC8kyaaT3bLUT76uUomC33k9ZV0eIEXV4pKC8BfL/6GJwUxUEWDsLh80zA9UZ1z9frkOqZT+GazvJoKUblfBaiB7ntlqfhjui/uynYu/K5hU3caomV8hPAoVErpYVVQbOa4Xt3ly3yHwfKG8PzDHTAXqSTxC+7dsl8xCh1H5QIVK9SIIgLvf8sBsclABzZWECcRgsZwJXTPmFzPx8DkCpC377ssFbM0hWwQ0Fo9vQh6l/U/CKNrQpAQSNfGZ/LqMVb7tPfTC8G+OP6wXmFgdqO2VszzKHpZd0x0c+VvCGY7f5NHJB7Sp5/lKx7s10dvv6kf2FZYuKS2gJvfUpi0wRxX0lk+Fpudg3lB4H4w0yAcjtLpkDvWrKT4MgkwxN9R/FXx10Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(54906003)(110136005)(38070700005)(508600001)(66446008)(2906002)(6506007)(122000001)(38100700002)(82960400001)(6512007)(86362001)(5660300002)(26005)(316002)(4744005)(71200400001)(6486002)(36756003)(76116006)(66946007)(83380400001)(64756008)(2616005)(91956017)(186003)(66556008)(4326008)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1JzN28zRmRYSDdmTDN1OThZUWlRRGcyUHJyN1B4RXYxd1RraUtSbEdPZ2VP?=
 =?utf-8?B?c2UyWWlyY2FUdjlXQS9vclNYS09ZVHJtQ0F3cjNuR3VIeWplWTlFWjBFeDYy?=
 =?utf-8?B?YnFoZjFHT2pZY2lUdVlyT1NQU3Q0a0htRzdUdnM3R2x4KzFZRXo3dHY1QUtu?=
 =?utf-8?B?dTdJcCtGeEtsdU1TcE5WcTJDZ0JjQ0wwcnhpVlM2YTMyQUE4NUFGVnhXN0dK?=
 =?utf-8?B?LytWYlluclllbkh0OU43d28wQU1qT0FsSE1qVGlDb3J0cG1IVTZ6QWdKdmVt?=
 =?utf-8?B?dEo0bThxMkQ4cDZmaS9PSFJ5MDNTQ0duV0pHVE9QSExEMnFaRFBVOEN4aVNN?=
 =?utf-8?B?SzNEeDJ4SXZaZEtkYXBadFdTeUJRR2lYaGl2L21LSzIxOGJUbjZpK3ZRL0FB?=
 =?utf-8?B?NVhKYnRRSlN1djZuZ1FyRTRXMktzWHFBcWY4RlUvbTdUOFUyVVZMajhXT2V6?=
 =?utf-8?B?cWl2NmlBcTF6bHhyM3FCQmh3TGF4V29yOWNsNkZtT0pLVmhyZzVIZWtYc29I?=
 =?utf-8?B?L214d0tXOTRUM0JNTlBOSWx3QmJ0UkJzMXB6R0hLVFkxcWowV2t6ZURTdkFp?=
 =?utf-8?B?NnFHTHNQbUpCVHoxc0RuMjZDd0VHLzZEbm80UWptUVlDK2ZYdjk4YWF4eXpG?=
 =?utf-8?B?emg3aXZlNlVjTjdmMTU5clJmbVpRWHo1ZVRlaDd1Tlp6OTNhTlVlUWpIN2dL?=
 =?utf-8?B?MWpIZTVWQ0c4UlUvbXc4QWNabFdUZXYyUmJPazlSbXBLRXBHMmN2WmNUbDZV?=
 =?utf-8?B?REVkbHpnOUk4WmhQUHg3bnMyZHhiOUkybnQ5L0RDc0pmSkx2RTFRVUhURFRa?=
 =?utf-8?B?TTkxVW5MelZsS2U2d1J5M3ZIcENkNWFxc0hrRlZVZ0xYSllPZFQ5SXFGZ0Ur?=
 =?utf-8?B?eGtENDY0Vm1MUFh4dm4vMEYwek1KSFZPU1JRaDdMODdvVjVuQ2I1WHVKa1dI?=
 =?utf-8?B?bWZacHFnMVNhY1dFTlJRcmFxcDJsYzhaeTJDdWJDRWtYQkkzVmlsMEh4QmRx?=
 =?utf-8?B?cVpkNmpxNWlRY3NlMzY0cEZ2RWdxQ0NQTUsvSEdFTVZvQWxRMGpyalB1YzFS?=
 =?utf-8?B?WHdUekR3VldTbXZxb1RZRFNqcSs2V0wwMWNldEVWMG9QdnU1emtzY1lyL0tD?=
 =?utf-8?B?MzQ5WGZwRWxiOVBlM2VOWHdiOWNERHc4NXF0MzgzT2xsVEtLVmk3NmJKam1O?=
 =?utf-8?B?MytNNHY2Y0ZSUWV3Q1RoSWZFSUxWSDhBcm85aG1RS3ZsS1dtQjh3aGRMenpL?=
 =?utf-8?B?bHlIMk9SVG9IYlA4eXhweE5NSzlsbytORVYzWENlUUVwL3pYQS9XOERld1gw?=
 =?utf-8?B?Q2pXUEF1SVNjN1JsdE1hZnNCWExkZ1pWNyt1d05PZ0VpTm9VK2swMko1YkNI?=
 =?utf-8?B?aFFPcXJtU3pHazBjMHdPMm0wd04yQ0FURmNhbDBPVXJIbVRXT0hmT01HMHlX?=
 =?utf-8?B?a3FYWWxwVEJ6aVJ2YmluellrY3Y2OHBoWjRnZUxOcDIzMkR4WG1tWmcxQWlw?=
 =?utf-8?B?VHFhZGhqZVFRL2FXMXQzR1RlK2IwcGxVdWIvM3RCbW01R2NlS3BOYXNOTHh4?=
 =?utf-8?B?YnNpNW1qTnY1dUtmZ2hLZ0h3RVVhSmMvU1l0bUZFTGQ0anJLUUFXV29LeXl5?=
 =?utf-8?B?Vml3b2E2djh6T2RiUHR1WDE1SlhiTTZxdnhtQmhHNGx4MytycWpFa3JqSjMr?=
 =?utf-8?B?eDYrbHNEWWs2Uk9nWFJxbStPTTUyVEkrc0YydndVeEI1TmI2d2RMdVRTQlVF?=
 =?utf-8?B?WUlsRVAxSjEzUWFTMnltTXRCTnRuWlYrdXErWTY5bkhwajVWSkpBckVsMDhr?=
 =?utf-8?B?NjBCb1Vxa2ZYb0lKOCt2b1laNU90VWVScXAvTlhKeUpKSTRtTVhEL2lwSU9J?=
 =?utf-8?B?alRpejVXdE83TFZHanpKTCtGcUViL1hwaGVKT294ZEpMK0VUK0d1Q0Y4VGJ4?=
 =?utf-8?B?Z1F3TTNrSjhBeWxCRnJnT1pLQk9ZT0tLSys2cllNWktGOHBWVVUvSUlITGdP?=
 =?utf-8?B?MThhcVE2ZGZVbitjVlFDU3VXdUlGK2RqNmRodlJOMTFBcXlsWGY1SzFDZXU4?=
 =?utf-8?B?TzRzL0taTE4zRzd3bkpXYmdpTFVoVnVmMFBmNk52V0dOeXFrL2JaRnhndHlm?=
 =?utf-8?B?bkhhMXB1aUtFRVhtNGJaanV6SExic1JNV0hlZ3E0aVFJNHVRbFZoV3NTU3Jz?=
 =?utf-8?B?QlN6eWhWd1FFdDMwazJXbVRSaU43dGNWd1lYMXBBZDVhMDZITUwrQkJ6ZjN5?=
 =?utf-8?B?N2UzQ3daY1g3a0NhbkNZT1RMMkVWQlZiNHpiNSt3SjA5RFplbkNGUGpJeWVY?=
 =?utf-8?B?Q1ZUZk4xdktJNEdQQTZpb0xtVWlSbUJrTDd3bVdMc0JScnhyVU42Ulo0bjB2?=
 =?utf-8?Q?uNNOt9II+Hrt4EUQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <778E0F490BE35B4AB6CAAE6BC53009C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bc40d9-9a9f-410d-aaf5-08da4150b328
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 08:53:28.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rJkUA9ODd8te4+BVxMZsdznHncLC8dT0B2hisPixrhGtHCqVM5WFaX0wFA16URjaow+EPRABTZ9gOjvg4aVeTEEqan8bM5JYex2nAwxheE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIyLTA1LTI5IGF0IDA4OjI5ICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBK
b2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiB3cm90ZToNCj4gDQo+ID4g
RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+DQo+ID4gDQo+ID4g
QXQgbGVhc3QgbWlwczY0IGhhcyBpc3Qgb3duIENBVVNFIG1hY3JvLCBzbyByZW5hbWUgb3VycyB0
bw0KPiA+IElXTF9DQVVTRSB0byBmaXggYnVpbGQgaXNzdWVzLg0KPiA+IA0KPiA+IFJlcG9ydGVk
LWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiA+IEZpeGVzOiBjMTkxODE5
NjQyN2IgKCJpd2x3aWZpOiBwY2llOiBzaW1wbGlmeSBNU0ktWCBjYXVzZSBtYXBwaW5nIikNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4N
Cj4gDQo+IEFzIHRoaXMgZml4ZXMgYSBidWlsZCBmYWlsdXJlIEkgd291bGQgbGlrZSB0byB0YWtl
IHRoaXMgZGlyZWN0bHkgdG8NCj4gd2lyZWxlc3MtZHJpdmVycy4gR3JlZ29yeSwgYWNrPw0KPiAN
Cg0KQWNrZWQtYnk6IEdyZWdvcnkgR3JlZW5tYW4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29t
Pg0KDQpZZXMsIHN1cmUuDQoNClRoYW5rcywNCkdyZWdvcnkNCg==
