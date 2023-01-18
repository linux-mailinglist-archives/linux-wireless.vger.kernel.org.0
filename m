Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7368670FC8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 02:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjARBRA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 20:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjARBQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 20:16:41 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FB123B3D4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 17:10:45 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30I1AfIvA001735, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30I1AfIvA001735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 18 Jan 2023 09:10:41 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 18 Jan 2023 09:10:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Jan 2023 09:10:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 18 Jan 2023 09:10:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/4] wifi: rtl8xxxu: Add LED control code for RTL8188EU
Thread-Topic: [PATCH 2/4] wifi: rtl8xxxu: Add LED control code for RTL8188EU
Thread-Index: AQHZKr+hBKCnte1s1Uqdke8JF0mK4a6jXcBQ
Date:   Wed, 18 Jan 2023 01:10:41 +0000
Message-ID: <66d281f4c74e44c8adee2653603adec1@realtek.com>
References: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
 <77a0ec12-3711-7f21-5b99-95388f0648b1@gmail.com>
In-Reply-To: <77a0ec12-3711-7f21-5b99-95388f0648b1@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTcg5LiL5Y2IIDExOjIwOjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAx
OCwgMjAyMyA2OjA0IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi80XSB3aWZpOiBydGw4eHh4
dTogQWRkIExFRCBjb250cm9sIGNvZGUgZm9yIFJUTDgxODhFVQ0KPiANCj4gQnkgZGVmYXVsdCB0
aGUgTEVEIHdpbGwgYmxpbmsgd2hlbiB0aGVyZSBpcyBzb21lIGFjdGl2aXR5Lg0KPiANCj4gVGhp
cyB3YXMgdGVzdGVkIHdpdGggYSBUUC1MaW5rIFRMLVdONzI1Ti4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNClsuLi5dDQoNCg==
