Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8536764CA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jan 2023 08:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjAUHBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Jan 2023 02:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUHBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Jan 2023 02:01:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEB653344B
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 23:01:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30L71Zd04021180, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30L71Zd04021180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Jan 2023 15:01:35 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 21 Jan 2023 15:01:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 21 Jan 2023 15:01:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Sat, 21 Jan 2023 15:01:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2 1/4] wifi: rtl8xxxu: Register the LED and make it blink
Thread-Topic: [PATCH v2 1/4] wifi: rtl8xxxu: Register the LED and make it
 blink
Thread-Index: AQHZLOcRnv2YPN3XbEm+eo0uEbr9eq6n7EMA
Date:   Sat, 21 Jan 2023 07:01:36 +0000
Message-ID: <16551886fea8b46cddd18659b43a54564b30ace2.camel@realtek.com>
References: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
In-Reply-To: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [111.252.173.81]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjEg5LiK5Y2IIDAyOjAzOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B2B7155E79DAA41B8ABF1C7AD0572B7@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTIwIGF0IDE3OjUxICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiBJZiB0aGUgY2hpcCBjYW4gaGF2ZSBhbiBMRUQsIHJlZ2lzdGVyIGEgc3RydWN0IGxlZF9j
bGFzc2RldiBhbmQgZW5hYmxlDQo+IGhhcmR3YXJlLWNvbnRyb2xsZWQgYmxpbmtpbmcuIFdoZW4g
dGhlIGNoaXAgaXMgbm90IHRyYW5zbWl0dGluZyBvcg0KPiByZWNlaXZpbmcgYW55dGhpbmcgdGhl
IExFRCBpcyBvZmYuIE90aGVyd2lzZSB0aGUgTEVEIHdpbGwgYmxpbmsNCj4gZmFzdGVyIG9yIHNs
b3dlciBhY2NvcmRpbmcgdG8gdGhlIHRocm91Z2hwdXQuDQo+IA0KPiBUaGUgTEVEIGNhbiBiZSBj
b250cm9sbGVkIGZyb20gdXNlcnNwYWNlIGJ5IHdyaXRpbmcgMCwgMSwgb3IgMiB0bw0KPiAvc3lz
L2NsYXNzL2xlZHMvcnRsOHh4eHUtdXNiWC1ZL2JyaWdodG5lc3M6DQo+IDAgLSBzb2xpZCBvZmYu
DQo+IDEgLSBzb2xpZCBvbi4NCj4gMiAtIGhhcmR3YXJlLWNvbnRyb2xsZWQgYmxpbmtpbmcuDQo+
IA0KPiBJbiB0aGlzIHBhdGNoIG5vbmUgb2YgdGhlIGNoaXBzIGFkdmVydGlzZSBoYXZpbmcgYW4g
TEVELiBUaGF0IHdpbGwgYmUNCj4gYWRkZWQgaW4gdGhlIG5leHQgcGF0Y2hlcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0K
DQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0KPiAt
LS0NCj4gdjI6DQo+ICAtIFN1Z2dlc3Rpb24gZnJvbSBQaW5nLUtlIFNoaWg6DQo+ICAgIC0gQ2hl
Y2sgZm9yIGxlZF9jbGFzc2Rldl9icmlnaHRuZXNzX3NldCBpbnNpZGUgcnRsOHh4eHVfaW5pdF9s
ZWQoKQ0KPiAgICAgIGFuZCBmb3IgbGVkX3JlZ2lzdGVyZWQgaW5zaWRlIHJ0bDh4eHh1X2RlaW5p
dF9sZWQoKSBpbnN0ZWFkIG9mDQo+ICAgICAgY2hlY2tpbmcgZm9yIHRoZW0gaW4gdGhlIGNhbGxl
ciBmdW5jdGlvbnMuDQo+IA0KDQpbLi4uXQ0KDQoNCg0K
