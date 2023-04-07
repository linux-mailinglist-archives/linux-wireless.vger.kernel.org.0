Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD46DA6DE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Apr 2023 03:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjDGBVZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 21:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbjDGBVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 21:21:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F607A27D
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 18:19:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3371IRSY0003555, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3371IRSY0003555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 7 Apr 2023 09:18:27 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 7 Apr 2023 09:18:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 7 Apr 2023 09:18:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 7 Apr 2023 09:18:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Thread-Topic: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Thread-Index: AQHZXOKJ+70+DZ6OK0SBvz9wvU5TVK8IFYoAgBRR6QCAArUgQA==
Date:   Fri, 7 Apr 2023 01:18:47 +0000
Message-ID: <2484265c91a5487d82604860457864e4@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
 <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
In-Reply-To: <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwg
NSwgMjAyMyAxMTozMSBQTQ0KPiBUbzogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQo+IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBL
YWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgUGluZy1LZSBTaGloDQo+IDxwa3NoaWhAcmVh
bHRlay5jb20+OyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXgu
ZGU+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggMDAvMTRdIHdpZmk6IHJ0bDh4eHh1OiBBZGQgQVAgbW9kZSBzdXBwb3J0IGZvciA4MTg4
Zg0KPiANCj4gQW0gMjMuMDMuMjMgdW0gMTg6MTIgc2NocmllYiBCaXR0ZXJibHVlIFNtaXRoOg0K
PiA+IE9uIDIyLzAzLzIwMjMgMTk6MTgsIE1hcnRpbiBLYWlzdHJhIHdyb3RlOg0KPiA+PiBUaGlz
IHNlcmllcyBpbnRlbmRzIHRvIGJyaW5nIEFQIG1vZGUgc3VwcG9ydCB0byB0aGUgcnRsOHh4eHUg
ZHJpdmVyLA0KPiA+PiBtb3JlIHNwZWNpZmljYWxseSBmb3IgdGhlIDgxODhmLCBiZWNhdXNlIHRo
aXMgaXMgdGhlIEhXIEkgaGF2ZS4NCj4gPj4gVGhlIHdvcmsgaXMgYmFzZWQgb24gdGhlIHZlbmRv
ciBkcml2ZXIgYXMgSSBkbyBub3QgaGF2ZSBhY2Nlc3MgdG8NCj4gPj4gZGF0YXNoZWV0cy4NCj4g
Pj4NCj4gPj4gVGhpcyBpcyBhbiBSRkMsIHNvIHRoYXQgdGhlcmUgY2FuIGJlIGEgZGlzY3Vzc2lv
biBmaXJzdCBiZWZvcmUNCj4gPj4gcG90ZW50aWFsbHkgaW1wbGVtZW50aW5nIHN1cHBvcnQgZm9y
IHRoZSBvdGhlciBjaGlwcyBpbiB0aGlzIGRyaXZlciwgaWYNCj4gPj4gcmVxdWlyZWQuDQo+ID4+
DQo+ID4NCj4gPiBIaSENCj4gPg0KPiA+IEkgcmFuIGludG8gc29tZSBwcm9ibGVtcyB3aGlsZSB0
ZXN0aW5nIHRoaXMuDQo+ID4NCj4gPiBGaXJzdCwgYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
aW4gcnRsOHh4eHVfY29uZmlnX2ZpbHRlcigpIHdoZW4NCj4gPiB0dXJuaW5nIG9uIHRoZSBBUC4g
cHJpdi0+dmlmIHdhcyBOVUxMOg0KPiA+DQo+ID4gICAgICAgaWYgKHByaXYtPnZpZi0+dHlwZSAh
PSBOTDgwMjExX0lGVFlQRV9BUCkgew0KPiA+DQo+ID4gSSBjaGFuZ2VkIGl0IGxpa2UgdGhpczoN
Cj4gPg0KPiA+ICAgICAgIGlmIChwcml2LT52aWYgJiYgcHJpdi0+dmlmLT50eXBlICE9IE5MODAy
MTFfSUZUWVBFX0FQKSB7DQo+ID4NCj4gPiBUaGVuIEkgd2FzIGFibGUgdG8gdHVybiBvbiB0aGUg
QVAgYW5kIGNvbm5lY3QgbXkgcGhvbmUgdG8gaXQuIEhvd2V2ZXIsDQo+ID4gdGhlIHN5c3RlbSBm
cm96ZSBhZnRlciBhIGZldyBzZWNvbmRzLiBJIGhhZCBgam91cm5hbGN0bCAtLWZvbGxvd2ANCj4g
PiBydW5uaW5nLiBUaGUgbGFzdCB0aGluZyBwcmludGVkIGJlZm9yZSB0aGUgc3lzdGVtIGZyb3pl
IHdhcyB0aGUgREhDUA0KPiA+IHN0dWZmIChkaXNjb3Zlciwgb2ZmZXIsIHJlcXVlc3QsIGFjayku
IFRoZSBwaG9uZSBzYWlkIGl0IHdhcyBjb25uZWN0ZWQsDQo+ID4gYnV0IHNwZWVkdGVzdC5uZXQg
ZGlkbid0IGhhdmUgdGltZSB0byBsb2FkIGJlZm9yZSB0aGUgZnJlZXplLg0KPiANCj4gSGkNCj4g
DQo+IEkgY291bGQgcmVwcm9kdWNlIGEgZnJvemVuIHN5c3RlbSB3aXRoIG15IGhvc3RhcGQgc2V0
dXAsIHRob3VnaCBpdA0KPiBkb2Vzbid0IGhhcHBlbiByZWxpYWJseSBhbmQgSSBkb24ndCBoYXZl
IGFuIGVycm9yIG1lc3NhZ2Ugd2hlbiBpdCBoYXBwZW5zLg0KPiANCj4gV2hhdCBJIGNhbiBzZWUg
b24gdGhlIG90aGVyIGhhbmQsIGFyZSBXQVJOSU5HIG1lc3NhZ2VzIHdoaWNoIGhhcHBlbg0KPiBz
b21ldGltZXMgaW4gaW5jbHVkZS9uZXQvbWFjODAyMTEuaDoyOTM2IChpZWVlODAyMTFfZ2V0X3R4
X3JhdGUoKSkuDQo+IFRoaXMgbWlnaHQgYmUgdW5yZWxhdGVkLCBJIGFtIG5vdCBzdXJlLg0KPiAN
Cj4gSXMgdGhpcyBmdW5jdGlvbiBldmVuIHN1cHBvc2VkIHRvIHdvcmsgaW4gY29tYmluYXRpb24g
d2l0aA0KPiBIQVNfUkFURV9DT05UUk9MIHNldD8gDQoNCkknbSBub3QgZmFtaWxpYXIgd2l0aCBy
YXRlIGNvbnRyb2wgb2YgbWFjODAyMTEsIHNvIEkgZGlkbid0IGhhdmUgY29tbWVudA0KYWJvdXQg
cmF0ZSBjb250cm9sIGFuZCBIQVNfUkFURV9DT05UUk9MIGJlZm9yZS4NCg0KU2ltcGx5IGNoZWNr
aW5nIHJhdGVfY29udHJvbF9nZXRfcmF0ZSgpIHRoYXQgaXMgdG8gZmlsbCBpbmZvLT5jb250cm9s
LnJhdGVzW10sDQpidXQgaXQgZG9lc24ndCBkbyBpdCBpZiBIQVNfUkFURV9DT05UUk9MIGlzIHNl
dDoNCg0KCWlmIChpZWVlODAyMTFfaHdfY2hlY2soJnNkYXRhLT5sb2NhbC0+aHcsIEhBU19SQVRF
X0NPTlRST0wpKQ0KCQlyZXR1cm47DQoNClNvLCBJIHRoaW5rIGl0IHdpbGwgbm90IHdvcmsgd2l0
aCBIQVNfUkFURV9DT05UUk9MIHNldC4gRm9ydHVuYXRlbHksDQpydGw4eHh4dSBvbmx5IHdvcmtz
IG9uIDIgR0h6IGJhbmQsIGFuZCBvbmx5IG1hbmFnZW1lbnQgZnJhbWVzIHVzZQ0KaW5mby0+Y29u
dHJvbC5yYXRlc1tdIHRvIGRlY2lkZSBUWCByYXRlLCBzbyBhbHdheXMgVFggbWFuYWdlbWVudCBm
cmFtZXMNCndpdGggMU0gQ0NLIHJhdGUgKGh3X3JhdGUgPSAwKSBpcyBmaW5lLg0KDQo+IEFsc28s
IHdoeSBhcmUgd2UgcHV0dGluZyByYXRlIGludG8gdHhkZXNjIGZvciBhbGwNCj4gcGFja2V0cyAo
aWUuIGFsc28gd2hlbiBVU0VfRFJJVkVSX1JBVEUgaXMgbm90IHNldCkgd2hlbiB0aGUgZmlybXdh
cmUNCj4gc2V0cyB0aGUgcmF0ZSBiYXNlZCBvbiB0aGUgcmF0ZV9tYXNrPw0KDQpDb25jZXB0dWFs
bHksIGlmIFVTRV9EUklWRVJfUkFURSBpcyBzZXQsIHJhdGUgaW5mbyBvZiB0eGRlc2MgaXMgYWRv
cHRlZC4NCk90aGVyd2lzZSwgcmF0ZSByZWdpc3RlciBjb250cm9sbGVkIGJ5IGZpcm13YXJlIGlz
IGFkb3B0ZWQuIFRoYXQgbWVhbnMNCmlmIFVTRV9EUklWRVJfUkFURSBpc24ndCBzZXQsIHJhdGUg
aW5mbyBvZiB0eGRlc2MgaXMgaWdub3JlZC4NCg0KcnRsOHh4eHVfdXBkYXRlX3JhdGVfbWFzaygp
IGlzIHRvIHRlbGwgZmlybXdhcmUgdGhlIGFsbCBzdXBwb3J0ZWQgcmF0ZSBtYXNrLA0KYW5kIGZp
cm13YXJlIGNob29zZSBwcm9wZXIgVFggYW5kIHJldHJ5IHJhdGUsIGFuZCBzZXQgdG8gcmVnaXN0
ZXIuDQoNClBpbmctS2UNCg0K
