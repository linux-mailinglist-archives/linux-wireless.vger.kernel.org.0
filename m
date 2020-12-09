Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBF2D4B2C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgLIUDE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:03:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:8268 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387598AbgLIUDB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:03:01 -0500
IronPort-SDR: Y6xInOqxfOFOATE1ZcRb0UKkvcAvtx/69GVxqZopDHLcMjxY9yEBFNM5qstKOb+IjK1cvc4viO
 GvK860oA0kqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="171565969"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="171565969"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:02:19 -0800
IronPort-SDR: ocMbSOoI5KCVljsYx7Qw2T6YQpcU9IiFKEpeN2JZCwjOuT17UersgCzu+YKjA3v2kX8qXomOJn
 adDvMkYgZbqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="484138324"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2020 12:02:19 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 12:02:18 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 12:02:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Dec 2020 12:02:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 9 Dec 2020 12:02:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLBtcIBpVMBNDglKeT3dS1fxA/rXgLtPLcX4mMKP21zqCUFJ3ly/2ce8Qco1xCNlZfiMoxWHR8VOox+Mvd7CsBpd1oNEc4yBukupHauQmOT+VNNmvTjNNQ0UeHFO9JUcmb9eYDHIOf+AU21RhjJKvCDKODCJY0l//aMPexaxpHPgSeRbcPfZ2c/2ty/utxidBUPK6Duh29EvwfFRPXeGDcOHxPjJJVBzyrDrKWwhmZZoL9TMXLlCqC0NcRGYLUlNMgECXbHGStxBMshenoP1+OUuAKC6g/jMz697xCeSoPWaen9xQYPUBe2lj2QN+mcGqdwFr9oDo0P7NlDskE+iIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JDog+a+IUtK82HAy93fwbzDhL7YEEccXwV6/avqxR0=;
 b=MrmovLjRNnuJonkBatjulKMEuap4GeERPxsIy+HRY/lDWTq+86T3Zj5FFoHQobwLItSnUrPtut35HULpW/s2WEhpVGHvfbkGVhgEn3Qbsy77rTiR2RU15Q01AW/u1cncQBEtYE7Ixa/xRMhjU/Ga+uwbF/UmwvE8MzMkbdXQi3kK5skvUL9JawD9eTavSo5lEQ6Pn4uQ3KnbEIyGpn23IJLg3X2rIb7SJw9TIJUwnISaqj6HNKKUmxQuqVdo+uuRiT/GPk2nB8iCQhrkUXd2fJJv9Sno4rO6AuRDmy8Wp8DFe6TMh0fKtJ4t8E5nPHhDvd1J3EO8tQsyGGePM2/7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JDog+a+IUtK82HAy93fwbzDhL7YEEccXwV6/avqxR0=;
 b=N8w3rU9Ft5nrQVa35aEiL0TKvBJ6JEpk9hyphj4XdrrvMqxcv9mWW3oxiXDuSiqQdRPSH3y2lOWYkZOAu5wgZUeASmwGyIyLdgLLzqh2Wsdpc8/GAlULw65Oca4IlSw85ZyeezWkB84yncYNIiON4UJuiOsbmSSrhlC3L/6AMJI=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2775.namprd11.prod.outlook.com (2603:10b6:a02:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 20:02:16 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::2581:444d:50af:1701]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::2581:444d:50af:1701%4]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 20:02:16 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rsalvaterra@gmail.com" <rsalvaterra@gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
Thread-Topic: [BUG] iwlwifi: card unusable after firmware crash
Thread-Index: AQHWzVU1uZFy6ssA7UObaN15n64XKantY3GAgABykwCAASx6gIAALziA
Date:   Wed, 9 Dec 2020 20:02:16 +0000
Message-ID: <1b76198a4f2775131bf744258b52e65fd7f8e597.camel@intel.com>
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
         <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
         <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
         <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b468550c-d28c-4013-79aa-08d89c7d53dd
x-ms-traffictypediagnostic: BYAPR11MB2775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27751DA37E2CD9433A5CC48F90CC0@BYAPR11MB2775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +RMia03Lg4XV8rwVrhTR3e7drTiT4DAt6Ny3izwkj7AsqMeuR5yOULXg6pfi2pMThiBo5YxJqq0A+o5WrOml6PSw5X02/64iF+/VB315TDyNxQz7fPUeKdjBdazTtYSysCYesIves8nqsd68y7AV1/CSbAkZNKSNy8y8cgmjR6xJAJl3v2L7tFa6kc+8K+Cu/gXLqmL2p3UMIFn+RYJm7kscgkAsuzNT/eBy5j9RJpNAMzsq2DoZ68FN2nNYGocvfkO+9cnt0XB92l5TLCybvxPM6uI0EoPzjpYwd2y0IcgNtB0Uua0kwk/BfWPV1wKUDeX6BgTJUzInT715HM8qVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(6512007)(8676002)(66476007)(2906002)(83380400001)(36756003)(4326008)(66574015)(5660300002)(8936002)(71200400001)(2616005)(54906003)(6506007)(64756008)(6486002)(26005)(508600001)(186003)(66446008)(86362001)(91956017)(110136005)(66946007)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V240MUg3S3hDVzdxb0FYSlJTMnBydG1LODJscVNMNmdxeWpPQkhZaEdwS29v?=
 =?utf-8?B?R0l2dWhrTHkyTkJBK0xSd1dYeUc5eTNNU1ZRS3pwWDk2ZFlxWGtRRG56NzhI?=
 =?utf-8?B?UHJiTHUyaXRKMDBXOFZGVUdtZ1BhZ1VuK0t3UitlamN1WUplRWpnMUExMGIz?=
 =?utf-8?B?ZmFPZ2Y2UTVBbzZqM0JJL0kyTGI0eHA3aE9YNC9KTEtMelNRWUF0NDFDSUVI?=
 =?utf-8?B?RWk1djRGY1BlN1N2T3hCdmxUOVBXTXlwcXloN2s0dmpWbk1majRlczFSV3ND?=
 =?utf-8?B?QVM3K29GckRTc2JiZ3BOY0dCcFExWGN0ZTJBc1duRkRzcmhnUUZiZmg0OE1M?=
 =?utf-8?B?NFI4MjY3ZlJRVTY1OWhDZlhiNFZBYksvVG0rbEtOY2dSWEd4N0RXVUovZ3pO?=
 =?utf-8?B?cSs0TW1GbmdpRE4xblFhM21hOHYzWUZRWXB6OUxzNXFiRFN4QU1kN0JaK2tt?=
 =?utf-8?B?U2daY1o3OWpuWFdRdUY1aTlNYkVVQzBwT0F5ZUpRR0dXTHJZYTJhM2Qrc084?=
 =?utf-8?B?aVVrOWljM2lRR2h2Tll6QWsxTVYzTk8zbmNLSmF2NFZ5WVlnN1ZBeUtUdjU0?=
 =?utf-8?B?TERybkdjbW5UWUJyUlo0R0NBbGtWU3NYdUtIaVNzMDFPUmtNZitwZlBwd0Vj?=
 =?utf-8?B?OXRXME8xYkJ4VitYdlg3bHlRU2p0MzR5SmVrVnJYYnJNbFZzdHNJYXduN0JN?=
 =?utf-8?B?VHJKMnJxZmlzR3BaUFJnS0wyV2ZlSndKa3gxdTM4TzRaMUhzZkJJTVFFeHUr?=
 =?utf-8?B?UEVxZEpPZ0trQmhCVnZOVzZlZCtjaU50M1FCS09uTytqb2RTZURpTng1SHBL?=
 =?utf-8?B?Wk1oUktwRUsydDRXeklSSE5rRmZYL1hNd2tkL3hlc1FjTFIrSWFZa3F5TnF1?=
 =?utf-8?B?c0gvWlV6aWJ1VUdZcXdYRXlwVXdnZzZiOTBzYVBUODgxVTNhdWovdHlzcjA4?=
 =?utf-8?B?NUtnRWZXUXFCR29zWm81U3hoU2s3WkE4UjRZVjVlVnRoVDJDbGxyVUptblJW?=
 =?utf-8?B?Z2kvZWp1bkxVSy9FR2JDYXducTZUM0xaZEUxOVk1WGhYeGV5bmhSb3NvaE8z?=
 =?utf-8?B?bURZN3Z2RjZRWklyYXhRQk1XMmw3Snp2aXpqYmxDUGdDWkJlY25nV0Q2QnBw?=
 =?utf-8?B?Slh5T0ZDeXZybCtHeTVjZ1hzY1RBSE9nUHMwNE5CMS9JQ0NWRVVXQ3Rna1ZC?=
 =?utf-8?B?MUpQNnJRZy9yOWcveHBwcVoxWG1YalovQytzSm1HMUVGTWZBM2FLNThRMVk1?=
 =?utf-8?B?M0gydVdidnRQSHoxQUx3dHE2SzlHSWE0aHVwOGkyY1BIRUg3eSt2U3R3c2VC?=
 =?utf-8?Q?ZanCiyQB/UAQiSkG0pPk0LDusQTZZSjRil?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC3F73251571DC46A153E6CE6A65B440@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b468550c-d28c-4013-79aa-08d89c7d53dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 20:02:16.3274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBKycwnDZUHcAfKhIiyICdDCVZ0C4rzuho7laXsKlifJszUvl/zCGwjvj9CIENMEaPaQemL/vnUn2/g/UX+XwDMzbpvuh3yop1djYcYnnkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2775
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSmFrdWIgZXQgYWwsDQoNCk9uIFdlZCwgMjAyMC0xMi0wOSBhdCAwOToxMyAtMDgwMCwgSmFr
dWIgS2ljaW5za2kgd3JvdGU6DQo+IE9uIFR1ZSwgOCBEZWMgMjAyMCAyMzoxNzo0OCArMDAwMCBS
dWkgU2FsdmF0ZXJyYSB3cm90ZToNCj4gPiBIaSwgTHVjYSwNCj4gPiANCj4gPiBPbiBUdWUsIDgg
RGVjIDIwMjAgYXQgMTY6MjcsIENvZWxobywgTHVjaWFubyA8bHVjaWFuby5jb2VsaG9AaW50ZWwu
Y29tPiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMC0xMi0wOCBhdCAxMToyNyArMDAwMCwgUnVp
IFNhbHZhdGVycmEgd3JvdGU6ICANCj4gPiA+ID4gDQo+ID4gPiA+IFsgMzE3NC4wMDM5MTBdIGl3
bHdpZmkgMDAwMDowMjowMC4wOiBSRl9LSUxMIGJpdCB0b2dnbGVkIHRvIGRpc2FibGUgcmFkaW8u
DQo+ID4gPiA+IFsgMzE3NC4wMDM5MTNdIGl3bHdpZmkgMDAwMDowMjowMC4wOiByZXBvcnRpbmcg
UkZfS0lMTCAocmFkaW8gZGlzYWJsZWQpICANCj4gPiA+IA0KPiA+ID4gSXQgbG9va3MgbGlrZSB5
b3VyIG1hY2hpbmUgaXMgcmVwb3J0aW5nIFJGLUtpbGwgdG8gdGhlIFdpRmkgZGV2aWNlLiAgDQo+
ID4gDQo+ID4gWWVzLCB0aGF0J3MgYW4gYXJ0aWZhY3Qgb2YgaG93IEkgdGVzdGVkOiBJIHJlYm9v
dGVkIHRoZSByb3V0ZXIsIHRoZQ0KPiA+IFdpLUZpIGludGVyZmFjZSBkaXNhc3NvY2lhdGVkIGFu
ZCB0aGUgZG1lc2cgd2FzIGNsZWFuLiBIb3dldmVyLCBhZnRlcg0KPiA+IHRoZSByb3V0ZXIgY2Ft
ZSB1cCwgdGhlIGxhcHRvcCBkaWRuJ3QgcmVjb25uZWN0IChhbmQgdGhlIGNvbm5lY3Rpb24NCj4g
PiBoYWQgY29tcGxldGVseSBkaXNhcHBlYXJlZCBmcm9tIG5tdHVpKS4gQWZ0ZXJ3YXJkcywgSSBk
aWQgdGhlIHJma2lsbA0KPiA+IGN5Y2xlIHlvdSBzZWUsIGFuZCBvbmx5IHRoZW4gSSBnb3QgdGhl
IHJlZ2lzdGVyIGR1bXAuDQo+ID4gDQo+ID4gPiBUaGVyZSBzZWVtcyB0byBiZSBzb21lIHNvcnQg
b2YgcmFjZSB0aGVyZSB0aGF0IGlzIGNhdXNpbmcgdXMgdG8gc3RpbGwNCj4gPiA+IHRyeSB0byBj
b21tdW5pY2F0ZSB3aXRoIHRoZSBkZXZpY2UgKGFuZCB0aHVzIHlvdSBzZWUgdGhlIHRyYW5zYWN0
aW9uDQo+ID4gPiBmYWlsZWQgZHVtcCksIGJ1dCB0aGF0IHdpbGwgb2J2aW91c2x5IGZhaWwgd2hl
biBSRi1LaWxsIGlzIGVuYWJsZWQuICANCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhh
dCwgdGhlIGNhcmQgd2FzIGFscmVhZHkgZGVhZCBiZWZvcmUgdGhlIHJma2lsbCBjeWNsZS4NCj4g
DQo+IEFueSBsdWNrIGZpZ3VyaW5nIHRoaXMgb3V0LCBMdWNhPyBJZiB0aGlzIGlzIGEgNS4xMCBy
ZWdyZXNzaW9uIHdlIG5lZWQNCj4gdG8gbGV0IExpbnVzIGtub3cgdG9tb3Jyb3csIHNvIHRoZSB0
aW1lIGlzIHRpY2tpbmcgOigNCg0KSSBqdXN0IGNoZWNrZWQgYWxsIHRoZSBjb21taXRzIGluIGl3
bHdpZmkgYmV0d2VlbiB2NS45IGFuZCB2NS4xMCBhbmQgSQ0KZG9uJ3Qgc2VlIGFueXRoaW5nIHRo
YXQgY291bGQgYWZmZWN0IGhvdyBSRi1LaWxsIHdvcmtzLg0KDQpFbW1hbnVlbCwgZG8geW91IHJl
bWVtYmVyIGFueXRoaW5nIHRoYXQgd2VudCBpbiB0aGF0IGNvdWxkIGhhdmUNCmFmZmVjdGVkIFJG
LUtpbGw/DQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
