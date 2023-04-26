Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAB6EEE81
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 08:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjDZGo5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 02:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbjDZGox (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 02:44:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70352129
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 23:44:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33Q6ikfzF018560, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33Q6ikfzF018560
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 26 Apr 2023 14:44:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 26 Apr 2023 14:44:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Apr 2023 14:44:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 26 Apr 2023 14:44:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZd5tasrPlKIiNeUKI8XDI8zOKla89JKTA
Date:   Wed, 26 Apr 2023 06:44:48 +0000
Message-ID: <9430983b196d42ffa7f83859004ef856@realtek.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
In-Reply-To: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjYs
IDIwMjMgMToyOCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSB3aWZpOiBydGw4eHh4dTogU3Vw
cG9ydCBuZXcgY2hpcCBSVEw4MTkyRlUNCj4gDQo+IFRoaXMgaXMgYSBuZXdlciBjaGlwLCBzaW1p
bGFyIHRvIHRoZSBSVEw4NzEwQlUgaW4gdGhhdCBpdCB1c2VzIHRoZSBzYW1lDQo+IFBIWSBzdGF0
dXMgc3RydWN0cy4NCj4gDQo+IEZlYXR1cmVzOiAyLjQgR0h6LCBiL2cvbiBtb2RlLCAyVDJSLCAz
MDAgTWJwcy4NCj4gDQo+IEl0IGNhbiBhbGxlZ2VkbHkgaGF2ZSBCbHVldG9vdGgsIGJ1dCB0aGF0
J3Mgbm90IGltcGxlbWVudGVkIGhlcmUuDQo+IA0KPiBUaGlzIGNoaXAgY2FuIGhhdmUgbWFueSBS
RkUgKFJGIGZyb250IGVuZCkgdHlwZXMsIG9mIHdoaWNoIHR5cGUgNSBpcw0KPiB0aGUgb25seSBv
bmUgdGVzdGVkLiBNYW55IG9mIHRoZSBvdGhlciB0eXBlcyBuZWVkIGRpZmZlcmVudA0KPiBpbml0
aWFsaXNhdGlvbiB0YWJsZXMuIFRoZXkgY2FuIGJlIGFkZGVkIGlmIHNvbWVvbmUgd2FudHMgdGhl
bS4NCj4gDQo+IFRoZSB2ZW5kb3IgZHJpdmVyIHY1LjguNi4yXzM1NTM4LjIwMTkxMDI4X0NPRVgy
MDE5MDkxMC0wZDAyIGZyb20NCj4gaHR0cHM6Ly9naXRodWIuY29tL0JyaWdodFgvcnRsODE5MmZ1
IHdhcyB1c2VkIGFzIHJlZmVyZW5jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvS2NvbmZpZyB8ICAgIDMgKy0NCg0KSXQgc2VlbXMgbGlr
ZSB5b3UgZm9yZ2V0IHRvIGFkZCBydGw4eHh4dV84MTkyZi5vIHRvIE1ha2VmaWxlLg0KDQo+ICAu
Li4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaCAgfCAgIDQ3ICsNCj4g
IC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMgICAgICAgICB8ICAgIDMgKy0N
Cj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJmLmMgICAgICAgICB8IDIwODEg
KysrKysrKysrKysrKysrKysNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzg3MTBi
LmMgICAgICAgICB8ICAgIDEgKw0KPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcy
M2IuYyAgICAgICAgIHwgICAgMSArDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV9jb3JlLmMgfCAgMTA0ICstDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9ydGw4eHh4dV9yZWdzLmggfCAgIDE1ICsNCj4gIDggZmlsZXMgY2hhbmdlZCwgMjIyNSBpbnNl
cnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJmLmMNCj4gDQoNCnNt
YXRjaCByZXBvcnRzIHR3byB3YXJuaW5ncyB0aGF0IGNhbiBiZSBmaXhlZCBieSBnaXZpbmcgaW5p
dGlhbCB2YWx1ZXM6IA0KDQpkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1XzgxOTJmLmM6NTc3IHJ0bDgxOTJmdV9jb25maWdfa2ZyZWUoKSBlcnJvcjogdW5pbml0
aWFsaXplZCBzeW1ib2wgJ2NoYW5uZWxfaWR4Jy4NCmRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE5MmYuYzoyMDI3IHJ0bDgxOTJmdV9sZWRfYnJpZ2h0bmVz
c19zZXQoKSBlcnJvcjogdW5pbml0aWFsaXplZCBzeW1ib2wgJ2xlZGNmZycuDQoNCg0KSSBoYXZl
IG5vdCByZXZpZXdlZCB0aGlzIHBhdGNoIGVudGlyZWx5LCBhbmQgd2lsbCBjb250aW51ZSBpbiBh
IGZldyBkYXlzLg0KSnVzdCBsZXQgeW91IGtub3cgdGhlc2UgcHJvYmxlbXMgYWhlYWQuIA0KDQpQ
aW5nLUtlDQoNCg==
