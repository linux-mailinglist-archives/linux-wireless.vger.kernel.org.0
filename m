Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C063C7FE9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhGNIWO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 04:22:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:14608 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238043AbhGNIWN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 04:22:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210350683"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210350683"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="487868267"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2021 01:19:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 01:19:20 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 01:19:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 14 Jul 2021 01:19:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 14 Jul 2021 01:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHtDkqECQ62ES06nlaHWN9BwaQ4/flZ/X4EoTlX7s/0CDDK/W/ryDizKP7+dHUaWByknGjZqLtFcUlbQXdwsInB43BD9Z1+kO/pBe7fczTwfD2pDDwD4XZedBPz2MnL/IOVxadqcpsqa8K/2dCAyiORuP8d2uNq3+0fidkdTMSBf4MbkVqISkOFXDVb7TAhrOq1FUljRIMu++HSkMyiR6KRYFHSRTN0FGS27EE4hHSDKpeIdgvJKk2eS4KPQTRh3bE+N0MUqjnZVMBrXLAKJKHJe0rrahOCZFPKXWDkqaH/6k+TN6Q4OdBO/USWSi+IKkU/XU7qEUGzeUFw+nv7sOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljX+6m0DXFSBvF13SV2eYNilhq7a2r0gQVeCSxxf2QI=;
 b=YI3Jsj2dgTr+vbGra/RIbKaCSvc1ZZT/6D0pv2Z/pijmEOQgEtN3uR9XmFMLd0Gih9caFeHeatdldj4lj/ogqdnexfxWLcIXfPbEftoMZjN0fGfu7m+lKFJX7LObtWjHIs43gL5FT7qwWLAXchcGRGnM564LTqQQWz8yr9H8Fm3yElBE8F/JbjgOS9180CC4WvZfILV7NB8a6U0B7txHIQChq0+dDW8I4TKQVk3F97vABLQqDHhGkg3bsZ03g/uFF3XK5ddMO1amTxqHn/vy6fbngKQEkERyDAKEDRktjym9IF3Si9Havt00ugTBxTFyt1srQdkYkhX4l3o3xtdjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljX+6m0DXFSBvF13SV2eYNilhq7a2r0gQVeCSxxf2QI=;
 b=UwAVitbP0Nn/rY13p2mJILysRzFR8PvZFszb/OtKcatq93wIW5GyKPQ0nrLAxq6hTM8tCInqWlHGTqkhzvV36gStUg79i7rrDWv5ujHzL0UPgFHjq4rqJUqkYVcO3vflleulrOJ0uYSnyCvRgRFlbiElsiIl8+9U2b95v7GXwyQ=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 08:19:19 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::598d:cc4e:321f:9156]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::598d:cc4e:321f:9156%6]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:19:18 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
CC:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: RE: [PATCH v4 1/5] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Topic: [PATCH v4 1/5] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Index: AQHXaZqMayk6BhOJ+0qHDsOgyT0gIasq/keAgBdAKVA=
Date:   Wed, 14 Jul 2021 08:19:18 +0000
Message-ID: <SA0PR11MB4752FADFD3AD40C22A5C533BF2139@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210625081717.7680-1-emmanuel.grumbach@intel.com>
 <CANUX_P2sw2bzhUrUC_QTZY1+YA+EyoZn3QeoQvv6=e3L4WHvuw@mail.gmail.com>
In-Reply-To: <CANUX_P2sw2bzhUrUC_QTZY1+YA+EyoZn3QeoQvv6=e3L4WHvuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2d3db66-620b-4f2d-a91f-08d946a013bb
x-ms-traffictypediagnostic: SA2PR11MB5003:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB500366AA93DB27ADBEF8DB97F2139@SA2PR11MB5003.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtr73c6IkCwqkrzGOrjrh4VlMXD0jQYtXJJALP1AyGXGTrhVgMvtOnzjs4NpsMCh+Z8U/NObXZIsFojdEppJOGNoS9kskyGAOU2evpJn9B+V/PEwbPvUoQm6d8jYRuY/C9KpLlxf9HK9894Na4JupTGp3sdYg7CgC1ZYXWIuasycppE3fvhJh5ygk86yU8r86VXvagTwlNGE0Cku3FYYACRPquFVfVJq/H498RJLkvHGoWL0eChtKsEj8MNPZm7+XAXmj8L5mNYVTWUxxKZL/ZqZ5drUDjA5UOMLWkky9xLW74E321COeIoZ7Kvj7m9/zzPHIfHAg1l2oOk+90HdYvfxml1uPqove5c1f2hN6TFq2WsJ/JYyx+G9Qkgx0Ds5ui5wyOnHPPdtCVK+o7yavisjHZZUspTWr5fz2mbcFpW2pX98D8N/NlaFUbnLq1ZozqVgJeONhTgIhxumykvfBx2W9svncamKJYgUH3LWer9yvHlMWSMtnhSveu+xKgg1MK8b4K6jpPUne1cizl+9zuZFWdS1v7ZdqzbIVaxO0/WeZwvXNQ6TFMqaYdFWjmQHQRfSjlH4bmXXSSJTSwWhhhyFn6ysK8q9Kzio/jpFdDVyumLOESLVyPyGzuIJFwXzHiDd70ypjRxX867FHtG9JV+MaxtEk3UPRmeyFiELvC/4lZXWS7QLJzk9fwZAcGB58xtahGN8hHsyz0Cycnfjnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(33656002)(86362001)(54906003)(6506007)(26005)(7696005)(122000001)(38100700002)(186003)(83380400001)(5660300002)(71200400001)(478600001)(66946007)(55016002)(66446008)(9686003)(316002)(2906002)(76116006)(52536014)(66556008)(66476007)(64756008)(8936002)(107886003)(8676002)(6916009)(4326008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE9yRmZwOTlDS3llZ1RseFdXYTgzU3VPTEVWTGt0OHluZmN2OWtMaWRHSnFT?=
 =?utf-8?B?bXlyZExla01wSmdLYjBiNk5kWFVweGN3T05qYmxsZC9EdG5UcHM4ZjRxN1Fu?=
 =?utf-8?B?dFZURGVzWks0Z3ZudCtTSWlrZU1tcXQ3RGIyL093VlRHOEViZ1hkZ3pEandl?=
 =?utf-8?B?S2dmWjBxdngxK01QWTVEK1ZMNmlwSzhPbXlVU1UxZ0haby9rVGxhRXcrQ3lt?=
 =?utf-8?B?azFTNmRTKzEyR0t2WVJJRGdFSWdsY3lYRVJ6M05NcmhZdzExbTRqcWM1dzNQ?=
 =?utf-8?B?TFU4dUVTME40ckNtS3hrb3Jnbi9DdVVWb29YMlBoR2lyUitjWTBDMEkwbmZV?=
 =?utf-8?B?UkNpbDBOUU9LaDNmL3BoUU43OVBrcGNRNkpDVFpVL0RWOTlPSG0wblhXNGNG?=
 =?utf-8?B?MVhJNTZnKzNLMVQ3VGNZck1lcmpWRGVsTStoUEFub3htaHFMVnMvU1pvMEU3?=
 =?utf-8?B?Tnd0S1krUG9jWVFNZXZIYnNyQWRUdXRkY2M5NGhTdk9RRFhZdnpiT3A3SC9q?=
 =?utf-8?B?clF0cUtURnVPeUpRMEVwejVQOXAzM0c0alhyd1g5Y0RyR0RMQXlBeGNMUFht?=
 =?utf-8?B?cDhJWHk3a2xJSTFvQ1JhU3diZ3FYZXNVU0E2RTdpTnJITFdUT1dRVnhnOHdZ?=
 =?utf-8?B?aXRkVWJpL1k3T294RTJnanQyWm14czY4bXVvSHVqbWt5UGNVQVp3a3pHRzZF?=
 =?utf-8?B?MzZFWlk4ZWpHM00wVThCbmJNNGx6bzdwOE5FaXY2ZURkWk81WUZhdnU1MHpX?=
 =?utf-8?B?SVlUdTRHWER6N1FIbTVZMHc5Nm1aejhTYzhXdDliRkcvR2dBWEUyS0E0d2w4?=
 =?utf-8?B?dGVjTUdFNW44LzNrSG4vYkVDVzRSeUVDdGRRME1GWEVpWUpBb2UyaEIyY09I?=
 =?utf-8?B?bDZrcnRBZWcvNXlzOEFJRW96eVNUNVVUaHVDVGRET0w0NzdLY0IxSWJpTDRK?=
 =?utf-8?B?VEZXeE9zMnFNbkZGaHpOZUhXc3JtUDdoTzlGT1A2eVorVjFjWGdYR1p6UWl2?=
 =?utf-8?B?MlFKZWZhMG5iYk83cVIrbHRSNTBKZzVUejU4cVE2Mm1YZzlUeFk0TWpMZWVm?=
 =?utf-8?B?dDIyeW5ZcG9kbWtVeGpqbUhxLzhWV1Y2V0dycVNsSFA4b3lvcDFTcXlYN3hC?=
 =?utf-8?B?ZnlyZ2VsVjVyUTNQb2xqK1UyOXpqOHdTNnF4WDR1a1BUTE1aZkxBN3p4QkRV?=
 =?utf-8?B?TCtaSDV1WXkwWG95MG14ZWFVQUpTcy9UQ0JEYWU1RGtPSXhkcWJJVkltR090?=
 =?utf-8?B?cyt0SjgrdWlnU1hCNXRGazRDSVo5TkhLZzZNd1lpeHJvaTQyZ0JWclg5NlhM?=
 =?utf-8?B?TytDaTR3bmcxeWhKRTVLZEk0cEJuR0oyS0paYURyWTdxcUZlMWFKU0hTcXdl?=
 =?utf-8?B?emszQkFpaUovOEdrK2w3Vi9QWnJGa0M1SlU2OEIrZEp5R3E3MDI1SGZTYzkz?=
 =?utf-8?B?czI5OVpNdTJOclVNR3FzSjkwMDdNS1grelpxTFgrVk1oZkhEaUFzQzdBWGJN?=
 =?utf-8?B?RVlobkRpZ1R4T3hEY093WGNXR2JVK0xxWDBiVFNFcXNHMEk1ZzNXYzh3Smhv?=
 =?utf-8?B?dHQ1SW9VVkM5c2ZWaWdEYmNpazNJc1Izdk1Sc1VaOFhPbE51ZlFzRThFTjd3?=
 =?utf-8?B?djgwYVkxQnk5akwxOVBldXJYV3dyUXZDWWtjcWRpUmIxcm9DSHBTZHNKbWd0?=
 =?utf-8?B?Z2ZNVDFScERLZVkzbWt4T0xXbHhsaXRYNUpYZ1pGaFVWUTBPZGlOdnBjZkxv?=
 =?utf-8?Q?GZnJLpNZWJDEJRefOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d3db66-620b-4f2d-a91f-08d946a013bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 08:19:18.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nf3ec9Gosw4BIuP98meftVPvuw+Qd+lDTWw6ugrKi9yJKQxAwYHlnsv8Sue04SQpKwaRfIj2VDAwstqw5pNRTuk8q/OLVD+3WlkCjry8UyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiA+DQo+ID4gQ1NNRSBpbiB0d28gd29yZHMNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IENT
TUUgc3RhbmRzIGZvciBDb252ZXJnZWQgU2VjdXJpdHkgYW5kIE1hbmFnZW1lbnQgRW5naW5lLiBJ
dCBpcyBhIENQVQ0KPiA+IG9uIHRoZSBjaGlwc2V0IGFuZCBydW5zIGEgZGVkaWNhdGVkIGZpcm13
YXJlLg0KPiA+IEFNVCAoQWN0aXZlIE1hbmFnZW1lbnQgVGVjaG5vbG9neSkgaXMgb25lIG9mIHRo
ZSBhcHBsaWNhdGlvbnMgdGhhdCBydW4NCj4gPiBvbiB0aGF0IENQVS4gQU1UIGFsbG93cyB0byBj
b250cm9sIHRoZSBwbGF0Zm9ybSByZW1vdGVseS4NCj4gPiBIZXJlIGlzIGEgcGFydGlhbCBsaXN0
IG9mIHRoZSB1c2UgY2FzZXM6DQo+ID4gKiBWaWV3IHRoZSBzY3JlZW4gb2YgdGhlIHBsYWZvcm0s
IHdpdGgga2V5Ym9hcmQgYW5kIG1vdXNlIChLVk0pDQo+ID4gKiBBdHRhY2ggYSByZW1vdGUgSURF
IGRldmljZQ0KPiA+ICogSGF2ZSBhIHNlcmlhbCBjb25zb2xlIHRvIHRoZSBkZXZpY2UNCj4gPiAq
IFF1ZXJ5IHRoZSBzdGF0ZSBvZiB0aGUgcGxhdGZvcm0NCj4gPiAqIFJlc2V0IC8gc2h1dCBkb3du
IC8gYm9vdCB0aGUgcGxhdGZvcm0NCj4gPg0KPiA+IE5ldHdvcmtpbmcgaW4gQ1NNRQ0KPiA+IC0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+IEZvciB0aG9zZSB1c2VzIGNhc2VzLCBDU01FJ3MgZmlybXdh
cmUgaGFzIGFuIGVtYmVkZGVkIG5ldHdvcmsgc3RhY2sNCj4gPiBhbmQgaXMgYWJsZSB0byB1c2Ug
dGhlIG5ldHdvcmsgZGV2aWNlcyBvZiB0aGUgc3lzdGVtOiBMQU4gYW5kIFdMQU4uDQo+ID4gVGhp
cyBpcyB0aGFua3MgdG8gdGhlIENTTUUncyBmaXJtd2FyZSBXTEFOIGRyaXZlci4NCj4gPg0KPiA+
IE9uZSBjYW4gYWRkIGEgcHJvZmlsZSAoU1NJRCAvIGtleSAvIGNlcnRpZmljYXRlKSB0byB0aGUg
Q1NNRSdzIE9TIGFuZA0KPiA+IENTTUUgd2lsbCBjb25uZWN0IHRvIHRoYXQgcHJvZmlsZS4gVGhl
biwgb25lIGNhbiB1c2UgdGhlIFdMQU4gbGluayB0bw0KPiA+IGFjY2VzcyB0aGUgYXBwbGljYXRp
b25zIHRoYXQgcnVuIG9uIENTTUUgKEFNVCBpcyBvbmUgb2YgdGhlbSkuIE5vdGUNCj4gPiB0aGF0
IENTTUUgaXMgYWN0aXZlIGR1cmluZyBwb3dlciBzdGF0ZSBhbmQgcG93ZXIgc3RhdGUgdHJhbnNp
dGlvbnMuDQo+ID4gRm9yIGV4YW1wbGUsIGl0IGlzIHBvc3NpYmxlIHRvIGhhdmUgYSBLVk0gc2Vz
c2lvbiBvcGVuIHRvIHRoZSBzeXN0ZW0NCj4gPiB3aGlsZSB0aGUgc3lzdGVtIGlzIHJlYm9vdGlu
ZyBhbmQgYWN0dWFsbHkgY29uZmlndXJlIHRoZSBCSU9TIHJlbW90ZWx5DQo+ID4gb3ZlciBXTEFO
IHRoYW5rcyB0byBBTVQuDQo+ID4NCj4gPiBIb3cgYWxsIHRoaXMgaXMgcmVsYXRlZCB0byBMaW51
eA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gSW4gTGludXgsIHRo
ZXJlIGlzIGEgZHJpdmVyIHRoYXQgYWxsb3dzIHRoZSBPUyB0byB0YWxrIHRvIHRoZSBDU01FDQo+
ID4gZmlybXdhcmUsIHRoaXMgZHJpdmVyIGlzIGRyaXZlcnMvbWlzYy9tZWkuIFRoaXMgZHJpdmVy
IGFkdmVydGlzZXMgYQ0KPiA+IGJ1cyB0aGF0IGFsbG93cyBvdGhlciBrZXJuZWwgZHJpdmVycyBv
ciBldmVuIHVzZXINCj4gPiBzcGFjZSkgdG8gdGFsayB0byBjb21wb25lbnRzIGluc2lkZSB0aGUg
Q1NNRSBmaXJtd2FyZS4NCj4gPiBJbiBwcmFjdGljZSwgdGhlIHN5c3RlbSBhZHZlcnRpc2VzIGEg
UENJIGRldmljZSB0aGF0IGFsbG93cyB0byBzZW5kIC8NCj4gPiByZWNlaXZlIGRhdGEgdG8gLyBm
cm9tIHRoZSBDU01FIGZpcm13YXJlLiBUaGUgbWVpIGJ1cyBkcml2ZXJzIGluDQo+ID4gZHJpdmVy
cy9taXNjL21laSBpcyBhbiBhYnN0cmF0aW9uIG9uIHRvcCBvZiB0aGlzIFBDSSBkZXZpY2UuDQo+
ID4gVGhlIGRyaXZlciBiZWluZyBhZGRlZCBoZXJlIGlzIGNhbGxlZCBpd2xtZWkgYW5kIHRhbGtz
IHRvIHRoZSBXTEFODQo+ID4gZHJpdmVyIGluc2lkZSB0aGUgQ1NNRSBmaXJtd2FyZSB0aHJvdWdo
IHRoZSBtZWkgYnVzIGRyaXZlci4NCj4gPiBOb3RlIHRoYXQgdGhlIG1laSBidXMgZHJpdmVyIG9u
bHkgZ2l2ZXMgYnVzIHNlcnZpY2VzLCBpdCBkb2Vzbid0DQo+ID4gZGVmaW5lIHRoZSBjb250ZW50
IG9mIHRoZSBjb21tdW5pY2F0aW9uLg0KPiA+DQo+ID4gV2h5IGRvIHdlIG5lZWQgdGhpcyBkcml2
ZXI/DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBDU01FIHVzZXMgdGhlIHNh
bWUgV0xBTiBkZXZpY2UgdGhhdCB0aGUgT1MgaXMgZXhwZWN0aW5nIHRvIHNlZSBoZW5jZQ0KPiA+
IHdlIG5lZWQgYW4gYXJiaXRyYXRpb24gbWVjaGFuaXNtLiBUaGlzIGlzIHdoYXQgaXdsbWVpIGlz
IGluIGNoYXJnZSBvZi4NCj4gPiBpd2xtZWkgbWFpbnRhaW5zIHRoZSBjb21tdW5pY2F0aW9uIHdp
dGggdGhlIENTTUUgZmlybXdhcmUncyBXTEFODQo+ID4gZHJpdmVyLiBUaGUgbGFuZ3VhZ2UgLyBw
cm90b2NvbCB0aGF0IGlzIHVzZWQgYmV0d2VlbiB0aGUgQ1NNRSdzDQo+ID4gZmlybXdhcmUgV0xB
TiBkcml2ZXIgYW5kIGl3bG1laSBpcyBPUyBhZ25vc3RpYyBhbmQgaXMgY2FsbGVkIFNBUCB3aGlj
aA0KPiA+IHN0YW5kcyBmb3IgU29mdHdhcmUgQWJyaXRyYXRpb24gUHJvdG9jb2wuDQo+ID4gV2l0
aCBTQVAsIGl3bG1laSB3aWxsIGJlIGFibGUgdG8gdGVsbCB0aGUgQ1NNRSBmaXJtd2FyZSdzIFdM
QU4NCj4gPiBkcml2ZXI6DQo+ID4gMSkgUGxlYXNlIGdpdmUgbWUgdGhlIGRldmljZS4NCj4gPiAy
KSBQbGVhc2Ugbm90ZSB0aGF0IHRoZSBTVy9IVyByZmtpbGwgc3RhdGUgY2hhbmdlLg0KPiA+IDMp
IFBsZWFzZSBub3RlIHRoYXQgSSBhbSBub3cgYXNzb2NpYXRlZCB0byBYLg0KPiA+IDQpIFBsZWFz
ZSBub3RlIHRoYXQgSSByZWNlaXZlZCB0aGlzIHBhY2tldC4NCj4gPiBldGMuLi4NCj4gPg0KPiA+
IFRoZXJlIGFyZSBtZXNzYWdlcyB0aGF0IGdvIHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24gYXMgd2Vs
bDoNCj4gPiAxKSBQbGVhc2Ugbm90ZSB0aGF0IEFNVCBpcyBlbi9kaXNhYmxlLg0KPiA+IDIpIFBs
ZWFzZSBub3RlIHRoYXQgSSBiZWxpZXZlIHRoZSBPUyBpcyBicm9rZW4gYW5kIGhlbmNlIEknbGwg
dGFrZQ0KPiA+ICAgIHRoZSBkZXZpY2UgKm5vdyosIHdoZXRoZXIgeW91IGxpa2UgaXQgb3Igbm90
LCB0byBtYWtlIHN1cmUgdGhhdA0KPiA+ICAgIGNvbm5lY3Rpdml0eSBpcyBwcmVzZXJ2ZWQuDQo+
ID4gMykgUGxlYXNlIG5vdGUgdGhhdCBJIGFtIHdpbGxpbmcgdG8gZ2l2ZSB0aGUgZGV2aWNlIGlm
IHRoZSBPUw0KPiA+ICAgIG5lZWRzIGl0Lg0KPiA+IDQpIFBsZWFzZSBnaXZlIG1lIGFueSBwYWNr
ZXQgdGhhdCBpcyBzZW50IG9uIFVEUCAvIFRDUCBvbiBJUCBhZGRyZXNzDQo+ID4gICAgWFguWFgu
WFguWFggYW5kIGFuIHBvcnQgWlouDQo+ID4gNSkgUGxlYXNlIHNlbmQgdGhpcyBwYWNrZXQuDQo+
ID4gZXRjLi4uDQo+ID4NCj4gPiBQbGVhc2UgY2hlY2sgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tZWkvc2FwLmggZm9yIHRoZSBmdWxsDQo+ID4gcHJvdG9jb2wgc3BlY2lmaWNh
dGlvbi4NCj4gPg0KPiA+IEFyYml0cmF0aW9uIGlzIG5vdCB0aGUgb25seSBwdXJwb3NlIG9mIGl3
bG1laSBhbmQgU0FQLiBTQVAgYWxzbyBhbGxvd3MNCj4gPiB0byBtYWludGFpbiB0aGUgQU1UJ3Mg
ZnVuY3Rpb25hbGl0eSBldmVuIHdoZW4gdGhlIE9TIG93bnMgdGhlIGRldmljZS4NCj4gPiBUbyBj
b25uZWN0IHRvIEFNVCwgb25lIG5lZWRzIHRvIGluaXRpYXRlIGFuIEhUVFAgY29ubmVjdGlvbiB0
byBwb3J0DQo+ID4gMTY5OTIuIGl3bG1laSB3aWxsIGxpc3RlbiB0byB0aGUgUnggcGF0aCBhbmQg
Zm9yd2FyZCAodGhyb3VnaCBTQVApIHRvDQo+ID4gdGhlIENTTUUgZmlybXdhcmUgdGhlIGRhdGEg
aXQgZ290LiBUaGVuLCB0aGUgZW1iZWRkZWQgSFRUUCBzZXJ2ZXIgaW4NCj4gPiB0aGUgY2hpcHNl
dCB3aWxsIHJlcGx5IHRvIHRoZSByZXF1ZXN0IGFuZCBzZW5kIGEgU0FQIG5vdGlmaWNhdGlvbiB0
bw0KPiA+IGFzayBpd2xtZWkgdG8gc2VuZCB0aGUgcmVwbHkuDQo+ID4gVGhpcyB3YXksIEFNVCBy
dW5uaW5nIG9uIHRoZSBDU01FIGNhbiBzdGlsbCB3b3JrLg0KPiA+DQo+ID4gSW4gcHJhY3RpY2Ug
dGhpcyBtZWFucyB0aGF0IGFsbCB0aGUgdXNlIGNhc2VzIHF1b3RlZCBhYm92ZSAoS1ZNLA0KPiA+
IHJlbW90ZSBJREUgZGV2aWNlLCBldGMuLi4pIHdpbGwgd29yayBldmVuIHdoZW4gdGhlIE9TIHVz
ZXMgdGhlIFdMQU4NCj4gPiBkZXZpY2UuDQo+ID4NCj4gPiBIb3cgdG8gZGlzYWJsZSBhbGwgdGhp
cz8NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBpd2xtZWkgd29uJ3QgYmUg
YWJsZSB0byBkbyBhbnl0aGluZyBpZiB0aGUgQ1NNRSdzIG5ldHdvcmtpbmcgc3RhY2sgaXMNCj4g
PiBub3QgZW5hYmxlZC4gQnkgZGVmYXVsdCwgQ1NNRSdzIG5ldHdvcmtpbmcgc3RhY2sgaXMgZGlz
YWJsZWQgKHRoaXMgaXMNCj4gPiBhIEJJT1Mgc2V0dGluZykuDQo+ID4gSW4gY2FzZSB0aGUgQ1NN
RSdzIG5ldHdvcmtpbmcgc3RhY2sgaXMgZGlzYWJsZWQsIGl3bHdpZmkgd2lsbCBqdXN0IGdldA0K
PiA+IGFjY2VzcyB0byB0aGUgZGV2aWNlIGJlY2F1c2UgdGhlcmUgaXMgbm8gY29udGVudGlvbiB3
aXRoIGFueSBvdGhlcg0KPiA+IGFjdG9yIGFuZCwgaGVuY2UsIG5vIGFyYml0cmF0aW9uIGlzIG5l
ZWRlZC4NCj4gPg0KPiA+IEluIHRoaXMgcGF0Y2gsIEkgb25seSBhZGQgdGhlIGl3bG1laSBkcml2
ZXIuIEludGVncmF0aW9uIHdpdGggaXdsd2lmaQ0KPiA+IHdpbGwgYmUgaW1wbGVtZW50ZWQgaW4g
dGhlIG5leHQgb25lLg0KPiA+DQo+ID4gQ28tRGV2ZWxvcGVkLWJ5OiBBeWFsYSBCZWtlciA8YXlh
bGEuYmVrZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNo
IDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gdjI6IGZpeCBhIGZl
dyB3YXJuaW5ncyByYWlzZWQgYnkgdGhlIGRpZmZlcmVudCBib3RzDQo+ID4gdjM6IHJld3JpdGUg
dGhlIGNvbW1pdCBtZXNzYWdlDQo+ID4gdjQ6IHB1dCB0aGUgZGVidWdmcyBjb250ZW50IGluIGEg
ZGlmZmVyZW50IHBhdGNoDQo+ID4gLS0tDQo+IA0KPiBJIHRoaW5rIEkgZGlkIGFsbCB5b3Ugd2Fu
dGVkLCBJIGNhbiB1bmRlcnN0YW5kIGlmIHRoaXMgc2VyaWVzIGRvZXNuJ3QgZ2V0IG1lcmdlZA0K
PiBmb3IgNS4xNCwgYnV0IEkgcmVhbGx5IHdvdWxkIGxpa2UgdG8gbWFrZSBzdXJlIHRoYXQgd2Ug
YXJlIHJlYWR5IHRvIGFwcGx5IHRoaXMNCj4gYWZ0ZXIgdGhlIG1lcmdlIHdpbmRvdy4NCj4gSWYg
eW91J3JlIGhhcHB5IHdpdGggdGhpcywgZ3JlYXQuIElmIG5vdCwgbGV0IG1lIGtub3cgc28gdGhh
dCBJIGNhbiBmaXggd2hhdCB5b3UNCj4gd2FudCB0byBzZWUgZml4ZWQuDQo+IEZZSSAtIHRoZXJl
IGlzIGFsc28gdGhlIHBhdGNoIGZvciBtZWkgdGhhdCBJIGRvbid0IHNlbmQgZm9yIHJldmlldyBi
ZWNhdXNlIGl0J3MNCj4gYWxyZWFkeSBBQ0snZWQgYnkgR3JlZywgYW5kIHRoZXJlIGlzIGFub3Ro
ZXIgcGF0Y2ggdGhhdCBJIGhhdmVuJ3Qgc2VudCB5ZXQNCj4gYmVjYXVzZSBpdCByZWxpZXMgb24g
YSBjZmc4MDIxMSBwYXRjaCB0aGF0IGlzIG5vdyBpbg0KPiBuZXQtbmV4dDogMzU4YWU4ODg4MWFk
YzNhYzE1NDQxMDQyNzJlYjdlOTQwOGY4MGIzOQ0KPiBJZiB5b3UgbWVyZ2UgbmV0LW5leHQsIEkn
bGwgYmUgYWJsZSB0byByZWJhc2UgYW5kIHNlbmQgdGhpcyBvbmUgYXMgd2VsbC4NCj4gDQoNCk1l
cmdlIHdpbmRvdyBpcyBub3cgY2xvc2VkLCBjYW4gd2UgbWFrZSBwcm9ncmVzcyBoZXJlPw0KVGhh
bmtzDQo=
