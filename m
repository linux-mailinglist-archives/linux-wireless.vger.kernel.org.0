Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600CA78647B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 03:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjHXBKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 21:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbjHXBKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 21:10:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF71610F0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 18:10:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37O19tekE003888, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37O19tekE003888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 09:09:55 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 24 Aug 2023 09:10:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Aug 2023 09:10:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 09:10:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
Thread-Topic: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
Thread-Index: AQHZ0Brxr+k/PO8FCkKk2NopO/rnjK/38wxC//+H2ACAAMMuiP//6tkA
Date:   Thu, 24 Aug 2023 01:10:04 +0000
Message-ID: <19deae143404590f10ffcbbb817ab24e1d360b60.camel@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
         <87o7ixhng5.fsf@kernel.org>
         <22a5d99c4f4be30dd7659400ba9a42c0701f6521.camel@realtek.com>
         <87fs49hb0n.fsf@kernel.org>
In-Reply-To: <87fs49hb0n.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.79.203]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <270E9249ECD88C4886653F52FFD4548B@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
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

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDIxOjI0ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gDQo+IEp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwgaG93IGRvIHlvdSBjcmVhdGUgeW91ciBhc2Np
aSBkaWFncmFtcz8gSXMgdGhlcmUNCj4gc29tZSBuaWZ0eSB0b29sIHRvIGhlbHAgd2l0aCB0aG9z
ZT8gOikNCj4gDQoNCkkgZHJhdyB0aGVzZSBkaWFncmFtcyBtYW51YWxseSwgbm90IHByZXR0eSBi
dXQgdXNlZnVsIChJIHRoaW5rIHNvIDopICkuDQoNClJlY2VudGx5LCBJIGRyYXcgYSBkaWFncmFt
IGluIGNvdmVyIGxldHRlciwgYmVjYXVzZSBwdXJwb3NlIG9mDQpwYXRjaHNldCBpcyBzaW1wbGUs
IGJ1dCB0b28gbXVjaCBkZXRhaWwgdGhpbmdzIGNhdXNlIHBhdGNoZXMNCmNvbXBsaWNhdGVkLiBT
bywgSSBob3BlIGEgZGlhZ3JhbSBjYW4gaGVscCByZXZpZXdlcnMgdG8gaGF2ZSBhIA0KY29uY2Vw
dCBxdWlja2x5IGJlZm9yZSByZXZpZXdpbmcgbXkgcGF0Y2hlcy4gDQoNClBpbmctS2UNCg0K
