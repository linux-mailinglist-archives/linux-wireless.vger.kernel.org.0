Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459F461EB30
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 07:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKGGwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 01:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKGGwq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 01:52:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E35012775
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 22:52:44 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A76q32O1023862, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A76q32O1023862
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 7 Nov 2022 14:52:03 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 7 Nov 2022 14:52:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 7 Nov 2022 14:52:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Mon, 7 Nov 2022 14:52:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 3/3] wifi: rtl8xxxu: Rename rtl8xxxu_8188f_channel_to_group
Thread-Topic: [PATCH v2 3/3] wifi: rtl8xxxu: Rename
 rtl8xxxu_8188f_channel_to_group
Thread-Index: AQHY8WmnqsejvwpvHE2f6wUlZ4n4qq4zCCxA
Date:   Mon, 7 Nov 2022 06:52:40 +0000
Message-ID: <e58b99d218e2494487114c65f3745e9d@realtek.com>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
 <ba8e3ea2-74f5-e1db-296e-4ae5f03084dc@gmail.com>
In-Reply-To: <ba8e3ea2-74f5-e1db-296e-4ae5f03084dc@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzcg5LiK5Y2IIDA0OjQ3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgNiwg
MjAyMiA2OjU1IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IHYyIDMvM10gd2lmaTogcnRsOHh4eHU6IFJlbmFtZSBydGw4eHh4dV84MTg4Zl9jaGFubmVsX3Rv
X2dyb3VwDQo+IA0KPiBUaGlzIG5hbWUgaXMgYW4gYW5vbWFseS4gQ2hhbmdlIGl0IHRvIHJ0bDgx
ODhmX2NoYW5uZWxfdG9fZ3JvdXAgdG8NCj4gZm9sbG93IHRoZSBzYW1lIHBhdHRlcm4gYXMgdGhl
IG90aGVyIGZ1bmN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYyOg0KPiAgLSBObyBjaGFuZ2UuDQo+IC0t
LQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTg4
Zi5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYw0KPiBpbmRleCA0ZDA0NGE4YmFhMzAuLjBmNzcz
MTJkZDBjYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV84MTg4Zi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYw0KPiBAQCAtMzUyLDcgKzM1Miw3IEBAIHN0YXRp
YyBpbnQgcnRsODE4OGZ1X2lkZW50aWZ5X2NoaXAoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYp
DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgdm9pZCBydGw4eHh4dV84MTg4
Zl9jaGFubmVsX3RvX2dyb3VwKGludCBjaGFubmVsLCBpbnQgKmdyb3VwLCBpbnQgKmNja19ncm91
cCkNCj4gK3N0YXRpYyB2b2lkIHJ0bDgxODhmX2NoYW5uZWxfdG9fZ3JvdXAoaW50IGNoYW5uZWws
IGludCAqZ3JvdXAsIGludCAqY2NrX2dyb3VwKQ0KPiAgew0KPiAgCWlmIChjaGFubmVsIDwgMykN
Cj4gIAkJKmdyb3VwID0gMDsNCj4gQEAgLTM3OCw3ICszNzgsNyBAQCBydGw4MTg4Zl9zZXRfdHhf
cG93ZXIoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIGludCBjaGFubmVsLCBib29sIGh0NDAp
DQo+ICAJdTggY2NrLCBvZmRtYmFzZSwgbWNzYmFzZTsNCj4gIAlpbnQgZ3JvdXAsIGNja19ncm91
cDsNCj4gDQo+IC0JcnRsOHh4eHVfODE4OGZfY2hhbm5lbF90b19ncm91cChjaGFubmVsLCAmZ3Jv
dXAsICZjY2tfZ3JvdXApOw0KPiArCXJ0bDgxODhmX2NoYW5uZWxfdG9fZ3JvdXAoY2hhbm5lbCwg
Jmdyb3VwLCAmY2NrX2dyb3VwKTsNCj4gDQo+ICAJY2NrID0gcHJpdi0+Y2NrX3R4X3Bvd2VyX2lu
ZGV4X0FbY2NrX2dyb3VwXTsNCj4gDQo+IC0tDQo+IDIuMzguMA0KPiANCj4gLS0tLS0tUGxlYXNl
IGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
