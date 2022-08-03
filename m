Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B1588629
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Aug 2022 06:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiHCEFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Aug 2022 00:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiHCEFa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Aug 2022 00:05:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032E926AD8
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 21:05:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27344kKdA014643, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27344kKdA014643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 3 Aug 2022 12:04:46 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 12:04:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 12:04:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97]) by
 RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97%5]) with mapi id
 15.01.2375.007; Wed, 3 Aug 2022 12:04:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Andrew than <linux_kernel_aathan@memeplex.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Terrible performance form Lenovo Ideapad using RTL8852AE 802.11ax on 5.17 kernel (ubuntu)
Thread-Topic: Terrible performance form Lenovo Ideapad using RTL8852AE
 802.11ax on 5.17 kernel (ubuntu)
Thread-Index: AQHYppoaKv+VpNdKYUqNNr/YeMmyWK2cd1mw
Date:   Wed, 3 Aug 2022 04:04:54 +0000
Message-ID: <92eaa483104f49b3bb48ec22263aa4e5@realtek.com>
References: <0cdbbf6f-5003-946b-7910-dbfbb83ee31b@memeplex.com>
In-Reply-To: <0cdbbf6f-5003-946b-7910-dbfbb83ee31b@memeplex.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMyDkuIrljYggMDE6MjM6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
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

SGksIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyB0aGFu
IDxsaW51eF9rZXJuZWxfYWF0aGFuQG1lbWVwbGV4LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBB
dWd1c3QgMywgMjAyMiAxOjU0IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogVGVycmlibGUgcGVyZm9ybWFuY2UgZm9ybSBMZW5vdm8gSWRlYXBhZCB1
c2luZyBSVEw4ODUyQUUgODAyLjExYXggb24gNS4xNyBrZXJuZWwgKHVidW50dSkNCj4gDQo+IEhl
bGxvIGFsbDoNCj4gDQo+IFBsZWFzZSBkaXJlY3QgbWUgb24gd2hhdCBhZGRpdGlvbmFsIGluZm9y
bWF0aW9uIEkgY2FuIHByb3ZpZGUuDQo+IA0KPiBJIHJlY2VudGx5IGFkZGVkIGEgTGVub3ZvIElk
ZWFwYWQgdG8gbXkgd2lmaSBuZXR3b3JrLiBUd28gbWFjIGhvc3RzIG9uDQo+IHRoYXQgbmV0d29y
ayBleHBlcmllbmNlIG5vIGlzc3VlIHdoYXRzb2V2ZXIgd2l0aCB0aGUgbmV0d29yayAoZGVza3Rv
cCArDQo+IG1hY3BybyBsYXB0b3ApLg0KPiANCj4gQSBzaW1wbGUgc2NwIHRlc3QgYmV0d2VlbiB0
aGUgZGVza3RvcCAmIG1hY3BybyB2cyBkZXNrdG9wICYgbGVub3ZvDQo+IHlpZWxkcyBhIDUwJSBk
aWZmZXJlbmNlIGluIHRocm91Z2hwdXQuDQoNClBsZWFzZSBzaGFyZSB0aGUgcmVhbCB0aHJvdWdo
cHV0IHlvdSBzYXcuDQoNClRvIGNoZWNrIHRoZSBzdGF0dXMgZHVyaW5nIHlvdSBkbyBzY3AgdGVz
dCwgcGxlYXNlIGVudGVyIGRlYnVnIGVudHJ5IG9mIHRoaXMgZHJpdmVyLA0KYW5kIGNhcHR1cmUg
bG9nIGJ5Og0KDQogIC9zeXMva2VybmVsL2RlYnVnL2llZWU4MDIxMS9waHkwL3J0dzg5JCB3aGls
ZSBbIDEgXTsgZG8gY2F0IHBoeV9pbmZvOyBzbGVlcCAyOyBkb25lIHwgdGVlIHNjcF90ZXN0Lmxv
Zw0KDQpUaGVuLCBzZW5kIHRoZSByZXN1bHQgdG8gbWUuIElmIHRoZXJlIGlzIHByaXZhY3kgcHJv
YmxlbSwgcGxlYXNlIHNlbmQNCnByaXZhdGUgbWFpbCB0byBtZSBkaXJlY3RseS4NCg0KQWxzbywg
eW91IGNhbiB0cnkgJ2l3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9mZicgdG8gc2VlIGlmIGl0IGhl
bHBzLg0KDQpbLi4uXQ0KDQo+ICDCoMKgwqDCoMKgwqAgY29uZmlndXJhdGlvbjogYnJvYWRjYXN0
PXllcyBkcml2ZXI9cnR3ODlfcGNpDQo+IGRyaXZlcnZlcnNpb249NS4xNy4wLTEwMTQtb2VtIGZp
cm13YXJlPU4vQSBpcD0xOTIuMTY4LngueCBsYXRlbmN5PTANCj4gbGluaz15ZXMgbXVsdGljYXN0
PXllcyB3aXJlbGVzcz1JRUVFIDgwMi4xMQ0KPiAgwqDCoMKgwqDCoMKgIHJlc291cmNlczogaXJx
OjY0IGlvcG9ydDoyMDAwKHNpemU9MjU2KSBtZW1vcnk6ZDE2MDAwMDAtZDE2ZmZmZmYNCj4gDQoN
ClBsZWFzZSBjaGVjayBmaXJtd2FyZSB5b3UgYXJlIHVzaW5nIHZpYSAvdmFyL2xvZy9rZXJuLmxv
ZzoNClRoZSBmaXJtd2FyZSB2ZXJzaW9uIGxvb2tzIGxpa2U6DQogICBydHc4OV84ODUyYWUgMDAw
MDowMzowMC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuMTMuMzYuMCwgY21kIHZlcnNpb24gMCwgdHlw
ZSAxDQogICBydHc4OV84ODUyYWUgMDAwMDowMzowMC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuMTMu
MzYuMCwgY21kIHZlcnNpb24gMCwgdHlwZSAzDQoNCg0KUGluZy1LZQ0KDQo=
