Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0F50D60D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiDXXww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 19:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiDXXwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 19:52:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0DD95D5
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 16:49:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23ONnjBmB011503, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23ONnjBmB011503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Apr 2022 07:49:45 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 07:49:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 07:49:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Mon, 25 Apr 2022 07:49:44 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kevlo@kevlo.org" <kevlo@kevlo.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: use the correct bit in the REG_HCI_OPT_CTRL register
Thread-Topic: [PATCH] rtw88: use the correct bit in the REG_HCI_OPT_CTRL
 register
Thread-Index: AQHYVlhhJ9uh8lO800a36ANjrZYUQKz/OReA
Date:   Sun, 24 Apr 2022 23:49:44 +0000
Message-ID: <d18c6bde75dce55a547fc43cb6b28a68d94d097e.camel@realtek.com>
References: <YmLAzuyPr0P4Y6BP@ns.kevlo.org>
In-Reply-To: <YmLAzuyPr0P4Y6BP@ns.kevlo.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.87.177]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjQg5LiL5Y2IIDA3OjE0OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9A2B1355D37F3409BBA01539EB5D71B@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTIyIGF0IDIyOjUwICswODAwLCBLZXZpbiBMbyB3cm90ZToNCj4gV3Jp
dGUgdGhlIEJJVF9VU0JfU1VTX0RJUyBiaXQgcmF0aGVyIHRoYW4gQklUX0JUX0RJR19DTEtfRU4g
dG8gdGhlDQo+IFJFR19IQ0lfT1BUX0NUUkwgcmVnaXN0ZXIgZm9yIGZpeGluZyBmYWlsdXJlIHRv
IFBDSWUgcG93ZXIgb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBMbyA8a2V2bG9Aa2V2
bG8ub3JnPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoN
Cj4gLS0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L21hYy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWMuYw0KPiBpbmRl
eCBkMTY3OGFlZDlkOWMuLmNhZjI2MDNkYTJkNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWMuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L21hYy5jDQo+IEBAIC03NSw3ICs3NSw3IEBAIHN0YXRpYyBpbnQgcnR3
X21hY19wcmVfc3lzdGVtX2NmZyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KPiAgDQo+ICAJc3dp
dGNoIChydHdfaGNpX3R5cGUocnR3ZGV2KSkgew0KPiAgCWNhc2UgUlRXX0hDSV9UWVBFX1BDSUU6
DQo+IC0JCXJ0d193cml0ZTMyX3NldChydHdkZXYsIFJFR19IQ0lfT1BUX0NUUkwsIEJJVF9CVF9E
SUdfQ0xLX0VOKTsNCj4gKwkJcnR3X3dyaXRlMzJfc2V0KHJ0d2RldiwgUkVHX0hDSV9PUFRfQ1RS
TCwgQklUX1VTQl9TVVNfRElTKTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBSVFdfSENJX1RZUEVf
VVNCOg0KPiAgCQlicmVhazsNCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVu
dCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQoNCg0K
