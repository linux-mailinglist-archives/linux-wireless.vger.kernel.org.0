Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E32244E3D2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhKLJcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 04:32:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:20097 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234745AbhKLJcp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 04:32:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="233350985"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="233350985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 01:29:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="546882001"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2021 01:29:54 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 01:29:54 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 01:29:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 12 Nov 2021 01:29:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 12 Nov 2021 01:29:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVNM7UXJQJmlbIjVnDNNFW3yfH3ETUHN1OqFyfuqYiMn+qF5C4O/igZ9droRHkhUW6/+KTYjfkiO3CkQo3LqKYlSaKyXrdzg8aC+ypHMg+1dGxDbS6vZS+mPA/T15BB7mEvDJuCKLS/v3aITyD+zvfoZCwCJUFzWl7O3n/wBzEOaFoezgXqhPMmmnHjAV2+p7vqSEQcx843AZezEJzJxiRXY+Xl0IGXKe9IKR3OpPp9mQb/t0jwTdNmtgLYVAfqCd7ChvGqortqJEXJtjPHCgC9YqiE78g4phzPHa7uh8MIU0iRQW3RWZL2t688uPR2UpPFxfhVnyi1m8NL2a0zrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfi46TtLdyf5ivakMzq/sL3H7gkBGxvGpYFyhEdU7GY=;
 b=kl7KeRZixdu3ugrXkcKn20+Yt3Rwmo6QiXYRZ+RljKwNWJaeWlbVU3P+1Pjrur6IFXCKdCR7X7HEK3jnEZmLLcfNFZJaOlj38aVL5pVNcSeoy6e5PBfVvThuDOleC9sgbbnZzQGd2rPtuYd0rf0lDnnujjNBX8z6g9ECpjGoOc/BdeBOVYpGTMV3X4chICDmqlfBLNmssadHptEoavrx0aJfFifjeIQIdSIeIY9RfgWvvEBFbXTp3yUGkaJzKLOdnN/IW0V9Ftp5wYNrLnGv6S7f7LHm4CZRJnQyay3Ql7L5wS47UNZZ3jyFHsP1WUdpskdLsA1SbRd8UB67eLXzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfi46TtLdyf5ivakMzq/sL3H7gkBGxvGpYFyhEdU7GY=;
 b=vSCNCrTr31Fc/tSFU1Rs3bXV1V39LGdd3f+iBabGruxJE4WaIf1khp9uciqvFcg5hqLFMj/ygq/fUX4yZMO2wojtdg92t4hWSpIEuPvB2frbA3Ev9Qt7LTW+s49b/xdRGUrFx4iPKMS/fu2kCW+8c4PDNMpVVUC7oxyefz4cC4w=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 12 Nov
 2021 09:29:50 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e559:d4e6:163c:b1ae]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e559:d4e6:163c:b1ae%6]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 09:29:50 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "lb@semihalf.com" <lb@semihalf.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>
Subject: Re: [PATCH v1] iwlwifi: fix warnings produced by kernel debug options
Thread-Topic: [PATCH v1] iwlwifi: fix warnings produced by kernel debug
 options
Thread-Index: AQHX1n4H3xCVbTO2GUiBg7cBfRSagqv/orGA
Date:   Fri, 12 Nov 2021 09:29:50 +0000
Message-ID: <16385724135f2652de1f954e4b3c019273b61c74.camel@intel.com>
References: <20211110215744.5487-1-lukasz.bartosik@semihalf.com>
In-Reply-To: <20211110215744.5487-1-lukasz.bartosik@semihalf.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c242ced-979a-4240-0b11-08d9a5befa28
x-ms-traffictypediagnostic: BYAPR11MB2854:
x-microsoft-antispam-prvs: <BYAPR11MB2854000B8E06CCEDA9A74DA690959@BYAPR11MB2854.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYsCTYOoFbO3Rg44CJMtGTZi98p6mmzgukZaLMaowTKNH6KTVKZWKCq429h96xoGRHOSIBRhh9tGjQEr3dx1ReACAt9cN3jtpmD21qtqElfOQml6jjbA7TA3Prs09tIhlVo39LRxDs5wgw66EorCHQY+W6O5tsNBhbXin79Czb/dVC5qLqAwn/UdSCOoBWgaH3sAvCfhc4B1b6rQWBr3cILzGeRpDoGf2UjL+AW1/CikOjsbr99DAtuuT05W1tpBr+jZ1IDI61KI1r3kj0OljDLFZMxwbkTMC56ofaZCfuYNX+fiC4JvYi17VbKCRlgEVj+4iUwAujcoV+1JPR+bxw43jMvlXGtSGeI5hw+nVqenwN8p01IAKcc+I2CLvb8Aak/EgWRI4QDSHby79KRKTdkWAgNmw+5MJrrhPAsAR2XGD2A19jojv7TZwMxoT/nB1XFNwcNhP28y7JWBdVbU6OZykQsiodMxM4aH0M1/uowuUqn2TLRqoNBbfPgVvK/1pE4l86fXEeQiEPNE1rm05cCCPZZHvRtfX7xtWwY/aJl7iso6a+h5uS+HwnFs14pHjZHgy9EVREKCSvVrJ5CxAUG/SpAwUoolq/80S88vnS0Ci+lVv6BjlBvN5jQsjgMrQZUfLF6LYF1Fmldx0bD+Phxx1yTJrGb4T/FG88ocYrGUbBeYNogbbGoao0Y6ABfvKQgSMW6WupdmdT7wdDyXkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66556008)(66476007)(316002)(122000001)(26005)(6486002)(508600001)(82960400001)(38070700005)(76116006)(8676002)(186003)(54906003)(91956017)(66946007)(6916009)(36756003)(83380400001)(4326008)(4001150100001)(6506007)(71200400001)(2616005)(2906002)(86362001)(66446008)(6512007)(8936002)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3IrZmdaWll2R296TGpDbWFCdzhyZ3AvaGs5ZEhRK2psZnR0bnpBTlhvckdr?=
 =?utf-8?B?NW1QSEdtOGhyVHROSUp4cHY0Z3ZTN3RCditzcldkdlNlM3ZoamtYV0ZOdTVL?=
 =?utf-8?B?Z29obE51czQrSm1nWlkvWjJFVHlLZUlsTjB4a0F4Tllka3poa1BiK3RiK21h?=
 =?utf-8?B?NE90V21MZGppSXBnYWFhYXhyWkxHQUkwMkoxMmFnTVNnMTJTSFo2dDNKYWNt?=
 =?utf-8?B?Z0htaTZESkpXekltY3FEalNmUWsvMDJZdHR1Wlkwb3FsdzBHN0tRWXpZNlZq?=
 =?utf-8?B?cExDQWpmcVVCVVR6R2ZPdTZQQWxObTZJRTNKQkZNR0JXOFM2TlBYT2hRWlN5?=
 =?utf-8?B?R1ZqQmdGMjhpNEJ0UnNINlZ0UGZISFhkR0JVNVU3SDFmbENuR2QrbHpxN3Z5?=
 =?utf-8?B?WGJOZVNjK3pJSDE0cXB2Qi9zeWVOMVE5dzNaSHpiTy92bzQ0Yk9EYkdqbi9D?=
 =?utf-8?B?RmlGbHdRU3ZIY0ZJamkwT0lKMkYxeVI2dnVaQUE3YmZLdFMrb3J0c2FWZ3hq?=
 =?utf-8?B?RmRoSmQvSWdtckRYNG54WWhsSjZQOUtjWmdFZnRxSmdjZ1VheDVVTi95RjRQ?=
 =?utf-8?B?aC8wcTF3Vi8zbi85NytwWnRwNVpuNDduMmpHaTdOb2l3aG51NytlYnh3WGxo?=
 =?utf-8?B?R3pjZXREYlI4dkQ2Wk5iZkFNWGl6ejYxY2Nha244VWkyMzRodlBCMFNMYlBa?=
 =?utf-8?B?cE5UdnFIQ0NzR1pGNjZwb0ZEVzY3RUFtU3J5T1JnM3p0cC9ORlpYbVlGekJW?=
 =?utf-8?B?NkIzZGlLODdTYS9KR1BQYmxPSXVVLzVLaWhHZ3p6ZmtuOGttZy9wNEF6bkVm?=
 =?utf-8?B?K1Y3dmkzNzYrblZhR1BiM1VJOVF4SzI0ZVI2ZVhZeTlpeVpGc0NLQVdiZ1pu?=
 =?utf-8?B?T1RQRXlBU3pqWXIvVTI4TVNlOWRjQUFoWnR3d093TTQwRTFQc05rTkMxK0dD?=
 =?utf-8?B?eXJvUm1FbnpqNm5GSVErNElyTUdHZmV6QmlxOFZxMENtY0Z5OGJTbmhXZFJW?=
 =?utf-8?B?QkhaalpObCt2UnJvMVprU0NQS25YWjdHRTlES0JIbW9RS0hNbHRRQVpPMXhB?=
 =?utf-8?B?NmExVUt3N3M4eC81MVBoZ3ozYTVveHFSSWg2cDdMUDR4OWc3SWp2WVJISTE5?=
 =?utf-8?B?NGZaYXBVUld1N3Z4K09wK2pnMmtyM04xV0hOenJHRmlUZXZpMGQ5MjkzeDUy?=
 =?utf-8?B?TzBlNEZQWDhNcGd1c1RyN2ZoOUdJNW1CTVdXYW1OQ0FneXgyQ1hMSlJKZ0FV?=
 =?utf-8?B?NjBjZ1Z6cmt1a3dIZ2dJTjdiZUxrb2xVZDNQbEpXckdXQkpjYjlFUEM2eFRu?=
 =?utf-8?B?Y2Iyc3IrVFd0Y0Jyb2dYLyt3MERuaWxzclFSeUtWRXgvcG1YOEtRTURDZ0Zz?=
 =?utf-8?B?Y0hpUFZ4eEM0eGxwanovaGRHNUI5ZEE4WndiaDJiOGFPdUszR2g3SVJUZUNx?=
 =?utf-8?B?QlpiY1hrYS9hV1N1VUZYU2wvSHoyUjV1Z2p6MHBmMUloL1hNTVBqWFZEUC9k?=
 =?utf-8?B?aWFuQ0l6ayt1eDkxTlVtMVQ2VkRaRmQ1OGlPOXh4L3I5dFFERzhHRE5XOHlK?=
 =?utf-8?B?aUVFNytvYzlGdVJlYXIwd2toMFNQaTRROHBpeGJ0ZkN6MzJnQmNhN0FuaE81?=
 =?utf-8?B?YTljZ0lsaFpiVHh2aE1DNkh6S0xCR2lBZy9qSVA3TFZhNE00MlprVkhsOEZP?=
 =?utf-8?B?UVVMR25lUytmVGYxTGtpQktHTmVOVUE4MEhIeUhabVFJNnh1cGRzTjFsOTB0?=
 =?utf-8?B?UmJsRmx5Mk9obll5OS9xSHNGTUt5dGFwSmpTR0lhcktlZ2VQT2VHaENIbWtt?=
 =?utf-8?B?QmpCc1AxS1dCbFdVQTAxL204ZmVXTGZQSGM1UFk0WUM3TzhXbTFlZkZLN3JS?=
 =?utf-8?B?SUNtTkZFTCt0NVBUQW1WZHZvQ3dFNGdOVmlmMmx5U0RzQldmcTFXUVVOdWEr?=
 =?utf-8?B?dFVkbVkzRWVpRlh6ODlNTmFYTXB6NXl2cVphMTFybnBtNWhhWnBFOGFneXly?=
 =?utf-8?B?VmJwUW91ZUxiSHozRWEwU3RZaGFEWW5YWk91b3J3aTBpTUlhbU8wNUZDQXFO?=
 =?utf-8?B?R3J1UkRjZGpoUVRld0NnbGhYMy9FOUV0Q3pIcHVIRDNhVy9qK2E0blBJTjFI?=
 =?utf-8?B?WThjbVA3bnBaTWxBQ2ptc1dvVEJLVEJtMXBhVmFiTktheFp6aWlzYTMwM1Bk?=
 =?utf-8?B?RHNSbHBDbTJoM3dMeGppdjBocHdGSXJYSngwSU1ZUUo5TkdkMjRmWHJLV0lT?=
 =?utf-8?Q?mqEPQuFwDnrHqo/BvyK02m4vqxE62/D4qR3f8SLOg4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56283FAF9A3ABF4D9B71EC8E75111A87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c242ced-979a-4240-0b11-08d9a5befa28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 09:29:50.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qs6LEGsXcNLVJxd7+ze6thdJqdbhnyaDXhpCuUaSRtkf2m/T4E2kEf6FIGkVPXRw7INxpE7akuszYk6Il7NVoOg1XbHEbFRp89mneh5XfqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2854
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTEwIGF0IDIyOjU3ICswMTAwLCBMdWthc3ogQmFydG9zaWsgd3JvdGU6
DQo+IEZyb206IMWBdWthc3ogQmFydG9zaWsgPGxiQHNlbWloYWxmLmNvbT4NCj4gDQo+IEZpeCB3
YXJuaW5ncyBwcm9kdWNlZCBieToNCj4gLSBsb2NrZGVwX2Fzc2VydF93aXBoeSgpIGluIGZ1bmN0
aW9uIHJlZ19wcm9jZXNzX3NlbGZfbWFuYWdlZF9oaW50KCksDQo+IC0gd2lwaHlfZGVyZWZlcmVu
Y2UoKSBpbiBmdW5jdGlvbiBpd2xfbXZtX2luaXRfZndfcmVnZCgpLg0KPiBCb3RoIGZ1bmN0aW9u
IGFyZSBleHBlY3RlZCB0byBiZSBjYWxsZWQgaW4gY3JpdGljYWwgc2VjdGlvbi4NCj4gDQo+IFRo
ZSB3YXJuaW5ncyB3ZXJlIGRpc2NvdmVyZWQgd2hlbiBydW5uaW5nIHY1LjE1IGtlcm5lbA0KPiB3
aXRoIGRlYnVnIG9wdGlvbnMgZW5hYmxlZDoNCj4gDQo+IDEpDQo+IEhhcmR3YXJlIG5hbWU6IEdv
b2dsZSBEZWxiaW4vRGVsYmluDQo+IFJJUDogMDAxMDpyZWdfcHJvY2Vzc19zZWxmX21hbmFnZWRf
aGludCsweDI1NC8weDM0NyBbY2ZnODAyMTFdDQo+IC4uLg0KPiBDYWxsIFRyYWNlOg0KPiByZWd1
bGF0b3J5X3NldF93aXBoeV9yZWdkX3N5bmMrMHgzZC8weGIwDQo+IGl3bF9tdm1faW5pdF9tY2Mr
MHg0OWQvMHg1YTINCj4gaXdsX29wX21vZGVfbXZtX3N0YXJ0KzB4MWI1OC8weDI1MDcNCj4gPyBp
d2xfbXZtX3JlcHJvYmVfd2srMHg5NC8weDk0DQo+IF9pd2xfb3BfbW9kZV9zdGFydCsweDE0Ni8w
eDFhMw0KPiBpd2xfb3Btb2RlX3JlZ2lzdGVyKzB4ZGEvMHgxM2QNCj4gaW5pdF9tb2R1bGUrMHgy
OC8weDEwMDANCj4gDQo+IDIpDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL21hYzgwMjExLmM6MjYzIHN1c3BpY2lvdXMgcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZCgp
IHVzYWdlIQ0KPiAuLi4NCj4gSGFyZHdhcmUgbmFtZTogR29vZ2xlIERlbGJpbi9EZWxiaW4sIEJJ
T1MgR29vZ2xlX0RlbGJpbg0KPiBDYWxsIFRyYWNlOg0KPiBkdW1wX3N0YWNrX2x2bCsweGIxLzB4
ZTYNCj4gaXdsX212bV9pbml0X2Z3X3JlZ2QrMHgyZTcvMHgzNzkNCj4gaXdsX212bV9pbml0X21j
YysweDJjNi8weDVhMg0KPiBpd2xfb3BfbW9kZV9tdm1fc3RhcnQrMHgxYjU4LzB4MjUwNw0KPiA/
IGl3bF9tdm1fcmVwcm9iZV93aysweDk0LzB4OTQNCj4gX2l3bF9vcF9tb2RlX3N0YXJ0KzB4MTQ2
LzB4MWEzDQo+IGl3bF9vcG1vZGVfcmVnaXN0ZXIrMHhkYS8weDEzZA0KPiBpbml0X21vZHVsZSsw
eDI4LzB4MTAwDQo+IA0KPiBGaXhlczogYTA1ODI5YTcyMjJlICgiY2ZnODAyMTE6IGF2b2lkIGhv
bGRpbmcgdGhlIFJUTkwgd2hlbiBjYWxsaW5nIHRoZSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiDFgXVrYXN6IEJhcnRvc2lrIDxsYkBzZW1paGFsZi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vb3BzLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vb3BzLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS9vcHMuYw0KPiBpbmRleCA3N2VhMmQwYTMwOTEuLjYxZGQ3NWY5MzA0ZCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vb3Bz
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vb3BzLmMN
Cj4gQEAgLTY4Nyw2ICs2ODcsNyBAQCBzdGF0aWMgaW50IGl3bF9tdm1fc3RhcnRfZ2V0X252bShz
dHJ1Y3QgaXdsX212bSAqbXZtKQ0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlydG5sX2xvY2soKTsN
Cj4gKwl3aXBoeV9sb2NrKG12bS0+aHctPndpcGh5KTsNCj4gIAltdXRleF9sb2NrKCZtdm0tPm11
dGV4KTsNCj4gIA0KPiAgCXJldCA9IGl3bF9ydW5faW5pdF9tdm1fdWNvZGUobXZtKTsNCj4gQEAg
LTcwMiw2ICs3MDMsNyBAQCBzdGF0aWMgaW50IGl3bF9tdm1fc3RhcnRfZ2V0X252bShzdHJ1Y3Qg
aXdsX212bSAqbXZtKQ0KPiAgCQlpd2xfbXZtX3N0b3BfZGV2aWNlKG12bSk7DQo+ICANCj4gIAlt
dXRleF91bmxvY2soJm12bS0+bXV0ZXgpOw0KPiArCXdpcGh5X3VubG9jayhtdm0tPmh3LT53aXBo
eSk7DQo+ICAJcnRubF91bmxvY2soKTsNCj4gIA0KPiAgCWlmIChyZXQgPCAwKQ0KDQpUaGFua3Mh
IFRoaXMgc29tZWhvdyBnb3QgbG9zdCB3aGVuIHJlYmFzaW5nIHN0dWZmIGZyb20gb3VyIGludGVy
bmFsDQp0cmVlLg0KDQpLYWxsZSwgYXNzaWduaW5nIHRvIHlvdS4gIENhbiB5b3UgcGxlYXNlIGFk
ZCBhIENjOiBzdGFibGUgdGFnPw0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
