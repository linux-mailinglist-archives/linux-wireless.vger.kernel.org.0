Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708704A5731
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 07:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiBAG0q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 01:26:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51433 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiBAG0o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 01:26:44 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2116QaPdA008678, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2116QaPdA008678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 1 Feb 2022 14:26:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Feb 2022 14:26:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 22:26:36 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Tue, 1 Feb 2022 14:26:36 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Funny log entries for rtw88_8821ce
Thread-Topic: Funny log entries for rtw88_8821ce
Thread-Index: AQHYFvVq2DWVmxZS7E2VYxG/u8dgWqx9tPKA
Date:   Tue, 1 Feb 2022 06:26:35 +0000
Message-ID: <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
References: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
In-Reply-To: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [111.252.224.243]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMSDkuIrljYggMDQ6MTk6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0FEC3F11816194D81A889D408D7676F@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIE1vbiwgMjAyMi0wMS0zMSBhdCAxNjo1MyAtMDYwMCwgTGFycnkgRmluZ2VyIHdy
b3RlOg0KPiBQaW5nLUtlIGFuZCBsaXN0LA0KPiANCj4gV2l0aGluIHRoZSBsYXN0IGNvdXBsZSBv
ZiBkYXlzLCBJIHdhcyB0ZXN0aW5nIHJ0dzg4IHdpdGggYW4gcnRsODgyMWNlIGNhcmQuIEkgDQo+
IG5vdGljZWQgdGhhdCB3aGVuZXZlciB0aGUgZGV2aWNlIGlzIG5vdCBjb25uZWN0ZWQgdG8gYW4g
QVAsIHRoZSBsb2cgaXMgZmxvb2RlZCANCj4gd2l0aCBtZXNzYWdlcyBsaWtlIHRoZSBmb2xsb3dp
bmc6DQo+IFsxMzA0NjIuNjAzNTM5XSBydHdfODgyMWNlIDAwMDA6MDI6MDAuMDogc3RvcCB2aWYg
ZWU6YTQ6OTU6NGU6NTM6OGIgb24gcG9ydCAwDQo+IFsxMzA0NjMuMTE2ODQzXSBydHdfODgyMWNl
IDAwMDA6MDI6MDAuMDogc3RhcnQgdmlmIGFhOmZjOjE5OjY2OjVlOmUyIG9uIHBvcnQgMA0KPiBb
MTMwODc0LjYxMzQzMF0gcnR3Xzg4MjFjZSAwMDAwOjAyOjAwLjA6IHN0b3AgdmlmIGFhOmZjOjE5
OjY2OjVlOmUyIG9uIHBvcnQgMA0KPiBbMTMwODc1LjEyMjY0MV0gcnR3Xzg4MjFjZSAwMDAwOjAy
OjAwLjA6IHN0YXJ0IHZpZiBkMjplNjoyMzpiYTo5ODo3NiBvbiBwb3J0IDANCj4gWzEzMTI4Ni42
Nzc4MjhdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiBzdG9wIHZpZiBkMjplNjoyMzpiYTo5ODo3
NiBvbiBwb3J0IDANCj4gWzEzMTI4Ny4xOTIxMDhdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiBz
dGFydCB2aWYgODI6YzQ6MzM6OTY6MmU6YzYgb24gcG9ydCAwXA0KDQpJIHR1cm4gb2ZmIFVJIG5l
dHdvcmstbWFuYWdlciwgYW5kIGl0IGNhbiBzaG93IHRoZSBzYW1lIG1lc3NhZ2VzIGlmIEkgdXNl
DQonaWZjb25maWcnIHRvIHVwIGFuZCBkb3duIHRoZSBpbnRlcmZhY2VzLiBJIHRoaW5rIGFkZF9p
bnRlcmZhY2UoKS9yZW1vdmVfaW50ZXJmYWNlKCkNCmFyZSBjYWxsZWQgYnkgaWVlZTgwMjExX2Rv
X29wZW4oKS9pZWVlODAyMTFfZG9fc3RvcCgpIGluIG15IHRlc3QgY2FzZXMuDQoNClBsZWFzZSBj
aGVjayBpZiB5b3VyIG5ldHdvcmstbWFuYWdlciBkb2VzIHRoZSB0aGluZ3MuIElmIHNvLCBjaGVj
ayBzeXNsb2cgdG8NCmtub3cgd2h5IGl0IGRvZXMuDQoNCj4gDQo+IEFmdGVyIH40MTEgc2Vjcywg
dGhlIGNhbGxiYWNrIHJvdXRpbmUgZm9yIHJlbW92ZV9pbnRlcmZhY2UoKSBpbiBzdHJ1Y3QgDQo+
IGllZWU4MDIxMV9vcHMgaXMgY2FsbGVkLiBBZnRlciA8MSBzZWMsIHRoZSBhZGRfaW50ZXJmYWNl
KCkgY2FsbGJhY2sgaXMgY2FsbGVkIHRvIA0KPiByZXN0YXJ0IHRoZSB2aWYuIElzIHRoaXMgbm9y
bWFsIGJlaGF2aW9yIGFuZCBJIHNlZSBpdCBpbiB0aGUgbG9ncyBiZWNhdXNlIHRoaXMgDQo+IGRy
aXZlciBpcyB0aGUgb25seSBvbmUgdGhhdCBsb2dzIHRoZSBzdGFydC9zdG9wIGNhbGxzLCBvciBp
cyBzb21ldGhpbmcgZWxzZSANCj4gZ29pbmcgb24/IEl0IHdvdWxkIGJlIGVhc3kgdG8gZGlzYWJs
ZSB0aG9zZSBsb2cgZW50cmllcywgYnV0IEkgd291bGQgbGlrZSB0byANCj4ga25vdyBpZiB0aGVy
ZSBpcyBzb21lIG90aGVyIGNvbmRpdGlvbj8NCj4gDQo+IE9uIG15IGtlcm5lbCwgSFogaXMgMjUw
LCB0aHVzIHRoZSBpbnRlcnZhbCBpcyByb3VnaGx5IDEwMywwMDAgamlmZmllcy4NCj4gDQoNClBp
bmctS2UNCg0K
