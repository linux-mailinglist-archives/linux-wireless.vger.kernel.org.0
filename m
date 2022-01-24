Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8839497790
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jan 2022 03:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiAXC7u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jan 2022 21:59:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44883 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiAXC7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jan 2022 21:59:49 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20O2xGG21017168, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20O2xGG21017168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Jan 2022 10:59:16 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 10:59:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:59:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Mon, 24 Jan 2022 10:59:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neo Jou <neojou@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ed Swierk <eswierk@gh.st>
Subject: RE: [PATCH v3 0/8] rtw88: prepare locking for SDIO support
Thread-Topic: [PATCH v3 0/8] rtw88: prepare locking for SDIO support
Thread-Index: AQHYBCp/WStseF16x0uJ7VAbWo+1y6xqJTFAgAMM/BCAA1dIAIAA+BTw
Date:   Mon, 24 Jan 2022 02:59:15 +0000
Message-ID: <5ef8ab4f78e448df9f823385d0daed88@realtek.com>
References: <20220108005533.947787-1-martin.blumenstingl@googlemail.com>
 <423f474e15c948eda4db5bc9a50fd391@realtek.com>
 <CAFBinCBVEndU0t-6d5atE31OFYHzPyk7pOe78v0XrrFWcBec9w@mail.gmail.com>
In-Reply-To: <CAFBinCBVEndU0t-6d5atE31OFYHzPyk7pOe78v0XrrFWcBec9w@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMjMg5LiL5Y2IIDExOjAwOjAw?=
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

SGksIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcnRpbiBCbHVt
ZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgSmFudWFyeSAyNCwgMjAyMiAzOjA0IEFNDQo+IFRvOiBQa3NoaWggPHBrc2hpaEByZWFs
dGVrLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgdG9ueTA2MjBl
bW1hQGdtYWlsLmNvbTsga3ZhbG9AY29kZWF1cm9yYS5vcmc7DQo+IGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IE5lbyBKb3UNCj4gPG5lb2pvdUBnbWFpbC5jb20+OyBKZXJuZWogU2tyYWJlYyA8amVy
bmVqLnNrcmFiZWNAZ21haWwuY29tPjsgRWQgU3dpZXJrIDxlc3dpZXJrQGdoLnN0Pg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDAvOF0gcnR3ODg6IHByZXBhcmUgbG9ja2luZyBmb3IgU0RJTyBz
dXBwb3J0DQo+IA0KPiBIaSBQaW5nLUtlLA0KPiANCj4gT24gRnJpLCBKYW4gMjEsIDIwMjIgYXQg
OToxMCBBTSBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+IFsuLi5dDQo+ID4g
Pg0KPiA+ID4gSSBkbyBzdHJlc3NlZCB0ZXN0IG9mIGNvbm5lY3Rpb24gYW5kIHN1c3BlbmQsIGFu
ZCBpdCBnZXQgc3R1Y2sgYWZ0ZXIgYWJvdXQNCj4gPiA+IDQgaG91cnMgYnV0IG5vIHVzZWZ1bCBt
ZXNzYWdlcy4gSSB3aWxsIHJlLWJ1aWxkIG15IGtlcm5lbCBhbmQgdHVybiBvbiBsb2NrZGVwIGRl
YnVnDQo+ID4gPiB0byBzZWUgaWYgaXQgY2FuIHRlbGwgbWUgd2hhdCBpcyB3cm9uZy4NCj4gRmly
c3Qgb2YgYWxsOiB0aGFuayB5b3Ugc28gbXVjaCBmb3IgdGVzdGluZyB0aGlzIGFuZCBpbnZlc3Rp
Z2F0aW5nIHRoZSBkZWFkbG9jayENCj4gDQo+ID4gSSBmb3VuZCBzb21lIGRlYWRsb2NrOg0KPiA+
DQo+ID4gWyA0ODkxLjE2OTY1M10gICAgICAgIENQVTAgICAgICAgICAgICAgICAgICAgIENQVTEN
Cj4gPiBbIDQ4OTEuMTY5NzMyXSAgICAgICAgLS0tLSAgICAgICAgICAgICAgICAgICAgLS0tLQ0K
PiA+IFsgNDg5MS4xNjk3OTldICAgbG9jaygmcnR3ZGV2LT5tdXRleCk7DQo+ID4gWyA0ODkxLjE2
OTg3NF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvY2soJmxvY2FsLT5zdGFfbXR4
KTsNCj4gPiBbIDQ4OTEuMTY5OTQ4XSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9j
aygmcnR3ZGV2LT5tdXRleCk7DQo+ID4gWyA0ODkxLjE3MDA1MF0gICBsb2NrKCZsb2NhbC0+c3Rh
X210eCk7DQo+ID4NCj4gPg0KPiA+IFsgNDkxOS41OTg2MzBdICAgICAgICBDUFUwICAgICAgICAg
ICAgICAgICAgICBDUFUxDQo+ID4gWyA0OTE5LjU5ODcxNV0gICAgICAgIC0tLS0gICAgICAgICAg
ICAgICAgICAgIC0tLS0NCj4gPiBbIDQ5MTkuNTk4Nzc5XSAgIGxvY2soJmxvY2FsLT5pZmxpc3Rf
bXR4KTsNCj4gPiBbIDQ5MTkuNTk4OTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bG9jaygmcnR3ZGV2LT5tdXRleCk7DQo+ID4gWyA0OTE5LjU5ODk5NV0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGxvY2soJmxvY2FsLT5pZmxpc3RfbXR4KTsNCj4gPiBbIDQ5MTkuNTk5
MDkyXSAgIGxvY2soJnJ0d2Rldi0+bXV0ZXgpOw0KPiBUaGlzIGxvb2tzIHNpbWlsYXIgdG8gdGhl
IHByb2JsZW0gZml4ZWQgYnkgNWIwZWZiNGQ2NzBjOGIgKCJydHc4ODoNCj4gYXZvaWQgY2lyY3Vs
YXIgbG9ja2luZyBiZXR3ZWVuIGxvY2FsLT5pZmxpc3RfbXR4IGFuZCBydHdkZXYtPm11dGV4IikN
Cj4gd2hpY2ggeW91IGhhdmUgcG9pbnRlZCBvdXQgZWFybGllci4NCj4gSXQgc2VlbXMgdG8gbWUg
dGhhdCB3ZSBzaG91bGQgYXZvaWQgdXNpbmcgdGhlIG11dGV4IHZlcnNpb24gb2YNCj4gaWVlZTgw
MjExX2l0ZXJhdGVfKigpIGJlY2F1c2UgaXQgY2FuIGxlYWQgdG8gbW9yZSBvZiB0aGVzZSBpc3N1
ZXMuIFNvDQo+IGZyb20gbXkgcG9pbnQgb2YgdmlldyB0aGUgZ2VuZXJhbCBpZGVhIG9mIHRoZSBj
b2RlIGZyb20geW91ciBhdHRhY2hlZA0KPiBwYXRjaCBsb29rcyBnb29kLiBUaGF0IHNhaWQsIEkn
bSBzdGlsbCB2ZXJ5IG5ldyB0byBtYWM4MDIxMS9jZmc4MDIxMQ0KPiBzbyBJJ20gYWxzbyBpbnRl
cmVzdGVkIGluIG90aGVyJ3Mgb3BpbmlvbnMuDQo+IA0KDQpUaGUgYXR0YWNoZWQgcGF0Y2ggY2Fu
IHdvcmsgIm1vc3RseSIsIGJlY2F1c2UgYm90aCBjYWxsZXJzIG9mIGl0ZXJhdGUoKSBhbmQNCjo6
cmVtb3ZlX2ludGVyZmFjZSBob2xkIHJ0d2Rldi0+bXV0ZXguIFRoZW9yZXRpY2FsbHksIHRoZSBl
eGNlcHRpb24gaXMgYSBjYWxsZXINCmZvcmtzIGFub3RoZXIgd29yayB0byBpdGVyYXRlKCkgYmV0
d2VlbiBsZWF2aW5nIDo6cmVtb3ZlX2ludGVyZmFjZSBhbmQgbWFjODAyMTENCmRvZXNuJ3QgeWV0
IGZyZWUgdGhlIHZpZiwgYnV0IHRoZSB3b3JrIGV4ZWN1dGVzIGFmdGVyIG1hYzgwMjExIGZyZWUg
dGhlIHZpZi4NClRoaXMgd2lsbCBsZWFkIHVzZS1hZnRlci1mcmVlLCBidXQgSSdtIG5vdCBzdXJl
IGlmIHRoaXMgc2NlbmFyaW8gd2lsbCBoYXBwZW4uDQpJIG5lZWQgdGltZSB0byBkaWcgdGhpcywg
b3IgeW91IGNhbiBoZWxwIHRvIGRvIHRoaXMuDQoNClRvIGF2b2lkIHRoaXMsIHdlIGNhbiBhZGQg
YSBmbGFnIHRvIHN0cnVjdCBydHdfdmlmLCBhbmQgc2V0IHRoaXMgZmxhZw0Kd2hlbiA6OnJlbW92
ZV9pbnRlcmZhY2UuIFRoZW4sIG9ubHkgY29sbGVjdCB2aWYgd2l0aG91dCB0aGlzIGZsYWcgaW50
byBsaXN0DQp3aGVuIHdlIHVzZSBpdGVyYXRlX2FjdGlvbSgpLg0KDQpBcyB3ZWxsIGFzIGllZWU4
MDIxMV9zdGEgY2FuIGRvIHNpbWlsYXIgZml4Lg0KDQo+ID4gU28sIEkgYWRkIHdyYXBwZXJzIHRv
IGl0ZXJhdGUgcnR3X2l0ZXJhdGVfc3RhcygpIGFuZCBydHdfaXRlcmF0ZV92aWZzKCkgdGhhdA0K
PiA+IHVzZSBfYXRvbWljIHZlcnNpb24gdG8gY29sbGVjdCBzdGEgYW5kIHZpZiwgYW5kIHVzZSBs
aXN0X2Zvcl9lYWNoKCkgdG8gaXRlcmF0ZS4NCj4gPiBSZWZlcmVuY2UgY29kZSBpcyBhdHRhY2hl
ZCwgYW5kIEknbSBzdGlsbCB0aGlua2luZyBpZiB3ZSBjYW4gaGF2ZSBiZXR0ZXIgbWV0aG9kLg0K
PiBXaXRoICJiZXR0ZXIgbWV0aG9kIiBkbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZSBpbiBwYXRj
aCAjMiBmcm9tIHRoaXMNCj4gc2VyaWVzICh1c2luZyB1bnNpZ25lZCBpbnQgbnVtX3NpIGFuZCBz
dHJ1Y3QgcnR3X3N0YV9pbmZvDQo+ICpzaVtSVFdfTUFYX01BQ19JRF9OVU1dIGluc2lkZSB0aGUg
aXRlcl9kYXRhKSBhcmUgeW91IHRoaW5raW5nIG9mIGENCj4gYmV0dGVyIHdheSBpbiBnZW5lcmFs
Pw0KPiANCg0KSSB3b3VsZCBsaWtlIGEgc3RyYWlnaHQgbWV0aG9kLCBmb3IgZXhhbXBsZSwgd2Ug
Y2FuIGhhdmUgYW5vdGhlciB2ZXJzaW9uIG9mDQppZWVlODAyMTFfaXRlcmF0ZV94eHgoKSBhbmQg
ZG8gdGhpbmdzIGluIGl0ZXJhdG9yLCBsaWtlIG9yaWdpbmFsLCBzbyB3ZSBqdXN0DQpuZWVkIHRv
IGNoYW5nZSB0aGUgY29kZSBzbGlnaHRseS4NCg0KSW5pdGlhbGx5LCBJIGhhdmUgYW4gaWRlYSB3
ZSBjYW4gaG9sZCBkcml2ZXIgbG9jaywgbGlrZSBydHdkZXYtPm11dGV4LCBpbiBib3RoDQpwbGFj
ZXMgd2hlcmUgd2UgdXNlIGllZWU4MDIxMV9pdGVyYXRlXygpIGFuZCByZW1vdmUgc3RhIG9yIHZp
Zi4gSG9wZWZ1bGx5LA0KdGhpcyBjYW4gZW5zdXJlIGl0J3Mgc2FmZSB0byBydW4gaXRlcmF0b3Ig
d2l0aG91dCBvdGhlciBsb2Nrcy4gVGhlbiwgd2UgY2FuDQpkZWZpbmUgYW5vdGhlciBpZWVlODAy
MTFfaXRlcmF0ZV8oKSB2ZXJzaW9uIHdpdGggYSBkcnZfbG9jayBhcmd1bWVudCwgbGlrZQ0KDQoj
ZGVmaW5lIGllZWU4MDIxMV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzX2Rydl9sb2NrKGh3LCBp
dGVyX2ZsYWdzLCBpdGVyYXRvciwgZGF0YSwgZHJ2X2xvY2spIFwNCndoaWxlICgwKSB7CVwNCgls
b2NrZGVwX2Fzc2VydF93aXBoeShkcnZfbG9jayk7IFwNCglpZWVlODAyMTFfaXRlcmF0ZV9hY3Rp
dmVfaW50ZXJmYWNlc19ub19sb2NrKGh3LCBpdGVyX2ZsYWdzLCBpdGVyYXRvciwgZGF0YSk7IFwN
Cn0NCg0KVGhlIGRyaXZfbG9jayBhcmd1bWVudCBjYW4gYXZvaWQgdXNlciBmb3JnZXR0aW5nIHRv
IGhvbGQgYSBsb2NrLCBhbmQgd2UgbmVlZA0KYSBoZWxwZXIgb2Ygbm9fbG9jayB2ZXJzaW9uOg0K
DQp2b2lkIGllZWU4MDIxMV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzX25vX2xvY2soDQoJc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsIHUzMiBpdGVyX2ZsYWdzLA0KCXZvaWQgKCppdGVyYXRvciko
dm9pZCAqZGF0YSwgdTggKm1hYywNCgkJCSBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKSwNCgl2
b2lkICpkYXRhKQ0Kew0KCXN0cnVjdCBpZWVlODAyMTFfbG9jYWwgKmxvY2FsID0gaHdfdG9fbG9j
YWwoaHcpOw0KDQoJX19pdGVyYXRlX2ludGVyZmFjZXMobG9jYWwsIGl0ZXJfZmxhZ3MgfCBJRUVF
ODAyMTFfSUZBQ0VfSVRFUl9BQ1RJVkUsDQoJCQkgICAgIGl0ZXJhdG9yLCBkYXRhKTsNCn0NCg0K
SG93ZXZlciwgYXMgSSBtZW50aW9uZWQgdGhlb3JldGljYWxseSBpdCBpcyBub3Qgc2FmZSBlbnRp
cmVseS4NCg0KU28sIEkgdGhpbmsgdGhlIGVhc2llc3Qgd2F5IGlzIHRvIG1haW50YWlucyB0aGUg
dmlmL3N0YSBsaXN0cyBpbiBkcml2ZXIgd2hlbg0KOjp7YWRkLHJlbW92ZSB9X2ludGVyZmFjZS86
OnN0YV97YWRkLHJlbW92ZX0sIGFuZCBob2xkIHJ0d2Rldi0+bXV0ZXggbG9jayB0bw0KYWNjZXNz
IHRoZXNlIGxpc3RzLiBCdXQsIEpvaGFubmVzIHBvaW50ZWQgb3V0IHRoaXMgaXMgbm90IGEgZ29v
ZCBpZGVhIFsxXS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNz
L2Q2MWYzOTQ3Y2RkZWM2NjBjYmIyYTU5ZTI0MjRkMmJkOGMwMTM0NmEuY2FtZWxAc2lwc29sdXRp
b25zLm5ldC8NCi0tDQpQaW5nLUtlDQoNCg==
