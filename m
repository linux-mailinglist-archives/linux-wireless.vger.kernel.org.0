Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4113E48606B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 06:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiAFFx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 00:53:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49893 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAFFx4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 00:53:56 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2065rdzwF026361, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2065rdzwF026361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 6 Jan 2022 13:53:39 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 13:53:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 21:53:38 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Thu, 6 Jan 2022 13:53:38 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kevin Yang <kevin_yang@realtek.com>
CC:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: RE: rtw88: EDCCA makes Wi-Fi unusable with a USB 3.0 SSD connected
Thread-Topic: rtw88: EDCCA makes Wi-Fi unusable with a USB 3.0 SSD connected
Thread-Index: AQHYAZ8mkE1jd7NZiEmhM0rWcb+tAqxVXi5w
Date:   Thu, 6 Jan 2022 05:53:38 +0000
Message-ID: <c1a47f94d9a7408e9891dd15ba177992@realtek.com>
References: <994addcb-a203-d718-fc92-c7f1d9ef05fb@gmail.com>
In-Reply-To: <994addcb-a203-d718-fc92-c7f1d9ef05fb@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNiDkuIrljYggMDQ6MDk6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbHBlciBOZWJpIFlh
c2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFy
eSA1LCAyMDIyIDM6MTMgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsg
UGtzaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBLZXZpbiBZYW5nIDxrZXZpbl95YW5nQHJlYWx0
ZWsuY29tPg0KPiBDYzogWWFuLUhzdWFuIENodWFuZyA8dG9ueTA2MjBlbW1hQGdtYWlsLmNvbT47
IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IHJ0dzg4OiBFRENDQSBt
YWtlcyBXaS1GaSB1bnVzYWJsZSB3aXRoIGEgVVNCIDMuMCBTU0QgY29ubmVjdGVkDQo+IA0KPiBI
aSwNCj4gDQo+IEkgaGF2ZSBhIGxhcHRvcCB3aXRoIGEgcnR3Xzg4MjJiZSB3aXJlbGVzcyBjYXJk
IGFuZCBib290IERlYmlhbiBvbiBpdA0KPiBmcm9tIGFuIGV4dGVybmFsIFVTQiAzLjAgU1NELiBJ
IGFsc28gY29uZmlndXJlZCB0aGUgd2lyZWxlc3MgcmVndWxhdG9yeQ0KPiBkb21haW4gYXMgVFIg
KERGUy1FVFNJKS4gVGhpbmdzIHdvcmtlZCBmaW5lIHRoaXMgd2F5IHVudGlsIHRoZSB2NS4xNi1y
Yw0KPiByZWxlYXNlcyB3aGVyZSBJIGhhdmUgYmVlbiBwcmFjdGljYWxseSB1bmFibGUgdG8gdXNl
IFdpLUZpLiBUaGUgbmV0d29yaw0KPiBzaG93cyBhcyBjb25uZWN0ZWQgYnV0IEkgY2FuJ3QgbG9h
ZCBhbnkgd2Vic2l0ZSwgcGluZ3MgdG8gbXkgcm91dGVyDQo+IG1vc3RseSBmYWlsIHdpdGggIkRl
c3RpbmF0aW9uIEhvc3QgVW5yZWFjaGFibGUiLg0KPiANCj4gSSB0cmFja2VkIGl0IGRvd24gdG8g
Y29tbWl0IDcyODVlYjk2OTNhMiAoInJ0dzg4OiBzdXBwb3J0IGFkYXB0aXZpdHkgZm9yDQo+IEVU
U0kvSlAgREZTIHJlZ2lvbiIpLCB0cmllZCB0aGUgZGVidWdmcyB0b2dnbGUgbWVudGlvbmVkIGlu
IHRoYXQgY29tbWl0LA0KPiBhbmQgZm91bmQgYSBmZXcgbW9yZSB0aGluZ3MgdGhhdCBhbHNvIHdv
cms6DQo+IA0KPiAtIGVjaG8gMCB8IHN1ZG8gdGVlIC9zeXMva2VybmVsL2RlYnVnL2llZWU4MDIx
MS9waHkwL3J0dzg4L2VkY2NhX2VuYWJsZQ0KPiAtIENvbm5lY3RpbmcgdGhlIFNTRCB0aHJvdWdo
IGEgVVNCIDIuMCBodWINCj4gLSBDb25uZWN0aW5nIHRoZSBTU0QgdG8gdGhlIHBvcnQgb24gb3Ro
ZXIgc2lkZSBvZiB0aGUgbGFwdG9wDQo+IC0gUHV0dGluZyBteSBwaG9uZSBuZXh0IHRvIHRoZSBk
aXNwbGF5LCAic2hpZWxkaW5nIiBpdCBmcm9tIHRoZSBwb3J0cw0KPiANCj4gQWxsIGNvbWJpbmVk
IGxlYWQgbWUgdG8gdGhpbmsgaXQncyBpbnRlcmZlcmVuY2UgZnJvbSBVU0IgMy4wIHRoYXQncyB0
aGUNCj4gcmVhbCBjYXVzZSBvZiBteSBwcm9ibGVtcy4NCg0KSSB0aGluayB5b3UgaGF2ZSBzb3J0
ZWQgdGhlIHByb2JsZW0gdGhhdCBVU0IgMy4wIGlzIHRoZSBpbnRlcmZlcmVuY2Ugc291cmNlLg0K
U2luY2UgdGhlIGNsb2NrIG9mIFVTQiAzLjAgaXMgMi41Rywgc28gcGxlYXNlIHRyeSB0byBjb25u
ZWN0IGEgNUcgQVAgdG8gc2VlIGlmIHRoZSANCnByb2JsZW0gaXMgc3RpbGwgZXhpc3RpbmcuDQoN
Cj4gDQo+IEkgYWxzbyBzZWUgdGhpcyBtYWlsIG9uIGEgcHJldmlvdXMgdmVyc2lvbiBvZiB0aGUg
cGF0Y2ggWzFdOg0KPiANCj4gPiBBcyBtZW50aW9uZWQgaW4gY29tbWl0IG1lc3NhZ2UsIHRoZSBk
ZWJ1Z2ZzIGlzIGV4cGVjdGVkIHRvIGJlIHVzZWQgd2hlbiBkZWJ1Z2dpbmcNCj4gPiBpbiBub2lz
eSBlbnZpcm9ubWVudC4gSW4gdGhhdCBjYXNlLCB3ZSB0aGluayBhbGwgcnR3ODggZGV2aWNlcyB3
aWxsIHByb2JhYmx5DQo+ID4gYmUgYWZmZWN0ZWQuIEJlc2lkZXMsIHdlIGJlbGlldmUgdGhhdCB0
dXJuaW5nIEVEQ0NBIG9mZiBpcyBhIHRlbXBvcmFyeSBzdGF0ZSB1bmRlcg0KPiA+IGRlYnVnZ2lu
Zy4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy82
MWEyNDJjMTg2YmY0NTNkODA4MjBkODFlMWM0ODQ2NEByZWFsdGVrLmNvbS8NCj4gDQo+IFNvIEkn
bSBub3Qgc3VyZSB3aGF0IHRvIHRoaW5rIGFuZCB3YW50ZWQgdG8gYXNrIGhlcmUuIElzIEVEQ0NB
DQo+IHdvcmtpbmctYXMtaW50ZW5kZWQgaW4gbXkgY2FzZSwgbWVhbmluZyBJIHNob3VsZCBmaXgg
bXkgIm5vaXN5DQo+IGVudmlyb25tZW50Ij8gT3IgaXMgc29tZXRoaW5nIHdyb25nIHdpdGggdGhl
IGltcGxlbWVudGF0aW9uIHRoYXQgc2hvdWxkDQo+IGJlIGRlYnVnZ2VkPyBJIHRoaW5rIGl0J2xs
IGJlIHZlcnkgZWFzeSBmb3Igb3RoZXIgcGVvcGxlIHRvIHJ1biBpbnRvDQo+IHRoaXMgaXNzdWUs
IG1heWJlIGl0IHNob3VsZCBiZSBkaXNhYmxlZCBieSBkZWZhdWx0LCBvciB0dXJuZWQgaW50byBh
DQo+IG1vZHVsZSBvcHRpb24/DQoNClRoZSBhZGFwdGl2aXR5IHBhdGNoIGlzIHRvIGRldGVjdCBz
aWduYWwgZW5lcmd5IGFuZCBzdG9wIHRvIHRyYW5zbWl0IGlmIHRoZSANCmVuZXJneSBpcyBvdmVy
IGEgdGhyZXNob2xkLCBhbmQgSSB0aGluayB0aGUgVVNCIDMuMCBpbnRlcmZlcmVuY2UgZG9lcy4N
Ckkgd2lsbCBkaXNjdXNzIGludGVybmFsbHkgaG93IHdlIGNhbiBkZWJ1ZyB0aGlzIHN5bXB0b20u
DQoNCi0tDQpQaW5nLUtlDQoNCg==
