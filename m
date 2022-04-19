Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B351506461
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 08:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348764AbiDSG1H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 02:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348055AbiDSG1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 02:27:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525532126A
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650349465; x=1681885465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5tvMuT/kAeNvB1lQyLhjaYDGLiQqnNIA7nOunyNaY2w=;
  b=jTVPJWkY1q5+n4J4bNPHl96smw4KDfw2xE4pqItwh5ZW0uSunRDFiUuz
   SC5S0EU19BsuKEZiYOwDQVCsuhFrODb3PYRBT+otA56xrx4yZuE1ktI1e
   BX9HAqJx1v4buD7ek7Uvl2z9V50eboA7su5ZVPSFhxcTM0cHw5IAT10WS
   imuPXnp7O4U1UtdhEUmzuT0W75vHzXs9T9CZVrFKA0iDDloG0huK3iBRZ
   psW60LYivmmPzEvyPoJT2Is2KBbLKftF47W9lh5Xdiz6q+Jh7ow2nclsk
   70vrsc/yS39U9LmBdSq8i0SESIF7F5EpavqXrK6wfkYErX1dPjv6BH5oL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324131123"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="324131123"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 23:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="804559540"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2022 23:24:24 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 23:24:24 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 23:24:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 23:24:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 23:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpO2HPHZtdu+ZfY7CKLwdCt6/LxOsEvrR6v9dukgyVe9C8rjVvPXI6/RI4ZuYErw3ywpWGNuT4u07Tsfela9ZidkFai6XfXnmATHQyn+pKos5FQx6DvDEUVt92x6/KCpT9GNuLBrU0cLxgTEn4Bakp2ByZ44p5VYtGATzWUbKusMbBFGie3VZ1J2AZGmuU6rD6hnmrc52pbZ7f9GJV2jEO3ZyUvUccPxkOSYdH1nyPMuXgmduMuOyrwE998O2nZmV6do8hNb7OGtkTrwbltFZVDk3y1lvqqcmTcayb9qWNLf1c1i9byMBPsdqQ+OUR/KfY2aPTuZRHvlVUQdaC0AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tvMuT/kAeNvB1lQyLhjaYDGLiQqnNIA7nOunyNaY2w=;
 b=PzE/mEdawKFTcWszg3LdxWEVNCfU4UPIV2JUEoFfYRuJlwpYf6sv/3raFtQXrkHKKwiSZZPox8u5qs3pKdV1cMx04leLQLoPc/GFAexQ/DArsg0GA6MiRWetgnHYd1Bw3R/1IBzM4roz4dLgtb6l9wpSDD+G6mQPPCM9szs9TizkkWs0nhNEOCIrE5XfwhLwLnhL92R75YFDMIzeMVhyi6soAPGsFY53uUMaXsNn0EWd7eETizSgNKdKsxT9+L7a0Xk5mLyU6ykr42ed70wrL1yGOPZBm4OCth48whrDGQf5gjRPKAE6cwt6CNei9N9qzp+a1lUG2KNQlrCHMxTs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BL0PR11MB3330.namprd11.prod.outlook.com (2603:10b6:208:64::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 06:24:22 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::d47f:5a63:f3ab:a5c9]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::d47f:5a63:f3ab:a5c9%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 06:24:22 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSA
Date:   Tue, 19 Apr 2022 06:24:21 +0000
Message-ID: <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
In-Reply-To: <87czhe39p6.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.0-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 168e16ec-ee6d-4347-35bc-08da21cd3e1e
x-ms-traffictypediagnostic: BL0PR11MB3330:EE_
x-microsoft-antispam-prvs: <BL0PR11MB333021C93F6BBAB42A5FB64290F29@BL0PR11MB3330.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SuRvElCPIWEaNSrk0ERzefM7XY6LOTWkZkkTieFCcQz44/EhdHQhhG2Vhpr4Aad6JXGe2HOHQjN4XwJ63HHhgZfgRvLmTPgXUjHTyTwiheLVmEKDU5OF0juv49A9GTi9BryuqHb9YOBN5y2au3GRnGpyHOwmbkfEBnbYcmC7Pj7lFZPcCAtCWnBtJP7PRVwiaxC01QwDEqU3V4b/Ewph0KGlmB5SztiIgys06YagDYQbLv0Cgt9EZVeY7+X+JVSSo297+lzcOCfkD/GZZ2AzJ9hJHl53JSaNGEbPpS2aLQqlyhw4/c5OC/cwFkJLxK9LuT7WB/IquR2WjzgEHwvdGhRT7nLz6s+uCgMd/yRT+vfgPR5qTFaM+DevTQKVHlZ5vpQJASycGZ6HlIzs4FmsPJZpzUlxwta8arIeaPfTFNB/wcU+siop+2JA7g7C59EpR6FjdCbe65ZmKGQ9d1MaLwNXRda9hT8E00jFoUVggG0Iypu+B5I1qv/6yDXkZhas3u18GF7Uw06/bc/FF6ePdUYdtrgIYGUWv9uiQrwMELj70OKxmBB2qsCugFS7FqQwS1zEJ+EzkrbhipfoOPjc22l/g9E4qbAn/ncuhwyO4gh6ysfqOszai/GOnTr9Mo7lHiB6aeq5AHSXHLxmxWjegGZAe2SwUHYt4m3nWXUNFWM3QToTK3VWGdWMqReof/z7ZPecTs0S56VAwOfxX/F3KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(8676002)(508600001)(82960400001)(6512007)(38070700005)(186003)(66574015)(26005)(38100700002)(6636002)(36756003)(91956017)(107886003)(66946007)(66556008)(66476007)(64756008)(66446008)(76116006)(54906003)(4326008)(316002)(15650500001)(2906002)(83380400001)(8936002)(6486002)(86362001)(122000001)(6506007)(2616005)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXZETkNCejhGeGFhVHhEV2hvZTlmT0tWNnFySmFVSkFpMFJFLzh0SlhtWGM4?=
 =?utf-8?B?a1pHcWxVdmtDbXpCRklITTliQVBXaldxZGZjdHNwOHBGQm1wMmE2ak9YUXVX?=
 =?utf-8?B?ZWZvK2lKSVpjQlB3b3VqTWxlZEJ1dU1xRlJNVWlKRS9tV0QxNGlDM3pjd29l?=
 =?utf-8?B?MnpyUSs3VithY3FreGVRL1hKMkR5Z1BRVmtKTTFuOE42bkdIVjV0YkpURUtr?=
 =?utf-8?B?b0U0SFBPYi9xb3RyRDg5UFJMMDU2dEdsYXU0dmxEdUtINWpQaHA5ZFpmbGx1?=
 =?utf-8?B?bzRoVUxGaktvcnFXaXhDR2hxaWVab05RZk45ODJFUG11ZS9xNmlRTnFiM2cv?=
 =?utf-8?B?WVhVMnhLbVlub1MrSXJTYWNXcTVlWXVzaVUya214b3FLTklYKzQ5NkNXYlBI?=
 =?utf-8?B?aWdpUjVVOEVibHlmcmhVazNINXZic2tna0JzZVRHTC9WTW1ZU29TU0d3Zk1F?=
 =?utf-8?B?Rm1IQ2lFRDNjc3RzdldVMzE5amJMeDNta0FLcXREa2lBOWhGWWE0TVFyT2lF?=
 =?utf-8?B?RE90bkRCZHY1SWxTcmluUEN5OUU3U0VBdnl4ZFNEQ2lGZ0g2My9kSzVUQ3pW?=
 =?utf-8?B?SmU5ODhMaU5yTks4em5ZdUtKN3VVWkgzd21vR0YvOXFNajAvQWhhaUs3MjNo?=
 =?utf-8?B?Tmt1aGx2Q0dnQm1UbDE0cUExaHV4UEZTQkV5TmR0T0h3NGlJUVk4RkwxRlBZ?=
 =?utf-8?B?OUFrQUhRVjJyaE4zZjBad1E1R0lsV2tOTXRGaEY1cE9yNVNZS1Vyb2Rla1A3?=
 =?utf-8?B?SkRPV2Q4U1hCYkkrY3JxcUQ3Tk90SzV6eldaU2gvVW1zL0lKSTkzeHByem00?=
 =?utf-8?B?YkVtYWIzdXVTNEVBa3lPTk1jRmthNHgrazg3M2xSMDR3Mi9DWjQyOTRkOERx?=
 =?utf-8?B?NjFYcFNwdi9kLzhWWFpSL1NtMUJVNS9mZDZzTXZDQlBudDB0ajdGNlh4SjFk?=
 =?utf-8?B?S1FuK0g3Wi9NZUQ4ZjNZOFdRek84NzFNWS9EUzR2K1JBVmdPTVdFWEJYTUJZ?=
 =?utf-8?B?d3c0VFJERGRoeDB2elRZeWRLeW43OUk4V3FnWjBWazJqd3o2cmVsTTd0SjI1?=
 =?utf-8?B?WFlFaXB3SllhaTU0R0lBQktFWmRrME9YZEZzbnZGY1Q3T083Z2NhcUNDK0tW?=
 =?utf-8?B?SU9PS2dPWmNEa2NaSFV3SHNTZnlpZWluS0hpWFhjOWJicGQvbnAvR2hXYjJV?=
 =?utf-8?B?Q3cwQ1NuNHpCUkwyaXBES0QveDZwS05zMWphMHQvQzdFNlhzYlpNcjJvbzMy?=
 =?utf-8?B?SllpZjRHR2dzblp1UlJjVGxqK2h2UzdBYmQzM3loU2UwNzlDb0x2QVB0eTBI?=
 =?utf-8?B?YTVqNTk4bVFhQ0Y0TU1sUzMwc0FHY2dqTnJMaUdHdkRaQUp3UEVsbVhnVmVV?=
 =?utf-8?B?a1owMHNLUkg5emUySW1yVFUwY1UyemhGVzY1ZjVoc01BZmFoYVZtTHJIZzgx?=
 =?utf-8?B?QzlRSG12cHk2QzlXNURWLy9Ia0ZQVHpBcXg1MWQyR3NHd0MySUIrM2pZYTZs?=
 =?utf-8?B?dEFqUWtBMWRJM09IUU1heU9KMnRaaDRqM1lUUWpjRTFHZjBna3I2Y0FzUmhi?=
 =?utf-8?B?cHBneFVUcEx1cUVzSWtGNlZpUGt4azliUU83akI0WlF4a3J4dGl4ckdjbFNk?=
 =?utf-8?B?RHZ3R0tYdzExblJkdWgxT3VESWorSEpSY2J5bTl0Mi90WnFqRzV3dkxlQ0ZF?=
 =?utf-8?B?TURUNWIvcGUyS3pYbU90OU8yNVpNQm9NOWwxUnhjdVNEaVFFOWpCOXFZVlhI?=
 =?utf-8?B?MEJXSWpoTFNqSmE1TnNkY002ZjYrb2thYVZRR3hoVlgya3FqWVBDODdRMC92?=
 =?utf-8?B?MmY5RkhiaGRXMk1pa2EwRmJHcUg1enpNQjlmMG8veXdTTVVldkxWMlhpOXRD?=
 =?utf-8?B?ZThsdElvcXdsbjRZZG9sYmZibldBNmZ2MnlWUjZqbE5SRWoxaEt3M1NONFAx?=
 =?utf-8?B?aGNGQjRnOU5NamVueVgxNDNKSm9zVy8yRm9Ua0dQQjRNbEVRUUNhQy9LZjNN?=
 =?utf-8?B?dWRkVzRNRmlGWTdzZ2I4SjQzaTFCTUtZQXI1V0ExLysvSVVtbEt5MnJkK2I5?=
 =?utf-8?B?dnA0RVFucjhmYjN1U3ZxbFBiYlFOOFZhdEg3b0k0U29NRHRYMlBsK3IvODRw?=
 =?utf-8?B?ZmpKc2NidFVyS05Ib3plY29TNmV1MEZjZVljcmtIVjNSeU9ydXFZTWJIMHZ1?=
 =?utf-8?B?NFZzSWRUaWxEbHZFY0FpSXhuWUhnY1NCUVo0QTFDam15ZVkrYmVSU1FTc3ND?=
 =?utf-8?B?YURnYUkxSm0wSWVJN2xwZEE1MlZCdy9KQnFHVnpSVDVlMXJqSG1WMjdKdjEx?=
 =?utf-8?B?WndnSSs0bHJ6dFczMVI3QW5kRWYxbHgxTzlvMUtjbGU3MytLb1IxSUNoZ0xs?=
 =?utf-8?Q?4m60Pj8piAGmMjsg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <832262B4E5F4AE4BB82662F20B3D379A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168e16ec-ee6d-4347-35bc-08da21cd3e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 06:24:21.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMczzEapMRYhAFD/1ejK3Wck7hY545hyvPpHu/GiAl2D+TBJxpbFZm7Oi64nJki+4sZzl/vntKjM6iqFfbzF6tJNWbB5BDNrKBk4aEgGszA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3330
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTE4IGF0IDEzOjM2ICswMjAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+IEhpIEx1Y2ENCg0KSGkgVG9rZSwNCg0KPiBJJ3ZlIHN0YXJ0ZWQgc2VlaW5n
IGlzc3VlcyB3aXRoIG15IGl3bHdpZmkgaW50ZXJmYWNlIGdvaW5nIGF3YXkgYWZ0ZXINCj4gc3Vz
cGVuZC4gSSBnZXQgZXJyb3JzIGxpa2UgdGhlc2UgaW4gZG1lc2c6DQo+IA0KPiBbMTA0MzkzLjE0
MjI2NF0gd2xhbjA6IGRlYXV0aGVudGljYXRpbmcgZnJvbSA0Yzo2MDpkZTplYTpiODo1OCBieSBs
b2NhbCBjaG9pY2UgKFJlYXNvbjogMz1ERUFVVEhfTEVBVklORykNCj4gWzEwNDM5My4zNDc3NzVd
IGl3bG1laSAwMDAwOjAwOjE2LjAtMTMyODA5MDQtNzc5Mi00ZmNiLWExYWEtNWU3MGNiYjFlODY1
OiBDb3VsZG4ndCBnZXQgQUNLIGZyb20gQ1NNRSBvbiBIT1NUX0dPRVNfRE9XTiBtZXNzYWdlDQo+
IFsxMDQzOTMuMzQ3ODc2XSBpd2xtZWkgMDAwMDowMDoxNi4wLTEzMjgwOTA0LTc3OTItNGZjYi1h
MWFhLTVlNzBjYmIxZTg2NTogZmFpbGVkIHRvIHNlbmQgdGhlIFNBUF9NRV9NU0dfQ0hFQ0tfU0hB
UkVEX0FSRUEgbWVzc2FnZSAtMTkNCj4gDQo+IEFuZCB3aGVuIHRoZSBob3N0IGNvbWVzIGJhY2sg
dXAsIHRoZXJlIGlzIG5vIGNvbm5lY3Rpdml0eS4gUmVzdGFydGluZw0KPiBpd2QgZml4ZXMgdGhl
IHByb2JsZW0uDQo+IA0KPiBUaGlzIGlzIG9uIGEgNS4xNy4zIGtlcm5lbCAoQXJjaCBMaW51eCBk
aXN0cmlidXRpb24ga2VybmVsKSwgYW5kIGxzcGNpDQo+IHNheXMgdGhlIFdpRmkgZGV2aWNlIGlz
IGFuICJJbnRlbCBDb3Jwb3JhdGlvbiBXaS1GaSA2IEFYMjAxIi4NCj4gDQo+IEFueSBpZGVhcz8g
OikNCg0KVGhpcyBzZWVtcyB0byBiZSByZWxhdGVkIHRvIGl3bG1laSwgc28gSSBhZGRlZCBFbW1h
bnVlbCB0byB0aGUgdGhyZWFkLg0KDQpBZGRpdGlvbmFsbHksIEknbSBub3Qgd29ya2luZyB3aXRo
IEludGVsJ3MgV2lGaSBhbnkgbW9yZSwgc28gSSBhbHNvDQpDQ2VkIEdyZWdvcnksIHdobyBpcyB0
aGUgbmV3IGl3bHdpZmkgbWFpbnRhaW5lci4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
