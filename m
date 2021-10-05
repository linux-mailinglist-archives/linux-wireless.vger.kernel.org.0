Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA259422258
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhJEJes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 05:34:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50287 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJes (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 05:34:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1959Wj252012747, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1959Wj252012747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 5 Oct 2021 17:32:45 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 17:32:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 5 Oct 2021 17:32:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Tue, 5 Oct 2021 17:32:44 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 03/24] rtw89: add core and trx files
Thread-Topic: [PATCH v6 03/24] rtw89: add core and trx files
Thread-Index: AQHXlXz/YnZ2oZOf0EqyX08JkH+H2au+l1CcgAWc+lCAABr9Wv//iXKAgACQu8A=
Date:   Tue, 5 Oct 2021 09:32:44 +0000
Message-ID: <a8dd5e59fb8f491fb34e52d495cf4c85@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
 <20210820043538.12424-4-pkshih@realtek.com> <877dewiudp.fsf@codeaurora.org>
 <4b2f1c6b06e040d19b64d07500e0447b@realtek.com>
 <87pmsjgbhp.fsf@codeaurora.org>
 <CAK8P3a0T4iqtF0wj5+VUT6z3S2yGC4uaOr806NCiQTpYoPawUg@mail.gmail.com>
In-Reply-To: <CAK8P3a0T4iqtF0wj5+VUT6z3S2yGC4uaOr806NCiQTpYoPawUg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzUg5LiK5Y2IIDA3OjExOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/05/2021 09:12:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166509 [Oct 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/05/2021 09:15:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgNSwgMjAyMSA0OjQyIFBNDQo+
IFRvOiBLYWxsZSBWYWxvIDxrdmFsb0Bjb2RlYXVyb3JhLm9yZz4NCj4gQ2M6IFBrc2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPjsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAzLzI0XSBy
dHc4OTogYWRkIGNvcmUgYW5kIHRyeCBmaWxlcw0KPiANCj4gT24gVHVlLCBPY3QgNSwgMjAyMSBh
dCA5OjQ2IEFNIEthbGxlIFZhbG8gPGt2YWxvQGNvZGVhdXJvcmEub3JnPiB3cm90ZToNCj4gPiBQ
a3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiA+ID4+IEZyb206IGt2YWxvPWNv
ZGVhdXJvcmEub3JnQG1nLmNvZGVhdXJvcmEub3JnDQo+ID4gPj4NCj4gPiA+PiA+ICtzdGF0aWMg
X19hbHdheXNfaW5saW5lIHZvaWQgUlRXODlfU0VUX1RYV0QodTggKnR4ZGVzYywgdTMyIHZhbCwN
Cj4gPiA+PiA+IHU4IG9mZnNldCwgdTMyIG1hc2spDQo+ID4gPj4gPiArew0KPiA+ID4+ID4gKyAg
dTMyICp0eGQzMiA9ICh1MzIgKil0eGRlc2M7DQo+ID4gPj4gPiArDQo+ID4gPj4gPiArICBsZTMy
cF9yZXBsYWNlX2JpdHMoKF9fbGUzMiAqKSh0eGQzMiArIG9mZnNldCksIHZhbCwgbWFzayk7DQo+
ID4gPj4gPiArfQ0KPiA+ID4+DQo+ID4gPj4gSSdtIG5vdCBjb252aW5jZWQgYWJvdXQgdGhpcyBl
aXRoZXIsIHBsZWFzZSBqdXN0IHVzZSBpbmxpbmUuDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBiZWNh
dXNlICdtYXNrJyBhcmd1bWVudCBvZiBsZTMycF9yZXBsYWNlX2JpdHMoKSBtdXN0IGJlIGNvbnN0
YW50DQo+ID4gPiBvbmx5LiBJZiBJIHVzZSBpbmxpbmUgYW5kIGJ1aWxkIHRoaXMgZHJpdmVyIHdp
dGggY2NmbGFncy15ICs9IC1PcywNCj4gPiA+IGNvbXBpbGVyIHJlcG9ydHMgZXJyb3JzOg0KPiA+
ID4NCj4gPiA+IEluIGZ1bmN0aW9uICdmaWVsZF9tdWx0aXBsaWVyJywNCj4gPiA+ICAgICBpbmxp
bmVkIGZyb20gJ2xlMzJfZW5jb2RlX2JpdHMnIGF0IC4vaW5jbHVkZS9saW51eC9iaXRmaWVsZC5o
OjE1NDoxLA0KPiA+ID4gICAgIGlubGluZWQgZnJvbSAnbGUzMnBfcmVwbGFjZV9iaXRzJyBhdCAu
L2luY2x1ZGUvbGludXgvYml0ZmllbGQuaDoxNTQ6MSwNCj4gPiA+ICAgICBpbmxpbmVkIGZyb20g
J1JUVzg5X1NFVF9GV0NNRF9VQTMyLmNvbnN0cHJvcCcgYXQNCj4gL3dvcmsvZ2l0LXJvb3QvcnR3
bGFuL3J0dzg5L2Z3Lmg6MTM5NzoyOg0KPiA+ID4gLi9pbmNsdWRlL2xpbnV4L2JpdGZpZWxkLmg6
MTE5OjM6IGVycm9yOiBjYWxsIHRvICdfX2JhZF9tYXNrJyBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0
ZSBlcnJvcjoNCj4gYmFkIGJpdGZpZWxkIG1hc2sNCj4gPiA+ICAgMTE5IHwgICBfX2JhZF9tYXNr
KCk7DQo+ID4gPiAgICAgICB8ICAgXn5+fn5+fn5+fn5+DQo+ID4gPg0KPiA+ID4gSSBjaGVjayB0
aGUgaW1wbGVtZW50IG9mIGxlMzJwX3JlcGxhY2VfYml0cygpLCBpdCBsb29rcyBsaWtlDQo+ID4g
Pg0KPiA+ID4gc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHR5cGUjI3BfcmVwbGFjZV9iaXRz
KF9fIyN0eXBlICpwLCAgICAgICAgICAgXA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJhc2UgdmFsLCBiYXNlIGZpZWxkKSAgICAgICAgICAgXA0KPiA+ID4g
eyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPiA+ID4gICAgICAgICAqcCA9ICgqcCAmIH50byhmaWVsZCkpIHwg
dHlwZSMjX2VuY29kZV9iaXRzKHZhbCwgZmllbGQpOyAgICAgICAgXA0KPiA+ID4gfQ0KPiA+ID4N
Cj4gPiA+IFNvLCBJIGltaXRhdGUgdGhlIGZ1bmN0aW9uIHRvIHVzZSBfX2Fsd2F5c19pbmxpbmUs
IGFuZCB0aGVuIGl0IHdvcmtzLg0KPiA+ID4NCj4gPiA+IERvIHlvdSB0aGluayBJIGRvbid0IG5l
ZWQgdG8gY29uc2lkZXIgdGhlIGNhc2Ugb2YgT3M/DQo+ID4gPiBCdXQsIC1PcyBzZWVtcyBhIHN0
YW5kYXJkIG9wdGlvbiBvZiBMaW51eCBrZXJuZWwuDQo+ID4gPg0KPiA+ID4gaWZkZWYgQ09ORklH
X0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRQ0KPiA+ID4gS0JVSUxEX0NGTEFHUyArPSAtTzIN
Cj4gPiA+IGVsc2UgaWZkZWYgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRV9PMw0K
PiA+ID4gS0JVSUxEX0NGTEFHUyArPSAtTzMNCj4gPiA+IGVsc2UgaWZkZWYgQ09ORklHX0NDX09Q
VElNSVpFX0ZPUl9TSVpFDQo+ID4gPiBLQlVJTERfQ0ZMQUdTICs9IC1Pcw0KPiA+ID4gZW5kaWYN
Cj4gPg0KPiA+IFllYWgsIHdlIG5lZWQgdG8gc3VwcG9ydCAtT3MuDQo+ID4NCj4gPiBBcm5kLCB3
aGF0IGRvIHlvdSBzdWdnZXN0PyBJcyBfX2Fsd2F5c19pbmxpbmUgZ29vZCBzb2x1dGlvbiBmb3Ig
dGhpcz8gSQ0KPiA+IHRoaW5rIHdlIHNob3VsZCBhdCBsZWFzdCBhZGQgYSBjb21tZW50IGV4cGxh
aW5pbmcgd2h5IGl0J3MgbmVlZGVkLg0KPiANCj4gX19hbHdheXNfaW5saW5lIGNhbiBtYWtlIHNl
bnNlIHRvIGZvcmNlIHRoZSBjb21waWxlciB0byBiZWhhdmUNCj4gc2FuZWx5IGlmIGl0IGRvZXNu
J3Qgd29yayBpdCBvdXQgYnkgaXRzZWxmLCBhbmQgSSB0aGluayB0aGF0IGlzIGhvdyB0aGlzDQo+
IGZ1bmN0aW9uIHdhcyBtZWFudCB0byBiZSB1c2VkOiB0aGUgX19jb21waWxldGltZV9lcnJvciBp
biBiaXRmaWVsZC5oDQo+IGlzIGludGVuZGVkIHRvIGZpbmQgYW55IGNhbGxlcnMgdGhhdCBoYXZl
IGEgbm9uLWNvbnN0YW50IGFyZ3VtZW50LA0KPiBiZWNhdXNlIHRoYXQgd291bGQgcmVzdWx0IGlu
IGhvcnJpYmxlIGNvZGUuDQo+IA0KPiBJIHdvdWxkIHN1Z2dlc3QgbG9va2luZyBhdCB0aGUgb2Jq
ZWN0IGNvZGUgdGhhdCB5b3UgZ2V0IHdpdGggLU9zIGFmdGVyDQo+IHRoZSBhZGRlZCBfX2Fsd2F5
c19pbmxpbmUsIGp1c3QgdG8gbWFrZSBzdXJlIHRoYXQgdGhpcyBpc24ndCBhbHNvDQo+IGhvcnJp
YmxlLg0KDQpJIGNoZWNrIHRoZSBmdW5jdGlvbiBydHc4OV9jb3JlX2ZpbGxfdHhkZXNjKCkgd2hp
Y2ggdXNlcyB0aGVzZSBtYWNyb3MuDQpXaXRoIGlubGluZSwgdGhlIG9iamVjdCBjb2RlIHNpemUg
aXMgMHgxQUYuIFdpdGggX19hbHdheXNfaW5saW5lIGFuZA0KLU9zLCB0aGUgc2l6ZSBpcyAweDFB
NC4gKHg4Ni02NCBwbGF0Zm9ybSkNCg0KQ29tcGFyZSB0aGUgb2JqZWN0IGNvZGVzIHNpZGUtYnkt
c2lkZSwgdGhleSBhcmUgYWxtb3N0IHRoZSBzYW1lIGV4Y2VwdA0KdG8gc29tZSBpbnN0cnVjdGlv
bnMuIEkgdGhpbmsgdGhpcyBpcyBiZWNhdXNlIHRoZSBpbmxpbmUgZnVuY3Rpb24NCkkgYXBwbHkg
X19hbHdheXNfaW5saW5lIGNvbnRhaW5zIG9ubHkgYSBzaW1wbGUgc3RhdGVtZW50Lg0KDQo+IA0K
PiBMb29raW5nIGF0IHRoZSBkcml2ZXIgY29kZSwgYXMgaW4NCj4gDQo+ICsjZGVmaW5lIFJUVzg5
X1NFVF9UWFdEX0JPRFlfV1BfT0ZGU0VUKHR4ZGVzYywgdmFsKSBcDQo+ICsgUlRXODlfU0VUX1RY
V0QodHhkZXNjLCB2YWwsIDB4MDAsIEdFTk1BU0soMzEsIDI0KSkNCj4gKyNkZWZpbmUgUlRXODlf
U0VUX1RYV0RfQk9EWV9NT1JFX0RBVEEodHhkZXNjLCB2YWwpIFwNCj4gKyBSVFc4OV9TRVRfVFhX
RCh0eGRlc2MsIHZhbCwgMHgwMCwgQklUKDIzKSkNCj4gKyNkZWZpbmUgUlRXODlfU0VUX1RYV0Rf
Qk9EWV9XRF9JTkZPX0VOKHR4ZGVzYywgdmFsKSBcDQo+ICsgUlRXODlfU0VUX1RYV0QodHhkZXNj
LCB2YWwsIDB4MDAsIEJJVCgyMikpDQo+ICsjZGVmaW5lIFJUVzg5X1NFVF9UWFdEX0JPRFlfRldf
REwodHhkZXNjLCB2YWwpIFwNCj4gKyBSVFc4OV9TRVRfVFhXRCh0eGRlc2MsIHZhbCwgMHgwMCwg
QklUKDIwKSkNCj4gDQo+IEkgd291bGQgcGVyc29uYWxseSB3cml0ZSB0aGlzIHdpdGhvdXQgdGhl
IHdyYXBwZXJzLCBpbnN0ZWFkIGRlZmluaW5nIHRoZQ0KPiBiaXRtYXNrIG1hY3JvcyBhcyB0aGUg
bWFza3MgYW5kIHRoZW4gb3Blbi1jb2RpbmcgdGhlDQo+IGxlMzJwX3JlcGxhY2VfYml0cygpIGNh
bGxzIGluc3RlYWQsIHdoaWNoIEkgd291bGQgZmluZCBtb3JlDQo+IGludHVpdGl2ZSB3aGlsZSBp
dCBhdm9pZHMgdGhlIHByb2JsZW0gd2l0aCB0aGUgYml0bWFza3MuDQoNClVzZSB0aGVzZSBtYWNy
b3MgY2FuIGFkZHJlc3Mgb2Zmc2V0IGFuZCBiaXQgZmllbGRzIHF1aWNrbHkuDQpIb3cgYWJvdXQg
SSB1c2UgbWFjcm8gaW5zdGVhZCBvZiBpbmxpbmUgZnVuY3Rpb24/IExpa2UsDQoNCiNkZWZpbmUg
UlRXODlfU0VUX1RYV0QgKHR4ZGVzYywgdmFsLCBvZmZzZXQsIG1hc2spIFwNCmRvIHsgXA0KCXUz
MiAqdHhkMzIgPSAodTMyICopdHhkZXNjOyBcDQoJbGUzMnBfcmVwbGFjZV9iaXRzKChfX2xlMzIg
KikodHhkMzIgKyBvZmZzZXQpLCB2YWwsIG1hc2spOyBcDQp9IHdoaWxlICgwKQ0KDQoNCj4gR29p
bmcgYmFjayBvbmUgbW9yZSBzdGVwLCBJIHNlZSB0aGF0IHRoYXQgcnR3ODlfY29yZV9maWxsX3R4
ZGVzYygpDQo+IG1hbmlwdWxhdGVzIHRoZSBkZXNjcmlwdG9yIGZpZWxkcyBpbi1tZW1vcnksIHdo
aWNoIGFsc28gc2VlbXMNCj4gbGlrZSBhIGJhZCBpZGVhOiBUaGUgZGVzY3JpcHRvciBpcyBtYXBw
ZWQgYXMgY2FjaGUtY29oZXJlbnQsDQo+IHNvIG9uIG1hY2hpbmVzIHdpdGggbm8gY29oZXJlbnQg
RE1BIChpLmUuIG1vc3QgQVJNIG9yIE1JUFMNCj4gbWFjaGluZXMpLCB0aGF0IGlzIHVuY2FjaGVk
IG1lbW9yeSwgYW5kIHdyaXRpbmcgdGhlIGRlc2NyaXB0b3INCj4gdXNpbmcgYSBzZXJpZXMgb2Yg
cmVhZC1tb2RpZnktd3JpdGUgY3ljbGVzIG9uIHVuY2FjaGVkIG1lbW9yeQ0KPiB3aWxsIGJlIGF3
ZnVsbHkgc2xvdy4gTWF5YmUgdGhlIGFuc3dlciBpcyB0byBqdXN0IGNvbXBsZXRlbHkNCj4gcmVw
bGFjZSB0aGUgZGVzY3JpcHRvciBhY2Nlc3MuDQoNCkknbGwgdGhpbmsgaWYgd2UgY2FuIHVzZSBj
aGFjaGVkIG1lbW9yeSB3aXRoIHNpbmdsZV9tYXAvdW5tYXAgZm9yDQpkZXNjcmlwdG9yLiBUaGF0
IHdvdWxkIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlLg0KDQotLQ0KUGluZy1LZQ0KDQo=
