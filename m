Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56D3B1B91
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWNxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 09:53:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35045 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhFWNxV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 09:53:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15NDoweI7009961, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15NDoweI7009961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Jun 2021 21:50:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 23 Jun 2021 21:50:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 23 Jun 2021 21:50:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Wed, 23 Jun 2021 21:50:56 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA is connected HE
Thread-Topic: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA
 is connected HE
Thread-Index: AQHXXm6ItuGkMH9RLkaoOlE6YAkORKsOIMzwgBNZNwWAACI2oP//gCiAgACOqlA=
Date:   Wed, 23 Jun 2021 13:50:56 +0000
Message-ID: <3a473fc87d144750acb765c5e7de2cd8@realtek.com>
References: <20210611030422.9608-1-pkshih@realtek.com>
         <072bfd8473ac4054a43818009e66a914@realtek.com>
         (sfid-20210611_052347_394259_CA96FBDB)
 <05835527eb79d7bad22b20247b351b82cc0776d3.camel@sipsolutions.net>
         <8f1524261420449d87b86e9067f3d74f@realtek.com>
 <a2342a38a7fca26e0906057461f042981a94dad9.camel@sipsolutions.net>
In-Reply-To: <a2342a38a7fca26e0906057461f042981a94dad9.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMjMg5LiL5Y2IIDEyOjA2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/23/2021 13:24:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164583 [Jun 23 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;patchwork.kernel.org:7.1.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/23/2021 13:27:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgW21h
aWx0bzpqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0XQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUg
MjMsIDIwMjEgOTowMCBQTQ0KPiBUbzogUGtzaGloDQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbWFjODAyMTE6IEZpeCBzdyBjb25u
ZWN0aW9uIG1vbml0b3IgYW5kIHN3IHNjYW4gd2hlbiBTVEEgaXMgY29ubmVjdGVkIEhFDQo+IA0K
PiBPbiBXZWQsIDIwMjEtMDYtMjMgYXQgMTI6NDkgKzAwMDAsIFBrc2hpaCB3cm90ZToNCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKb2hhbm5lcyBCZXJnIFtt
YWlsdG86am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldF0NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwg
SnVuZSAyMywgMjAyMSA2OjMzIFBNDQo+ID4gPiBUbzogUGtzaGloDQo+ID4gPiBDYzogbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtYWM4
MDIxMTogRml4IHN3IGNvbm5lY3Rpb24gbW9uaXRvciBhbmQgc3cgc2Nhbg0KPiA+ID4gd2hlbiBT
VEEgaXMgY29ubmVjdGVkIEhFDQo+ID4gPg0KPiA+ID4gPiBIaSBtYWM4MDIxMSB0ZWFtLA0KPiA+
ID4gPg0KPiA+ID4gPiBXZSBhcmUgd29ya2luZyBvbiBSZWFsdGVrIDExYXggZHJpdmVyLCBydHc4
OSwgbm90IGJlaW5nIG1lcmdlZA0KPiA+ID4gPiB5ZXQuDQo+ID4gPiA+IFRoaXMgZHJpdmVyIHVz
ZXMgc29mdHdhcmUgY29ubmVjdGlvbiBtb25pdG9yIGFuZCBzb2Z0d2FyZSBzY2FuLA0KPiA+ID4g
PiBsaWtlDQo+ID4gPiA+IG91ciAxMWFjIGRyaXZlciBydHc4OCwNCj4gPiA+ID4gYnV0IHdlIGZv
dW5kIHRoZXNlIHR3byBmdW5jdGlvbnMgZG9uJ3Qgd29yayBwcm9wZXJseSBkdWUgdG8NCj4gPiA+
ID4gbWFjODAyMTENCj4gPiA+ID4gZG9lc24ndCBzZW5kDQo+ID4gPiA+IG51bGwgZGF0YSBmcmFt
ZSB3aGVuIFNUQSBpcyBjb25uZWN0ZWQgSEUuDQo+ID4gPiA+DQo+ID4gPiA+IFdlIHNlYXJjaCBm
b3IgdGhlIHJlYXNvbiB3aHkgaXQgY2FuJ3Qgc2VuZCBudWxsIGZyYW1lLCBidXQgd2UNCj4gPiA+
ID4gZG9uJ3QNCj4gPiA+ID4gZ2V0IHRoZSBhbnN3ZXIuDQo+ID4gPiA+IFBvc3NpYmx5LCBpdCBp
cyBiZWNhdXNlIGV4aXN0aW5nIEhFIGhhcmR3YXJlIHN1cHBvcnRzIGhhcmR3YXJlDQo+ID4gPiA+
IGNvbm5lY3Rpb24gbW9uaXRvcg0KPiA+ID4gPiBhbmQgc2Nhbiwgb3Igc3VwcG9ydHMgVFdUIHRv
IGF2b2lkIHNlbmRpbmcgbnVsbCBkYXRhIGZyYW1lIHRvIHRlbGwNCj4gPiA+ID4gQVANCj4gPiA+
ID4gaXRzIFBTIG1vZGUuDQo+ID4gPiA+IENvdWxkIGFueW9uZSBlbmxpZ2h0ZW4gbWUgdGhlIHJl
YXNvbj8NCj4gPiA+DQo+ID4gPiBJdCB3YXMganVzdCBhIHdvcmthcm91bmQgZm9yIGFuIGl3bHdp
Zmkgc3BlY2lmaWMgaXNzdWUgdGhhdCBnb3QgbGVmdA0KPiA+ID4gaW4uDQo+ID4gPiBJIGp1c3Qg
bWVyZ2VkIGEgcGF0Y2ggZnJvbSBGZWxpeCB0byByZXNvbHZlIHRoYXQuDQo+ID4gPg0KPiA+DQo+
ID4gSSBjaGVjayBGZWxpeCdzIHBhdGNoOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIxMDYxOTEwMTUxNy45MDgwNi0xLW5i
ZEBuYmQubmFtZS8NCj4gPg0KPiA+DQo+ID4gSSB0aGluayB3ZSBzaG91bGQgcmV2ZXJ0IHRoZSBj
b21taXQgZjM5YjA3ZmRmYjY4ICgibWFjODAyMTE6IEhFIFNUQQ0KPiA+IGRpc2Fzc29jIGR1ZSB0
byBRT1MgTlVMTCBub3Qgc2VudCIpLA0KPiA+IHdoaWNoIGZpeGVzIGNvbm5lY3Rpb24gbW9uaXRv
ciBkdWUgdG8gUU9TIE5VTEwgbm90IHNlbmQuDQo+ID4NCj4gDQo+IEkgYWdyZWUsIHRoYXQgbWFr
ZXMgc2Vuc2UuDQo+IA0KPiA+DQo+ID4gQW5vdGhlciBwbGFjZSBpcyBpZWVlODAyMTFfc2VuZF9u
dWxsX3Jlc3BvbnNlKCk7IEknbSBub3Qgc3VyZSBpZiB3ZQ0KPiA+IGNhbiByZW1vdmUNCj4gPiB0
aGUgY2hlY2tpbmcgYXMgd2VsbC4NCj4gDQo+IFllcywgSSB0aGluayBzby4NCj4gDQo+IFdhbnQg
dG8gc2VuZCBwYXRjaChlcykgZm9yIHRoYXQ/DQo+IA0KDQpTdXJlLg0KDQpUd28gcGF0Y2hlcyBh
cmUgc2VudDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjEwNjIz
MTM0ODI2LjEwMzE4LTEtcGtzaGloQHJlYWx0ZWsuY29tL1QvI3QNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjEwNjIzMTM0ODI2LjEwMzE4LTItcGtzaGloQHJlYWx0
ZWsuY29tL1QvI3UNCg0KLS0NClBpbmctS2UNCg0K
