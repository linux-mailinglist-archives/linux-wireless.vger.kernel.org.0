Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3583E71F9EA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 08:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFBGNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 02:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBGNW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 02:13:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA713E
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 23:13:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3526CsagE007392, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3526CsagE007392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 14:12:54 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 2 Jun 2023 14:13:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Jun 2023 14:13:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 2 Jun 2023 14:13:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A reads as unused
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A
 reads as unused
Thread-Index: AQHZlHctas6Xg5gTu0Cgi8yJ5JAmc691Wq+AgAAWMwCAARKcAA==
Date:   Fri, 2 Jun 2023 06:13:08 +0000
Message-ID: <dc499da404c21b1d2db71a792d7fb836bc9ef122.camel@realtek.com>
References: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
         <20230601105215.27013-1-dmantipov@yandex.ru>
         <3b92f9205003f44187f7ebf7add6c3e0626e9646.camel@realtek.com>
         <0d1f24b9-a058-52fd-b669-54aa4e9162f9@yandex.ru>
In-Reply-To: <0d1f24b9-a058-52fd-b669-54aa4e9162f9@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.72.35]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <63D003F9F466AD4B85EDB25FB53428D7@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDE2OjUwICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gDQo+IE9uIDYvMS8yMyAxNTozMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiANCj4gPiBOb3Jt
YWxseSwgbWVudGlvbiBhIGNvbW1pdCBieSBgY29tbWl0IDwxMiBkaWdpdHMgU0hBMT4gKCJzdWJq
ZWN0IilgDQo+IA0KPiBPSw0KPiANCj4gPiBXaHkgbm90IGp1c3QNCj4gPiANCj4gPiBydGxfZ2V0
X2JicmVnKGh3LCBSVFhfUE9XRVJfQkVGT1JFX0lRS19BLCBNQVNLRFdPUkQpOw0KPiA+IHJ0bF9n
ZXRfYmJyZWcoaHcsIFJUWF9QT1dFUl9BRlRFUl9JUUtfQSwgTUFTS0RXT1JEKTsNCj4gDQo+IENv
bXBpbGVyIHdpdGggLVdleHRyYSBldGMuIG9yIHN0YXRpYyBhbmFseXNpcyB0b29sIG1heSBjb21w
bGFpbiBhYm91dCBhbiB1bnVzZWQNCj4gcmV0dXJuIHZhbHVlLiBBcyBmYXIgYXMgSSBrbm93IEdD
QyBoYXMgX19hdHRyaWJ1dGVfXygod2Fybl91bnVzZWRfcmVzdWx0KSkgYnV0DQo+IGxhY2tzIGFu
IG9wcG9zaXRlIHRoaW5nLCBzbyAoc29tZXdoYXQgdWdseSBleHBsaWNpdCkgY2FzdCB0byAndm9p
ZCcgbWF5IGJlIGhlbHBmdWwuDQo+IA0KDQpEb24ndCB5b3UgdGhpbmsgY2FzdGluZyBvZiAndm9p
ZCcgb25seSBtYWtlcyB0b29sIGhhcHB5Pw0KDQpQaW5nLUtlDQoNCg==
