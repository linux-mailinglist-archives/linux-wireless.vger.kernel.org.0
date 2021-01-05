Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1532EA37D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 03:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAEC4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 21:56:36 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49053 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAEC4f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 21:56:35 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1052tbOlB003872, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs02.realtek.com.tw[172.21.6.95])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1052tbOlB003872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 5 Jan 2021 10:55:37 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.28) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 5 Jan 2021 10:55:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 5 Jan 2021 10:55:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Tue, 5 Jan 2021 10:55:37 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Thomas Backlund <tmb@tmb.nu>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH V2 00/18] rtw89: add Realtek 802.11ax driver
Thread-Topic: [PATCH V2 00/18] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHW4rb2sbY35yS6R0SLM7mJTr9EyaoYVVYw
Date:   Tue, 5 Jan 2021 02:55:37 +0000
Message-ID: <a1e2fe9670f64294b9a0f5baf33716e5@realtek.com>
References: <8b91811c-09d4-3ccb-1e7b-bb1c9fe77f9d@tmb.nu>
In-Reply-To: <8b91811c-09d4-3ccb-1e7b-bb1c9fe77f9d@tmb.nu>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21hcyBCYWNrbHVuZCBb
bWFpbHRvOnRtYkB0bWIubnVdDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMDUsIDIwMjEgMTI6
MzEgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUGtzaGlo
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMDAvMThdIHJ0dzg5OiBhZGQgUmVhbHRlayA4MDIu
MTFheCBkcml2ZXINCj4gDQo+IERlbiA0LjEuMjAyMSBrbC4gMTE6MTcsIHNrcmV2IFBpbmctS2Ug
U2hpaDoNCj4gPiBUaGlzIGRyaXZlciBuYW1lZCBydHc4OSwgd2hpY2ggaXMgdGhlIG5leHQgZ2Vu
ZXJhdGlvbiBvZiBydHc4OCwgc3VwcG9ydHMNCj4gPiBSZWFsdGVrIDg4NTJBRSA4MDIuMTFheCAy
eDIgY2hpcCB3aG9zZSBuZXcgZmVhdHVyZXMgYXJlIE9GRE1BLCBEQkNDLA0KPiA+IFNwYXRpYWwg
cmV1c2UsIFRXVCBhbmQgQlNTIGNvbG9yaW5nOyBub3cgc29tZSBvZiB0aGVtIGFyZW4ndCBpbXBs
ZW1lbnRlZA0KPiA+IHRob3VnaC4NCj4gPg0KPiANCj4gSGksIGZvciBzb21lIHJlYXNvbiBwYXRj
aCAxNi8xOCBkb2VzIG5vdCBzaG93IHVwIGluIHBhdGNod29yay4NCg0KSSdtIG5vdCBzdXJlIHdo
YXQgaGFwcGVuZWQsIGJ1dCBpdCdzIHRoZXJlIG5vdy4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIxMDEwNDA5MjAzNi4xNjA4OS0x
NC1wa3NoaWhAcmVhbHRlay5jb20vDQoNCj4gDQo+IFdoZXJlIGNhbiBvbmUgZ2V0IHRoZSBuZWVk
ZWQgZmlybXdhcmU6DQo+IA0KPiAkIG1vZGluZm8gcnR3ODlfY29yZS5rby54eiAgfGdyZXAgZmly
bXdhcmUNCj4gZmlybXdhcmU6ICAgICAgIHJ0dzg5L3J0dzg4NTJhX2Z3LmJpbg0KDQpXZSBhcmUg
c3RpbGwgd29ya2luZyBvbiBhIHN0YWJsZSBmaXJtd2FyZS4NCklmIHlvdSBuZWVkIGFuIGFscGhh
IHZlcnNpb24gZmlybXdhcmUsIEkgY2FuIHNlbmQgeW91IGEgY29weSBwcml2YXRlbHkuDQoNCj4g
DQo+IA0KPiBBbHNvLCB0aGUgZHJpdmVyIGlzIG1pc3NpbmcgdGhlIHBjaSBhbGlhcyB0byBnZXQg
YXV0b2xvYWRpbmcgdG8gd29yaywNCj4gbGlrZSB0aGUgYXR0YWNoZWQgcGF0Y2guDQoNCkknbGwg
bWVyZ2UgaXQgaW50byBWMy4NCg0KVGhhbmsgeW91DQoNCi0tLQ0KUGluZy1LZQ0KDQo=
