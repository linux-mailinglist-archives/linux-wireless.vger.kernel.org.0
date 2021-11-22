Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF24587F3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 03:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhKVCST (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 21:18:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43065 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhKVCST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 21:18:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AM2F38a8029859, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AM2F38a8029859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 10:15:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 22 Nov 2021 10:15:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 21 Nov 2021 21:15:02 -0500
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Mon, 22 Nov 2021 10:15:02 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?5p2O5L2z6YGg?= <leo.li@realtek.com>
Subject: RE: [PATCH] rtw89: add AXIDMA and TX FIFO dump in mac_mem_dump
Thread-Topic: [PATCH] rtw89: add AXIDMA and TX FIFO dump in mac_mem_dump
Thread-Index: AQHX3QqtSKIdrtP0BkmZxqDA7Gl/4awKwc0AgAQRaPA=
Date:   Mon, 22 Nov 2021 02:15:02 +0000
Message-ID: <63e59e967cf44c58a7a877d40d69f393@realtek.com>
References: <20211119055919.12954-1-pkshih@realtek.com>
 <2c354523-1603-0d0b-1880-1ff8dd00a58b@lwfinger.net>
In-Reply-To: <2c354523-1603-0d0b-1880-1ff8dd00a58b@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzIyIOS4iuWNiCAxMjoyNTowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/22/2021 01:53:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167391 [Nov 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, text}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/22/2021 01:57:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnJ5IEZpbmdlciA8bGFy
cnkuZmluZ2VyQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIExhcnJ5IEZpbmdlcg0KPiBTZW50OiBT
YXR1cmRheSwgTm92ZW1iZXIgMjAsIDIwMjEgNDowNyBBTQ0KPiBUbzogUGtzaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+OyBrdmFsb0Bjb2RlYXVyb3JhLm9yZw0KPiBDYzogbGludXgtd2lyZWxlc3NA
dmdlci5rZXJuZWwub3JnOyDmnY7kvbPpgaAgPGxlby5saUByZWFsdGVrLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gcnR3ODk6IGFkZCBBWElETUEgYW5kIFRYIEZJRk8gZHVtcCBpbiBtYWNf
bWVtX2R1bXANCj4gDQo+IE9uIDExLzE4LzIxIDIzOjU5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
ID4gRnJvbTogQ2hpYS1ZdWFuIExpIDxsZW8ubGlAcmVhbHRlay5jb20+DQo+ID4NCj4gPiBUaGUg
QVhJRE1BIGlzIHR4L3J4IHBhY2tldCB0cmFuc21pc3Npb24gYmV0d2VlbiBQQ0lFIGhvc3QNCj4g
PiBhbmQgZGV2aWNlLCBhbmQgVFggRklGTyBpcyBNQUMgVFggZGF0YS4NCj4gPiBXZSBkdW1wIHRo
ZW0gdG8gZW5zdXJlIHRoZXNlIG1lbW9yeSBidWZmZXJzIGNvcnJlY3QuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDaGlhLVl1YW4gTGkgPGxlby5saUByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQo+IFRoZSBjb2Rl
IGluIHRoaXMgcGF0Y2ggaXMgZmluZSwgYnV0IEkgdGhpbmsgeW91IG1heSB3YW50IHRvIGNoYW5n
ZSB0aGUgY29tbWl0DQo+IG1lc3NhZ2UuIFRlIG1vLCAiV2UgZHVtcCB0aGVtIHRvIGVuc3VyZSB0
aGVzZSBtZW1vcnkgYnVmZmVycyBjb3JyZWN0IiBtZWFucyB0aGF0DQo+IHRoZSBjaGFuZ2UgaGVy
ZSB3aWxsIGZpeCB0aGUgbWVtb3J5IGJ1ZmZlcnMuIEkgdGhpbmsgeW91IHdhbnQgdG8gc2F5ICJX
ZSBkdW1wDQo+IHRoZW0gdG8gdmVyaWZ5IHRoYXQgdGhlc2UgbWVtb3J5IGJ1ZmZlcnMgYXJlIGNv
cnJlY3QuIiBUaGlzIG1lYW5zIHRoYXQgeW91IGFyZQ0KPiBwcm92aWRpbmcgYSB3YXkgdG8gZHVt
cCB0aGUgYnVmZmVycyBzbyB0aGF0IHRoZWlyIGNvcnJlY3RuZXNzIGNhbiBiZSBkZXRlcm1pbmVk
Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IExhcnJ5IEZpbmdlciA8TGFycnkuRmluZ2VyQGx3ZmluZ2Vy
Lm5ldCINCg0KSSBoYXZlIGZpeGVkIGFuZCBzZW50IHYyLg0KVGhhbmsgeW91Lg0KDQotLQ0KUGlu
Zy1LZQ0KDQoNCg==
