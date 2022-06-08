Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7C5422D6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiFHCzH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 22:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444372AbiFHCxh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 22:53:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72EC1B82A1
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 17:26:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2580PRs14013596, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2580PRs14013596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 8 Jun 2022 08:25:27 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 8 Jun 2022 08:25:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 08:25:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Wed, 8 Jun 2022 08:25:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Thread-Topic: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Thread-Index: AQHYb4QquNlgqX2VSESbLHcGkKULkq1D3fwAgAAnIgCAALd/MA==
Date:   Wed, 8 Jun 2022 00:25:26 +0000
Message-ID: <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
 <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
 <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
In-Reply-To: <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvNyDkuIvljYggMTA6MDA6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnJ5IEZpbmdlciA8bGFy
cnkuZmluZ2VyQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIExhcnJ5IEZpbmdlcg0KPiBTZW50OiBX
ZWRuZXNkYXksIEp1bmUgOCwgMjAyMiA1OjI2IEFNDQo+IFRvOiBOYXRoYW4gQ2hhbmNlbGxvciA8
bmF0aGFuQGtlcm5lbC5vcmc+DQo+IENjOiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsg
Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD47DQo+IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZzsgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC80XSBydHc4ODogRml4IFNwYXJzZSB3YXJuaW5nIGZv
ciBydHc4ODIxY19od19zcGVjDQo+IA0KPiBPbiA2LzcvMjIgMTQ6MDUsIE5hdGhhbiBDaGFuY2Vs
bG9yIHdyb3RlOg0KPiA+IEhpIExhcnJ5LA0KPiA+DQo+ID4gT24gVHVlLCBNYXkgMjQsIDIwMjIg
YXQgMTA6Mzc6MTZBTSAtMDUwMCwgTGFycnkgRmluZ2VyIHdyb3RlOg0KPiA+PiBTcGFyc2UgbGlz
dHMgdGhlIGZvbGxvd2luZzoNCj4gPj4NCj4gPj4gICAgQ0hFQ0sgICBkcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMNCj4gPj4gZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9ydHc4ODIxYy5jOjE4ODA6MjI6IHdhcm5pbmc6IHN5bWJvbCAncnR3ODgy
MWNfaHdfc3BlYycgd2FzIG5vdA0KPiBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4g
Pj4NCj4gPj4gVGhlIHdhcm5pbmcgYXJpc2VzIGJlY2F1c2UgdGhlIGV4dGVybmFsIGRlY2xhcmF0
aW9uIGZvciBydHc4ODIxY19od19zcGVjDQo+ID4+IG9jY3VycyBpbiBydHc4ODIxY2UuaCwgd2hp
Y2ggaXMgbm90IGluY2x1ZGVkIGluIHJ0dzg4MjFjLmguIFRoYXQgbGluZSBpcw0KPiA+PiBtb3Zl
ZCwgYW5kIHRoZSBub3cgZW1wdHkgZmlsZSBydHc4ODIxY2UuaCBpcyBkZWxldGVkLg0KPiA+Pg0K
PiA+PiBTeW1ib2wgJ3J0dzg4MjFjX2h3X3NwZWMnIGNhbiBiZSBtYWRlIGNvbnN0YW50Lg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdl
ci5uZXQ+DQo+ID4NCj4gPiBJIGJpc2VjdGVkIHRoaXMgY2hhbmdlIGFzIGNvbW1pdCA4OWQ4ZjUz
ZmY2ZTcgKCJ3aWZpOiBydHc4ODogRml4IFNwYXJzZQ0KPiA+IHdhcm5pbmcgZm9yIHJ0dzg4MjFj
X2h3X3NwZWMiKSBpbiBsaW51eC1uZXh0IGFzIHRoZSBjYXVzZSBvZiBvbmUgb2YgbXkNCj4gPiB0
ZXN0IG1hY2hpbmVzIGZhaWxpbmcgdG8gYm9vdCB3aXRoIHRoZSBmb2xsb3dpbmcgc3RhY2t0cmFj
ZToNCj4gPg0KPiA+IEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNz
OiBmZmZmZmZmZmMwOWY1MmY0DQo+ID4gI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBr
ZXJuZWwgbW9kZQ0KPiANCj4gTmF0aGFuLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGV4Y2VsbGVu
dCByZXBvcnQuIERvZXMgdGhlIGF0dGFjaGVkIHBhdGNoIGZpeCB5b3VyIGlzc3VlPw0KPiANCg0K
SGkgTGFycnksDQoNCkhvdyBhYm91dCBrZWVwaW5nIHJ0dzg4MjFjX2h3X3NwZWMgY29uc3QsIGJ1
dCBtb3ZlIGNoX3BhcmFtWzNdIGZyb20gDQonc3RydWN0IHJ0d19jaGlwX2luZm8nIHRvICdzdHJ1
Y3QgcnR3X2hhbCc/DQoNCklmIHlvdSBhZ3JlZSB0aGlzLCBJIGNhbiBwcmVwYXJlIGEgcGF0Y2gu
DQoNClBpbmctS2UNCg0K
