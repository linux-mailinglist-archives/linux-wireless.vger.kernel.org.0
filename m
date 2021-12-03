Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA19466F3A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 02:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhLCBtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 20:49:09 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45530 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhLCBtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 20:49:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B31jgmhF023218, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B31jgmhF023218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 3 Dec 2021 09:45:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Dec 2021 09:45:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 3 Dec 2021 09:45:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f915:ec6f:35f1:6b04]) by
 RTEXMBS04.realtek.com.tw ([fe80::f915:ec6f:35f1:6b04%5]) with mapi id
 15.01.2308.015; Fri, 3 Dec 2021 09:45:41 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Ion Cebotari <cebotari.ion.v@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek wireless 8822CE fails to work after laptop discharges in sleep
Thread-Topic: Realtek wireless 8822CE fails to work after laptop discharges in
 sleep
Thread-Index: AQHX54pLSpoZrYf4wUGNxI6NFEzub6wf/1yg
Date:   Fri, 3 Dec 2021 01:45:41 +0000
Message-ID: <780e30f72df64bb2a9cfbf6a04d02e81@realtek.com>
References: <4ac5c6f8-c5c6-dcc6-89e0-557c5dc0a27f@gmail.com>
In-Reply-To: <4ac5c6f8-c5c6-dcc6-89e0-557c5dc0a27f@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzIg5LiL5Y2IIDA0OjU5OjAw?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IElvbiBDZWJvdGFyaSA8Y2Vi
b3RhcmkuaW9uLnZAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMiwgMjAy
MSAxMDozOCBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlYWx0ZWsgd2lyZWxlc3MgODgyMkNFIGZhaWxzIHRvIHdvcmsgYWZ0ZXIgbGFwdG9wIGRp
c2NoYXJnZXMgaW4gc2xlZXANCj4gDQo+IEhlbGxvIQ0KPiANCj4gRm9sbG93aW5nIHRoZSByZWNv
bW1lbmRhdGlvbiBmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OCwgSQ0KPiBr
aW5kbHkgYXNrIHlvdSB0byBjaGVjayBvdXQgdGhlIGZvbGxvd2luZyBidWcgcmVwb3J0Og0KPiAN
Cj4gaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2J1Zy8x
OTUyNDAzDQo+IA0KPiBJZiB5b3UgZG9uJ3Qgd29yayB3aXRoIHRoZSBVYnVudHUgYnVndHJhY2tl
ciwgd2hlcmUgSSBjYW4gc3VibWl0IGEgZnVsbA0KPiBidWcgcmVwb3J0IGFib3V0IG15IHByb2Js
ZW0/DQo+IEkgY2FuIGF0dGFjaCBhbGwgdGhlIHJlcXVpcmVkIGZpbGVzIGZvciB5b3UgaGVyZSBp
biB0aGlzIGVtYWlsLCBpZg0KPiBuZWNlc3NhcnkuDQo+IA0KDQpJIG5lZWQgeW91ciBoZWxwIHRv
IGNsYXJpZnkgdGhpcyBpc3N1ZSwgc28gSSBoYXZlIHdyaXR0ZW4gc29tZXRoaW5nIG9uIHRoZSBi
dWd0cmFja2VyLg0KTGV0J3MgZGlzY3VzcyBmdXJ0aGVyIHRoZXJlLg0KDQotLQ0KUGluZy1LZQ0K
DQo=
