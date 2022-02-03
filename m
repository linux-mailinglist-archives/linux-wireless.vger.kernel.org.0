Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC1D4A8012
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiBCIAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:00:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39178 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiBCIAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:00:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2137xmPbB023775, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2137xmPbB023775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 3 Feb 2022 15:59:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 15:59:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 15:59:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Thu, 3 Feb 2022 15:59:47 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        Bernie Huang <phhuang@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] rtw88: fix use after free in rtw_hw_scan_update_probe_req()
Thread-Topic: [PATCH] rtw88: fix use after free in
 rtw_hw_scan_update_probe_req()
Thread-Index: AQHYGDWWsvp5/lccGkWu17B1jQ92bayA8XYA
Date:   Thu, 3 Feb 2022 07:59:47 +0000
Message-ID: <2bf144b4f5782c7909f783a0c5deb15e6186f032.camel@realtek.com>
References: <20220202130510.GA27283@kili>
In-Reply-To: <20220202130510.GA27283@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [101.137.137.211]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMyDkuIrljYggMDY6MDA6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <00D33AB42E172D4990992D0B64A2294D@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTAyLTAyIGF0IDE2OjA1ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGlzIGNvZGUgbmVlZHMgdG8gdXNlIHNrYl9xdWV1ZV93YWxrX3NhZmUoKSBpbnN0ZWFkIG9m
IHNrYl9xdWV1ZV93YWxrKCkNCj4gYmVjYXVzZSBpdCBmcmVlcyB0aGUgbGlzdCBpdGVyYXRvci4N
Cj4gDQo+IEZpeGVzOiBkOTU5ODRiNTU4MGQgKCJydHc4ODogZml4IG1lbW9yeSBvdmVycnVuIGFu
ZCBtZW1vcnkgbGVhayBkdXJpbmcgaHdfc2NhbiIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2Z3LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9mdy5jDQo+IGluZGV4IGNlOTUzNWNjZTcyMy4uMmRlMGJiNjdiYWM2IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2Z3LmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+IEBAIC0xODY0
LDcgKzE4NjQsNyBAQCBzdGF0aWMgaW50IHJ0d19od19zY2FuX3VwZGF0ZV9wcm9iZV9yZXEoc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gIHsNCj4gIAlzdHJ1Y3QgY2ZnODAyMTFfc2Nhbl9yZXF1
ZXN0ICpyZXEgPSBydHd2aWYtPnNjYW5fcmVxOw0KPiAgCXN0cnVjdCBza19idWZmX2hlYWQgbGlz
dDsNCj4gLQlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiArCXN0cnVjdCBza19idWZmICpza2IsICp0
bXA7DQo+ICAJdTggbnVtID0gcmVxLT5uX3NzaWRzLCBpLCBiYW5kcyA9IDA7DQo+ICAJaW50IHJl
dDsNCj4gIA0KPiBAQCAtMTg4OSw3ICsxODg5LDcgQEAgc3RhdGljIGludCBydHdfaHdfc2Nhbl91
cGRhdGVfcHJvYmVfcmVxKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsDQo+ICAJcmV0dXJuIF9ydHdf
aHdfc2Nhbl91cGRhdGVfcHJvYmVfcmVxKHJ0d2RldiwgbnVtICogYmFuZHMsICZsaXN0KTsNCj4g
IA0KPiAgb3V0Og0KPiAtCXNrYl9xdWV1ZV93YWxrKCZsaXN0LCBza2IpDQo+ICsJc2tiX3F1ZXVl
X3dhbGtfc2FmZSgmbGlzdCwgc2tiLCB0bXApDQo+ICAJCWtmcmVlX3NrYihza2IpOw0KPiAgDQo+
ICAJcmV0dXJuIHJldDsNCg0KDQpPb3BzLCB3aGVuIEkgcmVpdmV3ZWQgdGhlIHBhdGNoICJydHc4
ODogZml4IG1lbW9yeSBvdmVycnVuIGFuZCBtZW1vcnkgbGVhayBkdXJpbmcgaHdfc2NhbiIsIA0K
SSBkaWQgb25seSBmb2N1cyBvbiBwb2ludGVycyBvZiBsaXN0IGhlYWQsIGJ1dCBmb3JnZXQgc2ti
IGlzIGZyZWVkIHRoYXQgbGVhZHMgdXNlIGFmdGVyIGZyZWUuDQoNCkNvdWxkIEkgaGF2ZSByZWxh
dGVkIGZpeCB3aXRoIHRoaXMgcGF0Y2g/DQoNCg0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9mdy5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L2Z3LmMNCkBAIC0xODUzLDcgKzE4NTMsNyBAQCBzdGF0aWMgaW50IF9ydHdfaHdfc2Nhbl91
cGRhdGVfcHJvYmVfcmVxKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHU4DQpudW1fcHJvYmVzLA0K
ICAgICAgICBydHdkZXYtPnNjYW5faW5mby5wcm9iZV9wZ19zaXplID0gcGFnZV9vZmZzZXQ7DQog
b3V0Og0KICAgICAgICBrZnJlZShidWYpOw0KLSAgICAgICBza2JfcXVldWVfd2Fsayhwcm9iZV9y
ZXFfbGlzdCwgc2tiKQ0KKyAgICAgICBza2JfcXVldWVfd2Fsa19zYWZlKHByb2JlX3JlcV9saXN0
LCBza2IsIHRtcCkNCiAgICAgICAgICAgICAgICBrZnJlZV9za2Ioc2tiKTsNCiANCiAgICAgICAg
cmV0dXJuIHJldDsNCg0KLS0NClBpbmctS2UNCg0KDQo=
