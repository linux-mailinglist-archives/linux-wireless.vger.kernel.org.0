Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2346448A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 02:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbhLABhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 20:37:15 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43176 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhLABhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 20:37:06 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B11Xc7S2019570, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B11Xc7S2019570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Dec 2021 09:33:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 09:33:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 30 Nov 2021 20:33:37 -0500
Received: from RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa]) by
 RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa%5]) with mapi id
 15.01.2308.015; Wed, 1 Dec 2021 09:33:37 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Jeff Clay <jeffclay@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Latency spikes in rtw89
Thread-Topic: Latency spikes in rtw89
Thread-Index: AQHX5h7gz1lunSxdRkC17cf5rz61Cqwc15RA
Date:   Wed, 1 Dec 2021 01:33:37 +0000
Message-ID: <74887ec8f49846f5ae8b40b4c213d2da@realtek.com>
References: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
In-Reply-To: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzMwIOS4i+WNiCAxMToxNjowMA==?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplZmYgQ2xheSA8amVmZmNs
YXlAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDEsIDIwMjEgMzoxNiBB
TQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IExhdGVu
Y3kgc3Bpa2VzIGluIHJ0dzg5DQo+IA0KPiBIaSwgSSBhbSB1c2luZyB0aGUgcnR3ODkgZHJpdmVy
IGZvciBSZWFsdGVrIDg4NTJBRSBpbiBteSBMZW5vdm8gVDE0DQo+IEFNRCBHZW4yLiBJIGhhdmUg
b2J0YWluZWQgYW5kIGluc3RhbGxlZCB0aGlzIGRyaXZlciBmcm9tIHNvdXJjZSBhdA0KPiBodHRw
czovL2dpdGh1Yi5jb20vbHdmaW5nZXIvcnR3ODkvdHJlZS9tYWluIEkgYW0gaGF2aW5nIGFuIGlz
c3VlIHdoZXJlDQo+IHRoZSBsYXRlbmN5IGR1cmluZyBhIHBpbmcgdGVzdCB0byBob3N0cyBvbiBt
eSBMQU4gc3Bpa2VzIHRvIDIwMG1zIG9yDQo+IGFib3ZlLiBBY2NvcmRpbmcgdG8gbHdmaW5nZXIs
IHRoaXMgaXMga25vd24gYW5kIGFjY2VwdGFibGUNCj4gaHR0cHM6Ly9naXRodWIuY29tL2x3Zmlu
Z2VyL3J0dzg5L2lzc3Vlcy84NSAgSG93ZXZlciwgSSBhbSBob3BpbmcgSQ0KPiBtYXkgYmUgYWJs
ZSB0byB3b3JrIHdpdGggeW91IHRvIHJlc29sdmUgdGhpcyBpc3N1ZSBhcyBhIHRlc3Rlci4NCg0K
V2Uga25vdyB0aGlzLCBhbmQgaXQgaXMgZHVlIHRvIHBvd2VyIHNhdmluZzsgaS5lLiB0cmFkZW9m
ZiBiZXR3ZWVuDQpsYXRlbmN5IGFuZCBwb3dlciBzYXZpbmcuIFdlIGFyZSB0aGlua2luZyBob3cg
dG8gaW1wcm92ZSBpdCBlbnRpcmVseS4NCg0KLS0NClBpbmctS2UNCg0K
