Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4952360C165
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 03:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJYBuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 21:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiJYBts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 21:49:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B03DBC5888
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 18:45:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P1jF241005082, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P1jF241005082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 09:45:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 09:45:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 25 Oct 2022 09:45:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Tue, 25 Oct 2022 09:45:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Thread-Topic: [PATCH v2 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Thread-Index: AQHY5/j+CYt/af/OM0iaLPMKljuhbK4eVvig
Date:   Tue, 25 Oct 2022 01:45:48 +0000
Message-ID: <a8ac65fa12bb400f92adf55c92ac1d6c@realtek.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
 <92f365c5-ff7c-33b0-60c9-f2c1492fba0a@gmail.com>
In-Reply-To: <92f365c5-ff7c-33b0-60c9-f2c1492fba0a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI0IOS4i+WNiCAxMToyMzowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUs
IDIwMjIgNDo1NyBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiAzLzVdIHdpZmk6IHJ0bDh4eHh1OiBSZWNvZ25pc2UgYWxsIHBvc3NpYmxlIGNoaXAgY3V0
cw0KPiANCj4gVGhlIGNoaXAgY3V0LCBhbHNvIGtub3duIGFzIHRoZSBjaGlwIHZlcnNpb24sIGlz
IGEgbGV0dGVyIGZyb20gQSAoMCkNCj4gdG8gUCAoMTUpLiBSZWNvZ25pc2UgdGhlbSBhbGwgaW5z
dGVhZCBvZiBwcmludGluZyAidW5rbm93biIgd2hlbiBpdCdzDQo+IGdyZWF0ZXIgdGhhbiBFLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFp
bC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0KPiAtLS0NCj4gdjI6DQo+ICAtIFN1Z2dlc3Rpb24gZnJvbSBQaW5nLUtlIFNoaWg6DQo+ICAg
IC0gRG9uJ3QgdXNlIGFycmF5IG9mIGxldHRlcnMuDQo+IC0tLQ0KPiAgLi4uL3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgMjYgKysrKy0tLS0tLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+IA0K
DQpbLi4uXQ0KDQo=
