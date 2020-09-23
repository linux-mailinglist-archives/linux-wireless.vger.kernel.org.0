Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AC27534F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Sep 2020 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIWIge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Sep 2020 04:36:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:61371 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIWIge (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Sep 2020 04:36:34 -0400
IronPort-SDR: qfzgczHwAyt4Cs/L6CXtOnaqHGkPEkHDPbvkobCYSV/FNW3pUyB9GMM84sydXhezsey3Kn/cM+
 IcMn0DVWf2RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="161764284"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="161764284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 01:36:33 -0700
IronPort-SDR: /mDVh3ETEsLjCukE2VAd6UEb5Ukso9hBPMjahN1sjjCKS2t2YSY9GTnxfAKdvUwmBUiEmbDf10
 Rvy7CkOiSdsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="347266879"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2020 01:36:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 01:36:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Sep 2020 01:36:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 23 Sep 2020 01:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRPkqF1R4+oTlXPP0T5DPmodenes56+Xlb65PsoaAMzmO7ir3e2IaXF+2+PIHSjAJzuAToJElRQRLiWzXVK/nW0O3AWy+1F9MzmHXsxoVpkknGhndW2RnvCekmpTe7oUmdmaN+aWSYAZknYjR4z+IWEIcxrhnPWahSwF1/Vp3OEqz0Ss8UM4zswcOAGxkTYelL+ZXQS7X7bwZPuhpClTG7efJRra/lZy+tB+ODFTrEEz86m/nSreRU70K/Fr3kRqtUuATd/Sqqh4iXRe0Tkgc+4JnYAl7hrvWSMjB+bAh8hkyF9I4DyJgkFkwe/1IHSpRx3Anob0mRT4pNfBQvEKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VhXvasz18iYb/oMeG8zrKdwDrGLKsnvtnRD71/hd94=;
 b=EHTjCv5z/q5cthVdNzl4OrmIP2Fu5clZUMzpxU2Y59o5fT3HXoz7pwH+l7AuRqK3VfnQysS13foWdUKejcuKq76h2//C7A4ySjn6QLyoHRpJjYHZv/5juOLWKE9W4e60zu2xz74kBgsS5Src06MShQD5cwKbxgFZSr7KYs1gJ+ag78zebeQ9T///4LOPZRpEu4DySYKCeh/dTQQyYoK+zDxGcj5QHDkERt+jpc2VtQ8602yyIZJjht/nNg2nc5REW7F0VnJoUkDjQvreOdK++5KU20OZpt9kZ3bEaw1SqIKxxdXcjM3ooJfU+CeuiDle+gybhTKumitfdN0BmEJ1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VhXvasz18iYb/oMeG8zrKdwDrGLKsnvtnRD71/hd94=;
 b=Cj7Tt6j+VEF+oJLm5SMGps5YmEJAYnyrtYjrA/AHLevUkF1H9ceHa7JqvSEIqpn4kYS5JrhGshyHGrPpqFy6d0GnVQUqvgL+oY56cVhK4onwh2kOgAJMgjWiZj+2KESDwtjOPLyL80u8LoQZ/HL9w+WMKsfLJpmDowMdAG0d1RA=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB3432.namprd11.prod.outlook.com (2603:10b6:a03:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Wed, 23 Sep
 2020 08:36:30 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::80d9:6be4:2116:c79c]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::80d9:6be4:2116:c79c%5]) with mapi id 15.20.3391.026; Wed, 23 Sep 2020
 08:36:30 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chaitanya.mgit@gmail.com" <chaitanya.mgit@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "sugandhgowda@gmail.com" <sugandhgowda@gmail.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Cedric.Izoard@ceva-dsp.com" <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Subject: Re: Configuring WiFi6 in hostapd
Thread-Topic: Configuring WiFi6 in hostapd
Thread-Index: AQHWiF6UWtb12ODeT0iq8bBO8Zo6qalj0kUAgAf+kACACiIqAIAABYeA
Date:   Wed, 23 Sep 2020 08:36:30 +0000
Message-ID: <e2cd5f5c162373e367d0e94bf2250e9a7f8144d2.camel@intel.com>
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
         <PR2PR08MB464983615CFB2AF2B3BCD644D12E0@PR2PR08MB4649.eurprd08.prod.outlook.com>
         <CAD_iCC-=rvC6mC8pOKNKqrrWQv2wt9BXVMQB2DR1QKcGp_KbiQ@mail.gmail.com>
         <CABPxzYJ=vJB4pnCC__G6Luhdp_m51Z_nKq80HFxEfN6cdsKQbw@mail.gmail.com>
         <CAD_iCC-koZwPCew4+n4nk8Ou_jWC2BxxcSDy_rf9KnO4Q=MO=g@mail.gmail.com>
         <CABPxzY+tfkjKETjdKJE7AjY6ELFfsLw4utVWOfXwxuV4C+RK8w@mail.gmail.com>
         <CAD_iCC-=9XU-DbfUorUtSRzCOEW=gr83T8ZSMvJn_xFgoMWvew@mail.gmail.com>
         <CABPxzYJmL7x1Hfx9Yf+4XT6xngWNmYC9ZGGvDYqLo7y2bNtCow@mail.gmail.com>
         <CAD_iCC9Vu55FG5vHSWF=H8v-ZZKQoyin8B-1zBtaJ+2MeJqCjg@mail.gmail.com>
         <CABPxzYKVK3OK6nKMrLrBfdy-Yz1v_bbyhHHLCkxnFzWtFBSGaA@mail.gmail.com>
         <CAD_iCC8XDNXfDmghhXyK8auFg5WinqaACpbpbiZ4g0toaDoeiw@mail.gmail.com>
         <CABPxzYK-HN-Q3wREn+6qAkiHAnkuyqz-g6m9XpUtaMd8ckHQPg@mail.gmail.com>
         <CAD_iCC-LMnDeL-e-i2GPYe9fRruWxkKvHEsNGDERv2j8eN1YFw@mail.gmail.com>
         <CABPxzYJVwjPGrHitstWkgiL+kEB9AeTMy_e5nu7FNXVv4ZNk-A@mail.gmail.com>
         <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
         <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
         <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
         <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
         <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
         <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com>
         <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
         <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com>
         <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net>
         <CABPxzYLEZ5KU5x3w9rex3SQqj+TwGXFOXnC_QXdEu9NLfcRHMQ@mail.gmail.com>
         <CABPxzYKPHXtJHP4FhdrtJ763ZeHwf4bjyPOr5c7g_88r_pSdLQ@mail.gmail.com>
         <27c3af2e3128614ffe6321a95935378f35fee1b3.camel@intel.com>
In-Reply-To: <27c3af2e3128614ffe6321a95935378f35fee1b3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.233.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a1a6aaa-c251-4f9f-8c44-08d85f9bc533
x-ms-traffictypediagnostic: BYAPR11MB3432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB34328B07E1A983AD0D018D7A90380@BYAPR11MB3432.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EcEiDkSWpIRMWqac0R6d+pyVCIPjDv64qFvxm6ovhL49eCZUh4r1FQsafVzuafbFvyru3GTa/htNhwO2ZvzwZRYA0ZOtlzBTe/urRdpYCYeCV5/DqePlMFQhrWWh1uFDBYq1Es4jr8BxfGVUWvc+VRZF8WZ9rPqa6ZkX+WYN7cdtm6pPDE652L7R4yxoCrYmh6vkN8yEm10O24Zl19iKFeLZpdEt7HW40j1gs+WYsAoLm/xtyIP0YV2gQPydUsdj5hnUphrQ1IOPch/6o932jMabrnLmmGY/NX7zHVzawroO3h5p6FdjApNwvXFemja7w8OHjFsZtLh39Je3qYD1wUo8wCGFALBKp0vYpC84lopYUXbqcNsKno2xqF5RTve9vZoUsuKMW0geV/Pyf0dcEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(71200400001)(5660300002)(66446008)(110136005)(316002)(4326008)(83380400001)(86362001)(76116006)(66476007)(2616005)(66946007)(91956017)(64756008)(66556008)(8676002)(53546011)(6506007)(36756003)(8936002)(26005)(6486002)(966005)(6512007)(478600001)(186003)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lKzl2imVmBZ7qXrqjKdtGebK6+Rbs/be/U6p3aeicrFgDMpPCn+M0J6Z9ZmvfLHAcuE5fiwNllnbYOTj15OgVvU/Xv2Px4QqehkG4Q2cNRrzYQl4XCeoRZPOGbnLgSPNBpCGLb/u8LcFwh67ayC/d610x6Z3S0uzimAngxAZ2R/cMRqUQS8fZeS5EYcdUCLi5c3uFvoPnpse6LoU1qDmeppurK9eRbCNPvBlnqUYxJhnigSz1LuA7oGleaSc1hpTOeI/ODoYxTgqJhS12mloti6k/ZCrELmyd/JhgSbvUhwS6YmJspm4IQjvRQQXfc7eA0vMLjSRVqk4xtpg0tIwD6Qy0SWto9ItaKb9d/nBIhkiOcZP4pE8CBXdHu0sU8YGRsrOcPAiWw1TpqBtDzKrnKC/Yfw4JWbX6HE1ViCGPLMc6PYJax9HoEigXc/5/E56e6E1htz0aDErZKZx9nB1YynCzDweLPahNUoMP8961wU3M7d3GRVEUYLgWf8GABxBlVlfJDmuZYx5mqALLquE0ljDrsWPHJE3QagGX+IdEafRxZbYxaYzGkys09DKGS1voydXxCNS07L2eb19b+5oxXvJN3Mp7XR4Sbaraug4Ik7cJ7uaMgzmGCliGTgC6biX+pRKic/15JTbTzXF6HahYw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <16391AF398550543816B4AFFACC80EF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1a6aaa-c251-4f9f-8c44-08d85f9bc533
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 08:36:30.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ShgHMRVFM9rEqmQ4qH8U2zOQsSE5z2Ix62jZGQBdycSj1dQ2smBEJxYXyTpcXl2ZidR34RsBDN7v2MitSyjWuij7bWmkJjP3dX8OhV74z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3432
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTIzIGF0IDExOjE2ICswMzAwLCBMdWNpYW5vIENvZWxobyB3cm90ZToN
Cj4gT24gVGh1LCAyMDIwLTA5LTE3IGF0IDAzOjAxICswNTMwLCBLcmlzaG5hIENoYWl0YW55YSB3
cm90ZToNCj4gPiBPbiBTYXQsIFNlcCAxMiwgMjAyMCBhdCAxMjo1NiBBTSBLcmlzaG5hIENoYWl0
YW55YQ0KPiA+IDxjaGFpdGFueWEubWdpdEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gT24gRnJp
LCBTZXAgMTEsIDIwMjAgYXQgMTA6NDEgUE0gSm9oYW5uZXMgQmVyZw0KPiA+ID4gPGpvaGFubmVz
QHNpcHNvbHV0aW9ucy5uZXQ+IHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIDIwMjAtMDktMTEgYXQg
MjA6MzcgKzA1MzAsIEtyaXNobmEgQ2hhaXRhbnlhIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFsgIDIyOC4zMTUyOTBdIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwMDAyMDc4IHwgQURW
QU5DRURfU1lTQVNTRVJUDQo+ID4gPiA+ID4gPiBbICAyMjguMzE1Mjk0XSBpd2x3aWZpIDAwMDA6
MDM6MDAuMDogMHgwMEEwQTIwMCB8IHRybV9od19zdGF0dXMwDQo+ID4gPiA+ID4gPiBbICAyMjgu
MzE1Mjk3XSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgwMDAwMDAwMCB8IHRybV9od19zdGF0dXMx
DQo+ID4gPiA+ID4gPiBbICAyMjguMzE1MzAwXSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgwMDRG
OEUzQyB8IGJyYW5jaGxpbmsyDQo+ID4gPiA+ID4gPiBbICAyMjguMzE1MzAzXSBpd2x3aWZpIDAw
MDA6MDM6MDAuMDogMHgwMDRFNEZGNCB8IGludGVycnVwdGxpbmsxDQo+ID4gPiA+ID4gPiBbICAy
MjguMzE1MzA3XSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgwMDRFNEZGNCB8IGludGVycnVwdGxp
bmsyDQo+ID4gPiA+ID4gPiBbICAyMjguMzE1MzEwXSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgw
NzAwMDEwMSB8IGRhdGExDQo+ID4gPiA+ID4gPiBbICAyMjguMzE1MzEzXSBpd2x3aWZpIDAwMDA6
MDM6MDAuMDogMHg0ODMwODQwMyB8IGRhdGEyDQo+ID4gPiA+ID4gPiBbICAyMjguMzE1MzE2XSBp
d2x3aWZpIDAwMDA6MDM6MDAuMDogMHgwMDAwMDAwNSB8IGRhdGEzDQo+ID4gPiA+IA0KPiA+ID4g
PiBUaGlzIG1lYW5zIHRoYXQgd2UgZ290IGFuIGludmFsaWQgVFggcmF0ZSwgbm90YWJseSBhbiBI
RSByYXRlIHdhcw0KPiA+ID4gPiByZXF1ZXN0ZWQvY29uZmlndXJlZCBvbiBhIE1BQyBjb25maWd1
cmF0aW9uIHRoYXQgZGlkbid0IGhhdmUgSEUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRoaW5rIEkg
c2F3IHNvbWUgcGF0Y2hlcyBpbiB0aGlzIGFyZWEgKGNvbmZpZ3VyaW5nIHRoZSBNQUMgdG8gYmUg
SEUpDQo+ID4gPiA+IGZseSBieSBpbnRlcm5hbGx5IHJlY2VudGx5LCBidXQgbm90IHN1cmUuLi4g
THVjYSBwcm9iYWJseSBrbm93cy4NCj4gPiA+IEFoIG9rYXkuIFRoaXMgd2FzIHJlcG9ydGVkIG9u
IDUuNCBrZXJuZWwsIGRvIHlvdSB0aGluayBpcyBpdCB3b3J0aA0KPiA+ID4gdHJ5aW5nIG9uIGxh
dGVzdCBpd2x3aWZpLW5leHQgdHJlZT8gT3IgYXMgeW91IGFyZSByZWZlcnJpbmcgdG8gdGhlIGlu
dGVybmFsIHRyZWUNCj4gPiA+IHRoZSBpc3N1ZSBpcyBwcmVzZW50IGluIHRoZSBsYXRlc3QgYXMg
d2VsbD8NCj4gPiBIaSBMdWNhLA0KPiA+IA0KPiA+IENhbiB5b3UgcGxlYXNlIHRha2UgYSBsb29r
PyBBbnkgaGVscCBpcyBhcHByZWNpYXRlZC4NCj4gDQo+IEhpLA0KPiANCj4gVGhlcmUgaGF2ZSBi
ZWVuIHNvbWUgbmV3IHBhdGNoZXMgaW4gdGhpcyBhcmVhLCBidXQgYWZ0ZXIgYSBxdWljayBsb29r
IEkNCj4gZGlkbid0IGZpbmQgYW55dGhpbmcgc3BlY2lmaWMgdGhhdCBqdW1wcyBvdXQuICBJJ2xs
IHRha2UgYSBjbG9zZXIgbG9vaw0KPiBhbmQgbGV0IHlvdSBrbm93IGlmIEkgZmluZCBhbnl0aGlu
Zy4NCg0KSW4gdGhlIG1lYW50aW1lLCB5b3UgY291bGQgdHJ5IG91ciBwdWJsaWMgYmFja3BvcnQt
aXdsd2lmaSB0cmVlLCB3aGVyZQ0KbW9zdCBvZiB0aGUgaW50ZXJuYWwgdHJlZSBpcyBwdWJsaXNo
ZWQ6DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3
bHdpZmkvYmFja3BvcnQtaXdsd2lmaS5naXQvDQoNClRoaXMgaXMgYW4gb3V0LW9mLXRyZWUgZHJp
dmVyLCBiYXNlZCBvbiB0aGUgbGludXgtYmFja3BvcnRzIHByb2plY3QuDQogWW91IGNvdWxkIHRy
eSB0aGUgY29yZTU2IGJyYW5jaCwgZm9yIGluc3RhbmNlLCBvciBldmVuIG1hc3RlciBhbmQNCmNo
ZWNrIGlmIHRoZSBwcm9ibGVtIGlzIHN0aWxsIHRoZXJlLiAgSWYgbm90LCB3ZSBjYW4gdHJ5IHRv
IGxvb2sgZm9yDQp0aGUgcGF0Y2ggdGhhdCBmaXhlcyBpdCBhbmQgcHVzaCBpdCB0byBzdGFibGUu
DQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
