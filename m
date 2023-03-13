Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49B6B6D58
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCMCME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Mar 2023 22:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCMCMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Mar 2023 22:12:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8781B2B616
        for <linux-wireless@vger.kernel.org>; Sun, 12 Mar 2023 19:12:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32D2BdknE026423, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32D2BdknE026423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 13 Mar 2023 10:11:39 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 13 Mar 2023 10:11:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 13 Mar 2023 10:11:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 13 Mar 2023 10:11:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>, Jiajie Chen <c@jia.je>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8710BU aka
 RTL8188GU
Thread-Index: AQHZUgTb1JQ6CjZInkaofWl5rHFKQa7zJnywgAChsoCABDXNMA==
Date:   Mon, 13 Mar 2023 02:11:49 +0000
Message-ID: <0e08c94a0a2447eb935a65e0b44d172a@realtek.com>
References: <d4c5073a-4831-7353-6ea7-06dfd3cca7f2@gmail.com>
 <8c3edda0b6944d4fafe08cea89b94142@realtek.com>
 <07f780e8-7b9e-c3cf-02dd-48325bd1f3b7@gmail.com>
In-Reply-To: <07f780e8-7b9e-c3cf-02dd-48325bd1f3b7@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxMSwg
MjAyMyAxOjUzIEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMuU29y
ZW5zZW5AZ21haWwuY29tPjsgSmlhamllIENoZW4gPGNAamlhLmplPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyXSB3aWZpOiBydGw4eHh4dTogU3VwcG9ydCBuZXcgY2hpcCBSVEw4NzEwQlUgYWth
IFJUTDgxODhHVQ0KPiANCj4gT24gMTAvMDMvMjAyMyAwMjo0OSwgUGluZy1LZSBTaGloIHdyb3Rl
Og0KPiA+DQo+ID4gMi4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV84NzEwYi5jOjE0ODcgcnRsODcxMGJ1X3BoeV9pcV9jYWxpYnJhdGUoKSBlcnJvcjoNCj4g
dW5pbml0aWFsaXplZCBzeW1ib2wgJ3JlZ19lOTQnLg0KPiA+DQo+ID4gVGhpcyBjb3VsZCBiZSBh
IGZhbHNlLWFsYXJtIHRvby4gJ3JlZ19lOTQnIG11c3QgYmUgc2V0IGlmICdjYW5kaWRhdGUgPj0g
MCcsIGJ1dA0KPiA+IG9yaWdpbmFsIHN0YXRlbWVudCBjYXVzZXMgc21hdGNoIGhhcmQgdG8gZGV0
ZXJtaW5lOg0KPiA+DQo+ID4gICAgaWYgKHJlZ19lOTQgJiYgY2FuZGlkYXRlID49IDApDQo+ID4N
Cj4gPiBzd2FwIHRoZSBleHByZXNzaW9ucyB0byBmaXggdGhlIHdhcm5pbmc6DQo+ID4NCj4gPiAg
IGlmIChjYW5kaWRhdGUgPj0gMCAmJiByZWdfZTk0KQ0KPiA+DQo+IA0KPiBNb3ZpbmcgImlmIChy
ZWdfZTk0KSIgaW5zaWRlIHRoZSBwcmV2aW91cyAiaWYgKGNhbmRpZGF0ZSA+PSAwKSIgc2hvdWxk
IGFsc28NCj4gZml4IGl0LCBJIHRoaW5rLg0KPiANCj4gICAgICAgICBpZiAoY2FuZGlkYXRlID49
IDApIHsNCj4gICAgICAgICAgICAgICAgIHJlZ19lOTQgPSByZXN1bHRbY2FuZGlkYXRlXVswXTsN
Cj4gICAgICAgICAgICAgICAgIHJlZ19lOWMgPSByZXN1bHRbY2FuZGlkYXRlXVsxXTsNCj4gICAg
ICAgICAgICAgICAgIHJlZ19lYTQgPSByZXN1bHRbY2FuZGlkYXRlXVsyXTsNCj4gICAgICAgICAg
ICAgICAgIHJlZ19lYWMgPSByZXN1bHRbY2FuZGlkYXRlXVszXTsNCj4gDQo+ICAgICAgICAgICAg
ICAgICBkZXZfZGJnKGRldiwgIiVzOiBjYW5kaWRhdGUgaXMgJXhcbiIsIF9fZnVuY19fLCBjYW5k
aWRhdGUpOw0KPiAgICAgICAgICAgICAgICAgZGV2X2RiZyhkZXYsICIlczogZTk0PSV4IGU5Yz0l
eCBlYTQ9JXggZWFjPSV4XG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
cmVnX2U5NCwgcmVnX2U5YywgcmVnX2VhNCwgcmVnX2VhYyk7DQo+IA0KPiAgICAgICAgICAgICAg
ICAgcGF0aF9hX29rID0gdHJ1ZTsNCj4gDQo+ICAgICAgICAgICAgICAgICBpZiAocmVnX2U5NCkN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcnRsOHh4eHVfZmlsbF9pcWtfbWF0cml4X2EocHJp
diwgcGF0aF9hX29rLCByZXN1bHQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNhbmRpZGF0ZSwgKHJlZ19lYTQgPT0gMCkpOw0KPiAgICAgICAg
IH0NCj4gDQoNCkluZGVlZCwgSSBoYXZlIGNvbmZpcm1lZCBpdCB3b3Jrcy4NCg0KDQo=
