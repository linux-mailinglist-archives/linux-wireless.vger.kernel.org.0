Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D067B29EB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 02:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjI2AnX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 20:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjI2AnP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 20:43:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D049CE3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 17:43:11 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38T0grhfF264807, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38T0grhfF264807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:42:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 29 Sep 2023 08:42:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 29 Sep 2023 08:42:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Fri, 29 Sep 2023 08:42:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH 2/3] wifi: rtw89: refine uplink trigger based control mechanism
Thread-Topic: [PATCH 2/3] wifi: rtw89: refine uplink trigger based control
 mechanism
Thread-Index: AQHZ74e2GXoool1T8kGXUPpsGJOCXbAv6jGAgACGz4yAAAWRAA==
Date:   Fri, 29 Sep 2023 00:42:52 +0000
Message-ID: <5cab4dd09aa908524b79d57e9c5f49b9a5f244e3.camel@realtek.com>
References: <20230925080902.51449-3-pkshih@realtek.com>
         <169591802194.3187104.18062067562610023067.kvalo@kernel.org>
         <87v8bui7u1.fsf@kernel.org>
In-Reply-To: <87v8bui7u1.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.66.25]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB904F733A575842B7D9518AB14DA153@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDE5OjI0ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4gd3JpdGVzOg0KPiANCj4gPiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBGcm9tOiBQby1I
YW8gSHVhbmcgPHBoaHVhbmdAcmVhbHRlay5jb20+DQo+ID4gPiANCj4gPiA+IFJlbmFtZSBzdXBw
b3J0X3VsX3RiX2N0cmwgdG8gd2F2ZWZvcm1fY3RybCBzaW5jZSB3ZSBuZWVkIHRvIGRvIG1vcmUN
Cj4gPiA+IHRyaWdnZXIgYmFzZWQgY29udHJvbCBhbmQgdGhlIG5hbWluZyBjb3VsZCBiZSBjb25m
dXNpbmcuIE1vdmUgcmVsYXRlZA0KPiA+ID4gY29kZSB0byBsZWFmIGZ1bmN0aW9uIHNvIHdlIG1h
a2UgZWFjaCBmdW5jdGlvbnMgc2VwYXJhdGUgYW5kIGNhbiBiZQ0KPiA+ID4gZWFzaWVyIHRvIG1h
aW50YWluLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQby1IYW8gSHVhbmcgPHBoaHVh
bmdAcmVhbHRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCj4gPiANCj4gPiBJIGRvbid0IHNlZSBwYXRjaCAxIGluIHBhdGNod29y
ayBhbmQgSSBzZWUgcGF0Y2ggMyB0d2ljZS4gUGxlYXNlIGNoZWNrDQo+ID4gYW5kIHJlc2VuZC4N
Cj4gPiANCj4gPiAzIHBhdGNoZXMgc2V0IHRvIENoYW5nZXMgUmVxdWVzdGVkLg0KPiA+IA0KPiA+
IDEzMzk3NDI3IFsyLzNdIHdpZmk6IHJ0dzg5OiByZWZpbmUgdXBsaW5rIHRyaWdnZXIgYmFzZWQg
Y29udHJvbCBtZWNoYW5pc20NCj4gPiAxMzM5NzQyNCBbMy8zXSB3aWZpOiBydHc4OTogUmVmaW5l
IGJhbmR3aWR0aCAxNjBNSHogdXBsaW5rIE9GRE1BIHBlcmZvcm1hbmNlDQo+ID4gMTMzOTc0MjYg
WzMvM10gd2lmaTogcnR3ODk6IHJlZmluZSBiYW5kd2lkdGggMTYwTUh6IHVwbGluayBPRkRNQSBw
ZXJmb3JtYW5jZQ0KPiANCj4gQWN0dWFsbHkgcGF0Y2ggMSB3YXMgYXNzaWduZWQgdG8gSm9oYW5u
ZXMgYW5kIGhlIGhhcyBhbHJlYWR5IGFwcGxpZWQgaXQuDQo+IEJ1dCBkdWUgdG8gc2VlaW5nIHBh
dGNoIDMgdHdpY2UgaXQncyBzdGlsbCBiZXN0IHRvIHJlc2VuZC4NCj4gDQoNCk9vcHMuIEkgbW9k
aWZpZWQgdGhlIGNvbW1pdCBtZXNzYWdlIGFzIHdlbGwgYXMgc3ViamVjdCBkdXJpbmcgc3VibWlz
c2lvbiwgYnV0DQpmb3Jnb3QgdG8gcmVtb3ZlIHRoZSBvbGQgb25lcy4gSSBzZW5kIHYyIHRvIGNv
cnJlY3QgdGhpcy4gDQoNClRoYW5rIHlvdSBhbmQgSm9oYW5uZXMuIA0KDQpQaW5nLUtlDQoNCg0K
