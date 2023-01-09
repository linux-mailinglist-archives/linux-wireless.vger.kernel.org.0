Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4D661C02
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 02:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjAIBhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 20:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAIBhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 20:37:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5133FB482
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 17:37:03 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3091a1l75013915, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3091a1l75013915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 9 Jan 2023 09:36:01 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 9 Jan 2023 09:36:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 9 Jan 2023 09:36:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Mon, 9 Jan 2023 09:36:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
Thread-Topic: [PATCH v2 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
Thread-Index: AQHZI3MMvUmyWObtGE2Rcf5vNFG4Na6VTsGA
Date:   Mon, 9 Jan 2023 01:36:58 +0000
Message-ID: <0b70feb9ae7c423b816ffd778fe882fb@realtek.com>
References: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
 <477d745b-6bac-111d-403c-487fc19aa30d@gmail.com>
In-Reply-To: <477d745b-6bac-111d-403c-487fc19aa30d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
MDIzIDExOjA4IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi8yXSB3aWZpOiBydGw4eHh4
dTogVXNlIGEgbG9uZ2VyIHJldHJ5IGxpbWl0IG9mIDQ4DQo+IA0KPiBUaGUgUmVhbHRlayByYXRl
IGNvbnRyb2wgYWxnb3JpdGhtIGdvZXMgYmFjayBhbmQgZm9ydGggYSBsb3QgYmV0d2Vlbg0KPiB0
aGUgaGlnaGVzdCBhbmQgdGhlIGxvd2VzdCByYXRlIGl0J3MgYWxsb3dlZCB0byB1c2UuIFRoaXMg
aXMgZHVlIHRvDQo+IGEgbG90IG9mIGZyYW1lcyBiZWluZyBkcm9wcGVkIGJlY2F1c2UgdGhlIHJl
dHJ5IGxpbWl0cyBzZXQgYnkNCj4gSUVFRTgwMjExX0NPTkZfQ0hBTkdFX1JFVFJZX0xJTUlUUyBh
cmUgdG9vIGxvdy4gKEV4cGVyaW1lbnRhbGx5LCB0aGV5DQo+IGFyZSA0IGZvciBsb25nIGZyYW1l
cyBhbmQgNyBmb3Igc2hvcnQgZnJhbWVzLikNCj4gDQo+IFRoZSB2ZW5kb3IgZHJpdmVycyBoYXJk
Y29kZSB0aGUgdmFsdWUgNDggZm9yIGJvdGggcmV0cnkgbGltaXRzIChmb3INCj4gc3RhdGlvbiBt
b2RlKSwgd2hpY2ggbWFrZXMgZHJvcHBlZCBmcmFtZXMgdmVyeSByYXJlIGFuZCB0aHVzIHRoZSBy
YXRlDQo+IGNvbnRyb2wgaXMgbW9yZSBzdGFibGUuDQo+IA0KPiBCZWNhdXNlIG1vc3QgUmVhbHRl
ayBjaGlwcyBoYW5kbGUgdGhlIHJhdGUgY29udHJvbCBpbiB0aGUgZmlybXdhcmUsDQo+IHdoaWNo
IGNhbid0IGJlIG1vZGlmaWVkLCBpZ25vcmUgdGhlIGxpbWl0cyBzZXQgYnkNCj4gSUVFRTgwMjEx
X0NPTkZfQ0hBTkdFX1JFVFJZX0xJTUlUUyBhbmQgdXNlIHRoZSB2YWx1ZSA0OCAoc2V0IGR1cmlu
Zw0KPiBjaGlwIGluaXRpYWxpc2F0aW9uKSwgc2FtZSBhcyB0aGUgdmVuZG9yIGRyaXZlcnMuDQo+
IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJi
bHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmct
S2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiB2MjoNCj4gIC0gVXNlIENj
IHRhZyBpbnN0ZWFkIG9mIEZpeGVzLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgOSAtLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggNGM3NmZh
ZDY3MTUwLi5hYjQwNzRjYWYxOTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC02MTg0LDcgKzYx
ODQsNiBAQCBzdGF0aWMgaW50IHJ0bDh4eHh1X2NvbmZpZyhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpo
dywgdTMyIGNoYW5nZWQpDQo+ICB7DQo+ICAJc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYgPSBo
dy0+cHJpdjsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcHJpdi0+dWRldi0+ZGV2Ow0KPiAt
CXUxNiB2YWwxNjsNCj4gIAlpbnQgcmV0ID0gMCwgY2hhbm5lbDsNCj4gIAlib29sIGh0NDA7DQo+
IA0KPiBAQCAtNjE5NCwxNCArNjE5Myw2IEBAIHN0YXRpYyBpbnQgcnRsOHh4eHVfY29uZmlnKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1MzIgY2hhbmdlZCkNCj4gIAkJCSBfX2Z1bmNfXywgaHct
PmNvbmYuY2hhbmRlZi5jaGFuLT5od192YWx1ZSwNCj4gIAkJCSBjaGFuZ2VkLCBody0+Y29uZi5j
aGFuZGVmLndpZHRoKTsNCj4gDQo+IC0JaWYgKGNoYW5nZWQgJiBJRUVFODAyMTFfQ09ORl9DSEFO
R0VfUkVUUllfTElNSVRTKSB7DQo+IC0JCXZhbDE2ID0gKChody0+Y29uZi5sb25nX2ZyYW1lX21h
eF90eF9jb3VudCA8PA0KPiAtCQkJICBSRVRSWV9MSU1JVF9MT05HX1NISUZUKSAmIFJFVFJZX0xJ
TUlUX0xPTkdfTUFTSykgfA0KPiAtCQkJKChody0+Y29uZi5zaG9ydF9mcmFtZV9tYXhfdHhfY291
bnQgPDwNCj4gLQkJCSAgUkVUUllfTElNSVRfU0hPUlRfU0hJRlQpICYgUkVUUllfTElNSVRfU0hP
UlRfTUFTSyk7DQo+IC0JCXJ0bDh4eHh1X3dyaXRlMTYocHJpdiwgUkVHX1JFVFJZX0xJTUlULCB2
YWwxNik7DQo+IC0JfQ0KPiAtDQo+ICAJaWYgKGNoYW5nZWQgJiBJRUVFODAyMTFfQ09ORl9DSEFO
R0VfQ0hBTk5FTCkgew0KPiAgCQlzd2l0Y2ggKGh3LT5jb25mLmNoYW5kZWYud2lkdGgpIHsNCj4g
IAkJY2FzZSBOTDgwMjExX0NIQU5fV0lEVEhfMjBfTk9IVDoNCj4gLS0NCj4gMi4zOC4wDQo+IA0K
PiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0
aGlzIGUtbWFpbC4NCg==
