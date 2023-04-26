Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7A6EECD7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 05:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbjDZDzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 23:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDZDzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 23:55:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4927910FE
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 20:55:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33Q3tSH01015459, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33Q3tSH01015459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 26 Apr 2023 11:55:28 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 26 Apr 2023 11:55:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Apr 2023 11:55:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 26 Apr 2023 11:55:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by access null page
Thread-Topic: [PATCH] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused
 by access null page
Thread-Index: AQHZc/Q43bCi4aFIaU2MU/XWEKULoq87sSOAgAFK80A=
Date:   Wed, 26 Apr 2023 03:55:29 +0000
Message-ID: <4c77e52cd5924c55af50662bb8214dce@realtek.com>
References: <20230421015357.13940-1-pkshih@realtek.com>
 <2784bfc8-9c5a-8e0c-aa0c-0864078e31b7@lwfinger.net>
In-Reply-To: <2784bfc8-9c5a-8e0c-aa0c-0864078e31b7@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IFdlZG5lc2RheSwgQXByaWwgMjYsIDIwMjMgMTI6MDQgQU0NCj4gVG86IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPjsga3ZhbG9Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IHJ0dzg5OiA4
ODUyYjogYWRqdXN0IHF1b3RhIHRvIGF2b2lkIFNFUiBMMSBjYXVzZWQgYnkgYWNjZXNzIG51bGwg
cGFnZQ0KPiANCj4gDQo+IFRlc3RlZC1ieTogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdm
aW5nZXIubmV0Pg0KPiANCj4gVGhpcyBwYXRjaCBoYXMgbm93IGJlZW4gYWRkZWQgdG8gdGhlIHJl
cG8gYXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5LmdpdC4NCj4gDQo+IEFs
dGhvdWdoIGl0IGhhcyBiZWVuIGFwcGxpZWQgdGhlcmUgZm9yIG9ubHkgYSBjb3VwbGUgb2YgZGF5
cywgaXQgaGFzIGZpeGVkDQo+IHRpbWluZyBwcm9ibGVtcyBvbiBzZXZlcmFsIG5ldyBIUCBsYXB0
b3BzIFsxXVsyXS4NCj4gDQo+IE15IHJlY29tbWVuZGF0aW9uIGlzIHRoYXQgdGhpcyBiZSBkZXNp
Z25hdGVkIGEgIkZpeGVzOiIgcGF0Y2gsIGJlIGFwcGxpZWQgdG8NCj4ga2VybmVsIDYuNCwgYW5k
IGJlIHNlbnQgdG8gNi4zIHRocm91Z2ggdGhlICJTdGFibGUiIG1lY2hhbmlzbS4NCj4gDQo+IExh
cnJ5DQo+IA0KPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5L2lzc3Vlcy8y
MjYjaXNzdWVjb21tZW50LTE1MjA3NzY3NjENCj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zp
bmdlci9ydHc4OS9pc3N1ZXMvMjQwDQo+IA0KDQpJIGhhdmUgc2VudCB2MiB3aXRoIHRoZXNlIHRh
Z3M6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIzMDQyNjAzNDcz
Ny4yNDg3MC0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNClBpbmctS2UNCg0KDQo=
