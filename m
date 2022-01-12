Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D678948C0B2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 10:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351930AbiALJFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 04:05:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:16125 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351926AbiALJFs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 04:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641978348; x=1673514348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TXWSK4Mfx6auThyFVohrGbmxEKONstRBB5xyM62w//I=;
  b=BkJ1uKLPFEkpel67I1yyWuKfz7Th0prDY2gL12Vk51vaqVFuO8I/TE78
   35S6CEiEVIJAg1YRplRhiShyIiFMN+RXaBw1CMMW2D1ZgzPw6oz3To8ch
   DktScHTr1l9jiYsrGRTa4OPM2edMaTo6JkOOfF4GNyyO2Hes2XyoRuAD2
   fR2RH6nyUNXJM4yAX3TgoC7kcxClsVA1AA2HuRZIW/fzhWsvIjABPhKXF
   3gEDDd99FqTQSJ6ZDfRxnRGZehmDPWdKyUnkzM5eSdQkExqw8k010uPo2
   SYwefuk0CT+GtLE3NbR3+ibtZaPjfEq6Likrb15DvrotoGjIHEr4gzx+E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="268037997"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="268037997"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="620128769"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2022 01:05:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 01:05:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 12 Jan 2022 01:05:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 12 Jan 2022 01:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7JkiEJNZTPe1WHZeV3Trbzz0qWXAa5jjbM6Z6fPzS9DDMIH3NUrt+GMSP9sDiJQ7jM5s/FT7nmDm1CRJmnozLaA6a2NViBIV3u7ryuWU5cLLkhxBqz84KFEW4hco1MpMK0GNEwBASGvpv0MIBPi/nKEmK2ApA3nu3CzKEYeY1IecI5JT5MhkuOZ+oDAdU7fUukPadGXScctiuRwyqTpPYEt1uBKPCPbfoT6DE+FcspQoBaVG2tLXmRzbEZT9IZWYlF9WSO+Vm5++YPwJjG1RXbMZ0o2QdhSDaLI47RC+EdDx2cXG5Ym0Itsu0sjOH9eIsAo5f1Km+j/dF/VLWc/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXWSK4Mfx6auThyFVohrGbmxEKONstRBB5xyM62w//I=;
 b=HQggzt+puz4asWUzkQYmLEi46DpJDClG48YDBtZYbk1RnQhW/Me+pFhnPa8sUle6mLnE+mgv6Qd4sMN+G6p/Da+/3B7cCcQAo/pk7KUG553t72g4KlrAnx/WU0EvbkP2DIlN+iCgAbzG3/qOdkHN2sr1vQ0xJYxpEWBjHaK5isVIbTWSaJ5N5kCgGD7I+OQfMKYKZUUuXiLj1BVfKlto708SAbNd7KInfrM6HdOXS/hSQGHyQptqs3+2T9F2XLNFir6Czno6iLWyxdH0zBXhiVdnw2KIqe95JnzS0aswHZ10YNnc86X6bxl3MRpmODIb0KVitOGpUtBNr3b5szme9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB3701.namprd11.prod.outlook.com (2603:10b6:a03:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 09:05:44 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:05:44 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Topic: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Index: AQHYB1Z1kfzr/0Efz0WQ7sMSiyR//KxfD8iAgAAIsQA=
Date:   Wed, 12 Jan 2022 09:05:43 +0000
Message-ID: <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
In-Reply-To: <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 619b5701-11e8-494e-34ee-08d9d5aab72d
x-ms-traffictypediagnostic: BYAPR11MB3701:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3701495AC42C455B078BD30590529@BYAPR11MB3701.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vw0/kv/9oE8NAHQcK8SD/uUqoYBzhB6mfBSVYrJytohxefjpNR85Lm46mO1EUrSVqp/qH/YX2EBXjeYsp0milylSTT4/Ofuah+ImlbmaRvzm5U9uP1GckKmhe5W1V/CxA/sSitnjB7Zm1v9WEvrSatu4gshTW/EMcWOYwmg6c8tPcBKmgTOeePiGS6L+ob/NJXYuPM5Qnekxsll39O/YRruG6QJyKX/OniR8Ps8SNgjNoxK6VTTuctDL+79beICPEUtQZBOVxWD/VX68gehaR86TjI+ezgwb+ECajMBtECBholjof8QEUj/lyhKl3tvC6tl2ppQx8gCaM26V1JgCT3TSHBoDYeEO3fAVU07bn8ROQp9whRDeWTwgtcAtfEA8bibQiO21eY8m7hhNuSNNwvoBkfsBZyQsA/HHCqx2cEIDC76l9vtqHQgfO4HYa0DAMesViE7HKsBwGZwiH+991HbD8Vcf3mFiSbqgkc0G2P7nOijWrUF8pA80mfFFJ4lWzJ9z23Ih5aZGVCWYzmcufAUZrJ77IyTlMnaFqViCnF8cy8g+lEICpIty4rOvyl/ZCYHkIb6YvRhjAvGZl/Ma18RW0gWc/T8dw4H9CAQjj1m49P1/P+luo7iGgmwkLWYSgUrrBPMV1JjafyWOuBxcDFyLQoFryx6nmljSJQPe26RmUvZ7ZKDEByqHo5OZE8YmsPghcdYLiKbgKBKRJJzYfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(86362001)(64756008)(66556008)(66946007)(38100700002)(122000001)(76116006)(4326008)(66446008)(8676002)(110136005)(26005)(186003)(316002)(2616005)(6486002)(91956017)(38070700005)(6512007)(508600001)(82960400001)(71200400001)(6506007)(2906002)(8936002)(83380400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTVEMmplMG5wVHNVVmVWUC8zUm1KSWVPbHppNGw3aGNLcW1GdjFtVmlYb2dW?=
 =?utf-8?B?Sy9wdGpIYzN6MHdQVGxGSE9Za1hvVExMSDJTV2kvWmJLMVNtbGhsNEhGM3Ur?=
 =?utf-8?B?RXRSbW5pWkN3WDlTRTVzTXc5Y0pCYjRRVHdqTGROZ2tqYlRsQ3Azd3BsZHZy?=
 =?utf-8?B?Rkh2QnNHNjRxZVE1Z2t3eXk3cGFjZXRCS0tPcFUwTHZ0SGRLRVRlbHMvZFRU?=
 =?utf-8?B?a1RibXFSampWSjJjMDAzNmZ4aEQxN1JvOCtCd2U3N2Q0QittVHdTQ2hYVzZr?=
 =?utf-8?B?MCs0d1VpVWtuT254NktmOERMcWtVQ29tc3c1Z1lRUUtLaWQ1cGhHMXlIQ0pO?=
 =?utf-8?B?MC9sMlpldHN1RWRmMXJ5dmY0dmZaZXZtdnFVZC9DRTM5eWRKMkhHVnNzVlpk?=
 =?utf-8?B?bnBrbHh3MWk2MU51RDV1bDZneVpoR255NEgzV2FSRkJtWENjcmJZL2FXa1hy?=
 =?utf-8?B?KzFmQlE3ZDBFK1lLUUdjM2o4ZTl1dFBHdVJnYWZWbkxWZEtzOVcxNGlhaGEr?=
 =?utf-8?B?WkNQUHplcjJ3M29iM01XZldPcGZmWE9IY2tVeGJDMjV6dElaT1NiNlZYcHZQ?=
 =?utf-8?B?R2REU094NFBWWVpieW56L2JqTGovZEkvNndHV2EyWkRhZWh1b2s0cnJ3MU4w?=
 =?utf-8?B?Si84aHhNbkJmVWMrMVVJY05xTWNUWFpYUW9ZMHc0S2VWcEdKa1kzL1VQVThF?=
 =?utf-8?B?NkFycktLZFVsZ1plL3VYbDhBODdZVHFEOGkrQkpOSlArdWw0Z2NLWThMdi9Z?=
 =?utf-8?B?ZGRJMHFuL1VaQkpmQ2ZGdnpaelVkeWx3S0ZyblVKRWJoVmJScEtRUkdUUTdo?=
 =?utf-8?B?NkZrRVlya0tzT1NvUzJMSzdxZ0dKdzc2VzI4UUd2WVdCcy93Yyt4dnFWSlJL?=
 =?utf-8?B?QTBOMElMcElGQTEwbG1nQjNKdllFeHpudmFMUEViTnhsV3pRRkVkV3dUWjhw?=
 =?utf-8?B?eDBidHZsakhtcU5Vd0NnSGRhdTBQTWZ1Q3hqSE5qS3E3bnphNXpGM1J2cUJ4?=
 =?utf-8?B?VEZZRnk4dzJkNHRBUmxhcXdPM3lTTTladWhvU0MrKzQrNG9CZGtJMzhBZjFB?=
 =?utf-8?B?dzI5cDJYeW05NGZXb1lvYm03VkF2aGFxc1o3ZHNNTDgwWE56OEErRlUxNWZh?=
 =?utf-8?B?ZnNTWlFnRmxIdjU4N3ZPNHJxd0NwRk13VE9aMEtvYTNQaTM1N3RGalJ6K0tr?=
 =?utf-8?B?by9pdDljbElrWkxPeVZReDRnN2VyTWoxT3FwYmhMbXB2QitHQkdya0NNNW9X?=
 =?utf-8?B?N0wrUmFmK0dlMllRN2h1SE1mcFlLYnJvN0h3MlZ2eEgyZnVzdjhlcC95bXND?=
 =?utf-8?B?eTNzd05ta04yekNFdzVhQkQ4U29KVWw1eHcweU05cndDRjRCaG54blNXVXVH?=
 =?utf-8?B?a1R2Vm9oUFRmOXBOdlJURWJhL3pXV3lvMmxKZUNFTHloa3YzQ2tvQlN2a0E1?=
 =?utf-8?B?Q0lBYmJobGErVFMyb3Bqd0VXVnhEeTE3TTFYRXI1dkQxRzRVMHZrWnJ5aGZo?=
 =?utf-8?B?ODh4TVluWUFiNENkb0VKRTFDV01BMlBjK3A0RUUweS91N1ZzUTJZbmdMR0xx?=
 =?utf-8?B?TTJtVmJ4T3FubVlSQ0VzOEtyT3lYQmtCRmZPU3BtOVBqVTRYM0wyZk51MXhs?=
 =?utf-8?B?cGswNXNTa2trdEdxUEJXVlhPSUR0aSttVjVBRDl4MWtlTTRQNFZWbmg0U012?=
 =?utf-8?B?L3cvSFlYNUw3cjJrTXBONkRmUXQ0N0JVWXVxMW1Vd2tmM2R4VGc2bVhPNENG?=
 =?utf-8?B?N0xIVzZBTXZBWDJCQjBBdFpqa1JyR1JIZW5wZlBacklvdjBpRUxmQ2JydGlW?=
 =?utf-8?B?SWh4enpHMWw1RklMdlkrYTR5V1lhUzBOcm5JVnVYeUo1ZE80MDBCeStKUVli?=
 =?utf-8?B?WGVEb084Q2lGZmZlVlRNNCtNWDFYYzg2ZUp2SC9zMGNvUjF6QTJRZkRoWEhB?=
 =?utf-8?B?SzJteTRtVzR3cWRWTzRRRVFWNFE0MkFsYUsvbEJrOE1qWFlPT3o2MjdLZzlt?=
 =?utf-8?B?MnY0Y2ZhbVl0K3RXVk54QkI2cDU2QjBPRG9hQ2VRdEtSeXBucENYNEoxbnFk?=
 =?utf-8?B?WFdRdGROMDNRNkdzWWFUd01WKzA0ams4VW1wb1hobzYxNkF3KzJneDZHZ2tp?=
 =?utf-8?B?WmxscVA5ZWo5TDkyMlRpR0x5bUZBN1ZXM0hleTBSS0ZTOGtNclcreldEenNv?=
 =?utf-8?B?QS9aL09HemdSUDVTUHFiMlp1TU9qdWJWOHNQT1hWR0VsakZ0a3ozYjlCQzhP?=
 =?utf-8?Q?Is9mu+XABaQBp3GTdzl+FbUtZO4EPxyJJ+Gr12dSEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2C3C935E2B5741ACD99A45A58BE60E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619b5701-11e8-494e-34ee-08d9d5aab72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:05:44.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3gJolmK5C2vq6KZtjn5TZrfuOK49YfKiz3bYk8eGvLFeotBxfsckaWeTHAoPgCHSZZN43DKySxM3BHV8j+x8BNegNTEEpy07/oj5WBLP/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3701
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAyMi0wMS0xMiBhdCAwOTozNCArMDEwMCwgSm9oYW5uZXMgQmVyZyB3
cm90ZToNCj4gT24gVHVlLCAyMDIyLTAxLTExIGF0IDIwOjQ3IC0wNTAwLCBMZW4gQnJvd24gd3Jv
dGU6DQo+ID4gDQo+ID4gSSByZWNlbnRseSBpbnN0YWxsZWQgRmVkb3JhIDM1LCBhbmQgdGhlIGNh
cmQgd29ya2VkIGZpbmUuDQo+ID4gQnV0IHdoZW4gSSBidWlsdCBhbmQgYm9vdGVkIGEgNS4xNSBv
ciA1LjE2IHVwc3RyZWFtIGtlcm5lbCBmcm9tIHNyYywNCj4gPiB0aGUgY2FyZCBmYWlscyBhdCBp
bml0aWFsaXphdGlvbiBhbmQgSSd2ZSBub3QgZm91bmQgYSB3YXkgdG8gcmV2aXZlIGl0Lg0KPiA+
IChkbWVzZyBiZWxvdykNCj4gDQo+IE91Y2guDQo+IA0KPiA+IFsgICAxMS40MTE1MzNdIGl3bHdp
ZmkgMDAwMDozYTowMC4wOiBMb2FkZWQgZmlybXdhcmUgdmVyc2lvbjogMTcuMzIxNjM0NDM3Ni4w
IDMxNjAtMTcudWNvZGUNCj4gPiBbICAgMTEuNDEyODE1XSBpd2x3aWZpIDAwMDA6M2E6MDAuMDog
MHgwMDAwMDAzOCB8IEJBRF9DT01NQU5EDQo+IA0KPiAuLi4NCj4gDQo+ID4gWyAgIDExLjY4ODMx
N10gaXdsd2lmaSAwMDAwOjNhOjAwLjA6IEZXIGVycm9yIGluIFNZTkMgQ01EIFBFUl9DSEFJTl9M
SU1JVF9PRkZTRVRfQ01EDQo+IA0KPiBMb29rcyBsaWtlIHNvbWVob3cgdGhpcyBzbGlwcGVkIHRo
cm91Z2ggYW5kIHdlJ3JlIHNlbmRpbmcgYSBuZXcgY29tbWFuZA0KPiB3aXRoIGFuIG9sZCBmaXJt
d2FyZS4NCj4gDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGlzIG1pZ2h0IGhlbHA/DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZncuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMNCj4gaW5kZXggN2Vl
NDgwMmE1ZWYxLi41NmI5MzYzYTkxMTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vZncuYw0KPiBAQCAtMTAyNiw3ICsxMDI2LDkgQEAgc3RhdGljIGlu
dCBpd2xfbXZtX3Nhcl9nZW9faW5pdChzdHJ1Y3QgaXdsX212bSAqbXZtKQ0KPiAgCS8qIHRoZSBv
cHMgZmllbGQgaXMgYXQgdGhlIHNhbWUgc3BvdCBmb3IgYWxsIHZlcnNpb25zLCBzbyBzZXQgaW4g
djEgKi8NCj4gIAljbWQudjEub3BzID0gY3B1X3RvX2xlMzIoSVdMX1BFUl9DSEFJTl9PRkZTRVRf
U0VUX1RBQkxFUyk7DQo+ICANCj4gLQlpZiAoY21kX3ZlciA9PSA1KSB7DQo+ICsJaWYgKGNtZF92
ZXIgPT0gSVdMX0ZXX0NNRF9WRVJfVU5LTk9XTikgew0KPiArCQlyZXR1cm4gMDsNCj4gKwl9IGVs
c2UgaWYgKGNtZF92ZXIgPT0gNSkgew0KPiAgCQlsZW4gPSBzaXplb2YoY21kLnY1KTsNCj4gIAkJ
bl9iYW5kcyA9IEFSUkFZX1NJWkUoY21kLnY1LnRhYmxlWzBdKTsNCj4gIAkJbl9wcm9maWxlcyA9
IEFDUElfTlVNX0dFT19QUk9GSUxFU19SRVYzOw0KPiANCj4gDQo+IEx1Y2EsIGFyZSB5b3UgYXdh
cmUgb2YgYW55dGhpbmcgaW4gdGhpcyBhcmVhPw0KDQpJIHdhcyBub3QgYXdhcmUsIG5vdC4gIEkg
bG9va2VkIGludG8gdGhpcyBicmllZmx5IHRoaXMgbW9ybmluZywgYW5kIEkNCm5vdGljZWQgdGhh
dCB3ZSBzaG91bGQgYmUgZG9pbmcgdGhpczoNCg0KCWlmICghaXdsX3Nhcl9nZW9fc3VwcG9ydCgm
bXZtLT5md3J0KSkNCgkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KDQouLi5hbHNvIGluIHRoZSBpd2xf
bXZtX3Nhcl9nZW9faW5pdCgpIGZ1bmN0aW9uLg0KDQpUaGVyZSB3YXMgc29tZSByZWZhY3Rvcmlu
ZyBpbiB0aGlzIGFyZWEsIHRvIG1vdmUgdGhlIGluaXRpYWxpemF0aW9uIHRvDQp0aGUgaW5pdCBw
aGFzZSwgYW5kIHRoYXQgbXVzdCBiZSBjYXVzaW5nIHRoaXMuICBJIHN1c3BlY3QgdGhpcyBwYXRj
aDoNCg0KY29tbWl0IDc4YTE5ZDUyODVkOTNlMjgxYjQwYzNiOGQ1YTk1OWZiYmQyZmUwMDYNCkF1
dGhvcjogICAgIE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5j
b20+DQpBdXRob3JEYXRlOiBUaHUgQXVnIDUgMTQ6MjE6NTYgMjAyMSArMDMwMA0KQ29tbWl0OiAg
ICAgTHVjYSBDb2VsaG8gPGx1Y2lhbm8uY29lbGhvQGludGVsLmNvbT4NCkNvbW1pdERhdGU6IFRo
dSBBdWcgMjYgMjM6MzY6MTAgMjAyMSArMDMwMA0KDQogICAgaXdsd2lmaTogbXZtOiBSZWFkIHRo
ZSBQUEFHIGFuZCBTQVIgdGFibGVzIGF0IElOSVQgc3RhZ2UNCg0KLi4ud2hpY2ggd2FzIGludHJv
ZHVjZWQgaW4gdjUuMTUuDQoNCg0KVEw7RFIsIEpvaGFubmVzIHBhdGNoIHNob3VsZCBoZWxwIHdp
dGggdGhlIHByb2JsZW0sIGJ1dCBtYXliZSB0aGlzDQp3b3VsZCBiZSBiZXR0ZXI/DQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZncuYw0KaW5kZXggODYzZmVjMTUw
ZTUzLi5mMTM4MjUxODUwOTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS9mdy5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9mdy5jDQpAQCAtODM0LDYgKzgzNCw5IEBAIHN0YXRpYyBpbnQgaXdsX212bV9zYXJf
Z2VvX2luaXQoc3RydWN0IGl3bF9tdm0gKm12bSkNCiAgICAgICAgICAgICAgICAgICAgIG9mZnNl
dG9mKHN0cnVjdCBpd2xfZ2VvX3R4X3Bvd2VyX3Byb2ZpbGVzX2NtZF92NCwgb3BzKSAhPQ0KICAg
ICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IGl3bF9nZW9fdHhfcG93ZXJfcHJvZmls
ZXNfY21kX3Y1LCBvcHMpKTsNCiANCisgICAgICAgaWYgKCFpd2xfc2FyX2dlb19zdXBwb3J0KCZt
dm0tPmZ3cnQpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCisNCiAgICAg
ICAgLyogdGhlIG9wcyBmaWVsZCBpcyBhdCB0aGUgc2FtZSBzcG90IGZvciBhbGwgdmVyc2lvbnMs
IHNvIHNldCBpbiB2MSAqLw0KICAgICAgICBjbWQudjEub3BzID0gY3B1X3RvX2xlMzIoSVdMX1BF
Ul9DSEFJTl9PRkZTRVRfU0VUX1RBQkxFUyk7DQogDQoNCldlIGhhZCBzb21lIGlzc3VlcyB3aXRo
IHRoZSB2ZXJzaW9uaW5nIGFuZCBzdXBwb3J0IGZsYWdzIGZvciB0aGlzDQpmZWF0dXJlIGluIHRo
ZSBwYXN0LCBzbyB0aGUgaXdsX3Nhcl9nZW9fc3VwcG9ydGVkKCkgZnVuY3Rpb24gaXMgbm90DQp0
aGF0IHN0cmFpZ2h0LWZvcndhcmQuLi4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
