Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F6535973
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiE0Gga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiE0Gg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 02:36:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E898BE12
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 23:36:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24R6ZXqD4006761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24R6ZXqD4006761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 May 2022 14:35:33 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 27 May 2022 14:35:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 27 May 2022 14:35:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Fri, 27 May 2022 14:35:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "megi@xff.cz" <megi@xff.cz>, Bernie Huang <phhuang@realtek.com>
Subject: RE: [PATCH] rtw88: add a work to correct atomic scheduling warning of ::set_tim
Thread-Topic: [PATCH] rtw88: add a work to correct atomic scheduling warning
 of ::set_tim
Thread-Index: AQHYcL9SCQ+P9wYAU0CsJx0CeJ3NrK0yRLnzgAAA22A=
Date:   Fri, 27 May 2022 06:35:33 +0000
Message-ID: <1a53b146ee034a058fad0f0d87a24e16@realtek.com>
References: <20220526051251.281905-1-pkshih@realtek.com>
 <871qwfwksm.fsf@kernel.org>
In-Reply-To: <871qwfwksm.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjcg5LiK5Y2IIDAyOjI4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGxlIFZhbG8gPGt2YWxv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDI3LCAyMDIyIDI6MjkgUE0NCj4gVG86
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogdG9ueTA2MjBlbW1hQGdt
YWlsLmNvbTsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBtZWdpQHhmZi5jejsgQmVy
bmllIEh1YW5nDQo+IDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBydHc4ODogYWRkIGEgd29yayB0byBjb3JyZWN0IGF0b21pYyBzY2hlZHVsaW5nIHdhcm5pbmcg
b2YgOjpzZXRfdGltDQo+IA0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3Jp
dGVzOg0KPiANCj4gPiBUaGUgc2V0X3RpbSBpcyBzdXBwb3NlZCB0byBiZSBhdG9taWMsIGJ1dCB3
ZSBzaG91bGQgZG93bmxvYWQgYmVhY29uDQo+ID4gY29udGV4dCB0byBmaXJtd2FyZSB3aXRoIGEg
bXV0ZXggbG9jay4gVG8gYXZvaWQgd2FybmluZywgZG8gdGhlIHRoaW5nIGluDQo+ID4gYW5vdGhl
ciB3b3JrLg0KPiA+DQo+ID4gQlVHOiBzY2hlZHVsaW5nIHdoaWxlIGF0b21pYzogc3dhcHBlci8x
LzAvMHgwMDAwMDcwMA0KPiA+IE1vZHVsZXMgbGlua2VkIGluOg0KPiA+IENQVTogMSBQSUQ6IDAg
Q29tbTogc3dhcHBlci8xIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA1LjE4LjAtcmM3LTAw
NzAzLWczM2I1ZWUwOWEwYzEgIzQNCj4gPiBIYXJkd2FyZSBuYW1lOiBQaW5lNjQgUkszNTY2IFF1
YXJ0ejY0LUEgQm9hcmQgKERUKQ0KPiA+IENhbGwgdHJhY2U6DQo+ID4gIGR1bXBfYmFja3RyYWNl
LnBhcnQuMCsweGM0LzB4ZDANCj4gPiAgc2hvd19zdGFjaysweDE0LzB4NjANCj4gPiAgZHVtcF9z
dGFja19sdmwrMHg2MC8weDc4DQo+ID4gIGR1bXBfc3RhY2srMHgxNC8weDJjDQo+ID4gIF9fc2No
ZWR1bGVfYnVnKzB4NWMvMHg3MA0KPiA+ICBfX3NjaGVkdWxlKzB4NWM0LzB4NjMwDQo+ID4gIHNj
aGVkdWxlKzB4NDQvMHhiMA0KPiA+ICBzY2hlZHVsZV9wcmVlbXB0X2Rpc2FibGVkKzB4Yy8weDE0
DQo+ID4gIF9fbXV0ZXhfbG9jay5jb25zdHByb3AuMCsweDUzOC8weDU2Yw0KPiA+ICBfX211dGV4
X2xvY2tfc2xvd3BhdGgrMHgxMC8weDIwDQo+ID4gIG11dGV4X2xvY2srMHg1NC8weDYwDQo+ID4g
IHJ0d19vcHNfc2V0X3RpbSsweDIwLzB4NDANCj4gPiAgX19zdGFfaW5mb19yZWNhbGNfdGltKzB4
MTUwLzB4MjUwDQo+ID4gIHN0YV9pbmZvX3JlY2FsY190aW0rMHgxMC8weDIwDQo+ID4gIGludm9r
ZV90eF9oYW5kbGVyc19lYXJseSsweDRlNC8weDVjMA0KPiA+ICBpZWVlODAyMTFfdHgrMHg3OC8w
eDExMA0KPiA+ICBpZWVlODAyMTFfeG1pdCsweDk0LzB4YzANCj4gPiAgX19pZWVlODAyMTFfc3Vi
aWZfc3RhcnRfeG1pdCsweDgxOC8weGQyMA0KPiA+ICBpZWVlODAyMTFfc3ViaWZfc3RhcnRfeG1p
dCsweDQ0LzB4MmQwDQo+ID4gIGRldl9oYXJkX3N0YXJ0X3htaXQrMHhkMC8weDE1MA0KPiA+ICBf
X2Rldl9xdWV1ZV94bWl0KzB4MjUwLzB4YjMwDQo+ID4gIGRldl9xdWV1ZV94bWl0KzB4MTAvMHgy
MA0KPiA+ICBicl9kZXZfcXVldWVfcHVzaF94bWl0KzB4OTQvMHgxNzQNCj4gPiAgYnJfZm9yd2Fy
ZF9maW5pc2grMHg5MC8weGEwDQo+ID4gIF9fYnJfZm9yd2FyZCsweGMwLzB4MTNjDQo+ID4gIGJy
X2ZvcndhcmQrMHgxMDgvMHgxMzQNCj4gPiAgYnJfZGV2X3htaXQrMHgxY2MvMHgzYTQNCj4gPiAg
ZGV2X2hhcmRfc3RhcnRfeG1pdCsweGQwLzB4MTUwDQo+ID4gIF9fZGV2X3F1ZXVlX3htaXQrMHgy
NTAvMHhiMzANCj4gPiAgZGV2X3F1ZXVlX3htaXQrMHgxMC8weDIwDQo+ID4gIGFycF94bWl0KzB4
NmMvMHg3Yw0KPiA+ICBhcnBfc2VuZF9kc3QrMHg4Yy8weGMwDQo+ID4gIGFycF9zb2xpY2l0KzB4
ZDQvMHgxZTANCj4gPiAgbmVpZ2hfcHJvYmUrMHg1OC8weGEwDQo+ID4gIG5laWdoX3RpbWVyX2hh
bmRsZXIrMHgyN2MvMHgzODANCj4gPiAgY2FsbF90aW1lcl9mbi5jb25zdHByb3AuMCsweDIwLzB4
ODANCj4gPiAgX19ydW5fdGltZXJzLnBhcnQuMCsweDIzMC8weDI4MA0KPiA+ICBydW5fdGltZXJf
c29mdGlycSsweDM4LzB4NzANCj4gPiAgX3N0ZXh0KzB4MTA0LzB4Mjc4DQo+ID4gIF9faXJxX2V4
aXRfcmN1KzB4YTQvMHhkYw0KPiA+ICBpcnFfZXhpdF9yY3UrMHhjLzB4MTQNCj4gPiAgZWwxX2lu
dGVycnVwdCsweDM0LzB4NTANCj4gPiAgZWwxaF82NF9pcnFfaGFuZGxlcisweDE0LzB4MjANCj4g
PiAgZWwxaF82NF9pcnErMHg2NC8weDY4DQo+ID4gIGFyY2hfY3B1X2lkbGUrMHgxNC8weDIwDQo+
ID4gIGRvX2lkbGUrMHgyMDgvMHgyOTANCj4gPiAgY3B1X3N0YXJ0dXBfZW50cnkrMHgyMC8weDMw
DQo+ID4gIHNlY29uZGFyeV9zdGFydF9rZXJuZWwrMHgxMzAvMHgxNDQNCj4gPiAgX19zZWNvbmRh
cnlfc3dpdGNoZWQrMHg1NC8weDU4DQo+ID4NCj4gPiBGaXhlczogZjIyMTc5NjhmZmRhICgicnR3
ODg6IEFkZCB1cGRhdGUgYmVhY29uIGZsb3cgZm9yIEFQIG1vZGUiKQ0KPiA+IFJlcG9ydGVkLWJ5
OiBPbmTFmWVqIEppcm1hbiA8bWVnaUB4ZmYuY3o+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1L
ZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBTaG91bGQgSSBxdWV1ZSB0aGlzIHRv
IHY1LjE5IChpZS4gdGFrZSB0byB3aXJlbGVzIHRyZWUpPw0KPiANCg0KWWVzLCBwbGVhc2UuIEkg
dGhpbmsgaXQgd291bGQgYmUgZ29vZCB0byBoYXZlIHRoaXMgZml4Lg0KDQpUaGFua3MNClBpbmct
S2UNCg0K
