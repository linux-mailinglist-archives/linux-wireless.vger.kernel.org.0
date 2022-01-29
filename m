Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953FE4A2B76
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 04:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbiA2DgY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 22:36:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44247 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiA2DgX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 22:36:23 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20T3aFxR5019637, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20T3aFxR5019637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 29 Jan 2022 11:36:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 29 Jan 2022 11:36:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 11:36:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Sat, 29 Jan 2022 11:36:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
Thread-Topic: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
Thread-Index: AQHYA3i7Zng9D27u60C+yxZ+ujbTSKx4tvl4gAA+sgA=
Date:   Sat, 29 Jan 2022 03:36:14 +0000
Message-ID: <97e80d86f5b925a0b2337d15c56e88d3808b6efe.camel@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
         <20220107034239.22002-14-pkshih@realtek.com> <874k5ng8oq.fsf@kernel.org>
In-Reply-To: <874k5ng8oq.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.93.154]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMjgg5LiL5Y2IIDEwOjU1OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BC8F67E932D6444B4A48C3673839E61@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTAxLTI4IGF0IDE3OjUxICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGaWxsIG1h
Y19pZCBhbmQgc2VsZl9yb2xlIGRlcGVuZHMgb24gdGhlIG9wZXJhdGlvbiBtb2RlLg0KPiA+IA0K
PiA+IEluIEFQIG1vZGUsIGVjaG8gY29ubmVjdGVkIHN0YXRpb24gaGFzIGFuIHVuaXF1ZSBtYWNf
aWQsIGFuZCBlYWNoIHZpZiBhbHNvDQo+ID4gaGFzIG9uZSBtYWNfaWQgdG8gcmVwcmVzZW50IGl0
c2VsZi4NCj4gPiANCj4gPiBUaGUgc2VsZl9yb2xlIGlzIGFzc2lnbmVkIHRvIHZpZiBpZiB0aGUg
b3BlcmF0aW9uIG1vZGUgaXMgZGVjaWRlZCwgYW5kDQo+ID4gUlRXODlfU0VMRl9ST0xFX0FQX0NM
SUVOVCBpcyBhc3NpZ25lZCB0byB0aGUgY29ubmVjdGVkIFNUQSBpbiBBUCBtb2RlLA0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMgIHwgOCAr
KysrKystLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmggIHwg
MSArDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgfCA0ICsr
LS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvZncuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0KPiA+IGlu
ZGV4IDUyMDk4MTMyNzU2NzYuLjQ2NDFhYWRlYTAzODYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+ID4gQEAgLTk5Myw5ICs5OTMsMTMgQEAgaW50
IHJ0dzg5X2Z3X2gyY191cGRhdGVfYmVhY29uKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4g
PiAgI2RlZmluZSBIMkNfUk9MRV9NQUlOVEFJTl9MRU4gNA0KPiA+ICBpbnQgcnR3ODlfZndfaDJj
X3JvbGVfbWFpbnRhaW4oc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiA+ICAJCQkgICAgICAg
c3RydWN0IHJ0dzg5X3ZpZiAqcnR3dmlmLA0KPiA+ICsJCQkgICAgICAgc3RydWN0IHJ0dzg5X3N0
YSAqcnR3c3RhLA0KPiA+ICAJCQkgICAgICAgZW51bSBydHc4OV91cGRfbW9kZSB1cGRfbW9kZSkN
Cj4gPiAgew0KPiA+ICAJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4gPiArCXU4IG1hY19pZCA9IHJ0
d3N0YSA/IHJ0d3N0YS0+bWFjX2lkIDogcnR3dmlmLT5tYWNfaWQ7DQo+ID4gKwl1OCBzZWxmX3Jv
bGUgPSBydHd2aWYtPm5ldF90eXBlID09IFJUVzg5X05FVF9UWVBFX0FQX01PREUgJiYgcnR3c3Rh
ID8NCj4gPiArCQkgICAgICAgUlRXODlfU0VMRl9ST0xFX0FQX0NMSUVOVCA6IHJ0d3ZpZi0+c2Vs
Zl9yb2xlOw0KPiANCj4gSXQgc2VlbXMgeW91IGxpa2UgJz8nIG9wZXJhdG9yIG1vcmUgdGhhbiBJ
IGRvLCBhbmQgaXQncyBvayB0byB1c2UgaW4NCj4gc2ltcGxlIGNhc2VzLiBCdXQgdGhlIGxhdHRl
ciBzdGF0ZW1lbnQgaXMgbm90IHJlYWxseSByZWFkYWJsZSwgc29tZXRoaW5nDQo+IGxpa2UgdGhp
cyBpcyBzbyBtdWNoIGVhc2llciB0byByZWFkOg0KPiANCj4gaWYgKHJ0d3ZpZi0+bmV0X3R5cGUg
PT0gUlRXODlfTkVUX1RZUEVfQVBfTU9ERSAmJiBydHdzdGEpDQo+ICAgICBzZWxmX3JvbGUgPSBS
VFc4OV9TRUxGX1JPTEVfQVBfQ0xJRU5UDQo+IGVsc2UNCj4gICAgIHNlbGZfcm9sZSA9IHJ0d3Zp
Zi0+c2VsZl9yb2xlOw0KPiANCg0KSSB1c2UgJz8nIHRvIG1ha2UgY29kZSBzaG9ydGVyLCBidXQg
eW91ciBzdWdlZXN0aW9uIHdvdWxkIGJlIGVhaXNlciB0byByZXZpZXdlci4NCkkgd2lsbCBzZW5k
IHYyIGFmdGVyIHRoZSBMdW5hciBOZXcgWWVhci4gDQoNCg0KPiBCdXQgc2hvdWxkIHRoZXJlIGEg
cGFyZW50aGVzaXMgYXJvdW5kIHRoZSA9PSBvcGVyYXRvcj8gSSBjYW5ub3Qgbm93DQo+IHJlY2Fs
bCB3aGF0J3MgdGhlIHByZWZlcmVuY2UgaW4gdGhlIGtlcm5lbCwgY2FuIHNvbWVvbmUgaGVscCBv
biB0aGF0Pw0KDQpUaGUgY2hlY2twYXRjaCB3aWxsIHdhcm4gdGhpcyBpZiB3ZSBhZGQgcGFyZW50
aGVzaXMsIHNvIHByZWVuY2UgaXMgbm90IHRvDQp1c2UgcGFyZW50aGVzaXMuDQoNCkNIRUNLOlVO
TkVDRVNTQVJZX1BBUkVOVEhFU0VTOiBVbm5lY2Vzc2FyeSBwYXJlbnRoZXNlcyBhcm91bmQgJ3J0
d3ZpZi0+bmV0X3R5cGUgPT0NClJUVzg5X05FVF9UWVBFX0FQX01PREUnDQojOTogRklMRTogZncu
YzoxMDA0Og0KKwlpZiAoKHJ0d3ZpZi0+bmV0X3R5cGUgPT0gUlRXODlfTkVUX1RZUEVfQVBfTU9E
RSkgJiYgcnR3c3RhKQ0KDQo+IA0KPiBNYXliZSBJIGFsc28gbW92ZSBjaGVjayBmb3IgcnR3c3Rh
IGZpcnN0Pw0KPiANCg0KVGhlIGZ1bGwgbG9naWMgaXMgDQoNCmlmIChydHd2aWYtPm5ldF90eXBl
ID09IFJUVzg5X05FVF9UWVBFX0FQX01PREUpIHsNCiAgICBpZiAocnR3c3RhKQ0KICAgICAgICBz
ZWxmX3JvbGUgPSBSVFc4OV9TRUxGX1JPTEVfQVBfQ0xJRU5UDQogICAgZWxzZQ0KICAgICAgICBz
ZWxmX3JvbGUgPSBydHd2aWYtPnNlbGZfcm9sZTsNCn0gZWxzZSB7DQogICAgc2VsZl9yb2xlID0g
cnR3dmlmLT5zZWxmX3JvbGU7DQp9DQoNCkFuZCwgdGhlIG1lYW5pbmcgb2YgJ3J0d3N0YScgaGVy
ZSBpcyB0byBpbmRpY2F0ZSB3ZSBhcmUgZ29pbmcgdG8gc2V0dXAgDQphIGNvbm5lY3RlZCBzdGF0
aW9uIHRoYXQgY29ubmVjdHMgdG8gdGhpcyBBUCwgYnV0IG5vdCBjaGVjayBpZiB0aGUNCnBvaW50
ZXIgaXMgTlVMTC4gVG8gZW1waGFzaXMgdGhlIGNhc2UgaXMgb25seSBleGlzdGluZyBpbiBBUF9N
T0RFLA0KSSBwcmVmZXIgdG8gY2hlY2sgbmV0X3R5cGUgYWhlYWQuIE9yLCB0aGlzIGZ1bGwgbG9n
aWMgaXMgcHJlZmVycmVkPw0KDQoNClBpbmctS2UNCg0K
