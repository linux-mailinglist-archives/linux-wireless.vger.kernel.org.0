Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB96F130C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 10:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjD1IL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345811AbjD1ILv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 04:11:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F11FF1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 01:11:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33S8BM0a8002774, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33S8BM0a8002774
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 28 Apr 2023 16:11:22 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Apr 2023 16:11:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Apr 2023 16:11:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 28 Apr 2023 16:11:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH v3 03/18] wifi: rtl8xxxu: Add beacon functions
Thread-Topic: [PATCH v3 03/18] wifi: rtl8xxxu: Add beacon functions
Thread-Index: AQHZeOgGGoRHEtLeQ0Ksj5W7CE3Kna8/4FpA///lpwCAAJoDEA==
Date:   Fri, 28 Apr 2023 08:11:24 +0000
Message-ID: <33543a661a0f46abbf4d2c5e77a4bf34@realtek.com>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
 <20230427090922.165088-4-martin.kaistra@linutronix.de>
 <39b41578a55e4375a6bdd5b127a3f20b@realtek.com>
 <a1ab0e82-5ec5-8d33-5f8c-b8bbf88ed87c@linutronix.de>
In-Reply-To: <a1ab0e82-5ec5-8d33-5f8c-b8bbf88ed87c@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjgs
IDIwMjMgMjo1OSBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcyBTb3JlbnNlbiA8SmVzLlNv
cmVuc2VuQGdtYWlsLmNvbT47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBCaXR0ZXJi
bHVlIFNtaXRoDQo+IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT47IFNlYmFzdGlhbiBBbmRyemVq
IFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAwMy8xOF0gd2lmaTogcnRsOHh4eHU6IEFkZCBiZWFjb24gZnVuY3Rpb25zDQo+IA0KPiBBbSAy
OC4wNC4yMyB1bSAwMjozOCBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPg0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcnRpbiBLYWlzdHJhIDxtYXJ0
aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRlPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjcs
IDIwMjMgNTowOSBQTQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
ID4+IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBLYWxsZSBWYWxv
IDxrdmFsb0BrZXJuZWwub3JnPjsgUGluZy1LZSBTaGloDQo+ID4+IDxwa3NoaWhAcmVhbHRlay5j
b20+OyBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT47IFNlYmFzdGlh
biBBbmRyemVqIFNpZXdpb3INCj4gPj4gPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gPj4gU3Vi
amVjdDogW1BBVENIIHYzIDAzLzE4XSB3aWZpOiBydGw4eHh4dTogQWRkIGJlYWNvbiBmdW5jdGlv
bnMNCj4gPj4NCj4gPj4gQWRkIGEgd29ya3F1ZXVlIHRvIHVwZGF0ZSB0aGUgYmVhY29uIGNvbnRl
bnRzIGFzeW5jaHJvbm91c2x5IGFuZA0KPiA+PiBpbXBsZW1lbnQgZG93bmxvYWRpbmcgdGhlIGJl
YWNvbiB0byB0aGUgSFcgYW5kIHN0YXJ0aW5nIGJlYWNvbiB0eCBsaWtlDQo+ID4+IHRoZSB2ZW5k
b3IgZHJpdmVyLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gS2Fpc3RyYSA8bWFy
dGluLmthaXN0cmFAbGludXRyb25peC5kZT4NCj4gPj4gLS0tDQo+ID4NCj4gPiBbLi4uXQ0KPiA+
DQo+ID4+ICAgLyoNCj4gPj4gICAgKiBUaGUgcnRsODcyM2EgaGFzIDMgY2hhbm5lbCBncm91cHMg
Zm9yIGl0J3MgZWZ1c2Ugc2V0dGluZ3MuIEl0IG9ubHkNCj4gPj4gQEAgLTQ5NjQsNiArNDk3OCwx
NiBAQCBydGw4eHh4dV9ic3NfaW5mb19jaGFuZ2VkKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBz
dHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiA+PiAgICAgICAgICAgICAgICAgIGRldl9kYmco
ZGV2LCAiQ2hhbmdlZCBCQVNJQ19SQVRFUyFcbiIpOw0KPiA+PiAgICAgICAgICAgICAgICAgIHJ0
bDh4eHh1X3NldF9iYXNpY19yYXRlcyhwcml2LCBic3NfY29uZi0+YmFzaWNfcmF0ZXMpOw0KPiA+
PiAgICAgICAgICB9DQo+ID4+ICsNCj4gPj4gKyAgICAgICBpZiAoY2hhbmdlZCAmIEJTU19DSEFO
R0VEX0JFQUNPTl9FTkFCTEVEICYmIGJzc19jb25mLT5lbmFibGVfYmVhY29uKQ0KPiA+PiArICAg
ICAgICAgICAgICAgcnRsOHh4eHVfc3RhcnRfdHhfYmVhY29uKHByaXYpOw0KPiA+PiArDQo+ID4+
ICsgICAgICAgaWYgKGNoYW5nZWQgJiBCU1NfQ0hBTkdFRF9CRUFDT04pDQo+ID4+ICsgICAgICAg
ICAgICAgICBzY2hlZHVsZV93b3JrKCZwcml2LT51cGRhdGVfYmVhY29uX3dvcmspOw0KPiA+PiAr
DQo+ID4+ICsgICAgICAgaWYgKGNoYW5nZWQgJiBCU1NfQ0hBTkdFRF9CRUFDT05fRU5BQkxFRCAm
JiAhYnNzX2NvbmYtPmVuYWJsZV9iZWFjb24pDQo+ID4+ICsgICAgICAgICAgICAgICBydGw4eHh4
dV9zdG9wX3R4X2JlYWNvbihwcml2KTsNCj4gPj4gKw0KPiA+DQo+ID4gSSB0aG91Z2h0IHRoZXNl
IHRocmVlIHN5bmNocm9ub3VzIHdvcmtzLCBzbyBJIGhhdmUgdGhpcyBzdWdnZXN0aW9uLCBidXQg
YWN0dWFsbHkNCj4gPiB1cGRhdGVfYmVhY29uX3dvcmsgaXMgYXN5bmNocm9ub3VzLiBUaGVuLCB3
ZSBjYW4gc3RhcnQvc3RvcCB0eF9iZWFjb24gaW50byBhDQo+ID4gYnJhbmNoLg0KPiANCj4gSSBn
dWVzcyBJIHdpbGwgcHJlcGFyZSBhIHY0IHRoZW4uDQo+IA0KDQpJIHRoaW5rIHY0IHdpbGwgYmUg
ZmluYWwuIDotKQ0KDQoNCg==
