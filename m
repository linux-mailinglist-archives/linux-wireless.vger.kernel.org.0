Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5466740799
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjF1BaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 21:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjF1BaV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 21:30:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEFAF2973
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 18:30:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35S1ToJxA007814, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35S1ToJxA007814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Jun 2023 09:29:50 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 28 Jun 2023 09:29:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Jun 2023 09:29:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 28 Jun 2023 09:29:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     James <bjlockie@lockie.ca>, Giulio Paci <giuliopaci@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8822ce connection is very unstable
Thread-Topic: Realtek 8822ce connection is very unstable
Thread-Index: AQHZqQnme5lXUSoFX0KxvKzAZ70xJa+eSecAgAACcoCAACRSgIAA+I6A
Date:   Wed, 28 Jun 2023 01:29:50 +0000
Message-ID: <b3c5f2f05d0844dfb4e9f7e943b4cbbd@realtek.com>
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
 <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
 <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
 <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca>
In-Reply-To: <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgPGJqbG9ja2ll
QGxvY2tpZS5jYT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI4LCAyMDIzIDI6MjMgQU0NCj4g
VG86IEdpdWxpbyBQYWNpIDxnaXVsaW9wYWNpQGdtYWlsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogUmVhbHRlayA4ODIyY2UgY29ubmVj
dGlvbiBpcyB2ZXJ5IHVuc3RhYmxlDQo+IA0KPiBKdW4uIDI3LCAyMDIzIDEyOjEzOjQ4IEdpdWxp
byBQYWNpIDxnaXVsaW9wYWNpQGdtYWlsLmNvbT46DQo+IA0KPiA+IE9uIFR1ZSwgSnVuIDI3LCAy
MDIzIGF0IDY6MDTigK9QTSBKYW1lcyA8Ympsb2NraWVAbG9ja2llLmNhPiB3cm90ZToNCj4gPj4g
SSB3b3VsZCB0cnkgYSBkaWZmZXJlbnQgZGlzdHJvLg0KPiA+DQo+ID4gQW55IGRldGFpbCBhYm91
dCB3aHkgeW91IHdvdWxkIHRyeSBhIGRpZmZlcmVudCBkaXN0cm8gYW5kIGhvdyBtdWNoDQo+ID4g
c2hvdWxkIHRoZXkgZGlmZmVyPw0KPiA+DQo+ID4gQWN0dWFsbHkgd2hlbiBJIHRyaWVkIERlYmlh
biBCdWxsc2V5ZSB3aWZpIHNlZW1lZCBtb3JlIHN0YWJsZQ0KPiA+IChhbHRob3VnaCBJIGRpZCBu
b3QgdXNlIHRoYXQgc3lzdGVtIGxvbmcgZW5vdWdoIHRvIGJlIHN1cmUgdGhhdCBpdCB3YXMNCj4g
PiB3b3JraW5nIHdpdGhvdXQgaXNzdWVzKSwgYnV0IHRvdWNocGFkIHdhcyBub3Qgc3VwcG9ydGVk
IGJ5IHRoYXQNCj4gPiBzeXN0ZW0uDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSBhbnkgc3BlY2lmaWMg
c3VnZ2VzdGlvbj8NCj4gSnVzdCBzb21ldGhpbmcgdG8gdHJ5Lg0KPiBJIGhhdmUgbm8gaWRlYXMu
DQo+IA0KDQpUcnkgYmVsb3cgb3B0aW9ucyB0byBzZWUgaWYgdGhleSBjYW4gaGVscDogDQoNCjEu
IHRyeSBhbm90aGVyIGJhbmQgKHN3aXRjaCBmcm9tIDJHSHogdG8gNUdIeiBvciBvcHBvc2l0ZSkN
CjIuIHRyeSBhbm90aGVyIEFQDQozLiBkaXNhYmxlIFdpRmkgcG93ZXIgc2F2ZSBieQ0KICAgcnR3
ODhfY29yZS5rbyBkaXNhYmxlX2xwc19kZWVwPTENCiAgIG9yIA0KICAgaXcgd2xhbjAgc2V0IHBv
d2VyX3NhdmUgb2ZmDQoNCg0KQnkgdGhlIHdheSwgd2hlbiB5b3UgdHJ5IGRpc2FibGVfYXNwbT0x
IGFuZCBkaXNhYmxlX21zaT0xLCBJIHN1Z2dlc3QgdG8NCmNyZWF0ZSBhIGZpbGUgYW5kIGFkZCB0
aGVtIHRvIC9ldGMvbW9kcHJvYmUuZC8sIGFuZCB0aGVuIHNodXRkb3duIGFuZCB0dXJuIG9uDQp5
b3VyIGNvbXB1dGVyIGFmdGVyIGEgd2hpbGUuIEJlY2F1c2Ugc29tZSBQQ0kgc2V0dGluZ3MgYXJl
IHBlcnNpc3RlbnQgaWYgb25seQ0KZG8gcm1tb2QvaW5zbW9kLiANCg0KDQoNCg==
