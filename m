Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8469C3A7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 01:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjBTAcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Feb 2023 19:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAcx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Feb 2023 19:32:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5F71BC
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 16:32:48 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31K0WfYjA014891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31K0WfYjA014891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Feb 2023 08:32:41 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Feb 2023 08:32:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 20 Feb 2023 08:32:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 20 Feb 2023 08:32:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Remove always true condition in rtl8xxxu_print_chipinfo
Thread-Topic: [PATCH] wifi: rtl8xxxu: Remove always true condition in
 rtl8xxxu_print_chipinfo
Thread-Index: AQHZQwCiEo7R3rvElkSHe3AcqaZ1467W/0Tg
Date:   Mon, 20 Feb 2023 00:32:44 +0000
Message-ID: <e1952041f37548379955e48f9f8fa734@realtek.com>
References: <68eff98b-a022-5a00-f330-adf623a35772@gmail.com>
In-Reply-To: <68eff98b-a022-5a00-f330-adf623a35772@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzIvMTkg5LiL5Y2IIDA1OjI3OjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAx
OCwgMjAyMyAyOjQ5IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IHJ0bDh4eHh1OiBS
ZW1vdmUgYWx3YXlzIHRydWUgY29uZGl0aW9uIGluIHJ0bDh4eHh1X3ByaW50X2NoaXBpbmZvDQo+
IA0KPiBGaXggYSBuZXcgc21hdGNoIHdhcm5pbmc6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jOjE1ODAgcnRsOHh4eHVfcHJpbnRfY2hpcGlu
Zm8oKSB3YXJuOiBhbHdheXMgdHJ1ZQ0KPiBjb25kaXRpb24gJyhwcml2LT5jaGlwX2N1dCA8PSAx
NSkgPT4gKDAtMTUgPD0gMTUpJw0KPiANCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVp
bGQtYWxsLzIwMjMwMjE0MDc1My43MUlnVTc3QS1sa3BAaW50ZWwuY29tLw0KPiBGaXhlczogN2Iw
YWM0NjllMzMxICgid2lmaTogcnRsOHh4eHU6IFJlY29nbmlzZSBhbGwgcG9zc2libGUgY2hpcCBj
dXRzIikNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfY29yZS5jIHwgNiArLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDYyMGE1Y2MyYmZk
ZC4uNTRjYTZmMmNlZDNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtMTU3NSwxMSArMTU3NSw3
IEBAIHJ0bDh4eHh1X3NldF9zcGVjX3NpZnMoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHUx
NiBjY2ssIHUxNiBvZmRtKQ0KPiAgc3RhdGljIHZvaWQgcnRsOHh4eHVfcHJpbnRfY2hpcGluZm8o
c3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnByaXYtPnVkZXYtPmRldjsNCj4gLSAgICAgICBjaGFyIGN1dCA9ICc/JzsNCj4g
LQ0KPiAtICAgICAgIC8qIEN1cnJlbnRseSBhbHdheXMgdHJ1ZTogY2hpcF9jdXQgaXMgNCBiaXRz
LiAqLw0KPiAtICAgICAgIGlmIChwcml2LT5jaGlwX2N1dCA8PSAxNSkNCj4gLSAgICAgICAgICAg
ICAgIGN1dCA9ICdBJyArIHByaXYtPmNoaXBfY3V0Ow0KPiArICAgICAgIGNoYXIgY3V0ID0gJ0En
ICsgcHJpdi0+Y2hpcF9jdXQ7DQo+IA0KPiAgICAgICAgIGRldl9pbmZvKGRldiwNCj4gICAgICAg
ICAgICAgICAgICAiUlRMJXMgcmV2ICVjICglcykgcm9tdmVyICVkLCAlaVQlaVIsIFRYIHF1ZXVl
cyAlaSwgV2lGaT0laSwgQlQ9JWksIEdQUz0laSwgSEkgUEE9JWlcbiIsDQo+IC0tDQo+IDIuMzku
MQ0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJp
bnRpbmcgdGhpcyBlLW1haWwuDQo=
