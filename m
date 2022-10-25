Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4725E60C1A9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiJYCZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 22:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJYCZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 22:25:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C9230550
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 19:25:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P2P7ntC002883, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P2P7ntC002883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 10:25:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 10:25:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 25 Oct 2022 10:25:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Tue, 25 Oct 2022 10:25:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: How to use the rate control in mac80211?
Thread-Topic: How to use the rate control in mac80211?
Thread-Index: AQHY5lyyL3gBgbd0EU6ThXL7SgPKiq4cyQxQgABM5QCAAUxF4A==
Date:   Tue, 25 Oct 2022 02:25:40 +0000
Message-ID: <6af9d9ddfdb34f22a8c8e181ba5d0b1f@realtek.com>
References: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
 <efd11380ad344257a8f674b1cff0d080@realtek.com>
 <92d01e81-9d40-a9a2-1a8e-1207ccf33755@gmail.com>
In-Reply-To: <92d01e81-9d40-a9a2-1a8e-1207ccf33755@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI0IOS4i+WNiCAxMTozMTowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjQsIDIw
MjIgMTA6MjUgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBIb3cgdG8gdXNlIHRo
ZSByYXRlIGNvbnRyb2wgaW4gbWFjODAyMTE/DQo+IA0KPiBPbiAyNC8xMC8yMDIyIDA1OjEzLCBQ
aW5nLUtlIFNoaWggd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+
ID4+IFNlbnQ6IFN1bmRheSwgT2N0b2JlciAyMywgMjAyMiA1OjI0IEFNDQo+ID4+IFRvOiBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogSG93IHRvIHVzZSB0aGUg
cmF0ZSBjb250cm9sIGluIG1hYzgwMjExPw0KPiA+Pg0KPiA+PiBIaSENCj4gPj4NCj4gPj4gV2hh
dCBkb2VzIGEgZHJpdmVyIChydGw4eHh4dSkgbmVlZCB0byBkbyB0byBtYWtlIHRoZSByYXRlIGNv
bnRyb2wgd29yaz8NCj4gPj4NCj4gPj4gSSB0aG91Z2h0IGl0J3MgbGlrZSB0aGlzOg0KPiA+PiAx
KSBkb24ndCBzZXQgSEFTX1JBVEVfQ09OVFJPTA0KPiA+PiAyKSB0ZWxsIHRoZSBjaGlwIHRvIHVz
ZSB0aGUgcmF0ZSBmcm9tIHR4X2luZm8tPmNvbnRyb2wucmF0ZXNbMF0NCj4gPj4gMykgcmVwb3J0
IGlmIHRoZSBmcmFtZSB3YXMgYWNrZWQgb3Igbm90DQo+ID4+DQo+ID4+IEJ1dCBpdCdzIG5vdCB0
aGF0IGVhc3kuIEknbSBhbHdheXMgZ2V0dGluZyBNQ1MwLiBDdXJyZW50bHkgcnRsOHh4eHUNCj4g
Pj4gZG9lc24ndCBhc2sgdGhlIGNoaXAgZm9yIFRYIHJlcG9ydHMgYW5kIGFsd2F5cyBzZXRzIElF
RUU4MDIxMV9UWF9TVEFUX0FDSy4NCj4gPj4gSSB0aG91Z2h0IHRoaXMgd291bGQgZ2V0IG1lIE1D
UzcgZm9yIGFsbCBkYXRhIGZyYW1lcywgYnV0IGl0IGRvZXNuJ3QuDQo+ID4NCj4gPiBJIGRvbid0
IGRpZyByYXRlIGNvbnRyb2wgb2YgbWFjODAyMTEsIGJ1dCBJIHRoaW5rIGl0IGlzIGhhcmQgdG8g
c3VwcG9ydCB0aGlzDQo+ID4gYnkgUmVhbHRlayBjaGlwLCBiZWNhdXNlIHRoZSBpdGVtIDMgeW91
IGxpc3RlZC4NCj4gPg0KPiA+IFJlYWx0ZWsgV2lGaSBjaGlwIG9ubHkgcmVwb3J0cyBUWCBzdGF0
dXMgZm9yIHNwZWNpZmljIHBhY2tldHMsIGJlY2F1c2UgYnVzDQo+ID4gYmFuZHdpZHRoIGlzIGxp
bWl0ZWQsIHNvIHJlZHVjZSB0aGVzZSByZXBvcnRzIHRvIGhhdmUgYmV0dGVyIHBlcmZvcm1hbmNl
Lg0KPiA+IEFuZCwgZmlybXdhcmUgaGFzIGltcGxlbWVudGVkIHJhdGUgY29udHJvbCBjYWxsZWQg
cmF0ZSBhZGFwdGl2ZSAoUkEpLCBhbmQNCj4gPiB1c2luZyBmaXJtd2FyZSBSQSBpcyBleHBlY3Rl
ZC4NCj4gPg0KPiA+IElmIHlvdSByZWFsbHkgd2FudCB0byBjb250cm9sIHJhdGUgYnkgZHJpdmVy
LCB5b3UgY2FuIHJlZmVyIHRvIGltcGxlbWVudGF0aW9uDQo+ID4gb2YgbWFuYWdlbWVudCBmcmFt
ZSBiZWxvdzoNCj4gPg0KPiA+IAlpZiAoaWVlZTgwMjExX2lzX21nbXQoaGRyLT5mcmFtZV9jb250
cm9sKSkgew0KPiA+IAkJdHhfZGVzYy0+dHhkdzUgPSBjcHVfdG9fbGUzMihyYXRlKTsNCj4gPiAJ
CXR4X2Rlc2MtPnR4ZHc0IHw9IGNwdV90b19sZTMyKFRYREVTQzMyX1VTRV9EUklWRVJfUkFURSk7
DQo+ID4gCQl0eF9kZXNjLT50eGR3NSB8PSBjcHVfdG9fbGUzMig2IDw8IFRYREVTQzMyX1JFVFJZ
X0xJTUlUX1NISUZUKTsNCj4gPiAJCXR4X2Rlc2MtPnR4ZHc1IHw9IGNwdV90b19sZTMyKFRYREVT
QzMyX1JFVFJZX0xJTUlUX0VOQUJMRSk7DQo+ID4gCX0NCj4gPg0KPiA+IEFub3RoZXIgdGhpbmcg
aXMgdGhhdCByZXRyeSByYXRlIGlzIGRlY2lkZWQgYnkgaGFyZHdhcmUgYnkgYW5vdGhlciByZWdp
c3Rlcg0KPiA+IHNldHRpbmdzLCBidXQgSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZW0sIGJlY2F1
c2UgSSBhbHdheXMgdXNlIFJBIG1lbnRpb25lZA0KPiA+IGFib3ZlLiBNYXliZSwgeW91IHN0aWxs
IGNhbiB1c2UgKmRlZmF1bHQqIHNldHRpbmdzIG9mIHJldHJ5IHJhdGUgdGhhdCBjb3VsZA0KPiA+
IHdvcmsgYnV0IG5vdCBhbHdheXMgZ29vZCBpbiBhbGwgc2l0dWF0aW9ucy4NCj4gPg0KPiA+IFBp
bmctS2UNCj4gPg0KPiBOb3JtYWxseSwgd2UgdXNlIHRoZSBmaXJtd2FyZSByYXRlIGNvbnRyb2ws
IGJ1dCBSVEw4MTg4RVUgZG9lc24ndCBoYXZlIGl0Og0KPiBodHRwczovL2dpdGh1Yi5jb20vbHdm
aW5nZXIvcnRsODE4OGV1L2Jsb2IvYzQ5MDhjYTRjYWY4NjFkODU4YzRkOWU4NDUyYTJhZDVjODhj
ZjJiYS9ydGw4MTg4ZXVfeG1pdC5jI0wNCj4gMzQ5DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zp
bmdlci9ydGw4MTg4ZXUvYmxvYi9jNDkwOGNhNGNhZjg2MWQ4NThjNGQ5ZTg0NTJhMmFkNWM4OGNm
MmJhL2hhbDgxODhlcmF0ZWFkYXB0aQ0KPiB2ZS5jDQoNCllvdSBhcmUgcmlnaHQuIFRoZSBSVEw4
MTg4RVUgZG9lcyBkaWZmZXJlbnQgdGhpbmcgZnJvbSBvdGhlciBjaGlwcy4gDQoNCkZpcm13YXJl
IGNvbGxlY3RzIFRYIHN0YXR1cyBhbmQgc2VuZCBUWF9SRVBPUlQyIGV2ZW50cyB0byBkcml2ZXIs
IGFuZA0KdGhlbiBkcml2ZXIgY2FuIHVzZSBpdCB0byBkZWNpZGUgcmF0ZS4gQW5vdGhlciB0aGlu
ZyBpcyB0byBzZXQgbWF4aW11bQ0KbWFjX2lkIHRvIHRlbGwgZmlybXdhcmUgaG93IG1hbnkgZW50
cmllcyBkcml2ZXIgbmVlZHMuDQoNCiAgcnR3X3dyaXRlOChhZGFwdGVyLCBSRUdfVFhfUlBUX0NU
UkwgKyAxLCBtYXhNYWNpZCArIDEpOw0KDQo+IA0KPiAoSSBndWVzcyB0aGV5IHVzZWQgdGhlIHNw
YWNlIGluIHRoZSBmaXJtd2FyZSBvbiB0aGUgSU9MIHN0dWZmIGFuZCB0aGUgcmF0ZQ0KPiBjb250
cm9sIGNvZGUgZGlkbid0IGZpdD8pDQo+IA0KPiBNYXliZSB3ZSBkb24ndCBuZWVkIHRvIGFzayBm
b3IgVFggcmVwb3J0cyBmb3IgZXZlcnkgZGF0YSBmcmFtZT8NCg0KTWF5YmUsIHdlIGNhbiBhc2sg
VFggcmVwb3J0IHBlciAxMCBvciAxMDAgcGFja2V0cywgYnV0IEkgZG9uJ3Qga25vdyBpZg0KdGhp
cyBjYW4gZ2V0IHBvc2l0aXZlIHJlc3VsdC4NCg0KUGluZy1LZQ0KDQo=
