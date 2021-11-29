Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CF46109C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 09:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbhK2I6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 03:58:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55842 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhK2I4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 03:56:32 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AT8r0ecD007931, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AT8r0ecD007931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 16:53:00 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 16:53:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 29 Nov 2021 16:53:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa]) by
 RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa%5]) with mapi id
 15.01.2308.015; Mon, 29 Nov 2021 16:52:59 +0800
From:   Pkshih <pkshih@realtek.com>
To:     James <bjlockie@lockie.ca>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: USB for rtw89 driver?
Thread-Topic: USB for rtw89 driver?
Thread-Index: AQHX4+EwwlDJUs75Nkep6VfI/8z1mawZ+Xkw
Date:   Mon, 29 Nov 2021 08:52:59 +0000
Message-ID: <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
In-Reply-To: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzI5IOS4iuWNiCAwNjoxMjowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbWVzIDxiamxvY2tpZUBs
b2NraWUuY2E+DQo+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgMjgsIDIwMjEgNjoyMyBBTQ0KPiBU
bzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFVTQiBmb3IgcnR3
ODkgZHJpdmVyPw0KPiANCj4gQXJlIHRoZXJlIGFueSBwbGFucyB0byBzdXBwb3J0IHRoZSBVU0Ig
aW50ZXJmYWNlIHdpdGggdGhpcyBkcml2ZXI/DQo+IFNwZWNpZmljYWxseSBmb3IgdGhlIERMaW5r
IERXQS1YMTg1MCBhbmQgb3RoZXIgd2lmaTYgVVNCIGRldmljZXMgYmFzZWQNCj4gb24gdGhpcyBj
aGlwc2V0Pw0KDQpUaGUgYXJjaGl0ZWN0dXJlIG9mIHJ0dzg5IGNhbiBzdXBwb3J0IFVTQiBpbnRl
cmZhY2UsIGJ1dCB3ZSBkb24ndCBoYXZlIGENCmNsZWFyIHBsYW4geWV0Lg0KDQpUaGUgRFdBLVgx
ODUwIGlzIGEgV2luZG93cyBzcGVjaWZpYyBkb25nbGUsIGJlY2F1c2UgaXQgcnVucyBpbiBhIHNw
ZWNpYWwNCm1vZGUgdGhhdCB1c2VyIGNhbiBpbnN0YWxsIGRyaXZlciBmcm9tIGl0c2VsZiB3aXRo
b3V0IGRvd25sb2FkaW5nIGRyaXZlcg0KZnJvbSBpbnRlcm5ldC4NCg0KPiANCj4gQWxzbywNCj4g
RG9lcyBhbnlvbmUga25vdyBpZiB0aGUgcHJvcHJpZXRhcnkgZHJpdmVyIHdvcmtzIG9uIHRoZSBS
YXNwYmVycnkgUGk0Qg0KPiAoQXJtKT8NCg0KRG9uJ3QgaGF2ZSBhIHByb3ByaWV0YXJ5IGRyaXZl
ciBuZWl0aGVyLg0KDQotLQ0KUGluZy1LZQ0KDQo=
