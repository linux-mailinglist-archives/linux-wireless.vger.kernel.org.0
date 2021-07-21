Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E463D0753
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 05:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhGUCjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 22:39:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36886 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhGUCjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 22:39:35 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16L3K57q8012246, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16L3K57q8012246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Jul 2021 11:20:05 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 21 Jul 2021 11:20:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 21 Jul 2021 11:20:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Wed, 21 Jul 2021 11:20:03 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v4 09/19] rtw89: add pci files
Thread-Topic: [PATCH v4 09/19] rtw89: add pci files
Thread-Index: AQHXPM4t4237yjXWkE2au/031Uoa26sMOfeAgAJeNoCAC1QVAIAK1bHggAjpL6CAHPMoAIABA19g
Date:   Wed, 21 Jul 2021 03:20:03 +0000
Message-ID: <bc549c7ad1a3475fbae814a2efb9ca7d@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
 <20210429080149.7068-10-pkshih@realtek.com> <YMFzAZUysQ5HxZlK@google.com>
 <45dd7da687a444d5acbc13eb67dcee97@realtek.com>
 <CA+ASDXP1aY5Mm14GDA_qPK7+7Jri2xAMZ3fYiVrhur7N5EO0mQ@mail.gmail.com>
 <db26751dfb02499093829a6aeecadb61@realtek.com>
 <CA+ASDXO7SfuAsLhLU9hn4bANL5oTizwoYh5ifi2Wi-Mr-7zMDQ@mail.gmail.com>
In-Reply-To: <CA+ASDXO7SfuAsLhLU9hn4bANL5oTizwoYh5ifi2Wi-Mr-7zMDQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMjEg5LiK5Y2IIDAxOjA3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/21/2021 02:54:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165154 [Jul 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/21/2021 02:56:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJyaWFuIE5vcnJpcyBbbWFp
bHRvOmJyaWFubm9ycmlzQGNocm9taXVtLm9yZ10NCj4gU2VudDogVHVlc2RheSwgSnVseSAyMCwg
MjAyMSAyOjUxIEFNDQo+IFRvOiBQa3NoaWgNCj4gQ2M6IGt2YWxvQGNvZGVhdXJvcmEub3JnOyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAw
OS8xOV0gcnR3ODk6IGFkZCBwY2kgZmlsZXMNCj4gDQo+IChMYXRlIHJlc3BvbnNlKQ0KPiANCj4g
T24gV2VkLCBKdW4gMzAsIDIwMjEgYXQgNTo0NyBQTSBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4gd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
UGtzaGloDQo+IA0KPiA+ID4gSSByZWFkIElSUSBoYW5kbGVyIG9mIHJ0dzg4IHRoYXQgbG9va3Mg
bXVjaCBzaW1wbGVyLCBhbmQgSSBwaWN0dXJlIHRoZQ0KPiA+ID4gbmV3IGZsb3c6DQo+ID4gPg0K
PiA+ID4gaW50X2hhbmRsZXIgICAgICAgICAgICAgaW50X3RocmVhZGZuICAgICAgICAgICAgICBu
YXBpX3BvbGwNCj4gPiA+IC0tLS0tLS0tLS0tICAgICAgICAgICAgIC0tLS0tLS0tLS0tLSAgICAg
ICAgICAgICAgLS0tLS0tLS0tDQo+ID4gPiAgICAgfA0KPiA+ID4gICAgIHwNCj4gPiA+ICAgICB8
IDEpIGRpcy4gaW50cg0KPiA+ID4gICAgIG8gICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyKSByZWFkIGludGVycnVwdCBzdGF0dXMgbG9j
YWxseQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzKSBkbyBUWCByZWNsYWlt
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQpIGNoZWNrIGlmIFJYPw0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1KSByZS1lbmFibGUgaW50cg0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAoUlggaXMgb3B0aW9uYWwpDQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDYpIHNjaGVkdWxlX25hcGkNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgKGlmIFJYKQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgOiA+Pj4tLS0tLS0tLS0tLS0tLS0tLS0tKyA3KSAodGFza2xldCBzdGFydCBp
bW1lZGlhdGVseSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogICAgICAgICAg
ICAgICAgICAgICAgIHwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogICAgICAg
ICAgICAgICAgICAgICAgIHwgOCkgc2V0ICdkb2luZyBSWCcgZmxhZw0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgOiAgICAgICAgICAgICAgICAgICAgICAgfCA5KSBkbyBSWCB0aGlu
Z3MNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogICAgICAgICAgICAgICAgICAg
ICAgIHwgMTApIGNsZWFyICdkb2luZyBSWCcgZmxhZw0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgOiAgICAgICAgICAgICAgICAgICAgICAgfCAxMSkgcmUtZW5hYmxlIGludHIgb2Yg
UlgNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogICAgICAgICAgICAgICAgICAg
ICAgIHwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogPDw8LS0tLS0tLS0tLS0t
LS0tLS0tLW8NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG8NCj4gPiA+DQo+ID4gPiBTdGVwIDIpIHJlYWQgYW5kIGNs
ZWFyIGludGVycnVwdCBzdGF0dXMgd2l0aCBzcGluX2xvY2tfaXJxc2F2ZSwgYW5kIHVzZSBsb2Nh
bA0KPiA+ID4gdmFyaWFibGVzIHRvIHNhdmUgdGhlIHN0YXR1cy4gVGhlbiwgdGhlIHN0YXR1cyB3
aWxsIGJlIGNvcnJlY3QsIGV2ZW4gbW9yZQ0KPiA+ID4gaW50ZXJydXB0cyBhcmUgdHJpZ2dlcmVk
Lg0KPiA+ID4NCj4gPiA+IFN0ZXAgOCkvMTApIGFkZCBhICdkb2luZyBSWCcgZmxhZyB3ZSBkb24n
dCBlbmFibGUgUlggaW50ZXJydXB0IGluIHRoaXMgcGVyaW9kLCBzbw0KPiA+ID4gc3RlcCA1KSB3
aWxsIG5vdCBtYWtlIGEgbWlzdGFrZSB0byBlbmFibGUgUlggaW50ZXJydXB0IGltcHJvcGVybHku
DQo+IA0KPiBCVFcsIEkgdGhpbmsgeW91IG1pZ2h0IGJlIHBvaW50aW5nIG91dCBhIHNvcnQgb2Yg
YnVnIHdpdGggcnR3ODggLS0gYQ0KPiBub24tUlggaW50ZXJydXB0IG1pZ2h0IGNhdXNlIFJYIGlu
dGVycnVwdHMgdG8gZ2V0IHJlLWVuYWJsZWQgaW4gdGhlDQo+IG1pZHN0IG9mIHdoYXQncyAqc3Vw
cG9zZWQqIHRvIGJlIGEgTkFQSSBwb2xsLiBJdCdzIG5vdCBhIGZhdGFsDQo+IGZ1bmN0aW9uYWwg
cHJvYmxlbSBvciBhbnl0aGluZywgYnV0IGl0IGRvZXMgbWVhbiB3ZSBtaWdodCBnZXQgZXhjZXNz
DQo+IFJYIGludGVycnVwdHMsIHdoaWNoIGNhbiBkZWZlYXQgdGhlIHB1cnBvc2Ugb2YgcG9sbGlu
Zy4gSSBzdXBwb3NlIHRoZQ0KPiBpbXBhY3Qgb2Ygc3VjaCBhIGJ1ZyBkZXBlbmRzIG9uIGhvdyBm
cmVxdWVudGx5IHdlJ3JlIHJlY2VpdmluZyBvdGhlcg0KPiBpbnRlcnJ1cHRzIChzYXksIEgyQz8p
Lg0KDQpJbmRlZWQuIFdlIG5lZWQgdG8gYWRkIGEgJ2RvaW5nIFJYJyBmbGFnIHRvIHJ0dzg4LiBJ
IGhhdmUgYW5vdGhlciB0aGlua2luZywNCndoaWNoIGRvZXNuJ3QgdXNlIHRoaXMgZmxhZywgdG8g
cmVmaW5lIHJ0dzg5LCBhbmQgSSdtIHdvcmtpbmcgb24gaXQuDQpJZiBpdCB3b3JrcyB3ZWxsLCBJ
IGNhbiBhcHBseSBpdCB0byBydHc4OC4NCg0KaW50X2hhbmRsZXIgICAgICAgICAgICAgaW50X3Ro
cmVhZGZuICAgICAgICAgICAgICBuYXBpX3BvbGwNCi0tLS0tLS0tLS0tICAgICAgICAgICAgIC0t
LS0tLS0tLS0tLSAgICAgICAgICAgICAgLS0tLS0tLS0tDQogICAgfA0KICAgIHwNCiAgICB8IDEp
IGRpcy4gaW50cg0KICAgIG8gICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyKSByZWFkIGludGVycnVwdCBzdGF0dXMgbG9jYWxseQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAzKSBkbyB1bmxpa2VseSB0aGluZ3MNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgNCkgc2NoZWR1bGVfbmFwaQ0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgOiA+Pj4tLS0tLS0tLS0tLS0tLS0tLS0t
KyA1KSAodGFza2xldCBzdGFydCBpbW1lZGlhdGVseSkNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDogICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
IDogICAgICAgICAgICAgICAgICAgICAgIHwgNikgZG8gVFggY29tcGxldGlvbiB0aGluZ3MNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDogICAgICAgICAgICAgICAgICAgICAgIHwgNykgZG8g
UlggdGhpbmdzDQogICAgICAgICAgICAgICAgICAgICAgICAgICA6ICAgICAgICAgICAgICAgICAg
ICAgICB8IA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgOiAgICAgICAgICAgICAgICAgICAg
ICAgfCA4KSByZS1lbmFibGUgaW50cg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgOiAgICAg
ICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgOiA8PDwtLS0t
LS0tLS0tLS0tLS0tLS0tbw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgOg0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbw0KDQpJIGRvbid0IGNoYW5nZSB0aGUgam9icyBvZiB0aGUgaW50
X2hhbmRsZXIuIFRoZSBpbnRfdGhyZWFkIHJlYWRzIGludGVycnVwdCBzdGF0dXMNCmFuZCBzY2hl
ZHVsZXMgTkFQSSB1bmNvbmRpdGlvbmFsbHksIGJlY2F1c2Ugb25seSB1bmxpa2VseSB0aGluZ3Mg
cmVzaWRlIGluIHRoaXMNCmZ1bmN0aW9uLCBhbmQgdGhlIFRYIGNvbXBsZXRpb24gYW5kIFJYIHRo
aW5ncyBhcmUgZG9uZSBieSBuYXBpX3BvbGwuDQpGaW5hbGx5LCB0aGUgbmFwaV9wb2xsIHJlLWVu
YWJsZSBpbnRlcnJ1cHQgYWZ0ZXIgaXQgZG9lcyBhbGwgdGhpbmdzLg0KDQpUaGluZ3MgSSdtIHdv
cnJpZWQgYXJlIHRoZSBsYXRlbmN5IG9mIFJYIGFuZCBUWCBjb21wbGV0aW9uLCBhbmQgZXh0cmEg
cG9sbGluZyBJTy4NClRoZSBsYXRlbmN5IGFmZmVjdHMgcGVyZm9ybWFuY2UsIHNvIEknbGwgbWVh
c3VyZSBpdC4gQWxzbywgSSdsbCBleGFtaW5lIHRpbWUgY29zdA0Kb2YgcG9sbGluZyBJTywgYW5k
IGNvbXBhcmUgdGhlIGNvdW50IG9mIHBvbGxpbmcgSU8gYmVmb3JlL2FmdGVyIHRoaXMgY2hhbmdl
Lg0KDQpJIGhvcGUgSSBjYW4gZmluaXNoIHRoaXMgd29yayBiZWZvcmUgdjYuDQoNCi0tDQpQaW5n
LUtlDQoNCg==
