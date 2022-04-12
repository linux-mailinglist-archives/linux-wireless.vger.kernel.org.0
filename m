Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9434FC951
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 02:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbiDLAjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 20:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDLAjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 20:39:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5431929A
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 17:37:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23C0b8w85008158, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23C0b8w85008158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Apr 2022 08:37:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 08:37:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 08:37:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Tue, 12 Apr 2022 08:37:08 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: consider Order bit to fill CCMP AAD
Thread-Topic: [PATCH] mac80211: consider Order bit to fill CCMP AAD
Thread-Index: AQHYPxkFP7R5JPsLF0yyO3i26l23HKzqBBeAgACJGSA=
Date:   Tue, 12 Apr 2022 00:37:08 +0000
Message-ID: <1170e4f5f399431e88b8304e9b606170@realtek.com>
References: <20220324004816.6202-1-pkshih@realtek.com>
 <e90e6249a7330cd60434d184d358694785e465e7.camel@sipsolutions.net>
In-Reply-To: <e90e6249a7330cd60434d184d358694785e465e7.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTEg5LiL5Y2IIDEwOjAxOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTEsIDIwMjIg
NToxMiBQTQ0KPiBUbzogUGtzaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbWFjODAyMTE6
IGNvbnNpZGVyIE9yZGVyIGJpdCB0byBmaWxsIENDTVAgQUFEDQo+IA0KPiBPbiBUaHUsIDIwMjIt
MDMtMjQgYXQgMDg6NDggKzA4MDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBGb2xsb3cgSUVF
RSA4MDIuMTEtMjEgdGhhdCBIVEMgc3ViZmllbGQgbWFza2VkIHRvIDAgZm9yIGFsbCBkYXRhIGZy
YW1lcw0KPiA+IGNvbnRhaW5pbmcgYSBRb1MgQ29udHJvbCBmaWVsZC4NCj4gPg0KPiANCj4gVGhh
dCBzZWVtcyBmaW5lLCB0aG91Z2ggbm90IHN1cmUgaXQncyBhY3R1YWxseSBfcmVsZXZhbnRfIC0g
aG93IHdvdWxkIHdlDQo+IHBvc3NpYmx5IGdlbmVyYXRlIHN1Y2ggZnJhbWVzIGluIG1hYzgwMjEx
Pw0KDQpJIHN1ZGRlbmx5IG1lZXQgdGhpcyBjYXNlLCBiZWNhdXNlIGhhcmR3YXJlIGRlY3J5cHRp
b24gaXNuJ3QgY29uZmlndXJlZCBwcm9wZXJseQ0KZHVyaW5nIGRldmVsb3BtZW50LCBzbyBpdCBm
YWxscyBpbnRvIHNvZnR3YXJlIGRlY3J5cHRpb24uIFRoZSByZWNlaXZlZCBwYWNrZXRzDQpjYW4g
cG9zc2libHkgY29udGFpbiBIVEMuDQoNCkFmdGVyIEkgZml4IG15IGRyaXZlciwgSSBkb24ndCBu
ZWVkIHRoaXMsIGJ1dCBJIHRoaW5rIGl0IGlzIHdvcnRoIHRvIGhhdmUNCnRoaXMgcGF0Y2guDQoN
Cj4gDQo+ID4gSXQgYWxzbyBkZWZpbmVzIHRoZSBBQUQgbGVuZ3RoIGRlcGVuZHMgb24NCj4gPiBR
QyBhbmQgQTQgZmllbGRzLCBzbyBjaGFuZ2UgbG9naWMgdG8gZGV0ZXJtaW5lIGxlbmd0aCBhY2Nv
cmRpbmdseS4NCj4gDQo+IFRoaXMgSSBkb24ndCB1bmRlcnN0YW5kLg0KDQpJRUVFIDgwMi4xMS0y
MSBpbGx1c3RyYXRlIHRoZSB1c2UgY2FzZXMgYXMgYmVsb3cNCiAgUUMgRmllbGQgICBBNCBGaWVs
ZCAgIEFBRCBsZW5ndGgNCiAgLS0tLS0tLSAgICAtLS0tLS0tLSAgIC0tLS0tLS0tLQ0KICAgIHgg
ICAgICAgICAgIHggICAgICAgICAyMg0KICAgIG8gICAgICAgICAgIHggICAgICAgICAyNA0KICAg
IHggICAgICAgICAgIG8gICAgICAgICAyOA0KICAgIG8gICAgICAgICAgIG8gICAgICAgICAzMA0K
DQpJIHdyaXRlIGxvZ2ljIGFsb25nIHdpdGggdGhpcyB0YWJsZSwgYmVjYXVzZSBpdCB3b3VsZCBi
ZSBjbGVhciBhbmQgc2ltcGxlLg0KDQo+IA0KPiBUaGUgY29kZQ0KPiANCj4gDQo+ID4gLQloZHJs
ZW4gPSBpZWVlODAyMTFfaGRybGVuKGhkci0+ZnJhbWVfY29udHJvbCk7DQo+ID4gLQlsZW5fYSA9
IGhkcmxlbiAtIDI7DQo+IA0KPiBzZXRzIGl0IHRvIHRoZSBzYW1lIHRoaW5nLCBubz8NCg0KU2lu
Y2UgQUFEIGNvbnNpc3RzIG9mICJGQyB8IEExIHwgQTIgfCBBMyB8IFNDIHwgW0E0XSB8IFtRQ10i
DQpJIHRoaW5rICctMicgaGVyZSBtZWFucyBBQUQgZG9lc24ndCBjb250YWluICdEdXJhdGlvbicg
ZmllbGQuDQoNCj4gDQo+IE9oLCBJIHNlZSAtIGFnYWluIHlvdSdyZSB3b3JyaWVkIGFib3V0IElF
RUU4MDIxMV9IVF9DVExfTEVOIEkgZ3Vlc3M/DQo+IA0KPiBNYXliZSBqdXN0IHN1YnRyYWN0IHRo
YXQgYWdhaW4/DQoNClllcywgd2UgY2FuIHN1YnRyYWN0IGxlbmd0aCBmcm9tIGllZWU4MDIxMV9o
ZHJsZW4oKS4NCkJ1dCwgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgaW4gZGF0YSBwYXRoIHRoYXQg
bWVhbnMgZXZlcnkgcGFja2V0IGNhbiB1c2UgaXQuDQpJcyBpdCByZWFzb25hYmxlIHRvICs9IElF
RUU4MDIxMV9IVF9DVExfTEVOIGluIGllZWU4MDIxMV9oZHJsZW4oKSBhbmQNCi09IElFRUU4MDIx
MV9IVF9DVExfTEVOIHJpZ2h0IGFmdGVyIGxlYXZpbmcgaWVlZTgwMjExX2hkcmxlbigpIGlmIHRo
ZSBwYWNrZXQgaXMNCmllZWU4MDIxMV9oYXNfb3JkZXIoKT8NCg0KUGluZy1LZQ0KDQo=
