Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B538C258
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhEUI4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 04:56:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:32680 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhEUI4r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 04:56:47 -0400
IronPort-SDR: TulRORyV0ye1EbSCu3FsQ/nAy28Doo1KFGerVpM1MCFvW71R4KTqdEu6HJXHvRxGfT5k1ElTPg
 TDpiPGHTBetw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201477293"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201477293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 01:55:24 -0700
IronPort-SDR: 4yOKgkM0oiyyPo30Nx6LAjoLjtDj/NaHab1KCQi3XMgQ0/aSAV5ZudSLVcRG44SuOiDrsJAXHa
 tlFhA5LTZJdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440985232"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2021 01:55:24 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 01:55:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 01:55:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 21 May 2021 01:55:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 21 May 2021 01:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOHVVNafIMcbKjZGelXxXwfO8Lcs0IDlthn5x7ImrrgQcWEHmNXJwSVZoknVOEjyFDJBgtCnvTMZ9rhlTXzjnDG+DcvT//LpQRJT/mOX2DypozKCMvPreE9EX2578pvy4aY08r1S540/N9ksTT6dPWPHMIhsAhfBdTewRQst0qLMOoPmvR7hXjMAc9cYZ6z4Z8HRDDziYiBEemK4tGWogK5brsInoJoqUdEqR0iqC9qssg86Lk1cgZBrtHK37GLHQamBX9GN5k9c2mT1bB+A1keg3pZLa5SKkk2qH7AOBSF/jgzcRH+jKRGxZ1mV29z5Alhs3Cjz7BmV4Hf6zTHPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAsSAVR43ZH4EqiFVXYoD/SIkPHPctPZdUDKgiKSROQ=;
 b=h6p2X/TmYR/P2q9OrUp9YkyzjaPhewVFSU+PCHihkD/EU7igmOCJu+j2M9EgLDtpzrX+UOamVv2hiv4sF/LctE5R+USCFCotHWHNeRkyTKKtoR7aw8sTX0kAkK2jlcoCNz7OeXYFme7nKvQgaFkXhhJDzuUjGHZDtVnak/9x0F+7LQZaXPY3/l67Gy4ddJWLmgSs/sHsrQ2ha/eidNa3x2O40bIWllBRX0WODvkST0YmEU0gL/UsD+fAqNso5uZ6acb/n3RCtVw2v8dzutwxaK8RfdlltChk2NNTGLSZXksDzUfRw3dp+20/wTSUZ2b5Jdn+FarIwFn9VcPZPQVF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAsSAVR43ZH4EqiFVXYoD/SIkPHPctPZdUDKgiKSROQ=;
 b=b0SIwYEWBRgJYBjOSHA+zI8Z4Q0lqw7P+1D/I4/mAstrhy/adhpNlu4alCKoW2Ja32DM7E+ehnMRaui+yQEACfTjCTtc3NUa9UrGw40sIZjL9bCgQdPKhUtOsM3vJLUIxtV58+uCOc5WZBzo5ZR8trOn3RZBmLmeGiMsiwAsKm4=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 08:55:18 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::106d:d229:f71b:b34f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::106d:d229:f71b:b34f%4]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 08:55:18 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] mei: bus: add client dma interface
Thread-Topic: [PATCH v2 1/3] mei: bus: add client dma interface
Thread-Index: AQHXNgqNZRBBa8AhY0K+z1wI0CZfvKrt0PAAgAABBYA=
Date:   Fri, 21 May 2021 08:55:18 +0000
Message-ID: <dd4bf16bca499356a69ce17d53bd1cf5a331f3e3.camel@intel.com>
References: <20210420172755.12178-1-emmanuel.grumbach@intel.com>
         <E1lk0sb-0018Me-75@farmhouse.coelho.fi>
In-Reply-To: <E1lk0sb-0018Me-75@farmhouse.coelho.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09160d2a-1773-47fc-2e83-08d91c3628b9
x-ms-traffictypediagnostic: SJ0PR11MB5119:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB511906F474D8DFF2DF4D82FC90299@SJ0PR11MB5119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/23f8vxi5i7DrrHWWaCkn2tgOIv8M8Ai0DjXLPXXFkhWIB4Z0hzMpZx17vrQUtrSbzhLRtTqkaiVLwUXtbzF53EQ9n5CSr4XgsICNL4iiKxk/LblwA79KRFa1fvEAHOmZ9PvEB63Txtj4Mztmd16pJDJdMwMBjf55ADo5rMQdwujD/SL9mUxfvXubC7yiTNiTeQ8C2+BVhrmN9HcacmwKihPa/eP1sCxX7IQL0ZMxfZMfM+J9mSiSApQfIkWd5zA5sM4vBCoOuYP8QG9nNqJBzVzFknkfdxgSt4TY3o7sJMRb91PxmmtiVcNqV1VS6DwR/ZPkhZCVE+bZBUWM2OmfYNUi0O/suH814K0AmMt1WUG0qdHqjUVg+ucxvl9B3s3VvUG5Kh8VKg7VWmjHUfr5wkczFJO4HArBwkFC4jnfVvEvvACjKJOU/CBf2ybxbp3J1kWfnC4/lvVuoPhPeTXeYefUp/KdFeDT1j2pfZ/Wi1zforlyBGWNCmS1BeVSKG+HeDC4TJcqwe6kaZR/XujLUpGt5iAY00wlQNrH2vYSLqIY5EWWlJ+m1IrgQ2i5OlDrwLix1KFX+NK3PblYQ35JYuPGNJwt/mlrspoMhEW1o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(83380400001)(37006003)(2906002)(54906003)(71200400001)(6486002)(6862004)(6512007)(316002)(6636002)(86362001)(6506007)(66476007)(64756008)(4326008)(478600001)(38100700002)(122000001)(91956017)(2616005)(66946007)(36756003)(76116006)(66446008)(8676002)(66556008)(5660300002)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ekF4OVNXWVZ3ckEvNDVLM0hiOE5tdGNvSVBzeVNTYTNqZDNGVHRUZ1p1TDdx?=
 =?utf-8?B?cEhKbS9kNnNJNlQrZnlxKzNkdkFiSjdJZGIxVWJRNVBHRVJ0by8vZFRISDY0?=
 =?utf-8?B?SUJMUzU5Z0FDVUZoRlB0MFRFOEZObXk2aTFUdk10VTF6aksvSW56L3F3UFRM?=
 =?utf-8?B?M2g1SzFRYWswQVZWcDh4WUtqYkVHRElwT0l3MldYNmtheEUvcWpXM3JzMEcz?=
 =?utf-8?B?WmU5NzIycE1ZdWtpbHhpQkFKSkJiNnpCM3hlT1FaaWk4THBjOVBGUVorWFVr?=
 =?utf-8?B?OFdrSUFJSUFDTnhUbWp2dzkxcjFjRkZOUUxJNW83VjR5TEp3SS9ob216bHhz?=
 =?utf-8?B?SEtVT0FrbWRtditJUmt6aUN0ZnFSWXVtb0E1R1RPVEtDeFJDSlVGZEhSUTBY?=
 =?utf-8?B?NlNNNkxzbDI0bzIyeFY3RXhDeGdBUlpuZHVJWXNmMGkvMUdld0YyUUNGbUgz?=
 =?utf-8?B?WjcvZU1rUU43VWJSMFh5OXNmaXVIR0tHS1NYditDOE5udmhIa2wzNzFVY3Iv?=
 =?utf-8?B?Ly8vRW03WUR2dlpXVFFwVndKcHA5cmpQYXJReEV3TDY1OTFBVXFncWFVb0xW?=
 =?utf-8?B?WHM4QUhwNnJTb21pVmNsUmtCVE1CckRnbzdPTW5HNVF1U0Y5c0NBRFVoQUJP?=
 =?utf-8?B?UFd6VHEvU3F5ak1maDRWeWM1RVN4a3pubXN6dnAySVY3cFZ1UjhsQ1A0dEFB?=
 =?utf-8?B?Tm9oWFp2bU82eExqZVFzYWRiQzRLZ3l5RFRZUlF4SGh0UTdvaWxjU3RCU3lF?=
 =?utf-8?B?dnFPd0JuTEliVUhYYzNqRFBkQUtrR2c2Zk8rbDE2VWJqT0oranpEMnlPZTBv?=
 =?utf-8?B?SkhMRHJiM3ptZ1A3WTYvOERnczBRTVRQbVhZTkd1aXdwZmdjSGI2Y1RQLzlW?=
 =?utf-8?B?VXV0ZDh0UWFYUTlmUGxZbHh5cWlQVktMRXZyN2xQK1FKdElHeE5IeFh1TDNX?=
 =?utf-8?B?czVMRVhGWWZZMVRUdUFKNkRXcStlTzgxa0piMHM3WFdGVWNEL1crTnBMWkwz?=
 =?utf-8?B?N3RXTWdRajVlSm14V0YxNkxKSG5mY3Y5cXlreldBbGFRb3gwU1ljdDh3bVpR?=
 =?utf-8?B?NjRPZ1l4cnZMWWFvZXdKeDB3a1NwdnFOOHRzalo5NjRoUUJBbWp1WlduYnJk?=
 =?utf-8?B?VDMwVy8rRGxVU3pRT2lyMzZTdW8rN3A0Q2I5UW5NMmFGcFhrK3hhcjlTUzZh?=
 =?utf-8?B?S0dnZzFTeDZFSkdheWZ2SStsWHZmZnNKck1KajQ5WW9rRHBqb1ZSb25rblA4?=
 =?utf-8?B?N1c4c21aSDB5RnBDVDlLbHFVd1oyQmxnVE5MS2FCczIraDRwdVFMRkorNDJv?=
 =?utf-8?B?U1JOUmgrMUErdlJrMXA4TlJGSWhFSit1aVVSbzVlemM2dHdYVjlhNjBaVXpO?=
 =?utf-8?B?QnU3bU13cWF0MUQ4MjVIZVBzdjUwNHdBZTl6aXJEZHJRWnByMUc3VlgwZkt0?=
 =?utf-8?B?M0d5Q1VoSHdUNzJ4MHEzbWZZZmhqUDhlNmRpQXJJZ2w2U3BKRmdlaTVoSDFt?=
 =?utf-8?B?MlV0TnQxdWpNRHYwcEM2WFBENTYyaTl2QmloMU41MVdvb3E5S2diTmxzOGJL?=
 =?utf-8?B?ZURUcGxJMDd6S3ZGVEU1NHBaZThESUY5Vm5NejE1SVlNYnhQRVlaREs4THdK?=
 =?utf-8?B?ajJSODIrVytrMU5TL0dlMExnZE9aQ3ZYeExkNGZIQ1lkNnZOSXBEeldhUUJ3?=
 =?utf-8?B?aFdzaXYvbWdQYkRtSzJUU281RnZsVFZkdnY4UUZsTzg1KzZqKzk5ZW1lYmU2?=
 =?utf-8?Q?r3X5Jqxo9EKQemWmAvwaD8gtRKR/S5tngUIW7iY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56CA1387D16AE04793B08091162CB77D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09160d2a-1773-47fc-2e83-08d91c3628b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 08:55:18.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHp7ZjR4MXPGbOL9gcplHY+QJZ6YKkZYiPiEyo5JvmX4SxX/nRYj1Tw1xjLYg9VDHspands73Ddz+Z/jCn8zIv4HfxCw8vj3p0tmPKJ2ZP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTIxIGF0IDExOjUxICswMzAwLCBMdWNhIENvZWxobyB3cm90ZToNCj4g
RW1tYW51ZWwgR3J1bWJhY2ggPGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4gd3JvdGU6DQo+
IA0KPiA+IEZyb206IEFsZXhhbmRlciBVc3lza2luIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5j
b20+DQo+ID4gDQo+ID4gRXhwb3NlIHRoZSBjbGllbnQgZG1hIG1hcHBpbmcgdmlhIG1laSBjbGll
bnQgYnVzIGludGVyZmFjZS4NCj4gPiBUaGUgY2xpZW50IGRtYSBoYXMgdG8gYmUgbWFwcGVkIGJl
Zm9yZSB0aGUgZGV2aWNlIGlzIGVuYWJsZWQsDQo+ID4gdGhlcmVmb3JlIHdlIG5lZWQgdG8gY3Jl
YXRlIGRldmljZSBsaW5raW5nIGFscmVhZHkgZHVyaW5nIG1hcHBpbmcNCj4gPiBhbmQgd2UgbmVl
ZCB0byB1bm1hcCBhZnRlciB0aGUgY2xpZW50IGlzIGRpc2FibGUgaGVuY2Ugd2UgbmVlZCB0bw0K
PiA+IHBvc3Rwb25lIHRoZSB1bmxpbmsgYW5kIGZsdXNoIHRpbGwgdW5tYXBwaW5nIG9yIHdoZW4N
Cj4gPiBkZXN0cm95aW5nIHRoZSBkZXZpY2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZGVyIFVzeXNraW4gPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCj4gPiBDby1kZXZl
bG9wZWQtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRl
bC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVjYSBDb2VsaG8gPGx1Y2lhbm8uY29lbGhvQGlu
dGVsLmNvbT4NCj4gPiBBY2tlZC1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4NCj4gDQo+IDMgcGF0Y2hlcyBhcHBsaWVkIHRvIGl3bHdpZmktbmV4dC5n
aXQsIHRoYW5rcy4NCj4gDQo+IGQwZjJlZGRhMTY1MSBpd2x3aWZpOiBwY2llOiBkb24ndCBlbmFi
bGUgQkhzIHdpdGggSVJRcyBkaXNhYmxlZA0KDQpUaGlzIGNhbWUgb3V0IHdyb25nLiAgDQoNCj4g
ZmMwN2I4MzI4NmFmIG1laTogYnVzOiBhZGQgY2xpZW50IGRtYSBpbnRlcmZhY2UNCj4gMDlkZjhm
YTUwYmU4IGl3bHdpZmk6IG1laTogYWRkIHRoZSBkcml2ZXIgdG8gYWxsb3cgY29vcGVyYXRpb24g
d2l0aCBDU01FDQoNClRoaXMgb25lIHdhcyB0aGUgdGhpcmQgY29tbWl0IHRoYXQgd2FzIGFwcGxp
ZWQ6DQoNCjQzZDQwMGI3NWJiZiBpd2x3aWZpOiBpbnRlZ3JhdGUgd2l0aCBpd2xtZWkNCg0KLS0N
CkNoZWVycywNCkx1Y2EuDQo=
