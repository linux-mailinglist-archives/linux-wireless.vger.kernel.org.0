Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DB77B8E5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHNMpI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjHNMoi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 08:44:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A935E5B
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 05:44:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37ECiDX41031223, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37ECiDX41031223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 20:44:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 14 Aug 2023 20:44:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 14 Aug 2023 20:44:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 14 Aug 2023 20:44:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "emmanuel.mazurier@gmail.com" <emmanuel.mazurier@gmail.com>
Subject: Re: rtw89_8852ae : failed to recognize firmware elements
Thread-Topic: rtw89_8852ae : failed to recognize firmware elements
Thread-Index: AQHZzpU1V36L2dqrSEeM3aqDGrDKcK/pMAEAgAAGtAA=
Date:   Mon, 14 Aug 2023 12:44:30 +0000
Message-ID: <2c5dda769ab25b819128eafca8701870ffeee443.camel@realtek.com>
References: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
         <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
In-Reply-To: <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.65]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6953AB12B3B1848988671EA7A1A20B2@realtek.com>
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

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDEyOjIwICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIE1vbiwgMjAyMy0wOC0xNCBhdCAxMTo1MiArMDIwMCwgRW1tYW51ZWwgTWF6dXJpZXIgd3Jv
dGU6DQo+ID4gSGVsbG8sDQo+ID4gQWZ0ZXIgYSBEZWJpYW4gMTEgdXBkYXRlLCBuZXcgaGVhZGVy
IHdhcyBpbnN0YWxsZWQgOiA1LjEwLjAtMjQtYW1kNjQsDQo+ID4gYW5kIGFmdGVyIHVwZ3JhZGlu
ZyBydHc4OSBmaXJtd2FyZSwgdGhlIGRyaXZlciB3YXMgbm90IHJlY29nbml6ZWQgYnkNCj4gPiB0
aGUgc3lzdGVtLg0KPiA+IA0KPiA+IERtZXNnIGVycm9yIDoNCj4gPiBydHc4OWNvcmU6IGxvYWRp
bmcgb3V0LW9mLXRyZWUgbW9kdWxlIHRhaW50cyBrZXJuZWwuDQo+ID4gcnR3ODlfODg1MmFlIDAw
MDA6MDk6MDAuMDogbm90IG1mdyBmb3JtYXQNCj4gPiBydHc4OV84ODUyYWUgMDAwMDowOTowMC4w
OiBmYWlsZWQgdG8gcmVjb2duaXplIGZpcm13YXJlIGVsZW1lbnRzDQo+IA0KPiBXaXRoIHRoZXNl
IGVycm9ycywgaXQgc2VlbXMgbGlrZSB5b3UgaW5zdGFsbGVkIHRoZSBsYXRlc3Qgd2lyZWxlc3Mt
bmV4dCANCj4ga2VybmVsIChha2Ega2VybmVsIDYuNi1yYyksIGJ1dCB5b3VyIGZpcm13YXJlIGlz
IHRoZSBvbGRlc3QgZmlybXdhcmUNCj4gdGhhdCB3ZSB1c2VkIGl0IGluIGRldmVsb3BtZW50IHN0
YWdlLiANCj4gDQo+IFBsZWFzZSBwcm92aWRlIGJlbG93IGluZm9ybWF0aW9uIHRvIGRpYWdub3Nl
IHRoaXMgcHJvYmxlbS4NCj4gDQo+IDEuIGtlcm5lbCB2ZXJzaW9uIHlvdSBhcmUgdXNpbmcNCj4g
JCB1bmFtZSAtYSANCj4gDQo+IDIuIGZpcm13YXJlIHlvdSBhcmUgdXNpbmcNCj4gJCBscyAtYWwg
L2xpYi9maXJtd2FyZS9ydHc4OS9ydHc4ODUyYV9mdy5iaW4NCj4gJCBtZDVzdW0gL2xpYi9maXJt
d2FyZS9ydHc4OS9ydHc4ODUyYV9mdy5iaW4NCj4gDQo+ID4gcnR3ODlfODg1MmFlIDAwMDA6MDk6
MDAuMDogZmFpbGVkIHRvIHNldHVwIGNoaXAgaW5mb3JtYXRpb24NCj4gPiBydHc4OV84ODUyYWU6
IHByb2JlIG9mIDAwMDA6MDk6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMjINCj4gPiANCj4gPiBJ
IGhhdmUgaW5zdGFsbGVkIHRoZSBmaXJtd2FyZS1yZWFsdGVrIHBhY2thZ2UgdG9vLg0KPiA+IA0K
PiA+IERvIHlvdSBoYXZlIGFueSBpZGVhIGFib3V0IHRoZSBwcm9ibGVtID8gSSBjYW4ndCB1c2Ug
d2lmaSBmb3IgdGhlIG1vbWVudC4NCj4gDQo+IEEgcG9zc2libGUgZml4IGlzIHRvIHVwZGF0ZSBm
aXJtd2FyZSB0byB0aGUgbGF0ZXN0IHRoYXQgeW91IGNhbiBkb3dubG9hZA0KPiBpdCB2aWE6DQo+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Zpcm13YXJl
L2xpbnV4LWZpcm13YXJlLmdpdC90cmVlL3J0dzg5L3J0dzg4NTJhX2Z3LmJpbg0KPiANCj4gSSB3
aWxsIGFsc28gc2VuZCBhIHBhdGNoIHRvIGJlIGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCB0aGUg
b2xkIGZpcm13YXJlDQo+IGlmIHRoaXMgcHJvYmxlbSBpcyByZXNvbHZlZC4gDQo+IA0KDQpQbGVh
c2UgYWxzbyBjYXB0dXJlIGxvZyB3aGVuIGl0IGZhaWxlZCB0byBsb2FkIGZpcm13YXJlLCBhbmQg
c2VlIGlmIHRoZQ0KZmlybXdhcmUgdmVyc2lvbiBsaWtlOiANCg0KcnR3ODlfODg1MmFlIDAwMDA6
MDM6MDAuMDogbG9hZGVkIGZpcm13YXJlIHJ0dzg5L3J0dzg4NTJhX2Z3LmJpbg0KcnR3ODlfODg1
MmFlIDAwMDA6MDM6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMTAwIC0+IDAxMDMpDQpydHc4OV84
ODUyYWUgMDAwMDowMzowMC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuOS4xMi4yIChhNmEwYzQyNSks
IGNtZCB2ZXJzaW9uIDAsIHR5cGUgMQ0KcnR3ODlfODg1MmFlIDAwMDA6MDM6MDAuMDogbm90IG1m
dyBmb3JtYXQNCnJ0dzg5Xzg4NTJhZSAwMDAwOjAzOjAwLjA6IGZhaWxlZCB0byByZWNvZ25pemUg
ZmlybXdhcmUgZWxlbWVudHMNCnJ0dzg5Xzg4NTJhZSAwMDAwOjAzOjAwLjA6IGZhaWxlZCB0byBz
ZXR1cCBjaGlwIGluZm9ybWF0aW9uDQpydHc4OV84ODUyYWU6IHByb2JlIG9mIDAwMDA6MDM6MDAu
MCBmYWlsZWQgd2l0aCBlcnJvciAtMjINCg0KUGluZy1LZQ0KDQoNCg==
