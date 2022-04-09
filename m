Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF854FA563
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Apr 2022 08:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiDIGVp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Apr 2022 02:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiDIGVo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Apr 2022 02:21:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A923AA5E;
        Fri,  8 Apr 2022 23:19:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2396JGY00012484, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2396JGY00012484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 9 Apr 2022 14:19:16 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 14:19:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Apr 2022 14:19:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Sat, 9 Apr 2022 14:19:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH] rtw89: pci: reversed conditions in rtw89_write16_mdio_mask()
Thread-Topic: [PATCH] rtw89: pci: reversed conditions in
 rtw89_write16_mdio_mask()
Thread-Index: AQHYS9j4UB37KjNlp02PwOAzTJmg7qzmlaQA
Date:   Sat, 9 Apr 2022 06:19:15 +0000
Message-ID: <55fe8f8f382ae27048152c59dfc51be75dd4e658.camel@realtek.com>
References: <20220409061318.GB5447@kili>
In-Reply-To: <20220409061318.GB5447@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.82.63]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvOSDkuIrljYggMDM6NDA6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCDCD34B54B53F4B97A77C518867BE66@realtek.com>
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

T24gU2F0LCAyMDIyLTA0LTA5IGF0IDA5OjEzICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGVzZSBpZiBjb25kaXRpb25zIGFyZSByZXZlcnNlZCBzbyBpdCB3aWxsIGp1c3QgcmV0dXJu
IHN1Y2Nlc3Mgd2l0aG91dA0KPiB3cml0aW5nLg0KPiANCj4gRml4ZXM6IDc0MGM0MzFjMjJmZSAo
InJ0dzg5OiBwY2k6IGFkZCByZWdpc3RlciBkZWZpbml0aW9uIHRvIHJ0dzg5X3BjaV9pbmZvIHRv
IGdlbmVyYWxpemUgcGNpDQo+IGNvZGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9wY2kuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS9wY2kuYw0KPiBpbmRleCBkY2Y5MDdiODFjZmYuLmVjYjQxOTAxMGYwYyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jDQo+IEBAIC0xNTIy
LDcgKzE1MjIsNyBAQCBydHc4OV93cml0ZTE2X21kaW9fbWFzayhzdHJ1Y3QgcnR3ODlfZGV2ICpy
dHdkZXYsIHU4IGFkZHIsIHUxNiBtYXNrLCB1MTYNCj4gZGF0YSwgdQ0KPiAgCXUxNiB2YWw7DQo+
ICANCj4gIAlyZXQgPSBydHc4OV9yZWFkMTZfbWRpbyhydHdkZXYsIGFkZHIsIHNwZWVkLCAmdmFs
KTsNCj4gLQlpZiAoIXJldCkNCj4gKwlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+
ICAJc2hpZnQgPSBfX2ZmcyhtYXNrKTsNCj4gQEAgLTE1MzAsNyArMTUzMCw3IEBAIHJ0dzg5X3dy
aXRlMTZfbWRpb19tYXNrKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggYWRkciwgdTE2IG1h
c2ssIHUxNg0KPiBkYXRhLCB1DQo+ICAJdmFsIHw9ICgoZGF0YSA8PCBzaGlmdCkgJiBtYXNrKTsN
Cj4gIA0KPiAgCXJldCA9IHJ0dzg5X3dyaXRlMTZfbWRpbyhydHdkZXYsIGFkZHIsIHZhbCwgc3Bl
ZWQpOw0KPiAtCWlmICghcmV0KQ0KPiArCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+ICAN
Cj4gIAlyZXR1cm4gMDsNCg0KSSBoYXZlIGZvdW5kIGFuZCBzZW50IGEgcGF0Y2ggdG8gZml4IHRo
aXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIyMDQwODAwMTM1
My4xNzE4OC0xNC1wa3NoaWhAcmVhbHRlay5jb20vVC8jdQ0KDQpUaGFuayB5b3UNClBpbmctS2UN
Cg0KDQo=
