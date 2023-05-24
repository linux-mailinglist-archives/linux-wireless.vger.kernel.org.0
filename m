Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27270EA76
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 02:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjEXAvP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 20:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEXAvO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 20:51:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25693B5
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 17:51:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34O0ota47016203, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34O0ota47016203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 08:50:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 24 May 2023 08:51:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 24 May 2023 08:51:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 24 May 2023 08:51:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Josh Boyer <jwboyer@kernel.org>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: pull request: rtw89: 8851b: add firmware v0.29.41.0
Thread-Topic: pull request: rtw89: 8851b: add firmware v0.29.41.0
Thread-Index: AQHZiheWm13H01Q550C4n/FZaKrda69nl7GAgAEGt2A=
Date:   Wed, 24 May 2023 00:51:05 +0000
Message-ID: <2812aa25ef7a4a36b946eda7052c5e9a@realtek.com>
References: <35e79df26e17bd38bfb074b71df47f40277b7510.camel@realtek.com>
 <CA+5PVA7GuP-uf_UfE1wQk_a6N=HrMqnvycePxdewirJFcdU78g@mail.gmail.com>
In-Reply-To: <CA+5PVA7GuP-uf_UfE1wQk_a6N=HrMqnvycePxdewirJFcdU78g@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvc2ggQm95ZXIgPGp3Ym95
ZXJAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjQsIDIwMjMgMTowNyBBTQ0K
PiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC1maXJt
d2FyZUBrZXJuZWwub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IHB1bGwgcmVxdWVzdDogcnR3ODk6IDg4NTFiOiBhZGQgZmlybXdhcmUgdjAuMjkuNDEu
MA0KPiANCj4gT24gRnJpLCBNYXkgMTksIDIwMjMgYXQgMjowM+KAr0FNIFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFBpbmctS2UgU2hpaCAoMSk6DQo+
ID4gICAgICAgcnR3ODk6IDg4NTFiOiBhZGQgZmlybXdhcmUgdjAuMjkuNDEuMA0KPiANCj4gVGhp
cyBpcyBtaXNzaW5nIGFuIGVudHJ5IGluIFdIRU5DRS4gIENhbiB5b3UgZml4IHRoYXQgdXA/DQo+
IA0KPiBbandib3llckB2YWRlciBsaW51eC1maXJtd2FyZV0kIC4vY2hlY2tfd2hlbmNlLnB5DQo+
IEU6IHJ0dzg5L3J0dzg4NTFiX2Z3LmJpbiBub3QgbGlzdGVkIGluIFdIRU5DRQ0KPiBbandib3ll
ckB2YWRlciBsaW51eC1maXJtd2FyZV0kDQo+IA0KDQpJIGhhdmUgYWRkZWQgdGhpcyBjaGVja2lu
ZyBpbnRvIG15IGxvY2FsIHNjcmlwdCwgc28gSSB3aWxsIG5vdCBtaXNzIGl0IGluDQp0aGUgZnV0
dXJlLiBTb3JyeSBmb3IgdGhlIG1pc3Rha2VzLiANCg0KQWxzbywgSSBoYXZlIHNlbnQgdjIgcHVs
bC1yZXF1ZXN0LiANCg0KVGhhbmsgeW91DQpQaW5nLUtlDQoNCg==
