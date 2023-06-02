Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96971FA2D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjFBGhU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjFBGhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 02:37:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF9128
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 23:37:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3526arWA3008692, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3526arWA3008692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 14:36:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Jun 2023 14:37:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Jun 2023 14:37:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 2 Jun 2023 14:37:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: remove unused dualmac control leftovers
Thread-Topic: [PATCH] wifi: rtlwifi: remove unused dualmac control leftovers
Thread-Index: AQHZlRNtqztN1SpYGEm3yxYB0jUrka92iESA
Date:   Fri, 2 Jun 2023 06:37:07 +0000
Message-ID: <54bbc84ecf47f253749ff74ffa1fe892709ceb3a.camel@realtek.com>
References: <20230602052936.114649-1-dmantipov@yandex.ru>
In-Reply-To: <20230602052936.114649-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.72.35]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E45FF21761B9EF4597882452083EA254@realtek.com>
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

T24gRnJpLCAyMDIzLTA2LTAyIGF0IDA4OjI5ICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gDQo+IFJlbW92ZSAnc3RydWN0IHJ0bF9kdWFsbWFjX2Vhc3lfY29uY3VycmVudF9jdGwnIG9m
ICdzdHJ1Y3QgcnRsX3ByaXYnDQo+IGFuZCByZWxhdGVkIGNvZGUgaW4gJ19ydGxfcGNpX3R4X2No
a193YWl0cSgpJy4NCj4gDQo+IFRoaXMgaXMgYSBmb2xsb3d1cCBvZiBiYzRiODNkNjQwNzcgKCJ3
aWZpOiBydGx3aWZpOiByZW1vdmUgdW51c2VkDQo+IHRpbWVyIGFuZCByZWxhdGVkIGNvZGUiKS4N
Cg0KTWVudGlvbiBjb21taXQgU0hBMSBvbmx5IGlmIGl0IGdldHMgbWVyZ2VkIGluIHdpcmVsZXNz
LW5leHQgYXQgbGVhc3QuDQpJZiB3YW50IHRvIHNheSB0aGVpciBkZXBlbmRlbmN5LCB5b3UgY2Fu
IGRlc2NyaWJlIHRoZSBkZXBlbmRlbmN5DQpmb2xsb3dlZCBieSAnLS0tJyBsaWtlIGNoYW5nZWxv
ZywgYnV0IGJldHRlciB3YXkgaXMgdGhhdCB5b3UgY2FuDQpzZW5kIHR3byBwYXRjaGVzIGluIHNp
bmdsZSBvbmUgcGF0Y2hzZXQuIA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgQW50aXBv
diA8ZG1hbnRpcG92QHlhbmRleC5ydT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bHdpZmkvcGNpLmMgIHwgNSAtLS0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGx3aWZpL3dpZmkuaCB8IDkgLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsd2lmaS9wY2kuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsd2lmaS9wY2kuYw0KPiBpbmRleCBjYTc5ZjY1MmZlZjMuLjAyOGE3Yzk3YmFjZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3BjaS5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9wY2kuYw0KPiBAQCAtNDgy
LDExICs0ODIsNiBAQCBzdGF0aWMgdm9pZCBfcnRsX3BjaV90eF9jaGtfd2FpdHEoc3RydWN0IGll
ZWU4MDIxMV9odyAqaHcpDQo+ICAgICAgICAgaWYgKCFydGxwcml2LT5ydGxoYWwuZWFybHltb2Rl
X2VuYWJsZSkNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IC0gICAgICAgaWYgKHJ0
bHByaXYtPmRtLnN1cHBfcGh5bW9kZV9zd2l0Y2ggJiYNCj4gLSAgICAgICAgICAgKHJ0bHByaXYt
PmVhc3lfY29uY3VycmVudF9jdGwuc3dpdGNoX2luX3Byb2Nlc3MgfHwNCj4gLSAgICAgICAgICAg
KHJ0bHByaXYtPmJ1ZGR5X3ByaXYgJiYNCj4gLSAgICAgICAgICAgcnRscHJpdi0+YnVkZHlfcHJp
di0+ZWFzeV9jb25jdXJyZW50X2N0bC5zd2l0Y2hfaW5fcHJvY2VzcykpKQ0KPiAtICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPiAgICAgICAgIC8qIHdlIGp1c3QgdXNlIGVtIGZvciBCRS9CSy9WSS9W
TyAqLw0KPiAgICAgICAgIGZvciAodGlkID0gNzsgdGlkID49IDA7IHRpZC0tKSB7DQo+ICAgICAg
ICAgICAgICAgICB1OCBod19xdWV1ZSA9IGFjX3RvX2h3cVtydGxfdGlkX3RvX2FjKHRpZCldOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3dpZmku
aA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS93aWZpLmgNCj4gaW5k
ZXggYmMxZDY4Y2I5MTgzLi4zMDdlMDU5ZWM4YWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS93aWZpLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGx3aWZpL3dpZmkuaA0KPiBAQCAtMjQ5NiwxNCArMjQ5Niw2IEBAIHN0
cnVjdCBydGxfZGVidWcgew0KPiAgI2RlZmluZSBNSU1PX1BTX0RZTkFNSUMgICAgICAgICAgICAg
ICAgICAgICAgICAxDQo+ICAjZGVmaW5lIE1JTU9fUFNfTk9MSU1JVCAgICAgICAgICAgICAgICAg
ICAgICAgIDMNCj4gDQo+IC1zdHJ1Y3QgcnRsX2R1YWxtYWNfZWFzeV9jb25jdXJyZW50X2N0bCB7
DQo+IC0gICAgICAgZW51bSBiYW5kX3R5cGUgY3VycmVudGJhbmR0eXBlX2JhY2tmb3JkbWRwOw0K
PiAtICAgICAgIGJvb2wgY2xvc2VfYmJhbmRyZl9mb3JfZG1zcDsNCj4gLSAgICAgICBib29sIGNo
YW5nZV90b19kbWRwOw0KPiAtICAgICAgIGJvb2wgY2hhbmdlX3RvX2Rtc3A7DQo+IC0gICAgICAg
Ym9vbCBzd2l0Y2hfaW5fcHJvY2VzczsNCj4gLX07DQo+IC0NCj4gIHN0cnVjdCBydGxfZG1zcF9j
dGwgew0KPiAgICAgICAgIGJvb2wgYWN0aXZlc2Nhbl9mb3Jfc2xhdmVvZmRtc3A7DQo+ICAgICAg
ICAgYm9vbCBzY2FuX2Zvcl9hbm90aGVybWFjX2ZvcmRtc3A7DQo+IEBAIC0yNzQ0LDcgKzI3MzYs
NiBAQCBzdHJ1Y3QgcnRsX3ByaXYgew0KPiAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgbGlzdDsN
Cj4gICAgICAgICBzdHJ1Y3QgcnRsX3ByaXYgKmJ1ZGR5X3ByaXY7DQo+ICAgICAgICAgc3RydWN0
IHJ0bF9nbG9iYWxfdmFyICpnbGJfdmFyOw0KPiAtICAgICAgIHN0cnVjdCBydGxfZHVhbG1hY19l
YXN5X2NvbmN1cnJlbnRfY3RsIGVhc3lfY29uY3VycmVudF9jdGw7DQo+ICAgICAgICAgc3RydWN0
IHJ0bF9kbXNwX2N0bCBkbXNwX2N0bDsNCj4gICAgICAgICBzdHJ1Y3QgcnRsX2xvY2tzIGxvY2tz
Ow0KPiAgICAgICAgIHN0cnVjdCBydGxfd29ya3Mgd29ya3M7DQo+IC0tDQo+IDIuNDAuMQ0KPiAN
Cg==
