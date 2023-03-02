Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8A6A78DC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 02:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCBB21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 20:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBB20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 20:28:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68525CA0D
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 17:28:23 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3221SB9o8003497, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3221SB9o8003497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 2 Mar 2023 09:28:11 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 2 Mar 2023 09:27:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Mar 2023 09:27:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 2 Mar 2023 09:27:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     =?utf-8?B?RnJhbsOnb2lzIFZhbGVuZHVj?= <francoisvalenduc@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Thread-Topic: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Thread-Index: AQHZTAa6Py9EcdEHrE2r44qUUmLSxK7msFmA
Date:   Thu, 2 Mar 2023 01:27:34 +0000
Message-ID: <ad187d12189d45a68bc8bdc229ab5d4e@realtek.com>
References: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
In-Reply-To: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMSDkuIvljYggMTA6Mzc6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbsOnb2lzIFZhbGVu
ZHVjIDxmcmFuY29pc3ZhbGVuZHVjQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxLCAyMDIzIDI6MjYgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBIYW5ncyB3aXRoIE5ldHdvcmtNYW5hZ2VyIGFuZCBydHc4NzIzX2RlIHdpdGgg
a2VybmVsIDYuMQ0KPiANCj4gR29vZCBtb3JuaW5nLA0KPiANCj4gc3lzdGVtcmVzY3VlIHJlY2Vu
dGx5IHN3aXRjaGVkIGZyb20ga2VybmVsIDUuMTUgdG8ga2VybmVsIDYuMSBhbmQNCj4gTmV0d29y
a01hbmFnZXIgc3RhcnRlZCB0byBoYW5ncyBhdCBzdGFydHVwLiBUaGlzIHNlZW1zIHRvIGJlIGxp
bmtlZCB0bw0KPiBteSB3aWZpIGNhcmQgKFJUTDg3MjNERSkuIEkgYW0gYWxzbyBhYmxlIHRvIHJl
cHJvZHVjZSB0aGUgcHJvYmxlbSB1bmRlcg0KPiBnZW50b28gd2l0aCB0aGUgc2FtZSB2ZXJzaW9u
cyBmb3IgTmV0d29ya01hbmFnZXIgYW5kIGxpbnV4LWZpcm13YXJlIHRoYW4NCj4gdGhvc2UgdXNl
ZCBpbiBzeXN0ZW1yZXNjdWUgKDEuNDIuMiBhbmQgMjAyMzAyMTApLiBVbmRlciBnZW50b28sIHRo
ZQ0KPiBwcm9ibGVtIGFwcGVhcnMgd2l0aCBrZXJuZWwgNi4xLjE0IGFuZCA2LjIuMS4gSSBhbSBh
YmxlIHRvIHVzZQ0KPiBOZXR3b3JrTWFuYWdlciBhbmQgc3lzdGVtcmVzY3VlIHdpdGhvdXQgcHJv
YmxlbSBvbiBhbm90aGVyIGNvbXB1dGVyDQo+IHdoaWNoIGhhcyBhbm90aGVyIHdpZmkgY2FyZC4N
Cj4gDQo+IERvZXMgYW55Ym9keSBoYXZlIGEgc29sdXRpb24gdG8gdGhpcyBwcm9ibGVtID8NCj4g
DQoNCkkgdGhpbmsgdGhpcyBwcm9ibGVtIGlzIHRoZSBzYW1lIGFzDQpodHRwczovL2J1Z3ppbGxh
Lmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzAxNg0KDQpQaW5nLUtlDQoNCg0K
