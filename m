Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD515FEE74
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJNNRv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 09:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJNNRu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 09:17:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A66BF1793B8
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 06:17:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29EDH90k8000907, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29EDH90k8000907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Oct 2022 21:17:09 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Oct 2022 21:17:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Oct 2022 21:17:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2]) by
 RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2%5]) with mapi id
 15.01.2375.007; Fri, 14 Oct 2022 21:17:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/4] wifi: rtw89: 8852b: add RF calibration part 2 and enable 8852BE
Thread-Topic: [PATCH 0/4] wifi: rtw89: 8852b: add RF calibration part 2 and
 enable 8852BE
Thread-Index: AQHY35LVdSzT97sfjESlfqJScY6Egq4NrhWZ//+rR4A=
Date:   Fri, 14 Oct 2022 13:17:38 +0000
Message-ID: <335e441413dbe33884e931f318501de147c45c20.camel@realtek.com>
References: <20221014060237.29050-1-pkshih@realtek.com>
         <87ilkmn1ud.fsf@kernel.org>
In-Reply-To: <87ilkmn1ud.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.65.142]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzE0IOS4iuWNiCAwNjoxNzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DB5E96D18B1454D9B42FAB96E4C793D@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDEzOjIwICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBBZnRlciB0
aGlzIHBhdGNoc2V0LCA4ODUyQkUgaXMgcmVhZHksIHNvIGFkZCA4ODUyQkUgdG8gS2NvbmZpZyBh
bmQNCj4gPiBNYWtlZmlsZS4gV2l0aCBmaXJtd2FyZSB2MC4yNy4zMi4wLCBTVEEsIEFQIGFuZCBt
b25pdG9yIGNhbiB3b3JrIHdlbGwuIA0KPiANCj4gQXdlc29tZSEgRnJvbSBteSBwb2ludCBvZiB2
aWV3IGFkZGluZyA4ODUyQkUgc3VwcG9ydCB3ZW50IHJlYWxseQ0KPiBzbW9vdGhseSwgdGhhbmtz
IGZvciB0aGF0LiBWZXJ5IG11Y2ggYXBwcmVjaWF0ZWQuDQo+IA0KDQpTdXBlciB0aGFua3MgZm9y
IHNwZW5kaW5nIHlvdXIgdGltZSB0byByZXZpZXcgdGhpcyBkcml2ZXIsIGFuZCBhbHNvDQp0aGFu
a3MgZm9yIHlvdXIgc3VwcG9ydCwgYWR2aWNlIGFuZCB0ZWFjaGluZyBkdXJpbmcgcmV2aWV3IHBy
b2Nlc3MuIDotKQ0KDQpQaW5nLUtlDQoNCg==
