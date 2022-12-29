Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFB658813
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 01:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiL2A03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 19:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiL2A01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 19:26:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B53E2F02D
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 16:26:25 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BT0PLsJ4004068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BT0PLsJ4004068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Dec 2022 08:25:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 29 Dec 2022 08:26:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 29 Dec 2022 08:26:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Thu, 29 Dec 2022 08:26:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Felix Schwarz <felix.schwarz@oss.schwarz.eu>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw_8821cu: "rfe 38 isn't supported" with Linux 6.2rc1 (0bda:c811)
Thread-Topic: rtw_8821cu: "rfe 38 isn't supported" with Linux 6.2rc1
 (0bda:c811)
Thread-Index: AQHZGwvqAQY1RlZwHUqVG8JwOeMiNa6EATdg
Date:   Thu, 29 Dec 2022 00:26:14 +0000
Message-ID: <79ce633c3e274cffb22349b12566d78a@realtek.com>
References: <a949dfb1-51e9-8f91-bef1-674c78101cc3@oss.schwarz.eu>
In-Reply-To: <a949dfb1-51e9-8f91-bef1-674c78101cc3@oss.schwarz.eu>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzI4IOS4i+WNiCAxMDoxODowMA==?=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXggU2Nod2FyeiA8
ZmVsaXguc2Nod2FyekBvc3Muc2Nod2Fyei5ldT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVy
IDI5LCAyMDIyIDY6MjYgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBydHdfODgyMWN1OiAicmZlIDM4IGlzbid0IHN1cHBvcnRlZCIgd2l0aCBMaW51
eCA2LjJyYzEgKDBiZGE6YzgxMSkNCj4gDQo+IEhpLA0KPiANCj4gSSBub3RpY2VkIHRoYXQgc3Vw
cG9ydCBmb3IgUmVhbHRlaydzIDg4MjFjdSBkZXZpY2VzIHdhcyByZWNlbnRseSBtZXJnZWQgd2l0
aA0KPiBjb21taXQgYWZmNWZmZDcuIEkgaGF2ZSBhICJSZWFsdGVrIFNlbWljb25kdWN0b3IgQ29y
cC4gODAyLjExYWMgTklDIiAoSUQNCj4gMGJkYTpjODExKSBzbyBJIGRlY2lkZWQgdG8gdHJ5IDYu
MnJjMS4NCj4gDQo+IEhvd2V2ZXIgSSBvbmx5IGdldCB0aGVzZSBtZXNzYWdlcyAoYW5kIG5vIG5l
dyB3aWZpIG5ldHdvcmsgaW50ZXJmYWNlKSB3aGVuDQo+IHRyeWluZyB0byBsb2FkIHRoZSBtb2R1
bGU6DQo+IA0KPiBydHdfODgyMWN1IDEtNDoxLjA6IEZpcm13YXJlIHZlcnNpb24gMjQuMTEuMCwg
SDJDIHZlcnNpb24gMTINCj4gcnR3Xzg4MjFjdSAxLTQ6MS4wOiByZmUgMzggaXNuJ3Qgc3VwcG9y
dGVkDQoNClJGRSB0eXBlIDM4IGlzIHZlcnkgc2ltaWxhciB0byB0eXBlIDYsIHNvIEkgc3VnZ2Vz
dCB0byB0cnkgdGhpczogDQoNCmRpZmYgLS1naXQgYS9ydHc4ODIxYy5jIGIvcnR3ODgyMWMuYw0K
aW5kZXggZGQwMWIyMmYuLjlhYzgzNzU2IDEwMDY0NA0KLS0tIGEvcnR3ODgyMWMuYw0KKysrIGIv
cnR3ODgyMWMuYw0KQEAgLTE1NDcsNiArMTU0Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnR3
X3JmZV9kZWYgcnR3ODgyMWNfcmZlX2RlZnNbXSA9IHsNCiAgICAgICAgWzRdID0gUlRXX0RFRl9S
RkVfRVhUKDg4MjFjLCAwLCAwLCAyKSwNCiAgICAgICAgWzZdID0gUlRXX0RFRl9SRkUoODgyMWMs
IDAsIDApLA0KICAgICAgICBbMzRdID0gUlRXX0RFRl9SRkUoODgyMWMsIDAsIDApLA0KKyAgICAg
ICBbMzhdID0gUlRXX0RFRl9SRkUoODgyMWMsIDAsIDApLA0KIH07DQoNCi0tDQpQaW5nLUtlDQoN
Cg==
