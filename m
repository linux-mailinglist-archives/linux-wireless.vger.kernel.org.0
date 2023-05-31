Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022C0717263
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 02:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjEaA0W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 20:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEaA0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 20:26:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DD9F3
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 17:26:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34V0PQCl8032547, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34V0PQCl8032547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 31 May 2023 08:25:27 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 31 May 2023 08:25:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 31 May 2023 08:25:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 31 May 2023 08:25:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
Subject: RE: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and RTX_POWER_AFTER_IQK_A reads
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and
 RTX_POWER_AFTER_IQK_A reads
Thread-Index: AQHZkxBmPVoxZYMjUEiVPr+B6yKXPa9yj+sAgAAMRgCAAAgdAIAA4Yuw
Date:   Wed, 31 May 2023 00:25:39 +0000
Message-ID: <c861d21d606441c9bf40ff963090d098@realtek.com>
References: <20230530155446.555091-1-dmantipov@yandex.ru>
 <b747b45e-e176-4c55-0886-abfcb1e33717@lwfinger.net>
 <09191d90-c29d-bdf5-4192-19553f8911fd@yandex.ru>
 <bee18794-8c4a-2af9-cf1c-807969be3dd2@lwfinger.net>
In-Reply-To: <bee18794-8c4a-2af9-cf1c-807969be3dd2@lwfinger.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IFdlZG5lc2RheSwgTWF5IDMxLCAyMDIzIDI6NTUgQU0NCj4gVG86IERtaXRyeSBBbnRpcG92IDxk
bWFudGlwb3ZAeWFuZGV4LnJ1PjsgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+
IENjOiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnOyBsdmMtcHJvamVjdEBsaW51eHRlc3Rpbmcub3JnOyBEbWl0cml5DQo+IEFudGlw
b3YgPERtaXRyaXkuQW50aXBvdkBzb2Z0bGluZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHJ0bHdpZmk6IHJ0bDgxODhlZTogZHJvcCBSVFhfUE9XRVJfQkVGT1JFX0lRS19BIGFuZCBSVFhf
UE9XRVJfQUZURVJfSVFLX0EgcmVhZHMNCj4gDQo+IE9uIDUvMzAvMjMgMTM6MjYsIERtaXRyeSBB
bnRpcG92IHdyb3RlOg0KPiA+IE9uIDUvMzAvMjMgMjA6NDIsIExhcnJ5IEZpbmdlciB3cm90ZToN
Cj4gPg0KPiA+PiBJIGRvIG5vdCBrbm93IHRoZSBhbnN3ZXIgdG8gdGhpcyBxdWVzdGlvbiBlaXRo
ZXIsIGJ1dCBob3cgZG9lcw0KPiA+PiB5b3VyIHRvb2wga25vdyB0aGF0IHRoZSBzdGF0ZW1lbnRz
IGJldHdlZW4gdGhlIGZpcnN0IHJlYWQgYW5kDQo+ID4+IHRoZSBzZWNvbmQgaGF2ZSBub3QgY2F1
c2VkIHRoZSBmaXJtd2FyZSB0byBjaGFuZ2UgdGhlIGNvbnRlbnRzID4gb2YgdGhlIEJCDQo+ID4+
IHJlZ2lzdGVycz8NCj4gPg0KPiA+IFRoaXMgdG9vbCBpcyBhIHN0YXRpYyBhbmFseXNpcyBzb2Z0
d2FyZSBhbmQgaGFzIG5vIHNwZWNpYWwga25vd2xlZGdlDQo+ID4gYWJvdXQgYW55IHBhcnRpY3Vs
YXIgaGFyZHdhcmUuIFNvIEkgZG8gbm90IHN0cm9uZ2x5IGluc2lzdCBvbiB0aGlzDQo+ID4gY2hh
bmdlIHdoaWNoIHNob3VsZCBiZSB0cmVhdGVkIGFzIGEgc3ViamVjdCB0byBtb3JlIGRldGFpbGVk
IGNvbnNpZGVyYXRpb24uDQo+ID4NCj4gPiBJJ3ZlIG5vdGljZWQgNmM3NWVhYjA0MTdiOWU1YjA1
YTE4ZGJmYzM3M2UyN2E4ZWY4NzZkOCB3aGVyZSBydGxfZ2V0X2JicmVnKCkNCj4gPiBpcyBwcmVz
ZXJ2ZWQgYnV0IHRoZSByZXN1bHQgaXMgaWdub3JlZC4gV291bGQgdGhlIHNpbWlsYXIgdGhpbmcg
YmUgYSBraW5kDQo+ID4gb2YgYSBjbGVhbnVwIGZvciB0aGlzIGNhc2UgYXMgd2VsbD8NCj4gPg0K
PiANCj4gWWVzLCB5b3UgY291bGQgaWdub3JlIHRoZSBvdXRwdXQgZnJvbSBydGxfZ2V0X2JicmVn
KCkgZm9yIGxpbmVzIDE0ODQgYW5kIDE0ODUuDQo+IA0KDQpBbm90aGVyIHdheSBpcyB0byBhZGQg
YSBkZWJ1ZyBtZXNzYWdlIHRvIHNob3cgdGhlbSwgYW5kIHRoZW4gc3RhdGljIGNoZWNrZXINCnNo
b3VsZG4ndCB3YXJuIHRoaXMuIEFsc28sIHBlb3BsZSBjYW4gZGlhZ25vc2UgSVFLICYgTE9LIHJl
c3VsdHMgaWYgbmVlZGVkLiANCg0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGx3aWZpL3J0bDgxODhlZS9waHkuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydGx3aWZpL3J0bDgxODhlZS9waHkuYw0KQEAgLTE0NzksNiArMTQ3OSwxMCBAQCBzdGF0aWMg
dTggX3J0bDg4ZV9waHlfcGF0aF9hX3J4X2lxayhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgYm9v
bCBjb25maWdfcGF0aGIpDQogICAgICAgIHJlZ19lOWMgPSBydGxfZ2V0X2JicmVnKGh3LCBSVFhf
UE9XRVJfQUZURVJfSVFLX0EsIE1BU0tEV09SRCk7DQogICAgICAgIHJlZ19lYTQgPSBydGxfZ2V0
X2JicmVnKGh3LCBSUlhfUE9XRVJfQkVGT1JFX0lRS19BXzIsIE1BU0tEV09SRCk7DQoNCisgICAg
ICAgcnRsX2RiZyhydGxwcml2LCBDT01QX0lRSywgREJHX0xPVUQsDQorICAgICAgICAgICAgICAg
IlBhdGggQSBSeCBMT0sgJiBJUUsgcmVzdWx0cyAweGVhYz0weCV4IDB4ZTk0PTB4JXggMHhlOWM9
MHgleCAweGVhND0weCV4XG4iLA0KKyAgICAgICAgICAgICAgIHJlZ19lYWMsIHJlZ19lOTQsIHJl
Z19lOWMsIHJlZ19lYTQpOw0KKw0KICAgICAgICBpZiAoIShyZWdfZWFjICYgQklUKDI3KSkgJiYN
CiAgICAgICAgICAgICgoKHJlZ19lYTQgJiAweDAzRkYwMDAwKSA+PiAxNikgIT0gMHgxMzIpICYm
DQogICAgICAgICAgICAoKChyZWdfZWFjICYgMHgwM0ZGMDAwMCkgPj4gMTYpICE9IDB4MzYpKQ0K
DQpQaW5nLUtlDQoNCg==
