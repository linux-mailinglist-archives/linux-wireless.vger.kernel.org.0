Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ACE651A75
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 06:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiLTF7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 00:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTF7j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 00:59:39 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90F17FCF1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 21:59:38 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BK5whUL3007973, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BK5whUL3007973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Dec 2022 13:58:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 20 Dec 2022 13:59:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Dec 2022 13:59:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 20 Dec 2022 13:59:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v3 2/5] wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take const char*
Thread-Topic: [PATCH v3 2/5] wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take
 const char*
Thread-Index: AQHZEiHLJHgpL1CVUEOP4qKtRDOuu652TB3w
Date:   Tue, 20 Dec 2022 05:59:33 +0000
Message-ID: <d9e6c1ba839649c6918c79bf3a191285@realtek.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
 <361ceac1-cc73-605b-4b63-736bfce80833@gmail.com>
In-Reply-To: <361ceac1-cc73-605b-4b63-736bfce80833@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIwIOS4iuWNiCAwMjoyNDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAx
NywgMjAyMiAxMDoxNCBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MyAyLzVdIHdpZmk6IHJ0bDh4eHh1OiBNYWtlIHJ0bDh4eHh1X2xvYWRfZmlybXdhcmUg
dGFrZSBjb25zdCBjaGFyKg0KPiANCj4gQW5kIHBhc3MgY29uc3QgY2hhciogdG8gaXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+
IC0tLQ0KPiB2MzoNCj4gIC0gTm8gY2hhbmdlLg0KPiANCj4gdjI6DQo+ICAtIFBhdGNoIGlzIG5l
dyBpbiB2Mi4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1LmggICAgICAgfCAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMgfCAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJjLmMgfCAyICstDQo+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJlLmMgfCAyICstDQo+ICBk
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzg3MjNhLmMgfCAy
ICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzg3
MjNiLmMgfCAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYyAgfCAyICstDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4gDQoNClsuLi5dDQoNCg==
