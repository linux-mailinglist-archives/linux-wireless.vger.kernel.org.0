Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA87559BC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 04:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQCpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 22:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 22:45:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 751C4197
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 19:45:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36H2j25R1012846, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36H2j25R1012846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 17 Jul 2023 10:45:02 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Jul 2023 10:45:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 17 Jul 2023 10:45:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 17 Jul 2023 10:45:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/4] wifi: rtl8xxxu: Enable AP mode for RTL8192FU
Thread-Topic: [PATCH 1/4] wifi: rtl8xxxu: Enable AP mode for RTL8192FU
Thread-Index: AQHZs3HlTTStybLmx0CQCoc8GJ76/K+9SjBg
Date:   Mon, 17 Jul 2023 02:45:10 +0000
Message-ID: <88026c906c8c4b12a7524c93bc25c850@realtek.com>
References: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
In-Reply-To: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTEsIDIw
MjMgNTowMyBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBK
ZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvNF0gd2lmaTogcnRsOHh4eHU6IEVu
YWJsZSBBUCBtb2RlIGZvciBSVEw4MTkyRlUNCj4gDQo+IFRoZW9yZXRpY2FsbHkgdGhpcyBjaGlw
IGNhbiBoYW5kbGUgMTI3IGNsaWVudHMuDQo+IA0KPiBUZXN0ZWQgb25seSB2ZXJ5IGJyaWVmbHkg
YnV0IGl0IHNob3VsZCB3b3JrIGFzIHdlbGwgYXMgdGhlIFJUTDgxODhGVS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpX
aXRoIHlvdXIgcG9zaXRpdmUgcmVzdWx0cywgaXQgc2hvdWxkIGJlIGdvb2QgdG8gaGF2ZSB0aGlz
IHBhdGNoc2V0LCBzbw0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1XzgxOTJmLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV84MTkyZi5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dV84MTkyZi5jDQo+IGluZGV4IDE4ZGM1MjIxYTljMC4uMjhlOTM4MzVl
MDVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1XzgxOTJmLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dV84MTkyZi5jDQo+IEBAIC0yMDc5LDYgKzIwNzksOCBAQCBzdHJ1Y3Qg
cnRsOHh4eHVfZmlsZW9wcyBydGw4MTkyZnVfZm9wcyA9IHsNCj4gICAgICAgICAuYW1wZHVfbWF4
X3RpbWUgPSAweDVlLA0KPiAgICAgICAgIC51c3RpbWVfdHNmX2VkY2EgPSAweDUwLA0KPiAgICAg
ICAgIC5tYXhfYWdncl9udW0gPSAweDFmMWYsDQo+ICsgICAgICAgLnN1cHBvcnRzX2FwID0gMSwN
Cj4gKyAgICAgICAubWF4X21hY2lkX251bSA9IDEyOCwNCj4gICAgICAgICAudHJ4ZmZfYm91bmRh
cnkgPSAweDNmM2YsDQo+ICAgICAgICAgLnBicF9yeCA9IFBCUF9QQUdFX1NJWkVfMjU2LA0KPiAg
ICAgICAgIC5wYnBfdHggPSBQQlBfUEFHRV9TSVpFXzI1NiwNCj4gLS0NCj4gMi40MS4wDQo+IA0K
PiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0
aGlzIGUtbWFpbC4NCg==
