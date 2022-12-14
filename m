Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3164C55B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiLNI5Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 03:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiLNI5O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 03:57:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1618C1AD81
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 00:57:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BE8uJiK5021408, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BE8uJiK5021408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Dec 2022 16:56:19 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 14 Dec 2022 16:57:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Dec 2022 16:57:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 14 Dec 2022 16:57:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v2 2/5] wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take const char*
Thread-Topic: [PATCH v2 2/5] wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take
 const char*
Thread-Index: AQHZDxhm3gIy1zg210+hpNKWR+TcM65tFc6Q
Date:   Wed, 14 Dec 2022 08:57:08 +0000
Message-ID: <f71b1e2f8ed144b9b6f73490ba9ec396@realtek.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
 <5ffc2ae2-9f90-6a60-370c-5e614262616e@gmail.com>
In-Reply-To: <5ffc2ae2-9f90-6a60-370c-5e614262616e@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE0IOS4iuWNiCAwNjoxMjowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIg
MTQsIDIwMjIgMToyOSBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAyLzVdIHdpZmk6IHJ0bDh4eHh1OiBNYWtlIHJ0bDh4eHh1X2xvYWRfZmlybXdhcmUg
dGFrZSBjb25zdCBjaGFyKg0KPiANCj4gQW5kIHBhc3MgY29uc3QgY2hhciogdG8gaXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoN
Cj4gLS0tDQo+IHYyOg0KPiAgLSBQYXRjaCBpcyBuZXcgaW4gdjIuDQo+IC0tLQ0KPiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oICAgICAgIHwgMiArLQ0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTg4Zi5j
IHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4
dV84MTkyYy5jIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9ydGw4eHh4dV84MTkyZS5jIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYS5jIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYi5jIHwgMiArLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgIHwgMiArLQ0KPiAg
NyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KDQpb
Li4uXQ0KDQo=
