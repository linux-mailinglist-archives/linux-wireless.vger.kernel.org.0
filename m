Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFE719C2A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjFAMbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjFAMbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 08:31:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE7119
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 05:30:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 351CUZfkC009891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 351CUZfkC009891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 20:30:35 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 1 Jun 2023 20:30:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 1 Jun 2023 20:30:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 20:30:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A reads as unused
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A
 reads as unused
Thread-Index: AQHZlHctas6Xg5gTu0Cgi8yJ5JAmc691Wq+A
Date:   Thu, 1 Jun 2023 12:30:48 +0000
Message-ID: <3b92f9205003f44187f7ebf7add6c3e0626e9646.camel@realtek.com>
References: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
         <20230601105215.27013-1-dmantipov@yandex.ru>
In-Reply-To: <20230601105215.27013-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.22.87]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <955F7AD51F5D3A458A7210F8457C6B96@realtek.com>
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

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDEzOjUyICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gDQo+IEFjY29yZGluZyB0byBQaW5nLUtlIFNoaWgsIGl0IG1heSBiZSB1bnNhZmUgdG8gcmVt
b3ZlIEJCIHJlZ2lzdGVyIHJlYWRzDQo+IGV2ZW4gaWYgd2UgZG9uJ3QgaW50ZXJlc3RlZCBpbiB0
aGVpciB2YWx1ZXMuIE9UT0ggc3VjaCBhIHJlYWRzIG1heSBjb25mdXNlDQo+IGNvbXBpbGVycyAo
d2hlbiB0aGUgbW9zdCBzdHJpY3RuZXNzIHdhcm5pbmcgb3B0aW9ucyBhcmUgZW5hYmxlZCkgYW5k
L29yDQo+IHN0YXRpYyBhbmFseXNpcyB0b29scy4gU28gaXQgbWF5IGJlIGhlbHBmdWwgdG8gY29u
dmVydCByZWxhdGVkIGNhbGxzIG9mDQo+ICdydGxfZ2V0X2JicmVnKCknIHRvICd2b2lkJyBhbmQg
bWFyayBzdWNoIGEgY2FzZXMgd2l0aCBzcGVjaWFsIGNvbW1lbnQNCj4ganVzdCB0byBtYWtlIHRo
ZW0gZWFzaWVyIHRvIGZpbmQgYW5kIG1heWJlIGV2ZW4gZml4IGluIHRoZSBmdXR1cmUuDQo+IA0K
PiBUaGlzIGlzIGdlbmVyYWxseSBpbnNwaXJlZCBieSA2Yzc1ZWFiMDQxN2I5ZTViMDVhMThkYmZj
MzczZTI3YThlZjg3NmQ4Lg0KDQpOb3JtYWxseSwgbWVudGlvbiBhIGNvbW1pdCBieSBgY29tbWl0
IDwxMiBkaWdpdHMgU0hBMT4gKCJzdWJqZWN0IilgDQoNCj4gDQo+IFN1Z2dlc3RlZC1ieTogUGlu
Zy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBB
bnRpcG92IDxkbWFudGlwb3ZAeWFuZGV4LnJ1Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTg4ZWUvcGh5LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxODhlZS9waHkuYw0K
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTg4ZWUvcGh5LmMN
Cj4gaW5kZXggMTJkMGIzYTg3YWY3Li44NTZjNjI2Y2M5OWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTg4ZWUvcGh5LmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxODhlZS9waHkuYw0KPiBA
QCAtMTQ3NSw4ICsxNDc1LDggQEAgc3RhdGljIHU4IF9ydGw4OGVfcGh5X3BhdGhfYV9yeF9pcWso
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIGJvb2wNCj4gY29uZmlnX3BhdGhiKQ0KPiAgICAgICAg
IG1kZWxheShJUUtfREVMQVlfVElNRSk7DQo+IA0KPiAgICAgICAgIHJlZ19lYWMgPSBydGxfZ2V0
X2JicmVnKGh3LCBSUlhfUE9XRVJfQUZURVJfSVFLX0FfMiwgTUFTS0RXT1JEKTsNCj4gLSAgICAg
ICByZWdfZTk0ID0gcnRsX2dldF9iYnJlZyhodywgUlRYX1BPV0VSX0JFRk9SRV9JUUtfQSwgTUFT
S0RXT1JEKTsNCj4gLSAgICAgICByZWdfZTljID0gcnRsX2dldF9iYnJlZyhodywgUlRYX1BPV0VS
X0FGVEVSX0lRS19BLCBNQVNLRFdPUkQpOw0KPiArICAgICAgIC8qIHVudXNlZCAqLyAodm9pZCly
dGxfZ2V0X2JicmVnKGh3LCBSVFhfUE9XRVJfQkVGT1JFX0lRS19BLCBNQVNLRFdPUkQpOw0KPiAr
ICAgICAgIC8qIHVudXNlZCAqLyAodm9pZClydGxfZ2V0X2JicmVnKGh3LCBSVFhfUE9XRVJfQUZU
RVJfSVFLX0EsIE1BU0tEV09SRCk7DQoNCldoeSBub3QganVzdA0KDQpydGxfZ2V0X2JicmVnKGh3
LCBSVFhfUE9XRVJfQkVGT1JFX0lRS19BLCBNQVNLRFdPUkQpOw0KcnRsX2dldF9iYnJlZyhodywg
UlRYX1BPV0VSX0FGVEVSX0lRS19BLCBNQVNLRFdPUkQpOw0KDQoNCj4gICAgICAgICByZWdfZWE0
ID0gcnRsX2dldF9iYnJlZyhodywgUlJYX1BPV0VSX0JFRk9SRV9JUUtfQV8yLCBNQVNLRFdPUkQp
Ow0KPiANCj4gICAgICAgICBpZiAoIShyZWdfZWFjICYgQklUKDI3KSkgJiYNCj4gLS0NCj4gMi40
MC4xDQo+IA0K
