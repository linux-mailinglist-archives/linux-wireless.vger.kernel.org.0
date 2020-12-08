Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208252D2FAA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgLHQ2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 11:28:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:40444 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgLHQ2a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 11:28:30 -0500
IronPort-SDR: PEvzhMHV7OFq2jH6fw1x2BHIVHi/jHoSTUo1Le4bE4SowVKiy5I9WXRai4XjTRTTxhRS0QJ2se
 /DKppQSHldLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174066437"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="174066437"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 08:27:49 -0800
IronPort-SDR: dPfoasYlKrP7m0OdaBcpD4yg2/+aLLuV+T7U7lnnA+4DY2adq8SIR5c7cjDcb/OJvCX3aBSX7L
 +suEv4FruVkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="370440031"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2020 08:27:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 08:27:48 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 08:27:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 08:27:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 08:27:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXP7rS4rKMx0LJhjrK15egGbF47SgZOEcv+wsGmw8C5G4HSvok+w3dX24xi2RhEOKLel6H8K/0JiPYe7zBd9VViHIID29N0OHhrlKdCYJC2QpWN1il4/7I+HYPnpBjNefnFV+Z+sHqYFhoVl93AhuexI/3i/zfCgsHxqU3CVJz0ZQGYm/ht9fwynACZk/LGrkhj2RvKxmC91Q/phttI+L2gIK85JRDlAmyoVK6yJSuPMieph31Gz90DOW80Y5mr9GXLfJ+aZhXoOw/uNNwNuJpFyfdcnZccOzhiuZE6hlAhxPYMPdXrBJtGb6z0Gtyj+vrUIb5eT7l9EwPVpqRVzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB0tNFJGCHry5fOp8H4Rb1PPNt8dPylS9BfSUzAOsbs=;
 b=hun031i5ylHvcWELW13oHk7rmVuSlKkuSivWyWmcNGzeq+mBUiOqglO+DEeecqXqk9VAqSDtu4y7ipIVrhZ/bAWSkk0C7dD2tmH3t6O9mv16HtzQ+5gZcabAWwbS5knQYPpfPur8zhX+E558t8Mly04SB8ckDRdyypNM+5Xb1BRlWn97BHBvVwEHYVWraFd8RmWyeskAqI2psx4IEemDK9dKEkvddWhXseMsR+dsMsd+eiKOTRt7li9tS0x47rwlnAK/aICoAh6E6Fybqs0QCh1dmW4RDmoyL5hBNEMXtaDNTBEpVyrnkysjSdscOvyoaUlhm3w8C8lDNwazB8octA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB0tNFJGCHry5fOp8H4Rb1PPNt8dPylS9BfSUzAOsbs=;
 b=VXIWWulpaF6K/VlCbT/TEGdk1+X3PCIlQi28D8sis5Z+oyjm/wxbaTymAqbvaIhLsbJ7snyYYSb0uux0ZKOnN60BeNB9bjFZf989o2ogtDQ7J3rWq2Xaop7UvpglULMHnIFz6AaM+p373nsu0QbmK+UZyWPbF/xgruccU2OxdxM=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 16:27:46 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::2581:444d:50af:1701]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::2581:444d:50af:1701%4]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 16:27:46 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "rsalvaterra@gmail.com" <rsalvaterra@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
Thread-Topic: [BUG] iwlwifi: card unusable after firmware crash
Thread-Index: AQHWzVU1uZFy6ssA7UObaN15n64XKantY3GA
Date:   Tue, 8 Dec 2020 16:27:46 +0000
Message-ID: <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
In-Reply-To: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48bee090-7def-4bb1-c8e4-08d89b96329b
x-ms-traffictypediagnostic: SJ0PR11MB5056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5056404C2B2EA18889B6E59C90CD0@SJ0PR11MB5056.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5D/SnY2CG17paAHiMuHQ0AhbIIsT61OIoHLeFeGLOKXUz+IjQmFCFhCBVBSe+4QbSAWdrQ1WeGa5ANuegmkgO9DCLeq9X4th9XV6YliTbInoTsnNLkvJ40XkHLQ+Acaxh6KqOMO//DY/WV4A8gZsO/kIm64A7Ee+OCnsRzE21/P0zEgy+XGS4vRHueGClYzBlIIJ0RKR567/F/l/U4BDRrCXsOk9g/LkqHCEKUSWtr6MPRbMwKdXq8/9vVTRkPq+vwT7DHPADwei08HgBmqMQyR10S8MYFmnxV0ZAfxDmltwWHkQ6I7S4tW851Thfp1aqCnENE0hAaooyq968hxbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(508600001)(186003)(8676002)(6506007)(4744005)(83380400001)(5660300002)(8936002)(76116006)(2616005)(4326008)(66574015)(54906003)(110136005)(86362001)(66946007)(91956017)(66446008)(26005)(66556008)(6486002)(2906002)(64756008)(66476007)(36756003)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TzRnaElmZ1NGQU54UlJvd1V2ZEUxaVpyM1BJblRibUIwNHcxVXE5bkVWWThK?=
 =?utf-8?B?TDB4U1Z6U05IZFdnUjhuYWdONnFiMkI3RHBCYUNSZ0M4ZHh0RU9YMmcwNnow?=
 =?utf-8?B?bHMrc3BzcFlEMXp2Z1JtM0dRcUwxVnJqdWo1OEQwTE5IbTlId2JKUnBwdGU1?=
 =?utf-8?B?Z3dYZDN4dzNLcDZQRnkrbTNyeFltY3Z2UTZHMjQ0bU0vRkpYbmVyR1pZdjNY?=
 =?utf-8?B?cVczc21aNW5kWUY5MGlid2YrTUx3M05hSlM3dmIzTTc0Y2xIRndQZ0ZjdXM4?=
 =?utf-8?B?b2ovM1oxUkRaaExQN294TnVGeUJ1MkRERkJxZ0c0dm9JdDE3NUxHU2pkdnhW?=
 =?utf-8?B?cERjS0NCck9GWmh2QXJyMkFHSlQrVTdyZDhuc1pLZjB4K0FRK0U4czc2RU1q?=
 =?utf-8?B?Y1JFMGEvYjdhc1V2TUM4WlNsWXdQU3hkMVdkUHJMK0tQb2FkZ0kyVXM2U3dR?=
 =?utf-8?B?bzZPSnVFK0FONjNrM003SlFHTGQ2MlRlb0dOampsRi9yS2Nya2xndDZ5alFm?=
 =?utf-8?B?a0ZvbStoWklwWUhGVmJBQzJKZ2REUDByWWlIZ2lTWE5TeDNsdCs3cWNPSURx?=
 =?utf-8?B?ZUVVMmtscnZaZzQwWXlHeEx3SVRoL1U5c2dodHJVcWRJams5VDdWZDJVdVha?=
 =?utf-8?B?am5VeVZ6ZzIwbmRLZ2lDV3VoVkdiOUFqOFBoT3QwMWJjRTJkcVlJTExZUFRO?=
 =?utf-8?B?aUVxa29EQXIwR05zUCtmSGJ5V1VUdi9zMGpjb1ZrREZlekRDQWk2NU5KUzcz?=
 =?utf-8?B?cWFKb3FnMmJ6NVJMYnEvanBPQStBZm01NTZQaTFkVDh2bTE3Um8zV1k3Vk9H?=
 =?utf-8?B?OElUb0ZvSFRqeis0TDA5Qm1zWmFtMGVOWWYvYjlmUTlYbnRrWVZRQStxNEFa?=
 =?utf-8?B?Z1AzYk0xOW5wY3BzclN3cUh4NHlQcVFjdDJGRUNaalg5aUd5emNicWM5MzVz?=
 =?utf-8?B?QWEwQzNTTHE3U253enIvbS9manJwMDB6blgyenVZajY5UTY4SGl4aWg1MHN1?=
 =?utf-8?B?WjNudXM4OFpZOVhVMHREdG5SdDF4SFN3REhWamYySzRzcTBuVGJhZEVuQzcv?=
 =?utf-8?B?WWkyZFU2eDBISkxHL0NtdHBqZUYwYXphSnNKMTlVSGxXTmlxeVdkYm50ekkz?=
 =?utf-8?B?aUppTGNOaVZ2S0hnTStkVTU5d01CeS9Lb2tvOFR1bTI0Z29Vbm9CS1pRQjZQ?=
 =?utf-8?B?WkF0eXd0MVZBeThETi8wRkZwWUhVd0JXTnVQU1V5TklTUXRwVXhWT3RsTjd5?=
 =?utf-8?B?WU94MWlxdUVNaHNaQkZTQitUSUZGbEZFMExQMk1XV0pBOXdoSlgzcUIwSzRI?=
 =?utf-8?Q?0tPMTZD7C+E51VgV4he5ZD1j7a/1vrnZB4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6183FF4C3F8E42489C0A8BA7C141DCBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bee090-7def-4bb1-c8e4-08d89b96329b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 16:27:46.7656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbSupauYybMyA/EGeSZprBIt7bl+JLzd1WZUJNCtaYZdO2XPpVnlJjFSOgCFa9CxOuy7IEZxn0TjicFx9GA/WI5oCSyi9vWcADy6BOs6HCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTA4IGF0IDExOjI3ICswMDAwLCBSdWkgU2FsdmF0ZXJyYSB3cm90ZToN
Cj4gSGksIGV2ZXJ5b25lLA0KPiANCj4gSSdtIHJ1bm5pbmcgTGludXggNS4xMC1yYzcgd2l0aCB0
aGlzIGZpcm13YXJlL2hhcmR3YXJlOg0KPiANCj4gWyAgICAxLjQzMTg3OF0gaXdsd2lmaSAwMDAw
OjAyOjAwLjA6IGxvYWRlZCBmaXJtd2FyZSB2ZXJzaW9uDQo+IDI5LjE5ODc0MzAyNy4wIDcyNjVE
LTI5LnVjb2RlIG9wX21vZGUgaXdsbXZtDQo+IFsgICAgMS40MzE4OTldIGl3bHdpZmkgMDAwMDow
MjowMC4wOiBEZXRlY3RlZCBJbnRlbChSKSBEdWFsIEJhbmQNCj4gV2lyZWxlc3MgQUMgMzE2NSwg
UkVWPTB4MjEwDQo+IA0KPiBNb3N0IG9mIHRoZSB0aW1lLCBhZnRlciBkaXNhYmxpbmcvZW5hYmxp
bmcgV2ktRmkgKG9yLCBzYXksIHJlYm9vdGluZw0KPiB0aGUgcm91dGVyKSwgdGhlIGNhcmQgZGll
cyBhbmQgb25seSBjb21lcyBiYWNrIGFmdGVyIHJlYm9vdC4gVGhpcyBpcw0KPiB0aGUgcmVsZXZh
bnQgZG1lc2cgb3V0cHV0Og0KPiANCj4gWyAzMTc0LjAwMzkxMF0gaXdsd2lmaSAwMDAwOjAyOjAw
LjA6IFJGX0tJTEwgYml0IHRvZ2dsZWQgdG8gZGlzYWJsZSByYWRpby4NCj4gWyAzMTc0LjAwMzkx
M10gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IHJlcG9ydGluZyBSRl9LSUxMIChyYWRpbyBkaXNhYmxl
ZCkNCg0KSXQgbG9va3MgbGlrZSB5b3VyIG1hY2hpbmUgaXMgcmVwb3J0aW5nIFJGLUtpbGwgdG8g
dGhlIFdpRmkgZGV2aWNlLg0KDQpUaGVyZSBzZWVtcyB0byBiZSBzb21lIHNvcnQgb2YgcmFjZSB0
aGVyZSB0aGF0IGlzIGNhdXNpbmcgdXMgdG8gc3RpbGwNCnRyeSB0byBjb21tdW5pY2F0ZSB3aXRo
IHRoZSBkZXZpY2UgKGFuZCB0aHVzIHlvdSBzZWUgdGhlIHRyYW5zYWN0aW9uDQpmYWlsZWQgZHVt
cCksIGJ1dCB0aGF0IHdpbGwgb2J2aW91c2x5IGZhaWwgd2hlbiBSRi1LaWxsIGlzIGVuYWJsZWQu
DQoNCi0tDQpMdWNhLg0K
