Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAC647F15
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 09:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLIIPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 03:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLIIPp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 03:15:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20B30F5AB
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 00:15:43 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B98EqEoA027728, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B98EqEoA027728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 16:14:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 9 Dec 2022 16:15:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Dec 2022 16:15:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 9 Dec 2022 16:15:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Fix assignment to bit field priv->cck_agc_report_type
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Fix assignment to bit field
 priv->cck_agc_report_type
Thread-Index: AQHZCzwLzlcfXo+M2UKmlR0PzI/maa5lNlEg
Date:   Fri, 9 Dec 2022 08:15:39 +0000
Message-ID: <620a128bf71b4161b85ee6e9a8d7761c@realtek.com>
References: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
 <7bb4858c-5cef-9cae-5e08-7e8444e8ba89@gmail.com>
In-Reply-To: <7bb4858c-5cef-9cae-5e08-7e8444e8ba89@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzkg5LiK5Y2IIDA3OjIzOjAw?=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgOSwg
MjAyMiAzOjM0IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSB3aWZpOiBydGw4eHh4dTog
Rml4IGFzc2lnbm1lbnQgdG8gYml0IGZpZWxkIHByaXYtPmNja19hZ2NfcmVwb3J0X3R5cGUNCj4g
DQo+IEp1c3QgYmVjYXVzZSBwcml2LT5jY2tfYWdjX3JlcG9ydF90eXBlIGlzIG9ubHkgb25lIGJp
dCBkb2Vzbid0IG1lYW4NCj4gaXQgd29ya3MgbGlrZSBhIGJvb2wuIFRoZSB2YWx1ZSBhc3NpZ25l
ZCB0byBpdCBsb3NlcyBhbGwgYml0cyBleGNlcHQNCj4gYml0IDAsIHNvIG9ubHkgYXNzaWduIDAg
b3IgMSB0byBpdC4NCj4gDQo+IFRoaXMgYWZmZWN0cyB0aGUgUlRMODE5MkVVLCBidXQgcnRsOHh4
eHUgYWxyZWFkeSBjYW4ndCBjb25uZWN0IHRvIGFueQ0KPiBuZXR3b3JrcyB3aXRoIHRoaXMgY2hp
cCwgc28gaXQgcHJvYmFibHkgZGlkbid0IGJvdGhlciBhbnlvbmUuDQo+IA0KPiBGaXhlczogMmFk
MmE4MTNiODAzICgid2lmaTogcnRsOHh4eHU6IEZpeCB0aGUgQ0NLIFJTU0kgY2FsY3VsYXRpb24i
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4
dV9jb3JlLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDNlZDQzNTQwMWU1Ny4u
Nzk5YjAzZWMxOTgwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtNDIwOCwxMCArNDIwOCwxMiBA
QCBzdGF0aWMgaW50IHJ0bDh4eHh1X2luaXRfZGV2aWNlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
KQ0KPiAgCQkgKiBzaG91bGQgYmUgZXF1YWwgb3IgQ0NLIFJTU0kgcmVwb3J0IG1heSBiZSBpbmNv
cnJlY3QNCj4gIAkJICovDQo+ICAJCXZhbDMyID0gcnRsOHh4eHVfcmVhZDMyKHByaXYsIFJFR19G
UEdBMF9YQV9IU1NJX1BBUk0yKTsNCj4gLQkJcHJpdi0+Y2NrX2FnY19yZXBvcnRfdHlwZSA9IHZh
bDMyICYgRlBHQTBfSFNTSV9QQVJNMl9DQ0tfSElHSF9QV1I7DQo+ICsJCXByaXYtPmNja19hZ2Nf
cmVwb3J0X3R5cGUgPQ0KPiArCQkJdTMyX2dldF9iaXRzKHZhbDMyLCBGUEdBMF9IU1NJX1BBUk0y
X0NDS19ISUdIX1BXUik7DQo+IA0KPiAgCQl2YWwzMiA9IHJ0bDh4eHh1X3JlYWQzMihwcml2LCBS
RUdfRlBHQTBfWEJfSFNTSV9QQVJNMik7DQo+IC0JCWlmIChwcml2LT5jY2tfYWdjX3JlcG9ydF90
eXBlICE9IChib29sKSh2YWwzMiAmIEZQR0EwX0hTU0lfUEFSTTJfQ0NLX0hJR0hfUFdSKSkgew0K
PiArCQlpZiAocHJpdi0+Y2NrX2FnY19yZXBvcnRfdHlwZSAhPQ0KPiArCQkgICAgdTMyX2dldF9i
aXRzKHZhbDMyLCBGUEdBMF9IU1NJX1BBUk0yX0NDS19ISUdIX1BXUikpIHsNCj4gIAkJCWlmIChw
cml2LT5jY2tfYWdjX3JlcG9ydF90eXBlKQ0KPiAgCQkJCXZhbDMyIHw9IEZQR0EwX0hTU0lfUEFS
TTJfQ0NLX0hJR0hfUFdSOw0KPiAgCQkJZWxzZQ0KPiAtLQ0KPiAyLjM4LjANCj4gDQo+IC0tLS0t
LVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1t
YWlsLg0K
