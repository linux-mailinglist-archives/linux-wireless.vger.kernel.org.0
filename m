Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECA86384EF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 09:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKYIEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 03:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKYIEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 03:04:48 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8BF0218AC
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 00:04:47 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AP840Cg8018856, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AP840Cg8018856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Nov 2022 16:04:00 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 25 Nov 2022 16:04:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Nov 2022 16:04:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 25 Nov 2022 16:04:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Index: AQHY/4LYAwFnH2Rc4ECh6z0I+CxFRa5PSOhw
Date:   Fri, 25 Nov 2022 08:04:43 +0000
Message-ID: <5992feea33944726b62d63951f118e7e@realtek.com>
References: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
In-Reply-To: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI1IOS4iuWNiCAwNjowMDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAy
NCwgMjAyMiA1OjMxIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSB3aWZpOiBydGw4eHh4
dTogRml4IHRoZSBjaGFubmVsIHdpZHRoIHJlcG9ydGluZw0KPiANCj4gVGhlIGdlbiAyIGNoaXBz
IFJUTDgxOTJFVSBhbmQgUlRMODE4OEZVIHBlcmlvZGljYWxseSBzZW5kIHRoZSBkcml2ZXINCj4g
cmVwb3J0cyBhYm91dCB0aGUgVFggcmF0ZSwgYW5kIHRoZSBkcml2ZXIgcGFzc2VzIHRoZXNlIHJl
cG9ydHMgdG8NCj4gc3RhX3N0YXRpc3RpY3MuIFRoZSByZXBvcnRzIGZyb20gUlRMODE5MkVVIG1h
eSBvciBtYXkgbm90IGluY2x1ZGUgdGhlDQo+IGNoYW5uZWwgd2lkdGguIFRoZSByZXBvcnRzIGZy
b20gUlRMODE4OEZVIGRvIG5vdCBpbmNsdWRlIGl0Lg0KPiANCj4gT25seSBhY2Nlc3MgdGhlIGMy
aC0+cmFfcmVwb3J0LmJ3IGZpZWxkIGlmIHRoZSByZXBvcnQgKHNrYikgaXMgYmlnDQo+IGVub3Vn
aC4NCj4gDQo+IFRoZSBvdGhlciBwcm9ibGVtIGZpeGVkIGhlcmUgaXMgdGhhdCB0aGUgY29kZSB3
YXMgYWN0dWFsbHkgbmV2ZXINCj4gY2hhbmdpbmcgdGhlIGNoYW5uZWwgd2lkdGggaW5pdGlhbGx5
IHJlcG9ydGVkIGJ5DQo+IHJ0bDh4eHh1X2Jzc19pbmZvX2NoYW5nZWQgYmVjYXVzZSB0aGUgdmFs
dWUgb2YgUkFURV9JTkZPX0JXXzIwIGlzIDAuDQo+IA0KPiBGaXhlczogMDk4NWQzYTQxMGFjICgi
cnRsOHh4eHU6IEZlZWQgY3VycmVudCB0eHJhdGUgaW5mb3JtYXRpb24gZm9yIG1hYzgwMjExIikN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV9jb3JlLmMgfCAxMCArKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggMjhmMTM2
MDY0Mjk3Li4xYzI5ZDBiZjA5ZTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC01NTY5LDcgKzU1
NjksNiBAQCBzdGF0aWMgdm9pZCBydGw4eHh4dV9jMmhjbWRfY2FsbGJhY2soc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQ0KPiAgCQkJcmFycHQtPnR4cmF0ZS5mbGFncyA9IDA7DQo+ICAJCQlyYXRl
ID0gYzJoLT5yYV9yZXBvcnQucmF0ZTsNCj4gIAkJCXNnaSA9IGMyaC0+cmFfcmVwb3J0LnNnaTsN
Cj4gLQkJCWJ3ID0gYzJoLT5yYV9yZXBvcnQuYnc7DQo+IA0KPiAgCQkJaWYgKHJhdGUgPCBERVND
X1JBVEVfTUNTMCkgew0KPiAgCQkJCXJhcnB0LT50eHJhdGUubGVnYWN5ID0NCj4gQEAgLTU1ODYs
OCArNTU4NSwxMyBAQCBzdGF0aWMgdm9pZCBydGw4eHh4dV9jMmhjbWRfY2FsbGJhY2soc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCQkJCQkJUkFURV9JTkZPX0ZMQUdTX1NIT1JUX0dJOw0K
PiAgCQkJCX0NCj4gDQo+IC0JCQkJaWYgKGJ3ID09IFJBVEVfSU5GT19CV18yMCkNCj4gLQkJCQkJ
cmFycHQtPnR4cmF0ZS5idyB8PSBSQVRFX0lORk9fQldfMjA7DQo+ICsJCQkJaWYgKHNrYi0+bGVu
ID49IDIgKyA3KSB7DQoNCkkgdGhpbmsgMiBpcyBoZWFkZXIgbGVuZ3RoIG9mIEMySCwgYW5kIDcg
aXMgc2l6ZW9mKGMyaC0+cmFfcmVwb3J0KSwgc28gd2UgY2FuDQpoYXZlOg0KI2RlZmluZSBSVEw4
WFhYVV9DMkhfSERSX0xFTiAyDQoNClRoZW4sIHJlcGxhY2UgdGhpcyBzdGF0ZW1lbnQgd2l0aA0K
DQppZiAoc2tiLT5sZW4gPj0gUlRMOFhYWFVfQzJIX0hEUl9MRU4gKyBzaXplb2YoYzJoLT5yYV9y
ZXBvcnQpKQ0KDQpCeSB0aGUgd2F5LCBJIGZvdW5kICdzdHJ1Y3QgcnRsODcyM2J1X2MyaCcgbWlz
cyAnX19wYWNrZWQnLg0KDQotLQ0KUGluZy1LZQ0KDQo=
