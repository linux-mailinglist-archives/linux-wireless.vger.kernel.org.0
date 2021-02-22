Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAB3213AC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhBVKE2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 05:04:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57749 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhBVKCw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 05:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613988171; x=1645524171;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iVmRXiBGV4gp6t5MlL+7G9n/E4lVGXYcEARPE+y1sm8=;
  b=JXc8wBL28yclGL4FND8P+ogIiVcodJdZXbentDom06k0De/P88ZmU3sp
   y4UCEA09JK5tUdeA9ByytRsgJtcE69yM74iGfN0hk7kw6ob9VrsdpvlmS
   SdTUyfzYgnJErOEnb4S0Tc8Wo4m9k1tTwHdtI3WYhZ/snbw2ZBZ4nYB/P
   PcIVjofPUMjdclkKkWA4SW8EtUWh1MEot723loK3M8iuK31yPOMEKSWuk
   K5nvoCykW7w5GmypK7yIGlKzTcdUa2sHz1U4n1JcaSOTQseKM2JtlsYHq
   FlvoSiTe1v7dCJwq07zy6/HFaid8cIxbriYTmOqhece4CXUiF998y/HvD
   w==;
IronPort-SDR: p8mxwoKzhERtK1JqFvigHdWKfXMFqo+Pfvrz7IGiYmZ9N8RV8DWwerJJwkOTU2tDmZxtgKlPWD
 3/Xe43qnDGH2+/HLq8rwkBipldrNY2GWZG+XSJLCohBG+KXkjBly1/XwmCvq78B2w8gS+mbS/8
 ju5Buh84YDxVsIev08nsxADsP5KdjLFUGMn9ominSYwZL19Yyw9kP2XEbonwpNoTrDu+dkvYRN
 kkd1X85ZIAlEB/KFAR4CQPPiGS9FwOx9oPzpV+E1xFR57qr/n+84wgx3Or6iwFPBaXm74gSKpx
 eVI=
X-IronPort-AV: E=Sophos;i="5.81,196,1610434800"; 
   d="scan'208";a="116074133"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2021 03:01:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 03:01:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 22 Feb 2021 03:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG1cvsDVHXY91tE05Jq9wNUmsa9Fg0hgGC5UPzejb2nwzNueY6FCJiBlJoaY/APJuNB/9BaQt//ithAloxGx9aNi2xaS7trl5tVMk0Q6v+X/ryfULKsLErLtE1d4SkE3sED1FURvEvdgDDAfgWyZ6Q680sIQSy/h16yNceBqbr6sBEiReOSjOiBOWqPnlUD/a+S+9gGzPHTJZnBvKclpBqs6vvIjmxuNMwgEHy4D9zE+zVWwXQlAc7/0t7nOTiAZMIdFYQwK1GrLKX+CgHGbuYteQNOf4LHtncdMdJA1jtVAcDIwzFYef6h4FVhO6xL0vknWRjwOg6JsHAdhoDNl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVmRXiBGV4gp6t5MlL+7G9n/E4lVGXYcEARPE+y1sm8=;
 b=PqFdKB4JNbxN/GffWFOekp0cDhDI6l2jk6CvMFUJeB5bRdZQ1T9iY+2AJkAk0ZgD6SIQ5grXWVBeZ92SQwQ6ZzDxoX+vvd+MZXPjXx6Rtn1gCBUsKplEJLC7C6c2lr61bjNiv0g+frFuaaqdN8lF/zzJbrNLuLFM0DAKiTdZ13gYce8pvOpqBj2PhKTP7PkrkAuz82X5+8SRukv0I3H/rGLx7GPzYjB4J3pF2SOW7sk7QeBjiFu+BrQTzb7MGbKXEpocgt3azepygSqcp041n3SoRPN4OnxvA1oe5eQWeDdtrGVez3bDxnXTx4H5o67aTCdfBgYwoj1ImWjfTozFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVmRXiBGV4gp6t5MlL+7G9n/E4lVGXYcEARPE+y1sm8=;
 b=k82EjZ1gVoq3RHStMPgHSGaX+x8ROg9IGUmt4y6ROEejv0NjHtdBf5BfxoZC6APMfQEdE9zUgxiDZNPJBfkyQnSxZL8jAcoinC4gfArwgsHouvH7y00IiwORxRpggokiW8c66PESVLdzIkFDBbIMyF2HHQeFHfOd6i/r7ggWGZE=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3685.namprd11.prod.outlook.com (2603:10b6:a03:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 10:01:22 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 10:01:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
Subject: Re: wilc1000 driver
Thread-Topic: wilc1000 driver
Thread-Index: AQHXCLDudY08vai/x0+sLM30/GJrVapj8fQA
Date:   Mon, 22 Feb 2021 10:01:21 +0000
Message-ID: <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
In-Reply-To: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: egauge.net; dkim=none (message not signed)
 header.d=none;egauge.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2401:4900:3762:a25a:482a:5748:d1cc:a857]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a72a02c-4efd-4887-b6d2-08d8d718cead
x-ms-traffictypediagnostic: BYAPR11MB3685:
x-microsoft-antispam-prvs: <BYAPR11MB368514C78FCAC4CA703884BAE3819@BYAPR11MB3685.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOqY/XT0Gvl+mF4OZ5C4mTdQL1GDXpfgV2J1s7JUI5gLtQ21HG2XHMELegTCo1aBwZsVAAifxdUyxy3F48QlIZczAWW9vM2mG4xHmCFceV6CIk2fccA9O4I2unE2kyJcFUfrLXOrDNmmRsELQGBeir29sO+q4cCc1D+YUWyRbDyh9Z+aq+6L90i/OeznsUqSzY5OwI65uMk94U9b4LFkZ03D36RvLciSa+ESlomgoLo5pKW6gAEFde0Votnjgtt6iJAO759JqwJEErxnf+ZBOtM/tZRI+iRkYj1ZFzNwximTCi94FNxMwQqgGlFGhRcEfhHQsY/M9IlxGpKFZez+vLbXDstjax5Yuss2fK1TAxR2NmqzAhSEa0GoLvdWTbo/esw6vIJUlPlhjXEEAlo517U+8sEdI67nai4ZNyh+XT2TvDcn+Rm/Mh1lpUF85kojKXWylYdGHAeyhnkz1AlLL5LqZX823MeguStsRX5SnGZFzpTfXEHXJdzttWZ+TkRGUxwKECo6pbd2CDK26ZmM991jHnqoxkG69QxrfMxSIpfv9AcThZpDVzoI1HjIW33DWiKhZgdkb5joiREAsbKFRes41oZFd16dvB/3UPs+u1xM2xYOZ5RJwR8ameILCoQSQGO76pH6dAjSpUD7pfhWbapM/aPm2QJly1LJW8NOnIwFnIk7sQcIOUetgJPDN631
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(966005)(91956017)(31686004)(76116006)(316002)(66556008)(66476007)(64756008)(71200400001)(8676002)(478600001)(66446008)(36756003)(6486002)(5660300002)(8936002)(2906002)(186003)(6506007)(53546011)(7116003)(31696002)(2616005)(86362001)(83380400001)(6512007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WEF3YUZ5L2xlU0FqNDNjWkJEVWpFQ1poQWQxKzF5TVRHc2tTekhGeHBxMGMv?=
 =?utf-8?B?WG10UTgyaHNYeXNSWExMZDVGM2hneTlqR3N4Y3dYeWtCc0ZyTjhqaEJHNjJE?=
 =?utf-8?B?OGtiSVRlVmtySkM4Q1J5VFBsL0NRbVk1clgrV2dIdW5tZ3lwdGNub21xNDhS?=
 =?utf-8?B?NjFlemg2bEtDNXFhaEZVeUpGbjRla3kwSjQ2L0llaGhyQVVaeElFOHF4Snlp?=
 =?utf-8?B?S2F6OTZrNEQwZ05ONytiY0dTanVEbHBwS21rSVFzaENVSjZNUDlGYlpTdDhQ?=
 =?utf-8?B?TXhmOWt5OXdqdzlDN0F0OFdSeXdhNkNMeGxQVWNYVUZRbXBCbEhKOC8rZTkr?=
 =?utf-8?B?bm5ZSlRDUkFMUjlxeStVbGgzQko1UmNrUUg4bDJObkRTSW5nN015Y0RMT2ky?=
 =?utf-8?B?SnRoMDhCU0xtRy80bEVLRHdOQ280SnAyckJxQ0QxMk5uaktndElOcVRLeUNi?=
 =?utf-8?B?Yi9ZaDBkVFZJMlJaQk9pNkhyMVlXbzRDSjBsUFBKUzMxdDNMOHUzbUFsMHBW?=
 =?utf-8?B?djM1UVNMOVNOVTk3UEVUVkZaZENWM0l6enFQNk5CeEpPcjNTNXFVRFlWSHZw?=
 =?utf-8?B?cmJRQkRhMkVzR3JkU3JFMldaK2FMUzJZL1lodWF5czhaY3hvNjdzdSttOTZw?=
 =?utf-8?B?MzNnK0NmNjFlT1NXbjJlSVN0aGIySENOODZzWm85NzB4QlY4K0RPMWxxOUhG?=
 =?utf-8?B?WGRPVVUzR3hwSzdOZGhrNU9pQWc4ZE0xL2FmaDdzTjdPRFhkYVJCL3BnM2Nk?=
 =?utf-8?B?NTd6d1grSXJ2TzMwUkVtN0lhOHFTci81VHRlbkFlT25Ud3pmTElVeUZldGV5?=
 =?utf-8?B?dFl3bHM0YkRYMFFVTmpoazY3c0VZTHg2dG9Fc1RIaFpPNTBNdDkrNHovOTdZ?=
 =?utf-8?B?R1pjN0o0Nkp0K2hIQ2VTcDFCM2w1cHVaZ082eElIcnhnRkxnbGtXcEpjTmVo?=
 =?utf-8?B?UDd2WVhhSUF4WXZNVWdBOHRMTFp0SEsxNFBqWVRNZ2psNkxGL2NmTWtETnhL?=
 =?utf-8?B?cGp4Vk5MNU40eGhSZUxCVFc1RVo3bjlzZVpGZjJxODJqSGpueGpnd0RldmZo?=
 =?utf-8?B?ZnNKdWkxSVV5a3FKTWMzaVJmWVRINjN3RTBwQUxuL09Ic1I5eWJKUitMWmpL?=
 =?utf-8?B?SWtOOVlSdnJIVm9xNXJlSmFDU0lOektCc3BOUnlIb2l3T0w1VkxObnp5dlJq?=
 =?utf-8?B?UTVuM2loLzlMOWVjZ3JMdms1RFhlRWozWUZCYThtZ0h1MVRGTlJTSFE4eGd0?=
 =?utf-8?B?eHRQMzUyR1owR2tXdi96MTI1cWMvWW5Gem02RWRENHZWNnRpcEZjYnpuN3Fi?=
 =?utf-8?B?Y1ZWSlpOenU1MFMxYWMrR3NhbDRZekRoRDFTdVV2TG0wMnRRMzFHcUtYTmVp?=
 =?utf-8?B?bEZZNkkybUF0QkgvTUpydVVpQTJaVnVYdG9RYlpzNTNLc1dOTVZWd2xQbVhN?=
 =?utf-8?B?M3duNWtpbmNtNjE1S3lLYWwwWGt3UyszNThKRGkxSjBUSHZJRlpqUE5QQTlq?=
 =?utf-8?B?alEwVUFNalVZd2JYOHUvMkpEaVJaUnFYQWVZT2ZzZlJPck85WTNLSmdIdzRp?=
 =?utf-8?B?WVgwdGU5Zm9LQmo1SU96QWlZMmd1YWFocW9mS3JWejVyQ203WlNDWjRRaWlJ?=
 =?utf-8?B?YXc1N3F2dG9oZ0ZzdWdDSEkwSWJWZ1FvS2c5N2prNVcyeHYzelVFL2gwNFRm?=
 =?utf-8?B?SFlDRFJ3WFQ3ckFFOU4yblhac2lrN2M1dHdaVGtTbW5NZndLd2s5ZFBSRUta?=
 =?utf-8?B?UDg0d3QyVk9iZVgrV0ZOOWcwT244ZTl2K1NMM3ZvcnVpNkZ3ZTQ2VkI2ZGRZ?=
 =?utf-8?Q?NxYAiAFAXifkhI41VuTnoF7pP45dAp+eUJ1Yo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F0C3EFAEB2EDD45A45988E775BF5F00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a72a02c-4efd-4887-b6d2-08d8d718cead
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 10:01:21.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGPlBZM+VF6ePAQ00YuKNIbOFXxlWMwvNoUSlvVwVwNCLKBwh/4aZ9O12u0QWPc3YuFNHhEFc0pALdZvT8Zk0X9g5mMW6o9sLPmcySBDOM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3685
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhhbmtzIERhdmlkLiBJIGFwcHJlY2lhdGUgeW91ciBlZmZvcnRzIHRvIGNvbnRyaWJ1dGUgZm9y
IFdJTEMgZHJpdmVyLg0KDQpPbiAyMi8wMi8yMSA1OjUyIGFtLCBEYXZpZCBNb3NiZXJnZXItVGFu
ZyB3cm90ZToNCj4gDQo+IFNvLCBJJ2QgbGlrZSB0byBwcm92aWRlIHNvbWUgcGF0Y2hlcyBmb3Ig
dGhlIHdpbGMgZHJpdmVyLCBidXQgSSdtDQo+IHVuY2xlYXIgd2hhdCB0aGUgbW9zdCBlZmZlY3Rp
dmUgd2F5IHRvIGdvIGFib3V0IHRoaXMgaXMuDQoNClRvIHN1Ym1pdCB0aGUgcGF0Y2hlcyBmb3Ig
d2lsYzEwMDAgbWFpbmxpbmVkIGRyaXZlciwgcGxlYXNlIHNlbmQgdGhlDQpwYXRjaGVzIHRvIGxp
bnV4LXdpcmVsZXNzIG1haWxpbmcgbGlzdC4gSGF2ZSBhIGxvb2sgYXQgKnN1Ym1pdHRpbmcNCnBh
dGNoKiBzZWN0aW9uIGluIHdpcmVsZXNzIHdpa2kgdG8ga25vdyBhYm91dCB0aGUgcGF0Y2ggc3Vi
bWlzc2lvbiBwcm9jZXNzLg0KDQpQbGVhc2UgcmVmZXIgdGhlIGJlbG93IGxpbms6DQpodHRwczov
L3dpcmVsZXNzLndpa2kua2VybmVsLm9yZy9lbi9kZXZlbG9wZXJzL2RvY3VtZW50YXRpb24vc3Vi
bWl0dGluZ3BhdGNoZXMNCg0KPiANCj4gVGhlIGRyaXZlciBpbiBtYWlubGluZSAoZHJpdmVyL25l
dC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDApIG9ubHkNCj4gc2VlbXMgdG8gc3VwcG9ydCBX
SUxDMTAwMCAobm90IFdJTEMzMDAwKSBhbmQgdXNlcyBmaXJtd2FyZToNCj4gDQo+ICAgYXRtZWwv
d2lsYzEwMDBfd2lmaV9maXJtd2FyZS0xLmJpbg0KPiANCj4gd2hlcmVhcyB0aGUgbGludXgtYXQ5
MSBkcml2ZXIgKGRyaXZlci9zdGFnaW5nL3dpbGMxMDAwKSBzdXBwb3J0cyBib3RoDQo+IFdJTEMx
MDAwIGFuZCBXSUxDMzAwMCBhbmQgdXNlcyBmaXJtd2FyZQ0KPiANCj4gICBtY2gvd2lsYzEwMDBf
d2lmaV9maXJtd2FyZS5iaW4NCj4gDQo+IChmb3IgV0lMQzEwMDApLg0KDQpUaGUgV0lMQzEwMDAg
MTUuNCBmaXJtd2FyZSh3aWxjMTAwMF93aWZpX2Zpcm13YXJlLTEuYmluKSBpcyBhdmFpbGFibGUg
YXQNCmxpbnV4LWZpcm13YXJlIHJlcG8uDQoNCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9maXJtd2FyZS9saW51eC1maXJtd2FyZS5naXQNCg0KUGxlYXNlIHVz
ZSB0aGlzIGZpcm13YXJlIGZvciB5b3VyIHRlc3RpbmcuDQoNCj4gDQo+IEZvciB0aGUgaGFyZHdh
cmUgSSBoYXZlIChlbWJlZGRlZCBzeXN0ZW0gd2l0aCBXSUxDMTAwMC9TUEkpLCB0aGUNCj4gbWFp
bmxpbmUgZHJpdmVyIGRvZXNuJ3QgbG9hZCwgd2hlcmVhcyB0aGUgZHJpdmVyIGZyb20gbGludXgt
YXQ5MSBkb2VzDQo+IGxvYWQgYW5kIHdvcmsobW9zdGx5KS4NCj4gDQoNCldoYXQgZXJyb3IgYXJl
IHlvdSBnZXR0aW5nIGR1cmluZyBkcml2ZXIgbG9hZGluZy4gQ291bGQgeW91IHBsZWFzZSBjaGVj
aw0KaWYgRlcgZmlsZSBpcyBhdmFpbGFibGUgYXQgImF0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdh
cmUtMS5iaW4iIHBhdGguDQoNCj4gSSdkIHJlYWxseSBsaWtlIHRvIHdvcmsgb2ZmIG9mIG1haW5s
aW5lIHNpbmNlIGl0J3MgbXVjaCBlYXNpZXIgdG8gdHJhY2sNCj4gdGhpbmdzIHdpdGggYSByZXBv
c2l0b3J5IHRoYXQncyB1cGRhdGVkIGZyZXF1ZW50bHksIGJ1dCBpdCBsb29rcyB0byBtZQ0KPiBs
aWtlIHRoZSBtYWlubGluZSBtYXkgYmUgbWlzc2luZyBhIGxvdCBvZiBjb2RlIHRoYXQncyBhbHJl
YWR5IGluDQo+IGxpbnV4LWF0OTEuDQo+IA0KPiBXaGF0IGFtIEkgc3VwcG9zZWQgdG8gZG8/DQoN
ClRoZSBtYWlubGluZWQgZHJpdmVyIG9ubHkgc3VwcG9ydCBmb3IgV0lMQzEwMDAuIFdJTEMzMDAw
IGNoaXAoV2lmaStCVA0KY29tYm8pIHN1cHBvcnQgbmVlZHMgdG8gYmUgYWRkZWQuIEVhcmxpZXIg
dGhlIHdpbGMgZHJpdmVyIHdhcyBwYXJ0IG9mDQpzdGFnaW5nIHNvIGFkZGluZyBuZXcgZmVhdHVy
ZXMgd2VyZSBub3QgZW5jb3VyYWdlZCBidXQgbm93IG5ldyBmZWF0dXJlcw0KYXJlIHdlbGNvbWUu
DQpXZSBuZWVkIHRvIHBvcnQgZGlmZmVyZW50IGZlYXR1cmVzIHRvIHRoZSBtYWlubGluZWQgZHJp
dmVyLiBSZWNlbnRseSB3ZQ0KaGF2ZSBhZGRlZCB0aGUgc3VwcG9ydCBmb3IgV01NWzFdLiBTaW1p
bGFybHkgd2UgbmVlZCB0byBhZGQgb3RoZXINCmZlYXR1cmVzKGxpa2Ugd2lsYzMwMDAgc3VwcG9y
dCkgdG8gdGhlIG1haW5saW5lIGRyaXZlciBieSBmb2xsb3dpbmcNCmtlcm5lbCBkZXZlbG9wbWVu
dCBndWlkZWxpbmUuDQoNCjEuIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXdp
cmVsZXNzL21zZzIwNTg5OS5odG1sDQoNClJlZ2FyZHMsDQpBamF5DQo=
