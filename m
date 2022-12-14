Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82164C561
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiLNI6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 03:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiLNI6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 03:58:22 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E90A5B5F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 00:58:21 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BE8vScuD021619, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BE8vScuD021619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Dec 2022 16:57:28 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 14 Dec 2022 16:58:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Dec 2022 16:58:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 14 Dec 2022 16:58:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v2 3/5] wifi: rtl8xxxu: Define masks for cck_agc_rpt bits
Thread-Topic: [PATCH v2 3/5] wifi: rtl8xxxu: Define masks for cck_agc_rpt bits
Thread-Index: AQHZDxiHt4OPI8O65U+Y9MGufLBG1a5tFhcw
Date:   Wed, 14 Dec 2022 08:58:17 +0000
Message-ID: <df8b961c6aca4f2a8bb3c2a14b087cb9@realtek.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
 <495c0ea7-d6c9-15c7-7c25-77ecbe856cdc@gmail.com>
In-Reply-To: <495c0ea7-d6c9-15c7-7c25-77ecbe856cdc@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
MTQsIDIwMjIgMTozMCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAzLzVdIHdpZmk6IHJ0bDh4eHh1OiBEZWZpbmUgbWFza3MgZm9yIGNja19hZ2NfcnB0
IGJpdHMNCj4gDQo+IERlZmluZSB0aGUgY29uc3RhbnRzIENDS19BR0NfUlBUX0xOQV9JRFhfTUFT
SyBhbmQNCj4gQ0NLX0FHQ19SUFRfVkdBX0lEWF9NQVNLIGluc3RlYWQgb2YgdXNpbmcgdGhlIHNh
bWUgbGl0ZXJhbHMNCj4gaW4gZm91ciBwbGFjZXMuDQo+IA0KPiBBbmQgZ2V0IHRoZSBiaXRzIGZy
b20gY2NrX2FnY19ycHQgdXNpbmcgdThfZ2V0X2JpdHMoKS4NCj4gDQo+IEl0J3MgYSBjb3NtZXRp
YyBjaGFuZ2Ugb25seS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYyOg0KPiAgLSBQYXRjaCBpcyBuZXcgaW4gdjIu
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4
dS5oICAgICAgIHwgMyArKysNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfODE4OGYuYyB8IDQgKystLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTkyZS5jIHwgNCArKy0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzg3MjNiLmMgfCA0ICsrLS0NCj4gIDQg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCg0KWy4u
Ll0NCg0K
