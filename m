Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6535B40A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhDKMPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 08:15:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:27297 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKMO7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 08:14:59 -0400
IronPort-SDR: 6zy98OCVIpJfOZlqr0XJJKIuicKJR07F2SqiLMlet/WXUCfEv034/flQL6qsioN8wbZmanMdEh
 ahC40L/iA9Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="214475362"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="214475362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 05:14:43 -0700
IronPort-SDR: JBChhYvYp6QY2LWnPMYepAdI9bXmR9m9Nf9ccQv6RPQy7ZgJe3KVanIWiCR8OsCUqJaq942zES
 gTGtw8xYPHHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="449659151"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2021 05:14:43 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 11 Apr 2021 05:14:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 11 Apr 2021 05:14:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 11 Apr 2021 05:14:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibT5Hy0kf4ChYHD0w4xT3ptLkxOW+uGPZtwCi8yT0cAqGERvCnUXuRLT2iufGgHwbr8f6x4fvEYMRjfweleF8JU0SeYD/7XxjoQz9y0vaaP363au3VOvOVr3Y0aiHzzkiX6JbA4uUZy9UckNVWVQhT8k/L+MUJPIA9HMK3aky/JM75EHGddyPx/zBChB5OfJOYtng+G4BbTJPB1NpxThQRvbpq1iPGxjD1/bbGCFCgTEYHYGsX/Lm0rlgMpZOqpQXG0jODV4LcAcNC0JB6CCG/JcniEYqUkDGKRjgg+ugftRHQN/ptflwf4Gr3SOPTJLuJbdUvJlh348UVZ90ZU4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPmsXYnV3OJ3/j7YMvkqaccIsAcjtR8DSOLnY8hBci8=;
 b=TJ+0OW9SoAQgNkjwz75YiGBAnRjvxysX0P1u7OgoY5zlLk//48lYEcuoyMDa7LfDndpZCpGmeJ479e2tyNNJHEDOJUv6qx7UB4iKjPmU5Zu02EDgAEfz30y1TC7kZRofswPcjstQNHS6Ww7Y6Jv1lBj1p8RU8xwFg9N+85eCx0fTmcF6qSS/yrpaYRnTWq1UgsAvD0il7R16tuwa54NABk+qizJptePeK13uXzjhOZr+zq4kXD+AoL241AUx7BD7VkKpmiqWFhNLM6khld2SoovuRdQG0FXUZyqV8XRrHm95TfvdPbn89h81VxwcvOwpIzsSy83YeyGUIBom+hRnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPmsXYnV3OJ3/j7YMvkqaccIsAcjtR8DSOLnY8hBci8=;
 b=IDoEncpxo/c3JnaYWvpXoWDGMRdy9zv/0vymNlE7lLJAzQOYw6P9lK5ydwOx1H1vUvu94MSXHp9IEnz4NuoXB0BzoMMsCbNtBonZEsNOzs27DQ6+APrluxqEeZP94egV+xwyIVq6ekzH5thAlSxN2mDPb3B+UsJctDnqORDoO1c=
Received: from BN7PR11MB2610.namprd11.prod.outlook.com (2603:10b6:406:ab::31)
 by BN9PR11MB5353.namprd11.prod.outlook.com (2603:10b6:408:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 12:14:39 +0000
Received: from BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::5480:4536:4082:eae0]) by BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::5480:4536:4082:eae0%6]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 12:14:39 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Ben Greear <greearb@candelatech.com>, Luca Coelho <luca@coelho.fi>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Thread-Topic: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Thread-Index: AQHXJg5w+sLc3CukO06kSfTxTOYklaqd/7oAgBEn/cCAABSLAIAACi1w
Date:   Sun, 11 Apr 2021 12:14:38 +0000
Message-ID: <BN7PR11MB2610CE4FAF07FFB017E19AB0E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
References: <20210331091452.543321-1-luca@coelho.fi>
 <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
 <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
 <BN7PR11MB2610D9C80C698F837C3A2A55E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
 <eb60c152-81ac-2977-87fc-f724d4d6ccf0@candelatech.com>
In-Reply-To: <eb60c152-81ac-2977-87fc-f724d4d6ccf0@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: candelatech.com; dkim=none (message not signed)
 header.d=none;candelatech.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [147.236.145.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02380e89-590c-4ffb-5c66-08d8fce36163
x-ms-traffictypediagnostic: BN9PR11MB5353:
x-microsoft-antispam-prvs: <BN9PR11MB5353FDFE841C1A31D50E3CD7E9719@BN9PR11MB5353.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1uWddVIZhCdRTZ+91yJfoXblAml8khjeDhyVSKLVMzwtWOMeaFsYqERl1Ge4CM2vNZTh9iwf2d9z7RMIfpToiJ1tMasUT3uOWvSmiTmPXNMiT4kM4m9mdv5N/E1LAINCZz8yaz7EOQ2nP0SBVPi6DwD59XRSiwINGDXplIXWXapaxLCEoGJNSvQpJhDJO9a7qpE7N2KgsaqiX6X7zh7ZjzXfH4m4H8pEsoyCOR2+YiFTmSPEgGxtca22y1nwklpFctJvJYaxQZcMP2adi+cAW8Va8i4nONhsTAyuOuKV6gYgGglt4VQmHBDWxRNc1Gm7nldtcdivgnHyetTcieWVThJHPomFlHDU4vEvhmqiKXTIcZs/mNWoM55T4/7no55lxi7ak2a1K99XyKg4kpZp1pNJiBwBCw8bvi7bWjC/VJRDJfVxWWsxZbRMv8S6yRRShYxRadWbmdmodrEfP4hJ6z4Yu7I9DAo8eLwX/OPXmkhE7JBpqmhw1Uy5eFiQSbwr9h1JSnD9tpNakNd+5tToztjf5+fRQsJjyCsnLdLFUZxGv/+p96PoMAm6U8TWvzXuk2H20vOA8tjG5/D62AQghCkmi84fJLFqKPUk9aESzNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(76116006)(52536014)(33656002)(66574015)(66556008)(5660300002)(316002)(66446008)(38100700002)(7696005)(64756008)(66476007)(55016002)(8936002)(2906002)(71200400001)(86362001)(186003)(4326008)(26005)(83380400001)(110136005)(8676002)(6506007)(478600001)(66946007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z24rT0pZUndMSUV1Z1U1M2FId2RxNGl0clAvRXQ1TWdUNHdFQTdHblBodmtT?=
 =?utf-8?B?WDNRaTFFdHU0M1ByV2wrc000cGtiWjloUSttWkJlWUtVeW4rMzRnMzhKK00y?=
 =?utf-8?B?LzVyTTZGL2Frc1JOQkpPeHNZWE9qOWtHTTJRY3NhNER2eTROOGx3M3ZrR3Rr?=
 =?utf-8?B?ZHYwMkM4ZmNwc0RIa0xyUW1FK1pKcFBSdFcvRklXbXlJY2hPTEZ4OWdxWUlS?=
 =?utf-8?B?c0tkQjBVM0g0NCtlb240MmRwOXRUcURZOUtCU2E0eEVkVHhLVWRvOGdjdEdW?=
 =?utf-8?B?R1R3UldxUXRBUmw0K1BnSi9YMVU2bk41WXJyS2NpdXFmdkpYZC9scHhnZ1RW?=
 =?utf-8?B?OHd4akhxN0hSRHpVOEtESk9jRzI4WUVWbkE4K1crUnRWNWc0OXZJK2FlcGVk?=
 =?utf-8?B?TU9iaWF4d1J5WnZPYmg0ckZiRkJRVHhVS3NLc3JGMGFzek1sRWFzbVZ5TkNu?=
 =?utf-8?B?M1Z6TS9Calpvcm5lVmtHNUsvVko0MkpoRDFYRWZDcUtGMnluRnU2d0I4bWFO?=
 =?utf-8?B?VkpZN0w4WEEzemJ3b1hlWERFYUdoTzNIQjcwNVJLdmc2SDFnbVFpZXZyRngw?=
 =?utf-8?B?am1yd292RHY0SDFGUlZMam50UCtUUkQ5dUpYZHVxNGFCaVJtZlRHMXpMLzRR?=
 =?utf-8?B?QmdaQnpDSGhBNzlaYmxWVVFiV2FVY1FwbXpCU2g5QnRkL2RUc0dmR053ZSt3?=
 =?utf-8?B?WjFWd050THc0MGtmN25INkNMVUNhNFVUZ0xYa3poZjZQM1VySXdJaVdnYURF?=
 =?utf-8?B?VWNwU1BzdnFKM3BGTVJVOW5QOGJGcnlFNWFqN2pIT2Jpa1JLT2RRcHBFOGtw?=
 =?utf-8?B?RW90SGJFaHdoS0NLa256Z2tXSllYaVVIOVVXd0ZRZ1JhRUtRcFp5Wld3S04v?=
 =?utf-8?B?SUpENDMva1NzS2MrUEVlaTU0SHhqNG1ER3VHL283RmVkSVczZGUzTTl6bm91?=
 =?utf-8?B?cE9kUGFjRVRmUVRORGR5NjhCUU5TSy9Jcms4UVhmQWVFM1RlaUJ6bXdrYksr?=
 =?utf-8?B?bmlwNDBGYmdHd2w3NTZVOTRCV3E5YUJpd3hEZ0ExWXh2VDFVdDdSWlNxOW00?=
 =?utf-8?B?RzMzWnVWam83TlhKV2tyeHRLZm55QllxWm4zWE1KcXo5RGpiUG43MUFyRUdK?=
 =?utf-8?B?bFU1NWk3bDU2TzFpTXZ4U1liSTA1WUU4a1NHSGR6VFdwaVc4allMWXAxT0VI?=
 =?utf-8?B?VFg1cU1tYmJ4d1FKa1I3a0J6L3BaS1dsakJ4bXZtMVFSNFJ4L05HSlJ0cE9C?=
 =?utf-8?B?SUk5ZlhUbVN0ekp2bVBnY1BYaG13THYvRWpFK20yTENNUW9TRnJ0RkJCWjhi?=
 =?utf-8?B?ZTJOOWlqNm9xQmFySkxCbWRMK2lKNDNBSmc1enpmalpxdHRuUTNyb2Zpem9l?=
 =?utf-8?B?d3B4U0szMlpWd3VLdEZhT1lpemdWaDlCUURRS0RSVTlVWlIybUgrVklvSUZl?=
 =?utf-8?B?c0FzZG1GdStSYlpPTVFweU5OTlBEZlUyVGIxbzhSWjJQbEVoRGZkOVJVLzVn?=
 =?utf-8?B?am1aUkxaRFR2N0VRTXJadHBac21oaGpJK0JIeEFsRmxLdjhla2tLc3VoUDJG?=
 =?utf-8?B?elpBZlhwcmNuYmR1dlg5RWVSTjhPNElua0dpZzFZcW5IY1hkQUVXWG5waFJr?=
 =?utf-8?B?Nmd6WVZudHkzbmg5TzhsUmhURld1Y1Y0Rmh4N0Nib0NNV2tyK0JwZ2RNODlN?=
 =?utf-8?B?SFVkMllJZ0R2Y1dqWDk1aWtrTFd6ZUVTTlc5aVVjOW9ORGdadDJtTWU2UHoz?=
 =?utf-8?Q?Jcw14PJVz3B1Aal0WdA0LoiRv1ZH75ZsYuaBP1f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02380e89-590c-4ffb-5c66-08d8fce36163
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 12:14:39.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrmB0rVpjd4CFaiArVIOH+OJzJhlE9oziSdVtlqCRU9TU5V/5NBUDJJYKU95IRXxViWBHXiTFhrM8rg+qmyxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5353
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCj4gPiBUaGlzIGxvZ2ljIGVuYWJsZXMgYSBzcGVjaWFsICdwYXNzaXZlJyBzY2FuIHdo
aWNoIGlzIG5vdCBkaXJlY3RseQ0KPiA+IGludGVuZGVkIGZvciBkaXNjb3Zlcnkgb2YgQVBzIGZv
ciBjb25uZWN0aW9uIGV0Yy4gYnV0IGZvciBkaXNjb3Zlcnkgb2YNCj4gPiBBUHMgd2l0aCBjb3Vu
dHJ5IGluZm9ybWF0aW9uIGluIHRoZSBiZWFjb25zL3Byb2JlIHJlc3BvbnNlcywgc28gdGhlIGZ3
DQo+ID4gY291bGQgdXNlIHRoaXMgaW5mb3JtYXRpb24gYXMgYW4gaW5wdXQgdGhhdCBtaWdodCBh
bGxvdyBpdCB0byBlbmFibGUgNkdIeg0KPiBjaGFubmVscyAod2hpY2ggYXJlIHN1cHBvcnRlZCBi
dXQgYXJlIGRpc2FibGVkKS4gVGhpcyBzcGVjaWFsIHNjYW4gaXMgaW50ZW5kZWQNCj4gZm9yIGNh
c2VzIHRoYXQgdGhlIGRldmljZSBkb2VzIG5vdCBoYXZlIGFueSBvdGhlciByZWd1bGF0b3J5IGlu
Zm9ybWF0aW9uIHRoYXQNCj4gYWxsb3dzIGl0IHRvIGVuYWJsZSB0aGUgNkdIeiBjaGFubmVscy4N
Cj4gPiBPbmNlIHRoZXNlIGNoYW5uZWxzIGFyZSBlbmFibGVkLCB3ZSB1c2UgcGFzc2l2ZSBzY2Fu
IGFzIG5lZWRlZC4NCj4gPg0KPiA+IFdlIGdlbmVyYWxseSB0cnkgdG8gYXZvaWQgcGFzc2l2ZSBz
Y2FuIG9uIGFsbCB0aGUgNkdIeiBjaGFubmVscyBhcw0KPiA+IHRoaXMgaXMgYSBsb25nIGZsb3cg
dGhhdCB0YWtlcyBhdCBsZWFzdCA2IHNlY29uZHMgKGFzIHRoZXJlIGFyZSBzdWNoIDY0DQo+IGNo
YW5uZWxzKSBhbmQgd2l0aCB0aGUgZGlzY292ZXJ5IG1lY2hhbmlzbXMgZGVmaW5lZCBmb3IgdGhl
IDZHSHogaXMgbm90DQo+IHJlYWxseSBuZWVkZWQuDQo+IA0KPiBJZiB0aGUgc3RhdGlvbiBjb21l
cyB1cCBhbmQgZG9lcyBhIDZFIHBhc3NpdmUgc2NhbiBhbmQgZG9lcyBub3QgZmluZCBhbnkgQVAs
DQo+IHBlcmhhcHMgYmVjYXVzZSA2R2h6IEFQIHdhcyB0dXJuZWQgb24gMSBtaW51dGUgYWZ0ZXIg
dGhlIHN0YXRpb24gdHJpZWQgdG8NCj4gaW5pdGlhbGx5IHNjYW4sIHRoaXMgbWVhbnMgdGhhdCBp
dCB3aWxsIHRha2UgNTAgbWludXRlcyBiZWZvcmUgaXQgY2FuIGhhdmUgYQ0KPiBjaGFuY2UgdG8g
c2NhbiB0aGUgQVAgYW5kIGNvbm5lY3QgdG8gdGhlIEludGVybmV0PyAgSWYgc3RhdGlvbiBjYW5u
b3QgY29ubmVjdA0KPiBhZnRlciBhIHJlbGF0aXZlbHkgc2hvcnQgdGltZSwgdGhlbiBJIHRoaW5r
IGl0IHNob3VsZCBzY2FuIGFzIHdpZGVseSBhcyBpdCBjYW4gaW4NCj4gb3JkZXIgZmluZCBzb21l
IHBvc3NpYmxlIHdheSB0byBjb25uZWN0Lg0KPiANCg0KVGhlIHB1cnBvc2Ugb2YgdGhpcyBoZXVy
aXN0aWMgd2FzIHRvIGhhbmRsZSBhIHZlcnkgc3BlY2lmaWMgY29ybmVyIGNhc2Ugd2hlcmUgdGhl
cmUgYXJlDQpubyBBUHMgb24gdGhlIDJHSHovNUdIeiBiYW5kcyBhbmQgdGhlcmUgYXJlIG9ubHkg
b25lIG9yIG1vcmUgbm9uLWNvbGxvY2F0ZWQgQVBzDQpvbiB0aGUgNkdIeiBiYW5kLiBCYXNlZCBv
biBvdXIgdW5kZXJzdGFuZGluZywgdGhpcyBpcyBub3QgYSB2ZXJ5IGxpa2VseSBzaXR1YXRpb24g
YW5kIHRodXMsDQpkdWUgdG8gb3RoZXIgY29uc2lkZXJhdGlvbiBlLmcuLCBwb3dlciBLUElzIGV0
Yy4sIHRoZSBhYm92ZSBjb25kaXRpb25zIHdlcmUgZGVmaW5lZC4gSG93ZXZlciwNCmFzIHlvdSBj
YW4gc2VlIGluIHRoZSBwYXRjaCwgdGhlcmUgYXJlIG9wdGlvbnMgdG8gdHVuZSB0aGUgaGV1cmlz
dGljIHRvIGJlIG1vcmUgYWdncmVzc2l2ZSwNCmFuZCBpZiBpdCB3b3VsZCBpbmRlZWQgYmUgbmVl
ZGVkIHdlIGNhbiBjaGFuZ2UgdGhlIGJlaGF2aW9yIHN1Y2ggY2FzZXMuDQoNCj4gQW5kIHdoeSBj
YXJlIGFib3V0ICdhdCBsZWFzdCA0IGNoYW5uZWxzJy4gIElmIHdlIGtub3cgdGhlIEFQIGNoYW5u
ZWwsIGFuZCBjYW4NCj4gc2NhbiBleGFjdGx5IHRoZXJlLCB0aGVuIHlvdXIgY29uY2VybiBhYm91
dCB0YWtpbmcgYSBsb25nIHRpbWUgaXMgcmVzb2x2ZWQuDQo+IA0KDQpUaGUgYXNzdW1wdGlvbiB3
YXMgdGhhdCB3aGlsZSBhIGNvbm5lY3Rpb24gd2FzIG5vdCBlc3RhYmxpc2hlZCBhIGZ1bGwgc2Nh
bg0KaXMgZXhwZWN0ZWQsIHNvIHRoYXQncyB3aHkgdGhlIGFib3ZlIGNvbmRpdGlvbiB3YXMgc2V0
LiBIb3dldmVyLCBJJ2xsIHRha2UgdGhpcw0Kd2l0aCBteSBjb2xsZWFndWVzIGFuZCBzZWUgaWYg
dGhpcyBjb25kaXRpb24gY2FuIGJlIHJlbW92ZWQgb3IgZGVmaW5lZA0KZGlmZmVyZW50bHkuIA0K
DQo+IEhvdyBlbHNlIGNhbiB3ZSB0ZWxsIHRoZSByYWRpbyB0aGF0IDZFIGlzIGFsbG93ZWQ/ICBJ
IHByZXZpb3VzbHkgdHJpZWQgYWxsIHNvcnRzIG9mDQo+IHRoaW5ncyB0byBlbmFibGUgNkUgY2hh
bm5lbHMgc28gdGhhdCBJIGNvdWxkIG1vcmUgZWFzaWx5IHNldCB0aGUgcmFkaW8gdG8gc25pZmYN
Cj4gb25lIG9mIHRob3NlIGNoYW5uZWxzIGluIG1vbml0b3IgbW9kZSwgYW5kIEkgaGFkIG5vIGx1
Y2suDQo+IA0KDQpBcmUgeW91IGFza2luZyBzcGVjaWZpY2FsbHkgZm9yIGl3bHdpZmkgZGV2aWNl
cz8gSSdtIG5vdCBmYW1pbGlhciB3aXRoIGEgc2ltcGxlDQp3YXkgdG8gZG8gc28gb3RoZXIgdGhl
IG9uZSBkZXNjcmliZWQgaGVyZSwgYnV0IEkgY2FuIGNoZWNrIGlmIHlvdSBuZWVkIGl0Lg0KDQo+
IElmIGFsbCBvZiB0aGUgNkUgY2hhbm5lbHMgYXJlIG1hcmtlZCBhcyBwYXNzaXZlLCB3aGF0IGhh
cm0gaXMgaXQgdG8gZW5hYmxlIHRoZQ0KPiBjaGFubmVscyBpbiB0aGUgcmVnZG9tIGZyb20gdGhl
IGJlZ2lubmluZz8NCj4gDQoNCkFGQUlLLCBhcyB0aGUgNkdIeiByZWd1bGF0b3J5IGlzIHN0aWxs
IGV2b2x2aW5nLCB3ZSBhcmUgbm90IHlldCBhbGxvd2VkIHRvIGRvIHNvLiBCdXQgb25jZSBhZ2Fp
biwNCklmIHlvdSBhcmUgaW50ZXJlc3RlZCBJIGNhbiBmdXJ0aGVyIGNoZWNrIHRoaXMgb3VyIHJl
Z3VsYXRvcnkgdGVhbS4gDQoNClJlZ2FyZHMsDQoNCklsYW4uDQo=
