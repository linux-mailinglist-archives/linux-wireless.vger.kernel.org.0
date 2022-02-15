Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8E4B5F07
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 01:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiBOA1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 19:27:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiBOA1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 19:27:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16FE687D
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 16:27:05 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21F0Qo9M2018731, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21F0Qo9M2018731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 08:26:50 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Feb 2022 08:26:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 16:26:49 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Tue, 15 Feb 2022 08:26:49 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>, DeanKu <ku920601@realtek.com>
Subject: RE: [PATCH 2/6] rtw88: coex: Improve WL throughput when HFP COEX
Thread-Topic: [PATCH 2/6] rtw88: coex: Improve WL throughput when HFP COEX
Thread-Index: AQHYHxdG7jfJ4CX9r0Knis4LQWcWA6yS1NiAgADx8uA=
Date:   Tue, 15 Feb 2022 00:26:49 +0000
Message-ID: <a78562ffb2a6409b866c5bc6817ade0f@realtek.com>
References: <20220211071533.34716-3-pkshih@realtek.com>
 <164486154882.6494.2693768453382904665.kvalo@kernel.org>
In-Reply-To: <164486154882.6494.2693768453382904665.kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTQg5LiL5Y2IIDA4OjQyOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGxlIFZhbG8gPGt2YWxv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDE1LCAyMDIyIDE6NTkgQU0N
Cj4gVG86IFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogdG9ueTA2MjBlbW1hQGdt
YWlsLmNvbTsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBUaW1sZWUgPHRpbWxlZUBy
ZWFsdGVrLmNvbT47IERlYW5LdQ0KPiA8a3U5MjA2MDFAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi82XSBydHc4ODogY29leDogSW1wcm92ZSBXTCB0aHJvdWdocHV0IHdoZW4g
SEZQIENPRVgNCj4gDQo+IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToN
Cj4gDQo+ID4gRnJvbTogQ2hpbmctVGUgS3UgPGt1OTIwNjAxQHJlYWx0ZWsuY29tPg0KPiA+DQo+
ID4gRGlzYWJsZSBwb3dlciBzYXZlIFRETUEgbWVjaGFuaXNtIHVuZGVyIEhGUCBDT0VYLCBzbyBX
TCBjYW4gVFJ4IGZ1bGwgdGltZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaW5nLVRlIEt1
IDxrdTkyMDYwMUByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQo+IFdoYXQncyBXTCBhbmQgVFJ4Pw0KPiANCg0KV0wg
aXMgV0xBTiwgYW5kIFRSeCBzaG91bGQgYmUgVFgvUlguDQpJIHdpbGwgdXNlIGNvbW1vbiBhYmJy
ZXZpYXRpb25zIGFuZCBzZW5kIHYyLg0KDQotLQ0KUGluZy1LZQ0KDQo=
