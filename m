Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCBF74C9AF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 03:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGJBmy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJBmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 21:42:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC37BEB
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 18:42:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36A1gdzhF028142, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36A1gdzhF028142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Jul 2023 09:42:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Jul 2023 09:42:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 10 Jul 2023 09:42:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 10 Jul 2023 09:42:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
Thread-Topic: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU,
 RTL8723AU
Thread-Index: AQHZspSGOtt7g+TK3EqOf7swN4bu+K+yN0+A
Date:   Mon, 10 Jul 2023 01:42:43 +0000
Message-ID: <509e09b7bfa445fb81f4e3dc3a83dd65@realtek.com>
References: <52c28b65-6f28-2cc0-7281-179bb1087c2a@gmail.com>
In-Reply-To: <52c28b65-6f28-2cc0-7281-179bb1087c2a@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxMCwgMjAy
MyAyOjM4IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEpl
cyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggUkZDXSB3aWZpOiBydGw4eHh4dTogRml4
IHRoZSBUWCBwb3dlciBvZiBSVEw4MTkyQ1UsIFJUTDg3MjNBVQ0KPiANCj4gRG9uJ3Qgc3VidHJh
Y3QgMSBmcm9tIHRoZSBwb3dlciBpbmRleC4gVGhpcyB3YXMgYWRkZWQgaW4gY29tbWl0DQo+IDJm
YzBiOGU1YTE3ZCAoInJ0bDh4eHh1OiBBZGQgVFggcG93ZXIgYmFzZSB2YWx1ZXMgZm9yIGdlbjEg
cGFydHMiKQ0KPiBmb3IgdW5rbm93biByZWFzb25zLiBUaGUgdmVuZG9yIGRyaXZlcnMgZG9uJ3Qg
ZG8gdGhpcy4NCj4gDQo+IEFsc28gY29ycmVjdCB0aGUgY2FsY3VsYXRpb25zIG9mIHZhbHVlcyB3
cml0dGVuIHRvDQo+IFJFR19PRkRNMF9Ye0MsRH1fVFhfSVFfSU1CQUxBTkNFLiBBY2NvcmRpbmcg
dG8gdGhlIHZlbmRvciBkcml2ZXIsDQo+IHRoZXNlIGFyZSB1c2VkIGZvciBUWCBwb3dlciB0cmFp
bmluZy4NCj4gDQo+IFdpdGggdGhlc2UgY2hhbmdlcyBydGw4eHh4dSBzZXRzIHRoZSBUWCBwb3dl
ciBvZiBSVEw4MTkyQ1UgdGhlIHNhbWUNCj4gYXMgdGhlIHZlbmRvciBkcml2ZXIuDQo+IA0KPiBO
b25lIG9mIHRoaXMgYXBwZWFycyB0byBoYXZlIGFueSBlZmZlY3Qgb24gbXkgUlRMODE5MkNVIGRl
dmljZS4NCj4gLS0tDQo+IE15IFJUTDgxOTJDVSB3aXRoIHJ0bDh4eHh1IGhhcyBsb3dlciB1cGxv
YWQgc3BlZWQgY29tcGFyZWQgdG8gdGhlDQo+IHZlbmRvciBkcml2ZXIsIHNvIEkgY29tcGFyZWQg
dGhlIHJlZ2lzdGVyIHdyaXRlcyBhbmQgZm91bmQNCj4gZGlmZmVyZW5jZXMgaW4gdGhlIFRYIHBv
d2VyIHN0dWZmLg0KPiANCj4gSmVzLCBkbyB5b3UgcmVtZW1iZXIgd2h5IHlvdSBzdWJ0cmFjdGVk
IDEgZnJvbSB0aGUgcG93ZXIgaW5kZXg/DQo+IFRoYXQgaGFzIHRvIGJlIG9uIHB1cnBvc2UuIFRo
ZSBvdGhlciBkaWZmZXJlbmNlcyBsb29rIHVuaW50ZW50aW9uYWwuDQo+IC0tLQ0KPiAgLi4uL3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jICB8IDE4ICsrKysrKysrLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRleCA1ZDEwMmExMjQ2YTMuLmUxMTFmYjJiMmMz
MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gQEAgLTE1MTAsOCArMTUxMCw4IEBAIHJ0bDh4eHh1X2dl
bjFfc2V0X3R4X3Bvd2VyKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2LCBpbnQgY2hhbm5lbCwg
Ym9vbCBodDQwKQ0KPiANCj4gICAgICAgICBncm91cCA9IHJ0bDh4eHh1X2dlbjFfY2hhbm5lbF90
b19ncm91cChjaGFubmVsKTsNCj4gDQo+IC0gICAgICAgY2NrWzBdID0gcHJpdi0+Y2NrX3R4X3Bv
d2VyX2luZGV4X0FbZ3JvdXBdIC0gMTsNCj4gLSAgICAgICBjY2tbMV0gPSBwcml2LT5jY2tfdHhf
cG93ZXJfaW5kZXhfQltncm91cF0gLSAxOw0KPiArICAgICAgIGNja1swXSA9IHByaXYtPmNja190
eF9wb3dlcl9pbmRleF9BW2dyb3VwXTsNCj4gKyAgICAgICBjY2tbMV0gPSBwcml2LT5jY2tfdHhf
cG93ZXJfaW5kZXhfQltncm91cF07DQo+IA0KPiAgICAgICAgIGlmIChwcml2LT5oaV9wYSkgew0K
PiAgICAgICAgICAgICAgICAgaWYgKGNja1swXSA+IDB4MjApDQo+IEBAIC0xNTIyLDEwICsxNTIy
LDYgQEAgcnRsOHh4eHVfZ2VuMV9zZXRfdHhfcG93ZXIoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnBy
aXYsIGludCBjaGFubmVsLCBib29sIGh0NDApDQo+IA0KPiAgICAgICAgIG9mZG1bMF0gPSBwcml2
LT5odDQwXzFzX3R4X3Bvd2VyX2luZGV4X0FbZ3JvdXBdOw0KPiAgICAgICAgIG9mZG1bMV0gPSBw
cml2LT5odDQwXzFzX3R4X3Bvd2VyX2luZGV4X0JbZ3JvdXBdOw0KPiAtICAgICAgIGlmIChvZmRt
WzBdKQ0KPiAtICAgICAgICAgICAgICAgb2ZkbVswXSAtPSAxOw0KPiAtICAgICAgIGlmIChvZmRt
WzFdKQ0KPiAtICAgICAgICAgICAgICAgb2ZkbVsxXSAtPSAxOw0KPiANCj4gICAgICAgICBvZmRt
YmFzZVswXSA9IG9mZG1bMF0gKyBwcml2LT5vZmRtX3R4X3Bvd2VyX2luZGV4X2RpZmZbZ3JvdXBd
LmE7DQo+ICAgICAgICAgb2ZkbWJhc2VbMV0gPSBvZmRtWzFdICsgcHJpdi0+b2ZkbV90eF9wb3dl
cl9pbmRleF9kaWZmW2dyb3VwXS5iOw0KPiBAQCAtMTYxNCwyMCArMTYxMCwyMiBAQCBydGw4eHh4
dV9nZW4xX3NldF90eF9wb3dlcihzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdiwgaW50IGNoYW5u
ZWwsIGJvb2wgaHQ0MCkNCj4gDQo+ICAgICAgICAgcnRsOHh4eHVfd3JpdGUzMihwcml2LCBSRUdf
VFhfQUdDX0FfTUNTMTVfTUNTMTIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBtY3NfYSAr
IHBvd2VyX2Jhc2UtPnJlZ18wZTFjKTsNCj4gKyAgICAgICB2YWw4ID0gdTMyX2dldF9iaXRzKG1j
c19hICsgcG93ZXJfYmFzZS0+cmVnXzBlMWMsIDB4ZmYwMDAwMDApOw0KDQpDb21wYXJpbmcgdG8g
dmVuZG9yIGRyaXZlciwgSSB0aGluayB0aGUgbG9naWMgaGVyZSBpcyB0aGUgc2FtZS4gDQoNCj4g
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgMzsgaSsrKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAo
aSAhPSAyKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICB2YWw4ID0gKG1jc2Jhc2VbMF0gPiA4
KSA/IChtY3NiYXNlWzBdIC0gOCkgOiAwOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB2YWw4
ID0gKHZhbDggPiA4KSA/ICh2YWw4IC0gOCkgOiAwOw0KPiAgICAgICAgICAgICAgICAgZWxzZQ0K
PiAtICAgICAgICAgICAgICAgICAgICAgICB2YWw4ID0gKG1jc2Jhc2VbMF0gPiA2KSA/IChtY3Ni
YXNlWzBdIC0gNikgOiAwOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB2YWw4ID0gKHZhbDgg
PiA2KSA/ICh2YWw4IC0gNikgOiAwOw0KDQpXb3VsZCB5b3UgbGlrZSB2YWw4ID0gbWluX3QoaW50
LCB2YWw4IC0gNiwgMCk7ID8NCg0KRXZlbiwgbWVyZ2UgdHdvIGJyYW5jaGVzIGludG8gb25lLg0K
ICBiYXNlID0gaSAhPSAyID8gOCA6IDY7DQogIHZhbDggPSBtaW5fdChpbnQsIHZhbDggLSBiYXNl
LCAwKTsNCg0KWy4uLl0NCg0K
