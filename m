Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3953A478493
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 06:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhLQFbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 00:31:12 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46346 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhLQFbM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 00:31:12 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BH5V5hG4018832, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BH5V5hG4018832
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 13:31:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 13:31:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 13:31:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::65a3:1e23:d911:4b01]) by
 RTEXMBS04.realtek.com.tw ([fe80::65a3:1e23:d911:4b01%5]) with mapi id
 15.01.2308.020; Fri, 17 Dec 2021 13:31:05 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Daniel Drake <drake@endlessos.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: RE: rtw88 support for USB devices such as RTL8723DU
Thread-Topic: rtw88 support for USB devices such as RTL8723DU
Thread-Index: AQHX8me96OwbbSNd50KqjrtoPH4DV6w2KCpQ
Date:   Fri, 17 Dec 2021 05:31:05 +0000
Message-ID: <36f4f4fe6f7848a7a7f4b274f494450a@realtek.com>
References: <CAD8Lp46BuhxA1XLWjBs4op0jzZ1k0HF=X22F29hB7nHgvnZftQ@mail.gmail.com>
In-Reply-To: <CAD8Lp46BuhxA1XLWjBs4op0jzZ1k0HF=X22F29hB7nHgvnZftQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzE3IOS4iuWNiCAwMzoxMjowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBEcmFrZSA8ZHJh
a2VAZW5kbGVzc29zLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE2LCAyMDIxIDY6
MjkgUE0NCj4gVG86IFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgdG9ueTA2MjBlbW1hQGdt
YWlsLmNvbQ0KPiBDYzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZz47IExpbnV4IFVwc3RyZWFtaW5nIFRlYW0gPGxpbnV4QGVuZGxlc3NtLmNvbT4NCj4gU3Vi
amVjdDogcnR3ODggc3VwcG9ydCBmb3IgVVNCIGRldmljZXMgc3VjaCBhcyBSVEw4NzIzRFUNCj4g
DQo+IEhpLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgb25nb2luZyBlZmZvcnRzIGFyb3VuZCB0aGUg
dXBzdHJlYW0gcnR3ODggZHJpdmVyIGFuZA0KPiBmb3IgeW91ciBoZWxwIG9uIHRoZSBBU1BNIGlz
c3VlIG92ZXIgdGhlIGxhc3QgZmV3IGRheXMhIEhhdmluZyBzdWNoDQo+IGhhcmR3YXJlIHN1cHBv
cnQgaW4gbWFpbmxpbmUgaXMgb2YgaHVnZSBpbXBhY3QgZm9yIGluZGl2aWR1YWwgdXNlcnMNCj4g
YW5kIG9yZ2FuaXNhdGlvbnMgbGlrZSBvdXJzLg0KPiANCj4gSSBhbSBjdXJpb3VzIGlmIHRoZXJl
IGlzIGEgcm9hZG1hcCBmb3IgUlRMODcyM0RVIHN1cHBvcnQgaW4gbWFpbmxpbmUNCj4gdG9vPyBP
dmVyIHRoZSBsYXN0IHdlZWssIDIgb2Ygb3VyIHBhcnRuZXJzIGhhdmUgaW5xdWlyZWQgYWJvdXQg
dGhpcy4NCj4gSXQgYXBwZWFycyB0aGF0IHRoaXMgaXMgYSB2ZXJ5IGF0dHJhY3RpdmUgY2hpcHNl
dCBmb3IgdmVuZG9ycyBhbmQgaXMNCj4gYmVpbmcgZGVwbG95ZWQgaW4gYSB3aWRlIHJhbmdlIG9m
IHByb2R1Y3RzLg0KPiANCj4gSSBzYXcgc29tZSBjb21tdW5pdHkgZWZmb3J0cyBmb3IgZGV2aWNl
IHN1cHBvcnQ6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS91bGxpLWtyb2xsL3J0dzg4LXVzYg0KPiBi
dXQgd2UgYXJlIHVuYWJsZSB0byB1c2Ugbm9uLW1haW5saW5lIGRyaXZlcnMgZm9yIHRoZXNlIHBy
b2plY3RzLg0KPiANCg0KV2UgbW92ZSBtb3N0IG9mIG91ciByZXNvdXJjZSB0byBkZXZlbG9wIHJ0
dzg5LCB3aWZpIDYgZHJpdmVyLCBzbyB3ZSBkb24ndA0KaGF2ZSBwbGFuIHRvIGRvIHRoaXMgeWV0
LiBCdXQgSSBjYW4gaGVscCB0byByZXZpZXcgdGhlIHBhdGNoZXMgaWYgeW91IGNhbg0KaGVscCB0
byBtYWtlIHBhdGNoZXMgZnJvbSBhYm92ZSBnaXRodWIgYW5kIHRlc3QgdXNiIGRvbmdsZXMuDQoN
ClBpbmctS2UNCg0K
