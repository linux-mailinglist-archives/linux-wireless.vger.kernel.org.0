Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6366E230B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDNMWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNMVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:21:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BB9B468
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:21:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33ECKd382010098, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33ECKd382010098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 20:20:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Apr 2023 20:21:01 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 14 Apr 2023 20:21:01 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::b457:c042:266c:6fec]) by
 RTEXDAG02.realtek.com.tw ([fe80::b457:c042:266c:6fec%5]) with mapi id
 15.01.2375.007; Fri, 14 Apr 2023 20:21:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: Re: [PATCH 4/7] wifi: rtw88: disallow scan and PS during AP mode
Thread-Topic: [PATCH 4/7] wifi: rtw88: disallow scan and PS during AP mode
Thread-Index: AQHZZJfxtujM7P+LRUmfNtWeFqaSvq8nrpJDgAKZQgA=
Date:   Fri, 14 Apr 2023 12:21:01 +0000
Message-ID: <9ee7c56110273bae043577651cf37f3cc7831249.camel@realtek.com>
References: <20230401124410.33221-1-pkshih@realtek.com>
         <20230401124410.33221-5-pkshih@realtek.com> <877cuh8eb3.fsf@kernel.org>
In-Reply-To: <877cuh8eb3.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.20.53]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1A73254AA4B204982EE16D907AADC87@realtek.com>
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

T24gV2VkLCAyMDIzLTA0LTEyIGF0IDE1OjM5ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gRnJv
bTogUG8tSGFvIEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IA0KPiA+IER1cmluZyBj
b25jdXJyZW50IG9wZXJhdGlvbiwgdGhlIFZJRiBzaGFyaW5nIHNhbWUgY2hhbm5lbCB3aXRoIEFQ
IG1vZGUNCj4gPiBtaWdodCBzY2FuLiBSZWplY3QgdGhvc2Ugc2NhbiByZXF1ZXN0cyBmcm9tIGRy
aXZlciB3aGVuIHRoZXJlJ3MgQVANCj4gPiBjdXJyZW50bHkgb3BlcmF0aW5nLiBBbHNvLCBkaXNh
bGxvdyBlbnRlcmluZyBwb3dlciBzYXZpbmcgbW9kZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQby1IYW8gSHVhbmcgPHBoaHVhbmdAcmVhbHRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBIb3cgaXMgYSBzdGF0aW9u
IGludGVyZmFjZSB1c2VmdWwgaWYgaXQgY2Fubm90IHNjYW4gYXQgYWxsPyBJTUhPIHF1aXRlDQo+
IGhhcmQgbGltaXRhdGlvbi4NCj4gDQoNCkR1ZSB0byBoYXJkd2FyZSBsaW1pdGF0aW9uLCBpdCBj
YW4ndCBob3N0IGFzIEFQIG1vZGUgYW5kIGRvIHNjYW5uaW5nIGF0DQp0aGUgc2FtZSB0aW1lLCBz
byB3ZSBtYWtlIHRoaXMgY2hvaWNlIGJlZm9yZS4gTm93LCB3ZSBkb24ndCByZWplY3Qgc2Nhbg0K
cmVxdWVzdHMsIGJ1dCBBUCdzIGNsaWVudHMgY291bGQgZ2V0IGxvc3Qgb3IgZGlzY29ubmVjdGVk
LiBJIHRoaW5rDQp0aGF0IGlzIGEgdHJhZGUtb2ZmLCBzbyB3ZSBsZWF2ZSB0aGlzIGRlY2lzaW9u
IHRvIHVzZXIgc3BhY2UuDQoNCkkgaGF2ZSBzZW50IHYyIHdpdGggdGhpcyBjaGFuZ2UuDQoNClBp
bmctS2UNCg0K
