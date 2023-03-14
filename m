Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1C6B8771
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCNBNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 21:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNBNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 21:13:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A748EF8C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 18:13:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32E1ChSR2022375, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32E1ChSR2022375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 14 Mar 2023 09:12:43 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 14 Mar 2023 09:12:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 14 Mar 2023 09:12:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Tue, 14 Mar 2023 09:12:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>, Jiajie Chen <c@jia.je>
Subject: RE: [PATCH v3] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
Thread-Topic: [PATCH v3] wifi: rtl8xxxu: Support new chip RTL8710BU aka
 RTL8188GU
Thread-Index: AQHZVbPg4onVVI6KH0yxKWetnPbPpK75eGVg
Date:   Tue, 14 Mar 2023 01:12:31 +0000
Message-ID: <3e22072f0a304779b3c7914a121fedb6@realtek.com>
References: <4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com>
In-Reply-To: <4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTMsIDIw
MjMgOTo1OCBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBK
ZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT47IEppYWppZSBDaGVuIDxjQGppYS5qZT4NCj4gU3ViamVjdDogW1BBVENI
IHYzXSB3aWZpOiBydGw4eHh4dTogU3VwcG9ydCBuZXcgY2hpcCBSVEw4NzEwQlUgYWthIFJUTDgx
ODhHVQ0KPiANCj4gVGhpcyBjaGlwIGlzIGZvdW5kIGluIGNoZWFwICJmcmVlIGRyaXZlciIgVVNC
IGFkYXB0ZXJzIGZyb20gQWxpZXhwcmVzcy4NCj4gSW5pdGlhbGx5IHRoZXkgcHJldGVuZCB0byBi
ZSBhIENELVJPTSBjb250YWluaW5nIHRoZSBkcml2ZXIgZm9yIFdpbmRvd3MuDQo+ICJFamVjdGlu
ZyIgc3dpdGNoZXMgdGhlIGRldmljZSB0byB3aWZpIG1vZGUuDQo+IA0KPiBGZWF0dXJlczogMi40
IEdIeiwgYi9nL24gbW9kZSwgMVQxUiwgMTUwIE1icHMuDQo+IA0KPiBUaGlzIGNoaXAgaXMgbW9y
ZSB1bmlxdWUgdGhhbiBvdGhlciBSZWFsdGVrIGNoaXBzOg0KPiANCj4gKiBUaGUgcmVnaXN0ZXJz
IGF0IGFkZHJlc3NlcyAweDAtMHhmZiwgd2hpY2ggYWxsIHRoZSBvdGhlciBjaGlwcyB1c2UsDQo+
ICAgY2FuJ3QgYmUgdXNlZCBoZXJlLiBOZXcgcmVnaXN0ZXJzIGF0IDB4ODAwMC0weDgwZmYgbXVz
dCBiZSB1c2VkDQo+ICAgaW5zdGVhZC4gQW5kIGl0J3Mgbm90IGEgc2ltcGxlIG1hdHRlciBvZiBh
ZGRpbmcgMHg4MDAwOiAweDINCj4gICAoUkVHX1NZU19GVU5DKSBiZWNhbWUgMHg4MDA0LCAweDgw
IChSRUdfTUNVX0ZXX0RMKSBiZWNhbWUgMHg4MDkwLA0KPiAgIGV0Yy4NCj4gDQo+ICogQWxzbyB0
aGVyZSBhcmUgYSBmZXcgbmV3IHJlZ2lzdGVycyB3aGljaCBtdXN0IGJlIGFjY2Vzc2VkIGluZGly
ZWN0bHkNCj4gICBiZWNhdXNlIHRoZWlyIGFkZHJlc3NlcyBkb24ndCBmaXQgaW4gMTYgYml0cy4g
Tm8gb3RoZXIgY2hpcHMgc2VlbSB0bw0KPiAgIGhhdmUgdGhlc2UuDQo+IA0KPiAqIFRoZSB2ZW5k
b3IgZHJpdmVyIGNvbXBpbGVzIHRvIDgxODhndS5rbywgYnV0IHRoZSBjb2RlIGNhbGxzIHRoZSBj
aGlwDQo+ICAgUlRMODcxMEIoVSkgcHJldHR5IG11Y2ggZXZlcnl3aGVyZSwgaW5jbHVkaW5nIG1l
c3NhZ2VzIHZpc2libGUgdG8gdGhlDQo+ICAgdXNlci4NCj4gDQo+IEFub3RoZXIgZGlmZmVyZW5j
ZSBjb21wYXJlZCB0byB0aGUgb3RoZXIgY2hpcHMgc3VwcG9ydGVkIGJ5IHJ0bDh4eHh1IGlzDQo+
IHRoYXQgaXQgaGFzIGEgbmV3IFBIWSBzdGF0dXMgc3RydWN0LCBvciB0aHJlZSBvZiB0aGVtIGFj
dHVhbGx5LCBmcm9tDQo+IHdoaWNoIHdlIGV4dHJhY3QgdGhlIFJTU0ksIGFtb25nIG90aGVyIHRo
aW5ncy4gVGhpcyBpcyBub3QgdW5pcXVlLA0KPiB0aG91Z2gsIGp1c3QgbmV3LiBUaGUgY2hpcHMg
c3VwcG9ydGVkIGJ5IHJ0dzg4IGFsc28gdXNlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0
dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClRoYW5rcyBmb3IgdGhp
cyBuaWNlIHdvcmsuDQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0KDQo=
