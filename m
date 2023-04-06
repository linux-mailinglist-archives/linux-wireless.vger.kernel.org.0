Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A36D8C15
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 02:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjDFAmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 20:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjDFAmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 20:42:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1B5BBD
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 17:42:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3360fpqlF025488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3360fpqlF025488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 08:41:51 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 08:42:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 6 Apr 2023 08:42:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 6 Apr 2023 08:42:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Thread-Topic: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Thread-Index: AQHZXOKJ+70+DZ6OK0SBvz9wvU5TVK8IFYoAgBRR6QCAAR8HMA==
Date:   Thu, 6 Apr 2023 00:42:11 +0000
Message-ID: <a25acad730c94845a16552f321eb2660@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
 <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
In-Reply-To: <26840cf1-9403-3d09-a4d2-352bc198efff@linutronix.de>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwg
NSwgMjAyMyAxMTozMSBQTQ0KPiBUbzogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQo+IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBL
YWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgUGluZy1LZSBTaGloDQo+IDxwa3NoaWhAcmVh
bHRlay5jb20+OyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXgu
ZGU+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggMDAvMTRdIHdpZmk6IHJ0bDh4eHh1OiBBZGQgQVAgbW9kZSBzdXBwb3J0IGZvciA4MTg4
Zg0KPiANCj4gQW0gMjMuMDMuMjMgdW0gMTg6MTIgc2NocmllYiBCaXR0ZXJibHVlIFNtaXRoOg0K
PiA+IE9uIDIyLzAzLzIwMjMgMTk6MTgsIE1hcnRpbiBLYWlzdHJhIHdyb3RlOg0KPiA+IFRoZW4g
SSB3YXMgYWJsZSB0byB0dXJuIG9uIHRoZSBBUCBhbmQgY29ubmVjdCBteSBwaG9uZSB0byBpdC4g
SG93ZXZlciwNCj4gPiB0aGUgc3lzdGVtIGZyb3plIGFmdGVyIGEgZmV3IHNlY29uZHMuIEkgaGFk
IGBqb3VybmFsY3RsIC0tZm9sbG93YA0KPiA+IHJ1bm5pbmcuIFRoZSBsYXN0IHRoaW5nIHByaW50
ZWQgYmVmb3JlIHRoZSBzeXN0ZW0gZnJvemUgd2FzIHRoZSBESENQDQo+ID4gc3R1ZmYgKGRpc2Nv
dmVyLCBvZmZlciwgcmVxdWVzdCwgYWNrKS4gVGhlIHBob25lIHNhaWQgaXQgd2FzIGNvbm5lY3Rl
ZCwNCj4gPiBidXQgc3BlZWR0ZXN0Lm5ldCBkaWRuJ3QgaGF2ZSB0aW1lIHRvIGxvYWQgYmVmb3Jl
IHRoZSBmcmVlemUuDQo+IA0KPiBIaQ0KPiANCj4gSSBjb3VsZCByZXByb2R1Y2UgYSBmcm96ZW4g
c3lzdGVtIHdpdGggbXkgaG9zdGFwZCBzZXR1cCwgdGhvdWdoIGl0DQo+IGRvZXNuJ3QgaGFwcGVu
IHJlbGlhYmx5IGFuZCBJIGRvbid0IGhhdmUgYW4gZXJyb3IgbWVzc2FnZSB3aGVuIGl0IGhhcHBl
bnMuDQo+IA0KDQpVc2luZyBuZXRjYXQgd291bGQgaGVscCB0byBjYXB0dXJlIHVzZWZ1bCBtZXNz
YWdlcyB3aGVuIHN5c3RlbSBnZXRzIGZyb3plbi4NCg0KUGluZy1LZQ0KDQo=
