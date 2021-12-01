Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00476464D2D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbhLALtg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 06:49:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:5648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhLALtf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 06:49:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="235171897"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="235171897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 03:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="540795546"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2021 03:46:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 03:46:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 1 Dec 2021 03:46:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 1 Dec 2021 03:46:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne2aKovwFl2i9iu0DlEmqQKallglqZFmmMH5CEL6g8myJzZ31BKb4ln/5T0roUSNEZpxd8ninyoKoktyUdww6EBihXxkJh32ANGefnmtaP+BKXnrvtnkqh9wKzGqTOysS+oFBd/2im6q9rFeIQCJ+WUBne1BAMF9Hi595x4arR4n51JmWkjcYulzqLK+sM9EtD4sqOFZVGDv3shToFeUsblXqxBOjmq9NnbfOyT+h6ZGLEinr/v/ncmmuRc5LqjYOeSTlyaHC+pN/BlyH20i3Vrk0fgIHnplkczKyXypi1kdWuPqxcCALNgmPFyHtuJmfi0OKKsgeh9uhM2AtLIplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M8jUIanaC1MQ5AZED+Ntvksvdja0wPAQ/A7xhHbLNk=;
 b=XHU8XLubHvgaCkjezsUJFYtltmRJJfd97oQWEep8YmUisdwnquspir4whDyS5gb9snQEV2y4Uk6dOqxe4bicoYJ9jO0O9gXasi3ZC9KqUTghSo2wmMCpdND2LQT8Irqd2h6u9LYmxvyNTT/lJmnvvKcwWab4bAH0PDbHi3UQzBA3uQMnFTJCB/Dsp844yeVydRvyMTE1uLEnH6fGibhriw2h9gINvgYFlR2Kvw7cM6+c1wIvgbIsXikXF3+xUozCrteBY6LNN2Gz+IzpJJrN1+HtViaGMndHDMu2fBnbboLFyvEMcqP1Fe8ZPX8eucPt8+F2t0k8wGTaTdE3Bzz9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M8jUIanaC1MQ5AZED+Ntvksvdja0wPAQ/A7xhHbLNk=;
 b=o5tRs9KPCd65Rp80cIP/2zFxAA5HlPl3ub4sM9Jb9KhnCuutfZiLTtWsHO7IRQFq9Mf4/GVLIOedJOQxrvcqpKR4uaUgk/GfLqXx5bothTmefUpN35uzWtOOU6q7/A3OzKGTMOdGKa3xWEwnfeuYIUf7+nsSgl1ku8HHmck0akY=
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 11:46:11 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::787a:2f03:efff:c273]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::e814:a13b:4bbf:ef2%9]) with mapi id 15.20.4669.016; Wed, 1 Dec 2021
 11:46:11 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v8 2/6] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Topic: [PATCH v8 2/6] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Index: AQHX5ox6MPqJMcTeoU6oheXWAWoU6KwdhJ0A
Date:   Wed, 1 Dec 2021 11:46:11 +0000
Message-ID: <SA1PR11MB5825C9DE9D19017F36204A35F2689@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <20211112062814.7502-1-emmanuel.grumbach@intel.com>
 <20211112062814.7502-2-emmanuel.grumbach@intel.com>
 <0c26baa6-6e43-338e-5814-fac957c7b116@kernel.org>
In-Reply-To: <0c26baa6-6e43-338e-5814-fac957c7b116@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c69ec2ca-67f5-4e3c-1ee3-08d9b4c02bf6
x-ms-traffictypediagnostic: SA0PR11MB4560:
x-microsoft-antispam-prvs: <SA0PR11MB4560BE83D41960592AAA9674F2689@SA0PR11MB4560.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KpT3sIL/rsgQUntDhS9OCYTqniHyMALOM1uo32NN/HwaMd90rt/MO5qv58txEVoMCwXBFRTjlGBUhmCm+AQNHGXdfBt0QbD6CRHUsSh1RBwUkWdFvKQy3E8QNeBnIILa0pNA8whULYqrGz+KDUjfima/SbPpXI5wDtDPjQNAFnLp84LTsw/BBRHED9GK71HTlj2bv4eq3DXCGtQDI9Uq3um30v5R9eKDQwpvKY70ZJtUoJ6vXAfFSZqO05M1eIzvquNgBSyUqBXVr546qE7Ed2YwFlbEZH0FLT/u+JsI5dxqCbiwL2hpuuql8Oi3MfbRtFl1AfNvGwOzHCokWhEKiYm1o4N1PuLSMd1WMRF3PbkdsDV5dNYT3s/tJnF+6+JCanVZ0pGMq2DTjSpPhMq5/UhalnjivU3uHvF330DGORR79tuCjvpNLob89wI5MEvz4Pox30wWKpYi1IF3rX/ZdpIL5OYzu4Ui4HjAdK+oM0ojO+dtYqdC5IaDan9FCvR55ynkCN22nt/NcdUOyyn8VPXXNPzHH/X7GIdN20QKErkGVrghECIdpvnKMP1d4F3iOrGFJ7opTN1s/NsQU2IXbg312ojvbCi7hiLz6UeqB7GIYH2VzYMGOUAjWpG+1g80LrOrKJOe/SGIHu+jZra+i1baiF9HhSIOnDsWQVqHu8LtvpvvbRx5+BBnEO0LPOkHDQSXUdh91qMt0vNYgxF+lvxX//TE9kj4wNgj0nXYT2T2J8ZmWTE/BS3cKkAXx0j2z3msFMiauoEWViygCA/YxCxT70ILBLwsrH0+prwDffxHFWLlg/I7eDOy10+sPavRw+T/rbTO8QApMBZ/CFj2xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(4326008)(66476007)(66556008)(66446008)(64756008)(66946007)(38070700005)(55016003)(5660300002)(76116006)(9686003)(33656002)(8936002)(86362001)(122000001)(186003)(38100700002)(110136005)(966005)(6506007)(8676002)(52536014)(83380400001)(2906002)(316002)(7696005)(82960400001)(508600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBRZFgwc3h3TWZTVXc2MnpmWVNuYUYxSElIUDJKN3ZlS1ZSWVkyYjI0MUpn?=
 =?utf-8?B?VVMzTnlqZlFCYURkQVpvV3hPZDByV2hlaXFlWGJmcVN3UVo0SU1TOG5QMmhD?=
 =?utf-8?B?M3huc3FyUXJrZ2xpN005dG5QdkdpeDMxZ3p6ZHZoM0Z2WktuOVkzWi9FWWI3?=
 =?utf-8?B?VURqWnY4TlNCMlY2ditxc1JXZTE3WTFnKzZMK25zSitYWXVTOGEyUVRRazFt?=
 =?utf-8?B?T1hYN1hISjVSSmtlekFwZXhON2JrZUk1bzY4TlRDQkhhWjVKK0Zpem1TTkZR?=
 =?utf-8?B?cVBjYU9HYmFyc0RpNXlkYndudnhVME9BcmpVNjhtU1dWZExDTVh1N3d2MEZE?=
 =?utf-8?B?em5jbFNoUTAvQ0Yzd2V6ZkZsMTBZcCtFZS9OVXlLMEV2ZVpMN1NzVk1RMHFE?=
 =?utf-8?B?LzVYYzl3alVJNFNxdHJzZjREMDl4SzdrVy9CZ0U1a1VMRmxvVldHUjJlanlT?=
 =?utf-8?B?ekxVVHUwaGxzN3QrYTJ2QmtFSmVlNDBtbmNqbjVSSFZTMVJ4QlNCMUZ3d2xG?=
 =?utf-8?B?aHVELzhHYXVra3lDdGRCZGM0Tm85bHdtNlR6YWNHT2RHdVFSUmF6TmJuREM4?=
 =?utf-8?B?TGxlTjM4azNmcEt0d05uaFdyQ1hPUDhJaHIxWVJKSlJDbzFzUG92MzVmVkxJ?=
 =?utf-8?B?TlJOQ2cwYnNObEg0WENqVUFLVXlJYzZyVHZBU2hLY2JiREdMQU9GdktNTDIx?=
 =?utf-8?B?QmRVK0VDK3NQSlA2Q2pLRlUyODIwM1NyVkx1WjB1YmNFY2NvR21KZzNoYjJU?=
 =?utf-8?B?djNlTGR1eDRyL1ZZcU5USEhVVWZ3VWgzZjZraWRBVmtmbmF6OENJTkpaUFE3?=
 =?utf-8?B?VE84UFFubjNDbjU0ais1YTVtdXNaeWhkM2pTVWVJWmowVlVaM1FiMGVZcE5Z?=
 =?utf-8?B?bGFndTBFWXIxOVRONWRBQ1lXV1pZbWxIbC9kQXdUeUxPM2ZMSXptNU85MTRP?=
 =?utf-8?B?eUJYMTVMTHE3Sm1hcFRYWlpZd2JTcDlLaWhZNmlUUTNlOHUxbG9wam1YV1ZH?=
 =?utf-8?B?L0d4TE5BOGwyK1l6ay93aStiMFpmMEJyekZMS242c1U0NWs0ZGVTM1laZkNV?=
 =?utf-8?B?UyttNmRiN2kycCtUa2M2OERQQUh1aG9JWEdhbUl0enZFbVlRZTJ4bVdibkta?=
 =?utf-8?B?MHFEbHBMY0srZ3Y4emU0bjF1ZnpkdkRRdUszYWZ1cDJrc1EzNUdTSXhJZkhL?=
 =?utf-8?B?azhMelBRYU16Rk9wZVZEVFRhR0NzSkR0SS9qQUJXQ2pNWTJaUmhTa3I2VHhW?=
 =?utf-8?B?RysyQVJESkkyLzJ3VjQybWpLc2pScmxEQmtpaTh1dTVwVjJOVFg5bFpXZHQz?=
 =?utf-8?B?Y1RpUk9pS1JYdmJ4UjVyU1dUSzlsR015NjR5TklGUHBZZjZSRkR6YnNCWnh5?=
 =?utf-8?B?S0tPNDluMWpJNDBWTzlrYzQweEdRUDZlcWgxZ3VPcnh4dHpmdDJ3YlBlSlVj?=
 =?utf-8?B?Yk4zaU5pUEVqVDRzMWIwWm5Vd1MwcDU2SkU1UjdzcTFCYmNLWGdnQ1Y4Ymx4?=
 =?utf-8?B?eHdOQ09vazg1NkV0dy80SVpUbHFuMkNyOVpWNUpFaDJZU1hOM2JFZmhIZXBU?=
 =?utf-8?B?d1draGJXbG5YcVEvZEk2ZG52YXhpOUFJRnFUaTFPQlZzVmUrMHJmRVZRdzZo?=
 =?utf-8?B?a04xSVU1TDZRT1NSZ0UveDdmVyswVmZRaHJEaWd6bk1vdXdXVjVMNGQyZ0p3?=
 =?utf-8?B?RHFYaVpUQU1iTzA2dlFNbDJLelBzZWRWR1gybHA1SVRpbUdOQXgwNUo4RlZN?=
 =?utf-8?B?OTdXQ3RpR2JyYUVQeDRDNDFOamdlemtsMmM2WGZYMDhXaGJ6dk9lWFQ3c2pj?=
 =?utf-8?B?dEVWRlc1bHBSOWhQdml5K3psOXpTK000S3pHUWRSYjl6QkNlakozUm13Znpn?=
 =?utf-8?B?RWtnS3JMUXJpODZ2b0hId1NNSDlxblhmODgrdjhxamIxTVl0VFdBd0xrNFVE?=
 =?utf-8?B?R05aZ3R4WnppdGh5MFB3Y2JtOTZOMGNTYUo5QW92a1ZweW1qb0R2cktraG9K?=
 =?utf-8?B?Tkd3OHR2Zm1ucGwvWUliY0toaVloWUJuU3g2enRVaXFDT3Z2YVoxU0V6bG0w?=
 =?utf-8?B?TDErSlBXWXgzS05aNXU0RXFjNGNjRmFzUjlUWDFOTU54RW1pTWdGZHFrS1Fm?=
 =?utf-8?B?T3Y5VnlDMzYzMnVQZmxkNGZvYzJ1bERJL2pZZllEeW1WK1hZNzkyZzk4dlZX?=
 =?utf-8?B?bS93UWVoS0pFMXMzdGpPK0h5amZBa0lmRXVxSE55Q2dPVWUyTDFXWW5vb1Iz?=
 =?utf-8?B?QzFZbjFxUEdMQlVwb1NKZ2lPcmFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69ec2ca-67f5-4e3c-1ee3-08d9b4c02bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 11:46:11.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WppnZm55AgXbe/LBNbyerPTihCOR2CpwVzRcCymih6lLU6o5Vmwh8IeBd0pdPfUWzKT6BCKiJb0dJpxb3LvwqgefQwbli7U67r3ZjYVSzK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSmlyaSwNCg0KPiANCj4gT24gMTIuIDExLiAyMSwgNzoyOCwgRW1tYW51ZWwgR3J1bWJhY2gg
d3JvdGU6DQo+ID4gQ1NNRSBpbiB0d28gd29yZHMNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
IENTTUUgc3RhbmRzIGZvciBDb252ZXJnZWQgU2VjdXJpdHkgYW5kIE1hbmFnZW1lbnQgRW5naW5l
LiBJdCBpcyBhIENQVQ0KPiA+IG9uIHRoZSBjaGlwc2V0IGFuZCBydW5zIGEgZGVkaWNhdGVkIGZp
cm13YXJlLg0KPiA+IEFNVCAoQWN0aXZlIE1hbmFnZW1lbnQgVGVjaG5vbG9neSkgaXMgb25lIG9m
IHRoZSBhcHBsaWNhdGlvbnMgdGhhdCBydW4NCj4gPiBvbiB0aGF0IENQVS4gQU1UIGFsbG93cyB0
byBjb250cm9sIHRoZSBwbGF0Zm9ybSByZW1vdGVseS4NCj4gPiBIZXJlIGlzIGEgcGFydGlhbCBs
aXN0IG9mIHRoZSB1c2UgY2FzZXM6DQo+ID4gKiBWaWV3IHRoZSBzY3JlZW4gb2YgdGhlIHBsYWZv
cm0sIHdpdGgga2V5Ym9hcmQgYW5kIG1vdXNlIChLVk0pDQo+ID4gKiBBdHRhY2ggYSByZW1vdGUg
SURFIGRldmljZQ0KPiA+ICogSGF2ZSBhIHNlcmlhbCBjb25zb2xlIHRvIHRoZSBkZXZpY2UNCj4g
PiAqIFF1ZXJ5IHRoZSBzdGF0ZSBvZiB0aGUgcGxhdGZvcm0NCj4gPiAqIFJlc2V0IC8gc2h1dCBk
b3duIC8gYm9vdCB0aGUgcGxhdGZvcm0NCj4gDQo+IEhpLA0KPiANCj4gdGhpcyBwYXRjaCBjYXVz
ZXMgbGluayBmYWlsdXJlczoNCj4gID4gTU9EUE9TVCBtb2R1bGVzLW9ubHkuc3ltdmVycw0KPiAg
PiBFUlJPUjogbW9kcG9zdDogIl9fU0NUX190cF9mdW5jX2l3bG1laV9zYXBfZGF0YSINCj4gW2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL2l3bG1laS5rb10gdW5kZWZpbmVk
IQ0KPiAgPiBFUlJPUjogbW9kcG9zdDogIl9fU0NUX190cF9mdW5jX2l3bG1laV9tZV9tc2ciDQo+
IFtkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9pd2xtZWkua29dIHVuZGVm
aW5lZCENCj4gID4gRVJST1I6IG1vZHBvc3Q6ICJfX3RyYWNlcG9pbnRfaXdsbWVpX3NhcF9jbWQi
DQo+IFtkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9pd2xtZWkua29dIHVu
ZGVmaW5lZCENCj4gID4gRVJST1I6IG1vZHBvc3Q6ICJfX3RyYWNlcG9pbnRfaXdsbWVpX21lX21z
ZyINCj4gW2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL2l3bG1laS5rb10g
dW5kZWZpbmVkIQ0KPiAgPiBFUlJPUjogbW9kcG9zdDogIl9fU0NLX190cF9mdW5jX2l3bG1laV9t
ZV9tc2ciDQo+IFtkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9pd2xtZWku
a29dIHVuZGVmaW5lZCENCj4gID4gRVJST1I6IG1vZHBvc3Q6ICJfX1NDS19fdHBfZnVuY19pd2xt
ZWlfc2FwX2RhdGEiDQo+IFtkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9p
d2xtZWkua29dIHVuZGVmaW5lZCENCj4gID4gRVJST1I6IG1vZHBvc3Q6ICJfX3RyYWNlcG9pbnRf
aXdsbWVpX3NhcF9kYXRhIg0KPiBbZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
ZWkvaXdsbWVpLmtvXSB1bmRlZmluZWQhDQo+ICA+IEVSUk9SOiBtb2Rwb3N0OiAiX19TQ1RfX3Rw
X2Z1bmNfaXdsbWVpX3NhcF9jbWQiDQo+IFtkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL21laS9pd2xtZWkua29dIHVuZGVmaW5lZCENCj4gID4gRVJST1I6IG1vZHBvc3Q6ICJfX1ND
S19fdHBfZnVuY19pd2xtZWlfc2FwX2NtZCINCj4gW2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvbWVpL2l3bG1laS5rb10gdW5kZWZpbmVkIQ0KPiAgPiBtYWtlWzFdOiAqKiogWy4u
L3NjcmlwdHMvTWFrZWZpbGUubW9kcG9zdDoxMzQ6IG1vZHVsZXMtb25seS5zeW12ZXJzXQ0KPiBF
cnJvciAxICA+IG1ha2U6ICoqKiBbLi4vTWFrZWZpbGU6MTkwNDogbW9kdWxlc10gRXJyb3IgMg0K
PiANCj4gd2l0aCB0aGlzIGNvbmZpZzoNCj4gaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQu
Y29tL29wZW5TVVNFL2tlcm5lbC1zb3VyY2UvbGludXgtDQo+IG5leHQvY29uZmlnL3g4Nl82NC92
YW5pbGxhDQo+IA0KDQpUaGFua3MgZm9yIHJlcG9ydGluZy4NCkkgc2VudCBhIHBhdGNoIHRvIGZp
eCB0aGlzOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVs
ZXNzL3BhdGNoLzIwMjExMjAxMTEzNDExLjEzMDQwOS0xLWVtbWFudWVsLmdydW1iYWNoQGludGVs
LmNvbS8NCg0KVGhhbmtzIGFnYWluLiANCg==
