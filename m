Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5267665106
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 02:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjAKBPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 20:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjAKBPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 20:15:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 082DD95A8
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 17:15:10 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30B1E8sL4002638, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30B1E8sL4002638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Jan 2023 09:14:08 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 11 Jan 2023 09:15:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 11 Jan 2023 09:15:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 11 Jan 2023 09:15:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Dump the efuse only for untested devices
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Dump the efuse only for untested
 devices
Thread-Index: AQHZJQovshUa5aNnqU2bOMLrCFaPOq6YaLug
Date:   Wed, 11 Jan 2023 01:15:05 +0000
Message-ID: <921780f430c04135b5615688ed1cf158@realtek.com>
References: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
 <d53fcf97-d6d2-3c75-14d5-97b58a5f3a6c@gmail.com>
In-Reply-To: <d53fcf97-d6d2-3c75-14d5-97b58a5f3a6c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTAg5LiL5Y2IIDExOjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDEwLCAy
MDIzIDExOjQzIFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSB3aWZpOiBydGw4eHh4dTog
RHVtcCB0aGUgZWZ1c2Ugb25seSBmb3IgdW50ZXN0ZWQgZGV2aWNlcw0KDQpGcm9tIHRoZSBjb250
ZW50IG9mIHRoaXMgcGF0Y2gsIEkgZG9uJ3Qga25vdyB3aHkgIm9ubHkgZm9yIHVudGVzdGVkIGRl
dmljZXMiLA0Kc28gSSBkaWcgdGhlIGNvZGUgYW5kIGZpbmQgcnRsOHh4eHVfZGVidWcgY291bGQg
YmUgY2hhbmdlZCBhdCB1c2JfcHJvYmUoKS4NCk5vdCBzdXJlIGlmIGl0IGlzIHdvcnRoIHRvIHdy
aXRlIGludG8gY29tbWl0IG1lc3NhZ2UsIGJ1dCBJIHRoaW5rIHRoaXMgaW5mb3JtYXRpb24NCmlz
IGhlbHBmdWwgZm9yIG90aGVyIHJldmlld2Vycy4NCg0KPiANCj4gSXQgYXBwZWFycyB0aGlzIHdh
cyB0aGUgaW50ZW50aW9uIGFsbCBhbG9uZywgYnV0IGNvbW1pdCAzMzA3ZDg0MDI0ZDINCj4gKCJy
dGw4eHh4dTogQWRkIGluaXRpYWwgY29kZSB0byBwYXJzZSBydGw4MTkyZXUgZWZ1c2UiKSBpbml0
aWFsaXNlZA0KPiBydGw4eHh4dV9kZWJ1ZyB3aXRoIFJUTDhYWFhVX0RFQlVHX0VGVVNFIGZvciBu
byBhcHBhcmVudCByZWFzb24sIHdoaWNoDQo+IG1hZGUgaXQgZHVtcCB0aGUgZWZ1c2UgZm9yIGFs
bCBkZXZpY2VzLCBldmVuIHRoZSB0ZXN0ZWQgb25lcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJp
dHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29y
ZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9j
b3JlLmMNCj4gaW5kZXggZDUyMTQzNWUxYzA3Li4wN2MzYWY1ZDAzNzQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29y
ZS5jDQo+IEBAIC0zNCw3ICszNCw3IEBADQo+IA0KPiAgI2RlZmluZSBEUklWRVJfTkFNRSAicnRs
OHh4eHUiDQo+IA0KPiAtaW50IHJ0bDh4eHh1X2RlYnVnID0gUlRMOFhYWFVfREVCVUdfRUZVU0U7
DQo+ICtpbnQgcnRsOHh4eHVfZGVidWc7DQo+ICBzdGF0aWMgYm9vbCBydGw4eHh4dV9odDQwXzJn
Ow0KPiAgc3RhdGljIGJvb2wgcnRsOHh4eHVfZG1hX2FnZ3JlZ2F0aW9uOw0KPiAgc3RhdGljIGlu
dCBydGw4eHh4dV9kbWFfYWdnX3RpbWVvdXQgPSAtMTsNCj4gLS0NCj4gMi4zOC4wDQo+IA0KPiAt
LS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlz
IGUtbWFpbC4NCg==
