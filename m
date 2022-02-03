Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D24A8179
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiBCJ3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 04:29:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45007 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiBCJ3h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 04:29:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2139TLi84003393, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2139TLi84003393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 3 Feb 2022 17:29:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 17:29:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 17:29:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Thu, 3 Feb 2022 17:29:21 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        Bernie Huang <phhuang@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] rtw88: fix use after free in rtw_hw_scan_update_probe_req()
Thread-Topic: [PATCH v2] rtw88: fix use after free in
 rtw_hw_scan_update_probe_req()
Thread-Index: AQHYGNesRVy32sMtk0aaFWmiiJyrgqyBCTgA
Date:   Thu, 3 Feb 2022 09:29:20 +0000
Message-ID: <779ff6e7a852a1aed4f65ba1fbe921917904e944.camel@realtek.com>
References: <20220203082532.GA25151@kili>
In-Reply-To: <20220203082532.GA25151@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [101.137.137.211]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMyDkuIrljYggMDc6NTQ6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <D75C4A60E34C7B4994DD22C3CC6E08EB@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTAzIGF0IDExOjI1ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGlzIGNvZGUgbmVlZHMgdG8gdXNlIHNrYl9xdWV1ZV93YWxrX3NhZmUoKSBpbnN0ZWFkIG9m
IHNrYl9xdWV1ZV93YWxrKCkNCj4gYmVjYXVzZSBpdCBmcmVlcyB0aGUgbGlzdCBpdGVyYXRvci4N
Cj4gDQo+IEZpeGVzOiBkOTU5ODRiNTU4MGQgKCJydHc4ODogZml4IG1lbW9yeSBvdmVycnVuIGFu
ZCBtZW1vcnkgbGVhayBkdXJpbmcgaHdfc2NhbiIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQpUaGFuayB5b3UuDQoNCj4gLS0tDQo+IHYyOiBGaXgg
YSBzaW1pbGFyIGlzc3VlIGluIF9ydHdfaHdfc2Nhbl91cGRhdGVfcHJvYmVfcmVxKCkgYXMgcG9p
bnRlZA0KPiBvdXQgYnkgUGluZy1LZSBTaGloLg0KPiANCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODgvZncuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvZncuYw0KPiBpbmRleCBjZTk1MzVjY2U3MjMuLjRjOGU1ZWE1ZDA2OSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYw0KPiBAQCAtMTg1Myw3ICsx
ODUzLDcgQEAgc3RhdGljIGludCBfcnR3X2h3X3NjYW5fdXBkYXRlX3Byb2JlX3JlcShzdHJ1Y3Qg
cnR3X2RldiAqcnR3ZGV2LCB1OA0KPiBudW1fcHJvYmVzLA0KPiAgCXJ0d2Rldi0+c2Nhbl9pbmZv
LnByb2JlX3BnX3NpemUgPSBwYWdlX29mZnNldDsNCj4gIG91dDoNCj4gIAlrZnJlZShidWYpOw0K
PiAtCXNrYl9xdWV1ZV93YWxrKHByb2JlX3JlcV9saXN0LCBza2IpDQo+ICsJc2tiX3F1ZXVlX3dh
bGtfc2FmZShwcm9iZV9yZXFfbGlzdCwgc2tiLCB0bXApDQo+ICAJCWtmcmVlX3NrYihza2IpOw0K
PiAgDQo+ICAJcmV0dXJuIHJldDsNCj4gQEAgLTE4NjQsNyArMTg2NCw3IEBAIHN0YXRpYyBpbnQg
cnR3X2h3X3NjYW5fdXBkYXRlX3Byb2JlX3JlcShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0KPiAg
ew0KPiAgCXN0cnVjdCBjZmc4MDIxMV9zY2FuX3JlcXVlc3QgKnJlcSA9IHJ0d3ZpZi0+c2Nhbl9y
ZXE7DQo+ICAJc3RydWN0IHNrX2J1ZmZfaGVhZCBsaXN0Ow0KPiAtCXN0cnVjdCBza19idWZmICpz
a2I7DQo+ICsJc3RydWN0IHNrX2J1ZmYgKnNrYiwgKnRtcDsNCj4gIAl1OCBudW0gPSByZXEtPm5f
c3NpZHMsIGksIGJhbmRzID0gMDsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+IEBAIC0xODg5LDcgKzE4
ODksNyBAQCBzdGF0aWMgaW50IHJ0d19od19zY2FuX3VwZGF0ZV9wcm9iZV9yZXEoc3RydWN0IHJ0
d19kZXYgKnJ0d2RldiwNCj4gIAlyZXR1cm4gX3J0d19od19zY2FuX3VwZGF0ZV9wcm9iZV9yZXEo
cnR3ZGV2LCBudW0gKiBiYW5kcywgJmxpc3QpOw0KPiAgDQo+ICBvdXQ6DQo+IC0Jc2tiX3F1ZXVl
X3dhbGsoJmxpc3QsIHNrYikNCj4gKwlza2JfcXVldWVfd2Fsa19zYWZlKCZsaXN0LCBza2IsIHRt
cCkNCj4gIAkJa2ZyZWVfc2tiKHNrYik7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KDQoNCg0K
