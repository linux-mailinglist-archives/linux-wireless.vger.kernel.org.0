Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9ED370481
	for <lists+linux-wireless@lfdr.de>; Sat,  1 May 2021 02:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEAAk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Apr 2021 20:40:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34945 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhEAAk5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Apr 2021 20:40:57 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1410e0YB1022849, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1410e0YB1022849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 1 May 2021 08:40:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 1 May 2021 08:40:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 1 May 2021 08:39:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Sat, 1 May 2021 08:39:58 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH v4 06/19] rtw89: add files to download and communicate with firmware
Thread-Topic: [PATCH v4 06/19] rtw89: add files to download and communicate
 with firmware
Thread-Index: AQHXPM4okrUJfzybP0aiHd6/JP7jw6rLu4AAgAGJzIA=
Date:   Sat, 1 May 2021 00:39:58 +0000
Message-ID: <1619829597.1798.1.camel@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
         <20210429080149.7068-7-pkshih@realtek.com> <YItZBolH5sSYZT3v@google.com>
In-Reply-To: <YItZBolH5sSYZT3v@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.246.39.126]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMzAg5LiL5Y2IIDA3OjU4OjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <477E7562A5946649BCAB1F337476A3B2@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/01/2021 00:21:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163441 [Apr 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/01/2021 00:23:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/01/2021 00:25:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163441 [Apr 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/01/2021 00:28:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTMwIGF0IDAxOjEwICswMDAwLCBCcmlhbiBOb3JyaXMgd3JvdGU6DQo+
IFNtYWxsIHJldmlldyBub3RlLCBzaW5jZSBJIHdhcyBsb29raW5nIHRocm91Z2ggdGhlIFBTIGNv
ZGUgZHVlIHRvDQo+IGFub3RoZXIgYnVnIGluIHRoaXMgcGF0Y2hzZXQ6DQo+IA0KPiBPbiBUaHUs
IEFwciAyOSwgMjAyMSBhdCAwNDowMTozNlBNICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvZncuYw0KPiA+ICsNCj4gPiArI2RlZmluZSBIMkNfTFBTX1BBUk1fTEVOIDgNCj4gPiAr
aW50IHJ0dzg5X2Z3X2gyY19scHNfcGFybShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHU4IG1h
Y2lkKQ0KPiANCj4gWW91J3JlIG5vdCBhY3R1YWxseSB1c2luZyB0aGUgbWFjaWQgcGFyYW0gZnJv
bSB0aGlzIGZ1bmN0aW9uLiBJbnN0ZWFkLA0KPiB5b3UncmUgaW1wbGljaXRseSBwYXNzaW5nIGRh
dGEgdG8gdGhpcyBmdW5jdGlvbiB2aWENCj4gcnR3ZGV2LT5scHNfcGFybS4uLmV4Y2VwdCB0aGF0
IGl0IGxvb2tzIGxpa2UgeW91IG9ubHkgc2V0IGFuZCB1c2UgaXQNCj4gZGlyZWN0bHkgaW4gdGhp
cyBjYWxsY2hhaW4sIGFuZCB5b3UgZG9uJ3QgYWN0dWFsbHkgbmVlZCB0byBzYXZlIGl0IGluDQo+
IHlvdXIgZHJpdmVyIHN0cnVjdHVyZS4NCj4gDQo+IElJVUMsIEkgYmVsaWV2ZSB0aGlzIHdvdWxk
IGJlIGNsZWFyZXIgYW5kIGxlc3MgZXJyb3ItcHJvbmUgaWYgeW91IGp1c3QNCj4gcGFzcyBhICdz
dHJ1Y3QgcnR3ODlfbHBzX3Bhcm0nIGFyZyAoaGVyZSwgYW5kIGluDQo+IHJ0dzg5X2Z3X2gyY19n
ZW5lcmFsX3BrdCgpKSwgYW5kIGRyb3AgJ3N0cnVjdCBydHc4OV9scHNfcGFybScgZnJvbQ0KPiBy
dHdkZXYuDQo+IA0KDQpZb3UncmUgcmlnaHQuIFdpbGwgZm9sbG93IHlvdXIgc3VnZ2VzdGlvbi4N
Cg0KLS0NClBpbmctS2UNCg0K
