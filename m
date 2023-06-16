Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAF7331CA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbjFPNAw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbjFPNAu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 09:00:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFBC26BA
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 06:00:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35GD0MZZ0006768, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35GD0MZZ0006768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 21:00:22 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 16 Jun 2023 21:00:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Jun 2023 21:00:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 16 Jun 2023 21:00:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH 1/6] wifi: rtw88: use struct instead of macros to set TX desc
Thread-Topic: [PATCH 1/6] wifi: rtw88: use struct instead of macros to set TX
 desc
Thread-Index: AQHZoAUAEQ2VIIe9zkKO5UM2Bxf9Oa+MwDMAgAAeo4A=
Date:   Fri, 16 Jun 2023 13:00:40 +0000
Message-ID: <40b50cf9b3b22a850a16e232b2592926b46e8991.camel@realtek.com>
References: <20230616034431.17403-1-pkshih@realtek.com>
         <20230616034431.17403-2-pkshih@realtek.com>
         <0ce62044-b6a1-ca14-899d-47f7aa807df9@gmail.com>
In-Reply-To: <0ce62044-b6a1-ca14-899d-47f7aa807df9@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.227]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <1756D045E301644292864B3E3C03FB44@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDE0OjEwICswMzAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMTYvMDYvMjAyMyAwNjo0NCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEZy
b206IFBvLUhhbyBIdWFuZyA8cGhodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiANCj4gPiBSZW1vdmUg
bWFjcm9zIHRoYXQgc2V0IFRYIGRlc2NyaXB0b3JzLiBVc2Ugc3RydWN0IGFuZA0KPiA+IGxlMzJf
ZW5jb2RlX2JpdHMoKSB3aXRoIG1hc2sgZGVmaW5pdGlvbnMuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogUG8tSGFvIEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg3MjNkLmMgfCAgIDUgKy0NCj4gPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jICAgICAgIHwgIDc5ICsrKysr
KystLS0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmggICAg
ICAgfCAxMjEgKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvdXNiLmMgICAgICB8ICAxMiArLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEw
NCBpbnNlcnRpb25zKCspLCAxMTMgZGVsZXRpb25zKC0pDQo+ID4gDQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2Iu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gPiBpbmRleCA5
NzZlYWZhNzM5YTJkLi5kYmZkNTU3NmNjMTIwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jDQo+ID4gQEAgLTI0LDExICsyNCwxMiBAQCBzdHJ1Y3Qg
cnR3X3VzYl90eGNiIHsNCj4gPiAgc3RhdGljIHZvaWQgcnR3X3VzYl9maWxsX3R4X2NoZWNrc3Vt
KHN0cnVjdCBydHdfdXNiICpydHd1c2IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgYWdnX251bSkNCj4gPiAgew0KPiA+ICsg
ICAgIHN0cnVjdCBydHdfdHhfZGVzYyAqdHhfZGVzYyA9IChzdHJ1Y3QgcnR3X3R4X2Rlc2MgKilz
a2ItPmRhdGE7DQo+ID4gICAgICAgc3RydWN0IHJ0d19kZXYgKnJ0d2RldiA9IHJ0d3VzYi0+cnR3
ZGV2Ow0KPiA+ICAgICAgIHN0cnVjdCBydHdfdHhfcGt0X2luZm8gcGt0X2luZm87DQo+ID4gDQo+
ID4gLSAgICAgU0VUX1RYX0RFU0NfRE1BX1RYQUdHX05VTShza2ItPmRhdGEsIGFnZ19udW0pOw0K
PiA+IC0gICAgIHBrdF9pbmZvLnBrdF9vZmZzZXQgPSBHRVRfVFhfREVTQ19QS1RfT0ZGU0VUKHNr
Yi0+ZGF0YSk7DQo+ID4gKyAgICAgbGUzMl9yZXBsYWNlX2JpdHModHhfZGVzYy0+dzcsIGFnZ19u
dW0sIFJUV19UWF9ERVNDX1c3X1RYREVTQ19DSEVDS1NVTSk7DQo+IA0KPiBUaGlzIGxvb2tzIGxp
a2UgdGhlIHdyb25nIG1hc2suIFNob3VsZCBpdCBiZSBSVFdfVFhfREVTQ19XN19ETUFfVFhBR0df
TlVNID8NCg0KVGhhdCBpcyB3cm9uZyBpbmRlZWQuIEFsc28sIHNob3VsZCB1c2UgbGUzMnBfcmVw
bGFjZV9iaXRzKCkgaW5zdGVhZC4gDQpXZSBoYXZlIHNlbnQgdjIgdG8gY29ycmVjdCB0aGVtLiAN
ClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IHRoaXMuIA0KDQo+IA0KPiA+ICsgICAgIHBrdF9pbmZv
LnBrdF9vZmZzZXQgPSBsZTMyX2dldF9iaXRzKHR4X2Rlc2MtPncxLCBSVFdfVFhfREVTQ19XMV9Q
S1RfT0ZGU0VUKTsNCj4gPiAgICAgICBydHdfdHhfZmlsbF90eGRlc2NfY2hlY2tzdW0ocnR3ZGV2
LCAmcGt0X2luZm8sIHNrYi0+ZGF0YSk7DQo+ID4gIH0NCj4gPiANCj4gDQo+IC0tLS0tLVBsZWFz
ZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
