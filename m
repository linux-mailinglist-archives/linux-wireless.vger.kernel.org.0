Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33D2AFED2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgKLFih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:37 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58546 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgKLCYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 21:24:53 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC2OkpjE009288, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC2OkpjE009288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 10:24:46 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.36) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 10:24:46 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 12 Nov 2020 10:24:46 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Thu, 12 Nov 2020 10:24:46 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 08/11] rtw88: coex: fix BT performance drop during initial/power-on step
Thread-Topic: [PATCH 08/11] rtw88: coex: fix BT performance drop during
 initial/power-on step
Thread-Index: AQHWt9GB3rY5LAo9kUSk6W4aRWYDnanCnEiDgAEpn1A=
Date:   Thu, 12 Nov 2020 02:24:46 +0000
Message-ID: <d99fca79569f4da2bf58fe293007f6e5@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
        <20201111022108.9834-9-pkshih@realtek.com>
 <87wnysb86b.fsf@codeaurora.org>
In-Reply-To: <87wnysb86b.fsf@codeaurora.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbToga3ZhbG89Y29kZWF1cm9y
YS5vcmdAbWcuY29kZWF1cm9yYS5vcmcgW21haWx0bzprdmFsbz1jb2RlYXVyb3JhLm9yZ0BtZy5j
b2RlYXVyb3JhLm9yZ10gT24NCj4gQmVoYWxmIE9mIEthbGxlIFZhbG8NCj4gU2VudDogV2VkbmVz
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMCA0OjM4IFBNDQo+IFRvOiBQa3NoaWgNCj4gQ2M6IHRvbnkw
NjIwZW1tYUBnbWFpbC5jb207IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDA4LzExXSBydHc4ODogY29leDogZml4IEJUIHBlcmZvcm1hbmNlIGRy
b3AgZHVyaW5nIGluaXRpYWwvcG93ZXItb24gc3RlcA0KPiANCj4gPHBrc2hpaEByZWFsdGVrLmNv
bT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiBDaGluZy1UZSBLdSA8a3U5MjA2MDFAcmVhbHRlay5j
b20+DQo+ID4NCj4gPiBGb3JjZSBzZXQgdGhlIGNvZXhpc3RlbmNlIHRvIEJUIGhpZ2ggcHJpb3Jp
dHkgZHVyaW5nDQo+ID4gV0xBTiBpbml0aWFsL3Bvd2VyLW9uIHN0ZXAuIFNpbmNlIHRoZSBkdXJh
dGlvbiB0aGUgcmVsYXRlZCBzZXR0aW5nDQo+ID4gbWF5IGJlIG5vdCByZWFkeSB5ZXQuDQo+ID4N
Cj4gPiBUaGUgc2NvcmUgYm9hcmQgaXMgbm90IHJlbGF0ZWQgdG8gc2NhbiB3aGVuIGluaXRpYWxp
bmcsIHJlbW92ZSB0aGUgc2Nhbg0KPiA+IHBhcmFtZXRlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENoaW5nLVRlIEt1IDxrdTkyMDYwMUByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9jb2V4LmMgfCA4ICsrKysrLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9jb1TDlMOICA0K
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvY29leC5jOElsCGV4LmNjNzIx
NjI0NTU1Ny4uNmVjM2Y0NWE2NGMxIDEwMDY0NA0KPiANCj4gU29tZXRoaW5nIGlzIHdyb25nIGhl
cmUsIHRoZSBuZXcgbGluZXMgYXJlIHJlcGxhY2VkIHdpdGggJ15IJyBjb250cm9sDQo+IGNoYXJh
Y3Rlci4NCj4gDQoNCkkgZG9uJ3Qga25vdyB3aHkgaXQgZ29lcyB3cm9uZywgbXkgcGF0Y2ggc291
cmNlIGxvb2tzIG9rLiANCkknbGwgcGF5IGF0dGVudGlvbiB0byB0aGlzIHBhdGNoIHdoaWxlIHNl
bmRpbmcgdjIuDQoNCi0tLQ0KUGluZy1LZQ0KDQo=
