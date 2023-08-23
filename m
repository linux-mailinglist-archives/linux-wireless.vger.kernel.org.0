Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D206784E5B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 03:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjHWBos (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 21:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjHWBos (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 21:44:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 298E310D
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 18:44:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37N1hwlmF032733, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37N1hwlmF032733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Aug 2023 09:43:58 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 23 Aug 2023 09:44:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 23 Aug 2023 09:44:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 23 Aug 2023 09:44:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Damon Chen <damon.chen@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] wifi: rtw89: Fix clang -Wimplicit-fallthrough in rtw89_query_sar()
Thread-Topic: [PATCH] wifi: rtw89: Fix clang -Wimplicit-fallthrough in
 rtw89_query_sar()
Thread-Index: AQHZ1Q0rICwq3rdb4kKeSJtfSCPujK/3HGqw
Date:   Wed, 23 Aug 2023 01:44:19 +0000
Message-ID: <c1feebe0159348d2a0e50f58f0e278e6@realtek.com>
References: <20230822-rtw89-tas-clang-implicit-fallthrough-v1-1-5cb73f0fa976@kernel.org>
In-Reply-To: <20230822-rtw89-tas-clang-implicit-fallthrough-v1-1-5cb73f0fa976@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoYW5jZWxs
b3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjIsIDIwMjMg
MTE6MjcgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsga3ZhbG9A
a2VybmVsLm9yZw0KPiBDYzogbmRlc2F1bG5pZXJzQGdvb2dsZS5jb207IHRyaXhAcmVkaGF0LmNv
bTsgRGFtb24gQ2hlbiA8ZGFtb24uY2hlbkByZWFsdGVrLmNvbT47DQo+IGxpbnV4LXdpcmVsZXNz
QHZnZXIua2VybmVsLm9yZzsgcGF0Y2hlc0BsaXN0cy5saW51eC5kZXY7IGxsdm1AbGlzdHMubGlu
dXguZGV2OyBOYXRoYW4gQ2hhbmNlbGxvcg0KPiA8bmF0aGFuQGtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gd2lmaTogcnR3ODk6IEZpeCBjbGFuZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdo
IGluIHJ0dzg5X3F1ZXJ5X3NhcigpDQo+IA0KPiBjbGFuZyB3YXJucyAob3IgZXJyb3JzIHdpdGgg
Q09ORklHX1dFUlJPUj15KToNCj4gDQo+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9zYXIuYzoyMTY6MzogZXJyb3I6IHVuYW5ub3RhdGVkIGZhbGwtdGhyb3VnaCBiZXR3ZWVu
IHN3aXRjaCBsYWJlbHMNCj4gWy1XZXJyb3IsLVdpbXBsaWNpdC1mYWxsdGhyb3VnaF0NCj4gICAg
IDIxNiB8ICAgICAgICAgICAgICAgICBjYXNlIFJUVzg5X1RBU19TVEFURV9EUFJfRk9SQklEOg0K
PiAgICAgICAgIHwgICAgICAgICAgICAgICAgIF4NCj4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L3Nhci5jOjIxNjozOiBub3RlOiBpbnNlcnQgJ2JyZWFrOycgdG8gYXZvaWQg
ZmFsbC10aHJvdWdoDQo+ICAgICAyMTYgfCAgICAgICAgICAgICAgICAgY2FzZSBSVFc4OV9UQVNf
U1RBVEVfRFBSX0ZPUkJJRDoNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgICBeDQo+ICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+IA0K
PiBDbGFuZyBpcyBhIGxpdHRsZSBtb3JlIHBlZGFudGljIHRoYW4gR0NDLCB3aGljaCBkb2VzIG5v
dCB3YXJuIHdoZW4NCj4gZmFsbGluZyB0aHJvdWdoIHRvIGEgY2FzZSB0aGF0IGlzIGp1c3QgYnJl
YWsgb3IgcmV0dXJuLiBDbGFuZydzIHZlcnNpb24NCj4gaXMgbW9yZSBpbiBsaW5lIHdpdGggdGhl
IGtlcm5lbCdzIG93biBzdGFuY2UgaW4gZGVwcmVjYXRlZC5yc3QsIHdoaWNoDQo+IHN0YXRlcyB0
aGF0IGFsbCBzd2l0Y2gvY2FzZSBibG9ja3MgbXVzdCBlbmQgaW4gZWl0aGVyIGJyZWFrLA0KPiBm
YWxsdGhyb3VnaCwgY29udGludWUsIGdvdG8sIG9yIHJldHVybi4gQWRkIHRoZSBtaXNzaW5nIGJy
ZWFrIHRvIHNpbGVuY2UNCj4gdGhlIHdhcm5pbmcuDQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0
aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzE5MjENCj4gRml4ZXM6IGViMjYy
NGY1NWFkMSAoIndpZmk6IHJ0dzg5OiBJbnRyb2R1Y2UgVGltZSBBdmVyYWdlZCBTQVIgKFRBUykg
ZmVhdHVyZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2Vy
bmVsLm9yZz4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
DQoNCg==
