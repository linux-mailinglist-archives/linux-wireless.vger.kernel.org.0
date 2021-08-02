Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DEA3DDFA3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHBSyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:54:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:35510 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSyT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:54:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213547057"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="213547057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="584072727"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2021 11:54:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 11:54:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 11:54:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 2 Aug 2021 11:54:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 2 Aug 2021 11:54:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRFGkTox6KML3a+F0yQICzwnc6jqq90IzXxtk03WMX0rY5+U0mKno3qKzppvB/YXjZIQQ3hge1igXepWSSfbSQXixg/xyFQjAlVaj0QvkTJt89pCuBVUNpUCqz36Ze3q0ZvLXUw5vyCG43yKZK4xFaubxn8S32Pr8ovoNMAqvfKqYfQgC7gBw51ZruTpEjwEVil8Czx5qIjET/gqJo9PhG2AE/5bFQuwP/bWFWMag+5/A8m/0YFEXxD4EVjWt3IjhTKnX+BkXGoQwU7/rv+Fxx/PFQgTiLPIrNUkrdVy6wGurfc646Wgk9DyxTxHEL4y+H7/zirPOpVJvbHHMLcvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4mK9zGR7RrQ+eX4+XyqLV4J3g7NHVwgyL2t3KlBMKo=;
 b=a9/V3mXxi96kCUIZ6hwHv6Ktwir98eFbCn87zYaa9h3MFcYuFHkryP0HhRXg8rOB1v2vwKNEBaKR8HfDXhPTm08EkbKCWc7WJ4yUmstaQRSjE6v7HPaFKsgVsPTBxE2R9hGCrFKaXIzYs+0i2cfKR8wNtqp8LQpeOLL23oh4AjnWVtQHWxs+/DH4B2j8Bmt7uICH35hvbQvWDfkog+Eb4Zoxvz9xq7VUx8xpSt22uvIKijkLZOT2zC+Lmie1yerEYpZc7UX6eOr4CfqwLpfA4mKvAfhfnyglyxCa85q66qtGxbLTN6nAc7NDKQADr/Fk8F6F8JBc88CQS/yoADvDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4mK9zGR7RrQ+eX4+XyqLV4J3g7NHVwgyL2t3KlBMKo=;
 b=gAk1MU2iB+qk9ZOeTVUNWdw5XiR9koFkhhOdtJHL2tXWKA7y76eQqGPbrmbrAdYRqJ4lW0RHg6tTciDMsqiObAO51lUXmRfzzcMIg4qHic45wIPvKaQNUS8b4+bTSfC93Zre9g1Qw8BILNy944V0FlWh/mogbd79zUFC7LSUUTw=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BY5PR11MB4451.namprd11.prod.outlook.com (2603:10b6:a03:1cb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Mon, 2 Aug
 2021 18:54:06 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5c60:81c3:b049:887f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5c60:81c3:b049:887f%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 18:54:06 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "egrumbach@gmail.com" <egrumbach@gmail.com>
Subject: Re: [PATCH v5 1/7] mei: bus: add client dma interface
Thread-Topic: [PATCH v5 1/7] mei: bus: add client dma interface
Thread-Index: AQHXgrPhe2mC1kCS8ECoaXDokq/ywKtglESAgAAF3IA=
Date:   Mon, 2 Aug 2021 18:54:06 +0000
Message-ID: <bfb1a1d3ab7f948c2d1cd3a275e6aa072a7a7838.camel@intel.com>
References: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
         <SA0PR11MB47524A040AA244F77C38A86AF2EF9@SA0PR11MB4752.namprd11.prod.outlook.com>
In-Reply-To: <SA0PR11MB47524A040AA244F77C38A86AF2EF9@SA0PR11MB4752.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0632bebe-8507-4d00-49c3-08d955e6e7bc
x-ms-traffictypediagnostic: BY5PR11MB4451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB445171D2309B23AB59F89A2290EF9@BY5PR11MB4451.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fU0H1Vx/SL4W4YWM9nBDRTxJp7AhRhfh0SFnt3mQk3wv28VqkYcr5wlvV2lHb+fBtG50VGvfyh9xWXt70aDEQCgtecXdgNHhx+jNOUYn0ejN2FhFXR12rOp8iH6ofVkNay/9YT04zX/hFa9V9IcKUwUgDLHHicgXjxlfZqZEUg06BUENH4+yGCOGerain8D3U17HkNLjdO6UWD8fKlhpTkNb7aPRCrSjzZyir11gVz4/CzQOpnuupL3xPZOM8hQMqVBB/JXm2KkpjUScfunNwrf6TL7QQyOL1ATkas88842S0hBeo7HTnoLGdPB8CFlWjGiG+MTykBIPX9WmvgzO1CA+YEUHrABTJw1MtAOk23p7VCRC2Nzrm4pBkf09X1kLXte3uINXxrPC1CSYIxFsHzDpzmt99XcY6wHqpNqm7mGcJBalnH1hBVVLYXTkkqH4xFPAxjkfazJw6vySzVV3jzX6VC5Xjxv5qrzWK5z/4wG02sVS9poLmMfcgCVh3KMmqnLcZ4aYbC7XEppry+sQXMz/BAUnM5XwPTv+ciXM/qH3wtCXiG8Cu9ejWElFLDZqG+WDTw6eBXHTSi/RAdWytxgfw6YqriJETmFvoGB89h1NraXOpj6if+Rhm0e0NvMmhZJ/wgmHQbjSUN9YjXidsLG/ezflwDiBMcfKi6tidXGLwJUhnsCp0uFWOXdYyMeOS7ZQtOBFSaUbkVF9byb9W6U/db7Fy/m0dnSA+09VicsjBo5jLw8XaZ1da0DzGDQRVtjsOI5lVUxTEem3J5UEbRepqBzhwuuh+QGLZ/5J2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(2616005)(8676002)(186003)(76116006)(4326008)(26005)(966005)(5660300002)(6486002)(478600001)(66946007)(66556008)(6512007)(316002)(91956017)(110136005)(66476007)(2906002)(6506007)(71200400001)(64756008)(122000001)(86362001)(66446008)(8936002)(38100700002)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm43TXNQL0w5VjUyS0E0OTFpWlE2L0RRMGRtQVEwRDlqUnYzTXZ2NmY0ODg2?=
 =?utf-8?B?VnAvMHczb3Qrd25NSkZuSHBTVnc5QThDeElqUFlZdnZjTXo1QW4zYVB2NE0w?=
 =?utf-8?B?QjY0Rnp5dVhuMHZUd1RXTWlxZWxMZ05XS29WSGRIZWtyZy83U2NUeGpkaUVV?=
 =?utf-8?B?UkJmTS9rSWVVd2YvRm1mM1o3dkh0K1pYbHVoSUZsdXA2eFJuYTdXMXdnQTdU?=
 =?utf-8?B?Sm51bnJkVTl0aVByalhvR01CN01KNTBYbTFkWjF5R0xML2F4RjRsK3hwNEdH?=
 =?utf-8?B?NFpMMkczdkM1dEd1VGlTZmNGUytudjV5V2h0V08rRmtBRVI1MHlwTWp0L2Qy?=
 =?utf-8?B?bzh3OWdZbXk3T1pGYnBSNGFybzZtQ0FnVjZWODJPcUNFZUMxTVZhc2RvMHZx?=
 =?utf-8?B?S25Ib0pYeWE2K2ljbTQ4dHg0alVjSUtTSnhzRWsvQnd6bnBwd0ZLVTVST3g2?=
 =?utf-8?B?enAvKzFXRGZkeXRKQWI0NHkvajlXdTZwUmlIWC9GMXkvK01RbVNncDAwaTVx?=
 =?utf-8?B?NHMxb0pob1dMNkt6cHk4Z3RrWFpyckJxelR4TnVyRnRISFlyWTk3d1RPQUdE?=
 =?utf-8?B?ZWJFSGlNVUZ2M0RReXpzZlNyYnZLV2YzeWtiMVRrVGNhODlTc0hmZitUck9L?=
 =?utf-8?B?MVJQWnlvczRpWnI4ZDNLMU9KL0tneHk3N2I3WGJHWjMxODhtWXo0NTVWaE1u?=
 =?utf-8?B?SGh1MTRKME9oOXJCRTdkQ2dtUEdLWWwzL055czMzMGpDOEcxcGxVUVF3Qitp?=
 =?utf-8?B?R2NFd0k5U3RoOWRBUTBoNDRoT21pdTgrcnZieU10aXN3cGVUdXVkRlR5UUxJ?=
 =?utf-8?B?OWFRVDFKZFhwc1hOUXljVHB3QjYzRWpTb1JXYXpwZ3IxTjUrbEtOZVdRSUFD?=
 =?utf-8?B?U1dvcCtianBJN0dlUWdpdmczSHN1TlRVTlpoaGtzV2RFK204ZmRGLzRvM0pq?=
 =?utf-8?B?b1VCVzN5MUtDL1FyUVBzUUxERmF4SjZ1OERVajM4cllHeUx4bDJ2bndRSTNx?=
 =?utf-8?B?MkFDeEZUREFLUDYrejQ2OHcvTjk4VDJ6RGN0QVZWd3h3eCsvUDBBTTB2Vkp4?=
 =?utf-8?B?T0JETUZRakNOeXlycU1oYXJYUXdHR2MzN2lrdjV4U1hiQ1ZrNG9QYm1kQ3pX?=
 =?utf-8?B?SU54YWkwei9BcUZqdVlOd3lTemZmeGVtaXo1Q2tITStING5JUDlLd3B3YU9W?=
 =?utf-8?B?S2hKUUM0VUxDakpSUy9mazVseGVlMk5FRUFsR3VuaFlSRlZNMzAvSTIvL2I2?=
 =?utf-8?B?L2hQVTcwdy9WT01jOG1pZGdNWnppNFU5NTJDcXRobVJoK1FyNFQ4VXYvRGVu?=
 =?utf-8?B?cDBZVnY0eEZScDlrYXQzTldsSXlqajBxQXpIczBOajlQOUE4YTlKV09MWThN?=
 =?utf-8?B?QjR6UjZ4NUJHU3RRc0xpRFFvV2VsUHpXSmlrVWk0UlV3eFlBbGJuMHRuM3pL?=
 =?utf-8?B?OXBlMjNVVFIwQW4zUHNqNG81WHZLeTdJSy84L3hQTlVIL0taMVc4ZVlPL3hM?=
 =?utf-8?B?QThhUEZUdkVqRk9iU2l6UEtEU2VVOE55VlBjRDIwQmNWTzR3b1ZKaE5oUU9M?=
 =?utf-8?B?bExXZHJKeUpCYmd6Q25UVU44S1EzcWdpTEpReVNIb2hPSDc3RzFkTU5pZUxt?=
 =?utf-8?B?cmc2aGtlclpYOGcwc08yY0lXZFE3S08yLzlSbzRnSVRWUzVKYU9VcEZraFgz?=
 =?utf-8?B?TW8ydkkrWnZsenE2WlNyUU9FdkF1ejNmMnVjMERyTWFGOW9SN3ZzWmY4RHVj?=
 =?utf-8?Q?M9BSCnj6gNTGiVLZ8fPQxNfqCFEHVngqt1Fp8FA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4848370402E9AD48BCCE1EDD1924A552@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0632bebe-8507-4d00-49c3-08d955e6e7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 18:54:06.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5P/9BhLae15D4ZCnNAwFqRk0vp8ZPGVFymoiKApQIGXjy3c18S7F8nvyPa1+3LjrP+p1bzExbfi0VDBAuTa6sTEO/HJIAYxd7xpfFcqty4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4451
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTAyIGF0IDE4OjMzICswMDAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6DQo+IEhpIEthbGxlLA0KPiANCj4gPiANCj4gPiBGcm9tOiBBbGV4YW5kZXIgVXN5c2tpbiA8
YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiA+IA0KPiA+IEV4cG9zZSB0aGUgY2xpZW50
IGRtYSBtYXBwaW5nIHZpYSBtZWkgY2xpZW50IGJ1cyBpbnRlcmZhY2UuDQo+ID4gVGhlIGNsaWVu
dCBkbWEgaGFzIHRvIGJlIG1hcHBlZCBiZWZvcmUgdGhlIGRldmljZSBpcyBlbmFibGVkLCB0aGVy
ZWZvcmUgd2UNCj4gPiBuZWVkIHRvIGNyZWF0ZSBkZXZpY2UgbGlua2luZyBhbHJlYWR5IGR1cmlu
ZyBtYXBwaW5nIGFuZCB3ZSBuZWVkIHRvIHVubWFwDQo+ID4gYWZ0ZXIgdGhlIGNsaWVudCBpcyBk
aXNhYmxlIGhlbmNlIHdlIG5lZWQgdG8gcG9zdHBvbmUgdGhlIHVubGluayBhbmQgZmx1c2ggdGls
bA0KPiA+IHVubWFwcGluZyBvciB3aGVuIGRlc3Ryb3lpbmcgdGhlIGRldmljZS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50
ZWwuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogVG9tYXMgV2lua2xlciA8dG9tYXMud2lua2xl
ckBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVG9tYXMgV2lua2xlciA8dG9tYXMud2lu
a2xlckBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRW1tYW51ZWwgR3J1bWJhY2ggPGVt
bWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4NCj4gPiBBY2tlZC1ieTogR3JlZyBLcm9haC1IYXJ0
bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjEwNDIwMTcyNzU1LjEyMTc4LTEtDQo+ID4gZW1tYW51ZWwuZ3J1bWJh
Y2hAaW50ZWwuY29tDQo+ID4gLS0tDQo+IA0KPiBUaGlzIHNlcmllcyBpcyBhc3NpZ25lZCB0byBM
dWNhIG9uIHBhdGNod29yayBiZXNpZGVzIHRoaXMgcGF0Y2ggYW5kIHRoZSBvbmUgd2l0aA0KPiB0
aGUgdmVuZG9yIGNvbW1hbmRzIHdoaWNoIGFyZSBhc3NpZ25lZCB0byBKb2hhbm5lcy4NCj4gSSBh
bSBhIGJpdCBjb25mdXNlZCBiZWNhdXNlIHlvdSBzZWVtZWQgdG8gc2F5IHlvdSB3YW50IHRvIGxv
b2sgYXQgdGhlbSwgc28gbWF5YmUNCj4gdGhleSBzaG91bGQgYmUgYXNzaWduZWQgdG8geW91Pw0K
PiBNb3Jlb3ZlciB0aGUgdmVuZG9yIGNvbW1hbmRzIHBhdGNoIGlzIG1lYW50IHRvIGJlIHJvdXRl
ZCB0aHJvdWdoIHRoZSBkcml2ZXJzJw0KPiB0cmVlLg0KDQpFbW1hbnVlbCwgdGhlIGFzc2lnbm1l
bnQgaXMgZG9uZSBhdXRvbWF0aWNhbGx5IGRlcGVuZGluZyBvbiB0aGUgZmlsZXMNCmNoYW5nZWQu
DQoNClNpbmNlIEthbGxlIGVhcmxpZXIgc2FpZCB0aGF0IGhlIHdhbnRzIHRvIHJldmlldyBhbmQg
YXBwbHkgdGhlc2UNCnBhdGNoZXMgZGlyZWN0bHkgdG8gaGlzIHRyZWUsIEknbGwgYXNzaWduIHRo
ZSBlbnRpcmUgc2VyaWVzIHRvIGhpbSBub3cuDQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
