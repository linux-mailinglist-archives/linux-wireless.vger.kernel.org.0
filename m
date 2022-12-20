Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5AB651A7B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 07:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiLTGBB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 01:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiLTGA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 01:00:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C60E024A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 22:00:58 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BK603V60009850, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BK603V60009850
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Dec 2022 14:00:03 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 20 Dec 2022 14:00:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Dec 2022 14:00:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 20 Dec 2022 14:00:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v3 5/5] wifi: rtl8xxxu: Add rate control code for RTL8188EU
Thread-Topic: [PATCH v3 5/5] wifi: rtl8xxxu: Add rate control code for
 RTL8188EU
Thread-Index: AQHZEiLxPR6OVZYkD0mBI5AafuGdla52THPg
Date:   Tue, 20 Dec 2022 06:00:53 +0000
Message-ID: <5038fb93bd994fc68f0ca8790be41295@realtek.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
 <5acc1e5d-62d6-3a6a-0f9e-cbc8b809b1d7@gmail.com>
In-Reply-To: <5acc1e5d-62d6-3a6a-0f9e-cbc8b809b1d7@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIwIOS4iuWNiCAwMjoyNDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAx
NywgMjAyMiAxMDoyMiBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MyA1LzVdIHdpZmk6IHJ0bDh4eHh1OiBBZGQgcmF0ZSBjb250cm9sIGNvZGUgZm9yIFJU
TDgxODhFVQ0KPiANCj4gQ29waWVkIGZyb20gdGhlIG5ld2VyIHZlbmRvciBkcml2ZXIsIHY1LjIu
Mi40Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0KPiAtLS0NCj4gdjM6DQo+ICAtIEltcGxlbWVudCBzdWdnZXN0aW9ucyBmcm9tIFBp
bmctS2UgU2hpaDoNCj4gICAgLSBSZW1vdmUgdW5uZWNlc3NhcnkgYXNzaWdubWVudCBpbiBydGw4
MTg4ZV9wb3dlcl90cmFpbmluZ190cnlfc3RhdGUoKS4NCj4gICAgLSBVc2UgPj49IGluIHJ0bDgx
ODhlX3Bvd2VyX3RyYWluaW5nX2RlY2lzaW9uKCkuDQo+ICAgIC0gUmVtb3ZlIGVtcHR5IGxpbmUg
aW4gcnRsODE4OGVfaGFuZGxlX3JhX3R4X3JlcG9ydDIoKS4NCj4gICAgLSBNb3ZlIGNsb3Npbmcg
cGFyZW50aGVzaXMgaW4gcnRsOHh4eHVfcGFyc2VfcnhkZXNjMTYoKS4NCj4gIC0gUmVtb3ZlIHVu
dXNlZCBhcnJheXMgcmV0cnlfcGVuYWx0eV91cCBhbmQgdHJ5aW5nX25lY2Vzc2FyeS4NCj4gICAg
UmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gdjI6
DQo+ICAtIEltcGxlbWVudCBzdWdnZXN0aW9ucyBmcm9tIFBpbmctS2UgU2hpaDoNCj4gICAgLSBB
ZGQgbWlzc2luZyBicmVhayBpbiB0d28gc3dpdGNoIHN0YXRlbWVudHMuDQo+ICAgIC0gUmVtb3Zl
IHVubmVjZXNzYXJ5IGluaXRpYWxpc2F0aW9uIG9mIGlkeCBpbiBydGw4MTg4ZV9zZXRfdHhfcnB0
X3RpbWluZygpLg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dS5oICB8ICAzOSArKw0KPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4
OGUuYyAgICAgICAgIHwgNTkwICsrKysrKysrKysrKysrKysrLQ0KPiAgLi4uL3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgMTMwICsrKy0NCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNzI5IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCg0KWy4uLl0NCg0K
