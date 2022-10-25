Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2E60C168
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 03:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiJYBux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 21:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiJYBue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 21:50:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5152A152C43
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 18:47:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P1kVID1005347, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P1kVID1005347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 09:46:31 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Oct 2022 09:46:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Oct 2022 09:46:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Tue, 25 Oct 2022 09:46:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
Thread-Topic: [PATCH v2 4/5] wifi: rtl8xxxu: Set
 IEEE80211_HW_SUPPORT_FAST_XMIT
Thread-Index: AQHY5/kn5zZsMp3s8US9g/BfIsrgkK4eV0rg
Date:   Tue, 25 Oct 2022 01:46:46 +0000
Message-ID: <1f8cf2da341f4629a178fce38e53bf17@realtek.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
 <0dd519e3-45f7-de43-3e09-29c3d63af1f8@gmail.com>
In-Reply-To: <0dd519e3-45f7-de43-3e09-29c3d63af1f8@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI0IOS4i+WNiCAxMToyMzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUs
IDIwMjIgNDo1OCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiA0LzVdIHdpZmk6IHJ0bDh4eHh1OiBTZXQgSUVFRTgwMjExX0hXX1NVUFBPUlRfRkFTVF9Y
TUlUDQo+IA0KPiBBY2NvcmRpbmcgdG8gY29tbWl0IDYwZDc5MDBkY2I5OCAoIndsY29yZTogZW5h
YmxlDQo+IElFRUU4MDIxMV9IV19TVVBQT1JUX0ZBU1RfWE1JVCIpLCB3ZSBjYW4gdXNlIHRoaXMg
YmVjYXVzZSBhbGwgdGhlIGNoaXBzDQo+IGhhdmUgaGFyZHdhcmUgcmF0ZSBjb250cm9sLg0KPiAN
Cj4gVGhpcyBpcyBvbmUgb2YgdGhlIHRoaW5ncyBtYWM4MDIxMSByZXF1aXJlcyBiZWZvcmUgaXQg
d2lsbCBoYW5kbGUgTVNEVQ0KPiBhZ2dyZWdhdGlvbiBmb3IgdXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiB2MjoN
Cj4gIC0gTm8gY2hhbmdlLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDdjNTg3YjVkNTU0ZS4uOGJhYjcy
NDc0NjBkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtNzAwNSw2ICs3MDA1LDcgQEAgc3RhdGlj
IGludCBydGw4eHh4dV9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZXJmYWNlLA0KPiAg
CSAqIFRoZSBmaXJtd2FyZSBoYW5kbGVzIHJhdGUgY29udHJvbA0KPiAgCSAqLw0KPiAgCWllZWU4
MDIxMV9od19zZXQoaHcsIEhBU19SQVRFX0NPTlRST0wpOw0KPiArCWllZWU4MDIxMV9od19zZXQo
aHcsIFNVUFBPUlRfRkFTVF9YTUlUKTsNCj4gIAlpZWVlODAyMTFfaHdfc2V0KGh3LCBBTVBEVV9B
R0dSRUdBVElPTik7DQo+IA0KPiAgCXdpcGh5X2V4dF9mZWF0dXJlX3NldChody0+d2lwaHksIE5M
ODAyMTFfRVhUX0ZFQVRVUkVfQ1FNX1JTU0lfTElTVCk7DQo+IC0tDQo+IDIuMzguMA0KPiANCj4g
LS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhp
cyBlLW1haWwuDQo=
