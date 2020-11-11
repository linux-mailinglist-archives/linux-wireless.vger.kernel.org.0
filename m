Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011802AECA0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 10:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKKJHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 04:07:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:42094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgKKJHK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:10 -0500
IronPort-SDR: W8k9R+wjSGUb6ufrRf15fdldfHIVev2qlTyi/noT3/BhLyK1sk3DUf5mkjWY5xWUm/qTEDmGBz
 Asuupj0FfOeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170278446"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="170278446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:06:57 -0800
IronPort-SDR: dJfuCRP1ekrW/i4z+42JmGaOEGTgMcocjw6zXbR2C0MGupIYLRByOp6cNobAslQ9i9rLWUlZ3q
 sZxIs18ayriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="366175591"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2020 01:06:56 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Nov 2020 01:06:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Nov 2020 01:06:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 11 Nov 2020 01:06:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5e+E2dmTMa5JeSp2tI5Or8uk4aZNu7QAoiDCGlkahslIkJoE49eHwvMZX1wYhMe9SFM5D4OIyHQoZAC9Zn4Y/fYA2FAavEFouW4770URvqIlZWD46/YaisXSEunwCH57jXi27HQrZnzncmX7NFSzcUOkNBRJ2TjdrvlK5VXEt10s6/NyxuIS8ylSvw6v9F47V5RrX2jdeATRBK2xkVg0pImYbuEwEO2xZ8LLyhga1/5Uho+h47I6ixcoVC2Wwvst/CooNaYWWYJgMKKHIwUQ4F9FkqHWrN7Bmf7oVZ/9eEe/fvnPJakPkzbLKXOzH1rccd36FvHp+Z4EUYsM/9loA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z1NIwosKV52QIbiX8gBad1C+3JSZ513L4cF02XRTt4=;
 b=SXzNoNNSm9LfjPxvZhcWmNLB3RBRX8oO3jfrfzH/C7yi0cN/1eslQgFVlUOZl8m7+fEaiKNHf+hTux6WJkh8r31daXwxBd6Co5pc7hLz0L/uY1qwZIo6/c3SsnvsZ3uVStAle6eQfvlgy+zKEl+xMu6MgEso3vvNWNO0mhP0o9yOMbBZeQwuHi+8Nehjt/BaenEUwneN3jfy80uAcp9GdCYouiwsLDOHkZj42Ghnsi4UgdcZJPWlyouaIAC/w8qgZoy8x8Em2Q0AIjCBm7iFiQ5iriOZniGUOSntEq/GTmzd3PJ595o0/OQiP/gZ6qf7Ns1lgxvnv+uOSadsD4aE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z1NIwosKV52QIbiX8gBad1C+3JSZ513L4cF02XRTt4=;
 b=cIJ3fQbg2xwkCC3A0znnmA2F6/xx8MlW1t8+qK+nMbv2uHJbj8akj8ld1TUWL1VkyuuTLXa9cWfr9yDqcIfM7ERqbxiyKtri7tt8nxT2n21qbRjnkQa75vBiusX8zxJ1aAHG4HiHebYueKvl6Slmgtye6z8zt03XJO8lvf4K1bQ=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 09:06:54 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f9c7:5d2b:4417:bb33]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f9c7:5d2b:4417:bb33%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 09:06:54 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 wireless-drivers tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the
 wireless-drivers tree
Thread-Index: AQHWt6ZRZJkAPH80MUGNjJhx+kxqmKnCmJx5gAAMFYA=
Date:   Wed, 11 Nov 2020 09:06:54 +0000
Message-ID: <eec988364ca538451815a43dae655cd456e9e95f.camel@intel.com>
References: <20201111081257.30418470@canb.auug.org.au>
         <87eel0cnff.fsf@codeaurora.org>
In-Reply-To: <87eel0cnff.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1277f453-5b2f-437a-4c44-08d8862122b9
x-ms-traffictypediagnostic: SJ0PR11MB5120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5120D9517AE29C78FA717C3C90E80@SJ0PR11MB5120.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ABhCHRrAY9s4x8nzEAIoQYewtdRFw9L+fGkaY1qgv5ojFAL9Dx7e9hBnO+PO8QlGeZC7wzRsZdO8pbvADBES3T252hdhvVP9BEiFG2D3/WLLIYmkGA2DK1hXQuEK0ix1a47DGU1Fooku4ODGSObdVaft86pJEwwEsEVZHN8a46ZoWUJSpGJxjXwTXXvCSBeambeTkdlfyTxpteqN6zugZet4f5joifMcf2nTx3f2TwtQ8np0wxFxiZMxc6EiIuBzfr8BpFZVX8sQuA5CUNgurAv2yxIDsES3ngFwqe/FyBSCqvWBcaSRMFxAEQCza96TnXD4/JxMy1Ink3WWbW6WPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(5660300002)(8936002)(8676002)(66946007)(66446008)(66556008)(54906003)(6486002)(4001150100001)(2616005)(76116006)(2906002)(86362001)(26005)(316002)(110136005)(66476007)(36756003)(64756008)(478600001)(91956017)(186003)(6512007)(4326008)(107886003)(71200400001)(6506007)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3v8faXHwcKE1dOr3Il7E6c2BxUQB/wr9f6VZdUdLxZlKqfx90zsirurhWp32b7z4tek8rEs0a1FfVnJLKVo6peE/wiHDKLnhqtkOz/Lsy8Upv56nj+a0M5aQsizS8KRHxVeWjyZhIRzL4GbpDtFa5SX1M62/Yt25lF0MHWhIl+x5FPfk6dGSxfy4p8x1x4Mdx2catI3fv7FCrtJD4El9g0wPV+f0H0XX1QIOWg5W1dVy2FkqXXLGuwMJ3C8v1i/nqRRJh+N0Bh8Bq7Z/CwNhsZM4Fk1PlNHC0P6nH26GkHzzk6/WXaytnqYSVcRppVUO5+9QT7xJkBf4xzSfBQND/CfZJakDNGlfMV8fCEkGK4DW3GbdcgTzLJY0uc8Eg40Hyu9ldZY9pU5Sy6AF24gruhf7f6nKxx9K+GblPFeFdiUqBQglREQGhLyD+YMtatuWSbv9cxxaMu94tXc+67xLHnbCArJ+rM1eXGZUBjdGVOr7/dnmJpdWpp13I1WZ3+po/2C6LKv6K61015wgZX6o/BwmEgUFny6iR3QC63CsPokpd5kZD92taeLJlD1Tvh/p/Rd39bDz9MP/A8vb6c/Uo6neouq4IX5w9gW19VaARAveXrNoXbQx2rHz8uGcFffgjVPHaIsJj8FGm+Lx3yvNKVxr0/AunHxoEKqkiv8KYVLQpJZJNqqBpUsz8/CsDeFuAJVe1G8alKzulVpXtFUSuLLZnPk4M3GzgqdLgPUWoIVLbXcqXObr95BQA3WSBo+OALCjwMqt34Q6prUxVSdwseYWbLwXIIhdxbMgE59hVcr9gyDQF6f7/1+pe+luIDkzQWBieVDmQiT6veP/a3fZTV7sSkOW9DSiODZD74BqZVZz3zOkR16DF1I0hF7nFF/eYxFTh2QSReBNWLIuTj2pRw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <51133044AB79BA4A93880C4EC1AA012E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1277f453-5b2f-437a-4c44-08d8862122b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 09:06:54.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmJO3WLbq9j8usR6YfvOHRTkDWKXBLffZ3FYiKhR2jI9a1zJNRtLJT7ihK6BKECzOe40YEsUWcRfZ9OnZC3VCVQwnN8dMqwoFT62QqOgbsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTExIGF0IDEwOjIzICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBT
dGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4gd3JpdGVzOg0KPiANCj4gPiBD
b21taXQNCj4gPiANCj4gPiAgIDk3Y2MxNjk0M2YyMyAoIml3bHdpZmk6IG12bTogd3JpdGUgcXVl
dWVfc3luY19zdGF0ZSBvbmx5IGZvciBzeW5jIikNCj4gPiANCj4gPiBpcyBtaXNzaW5nIGEgU2ln
bmVkLW9mZi1ieSBmcm9tIGl0cyBhdXRob3IuDQo+IA0KPiBEb2gsIG1pc3NlZCB0aGF0LiBCdXQg
YXMgaXQgaGFzIHMtby1iIGZyb20gSm9oYW5uZXMgYW5kIEx1Y2EsIGJvdGggYWxzbw0KPiBmcm9t
IEludGVsLCBJIHRoaW5rIEknbGwgbGVhdmUgaXQgYXMgaXMgc28gdGhhdCBJIGRvbid0IG5lZWQg
dG8gcmViYXNlDQo+IHdpcmVsZXNzLWRyaXZlcnMuDQoNCkhtbW0sIHNvcnJ5LiAgU29tZXRoaW5n
IHdlbnQgd3Jvbmcgd2l0aCBteSBzY3JpcHQuICBJJ2xsIGludmVzdGlnYXRlDQppdC4NCg0KVGhl
IGFjdHVhbCBhdXRob3Igb2YgdGhpcyBwYXRjaCBpcyBKb2hhbm5lcywgYnV0IGZvciBzb21lIHJl
YXNvbiBteQ0Kc2NyaXB0IGhhcyBhcnRpZmljaWFsbHkgc2V0IGl0IHRvIEF2aS4NCg0KLS0NCkNo
ZWVycywNCkx1Y2EuDQo=
