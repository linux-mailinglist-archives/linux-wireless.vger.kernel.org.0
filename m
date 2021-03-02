Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321C32AF9D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbhCCA1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:27:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:22604 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383185AbhCBKtw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 05:49:52 -0500
IronPort-SDR: wVtBiUJgvTE5GDjlg8shZ5pX0vJ1BqoIu4wPwEWUNP9jJFAqAgsJPh/WjDeXFLkNLagifPuAZJ
 q10YAX5RpSMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186891240"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186891240"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 02:48:11 -0800
IronPort-SDR: PgpaEwnRAsmPSgoVHftEZmwVxMILFAN0cICbbu9acRkRHawAEFOpXF/6JCv7JRGmvZqyC6sSSk
 y3/R6lgV2lmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="427445134"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 02:48:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 02:48:10 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 02:48:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Mar 2021 02:48:10 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 02:48:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDRWMhvUUHS4toK4rt2FgQFs0N701xTKQFgTw9jZ2UqkXR9csJWoGRBZOJgh4zaVc7DNcSSxSgWgSl08Q3/8yCRYZj2BqTCHHB9O/RWJj8zgNcaQguDdm4z1VjeQcmkessg9nft+1eMzCztRyXAv/kihiz3pjWPdCDYUQ16SEuvs4VaAjleO21u/WM0ANbrpKa68qimOOS5kx+fWRpQa2XroEEFQp1NBfS83B6/sL+BLSrU19ehxQemX6S6bjyfZZPAQBDCeE3cDCySpmpARqUmErpNyn+OjFXLoCILo2yJXKJtXeariMkP76LJ2kLoMTC2NTj68yxJtPrqISz5rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgwVw0Hj8WxzpgaC5uNep1fY4XZofVLXBNgD6zS+71g=;
 b=ZPeHB3xH3uGorTUP42oi5F0ylP1s9PY7aWiMGHyitW84rvsHIeanGKFhffwTT89mWlKmqVglvFT+cncRkFMO7XYclXWx31e1UW/CY5o2lab35+zcE7kl0NEk/85xNfDLvRTjQjCbNYv40SxSoeL62vjQuf64sMe5ws8nazBUAHpeH37LBNk41P2pdOXb6iVKfC2TX3WoIY/kMfFY4ulvBwVMLBzqmLixd0eLplb5ABp21gnbz9TW+tR188gPZEPwiJ1PH+DWSpd5vETUzXZJ1SRN57ojxgQl7giA6SrPAy05lzX2Qywablk1vrpwTM+aAadYXy6DAx7GyT9xZbMOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgwVw0Hj8WxzpgaC5uNep1fY4XZofVLXBNgD6zS+71g=;
 b=frKocWt+pul1EgNuzRK2KazMKYTS8iJ4/4/Yqmr7YyWMqlYditLmX8wxP2FiQ507zo8a3WmjVPjCwAdutLd4LIy7GFIGhUnqxyRGAYwLH1neHPNcKQQwwB5cPVqlO1hPP86avm82pnNQMOuOGl8lGUn/gqJjd+4gQUxfaKF9sL4=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB4863.namprd11.prod.outlook.com (2603:10b6:a03:2ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 10:48:08 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::c951:3ae4:1aca:9daf]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::c951:3ae4:1aca:9daf%3]) with mapi id 15.20.3890.023; Tue, 2 Mar 2021
 10:48:08 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: don't call netif_napi_add() with rxq->lock held
 (was Re: Lockdep warning in iwl_pcie_rx_handle())
Thread-Topic: [PATCH] iwlwifi: don't call netif_napi_add() with rxq->lock held
 (was Re: Lockdep warning in iwl_pcie_rx_handle())
Thread-Index: AQHXD0ZRst4T6GhNS06Vr+mACGRVqqpwhIKA
Date:   Tue, 2 Mar 2021 10:48:08 +0000
Message-ID: <716376e9cf4b0b459dbe72b8697c1e26ca7b6a9a.camel@intel.com>
References: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm>
         (sfid-20210301_215846_256695_15E0D07E)
 <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net>
         <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e13dcc6f-7438-466b-2661-08d8dd68ab06
x-ms-traffictypediagnostic: SJ0PR11MB4863:
x-ms-exchange-minimumurldomainage: spinics.net#7446
x-microsoft-antispam-prvs: <SJ0PR11MB486321E8D5F38EB6BB67103790999@SJ0PR11MB4863.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5Z1ods37Vy20i8yLDDqxkQv1DODtt8lIU8Ahg7ebp5JKqGwgCGZKrNas2/opEsAAsvdJlxmZMqvkkk4mo/5DgPYZq23RmkdxkdXJkDzOg4YgzaSRoI9Om7CYWSg8hi6eEtciI2U4iYByZT96YaHR83soTryj/+cGehOP5XgroMuzvrjvhUyunaY0CGpIDOP9hdV5nXKVpZfU7e00q3dvLRNdKfWgz2BNhKQBdeVdZ68YZku2Jws0EvM7Lt9hNkvW9+/WKLbkgVrgKUkv9CwSmWSmUC7cZCzWF3oSUuNv3WZAKq67+8qWSt81d6pboNZIuahoJm60ZruuLnVe60OQ5xLJcIoxU5B37RWrXRNTRkcUkA9XBgfD5O8uA4ZMIx9RhAY3HVZAnuEOKk6qn8Wn1DUxahcrRx6BddKQMdtWD7O5iODast99aqIANnUinbkiDB7YVYAK26adirOP0UpWNz5YeQ65O5+sHtGzRD7y4t++vC62Xw4rxhjNnDE0n+JLdTdbN4IfuSdIcsHZKDFnYRq3O24xaesqDoigrckyPOjK4zYF1aTAmSWATMDvhABUUJQJowRU4htztfI1VMCtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(346002)(366004)(110136005)(966005)(478600001)(36756003)(54906003)(8936002)(86362001)(316002)(83380400001)(6506007)(5660300002)(6486002)(6512007)(66946007)(76116006)(4326008)(26005)(66556008)(91956017)(66476007)(66446008)(64756008)(2906002)(71200400001)(2616005)(8676002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WU1kc0dHSWNXaGZwNTA3UjhnaGVXT3p4M0hTOEY0dkdlS3QwbUF4Zi9yKzgr?=
 =?utf-8?B?VHhuR3M0MWJydDNEcWpLclh5VTlkQTYwRDkwcFVrSGJCUFkyUkZtcnQyQXov?=
 =?utf-8?B?L1A5NGk3SEZCMld5SmFVM2pZemNUVW1LQVhlaUNHRzBmUEtQK3hJbktrQVo1?=
 =?utf-8?B?WVd2b0dYSlFUVkZiUDBwYjFBNVNjTDQydkhhUDdDNFdTWENpU3ZPNWJ4dzRE?=
 =?utf-8?B?WnB6SW5HYUxWSGFpZkQ4Nk0wMGFPOGVoZzZLSldtQ3I4dk1CcERYdU9IN0do?=
 =?utf-8?B?K2NlL0lYNE93c0l4OGdQSWRLbzBYcDFEQm5pQm91ZzNmYWRGZDl0U0E3S05W?=
 =?utf-8?B?UGtjWUMvMUZ6TmJhYjVHalg5Y1JGKzJHUHhaUmFkdjhaS2EwbzZYejJrL3gz?=
 =?utf-8?B?TnJONnpOV2VUUmE1OTh5d1gzOW9nbFM5UVorSFFJZHEvVm9MRmVHVDMxWndL?=
 =?utf-8?B?SUx3US9DV3ZlMkM1N1N4WDlBMFEzZVU3TWNUV2FKYW5INjU5NDgzWDlRd3B1?=
 =?utf-8?B?Mm1LakZpU0srNUpudDJsYkhZTDJWTGJteWlvWjVweWlmM1kyaXpiek1ndXJl?=
 =?utf-8?B?OGNESlNGZi9oekg2T1IxcnRmNEJIRHpUY0M2ZGlhT0toU014L2VoU0NpeUJl?=
 =?utf-8?B?cHlXUG1Tcm11TldCYkVTTVR0K296cjBSeU5Dc0hQQ1Q2ajJLY2JES0RhZVRK?=
 =?utf-8?B?YWdNOU51L1ZaKzlaUW1LTXNJYnIyaXZLaFdYMjlhd2dnRjVXRzNnbVljc01J?=
 =?utf-8?B?NmVOQ2g3OGV5bStzY0hvZUhpQkx6ZSt2YWM2b1FnU3dOQkxSeHFLck5kb2J4?=
 =?utf-8?B?MFByU1NvaTY3NXZQeGlkdzRGRUtRVkpwTWhaQ1p0TXJqU1RnVFZXZTlHWTl5?=
 =?utf-8?B?dG4vTUROWkIvQWs0aWlRYnRzQzh5b052MWFhQkhmSzZmU3dYdjZaQlFGQjFm?=
 =?utf-8?B?MjMrZHk0SzlkNWxuQVBVa3JxK0pPaytaYUV6VHdFYXphZ3VyaFMxcDZzS24y?=
 =?utf-8?B?M3lIS1JQaGk2UldCUHFYb0dJSVRjTDg4UHFxYTBHaktmQ3FQNlcwYlNlVVZo?=
 =?utf-8?B?WXF3YThRSU80N2JGOXhQWWY2aDhUYXdnczRsNXJaYzZVZVowbHNya01zLzAw?=
 =?utf-8?B?RFIvelhFV3ZOYm5HenVlQ3BCUVNKeUVaWVZjamFaeGI5c0gvL3FvODhreTdx?=
 =?utf-8?B?T1FKdGZnU211VkJsVUVaRWN4cTBnMUhZZTlvTjJlQnJ5V2RBOVJmbVNlSjRT?=
 =?utf-8?B?S1IzQXJURWV6QnhXa0pDMDM4Z01UWmVaaGY1ajJ3TjU0c1RkQVA1TlhjMGRY?=
 =?utf-8?B?RzF6Z0JKaU1MbWhmN3hTaWZ3WllwQ09rdGozMHBDbjdXZkN5bUZXcEM2K3BO?=
 =?utf-8?B?bUhwb0k4UFVudE1sTGNMTnkxek1GUlpMQnBTK1l0R0w2N0ZHVWdnRDJrek52?=
 =?utf-8?B?NGIyWllLTGtiL21VVkFtY28vdUVOZGhyRzgydEtrYWNLZ3Z4dHVLNFlzZGVT?=
 =?utf-8?B?aXpoc0V6NWppdFVsekxZemhGZG9uMS9jOUhWY1cxTlhqZHNrWjFiZ0FvUnFn?=
 =?utf-8?B?Nk9YVkFiZEVLeW52RXdLSjIxbWZDMkN4d1BSVWZySnJheG50dncrd1k5aXhX?=
 =?utf-8?B?bUlhUnh6NVMrRU1nQW5wZzNkY090bTdvMVFqaWF0dHkrR1k1MkxyWTY4dWI0?=
 =?utf-8?B?WVV4akoyb1RxSUhiSUtIUU9pblJtOVArbFloU3NtZXdYMVBwK0JCdC9DVWRm?=
 =?utf-8?B?WXd4MXd0V2tJb1Q5cGtQQkF6bnJ0Y3FodnRxcUVYUCtKMnA5dmJVN253MmhE?=
 =?utf-8?B?cFJHSjhndWtJQitQM2FVdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A61B9F8B1F1D9488C062B76D5637FF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13dcc6f-7438-466b-2661-08d8dd68ab06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 10:48:08.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FxQRWyGNSCyUUiq0o2M4uoamDaNuXn4JTqRwrlmUx9CBvxKwGWoVBLRdBDGw+Hn7KwzjGNGP8FVy/n4jgyFRE3T5WIvRH7lPGmzHDRo4PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4863
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTAyIGF0IDEwOjI3ICswMTAwLCBKaXJpIEtvc2luYSB3cm90ZToNCj4g
T24gTW9uLCAxIE1hciAyMDIxLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiANCj4gPiA+IEkgYW0g
Z2V0dGluZyB0aGUgc3BsYXQgYmVsb3cgd2l0aCBMaW51cycgdHJlZSBhcyBvZiB0b2RheSAoNS4x
MS1yYzEsIA0KPiA+ID4gZmUwN2JmZGEyZmIpLiBJIGhhdmVuJ3Qgc3RhcnRlZCB0byBsb29rIGlu
dG8gdGhlIGNvZGUgeWV0LCBidXQgYXBwYXJlbnRseSANCj4gPiA+IHRoaXMgaGFzIGJlZW4gYWxy
ZWFkeSByZXBvcnRlZCBieSBIZWluZXIgaGVyZToNCj4gPiA+IA0KPiA+ID4gCWh0dHBzOi8vd3d3
LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXdpcmVsZXNzL21zZzIwODM1My5odG1sDQo+ID4gPiAN
Cj4gPiA+IHNvIGJlZm9yZSBJIHN0YXJ0IGRpZ2dpbmcgZGVlcCBpbnRvIGl0ICh0aGUgcHJldmlv
dXMga2VybmVsIHRoaXMgDQo+ID4gPiBwYXJ0aWN1bGFyIG1hY2hpbmUgaGFkIGlzIDUuOSwgc28g
SSdkIHJhdGhlciBhdm9pZCBsZW5naHR5IGJpc2VjdCBmb3Igbm93IA0KPiA+ID4gaW4gY2FzZSBz
b21lb25lIGhhcyBhbHJlYWR5IGxvb2tlZCBpbnRvIGl0IGFuZCBoYXMgaWRlYXMgd2hlcmUgdGhl
IHByb2JsZW0gDQo+ID4gPiBpcyksIEkgdGhvdWdodCBJJ2QgYXNrIHdoZXRoZXIgdGhpcyBoYXMg
YmVlbiByb290LWNhdXNlZCBlbHNld2hlcmUgDQo+ID4gPiBhbHJlYWR5Lg0KPiA+IA0KPiA+IFll
YWgsIEknbSBwcmV0dHkgc3VyZSB3ZSBoYXZlIGEgZml4IGZvciB0aGlzLCB0aG91Z2ggSSdtIG5v
dCBzdXJlIHJpZ2h0DQo+ID4gbm93IHdoZXJlIGl0IGlzIGluIHRoZSBwaXBlbGluZS4NCj4gPiAN
Cj4gPiBJdCdzIGNhbGxlZCAiaXdsd2lmaTogcGNpZTogZG9uJ3QgYWRkIE5BUEkgdW5kZXIgcnhx
LT5sb2NrIiBidXQgcmlnaHQNCj4gPiBub3cgSSBjYW4ndCBmaW5kIGl0IGluIGFueSBvZiB0aGUg
cHVibGljIGFyY2hpdmVzLg0KPiANCj4gSSB3YXMgbm90IGFibGUgdG8gZmluZCB0aGF0IHBhdGNo
IGFueXdoZXJlIGluZGVlZCwgYnV0IGluIHRoZSBtZWFudGltZSBJIA0KPiBmaXhlZCBpdCBieSB0
aGUgcGF0Y2ggYmVsb3cuIFBsZWFzZSBjb25zaWRlciBtZXJnaW5nIGVpdGhlciBvZiB0aGUgZml4
ZXMuDQoNCkkgY2hlY2tlZCBteSBxdWV1ZSBhbmQgSSByZWFsaXplZCB0aGF0IHRoZSBwYXRjaCBK
b2hhbm5lcyBtZW50aW9uZWQgd2FzDQptYXJrZWQgYXMgYSBmaXggZm9yIGEgZml4IGFuZCBteSBz
Y3JpcHQgaGFkIGlzc3VlcyB3aXRoIHJlY3Vyc2l2ZQ0KZml4ZXMuICBJdCBub3JtYWxseSBzcXVh
c2hlcyBmaXhlcyB0byBwYXRjaGVzIGJlZm9yZSB0aGUgbGF0dGVyIGFyZQ0Kc2VudCBvdXQuICBN
eSBiYWQuDQoNCkthbGxlLCBwbGVhc2UgdGFrZSBKaXJpJ3MgdjIgdG8gd2lyZWxlc3MtZHJpdmVy
cy5naXQuICBJJ2xsIGdpdmUgbXkgYWNrDQpzZXBhcmF0ZWx5IGluIHJlcGx5IHRvIHYyLg0KDQot
LQ0KQ2hlZXJzLA0KTHVjYS4NCg==
