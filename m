Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF703FB12D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhH3G20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 02:28:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43417 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhH3G2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 02:28:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17U6RN6G0027449, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17U6RN6G0027449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 14:27:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 30 Aug 2021 14:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Aug 2021 14:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 30 Aug 2021 14:27:21 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Gary Chang" <gary.chang@realtek.com>
Subject: RE: [PATCH 1/2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug
Thread-Topic: [PATCH 1/2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail
 bug
Thread-Index: AQHXkplwpVc0LwwxxkW8Tv+bMD4oSquLqL4g
Date:   Mon, 30 Aug 2021 06:27:20 +0000
Message-ID: <b776fe75e3d8476a83a6a969c2f15e2e@realtek.com>
References: <20210816085128.10931-1-pkshih@realtek.com>
 <1a7bdf33-046a-b67b-f650-7b4c3d7e2859@nbd.name>
In-Reply-To: <1a7bdf33-046a-b67b-f650-7b4c3d7e2859@nbd.name>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMzAg5LiK5Y2IIDA0OjIxOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/30/2021 06:09:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165837 [Aug 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 457 457 f9912fc467375383fbac52a53ade5bbe1c769e2a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2021 06:14:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZlbGl4IEZpZXRrYXUgW21h
aWx0bzpuYmRAbmJkLm5hbWVdDQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDE2LCAyMDIxIDg6MjMg
UE0NCj4gVG86IFBrc2hpaDsgam9oYW5uZXNAc2lwc29sdXRpb25zLm5ldA0KPiBDYzogbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBHYXJ5IENoYW5nDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS8yXSBtYWM4MDIxMTogRml4IGllZWU4MDIxMV9hbXNkdV9hZ2dyZWdhdGUgZnJhZ190YWls
IGJ1Zw0KPiANCj4gT24gMjAyMS0wOC0xNiAxMDo1MSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+
IEZyb206IENoaWgtS2FuZyBDaGFuZyA8Z2FyeS5jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gPg0KPiA+
IEluIGllZWU4MDIxMV9hbXNkdV9hZ2dyZWdhdGUoKSBzZXQgYSBwb2ludGVyIGZyYWdfdGFpbCBw
b2ludCB0byB0aGUNCj4gPiBlbmQgb2Ygc2tiX3NoaW5mbyhoZWFkKS0+ZnJhZ19saXN0LCBhbmQg
dXNlIGl0IHRvIGJpbmQgb3RoZXIgc2tiIGluDQo+ID4gdGhlIGVuZCBvZiB0aGlzIGZ1bmN0aW9u
LiBCdXQgd2hlbiBleGVjdXRlIGllZWU4MDIxMV9hbXNkdV9hZ2dyZWdhdGUoKQ0KPiA+IC0+aWVl
ZTgwMjExX2Ftc2R1X3JlYWxsb2NfcGFkKCktPnBza2JfZXhwYW5kX2hlYWQoKSwgdGhlIGFkZHJl
c3Mgb2YNCj4gPiBza2Jfc2hpbmZvKGhlYWQpLT5mcmFnX2xpc3Qgd2lsbCBiZSBjaGFuZ2VkLiBI
b3dldmVyLCB0aGUNCj4gPiBpZWVlODAyMTFfYW1zZHVfYWdncmVnYXRlKCkgbm90IHVwZGF0ZSBm
cmFnX3RhaWwgYWZ0ZXIgY2FsbA0KPiA+IHBza2JfZXhwYW5kX2hlYWQoKS4gVGhhdCB3aWxsIGNh
dXNlIHRoZSBzZWNvbmQgc2tiIGNhbid0IGJpbmQgdG8gdGhlDQo+ID4gaGVhZCBza2IgYXBwcm9w
cmlhdGVseS5TbyB3ZSB1cGRhdGUgdGhlIGFkZHJlc3Mgb2YgZnJhZ190YWlsIHRvIGZpeCBpdC4N
Cj4gSSB0aGluayBpbnN0ZWFkIG9mIGl0ZXJhdGluZyBvdmVyIGZyYWdtZW50cyBhIHNlY29uZCB0
aW1lLCB3ZSBzaG91bGQNCj4gbW92ZSB0aGUgaWVlZTgwMjExX2Ftc2R1X3ByZXBhcmVfaGVhZCBj
YWxsIGZ1cnRoZXIgdXAuDQo+IA0KDQpUaGUgZmlyc3QgaXRlcmF0aW9uIGlzIHVzZWQgdG8gY2Fs
Y3VsYXRlICduJyBhbmQgJ25mcmFncycgdG8gZGVjaWRlIGlmDQp3ZSBuZWVkIHRvIGRvIEFNU0RV
IGFzIHdlbGwgYXMgaWVlZTgwMjExX2Ftc2R1X3ByZXBhcmVfaGVhZCgpLCBzbyB3ZQ0KZG9uJ3Qg
aGF2ZSBhIGdvb2QgaWRlYSB0byBtb3ZlIHRoZSBmdW5jdGlvbiB1cHdhcmQuIEhvd2V2ZXIsIHdl
IGhhdmUNCmFuIGFsdGVybmF0aXZlIGlkZWEgWzFdIHRvIGZpeCBmcmFnX3RhaWwuIA0KDQpbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyMTA4MzAwNjE3MjguMTAz
MzItMS1wa3NoaWhAcmVhbHRlay5jb20vVC8jdQ0KDQotLQ0KUGluZy1LZQ0KDQo=
