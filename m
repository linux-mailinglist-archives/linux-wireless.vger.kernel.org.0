Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6A7EA7E8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKNAwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 19:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKNAwi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 19:52:38 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F2D4E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 16:52:35 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE0qNNK1459854, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE0qNNK1459854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 08:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 14 Nov 2023 08:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 14 Nov 2023 08:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 14 Nov 2023 08:52:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: EFUSE in RTW8723DS
Thread-Topic: EFUSE in RTW8723DS
Thread-Index: AQHaFBQbaER/+8rOBUK6A5kkYXA52rB4/Z5Q
Date:   Tue, 14 Nov 2023 00:52:23 +0000
Message-ID: <748b045e7aaa43eb9a7fb83ad924614f@realtek.com>
References: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net>
In-Reply-To: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IFNhdHVyZGF5LCBOb3ZlbWJlciAxMSwgMjAyMyA0OjI2IEFNDQo+IFRvOiBNYXJ0aW4gQmx1bWVu
c3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPg0KPiBDYzogbGludXgt
d2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogRUZV
U0UgaW4gUlRXODcyM0RTDQo+IA0KPiBNYXJ0aW4sDQo+IA0KPiBUaGUgY29tbWl0IDliZTIwYTgy
MjMyNyAoIndpZmk6IHJ0dzg4OiBydHc4NzIzZDogSW1wbGVtZW50IFJUTDg3MjNEUyAoU0RJTykN
Cj4gZWZ1c2UgcGFyc2luZyIpIGluZGljYXRlcyB0aGF0IG5vIGFkZGl0aW9uYWwgaW5mb3JtYXRp
b24gaXMgZXh0cmFjdGVkIGZyb20gdGhlDQo+IEVGVVNFPyBJcyB0aGF0IHRydWUsIG9yIGRpZCBJ
IG1pc3JlYWQgdGhlIGNvZGU/DQoNCkkgdGhpbmsgdGhlIGNvbW1pdCBpcyBvbmx5IHRvIHJlYWQg
TUFDIGFkZHJlc3MgdGhhdCBpcyBwcm9ncmFtbWVkIGluIGRpZmZlcmVudA0KbG9jYXRpb24gZnJv
bSBQQ0kgaW50ZXJmYWNlLCBhbmQgbm8gbW9yZSBpbmZvcm1hdGlvbi4gDQoNCj4gDQo+IE9uZSBw
cm9ibGVtIHdlIGFyZSBoYXZpbmcgaXMgdGhhdCBzb21lIGRldmljZXMgY29tZSB3aXRoIHplcm8g
cHJvZ3JhbW1pbmcgaW4gdGhlDQo+IEVGVVNFLCBhbmQgZXZlbiB3aXRoIHN1cHBseWluZyBhIHZh
bGlkIE1BQyBhZGRyZXNzLCB0aGUgcGVyZm9ybWFuY2UgaXMgcG9vci4NCg0KT25lIG9yIHR3byB5
ZWFycyBhZ28sIHBlb3BsZSByZXBvcnRlZCBlZnVzZSBvZiBSVEw4MTkyREUgKElJUkMpIGlzbid0
IHByb2dyYW1tZWQNCmluIE9wZW5XUlQgcGxhdGZvcm0gb3JpZ2luYWxseS4gVGhhdCBraW5kIG9m
IHByb2R1Y3QsIGNhbGlicmF0aW9uIHZhbHVlcyBhcmUgc3RvcmVkDQppbiBleHRlcm5hbCBmaWxl
cyBpbnN0ZWFkLCBhbmQgY2hpcCBpcyBzb2xkZXJlZCBvbiBtYWluIGJvYXJkIGluc3RlYWQgb2Yg
YQ0Kc2VwYXJhdGVkIGhhcmR3YXJlIG1vZHVsZSBzdWNoIE0uMi4NCg0KTWF5YmUsIHdlIGNhbiBy
ZWFkIGNhbGlicmF0aW9uIHZhbHVlcyBwcm9ncmFtbWVkIGluIGVmdXNlIGFzIF9kZWZhdWx0XyB2
YWx1ZXMNCmZyb20gYW5vdGhlciBtb2R1bGUuIFRoaXMgY2FuJ3QgeWllbGQgdGhlIGJlc3QgcGVy
Zm9ybWFuY2UsIGJ1dCBhdCBsZWFzdCBiZXR0ZXINCnRoYW4gbm90aGluZy4gDQoNClBpbmctS2UN
Cg0KDQo=
