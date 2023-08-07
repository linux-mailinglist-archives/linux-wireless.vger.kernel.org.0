Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3296D7719B1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjHGFxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 01:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjHGFxC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 01:53:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01A6C1708
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 22:52:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3775qPr75004485, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3775qPr75004485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 7 Aug 2023 13:52:25 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 7 Aug 2023 13:51:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 7 Aug 2023 13:51:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 7 Aug 2023 13:51:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Regression in rtw89
Thread-Topic: Regression in rtw89
Thread-Index: AQHZxlfTPgsrp0ON2UeQ37Bkk7RKaa/ZRqLAgAI6nICAAtVkoA==
Date:   Mon, 7 Aug 2023 05:51:52 +0000
Message-ID: <a9865ede12a04f87b7a1c78939b11035@realtek.com>
References: <813e9c3d-7fbd-7589-ebd0-6c61f03f970b@lwfinger.net>
 <c58758f5e2134ca19d9a11a0d54b96f1@realtek.com>
 <d144c814-6270-2b64-df78-25c8282050a9@lwfinger.net>
In-Reply-To: <d144c814-6270-2b64-df78-25c8282050a9@lwfinger.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IFN1bmRheSwgQXVndXN0IDYsIDIwMjMgMjoyNCBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzcyA8bGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogUmVncmVzc2lvbiBpbiBydHc4OQ0KPiANCj4g
VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVzcG9uc2UuIFRoZSBPUCBpcyB1c2luZyBrZXJuZWwgNi40
LjcsIHRodXMgaGlzIGJ0cnRsDQo+IHNob3VsZCBiZSBuZXcgZW5vdWdoLiBJIGNvcGllZCB0aGUg
bGF0ZXN0IGZpcm13YXJlIGluIGxpbnV4LWZpcm13YXJlLCBhbmQgaGUNCj4gY29waWVkIGl0IGlu
dG8gdGhlIGFwcHJvcHJpYXRlIGxvY2F0aW9ucy4gVGhhdCBkaWQgbm90IGhlbHAuDQoNCkkgd291
bGQgbGlrZSB0byByZXByb2R1Y2UgdGhpcyBzeW1wdG9tIGluIG15IHNpZGUuIENvdWxkIHlvdSBz
dW1tYXJpemUgdGhlDQpXaUZpIGRyaXZlci9maXJtd2FyZSBhbmQgQlQgZHJpdmVyL2Zpcm13YXJl
IHRoZSBPUCB1c2VzIG5vdz8gV2UgYWxzbyBuZWVkDQp0byBrbm93IHRoZSBCVCBkZXZpY2U/IERv
IHlvdSBoYXZlIHRoZSBkZXZpY2UgbW9kZWwgbmFtZT8NCg0KPiANCj4gSSB0aGVuIGhhZCBoaW0g
Y3JlYXRlIGEgc2NyaXB0IHRvIGNhcHR1cmUgdGhlIGxvZy4gSGUgZm91bmQgdGhhdCBCVCBnb2Vz
IHdyb25nDQo+IGltbWVkaWF0ZWx5IGFzIHNvb24gYXMgcG93ZXJfc2F2ZSBpcyBzZXQgb24uIEhp
cyBsb2dzIHdlcmUgYXMgZm9sbG93czoNCg0KT3VyIGNvZXggdGVhbSBuZWVkcyB0aGUgZnVsbCBs
b2cgaW4gcGVyaW9kIG9mIDIgc2Vjb25kcywgbm90IG9ubHkgdHdvIHNuYXBzaG90LiANClRob3Vn
aCB3ZSBhcmUgdHJ5aW5nIHRvIHJlcHJvZHVjZSwgaXQgbWF5IG5vdCBnZXQgdGhlIHN5bXB0b20g
cmlnaHQgbm93LiANCkNvdWxkIHlvdSBwcm92aWRlIHRoZSBsb2cgZnVsbHk/IA0KY29ubmVjdGlv
biAtLT4gZW50ZXIgUFMgKEJUIGNob3BwZWQgYXVkaW8pIC0+IGxlYXZlIFBTIChCVCBhdWRpbyBh
cyBub3JtYWwpIC0+DQplbnRlciBQUyAoQlQgY2hvcHBlZCBhdWRpbykgDQoNClRoYW5rIHlvdQ0K
UGluZy1LZQ0KDQoNCg==
