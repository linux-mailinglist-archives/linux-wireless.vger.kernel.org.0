Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234FA3B1A7D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWMvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 08:51:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60653 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 08:51:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15NCnIWV1002530, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15NCnIWV1002530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Jun 2021 20:49:18 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 23 Jun 2021 20:49:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 23 Jun 2021 20:49:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Wed, 23 Jun 2021 20:49:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA is connected HE
Thread-Topic: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA
 is connected HE
Thread-Index: AQHXXm6ItuGkMH9RLkaoOlE6YAkORKsOIMzwgBNZNwWAACI2oA==
Date:   Wed, 23 Jun 2021 12:49:15 +0000
Message-ID: <8f1524261420449d87b86e9067f3d74f@realtek.com>
References: <20210611030422.9608-1-pkshih@realtek.com>
         <072bfd8473ac4054a43818009e66a914@realtek.com>
         (sfid-20210611_052347_394259_CA96FBDB)
 <05835527eb79d7bad22b20247b351b82cc0776d3.camel@sipsolutions.net>
In-Reply-To: <05835527eb79d7bad22b20247b351b82cc0776d3.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMjMg5LiK5Y2IIDA4OjA2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/23/2021 12:32:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164580 [Jun 23 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: patchwork.kernel.org:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/23/2021 12:35:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgW21h
aWx0bzpqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0XQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUg
MjMsIDIwMjEgNjozMyBQTQ0KPiBUbzogUGtzaGloDQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbWFjODAyMTE6IEZpeCBzdyBjb25u
ZWN0aW9uIG1vbml0b3IgYW5kIHN3IHNjYW4gd2hlbiBTVEEgaXMgY29ubmVjdGVkIEhFDQo+IA0K
PiA+IEhpIG1hYzgwMjExIHRlYW0sDQo+ID4NCj4gPiBXZSBhcmUgd29ya2luZyBvbiBSZWFsdGVr
IDExYXggZHJpdmVyLCBydHc4OSwgbm90IGJlaW5nIG1lcmdlZCB5ZXQuDQo+ID4gVGhpcyBkcml2
ZXIgdXNlcyBzb2Z0d2FyZSBjb25uZWN0aW9uIG1vbml0b3IgYW5kIHNvZnR3YXJlIHNjYW4sIGxp
a2UNCj4gPiBvdXIgMTFhYyBkcml2ZXIgcnR3ODgsDQo+ID4gYnV0IHdlIGZvdW5kIHRoZXNlIHR3
byBmdW5jdGlvbnMgZG9uJ3Qgd29yayBwcm9wZXJseSBkdWUgdG8gbWFjODAyMTENCj4gPiBkb2Vz
bid0IHNlbmQNCj4gPiBudWxsIGRhdGEgZnJhbWUgd2hlbiBTVEEgaXMgY29ubmVjdGVkIEhFLg0K
PiA+DQo+ID4gV2Ugc2VhcmNoIGZvciB0aGUgcmVhc29uIHdoeSBpdCBjYW4ndCBzZW5kIG51bGwg
ZnJhbWUsIGJ1dCB3ZSBkb24ndA0KPiA+IGdldCB0aGUgYW5zd2VyLg0KPiA+IFBvc3NpYmx5LCBp
dCBpcyBiZWNhdXNlIGV4aXN0aW5nIEhFIGhhcmR3YXJlIHN1cHBvcnRzIGhhcmR3YXJlDQo+ID4g
Y29ubmVjdGlvbiBtb25pdG9yDQo+ID4gYW5kIHNjYW4sIG9yIHN1cHBvcnRzIFRXVCB0byBhdm9p
ZCBzZW5kaW5nIG51bGwgZGF0YSBmcmFtZSB0byB0ZWxsIEFQDQo+ID4gaXRzIFBTIG1vZGUuDQo+
ID4gQ291bGQgYW55b25lIGVubGlnaHRlbiBtZSB0aGUgcmVhc29uPw0KPiANCj4gSXQgd2FzIGp1
c3QgYSB3b3JrYXJvdW5kIGZvciBhbiBpd2x3aWZpIHNwZWNpZmljIGlzc3VlIHRoYXQgZ290IGxl
ZnQgaW4uDQo+IEkganVzdCBtZXJnZWQgYSBwYXRjaCBmcm9tIEZlbGl4IHRvIHJlc29sdmUgdGhh
dC4NCj4gDQoNCkkgY2hlY2sgRmVsaXgncyBwYXRjaDoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIxMDYxOTEwMTUxNy45MDgwNi0x
LW5iZEBuYmQubmFtZS8NCg0KDQpJIHRoaW5rIHdlIHNob3VsZCByZXZlcnQgdGhlIGNvbW1pdCBm
MzliMDdmZGZiNjggKCJtYWM4MDIxMTogSEUgU1RBIGRpc2Fzc29jIGR1ZSB0byBRT1MgTlVMTCBu
b3Qgc2VudCIpLA0Kd2hpY2ggZml4ZXMgY29ubmVjdGlvbiBtb25pdG9yIGR1ZSB0byBRT1MgTlVM
TCBub3Qgc2VuZC4NCg0KDQpBbm90aGVyIHBsYWNlIGlzIGllZWU4MDIxMV9zZW5kX251bGxfcmVz
cG9uc2UoKTsgSSdtIG5vdCBzdXJlIGlmIHdlIGNhbiByZW1vdmUNCnRoZSBjaGVja2luZyBhcyB3
ZWxsLg0KDQpkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL3N0YV9pbmZvLmMgYi9uZXQvbWFjODAy
MTEvc3RhX2luZm8uYw0KaW5kZXggZjJmYjY5ZGE5YjZlLi4xMzI1MGNhZGI0MjAgMTAwNjQ0DQot
LS0gYS9uZXQvbWFjODAyMTEvc3RhX2luZm8uYw0KKysrIGIvbmV0L21hYzgwMjExL3N0YV9pbmZv
LmMNCkBAIC0xMzk4LDExICsxMzk4LDYgQEAgc3RhdGljIHZvaWQgaWVlZTgwMjExX3NlbmRfbnVs
bF9yZXNwb25zZShzdHJ1Y3Qgc3RhX2luZm8gKnN0YSwgaW50IHRpZCwNCiAgICAgICAgc3RydWN0
IGllZWU4MDIxMV90eF9pbmZvICppbmZvOw0KICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5j
dHhfY29uZiAqY2hhbmN0eF9jb25mOw0KIA0KLSAgICAgICAvKiBEb24ndCBzZW5kIE5EUHMgd2hl
biBTVEEgaXMgY29ubmVjdGVkIEhFICovDQotICAgICAgIGlmIChzZGF0YS0+dmlmLnR5cGUgPT0g
Tkw4MDIxMV9JRlRZUEVfU1RBVElPTiAmJg0KLSAgICAgICAgICAgIShzZGF0YS0+dS5tZ2QuZmxh
Z3MgJiBJRUVFODAyMTFfU1RBX0RJU0FCTEVfSEUpKQ0KLSAgICAgICAgICAgICAgIHJldHVybjsN
Ci0NCiAgICAgICAgaWYgKHFvcykgew0KICAgICAgICAgICAgICAgIGZjID0gY3B1X3RvX2xlMTYo
SUVFRTgwMjExX0ZUWVBFX0RBVEEgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
SUVFRTgwMjExX1NUWVBFX1FPU19OVUxMRlVOQyB8DQoNCi0tDQpQaW5nLUtlDQoNCg0K
