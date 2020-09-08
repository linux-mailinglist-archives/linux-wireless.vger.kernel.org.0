Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D536260833
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgIHCNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 22:13:30 -0400
Received: from mail-bn8nam12on2129.outbound.protection.outlook.com ([40.107.237.129]:54944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728531AbgIHCNY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 22:13:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf3KneIF0AGis0Zf/853E6U/wlpus96q56zH1GZGsHpd05MzWOF+lVxcFLsuDdhq3DYCMUc4f9rQmvpgLsI522wTvvqwLRhloa/QidizeBMsA7TpisEl6Am+3GYTSbrOxnQf3fSsttZIVqINsRQ/hEBhdQa3vXKoKq/zJkcfhnq+Zmv9u7slKMO4WmqjctlPibpKJq6TX9VCDRWalhPaTIf+pG278Gb3HS4KypjIMoiyheQQkI6zwEbVwaycLUro39qfSzFYj2/vbwdWY5+OkMxDwbB/FI4Q/jRKDAbGsX6l3J5FX0KUpEMGhH7XTgOs2Vu30zFT0XwRggAZc26RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf/WSg9GWCZWZTpboois+G39hLOZ4v4g0rOE5KmkyQ8=;
 b=MR//cVM4y/n7X2xA9Ti4rPTRApKnboUuY1VGGPgQerfSfZjyxee3ML9cMDaTj8xPMw9irfecpPfM6P3a9eJaKnbuGUZNdLtQxA4iyCbqv1yc4zCfWROHIRVYsJLe1wZq/0WtEnvDMqlUKajQCnmJAeU6/2BqHUmBI9z8ka9XuOtJxgc60jy5w4Q1XoReI3moocBXnlk1RIw/DCALl09e9gdai9dBcwhvpLpoBjOKrO7L+MWp5Sq5kuFFksB1it+ikp0cZG3mspwdapys8LuWRGG/WfWy0dvugXl1LOPL4wUxsiH8qTJ1Oq3kY+Wb3cAOH7wOdYtoIE250jXZcbWg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf/WSg9GWCZWZTpboois+G39hLOZ4v4g0rOE5KmkyQ8=;
 b=Ljzhsy40PnP/ruxLXSjzgNsbJrc6NzNUO5914amVKpfph03eO/gHNEf8839CziPgC0qLtbmBOx3vKIj4wqmXnUDLrj1S/nYvj8q4ZqW5pA6q8bsLWoImS5tCgEkJOYa+uoUqUepIhHsGNFHhDJDIA27hzNt8UiyWh9kxZTDOcFo=
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5619.namprd06.prod.outlook.com (2603:10b6:408:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 02:13:20 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 02:13:20 +0000
From:   Wright Feng <Wright.Feng@cypress.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
Thread-Topic: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
Thread-Index: AQHWgCm2/NutJ8Wbqk+1pIJCKbhyy6lc635KgAAErACAAAfGlIAABaCAgABhL22AAKwqgA==
Date:   Tue, 8 Sep 2020 02:13:20 +0000
Message-ID: <6cc3759f-9dc5-f505-4878-33700e41fb73@cypress.com>
References: <20200901063237.15549-1-wright.feng@cypress.com>
 <20200901063237.15549-2-wright.feng@cypress.com>
 <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
 <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com>
 <0101017467f80c0c-9d33c4e2-53c3-486a-8dec-40e51161feb4-000000@us-west-2.amazonses.com>
 <9c5de429-ff6f-cad2-39a7-d5812fd3df09@cypress.com>
 <01010174692f7c3f-4b7369b2-0665-4324-b1c8-57bd22ac9ce7-000000@us-west-2.amazonses.com>
 <1746948ecc8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1746948ecc8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=cypress.com;
x-originating-ip: [210.241.230.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d69a3df7-0ee2-4e64-3e2e-08d8539cc206
x-ms-traffictypediagnostic: BN8PR06MB5619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB5619EEA48088B22FE56948C5FB290@BN8PR06MB5619.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlOSEGsYbnr8+Q1gVjpEQ5F+5MiVFlWJF+Vda7XFTvhp7PCSP7L3VH9Snv+BgI+mf6HP31Le5EZwJfJEjWet+vqoEXgg/5mO551TVthPc6KxH8OxMCmqBvxNo2Ew6zeTn2OkmfJ0rlI0g8wqzyhomrxyyc7iqsUt2hbl38fkBY37G46uQ55bXu6qGLysRkLgGDumT4UXD1xAggpoCl8GnEI4YqeCRs5SnrbuxLkhbqLMb7cOMbz0yeYg9LXAjoot6K30c1MDwJ8Anciv8rZOdT/EvVjCa7/7hkOxyo3plikI8l6Utvi+b4jUXxWxazlS64snNIyR7zvIEyURV21Xew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(5660300002)(31696002)(71200400001)(66556008)(66476007)(66446008)(66946007)(91956017)(76116006)(64756008)(8676002)(6506007)(6486002)(2616005)(110136005)(8936002)(478600001)(107886003)(6512007)(4326008)(54906003)(2906002)(316002)(86362001)(36756003)(26005)(186003)(31686004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6XbSKrjvgafx6x0JAnK062D+wKKpCSDTjtx2sVgb3T54orSKINhuqifmh1f+EK2uZeHKMPb3PlO8wV7RCXrRspeZWc0IoziDTaFS9E9785HUW972E+R2BtQt2/GTD+6LMBTu2V3PpWNmYiYR8dSdj7VOp7igqO2MsN+/f3ghh9IDtsdKYnncOY0iAdbQGjfs2zOPjzJiMT9DdfDKddYrOKQc3WgJxe6wVSGP8b4F3f43UwIzLGPER1W9KKhk7tObqMdI2RoTtqaSvtjwSkq7MVpkCdg69BxrViA6MyhKvkMKvScMVJwwStWCx4V4dXuYLKf0qsZ/ASqvxl45z9SapuuZbc96tUkphJsRuxRsJObk7C4C+PSZ55hl5n/Um4mXr1t5W40v00qBfutaQdh+ssaOqvBUc3LdEzY0/NBRha4+ppkFmJxAeOVbEBhCvez1lDNd00T3MNwMABejqsX3UYamdOQIkp17h7/nmnAp+o/SCmHflSeN+wbvuoo92IwJ/HeAdTiuOIjwxIFAEy185p1cBnA+SUuS1+kALXKcdLS5XXCvK6FM6yWn1b9WQD/Q0I61zSri6khM1diJxQqop0j8DErj8VCgDdY3JxdX1YZrRJ/nlASo9NhTX+8u5Ru/C570L92Jr0T6mnjmAQsuEw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C15F9D25C4AE774AA98E544618871ED6@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a3df7-0ee2-4e64-3e2e-08d8539cc206
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 02:13:20.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JdwKUGEZr4Z5GJfgjnvcklu6WUtL4V3tMr/28wToe8zSoP7L5o+OuBGE7PQj8iBBPj/dPt3CFnwUcxNsIjLEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5619
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCkFyZW5kIFZhbiBTcHJpZWwg5pa8IDkvNy8yMDIwIDExOjU3IFBNIOWvq+mBkzoNCj4gT24g
U2VwdGVtYmVyIDcsIDIwMjAgNToyOToxNCBQTSBLYWxsZSBWYWxvIDxrdmFsb0Bjb2RlYXVyb3Jh
Lm9yZz4gd3JvdGU6DQo+IA0KPj4gV3JpZ2h0IEZlbmcgPFdyaWdodC5GZW5nQGN5cHJlc3MuY29t
PiB3cml0ZXM6DQo+Pg0KPj4+Pj4+PiArYnJjbWZfY2ZnODAyMTFfY2hhbmdlX2JzcyhzdHJ1Y3Qg
d2lwaHkgKndpcGh5LCBzdHJ1Y3QgbmV0X2RldmljZSANCj4+Pj4+Pj4gKmRldiwNCj4+Pj4+Pj4g
K8KgIHN0cnVjdCBic3NfcGFyYW1ldGVycyAqcGFyYW1zKQ0KPj4+Pj4+PiArew0KPj4+Pj4+PiAr
IHN0cnVjdCBicmNtZl9pZiAqaWZwOw0KPj4+Pj4+PiArIGludCByZXQgPSAwOw0KPj4+Pj4+PiAr
IHUzMiBhcF9pc29sYXRlOw0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICsgYnJjbWZfZGJnKFRSQUNFLCAi
RW50ZXJcbiIpOw0KPj4+Pj4+PiArIGlmcCA9IG5ldGRldl9wcml2KGRldik7DQo+Pj4+Pj4+ICsg
aWYgKHBhcmFtcy0+YXBfaXNvbGF0ZSA+PSAwKSB7DQo+Pj4+Pj4+ICsgYXBfaXNvbGF0ZSA9ICh1
MzIpcGFyYW1zLT5hcF9pc29sYXRlOw0KPj4+Pj4+PiArIHJldCA9IGJyY21mX2ZpbF9pb3Zhcl9p
bnRfc2V0KGlmcCwgImFwX2lzb2xhdGUiLCBhcF9pc29sYXRlKTsNCj4+Pj4+Pg0KPj4+Pj4+IElz
IHRoZSBjYXN0IHRvIHUzMiByZWFsbHkgbmVjZXNzYXJ5PyBQbGVhc2UgYXZvaWQgY2FzdHMgYXMg
bXVjaCBhcw0KPj4+Pj4+IHBvc3NpYmxlLg0KPj4+Pj4NCj4+Pj4+IEl0IHNlZW1zIHRvIG1lLiBz
dHJ1Y3QgYnNzX3BhcmFtZXRlcnM6OmFwX2lzb2xhdGUgaXMgdHlwZWQgYXMgaW50LiBJdA0KPj4+
Pj4gaXMgcGFzc2VkIHRvIGJyY21mX2ZpbF9pb3Zhcl9pbnRfc2V0KCkgd2hpY2ggcmVxdWlyZXMg
YSB1MzIgKG1heWJlDQo+Pj4+PiBmdW5jdGlvbiBuYW1lIGlzIGNhdXNpbmcgdGhlIGNvbmZ1c2lv
bikuDQo+Pj4+DQo+Pj4+IFdoYXQgZXh0cmEgdmFsdWUgZG9lcyB0aGlzIGV4cGxpY2l0IHR5cGUg
Y2FzdGluZyBicmluZyBoZXJlPyBJIGRvbid0IA0KPj4+PiBzZWUNCj4+Pj4gaXQuIEltcGxpY2l0
IHR5cGUgY2FzdGluZyB3b3VsZCB3b3JrIHRoZSBzYW1lLCBubz8NCj4+Pg0KPj4+IFRoZSB2YWx1
ZSB3aWxsIGJlIC0xLCAwIG9yIDEuDQo+Pj4gSSB3aWxsIHN1Ym1pdCB2MiBwYXRjaCB0aGF0IGln
bm9yZXMgZG9pbmcgaW92YXIgaWYgZ2V0dGluZw0KPj4+IHBhcmFtcy0+YXBfaXNvbGF0ZSAtMSBh
bmQgcmVtb3ZlcyBleHBsaWNpdCB0eXBlIGNhc3RpbmcuIFRoYW5rcyBmb3IgdGhlDQo+Pj4gY29t
bWVudC4NCj4+DQo+PiBPaCwgSSBkaWRuJ3QgcmVhbGlzZSBhcF9pc29sYXRlIGNhbiBiZSAtMSBh
cyBzdHJ1Y3QgYnNzX3BhcmFtZXRlcnMNCj4+IGRpZG4ndCBkb2N1bWVudCB0aGF0LiBDYW4gc29t
ZW9uZSBzdWJtaXQgYSBwYXRjaCB0byBmaXggdGhhdD8NCj4+DQo+PiAqIEBhcF9pc29sYXRlOiBk
byBub3QgZm9yd2FyZCBwYWNrZXRzIGJldHdlZW4gY29ubmVjdGVkIHN0YXRpb25zDQo+IA0KPiBN
ZSB0b28uIEkgYXNzdW1lZCBpdCB3YXMgYSBib29sZWFuIHJlYWRpbmcgdGhhdCBkZXNjcmlwdGlv
bi4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFyZW5kDQo+IA0KVGhlIGFwX2lzb2xhdGUgLTEgdmFsdWUg
aW4gbmw4MDIxMV9zZXRfYnNzIG1lYW5zIG5vdCB0byBjaGFuZ2VkLkkgaW50ZW5kIA0KdG8gYWRk
IGEgY2hlY2sgb2YgInBhcmFtcy0+YXBfaXNvbGF0ZSA+PSAwIiBsaWtlDQphdGgvd2lsNjIxMC9j
Zmc4MDIxMS5jIGRvZXMgaW4gYnJjbWZfY2ZnODAyMTFfY2hhbmdlX2Jzcy4NCkFuZCBJIHdpbGwg
c3VibWl0IGFub3RoZXIgcGF0Y2ggdG8gcmV2aXNlIHRoZSBjb21tZW50IGluIGNmZzgwMjExLmgg
YXMgDQpiZWxvdy4gTGV0IG1lIGtub3cNCmlmIHlvdSBjb25jZXJuIGFib3V0IGl0Lg0KDQotLS0N
CmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9jZmc4MDIxMS5oIGIvaW5jbHVkZS9uZXQvY2ZnODAy
MTEuaA0KaW5kZXggZmM3ZTg4MDc4MzhkLi5mNjAyODFjODY2ZGMgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL25ldC9jZmc4MDIxMS5oDQorKysgYi9pbmNsdWRlL25ldC9jZmc4MDIxMS5oDQpAQCAtMTc2
NCw2ICsxNzY0LDcgQEAgc3RydWN0IG1wYXRoX2luZm8gew0KICAgICogICAgIChvciBOVUxMIGZv
ciBubyBjaGFuZ2UpDQogICAgKiBAYmFzaWNfcmF0ZXNfbGVuOiBudW1iZXIgb2YgYmFzaWMgcmF0
ZXMNCiAgICAqIEBhcF9pc29sYXRlOiBkbyBub3QgZm9yd2FyZCBwYWNrZXRzIGJldHdlZW4gY29u
bmVjdGVkIHN0YXRpb25zDQorICogICAgICgwID0gbm8sIDEgPSB5ZXMsIC0xID0gZG8gbm90IGNo
YW5nZSkNCiAgICAqIEBodF9vcG1vZGU6IEhUIE9wZXJhdGlvbiBtb2RlDQogICAgKiAgICAgKHUx
NiA9IG9wbW9kZSwgLTEgPSBkbyBub3QgY2hhbmdlKQ0KICAgICogQHAycF9jdHdpbmRvdzogUDJQ
IENUIFdpbmRvdyAoLTEgPSBubyBjaGFuZ2UpDQotLS0NCg0KUmVnYXJkcywNCldyaWdodA0KDQoN
Cg==
