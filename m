Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A844E3B3B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 09:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiCVIyK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCVIyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 04:54:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8067DE22
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 01:52:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22M8qQ221028037, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22M8qQ221028037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Mar 2022 16:52:26 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 16:52:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 16:52:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Tue, 22 Mar 2022 16:52:25 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Stefan K <Shadow_7@gmx.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RE: rtw89: unstable connection
Thread-Topic: RE: rtw89: unstable connection
Thread-Index: AQHYPRok8gD20x9bsU6oG/M1WzUcY6zK7kDA//+jdICAAIe24A==
Date:   Tue, 22 Mar 2022 08:52:25 +0000
Message-ID: <8e9bee3d3062450fba7f3f3e14d21c8a@realtek.com>
References: <2127068.tFZMq15b3B@t460-skr>
 <c9ff4269e3864ee4bd437a40678a9e5f@realtek.com>
 <trinity-ddca7a32-b0cd-440d-9018-f1da4af9be6a-1647938655236@3c-app-gmx-bap19>
In-Reply-To: <trinity-ddca7a32-b0cd-440d-9018-f1da4af9be6a-1647938655236@3c-app-gmx-bap19>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjIg5LiK5Y2IIDA3OjIzOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gSyA8U2hh
ZG93XzdAZ214Lm5ldD4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjIsIDIwMjIgNDo0NCBQTQ0K
PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IEF3OiBSRTog
cnR3ODk6IHVuc3RhYmxlIGNvbm5lY3Rpb24NCj4gDQo+IEhlbGxvLA0KPiANCj4gSSByYW4gdmVy
c2lvbiAwLjkuMTIuMiwgbm93IEkgdXNpbmcgMC4xMy4zNi4wDQo+IA0KPiBBbmQgaXQgd29ya3Mg
ZmluZSBhbmQgbG9va3Mgc3RhYmxlIHNvIGZhci4NCj4gDQo+IEJ1dCBmcm9tIHRpbWUgdG8gdGlt
ZSBJIGdvdCB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzIChkb24ndCBrbm93IHdoYXQgaXQgbWVhbik6
DQo+IFsgIDQxMi4wMzYzNDddIHJ0dzg5Xzg4NTJhZSAwMDAwOjAzOjAwLjA6IG1hYyBjMmggY2xh
c3MgMSBmdW5jIDIgbm90IHN1cHBvcnQNCj4gWyAgNDEyLjAzNjM1M10gcnR3ODlfODg1MmFlIDAw
MDA6MDM6MDAuMDogbWFjIGMyaCBjbGFzcyAxIGZ1bmMgMiBub3Qgc3VwcG9ydA0KPiBbICA0NDIu
MDUxNTgxXSBydHc4OV84ODUyYWUgMDAwMDowMzowMC4wOiBtYWMgYzJoIGNsYXNzIDEgZnVuYyAy
IG5vdCBzdXBwb3J0DQo+IFsgIDQ0Mi4wNTE1OTFdIHJ0dzg5Xzg4NTJhZSAwMDAwOjAzOjAwLjA6
IG1hYyBjMmggY2xhc3MgMSBmdW5jIDIgbm90IHN1cHBvcnQNCj4gDQoNClRoZXNlIGFyZSBkZWJ1
ZyBtZXNzYWdlcy4gVG8gYXZvaWQgdGhlbSwgSSBoYXZlIHN1Ym1pdHRlZCBhIHBhdGNoLCBidXQg
aXQgaXMgaGFybWxlc3MgdGhvdWdoLg0KDQotLQ0KUGluZy1LZQ0KDQo=
