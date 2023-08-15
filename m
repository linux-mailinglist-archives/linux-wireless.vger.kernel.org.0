Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4898177C476
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 02:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjHOAcj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjHOAcg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 20:32:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A716D1703
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 17:32:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37F0WCngC004811, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37F0WCngC004811
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Aug 2023 08:32:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 15 Aug 2023 08:31:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 15 Aug 2023 08:31:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 15 Aug 2023 08:31:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "emmanuel.mazurier@gmail.com" <emmanuel.mazurier@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: rtw89_8852ae : failed to recognize firmware elements
Thread-Topic: rtw89_8852ae : failed to recognize firmware elements
Thread-Index: AQHZzpU1V36L2dqrSEeM3aqDGrDKcK/pMAEAgAAjkoCAAKitAA==
Date:   Tue, 15 Aug 2023 00:31:32 +0000
Message-ID: <542c8efb431a4ad4b64c5d6be6a41d4e7cb61b56.camel@realtek.com>
References: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
         <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
         <CAOc87an-E=zmZcMhkaKTV7hmr4PagFq0weR=n3hzjJ9wENaPwg@mail.gmail.com>
In-Reply-To: <CAOc87an-E=zmZcMhkaKTV7hmr4PagFq0weR=n3hzjJ9wENaPwg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <025A58B3BC5B6A4BB9F32FA40F5BF9BD@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDE2OjI3ICswMjAwLCBFbW1hbnVlbCBNYXp1cmllciB3cm90
ZToNCj4gDQo+IA0KPiBIZXJlIGFyZSB0aGUgb3RoZXIgaW5mb21hdGlvbnMgKGJlZm9yZSB0aGUg
dXBkYXRlKSA6DQo+IA0KPiA+IFBsZWFzZSBwcm92aWRlIGJlbG93IGluZm9ybWF0aW9uIHRvIGRp
YWdub3NlIHRoaXMgcHJvYmxlbS4NCj4gPiANCj4gPiAxLiBrZXJuZWwgdmVyc2lvbiB5b3UgYXJl
IHVzaW5nDQo+ID4gJCB1bmFtZSAtYQ0KPiANCj4gTGludXggbWFudS1kZWJpYW4gNS4xMC4wLTI0
LWFtZDY0ICMxIFNNUCBEZWJpYW4gNS4xMC4xNzktNQ0KPiAoMjAyMy0wOC0wOCkgeDg2XzY0IEdO
VS9MaW51eA0KDQpTbywgeW91IGluc3RhbGxlZCBkcml2ZXIgZnJvbSBodHRwczovL2dpdGh1Yi5j
b20vbHdmaW5nZXIvcnR3ODkgPw0KDQoNCj4gPiAyLiBmaXJtd2FyZSB5b3UgYXJlIHVzaW5nDQo+
ID4gJCBscyAtYWwgL2xpYi9maXJtd2FyZS9ydHc4OS9ydHc4ODUyYV9mdy5iaW4NCj4gPiAkIG1k
NXN1bSAvbGliL2Zpcm13YXJlL3J0dzg5L3J0dzg4NTJhX2Z3LmJpbg0KPiANCj4gTm8gZmlsZSB3
YXMgZm91bmQNCj4gDQoNCg0KQ2FuIHlvdSByZXByb2R1Y2UgYmVsb3cgc3ltcHRvbSBhcyB5b3Vy
IGluaXRpYWwgcG9zdD8gSWYgc28sIHBsZWFzZSBzaGFyZQ0KZmlybXdhcmUgc2l6ZSBhbmQgaXRz
IG1kNXN1bS4gDQoNCiAgcnR3ODlfODg1MmFlIDAwMDA6MDk6MDAuMDogbm90IG1mdyBmb3JtYXQN
CiAgcnR3ODlfODg1MmFlIDAwMDA6MDk6MDAuMDogZmFpbGVkIHRvIHJlY29nbml6ZSBmaXJtd2Fy
ZSBlbGVtZW50cw0KDQpUaGVzZSBtZXNzYWdlcyB0b2xkIG1lIHRoYXQgYSBmaXJtd2FyZSBpcyBs
b2FkZWQgYnV0IGl0cyBmb3JtYXQgaXMgdW5leHBlY3RlZC4gDQpJIG1lYW4gaXQgc2hvdWxkIG5v
dCBubyBmaWxlIGV4aXN0cy4gDQoNClBpbmctS2UNCg0KDQo=
