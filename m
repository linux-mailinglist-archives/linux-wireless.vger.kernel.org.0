Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8E25F75F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgIGKJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 06:09:22 -0400
Received: from mail-dm6nam10on2116.outbound.protection.outlook.com ([40.107.93.116]:64434
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728317AbgIGKJV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrWEdg93J2229Oiq5YxXuDeb6rKCg7FP+g9kD+HU00U0hLgw3ci1RgOobnteWW7bB5vLVenvElmkPzOeghVtzk4oQoGhFyM/6iC/ww2BtLcVv7VFnHm/fUE2sWBSz0U3MTlYPG3LUMpbw1GTilBuD7XreswK78CPjDrvmOgn1tw7KhNr/w+RO62DFVk6IK3Xov3NGPx7el0/K0SBVbbiiXRw8UZMuugBUDXfBbz1pdPpDRx8pa8Bb+ZQolzMOSc6ig+I2CIeaDsZ5tXwrGgdQ+P9DgFseui/3vQR4MXCd3i1+X+OoybUuUiqZ5Ewd1GsIn4Eng23qfjpqMNTX9/IVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deHS/Fk14B6O0FNCZElpqFcPRHBOosnBXydmylUVEA8=;
 b=BkMUfYwnSp8RJx33+GS2ewm8IO51MC29UUYEw77lbfECJuJIG4jnIEHv/jcr3TeCLI10e18TCKlwzA4hWD4l3EN2Ax4tMMuveaCK6MirJtiv3lMtdNQNyN/HnlAtpGgbgMQorwIrFFloukGET/Jpban5HG6JeV7fZyJ4wPxMuJCUe7pmEnw5UolwANrRWpAMq46Ocng3z7/zj3UHYdKduP7N/jTdoeV6nGCYZ0ogxNZGs7P1vZmXpClpcdw+YAuwn25D9/P2L3GtucZWQ7oNM5GG325Td3MfWiAY2f202/j9LddP+QH/7M2v2hYTCb6a2pvYQeFHnnOIo7s1t47KZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deHS/Fk14B6O0FNCZElpqFcPRHBOosnBXydmylUVEA8=;
 b=DM1XFsyOnOYn/mqmu0HodgAVUowMttdgV0LvXwj9GuoSPbxsbvf/SKTm+qLXZUFDMTpvexPW99hnh48TLj8u2UFOEdTjSVkB06PubD1Hp9rbbeGtVio/2rxttP4P/dJ+Jo9YWW/Aup5jPqfwjQrE78X/zXpxb9fw4oxyKS+ikFE=
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB3985.namprd06.prod.outlook.com (2603:10b6:406:8f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 10:09:18 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:09:18 +0000
From:   Wright Feng <Wright.Feng@cypress.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
Thread-Topic: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
Thread-Index: AQHWgCm2/NutJ8Wbqk+1pIJCKbhyy6lc635KgAAErACAAAfGlIAABaCA
Date:   Mon, 7 Sep 2020 10:09:17 +0000
Message-ID: <9c5de429-ff6f-cad2-39a7-d5812fd3df09@cypress.com>
References: <20200901063237.15549-1-wright.feng@cypress.com>
 <20200901063237.15549-2-wright.feng@cypress.com>
 <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
 <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com>
 <0101017467f80c0c-9d33c4e2-53c3-486a-8dec-40e51161feb4-000000@us-west-2.amazonses.com>
In-Reply-To: <0101017467f80c0c-9d33c4e2-53c3-486a-8dec-40e51161feb4-000000@us-west-2.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=cypress.com;
x-originating-ip: [210.241.230.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 838f9a9d-3eaa-46a2-cfe7-08d853161513
x-ms-traffictypediagnostic: BN7PR06MB3985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB3985A32703A66A7119BEB859FB280@BN7PR06MB3985.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMyFR4iAOcLI6OAOwv4ITzFVfH/lxYjWTn3g7L6CuFDoHl+XCCaF35eUkUmQf2KUJFjddX2MeXUGXEqOexMh9I61fCMsQtEwWp0wocBMbhPRlThudDjMNgq6znq2+82mBdof3MiwliPbzw+Bh4N1i6BLeTkd3BdqHtP5I2Cmbi+IObA5Zy/ETpLHeOCaCI3+riimXq0SsjqlX+klnM1Ifn0w/I32rZEXjpDvvV4ljBThR0TRcVYccsTlKw1x/m7Fmm9cDulksfLokAZwoKdATR3pyCOV4IGcgZyhR6QAKFw861pPbRyq0jZe+Ng2/DLGFgPhjf1T1nR9sa8rYlryuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(83380400001)(66476007)(2616005)(4326008)(31686004)(71200400001)(76116006)(186003)(2906002)(91956017)(66946007)(66556008)(64756008)(26005)(66446008)(6512007)(6506007)(316002)(53546011)(36756003)(31696002)(86362001)(107886003)(110136005)(5660300002)(54906003)(8676002)(8936002)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cfXVuU0MX3qAY3X988u8VGVKzjQDvpIsPOrUy5B9pN1q6EYXPYIN4S0TtSMSqx+y8NVz1GhHEDo680sb5S9w1iWoXx10akO5oh+mAn0Eifb/UcDd5UmGEALPMpGQ3Dfdbn8e+4aKMrPGIemlXd3vbK2s2OHJv9I4Lvb/47dBcCuylyswUat1TS3pj94BlId+mqi5KTYlWMOTx5SxYcw9pPciq/gW/RMFM+MnYLkBNd6d3FrP0L/TlQpFg4/+pyAMkpTRhro5SokMUAEv3tzlZxvmzaG9M7tYPpMBVdk9sT+8/BWf4wd7vJ5fCcYkVQnf4gLaUq5QZf0aUSXgghs2evL1Fto3viDvwGoIuWruiUXK+oDB2DWxQB36RZoIU2wZBs4AzX6DHHNHOq8lbjgp733TOy0j6gIQYcoXAroa70fXQZeJzqUZTEjF3zG4cLKS63OOqNka32a4hgh4aXqxchvF1twFiM5Ovt7DEy58ys0PcMqw5a3e2zw4RjlftXu23DDzJ0yBUdu5NYyDfxKsHMLvK7oK8Wmgq5u0UkV94YJ8lKrkc67HzwujPIF/QzSr1nBH5jwgw1i7gu8nrX/XsuyAPmyHn96gTVk5ADcnurLisJsocijooCZoIN/IP3Y5MIuBsAKPa7bPuxXyLCfwjQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DC09E6007AFC84F9FCF1ABA3C457AD9@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838f9a9d-3eaa-46a2-cfe7-08d853161513
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 10:09:17.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Je6uu3Fi2HLYxsbcKKfn4HBAIuhXYouPNTGK9RE76VvIxN+v2fd4fADuljBk4fzQte/GgKSi3Zv1LLnnqFVZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3985
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCkthbGxlIFZhbG8g5pa8IDkvNy8yMDIwIDU6NDkgUE0g5a+r6YGTOg0KPiBBcmVuZCBWYW4g
U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPiB3cml0ZXM6DQo+IA0KPj4gT24g
OS83LzIwMjAgMTE6MDQgQU0sIEthbGxlIFZhbG8gd3JvdGU6DQo+Pj4gV3JpZ2h0IEZlbmcgPHdy
aWdodC5mZW5nQGN5cHJlc3MuY29tPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gSG9zdGFwIGhhcyBhIHBh
cmFtZXRlciAiYXBfaXNvbGF0ZSIgd2hpY2ggaXMgdXNlZCB0byBwcmV2ZW50IGxvdy1sZXZlbA0K
Pj4+PiBicmlkZ2luZyBvZiBmcmFtZXMgYmV0d2VlbiBhc3NvY2lhdGVkIHN0YXRpb25zIGluIHRo
ZSBCU1MuDQo+Pj4+IFJlZ2FyZGluZyBkcml2ZXIgc2lkZSwgd2UgYWRkIGNmZzgwMjExIG9wcyBt
ZXRob2QgY2hhbmdlX2JzcyB0byBzdXBwb3J0DQo+Pj4+IHNldHRpbmcgQVAgaXNvbGF0aW9uIGlm
IGZpcm13YXJlIGhhcyBhcF9pc29sYXRlIGZlYXR1cmUuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFdyaWdodCBGZW5nIDx3cmlnaHQuZmVuZ0BjeXByZXNzLmNvbT4NCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogQ2hpLWhzaWVuIExpbiA8Y2hpLWhzaWVuLmxpbkBjeXByZXNzLmNvbT4NCj4+Pj4gLS0t
DQo+Pj4+ICAgIC4uLi9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYyAgICB8
IDIzICsrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgLi4uL2Jyb2FkY29tL2JyY204MDIxMS9i
cmNtZm1hYy9mZWF0dXJlLmMgICAgIHwgIDEgKw0KPj4+PiAgICAuLi4vYnJvYWRjb20vYnJjbTgw
MjExL2JyY21mbWFjL2ZlYXR1cmUuaCAgICAgfCAgMyArKy0NCj4+Pj4gICAgMyBmaWxlcyBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2Zn
ODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1h
Yy9jZmc4MDIxMS5jDQo+Pj4+IGluZGV4IDVkOTk3NzFjM2Y2NC4uN2VmOTNjZDY2YjJjIDEwMDY0
NA0KPj4+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJj
bWZtYWMvY2ZnODAyMTEuYw0KPj4+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNv
bS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYw0KPj4+PiBAQCAtNTQyNSw2ICs1NDI1LDI2
IEBAIHN0YXRpYyBpbnQgYnJjbWZfY2ZnODAyMTFfZGVsX3BtayhzdHJ1Y3Qgd2lwaHkgKndpcGh5
LCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPj4+PiAgICAJcmV0dXJuIGJyY21mX3NldF9wbWso
aWZwLCBOVUxMLCAwKTsNCj4+Pj4gICAgfQ0KPj4+PiAgICArc3RhdGljIGludA0KPj4+PiArYnJj
bWZfY2ZnODAyMTFfY2hhbmdlX2JzcyhzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2LA0KPj4+PiArCQkJICBzdHJ1Y3QgYnNzX3BhcmFtZXRlcnMgKnBhcmFtcykNCj4+
Pj4gK3sNCj4+Pj4gKwlzdHJ1Y3QgYnJjbWZfaWYgKmlmcDsNCj4+Pj4gKwlpbnQgcmV0ID0gMDsN
Cj4+Pj4gKwl1MzIgYXBfaXNvbGF0ZTsNCj4+Pj4gKw0KPj4+PiArCWJyY21mX2RiZyhUUkFDRSwg
IkVudGVyXG4iKTsNCj4+Pj4gKwlpZnAgPSBuZXRkZXZfcHJpdihkZXYpOw0KPj4+PiArCWlmIChw
YXJhbXMtPmFwX2lzb2xhdGUgPj0gMCkgew0KPj4+PiArCQlhcF9pc29sYXRlID0gKHUzMilwYXJh
bXMtPmFwX2lzb2xhdGU7DQo+Pj4+ICsJCXJldCA9IGJyY21mX2ZpbF9pb3Zhcl9pbnRfc2V0KGlm
cCwgImFwX2lzb2xhdGUiLCBhcF9pc29sYXRlKTsNCj4+Pg0KPj4+IElzIHRoZSBjYXN0IHRvIHUz
MiByZWFsbHkgbmVjZXNzYXJ5PyBQbGVhc2UgYXZvaWQgY2FzdHMgYXMgbXVjaCBhcw0KPj4+IHBv
c3NpYmxlLg0KPj4NCj4+IEl0IHNlZW1zIHRvIG1lLiBzdHJ1Y3QgYnNzX3BhcmFtZXRlcnM6OmFw
X2lzb2xhdGUgaXMgdHlwZWQgYXMgaW50LiBJdA0KPj4gaXMgcGFzc2VkIHRvIGJyY21mX2ZpbF9p
b3Zhcl9pbnRfc2V0KCkgd2hpY2ggcmVxdWlyZXMgYSB1MzIgKG1heWJlDQo+PiBmdW5jdGlvbiBu
YW1lIGlzIGNhdXNpbmcgdGhlIGNvbmZ1c2lvbikuDQo+IA0KPiBXaGF0IGV4dHJhIHZhbHVlIGRv
ZXMgdGhpcyBleHBsaWNpdCB0eXBlIGNhc3RpbmcgYnJpbmcgaGVyZT8gSSBkb24ndCBzZWUNCj4g
aXQuIEltcGxpY2l0IHR5cGUgY2FzdGluZyB3b3VsZCB3b3JrIHRoZSBzYW1lLCBubz8NClRoZSB2
YWx1ZSB3aWxsIGJlIC0xLCAwIG9yIDEuDQpJIHdpbGwgc3VibWl0IHYyIHBhdGNoIHRoYXQgaWdu
b3JlcyBkb2luZyBpb3ZhciBpZiBnZXR0aW5nIA0KcGFyYW1zLT5hcF9pc29sYXRlIC0xIGFuZCBy
ZW1vdmVzIGV4cGxpY2l0IHR5cGUgY2FzdGluZy4gVGhhbmtzIGZvciB0aGUgDQpjb21tZW50Lg0K
