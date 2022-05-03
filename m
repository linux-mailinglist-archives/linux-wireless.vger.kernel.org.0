Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B163517B23
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiECAJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 20:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiECAJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 20:09:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330635AB1
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 17:05:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24305ja06017955, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24305ja06017955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 May 2022 08:05:45 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 08:05:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 08:05:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Tue, 3 May 2022 08:05:45 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 01/16] rtw89: 8852c: rfk: add RFK tables
Thread-Topic: [PATCH v2 01/16] rtw89: 8852c: rfk: add RFK tables
Thread-Index: AQHYW5ln57WGjoFhxkiAuoU9SntzOa0KozmAgAGoKlA=
Date:   Tue, 3 May 2022 00:05:45 +0000
Message-ID: <5ada5443e13044e9b366cc365e58bf19@realtek.com>
References: <20220429071809.32104-2-pkshih@realtek.com>
 <165147395131.22580.17272377169555802599.kvalo@kernel.org>
In-Reply-To: <165147395131.22580.17272377169555802599.kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMiDkuIvljYggMTA6MDE6MDA=?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGxlIFZhbG8gPGt2YWxv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDIsIDIwMjIgMjo0NiBQTQ0KPiBUbzog
UGtzaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMS8xNl0gcnR3ODk6IDg4NTJjOiBy
Zms6IGFkZCBSRksgdGFibGVzDQo+IA0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IFRoZXNlIHRhYmxlcyBhcmUgdXNlZCBieSBSRksgKFJGIGNhbGli
cmF0aW9uKSB0byBzZXQgcGFyYW1ldGVycy4gVGhlc2UNCj4gPiBwYXJhbWV0ZXJzIGNhbiB0cmln
Z2VyIGNlcnRhaW4gY2FsaWJyYXRpb24sIG9yIGNvbmZpZ3VyZS9yZXNldCBzZXR0aW5ncw0KPiA+
IGJlZm9yZSBhbmQgYWZ0ZXIgUkYgY2FsaWJyYXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiAxNiBwYXRjaGVzIGlz
IHRvbyBtdWNoLCBJIG9ubHkgcmV2aWV3ZWQgcGF0Y2hlcyAxLTguIFBsZWFzZSBzcGxpdCB0aGlz
DQo+IHBhdGNoc2V0IGludG8gdHdvLg0KPiANCg0KSSBoYXZlIHNlbnQgdjMgb25seSBjb250YWlu
aW5nIDggcGF0Y2hlcywgYW5kIGZpeCB0aGVtIGFjY29yZGluZyB0byBjb21tZW50cy4NCg0KVGhh
bmsgeW91DQpQaW5nLUtlDQoNCg0K
