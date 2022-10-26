Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4860DF18
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJZK5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJZK5K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 06:57:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6A8262A
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666781829; x=1698317829;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=LrqXlGU9JEXUUBDeH3on00QsKDB3v7rSR5XJLE9GV9o=;
  b=nlQ0k7iB9B743i8r6fAVDXDN0PuNuCyzK94fEVE1jPwCtf5hDCK0IzvQ
   6gSEXvkFdDu+D3KvlGlrIDGaMuiL4PpIy9+H0HVKma4lk8uyrz+BjkgQy
   +iwU/tU8fqr5ETMarrLW7i691H7gjZuTzHZtHKBJJS+3ChrmrUtm3q6xe
   xfsWHd/Ps78Infz3HceyiByPejEuPoAYfBAfv8DDWhCBGJ5LjQRElcW24
   KyEO3qUKnr3qGaGYGaaRAn/AC3+s2Zjg0OFLLdQ6EwDGX3IDdZwE3Zg4V
   Q9tWV7Yd3qOf7hm6u52CroPjCxLxdDbIBi5F9fBuESHVRuYJRPnJZaiLi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="394228148"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="394228148"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 03:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="757262535"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="757262535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2022 03:57:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 03:57:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 03:57:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 03:57:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 03:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPaIjN5wEwyyPmfxmF/rmls2AxMcUewadi8p4tl1ECV/35lDyDfNYYjSXkhOFiTMGc4SH/LA+bV+DCJx+NuNpu1yaJgQdyq5weY7ego0BNQVeKSXl7Cg1/95m+XjZmKi7r/SBSF0VE94rGUXazZoXoV2SpHflJClfdwGRIWzgHORLPYVGgwWLb76EUG+cF0EsA6X3iUsEboqtvTNYySiPxAwinFvqMafut2qhrUP4esb210vNZ/eMQ7XCkwAx1HLzayDRXTJtqu0iOvBKrCfnoYM56ElHNh+Dxhc/9nO0M//mKYb62rcOd22cLbvZO21fD0jepLSD+h3WzJjKoR17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrqXlGU9JEXUUBDeH3on00QsKDB3v7rSR5XJLE9GV9o=;
 b=n33OUU8lHSQV27ZXU5VCyXs5ZP222OGD+P/pjyaCpONAirDwS40XoSw9+dWZ91vkgPAq3mzFZy/4d8ZI4ftSjssWWk6Qi0g5ufUeP6dPRiUNiKTH+7hx/4F5GfGecmHakXdsieeAZWsnTtAGVevFil0tu0dLvf8kPz7xUmO4Xatyov+C2EY3ZPX18lHJIvWJ9bt+Sir6v5T5qHRGsukTDNEjIi7x6OMyK8TTPHcJBv/LOpCXF4cAr50wrkwWiHXAXrHVTM5EE8N93FhNSSlOsZyJ2aa6Nkj2Pe54yOaZg6LIJSgmYbRycCAZB4ah7/R/n4xQXfg96pFOPagVtU84kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by LV2PR11MB5973.namprd11.prod.outlook.com (2603:10b6:408:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 10:57:02 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::7b2d:e80f:f002:11be]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::7b2d:e80f:f002:11be%3]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 10:57:02 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2022-10-26
Thread-Topic: pull request: iwlwifi firmware updates 2022-10-26
Thread-Index: AQHY6SmtMR94cS+SFEO2H1DFcfOOsg==
Date:   Wed, 26 Oct 2022 10:57:02 +0000
Message-ID: <2a263d2d6c82b482dfb5933d1be990aed918b7b1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|LV2PR11MB5973:EE_
x-ms-office365-filtering-correlation-id: e3dc0cb7-f742-4ef2-68a5-08dab740d067
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/chm08lT5qJrJYGBxjtpw0Qhr7UFrgZxyuRxHMp4gaM4aj1Hp5YMwTru9bPj4l8KwFIpCjF1N2Aur8MSRTdqJp4AzkUqLF59Lebh1zF+sv22kVaft+UB0aNX9MWQmPV4tq9TNEObs65o7JgK7QcQhUb5RN2gt8AKAPNIhYYr5bZGGU2+D6phobd3sdT3KDH11cD0vXCGN0KqSgm0jxvjrlRFnRu2IggWo7BPy+h1JFx3HoenjvOtni8rpOMItw6FMgceOhYDjIEGvF616aDVAcQgKcZm02VVuHwD8ueMMJ/+2vuEttMn5UiNfGIXrbXRDtCYby+5rMi+o2xuMnGhdy0oSOOAX7SiT8qtCrdu9Zex0Nl/OMMYhU2rI1UyXf10Q1a7DkyVs0e35t7cVM4RoDuAMxFtdTR5fQZ/LSjh7qxG/mJ/kM8N9ss8QsgPiIEREe+8GJrkiJ3gUTL8WWWAXE6hnmPML4vnGxeFGRSSGa4B/FaAGrZKqva6dvxvvvBHrK+LYaIOFyyZoZpasHRgNcy7XR4ukaSjgVorgxUgwuAuT+Xppp7FPUYTsTV+7rupEV+8U0Cxd00SU5u9uCTtmf4LhPQjuImf1mvcjAXDlydQ4rwfjbVtA7P0hLa53/5xlKUduvl1eu7NBMik2Ow1o+IhMVEoWAUp1dlAuIxkh+o4tifQPwnsUTzYYfWJSkyd2ejZbnIz+UOUiuTtcTWgZlwbHo4R+0hSZCYi5WZQ8qJBxcnPNLztrhDEcbotZsRH8kPlKJbQw9zm/cerzgEWpJHtYFnletH0wLy+2Ns2pZBMFFZA57vK6gRLG4Lo1NnHoZF/FTtL4i33H3Lc5KbFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(38100700002)(122000001)(4001150100001)(19627235002)(36756003)(82960400001)(38070700005)(86362001)(6916009)(316002)(54906003)(478600001)(966005)(66476007)(8936002)(6486002)(5660300002)(41300700001)(15650500001)(71200400001)(26005)(8676002)(91956017)(2906002)(66446008)(4326008)(66946007)(66556008)(64756008)(76116006)(83380400001)(6506007)(6512007)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THFXUllNUnk1UFN0VXk4dXpPSXhpcEJmQzFpZ1R0eFpNVi9PdWxvc3laUmFY?=
 =?utf-8?B?dnQ0LzU4VjduaElNRE9pdGkvdWcwTUkrTlFEb0FzWExhdEx2ZWxIWDI1SVhr?=
 =?utf-8?B?cnkzYkJWYThqWm5UdExOR1kzakxBaFNRQm4xcm1DUCtNZTJoeDZTbTVoeG5W?=
 =?utf-8?B?TUJDTGVDaTdqdnB4TkJMamZhdXRHTUtWR1JUalo5MWtDMHZTRlh0QUNpZnh1?=
 =?utf-8?B?VktxZk1KcElOMzRLUGErZHBtTmNsZjJUdHNpTkxOSlB2QTFtZ2hGU0lMdVk3?=
 =?utf-8?B?N3VERUhjSDQ1bEUyQS9ETjB6NkpjN1JyeE9iemRFK2xmNXcxWnliZE9mNElv?=
 =?utf-8?B?TjdodzZPRlMxbUpkUDk2RmJaYzM1YVlSdjJrc3VRUlJpNEpEUGNMNXRXbEpU?=
 =?utf-8?B?ZmZJbG0rZHhhUGJIdDc0UmVyM3ZVa21TWDVFOXIwUXlZOUV2VkFkMzJwYnlP?=
 =?utf-8?B?N0N4bHRSZVU2VGRmMXNZOGpWRGp1SFNNd1hUMklLMVVZaDBhUFJiK3U0OXJv?=
 =?utf-8?B?YjY3NTY4eXp3WklkS3VUQm41QjVXL3cxTGw0SWdhcTdBYWxEVURNTlNML3V1?=
 =?utf-8?B?dnJUNzlOMS9HamxwOE1LczYzVEtqNVduRDlzSWw2VHJRczFwR2g5cmtlYmdE?=
 =?utf-8?B?elIzY0pzOTZnR05RcW5QbjVhVkZWOGNTWDN5SGZVdzh1MHU2aUxnSmx6RnBM?=
 =?utf-8?B?Q0xiUEdPOWd4aWRjb0xZTzJGRkpZZHUvQVhPeXJ5U3RHOVVNZ1h6Vyt2ZEVL?=
 =?utf-8?B?OFJqTk4xSlhIN09JZWs3SmZrM2hEMGgydVRtMTN0di9hNjZFYVhmWjRoWGVS?=
 =?utf-8?B?VkVXeGRPalBFZmcwWGpsaVpybURBTlc5ZlpnYi8rRzFRZzF3MjYzanZJL3pK?=
 =?utf-8?B?bFR3ZjF5TEMvK2NsZTJ6aWZtMEgxSWZhK1Rub214OG1nM2tMeS9BN2JVQ3ZN?=
 =?utf-8?B?YUZrY2drbTBYcmF2V3N4cGVQMyt1Yk9yUC9GSWpBcDdBeVJvNFFvblBwSFRE?=
 =?utf-8?B?U3FYaDhXV0h3QTE2aTk5L3M5KzdQdGtOTExlQm84U0NleFR1Si8vN204Qmcv?=
 =?utf-8?B?SXcyVDk5VFZXWnN2d01jTUZQa3lWTUdHWTlZT2lZaXVGaTZ0NnZmdmFpR3lY?=
 =?utf-8?B?Z2d6M3lucUtxU1Jvck13L3NpM1EvNzk5RFdsZjRGR3JqejdXbkp6WDZ6NE1O?=
 =?utf-8?B?RWhCdXFtYlpnME1FM1NtWDhtc0IxbWxSK05uT0MzY1FVY0J3MFA4VFJBb2Fr?=
 =?utf-8?B?Lzk4UUlyampyMzVsR3RnTHNSNkRoOCt1Z2lyTUNGNXpvSnE1UkIzcG5ObUJU?=
 =?utf-8?B?UjRZZ01ZL0dwU1RYWjRlMW5VOFdUc2tJb1NuTlJYcmxyYVNNMTZta1YvaWpI?=
 =?utf-8?B?NERXQTcraXNzbGJTL1lhWTR1OVBQM0hCWjhNT29lQU9PUW5MMG0vVWhjZytL?=
 =?utf-8?B?NzVDS3pBN0p6QXNuekdYMTUxaEtPRkcxOEo4U2Z4bGVNVUR1RUIvak9rMXRX?=
 =?utf-8?B?eFVhVzcyZXl3YkRhak1yZGs1cDE0UHd1SUxpSUNKYWVXSmp4VGlUcG9mcWVo?=
 =?utf-8?B?UDVIemRIQ2FkVmR1U1Z6YThCdVR2cW9hZkFHcFA4OUlDME1ERmZ5TXo5aUwy?=
 =?utf-8?B?M0Zvc3BZekF6RC9xU3lzc2k5N2VxNDA5eEw0UTFmMDQ0YzRHNXBUTENxM0dH?=
 =?utf-8?B?cmQxQS8zcGM1WEdtK2p2aWFQeklIc1RHaWh3RlZ6LzhGMjhhQTVNLzFtYmwx?=
 =?utf-8?B?T0xrNkp4S0Q5MEpqaE9iRXhaSkRKQndsNThoL1FteUduNGZrdXlTNm5rdE1l?=
 =?utf-8?B?dnYyVGRBVHRnbitOd2xxaWFtOWtQOW1jQ0czRlBaT0QzalhUZEo0N0srMVJt?=
 =?utf-8?B?M2svZEhnQVVNR09LTU1VVm9qQlJDOEVRZEJVejJtOWxmMHRSWkttZGx6Vjly?=
 =?utf-8?B?OE1ReHJlYTVMNUlqNTBFcElLdEQ4VFhjV01zN2FiWGQyenFtaTVnZ3dSRk9C?=
 =?utf-8?B?blczaEczREVwNXZHMGg0MG9xdEZFc3JHZ1V4ZnNsVWRnZDlBYkhWbWJlM0dM?=
 =?utf-8?B?a3hnWGxmeksvVDZnWnRWZWsyMCtMTy9LM29lcGJCUGZEWVBDcnBDZGdXcnB0?=
 =?utf-8?B?KzRPMXdiMWRoK2Nyb2VtY3ZIL1NURnVvcFEvR1NDWjNBOEtlY2NCVC9qdHJr?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <514F3FD122F1FD4BB78E083837FAA27C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dc0cb7-f742-4ef2-68a5-08dab740d067
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 10:57:02.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elq+W1VLu/BOl8RWLdgB+zIH23nU5cQJoXcM0+2wjEpVYWspShX3fBQ3/LW7BI/oSynqUZbDPp2CtkHZ2n0Ne+8VcAC8X8ll8zrLP1T/U0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoZSBmb2xsb3dpbmcgY29udGFpbnMgc29tZSB1cGRhdGVkIGZpcm1hcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseQ0KbWFpbnRhaW5lZCBGVyBiaW5hcmllcyBhcyB3ZWxsIGFzIHVwZGF0
ZWQgUE5WTSBmaWxlcy4NCg0KUGxlYXNlIHB1bGwgb3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJl
IGFueSBpc3N1ZXMuDQoNCi0tDQpUaGFua3MsDQpHcmVnb3J5DQoNClRoZSBmb2xsb3dpbmcgY2hh
bmdlcyBzaW5jZSBjb21taXQgMGNhYzgyZDM2YWY5ZjliMWQzZTUzMmRjY2YwYzY5MDQwOGNjYjQ1
NDoNCg0KICBNZXJnZSBicmFuY2ggJ2Zvci11cHN0cmVhbScgb2YgaHR0cHM6Ly9naXRodWIuY29t
L0NpcnJ1c0xvZ2ljL2xpbnV4LWZpcm13YXJlICgyMDIyLTEwLTI0IDEyOjA3OjU2IC0wNDAwKQ0K
DQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdh
cmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDIyLTEwLTI2DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hh
bmdlcyB1cCB0byAyMGQ5NTE2ZGU0Y2RjMDQxZTJhYTgzMDA5ZTViMDQ2NGIxYzNlZDgxOg0KDQog
IGl3bHdpZmk6IGFkZCBuZXcgUE5WTSBiaW5hcmllcyBmcm9tIGNvcmU3NC00NCByZWxlYXNlICgy
MDIyLTEwLTI2IDEzOjExOjQ5ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3aWZpOiBhZGQgY29yZTY5
IEZXIGFuZCB1cGRhdGUgUE5WTSBiaW5hcmllcyBmcm9tIGNvcmU3NA0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpHcmVn
b3J5IEdyZWVubWFuICgyKToNCiAgICAgIGl3bHdpZmk6IGFkZCBuZXcgRldzIGZyb20gY29yZTY5
LTgxIHJlbGVhc2UNCiAgICAgIGl3bHdpZmk6IGFkZCBuZXcgUE5WTSBiaW5hcmllcyBmcm9tIGNv
cmU3NC00NCByZWxlYXNlDQoNCiBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBpd2x3aWZpLVF1LWIwLWhyLWIw
LTcyLnVjb2RlICB8IEJpbiAwIC0+IDEzNzAyMzYgYnl0ZXMNCiBpd2x3aWZpLVF1LWIwLWpmLWIw
LTcyLnVjb2RlICB8IEJpbiAwIC0+IDEyODU5NjggYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWhyLWIw
LTcyLnVjb2RlICB8IEJpbiAwIC0+IDEzNzAyNTIgYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWpmLWIw
LTcyLnVjb2RlICB8IEJpbiAwIC0+IDEyODU5ODQgYnl0ZXMNCiBpd2x3aWZpLVF1Wi1hMC1oci1i
MC03Mi51Y29kZSB8IEJpbiAwIC0+IDEzNzAzNTYgYnl0ZXMNCiBpd2x3aWZpLVF1Wi1hMC1qZi1i
MC03Mi51Y29kZSB8IEJpbiAwIC0+IDEyODYwODggYnl0ZXMNCiBpd2x3aWZpLWNjLWEwLTcyLnVj
b2RlICAgICAgICB8IEJpbiAwIC0+IDEzMjk3ODAgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmLWEw
LTcyLnVjb2RlICB8IEJpbiAwIC0+IDE1NjA1MzIgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmLWEw
LnBudm0gICAgICB8IEJpbiA0MTgwOCAtPiA0MjA5MiBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2Y0
LWEwLTcyLnVjb2RlIHwgQmluIDAgLT4gMTU4MDkwMCBieXRlcw0KIGl3bHdpZmktc28tYTAtaHIt
YjAtNzIudWNvZGUgIHwgQmluIDAgLT4gMTQ3MDM4NCBieXRlcw0KIGl3bHdpZmktc28tYTAtamYt
YjAtNzIudWNvZGUgIHwgQmluIDAgLT4gMTQwNjMxMiBieXRlcw0KIGl3bHdpZmktdHktYTAtZ2Yt
YTAtNzIudWNvZGUgIHwgQmluIDAgLT4gMTQ5OTI4NCBieXRlcw0KIGl3bHdpZmktdHktYTAtZ2Yt
YTAucG52bSAgICAgIHwgQmluIDQxNTg4IC0+IDQxODc2IGJ5dGVzDQogMTUgZmlsZXMgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLVF1LWIwLWhy
LWIwLTcyLnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktUXUtYjAtamYtYjAtNzIu
dWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1RdS1jMC1oci1iMC03Mi51Y29kZQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLVF1LWMwLWpmLWIwLTcyLnVjb2RlDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGl3bHdpZmktUXVaLWEwLWhyLWIwLTcyLnVjb2RlDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGl3bHdpZmktUXVaLWEwLWpmLWIwLTcyLnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGl3bHdpZmktY2MtYTAtNzIudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1zby1h
MC1nZi1hMC03Mi51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmNC1h
MC03Mi51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWhyLWIwLTcyLnVj
b2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtamYtYjAtNzIudWNvZGUNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS10eS1hMC1nZi1hMC03Mi51Y29kZQ0K
