Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46213D9DA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 13:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPMYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 07:24:12 -0500
Received: from mail-db8eur05on2118.outbound.protection.outlook.com ([40.107.20.118]:38337
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgAPMYL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 07:24:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA0NNVamPQgv7hXzO89dGTNc64/QKLFk7YtQlSEeylBX7g6zfZm2jmftyN03J70w7yV3hGmWA6kie/Ouu2IhX5PW0/0+NP0+uts3EBSP2gyx64MCrnWoHG52qvgFDhacL71nlN8P9SRHjQglDbseaut/L3im0a9y3Lq/s650Ir4xumWBJoGkm17W8gwrgkCD6g6OPDql1n1adkU31joprVN45t9vv2o7ml9k657/RkV3V65H4YBDnjQB++u4/36pOtrq4bY8gHGPCrgUgvOSuUAzmZFBpuu4Uf5IyU0Qn3J0nTCBhI2EzeEfxWKvWRHwg7Qr0LA83LAnPVmkUSXVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpZ7FpuN93yupEb+ZgFZ2BCfE+HaWLqAx6nc5YwzX4U=;
 b=FKTcQZ19Simk58vsfzsSYvHaKeT5OawRdCKjbAdXfXoarcXAwYP+HmG67A3EFGQvg6YJ++gWQOb3SnUS475ZcG6omnGYjkzPkh7v/j+9mKHExxCup9zBC8O0XV0+4vzpd64UCQKEhGhHv7qucLUKjxNuk/Mwt44FxUEr3Vqx0W1Ao49VecC3YqtM3Rqk+EYh00FoNklhvEjVMXqRAagDwDiFAjxeog7PpKCsOACqkB+YHCvanAU3ea19ZSYthgZtD4IpyeyOKzLbGNtY43Ibh3NuS2nfblNzEe7RZKl4uY773cfKSfhV4yRhNjtGFHmyRtMkqKJ/i6+oRSHQo5OwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpZ7FpuN93yupEb+ZgFZ2BCfE+HaWLqAx6nc5YwzX4U=;
 b=LQr5fO/VAjtkIhfNua/NDvgrAtvJuY1y0NHLl5EG1VYR7QeKFUXMLsH93Vzls2eE/25GI/88hidIoast12C2Jy3JIw1tQvxsZqzjz1VFV9j7Pdkz66UTL5oy6VTv0H0XjWuvUVKt2Carb6eh1Sl5PDFQ+YTzxkGtAP//bpaZxjU=
Received: from AM0PR02MB3620.eurprd02.prod.outlook.com (52.133.63.21) by
 AM0PR02MB5009.eurprd02.prod.outlook.com (20.178.21.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 12:23:56 +0000
Received: from AM0PR02MB3620.eurprd02.prod.outlook.com
 ([fe80::cc09:22f:6786:819c]) by AM0PR02MB3620.eurprd02.prod.outlook.com
 ([fe80::cc09:22f:6786:819c%5]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 12:23:55 +0000
From:   Orr Mazor <orr.mazor@tandemg.com>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] cfg80211: Fix regulatory data is reset in case all phys
 have disconnected
Thread-Topic: [PATCH] cfg80211: Fix regulatory data is reset in case all phys
 have disconnected
Thread-Index: AQHVy7TG5nX+3c3iBUKSj4Vf+8rn0afr42cAgAExk+A=
Date:   Thu, 16 Jan 2020 12:23:55 +0000
Message-ID: <AM0PR02MB3620B9D7A4F68BA601B0445FEF360@AM0PR02MB3620.eurprd02.prod.outlook.com>
References: <20200115150123.7612-1-Orr.Mazor@tandemg.com>
 <CAKR_QVJkVSCuzZWgOxxmkffTYG3pgX4ZX_vvw-6Th5=tvs7ovg@mail.gmail.com>
In-Reply-To: <CAKR_QVJkVSCuzZWgOxxmkffTYG3pgX4ZX_vvw-6Th5=tvs7ovg@mail.gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=orr.mazor@tandemg.com; 
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef78c8be-9c17-4f5a-3126-08d79a7ef4c8
x-ms-traffictypediagnostic: AM0PR02MB5009:
x-microsoft-antispam-prvs: <AM0PR02MB50095A2D773E7B06BC060AE9EF360@AM0PR02MB5009.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(366004)(136003)(396003)(376002)(189003)(199004)(8936002)(71200400001)(86362001)(81166006)(2906002)(81156014)(8676002)(15650500001)(66446008)(66556008)(186003)(44832011)(5660300002)(66476007)(6916009)(26005)(76116006)(66946007)(64756008)(316002)(33656002)(54906003)(6506007)(9686003)(508600001)(55016002)(4326008)(7696005)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5009;H:AM0PR02MB3620.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzX/U7I0GnQyXKgaW4XuSPFvdd9GG3GT7AgaC5ns+r4E428ide/q8chbjHT1d8FlGWUYYojAVDRVRzYwSK2w0BcDkwQhJrqd78mN93VzJ8d8eBWrl7wlxwf+Pg0MPXhPPumzvmnggtJDS7GTFCIXza16jBZHSsP33i01KvcXCAPNaNS3TetASJZ/8oV0jLC0qNTElO/jamgiF5RKBxrqzIE2JUo63Ap1Vzi7EjQVQ9LuHd+/6tlPElHp8DRpi/wR18gNKKnMo1x5cZ9tSLX6/7zG9aAA4C5GYZ7hvs+/QEsV76SRfcXwh0gK22dkoDmLGc4BzlFbHzrxx2LeFVQhALDL9/Eo95e/vax37VGAvR9xw5piDi/+VvQ8kKGWZb6jMvve5jhAZXPK48twRcNSK8WmdTa5ASmggW9O5nmWo1oEMDtkASD8+N6O9TpZJVjd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef78c8be-9c17-4f5a-3126-08d79a7ef4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 12:23:55.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/D1Q/RlxT7VSokiEkRUCJpiv+5woDnNQ7oLhTAJD8Axm+s+V+D3ErwtLA8dfAbzs2YtDtd1ZTcrm7KvlbF+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5009
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pk9uIDE1LzAxLzIwMjAsIE9yciBNYXpvciA8b3JyLm1hem9yQHRhbmRlbWcuY29tPiB3cm90ZToN
Cj4+IEluIGNhc2Ugbm8gb25lIGlzIG9jY3VweWluZyBhIHdpcGh5LCBhbGwgcGFzdCByZWd1bGF0
b3J5IGRhdGEgd2lsbCBiZQ0KPj4gbG9zdCBhcyBhIHJlc3VsdCBvZiByZXNldCB0byB3b3JsZCBy
ZWcgZG9tYWluLg0KPj4NCj4+IFRoaXMgaW5jbHVkZXMgYW55IGNoYW5uZWwgdGhhdCBpcyBjdXJy
ZW50bHkgaW4gTk9QIHRpbWUgYXMgd2VsbCBhcyBpbg0KPj4gQVZBSUxBQkxFIHN0YXRlLg0KPj4N
Cj4+IFRoaXMgbWVhbnMgdGhhdCBhZnRlciBkZXRlY3RpbmcgYSByYWRhciBvbiBhIGNoYW5uZWwg
dGhlIHVzZXIgbWlnaHQgYmUNCj4+IGFibGUgdG8gc2ltcGx5IHJlc2V0IGhvc3RhcGQgYW5kIGdl
dCBiYWNrIHRvIHRoYXQgY2hhbm5lbCwgdGhpcyBpcyBhDQo+PiBtYWpvciBpc3N1ZS4NCj4+DQo+
PiBUbyBzb2x2ZSB0aGlzIEkgaGF2ZSBhZGRlZCBhIGNoZWNrIGJlZm9yZSBkb2luZyBhbnkgcmVz
ZXRzLg0KPj4NCj4+IElmIHRoZSB1c2VyIChmb3IgZXhhbXBsZTogaG9zdGFwZCkgYXNrcyBmb3Ig
YSByZWdkb21haW4gYW5kIHdlIGFyZQ0KPj4gYWxyZWFkeSBpbiB0aGF0IHJlZ2RvbWFpbiwgdGhh
biB3ZSBzaG91bGRuJ3QgcmVzZXQgdGhhdCByZWdkb21haW4gaW4NCj4+IGNhc2Ugb2Ygd2lwaHkg
ZGlzY29ubmVjdGlvbiAoZm9yIGV4YW1wbGU6IGhvc3RhcGQgcmVzZXQgb3Iga2lsbGVkKS4NCj4+
DQo+PiBUaGF0IHdheSB0aGUgcmVndWxhdG9yeSBkYXRhIHdpbGwgYmUgc2F2ZWQgYXMgbG9uZyBh
cyB3ZSBhcmUgaW4gdGhlDQo+PiBzYW1lIHJlZ2RvbWFpbi4NCj4+DQo+PiBTaW5jZSBpbiB0aGF0
IGNhc2Ugd2Ugd2lsbCBhbnl3YXkgZ2V0IGJhY2sgdG8gdGhlIHNhbWUgcmVnZG9tYWluIHRoZQ0K
Pj4gb25seSBkaWZmZXJlbmNlIGlzIHdlIHdpbGwgbm93IHNhdmUgdGhlIHJlZ3VsYXRvcnkgZGF0
YSwgd29uJ3QgbG9zZQ0KPj4gaXQsIGFuZCBhcyBhIHJlc3VsdCB3b24ndCBnZXQgYmFjayB0byBh
IGNoYW5uZWwgdGhhdCBhIHJhZGFyIHdhcw0KPj4gZGV0ZWN0ZWQgb24gdW50aWwgTk9QIHdpbGwg
YmUgZmluaXNoZWQsIGFzIHNob3VsZCBiZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBPcnIgTWF6
b3IgPE9yci5NYXpvckB0YW5kZW1nLmNvbT4NCj4+IC0tLQ0KPj4gIG5ldC93aXJlbGVzcy9yZWcu
YyB8IDEwICsrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvd2lyZWxlc3MvcmVnLmMgYi9uZXQvd2lyZWxlc3MvcmVn
LmMgaW5kZXgNCj4+IGQxOGNjMDUwNjFhMC4uNTA0OWM0ODc5NTBiIDEwMDY0NA0KPj4gLS0tIGEv
bmV0L3dpcmVsZXNzL3JlZy5jDQo+PiArKysgYi9uZXQvd2lyZWxlc3MvcmVnLmMNCj4+IEBAIC0z
MTgwLDYgKzMxODAsMTYgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9yZWd1bGF0b3J5X3NldHRpbmdz
KGJvb2wNCj4+IHJlc2V0X3VzZXIsIGJvb2wgY2FjaGVkKQ0KPj4gIAl9DQo+PiAgCXNwaW5fdW5s
b2NrKCZyZWdfaW5kb29yX2xvY2spOw0KPj4NCj4+ICsJLyogSWYgdGhlIHVzZXIgYXNrcyBmb3Ig
YSByZWdkb21haW4gYW5kIHdlIGFyZQ0KPj4gKwkgKiBhbHJlYWR5IGluIHRoYXQgcmVnZG9tYWlu
LCB0aGFuIHdlIHNob3VsZG4ndCByZXNldA0KPj4gKwkgKiB0aGUgcmVnZG9tYWluIGluIHRoZSBj
YXNlIG9mIHdpcGh5IGRpc2Nvbm5lY3Rpb24uDQo+PiArCSAqLw0KPj4gKwlpZiAoY2FjaGVkICYm
ICFyZXNldF91c2VyICYmDQo+PiArCSAgICAoIUlTX0VSUl9PUl9OVUxMKGNmZzgwMjExX3VzZXJf
cmVnZG9tKSkgJiYNCj4+ICsJICAgICghcmVnZG9tX2NoYW5nZXMoY2ZnODAyMTFfdXNlcl9yZWdk
b20tPmFscGhhMikpKSB7DQo+PiArCQlyZXR1cm47DQo+PiArCX0NCj4+ICsNCj4+ICAJcmVzZXRf
cmVnZG9tYWlucyh0cnVlLCAmd29ybGRfcmVnZG9tKTsNCj4+ICAJcmVzdG9yZV9hbHBoYTIoYWxw
aGEyLCByZXNldF91c2VyKTsNCj4+DQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg0KPj4NCj4NCj5XaGlj
aCBkZXZpY2UgaGF2ZSB5b3UgdGVzdGVkIHRoaXMgb24/DQoNCkhpIFRvbSwNCg0KSSBoYXZlIHRl
c3RlZCB0aGlzIG9uIG1hYzgwMjExX2h3c2ltIGFuZCBvbiBhIGludGVsIHByb3ByaWV0YXJ5IGRl
dmljZS4NClRoZSBpc3N1ZSAoYmVmb3JlIHRoZSBwYXRjaCkgaXMgc2VlbiBpbiBib3RoLCBhbmQg
dGhlIHBhdGNoIHNvbHZlcyBpdCBpbiBib3RoLg0KDQpCUiwNCk9ycg0K
