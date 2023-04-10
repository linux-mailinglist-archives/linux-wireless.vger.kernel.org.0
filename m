Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EFB6DC228
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 02:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDJAUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Apr 2023 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJAUm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Apr 2023 20:20:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451330F9
        for <linux-wireless@vger.kernel.org>; Sun,  9 Apr 2023 17:20:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33A0KGuyC007162, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33A0KGuyC007162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 10 Apr 2023 08:20:16 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 08:20:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 10 Apr 2023 08:20:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 10 Apr 2023 08:20:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Thread-Index: AQHZZA3VOb/3C7mk9kGPYLUdN/MokK8df2cQgAUMeYCAAS/x4A==
Date:   Mon, 10 Apr 2023 00:20:36 +0000
Message-ID: <e97ea73d95ef4a7eb56cebd433746d86@realtek.com>
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
 <04d4ca3e27924ea6b2ad6e5b00ddb424@realtek.com>
 <541f26bb-5022-2c2d-200a-68dc2c6fb5fe@gmail.com>
In-Reply-To: <541f26bb-5022-2c2d-200a-68dc2c6fb5fe@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzQvOSDkuIvljYggMTA6MDA6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgQXByaWwgOSwgMjAy
MyAxMDoxMSBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVu
c2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHdpZmk6IHJ0bDh4eHh1
OiBDbGVhbiB1cCBzb21lIG1lc3N5IGlmcw0KPiANCj4gT24gMDYvMDQvMjAyMyAwNDoxNiwgUGlu
Zy1LZSBTaGloIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+
DQo+ID4+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxLCAyMDIzIDQ6MTcgQU0NCj4gPj4gVG86IGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzogSmVzIFNvcmVuc2VuIDxKZXMu
U29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+
ID4+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIHdpZmk6IHJ0bDh4eHh1OiBDbGVhbiB1cCBzb21lIG1l
c3N5IGlmcw0KPiA+Pg0KPiA+PiBBZGQgc29tZSBuZXcgbWVtYmVycyB0byBydGw4eHh4dV9maWxl
b3BzIGFuZCB1c2UgdGhlbSBpbnN0ZWFkIG9mDQo+ID4+IGNoZWNraW5nIHByaXYtPnJ0bF9jaGlw
Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCj4gPj4gLS0tDQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2Nv
cmUuYw0KPiA+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4
eHVfY29yZS5jDQo+ID4+IGluZGV4IGMxNTJiMjI4NjA2Zi4uNjJkZDUzYTU3NjU5IDEwMDY0NA0K
PiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1
X2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiA+PiBAQCAtMTkxNiw3ICsxOTE2LDcgQEAgc3RhdGljIGludCBy
dGw4eHh4dV9zdGFydF9maXJtd2FyZShzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gPj4g
ICAgICAgICAvKg0KPiA+PiAgICAgICAgICAqIEluaXQgSDJDIGNvbW1hbmQNCj4gPj4gICAgICAg
ICAgKi8NCj4gPj4gLSAgICAgICBpZiAocHJpdi0+cnRsX2NoaXAgPT0gUlRMODcyM0IgfHwgcHJp
di0+cnRsX2NoaXAgPT0gUlRMODE4OEYgfHwgcHJpdi0+cnRsX2NoaXAgPT0gUlRMODcxMEIpDQo+
ID4+ICsgICAgICAgaWYgKHByaXYtPmZvcHMtPmluaXRfcmVnX2htdGZyKQ0KPiA+PiAgICAgICAg
ICAgICAgICAgcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19ITVRGUiwgMHgwZik7DQo+ID4+ICBl
eGl0Og0KPiA+PiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+IEBAIC0zODY0LDExICszODY0LDgg
QEAgdm9pZCBydGw4eHh4dV9pbml0X2J1cnN0KHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2KQ0K
PiA+PiAgICAgICAgIHJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfSFRfU0lOR0xFX0FNUERVXzg3
MjNCLCB2YWw4KTsNCj4gPj4NCj4gPj4gICAgICAgICBydGw4eHh4dV93cml0ZTE2KHByaXYsIFJF
R19NQVhfQUdHUl9OVU0sIDB4MGMxNCk7DQo+ID4+IC0gICAgICAgaWYgKHByaXYtPnJ0bF9jaGlw
ID09IFJUTDg3MjNCIHx8IHByaXYtPnJ0bF9jaGlwID09IFJUTDg3MTBCKQ0KPiA+PiAtICAgICAg
ICAgICAgICAgdmFsOCA9IDB4NWU7DQo+ID4+IC0gICAgICAgZWxzZSBpZiAocHJpdi0+cnRsX2No
aXAgPT0gUlRMODE4OEYpDQo+ID4+IC0gICAgICAgICAgICAgICB2YWw4ID0gMHg3MDsgLyogMHg1
ZSB3b3VsZCBtYWtlIGl0IHZlcnkgc2xvdyAqLw0KPiA+PiAtICAgICAgIHJ0bDh4eHh1X3dyaXRl
OChwcml2LCBSRUdfQU1QRFVfTUFYX1RJTUVfODcyM0IsIHZhbDgpOw0KPiA+PiArICAgICAgIHJ0
bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfQU1QRFVfTUFYX1RJTUVfODcyM0IsDQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHByaXYtPmZvcHMtPmFtcGR1X21heF90aW1lKTsNCj4gPg0KPiA+
IFNob3VsZCBpdCBiZQ0KPiA+DQo+ID4gaWYgKHByaXYtPmZvcHMtPmFtcGR1X21heF90aW1lKQ0K
PiA+ICAgICB2YWw4ID0gcHJpdi0+Zm9wcy0+YW1wZHVfbWF4X3RpbWU7Pg0KPiA+IHJ0bDh4eHh1
X3dyaXRlOChwcml2LCBSRUdfQU1QRFVfTUFYX1RJTUVfODcyM0IsIHZhbDgpOyAvLyB0aGlzIGxp
bmUgZG9lc24ndCBjaGFuZ2U/DQo+ID4NCj4gPiBCZWNhdXNlIG9yaWdpbmFsbHkgdmFsOCBpcyBy
ZWFkIGZyb20gUkVHX0hUX1NJTkdMRV9BTVBEVV84NzIzQiBhbmQgYWRkDQo+ID4gSFRfU0lOR0xF
X0FNUERVX0VOQUJMRSBiaXQuDQo+IA0KPiBObywgdGhlIHZhbHVlIHJlYWQgZnJvbSBSRUdfSFRf
U0lOR0xFX0FNUERVXzg3MjNCIGlzIG5vdCBzdXBwb3NlZCB0byBiZQ0KPiB3cml0dGVuIHRvIFJF
R19BTVBEVV9NQVhfVElNRV84NzIzQi4gQW5kIGl0IG5ldmVyIHdhcywgYmVjYXVzZSBvbmx5DQo+
IFJUTDg3MjNCLCBSVEw4NzEwQiwgYW5kIFJUTDgxODhGIHVzZSB0aGlzIGZ1bmN0aW9uLiBUaGlz
IHdhcyBjbGVhcmVyIGluDQo+IHRoZSBvcmlnaW5hbCB2ZXJzaW9uIG9mIHRoZSBjb2RlLCB3aGVu
IGl0IHdhcyB1c2VkIG9ubHkgYnkgUlRMODcyM0I6DQo+IA0KPiAgICAgICAgICAgICAgICAgdmFs
OCA9IHJ0bDh4eHh1X3JlYWQ4KHByaXYsIFJFR19IVF9TSU5HTEVfQU1QRFVfODcyM0IpOw0KPiAg
ICAgICAgICAgICAgICAgdmFsOCB8PSBCSVQoNyk7DQo+ICAgICAgICAgICAgICAgICBydGw4eHh4
dV93cml0ZTgocHJpdiwgUkVHX0hUX1NJTkdMRV9BTVBEVV84NzIzQiwgdmFsOCk7DQo+IA0KPiAg
ICAgICAgICAgICAgICAgcnRsOHh4eHVfd3JpdGUxNihwcml2LCBSRUdfTUFYX0FHR1JfTlVNLCAw
eDBjMTQpOw0KPiAgICAgICAgICAgICAgICAgcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19BTVBE
VV9NQVhfVElNRV84NzIzQiwgMHg1ZSk7DQo+IA0KDQpPb3BzLiBTb21laG93IEkgbWlzdW5kZXJz
dG9vZCB0aGUgY29kZS4gU29ycnkgZm9yIHRoZSBub2lzZS4NCg0KDQoNCg==
