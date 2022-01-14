Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4655C48E204
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 02:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiANBHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 20:07:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42701 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiANBHo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 20:07:44 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20E17WbG4011060, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20E17WbG4011060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jan 2022 09:07:32 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 09:07:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 13 Jan 2022 17:07:32 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Fri, 14 Jan 2022 09:07:32 +0800
From:   Pkshih <pkshih@realtek.com>
To:     =?utf-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [PATCH] rtw89: fix maybe uninitialized `qempty` variable
Thread-Topic: [PATCH] rtw89: fix maybe uninitialized `qempty` variable
Thread-Index: AQHYCGH6KhBne+/KM0O8iXkAMBkKl6xhtU3w
Date:   Fri, 14 Jan 2022 01:07:32 +0000
Message-ID: <fdee7063c0984c46bb374419fab606d2@realtek.com>
References: <20220113094253.73370-1-ihuguet@redhat.com>
In-Reply-To: <20220113094253.73370-1-ihuguet@redhat.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMTMg5LiL5Y2IIDEwOjQwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IMONw7FpZ28gSHVndWV0IDxp
aHVndWV0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDEzLCAyMDIyIDU6
NDMgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUGtzaGlo
IDxwa3NoaWhAcmVhbHRlay5jb20+OyBrdmFsb0BrZXJuZWwub3JnOyDDjcOxaWdvIEh1Z3VldCA8
aWh1Z3VldEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHJ0dzg5OiBmaXggbWF5YmUg
dW5pbml0aWFsaXplZCBgcWVtcHR5YCB2YXJpYWJsZQ0KPiANCj4gQ2FsbCB0byBkbGVfZGZpX3Fl
bXB0eSBtaWdodCBmYWlsLCBsZWF2aW5nIHFlbXB0eS5xZW1wdHkgdW50b3VjaGVkLCB3aGljaA0K
PiBpcyBsYXR0ZXIgdXNlZCB0byBjb250cm9sIHRoZSBmb3IgbG9vcC4gSWYgdGhhdCBoYXBwZW5z
LCBpdCdzIG5vdA0KPiBpbml0aWFsaXplZCBhbnl3aGVyZS4NCj4gDQo+IEluaXRpYWxpemUgaXQg
c28gdGhlIGxvb3AgZG9lc24ndCBpdGVyYXRlIHVubGVzcyBpdCdzIG1vZGlmaWVkIGJ5IHRoZQ0K
PiBjYWxsIHRvIGRsZV9kZmlfcWVtcHR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogw43DsWlnbyBI
dWd1ZXQgPGlodWd1ZXRAcmVkaGF0LmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KDQpbLi4uXQ0KDQo=
