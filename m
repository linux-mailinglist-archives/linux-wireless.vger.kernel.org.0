Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3A7020C8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjEOAWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjEOAWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 20:22:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873A1B1
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 17:22:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34F0LmIB2014713, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34F0LmIB2014713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 15 May 2023 08:21:48 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 15 May 2023 08:21:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 May 2023 08:21:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 15 May 2023 08:21:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v4 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH v4 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZhdwsrFGRToeLFU6+3rypbdTZla9aeqYw
Date:   Mon, 15 May 2023 00:21:56 +0000
Message-ID: <440f821c34bd4b48861dbcafe9ac4fc5@realtek.com>
References: <7dcf9fb9-1c97-ac28-5286-2236e287a18c@gmail.com>
In-Reply-To: <7dcf9fb9-1c97-ac28-5286-2236e287a18c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTWF5IDE0LCAyMDIz
IDQ6NDggQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVz
IFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2NCAxLzJdIHdpZmk6IHJ0bDh4eHh1OiBT
dXBwb3J0IG5ldyBjaGlwIFJUTDgxOTJGVQ0KPiANCj4gVGhpcyBpcyBhIG5ld2VyIGNoaXAsIHNp
bWlsYXIgdG8gdGhlIFJUTDg3MTBCVSBpbiB0aGF0IGl0IHVzZXMgdGhlIHNhbWUNCj4gUEhZIHN0
YXR1cyBzdHJ1Y3RzLg0KPiANCj4gRmVhdHVyZXM6IDIuNCBHSHosIGIvZy9uIG1vZGUsIDJUMlIs
IDMwMCBNYnBzLg0KPiANCj4gSXQgY2FuIGFsbGVnZWRseSBoYXZlIEJsdWV0b290aCwgYnV0IHRo
YXQncyBub3QgaW1wbGVtZW50ZWQgaGVyZS4NCj4gDQo+IFRoaXMgY2hpcCBjYW4gaGF2ZSBtYW55
IFJGRSAoUkYgZnJvbnQgZW5kKSB0eXBlcywgb2Ygd2hpY2ggdHlwZXMgMQ0KPiBhbmQgNSBhcmUg
dGhlIG9ubHkgb25lcyB0ZXN0ZWQuIE1hbnkgb2YgdGhlIG90aGVyIHR5cGVzIG5lZWQgZGlmZmVy
ZW50DQo+IGluaXRpYWxpc2F0aW9uIHRhYmxlcy4gVGhleSBjYW4gYmUgYWRkZWQgaWYgc29tZW9u
ZSB3YW50cyB0aGVtLg0KPiANCj4gVGhlIHZlbmRvciBkcml2ZXIgdjUuOC42LjJfMzU1MzguMjAx
OTEwMjhfQ09FWDIwMTkwOTEwLTBkMDIgZnJvbQ0KPiBodHRwczovL2dpdGh1Yi5jb20vQnJpZ2h0
WC9ydGw4MTkyZnUgd2FzIHVzZWQgYXMgcmVmZXJlbmNlLCB3aXRoDQo+IGFkZGl0aW9uYWwgZGV2
aWNlIElEcyB0YWtlbiBmcm9tDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9rZWxlYmVrMzMzL3J0bDgx
OTJmdS1ka21zLg0KPiANCj4gVGhlIHZlbmRvciBkcml2ZXIgYWxzbyBjbGFpbXMgdG8gc3VwcG9y
dCBkZXZpY2VzIHdpdGggSUQgMGJkYTphNzI1LA0KPiBidXQgdGhhdCBpcyBmb3VuZCBpbiBzb21l
IGJsdWV0b290aC1vbmx5IGRldmljZXMsIHNvIGl0J3Mgbm90IHN1cHBvcnRlZA0KPiBoZXJlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFp
bC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0KDQoNCg==
