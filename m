Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061346EA9A7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDULs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDULs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 07:48:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F6C5;
        Fri, 21 Apr 2023 04:48:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33LBmiWbB011385, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33LBmiWbB011385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 19:48:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 21 Apr 2023 19:48:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 21 Apr 2023 19:48:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 21 Apr 2023 19:48:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and RTL8851B
Thread-Topic: [PATCH] wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and
 RTL8851B
Thread-Index: AQHZdD43WaZmTDQ5E0ygpx3lZG6afa81H82A
Date:   Fri, 21 Apr 2023 11:48:43 +0000
Message-ID: <7475bff70fd50c7e8527e66080e126b4eff440bb.camel@realtek.com>
References: <e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain>
In-Reply-To: <e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.86.223]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <A43E60BD68A6D74AA0CB8FD21FED96C6@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTIxIGF0IDEzOjQ0ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiANCj4gVGhlIGlmIHN0YXRlbWVudCBpcyByZXZlcnNlZCBzbyBpdCB3aWxsIG5vdCByZWNvcmQg
dGhlIGNoaXAgdmVyc2lvbi4NCj4gVGhpcyB3YXMgZGV0ZWN0ZWQgdXNpbmcgU21hdGNoOg0KPiAN
Cj4gICAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5jOjM1OTMgcnR3
ODlfcmVhZF9jaGlwX3ZlcigpDQo+ICAgICBlcnJvcjogdW5pbml0aWFsaXplZCBzeW1ib2wgJ3Zh
bCcuDQoNCkkgdXNlIHNtYXRjaCB0byBjaGVjayBvdXIgZHJpdmVyIHJlZ3VsYXJseSwgYnV0IEkg
Y2FuJ3QgZmluZCB0aGlzIGVycm9yLg0KV2l0aCB0aGUgbGF0ZXN0IHZlcnNpb24gdjAuNS4wLTgz
MjEtZzU1NjA2NGNhLCBJIHN0aWxsIGNhbid0IGZpbmQgaXQuDQpEbyBJIG5lZWQgdG8gc3BlY2lm
eSBhZGRpdGlvbmFsIGFyZ3VtZW50cz8gVGhhbmtzLiANCg0KPiANCj4gRml4ZXM6IGE2ZmIyYmI4
NDY1NCAoIndpZmk6IHJ0dzg5OiByZWFkIHZlcnNpb24gb2YgYW5hbG9nIGhhcmR3YXJlIikNCj4g
U2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0K
DQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5jIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb3JlLmMNCj4gaW5kZXggN2ZjMGEyNmE0ZDcz
Li4xZDQ2MmM5ZTQ2ZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvY29yZS5jDQo+IEBAIC0zNTg3LDcgKzM1ODcsNyBAQCBzdGF0aWMgdm9pZCBydHc4OV9yZWFk
X2NoaXBfdmVyKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gDQo+ICAgICAgICAgaWYgKGNo
aXAtPmNoaXBfaWQgPT0gUlRMODg1MkIgfHwgY2hpcC0+Y2hpcF9pZCA9PSBSVEw4ODUxQikgew0K
PiAgICAgICAgICAgICAgICAgcmV0ID0gcnR3ODlfbWFjX3JlYWRfeHRhbF9zaShydHdkZXYsIFhU
QUxfU0lfQ1YsICZ2YWwpOw0KPiAtICAgICAgICAgICAgICAgaWYgKCFyZXQpDQo+ICsgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0K
PiAgICAgICAgICAgICAgICAgcnR3ZGV2LT5oYWwuYWN2ID0gdThfZ2V0X2JpdHModmFsLCBYVEFM
X1NJX0FDVl9NQVNLKTsNCj4gLS0NCj4gMi4zOS4yDQo+IA0KPiANCj4gLS0tLS0tUGxlYXNlIGNv
bnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQoNCg0K
