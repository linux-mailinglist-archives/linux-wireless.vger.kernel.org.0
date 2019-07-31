Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822487BE18
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGaKMh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 06:12:37 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:15701
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfGaKMh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 06:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiYInAu34r4k/4jBnS0nz0NMLzqiGZg2VwIrcXBBRXdT3pl+sq4tJpmn8xigYV+vbx4kwmqpQlaUQaXfbVtE8Sr6pLjvBkyCLUIwBs80go3F7hM0XPqO021LoVolX+NVepW2zq2FK4EXVRkT1HU9t9CtsTZ1nyiq6fpmQ3o8Y6/LezBPhXe8YRV1hz/Q2Z57Nq7QFGl8NccUNeBwCxeRAFj6QCHztjozbSl0XZN6oO9RU0eGyR8UpF3Gom4NFTgDb1XeuyHC5jt2Ol/d2KKwWdO1InyjReJqCrFRuGEG1LXI+lPh8NKUDSYrLjRcbcH9Mbt5BO7o/Gki8Etlmm9H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrmzREEEf7GmTbR28KXQpPQmiQYaNdNtkkKZo2nseps=;
 b=kYck4Ve2WnA+UoV14v5obZLXzuxm2KX0fjdxjJGHHcttUCELkrgMnms211+ZKHIMCdhqmXKyQN5ZI6vLIZmr9Drn4l98X/5xntXyj/LlRw6aicqON7GGixXp4G/1MlLjDUyjsk2N5TUe2+vxtlNCdaehbSlvkzrxHmCoMV+7AY0F6+nTHk4n32D6vTUKsxUvwLDA6xsvYhHWNWnsMYxxCnv5rpDKOHFANq9nGB+hv+PXruyRit33/xvAVd9E8zh1rYSXlDgaS6q8x2F3sgT4Jvl88ZCmRLStVqVvh+uSy/V9eDamu67kgCKJb5aF5sKPaU37rOZm1RhyeCSSlN4lzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=celeno.com;dmarc=pass action=none
 header.from=celeno.com;dkim=pass header.d=celeno.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Celeno.onmicrosoft.com; s=selector2-Celeno-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrmzREEEf7GmTbR28KXQpPQmiQYaNdNtkkKZo2nseps=;
 b=YFilNGKTkKLOwIon50gBRZ9uZWuV6SoC7fC3xATMKnI1pO9ms0Fu4ySYOJQ44qrui/Tq7XJn+TKwOHn9l4ceOaWMiV2y8A7Oa0+PW4TtVno4UwVQGVpmgnwI3WRvPkbtdYDWOSDsCURv+b5MOBc/jNQxCOuwNq1uf4N5wBCEjJs=
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM (10.175.12.18) by
 AM5P192MB0035.EURP192.PROD.OUTLOOK.COM (10.175.12.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 10:12:31 +0000
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::cd45:83a8:1e94:3186]) by AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::cd45:83a8:1e94:3186%11]) with mapi id 15.20.2115.005; Wed, 31 Jul
 2019 10:12:31 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: HE STA disassoc due to QOS NULL not sent
Thread-Topic: [PATCH] mac80211: HE STA disassoc due to QOS NULL not sent
Thread-Index: AQHVMaHe+tk2GOHxokCZlAiE/Qo8Z6bkl8vhgAATeoA=
Date:   Wed, 31 Jul 2019 10:12:31 +0000
Message-ID: <AM5P192MB0226D165AF722EB4E578405CE7DF0@AM5P192MB0226.EURP192.PROD.OUTLOOK.COM>
References: <20190703131848.22879-1-shay.bar@celeno.com>
         (sfid-20190703_151855_846208_5223FFC3)
 <5957aa7cc7dcd1cf24bd81bcdff419a27c7782aa.camel@sipsolutions.net>
In-Reply-To: <5957aa7cc7dcd1cf24bd81bcdff419a27c7782aa.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shay.Bar@celeno.com; 
x-originating-ip: [217.132.134.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 433838fe-658d-4c2b-bd7c-08d7159f996e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5P192MB0035;
x-ms-traffictypediagnostic: AM5P192MB0035:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM5P192MB0035680CA8CF41F72187A483E7DF0@AM5P192MB0035.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(396003)(39840400004)(136003)(366004)(13464003)(26244003)(189003)(199004)(26234003)(66446008)(64756008)(66556008)(71200400001)(102836004)(26005)(66946007)(14454004)(99286004)(66066001)(76116006)(3846002)(86362001)(81166006)(6246003)(186003)(7696005)(71190400001)(76176011)(4326008)(256004)(52536014)(53936002)(5660300002)(53546011)(966005)(478600001)(25786009)(8676002)(81156014)(14444005)(6116002)(6506007)(66476007)(11346002)(8936002)(6436002)(68736007)(476003)(446003)(55016002)(9686003)(6306002)(305945005)(7736002)(316002)(229853002)(33656002)(74316002)(16799955002)(2906002)(486006)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5P192MB0035;H:AM5P192MB0226.EURP192.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: celeno.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1MiNja12Dd+sdqPjaIx7AjP81pwldez9Hgpr3tU/wPKKH41dLevs82CaSpBt+3ACh0JWC7fPEzmL3X6iBoA4TMsPm07RES30jHWTjzTyx30sEgs3HGWxy48jVU1U5Wilx+RZczOhCsLVEJ/LHpnNK7PeXh4ebtBP2BcpJY4Je5b5lZi/ngq3xkjz9AWXILbA/2aTGs+ide6LuohpBMTRvUOcH1262l5lKwQgsdDXgYRE0LlylRz+zoS7+9b5c0K7uVfgcxy1TKSmGM3l9iMmDPW4p7CFaUskQ1uu/Pjyv4PNXprwm2SdytiK4ix39AvlQqP6k/4rBdUVCqsBxyk5bD3R6QDiZtxIGQehBT9RxaC6N1Qowobp2Q58oV0/FRcYtuxD1A46Z/ZlgW67Lj8RNd6gmfq0cIv858ggW9dxbqE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433838fe-658d-4c2b-bd7c-08d7159f996e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 10:12:31.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Shay.Bar@celeno.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P192MB0035
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSm9oYW5uZXMsDQpTdGF0aW9uIG1heSByZWNlaXZlIGEgYmVhY29uIGZyb20gdGhlIEFQIHRo
YXQgd2lsbCByZWFybSB0aGUgYmNuX21vbl90aW1lci4NCklmIGl0IHdpbGwgbm90IGdldCBhIGJl
YWNvbiB3aXRoaW4gdGhlIHRpbWVvdXQsIGl0IHdpbGwgZGlzY29ubmVjdC4NCkluIG15IHRlc3Qg
Y2FzZSwgYmVhY29uIGFycml2ZWQgbGF0ZXIgKHdpdGhpbiB0aGUgdGltZW91dCkuDQpXaXRob3V0
IHRoaXMgcGF0Y2gsIFNUQSAod3JvbmdseSkga2lja2VkIG91dCB0aGUgQVAgd2l0aG91dCBldmVu
IHNlbmRpbmcgUU9TIE5VTEwuDQpXaXRoIHRoaXMgcGF0Y2gsIFNUQSBrZWVwcyBBUCBhc3NvY2lh
dGVkIGFuZCB3aWxsIG9ubHkgZGlzYXNzb2MgaWYgYmVhY29uIHRpbWVvdXQgd2lsbCBwYXNzLg0K
DQpUaGFua3MsDQpTaGF5DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBsaW51
eC13aXJlbGVzcy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXdpcmVsZXNzLW93bmVyQHZn
ZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEpvaGFubmVzIEJlcmcNClNlbnQ6IFdlZG5lc2Rh
eSwgMzEgSnVseSAyMDE5IDExOjU0DQpUbzogU2hheSBCYXIgPFNoYXkuQmFyQGNlbGVuby5jb20+
DQpDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
XSBtYWM4MDIxMTogSEUgU1RBIGRpc2Fzc29jIGR1ZSB0byBRT1MgTlVMTCBub3Qgc2VudA0KDQpF
eHRlcm5hbCBFbWFpbA0KDQoNCk9uIFdlZCwgMjAxOS0wNy0wMyBhdCAxNjoxOCArMDMwMCwgU2hh
eSBCYXIgd3JvdGU6DQo+IEluIGNhc2Ugb2YgSEUgQVAtU1RBIGxpbmssIGllZWU4MDIxMV9zZW5k
X251bGxmdW5jKCkgd2lsbCBub3Qgc2VuZCB0aGUgUU9TIE5VTEwgcGFja2V0IHRvIGNoZWNrIGlm
IEFQIGlzIHN0aWxsIGFzc29jaWF0ZWQuDQo+IEluIHRoaXMgY2FzZSwgcHJvYmVfc2VuZF9jb3Vu
dCB3aWxsIGJlIG5vbiB6ZXJvIGFuZCBpZWVlODAyMTFfc3RhX3dvcmsoKSB3aWxsIGxhdGVyIGRp
c2Fzc29jaWF0ZSB0aGUgQVAuDQo+IChhbHRob3VnaCBpdCBkaWRuJ3QgcmVhbGx5IHNlbmQgYSB0
ZXN0IFFPUyBOVUxMIHBhY2tldCkuDQo+IEZpeCBpcyB0byBkZWNyZW1lbnQgcHJvYmVfc2VuZF9j
b3VudCBhbmQgbm90IGNhbGwgaWVlZTgwMjExX3NlbmRfbnVsbGZ1bmMoKSBpbiBjYXNlIG9mIEhF
IGxpbmsuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNoYXkgQmFyIDxzaGF5LmJhckBjZWxlbm8uY29t
Pg0KPiAtLS0NCj4gSG9wZSBJIHNvbHZlZCBhbGwgdGhlIFNNVFAgc2VydmVyIHByb2JsZW1zIGFu
ZCBwYXRjaCBpcyBiZXR0ZXIgbm93IDopDQoNClllcCwgdGhhbmtzLg0KDQo+ICAgICAgIGlmIChp
ZWVlODAyMTFfaHdfY2hlY2soJnNkYXRhLT5sb2NhbC0+aHcsIFJFUE9SVFNfVFhfQUNLX1NUQVRV
UykpIHsNCj4gICAgICAgICAgICAgICBpZm1nZC0+bnVsbGZ1bmNfZmFpbGVkID0gZmFsc2U7DQo+
IC0gICAgICAgICAgICAgaWVlZTgwMjExX3NlbmRfbnVsbGZ1bmMoc2RhdGEtPmxvY2FsLCBzZGF0
YSwgZmFsc2UpOw0KPiArICAgICAgICAgICAgIGlmICghKGlmbWdkLT5mbGFncyAmIElFRUU4MDIx
MV9TVEFfRElTQUJMRV9IRSkpDQo+ICsgICAgICAgICAgICAgICAgICAgICBpZm1nZC0+cHJvYmVf
c2VuZF9jb3VudC0tOw0KPiArICAgICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIGllZWU4MDIxMV9zZW5kX251bGxmdW5jKHNkYXRhLT5sb2NhbCwgc2RhdGEsIGZhbHNlKTsN
Cg0KTm90IHN1cmUgdGhhdCBtYWtlcyBzZW5zZSB0aG91Z2guDQoNCldoeSBnbyB0aHJvdWdoIGFs
bCB0aGUgbW90aW9ucyBvZiBkb2luZyB0aGUgY291bnRpbmcgYW5kIGFsbCwgYW5kIHRoZQ0KcnVu
X2FnYWluKCkgZXRjLiB3aGVuIGFsbCB0aGF0IHdpbGwgaGFwcGVuIGlzIHRoYXQgd2UnbGwgZGlz
Y29ubmVjdA0KYW55d2F5Pw0KDQpqb2hhbm5lcw0KDQoNCi0tLS0tLS0tLS0NCg0KVGhpcyBlbWFp
bCBoYXMgYmVlbiBzY2FubmVkIGZvciBzcGFtIGFuZCB2aXJ1c2VzIGJ5IFByb29mcG9pbnQgRXNz
ZW50aWFscy4gVmlzaXQgdGhlIGZvbGxvd2luZyBsaW5rIHRvIHJlcG9ydCB0aGlzIGVtYWlsIGFz
IHNwYW06DQpodHRwczovL2V1MS5wcm9vZnBvaW50ZXNzZW50aWFscy5jb20vaW5kZXgwMS5waHA/
bW9kX2lkPTExJm1vZF9vcHRpb249bG9naXRlbSZtYWlsX2lkPTE1NjQ1NjMyNTItNnpvQXFFYTNR
UlJPJnJfYWRkcmVzcz1zaGF5LmJhciU0MGNlbGVuby5jb20mcmVwb3J0PTENCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpUaGUgaW5mb3JtYXRpb24gdHJhbnNtaXR0ZWQgaXMgaW50
ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVz
c2VkIGFuZCBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kL29yIHByaXZpbGVnZWQgbWF0ZXJp
YWwuIEFueSByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiwgY29weWluZyBvciBvdGhlciB1
c2Ugb2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIHVwb24gdGhpcyBpbmZv
cm1hdGlvbiBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZWQgdGhpcyBpbiBlcnJvciwgcGxl
YXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIHRoZSBtYXRlcmlhbCBmcm9tIGFueSBj
b21wdXRlci4gTm90aGluZyBjb250YWluZWQgaGVyZWluIHNoYWxsIGJlIGRlZW1lZCBhcyBhIHJl
cHJlc2VudGF0aW9uLCB3YXJyYW50eSBvciBhIGNvbW1pdG1lbnQgYnkgQ2VsZW5vLiBObyB3YXJy
YW50aWVzIGFyZSBleHByZXNzZWQgb3IgaW1wbGllZCwgaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0
ZWQgdG8sIGFueSBpbXBsaWVkIHdhcnJhbnRpZXMgb2Ygbm9uLWluZnJpbmdlbWVudCwgbWVyY2hh
bnRhYmlsaXR5IGFuZCBmaXRuZXNzIGZvciBhIHBhcnRpY3VsYXIgcHVycG9zZS4NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQoNCg==
