Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCF661C01
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 02:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjAIBgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 20:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjAIBgq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 20:36:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DA27B4A2
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 17:36:45 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3091Zh5G2013891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3091Zh5G2013891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 9 Jan 2023 09:35:43 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 9 Jan 2023 09:36:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 09:36:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Mon, 9 Jan 2023 09:36:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
Thread-Topic: [PATCH v2 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
Thread-Index: AQHZI3LWAPU9c1KQ4UCk8dUozK0Ktq6VTqZQ
Date:   Mon, 9 Jan 2023 01:36:40 +0000
Message-ID: <df9040d065214ce7a3f2f34506f97579@realtek.com>
References: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
In-Reply-To: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvOCDkuIvljYggMTE6NTQ6MDA=?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSA4LCAy
MDIzIDExOjA3IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8yXSB3aWZpOiBydGw4eHh4
dTogUmVwb3J0IHRoZSBSU1NJIHRvIHRoZSBmaXJtd2FyZQ0KPiANCj4gT3IgaW4gdGhlIGNhc2Ug
b2YgUlRMODE4OEVVLCByZXBvcnQgdGhlIFJTU0kgdG8gdGhlIHJhdGUgY29udHJvbCBjb2RlLg0K
PiANCj4gVGhlIHJhdGUgY29udHJvbCBjb2RlIGZvciBSVEw4MTg4RVUgaXMgbGVzcyBsaWtlbHkg
dG8gc3dpdGNoIHRvIGEgbG93ZXINCj4gcmF0ZSB3aGVuIHRoZSBSU1NJIGlzIGhpZ2guIFRoZSBm
aXJtd2FyZS1iYXNlZCByYXRlIGNvbnRyb2wgaW4gdGhlIG90aGVyDQo+IGNoaXBzIHByb2JhYmx5
IHdvcmtzIHRoZSBzYW1lIHdheS4NCj4gDQo+IFRoaXMgYWZmZWN0cyBhbGwgdGhlIGNoaXBzLCBi
dXQgaXQgd2FzIG9ubHkgdGVzdGVkIHdpdGggUlRMODE4OEVVLA0KPiBSVEw4MTg4RlUsIGFuZCBS
VEw4MTkyRVUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiB2MjoNCj4gIC0gU3VnZ2VzdGlvbiBmcm9tIFBpbmctS2Ug
U2hpaDoNCj4gICAgLSBNYWtlIGgyY19zaXplIDQgaW5zdGVhZCBvZiAzIGluIHJ0bDh4eHh1X2dl
bjFfcmVwb3J0X3Jzc2koKS4NCj4gICAgICBKdXN0IHRvIG1ha2UgaXQgbGVzcyBjb25mdXNpbmcu
IEl0IGRvZXNuJ3QgY2hhbmdlIHRoZSBiZWhhdmlvdXIuDQo+IC0tLQ0KPiAgLi4uL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1LmggIHwgMjMgKysrKysrKysrKysrKw0KPiAg
Li4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGUuYyAgICAgICAgIHwgIDYgKysrKw0K
PiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYyAgICAgICAgIHwgIDEgKw0K
PiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE5MmMuYyAgICAgICAgIHwgIDEgKw0K
PiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE5MmUuYyAgICAgICAgIHwgIDEgKw0K
PiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcyM2EuYyAgICAgICAgIHwgIDEgKw0K
PiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcyM2IuYyAgICAgICAgIHwgIDEgKw0K
PiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgMzQgKysr
KysrKysrKysrKysrKysrKw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspDQo+
IA0KDQpbLi4uXQ0KDQo=
