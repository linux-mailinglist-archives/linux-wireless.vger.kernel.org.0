Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D736EC386
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDXCJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXCJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 22:09:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C94E4A
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 19:09:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O298Sa8023666, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O298Sa8023666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 10:09:08 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Apr 2023 10:09:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Apr 2023 10:09:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 24 Apr 2023 10:09:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Problems with HP BIOS
Thread-Topic: Problems with HP BIOS
Thread-Index: AQHZdTmFc3jqhBkxP0y9Edpl4eYmaa85tuyg
Date:   Mon, 24 Apr 2023 02:09:08 +0000
Message-ID: <7b5f33cb7c704e3696674a5cebe9dd8a@realtek.com>
References: <5c753c2b-ca3e-50d8-8829-9c350d35b9f5@lwfinger.net>
In-Reply-To: <5c753c2b-ca3e-50d8-8829-9c350d35b9f5@lwfinger.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IFN1bmRheSwgQXByaWwgMjMsIDIwMjMgMTI6NDMgQU0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUHJvYmxlbXMgd2l0aCBIUCBCSU9TDQo+IA0KPiBQ
aW5nLUtlLA0KPiANCj4gSW4gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5L2lzc3Vl
cy8yMjYsIHVzZXJzIHdpdGggYW4gSFAgNDUwIEc5IHdpdGggYW4NCj4gSW50ZWwgcHJvY2Vzc29y
IGFuZCBhbiBIUCA2NDUgRzkgd2l0aCBhbiBBTUQgQ1BVIHJlcG9ydCBwcm9ibGVtcyB0aGF0IHNl
ZW0gdG8gYmUNCj4gZnJvbSBQQ0kgYnVzIHBvd2VyIGhhbmRsaW5nLiBCb3RoIG1vZGVscyBoYXZl
IGFuIFJUVzg4NTJCRSB3aXJlbGVzcyBjYXJkLiBBZGRpbmcNCj4gYWxsIDMgb3B0aW9ucyBmb3Ig
cnR3ODlfcGNpIGRpZCBub3Qgc29sdmUgdGhlIHByb2JsZW0sIGJ1dCBtYXkgaGF2ZSBoZWxwZWQu
DQo+IA0KPiBUaGUgdXNlciB3aXRoIHRoZSBBTUQgQ1BVIGZvdW5kIGEgQklPUyBzZXR0aW5nIHRo
YXQgZGlzYWJsZXMgUENJIHBvd2VyIHNhdmluZw0KPiB0aGF0IHNlZW1zIHRvIGhlbHAgYSBsb3Qu
IEkgYW0gbm90IHN1cmUgd2hhdCB0byBkbyBhdCB0aGlzIHBvaW50LCBidXQgSSB3YW50ZWQNCj4g
dG8gYWxlcnQgeW91IHRvIHRoZSBwcm9ibGVtLg0KPiANCj4gU3VjaCBCSU9TIHByb2JsZW1zIGFw
cGVhciB0byBiZSBtb3N0IGNvbW1vbiB3aXRoIGxhdGUgbW9kZWwgSFAgYW5kIExlbm92byBsYXB0
b3BzLg0KPiANCg0KV2UgaGF2ZSBzaW1pbGFyIGZpeCByZWNlbnRseSwgYW5kIGhhdmUgc2VudCBh
IHBhdGNoOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyMzA0MjEw
MTUzNTcuMTM5NDAtMS1wa3NoaWhAcmVhbHRlay5jb20vVC8jdQ0KDQpDb3VsZCB5b3Ugb3IgdGhl
IHVzZXIgZ2l2ZSBpdCBhIHRyeT8NCg0KUGluZy1LZQ0KDQo=
