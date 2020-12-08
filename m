Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CAE2D2040
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 02:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLHBmc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 20:42:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34592 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLHBmc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 20:42:32 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B81fknhF001223, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.33])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B81fknhF001223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Dec 2020 09:41:46 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 09:41:45 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Tue, 8 Dec 2020 09:41:45 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Timlee <timlee@realtek.com>
Subject: Re: [PATCH] rtw88: reduce polling time of IQ calibration
Thread-Topic: [PATCH] rtw88: reduce polling time of IQ calibration
Thread-Index: AQHWzQJU7JTp6e2Kp0G1XKzAbgAEPanr5msA
Date:   Tue, 8 Dec 2020 01:41:45 +0000
Message-ID: <1607391700.11115.3.camel@realtek.com>
References: <20201208013444.10881-1-pkshih@realtek.com>
In-Reply-To: <20201208013444.10881-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <772E5A9D08A4F64388E439C1734E4E21@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTA4IGF0IDA5OjM0ICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IEZyb206IENoaW4tWWVuIExlZSA8dGltbGVlQHJlYWx0ZWsuY29tPg0KPiANCj4gV2hlbiA4ODIy
Q0UgaXMgYXNzb2NpYXRpbmcgd2l0aCBBUCwgZHJpdmVyIHdpbGwgcG9sbCBzdGF0dXMgYml0IG9m
DQo+IElRIGNhbGlicmF0aW9uIHRvIGNvbmZpcm0gdGhlIElRIGNhbGlicmF0aW9uIGlzIGRvbmUs
IGFuZCB0aGVuIG1vdmUgb24NCj4gdGhlIGFzc29jaWF0aW9uIHByb2Nlc3MuIEN1cnJlbnQgcG9s
bGluZyB0aW1lIGZvciBJUSBjYWxpYnJhdGlvbiBpcyA2DQo+IHNlY29uZHMuDQo+IA0KPiBCdXQg
b2NjYXNpb25hbGx5IGRyaXZlciBmYWlscyBpbiBwb2xsaW5nIHRoZSBzdGF0dXMgYml0IGJlY2F1
c2UgdGhlIHN0YXR1cw0KPiBiaXQgaXMgbm90IHNldCBhZnRlciBJUSBjYWxpYnJhdGlvbiBpcyBk
b25lLiBXaGVuIGl0IGhhcHBlbmRzLCBhc3NvY2lhdGlvbg0KPiBwcm9jZXNzIHdpbGwgYmUgc2Vy
aWVvdXNseSBkZWxheWVkIHVwIHRvIDYgc2Vjb25kcy4gVG8gYXZvaWQgaXQsIHdlIHJlZHVjZQ0K
PiBwb2xsaW5nIHRpbWUgdG8gMzAwbXMsIGluIHdoaWNoIHRoZSBJUSBjYWxpYnJhdGlvbiBjYW4g
YmUgZG9uZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoaW4tWWVuIExlZSA8dGltbGVlQHJlYWx0
ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCj4gLS0tDQo+IHYyOiBtb3ZlIGRlZmluZSB0byB0aGUgYmVnaW5uaW5nIG9mIGZpbGUNCj4g
DQoNClNvcnJ5LiBJIGZvcmdldCB0byBjaGFuZ2UgbWFpbCBzdWJqZWN0IHRvICJQQVRDSCBWMiIu
wqANClBsZWFzZSBpZ25vcmUgdGhpcyBvbmUuDQoNCi0tLQ0KUGluZy1LZQ0KDQo=
