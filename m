Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6364C178
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 01:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbiLNArv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 19:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiLNArr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 19:47:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 674E72705
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 16:47:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BE0kj7X3013761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BE0kj7X3013761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Dec 2022 08:46:45 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 14 Dec 2022 08:47:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Dec 2022 08:47:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 14 Dec 2022 08:47:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Charles Piekarski <contact@charlespiekarski.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8852BE support
Thread-Topic: Realtek 8852BE support
Thread-Index: AQHZDiv7aKh6KT2pxkK2thQIySbvPq5sjl7A
Date:   Wed, 14 Dec 2022 00:47:34 +0000
Message-ID: <1f878b2ec793443f96685773c6599591@realtek.com>
References: <a2a454c5-3940-52d0-77b7-e5f8376720ae@charlespiekarski.com>
In-Reply-To: <a2a454c5-3940-52d0-77b7-e5f8376720ae@charlespiekarski.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzEzIOS4i+WNiCAxMDowMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoYXJsZXMgUGlla2Fyc2tp
IDxjb250YWN0QGNoYXJsZXNwaWVrYXJza2kuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVy
IDEyLCAyMDIyIDc6MTEgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZWFsdGVrIDg4NTJCRSBzdXBwb3J0DQo+IA0KPiBEZWFyIFNpciBvciBNYWRh
bSwNCj4gDQo+IEkgd291bGQgbGlrZSB0byBraW5kbHkgYXNrIGZvciBpbmZvcm1hdGlvbiBpZiBS
ZWFsdGVrIDg4NTJCRSBXaS1GaSA2DQo+IG1vZHVsZSBpcyBzdXBwb3J0ZWQgb3Igd2lsbCBiZSBz
dXBwb3J0ZWQgYnkgdGhlIExpbnV4IGtlcm5lbC4NCj4gUmVncmV0dGFibHksIHRoZSBtb2R1bGUg
ZG9lcyBub3Qgd29yayB1bmRlciBVYnVudHUgMjIuMDQuMSBhbmQgMjIuMTAsIGF0DQo+IGxlYXN0
IG91dCBvZiB0aGUgYm94LCBhbmQgSSB3YXMgdW5hYmxlIHRvIGZpbmQgYW55IHVzZWZ1bCBpbmZv
cm1hdGlvbiB0bw0KPiBnZXQgaXQgd29ya2luZyBpbiBhIHNhZmUgd2F5ICh3aXRoIFNlY3VyZSBC
b290IGVuYWJsZWQpLg0KPiANCg0KODg1MkJFIGdvdCBtZXJnZWQgaW50byBrZXJuZWwgNi4yIHRo
YXQgd2lsbCByZWxlYXNlIGFib3V0IDMgbW9udGhzIGxhdGVyLg0KDQpQaW5nLUtlDQoNCg==
