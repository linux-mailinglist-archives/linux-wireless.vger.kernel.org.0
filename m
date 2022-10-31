Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82608612E8E
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 02:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJaBJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 21:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaBJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 21:09:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A192A195
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 18:09:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29V18WX60011072, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29V18WX60011072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 31 Oct 2022 09:08:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 31 Oct 2022 09:09:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 31 Oct 2022 09:09:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Mon, 31 Oct 2022 09:09:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v3 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
Thread-Topic: [PATCH v3 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
Thread-Index: AQHY6uwE5PMr8KlZi0KZN41mS2jLnq4ntNWA
Date:   Mon, 31 Oct 2022 01:09:07 +0000
Message-ID: <9dd7b9634d754afb97a70bd5bf0fadc0@realtek.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
 <f5ceeb63-bfd2-0fe5-c88b-2bc4c9c7c46a@gmail.com>
In-Reply-To: <f5ceeb63-bfd2-0fe5-c88b-2bc4c9c7c46a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzMwIOS4i+WNiCAxMDowMDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI5
LCAyMDIyIDEyOjQwIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYzIDUvNV0gd2lmaTogcnRsOHh4eHU6IFVzZSBkZXZfaW5mbyBpbnN0ZWFkIG9mIHByX2lu
Zm8NCj4gDQo+IFJlcGxhY2UgdHdvIGluc3RhbmNlcyBvZiBiYXJlIHByX2luZm8gd2l0aCBkZXZf
aW5mby4NCj4gDQo+IEFsc28gbWFrZSB0aGVpciBtZXNzYWdlcyBhIGxpdHRsZSBtb3JlIGluZm9y
bWF0aXZlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFs
dGVrLmNvbT4NCg0KPiAtLS0NCj4gdjM6DQo+ICAtIE5vIGNoYW5nZS4NCj4gDQo+IHYyOg0KPiAg
LSBObyBjaGFuZ2UuDQo+IC0tLQ0KDQpbLi4uXQ0KDQo=
