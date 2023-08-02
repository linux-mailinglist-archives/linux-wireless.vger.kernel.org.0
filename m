Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F04676C30E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHBCrA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 22:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjHBCq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 22:46:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1CF11BFD
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 19:46:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3722kWLI1004149, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3722kWLI1004149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 2 Aug 2023 10:46:32 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 2 Aug 2023 10:46:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 2 Aug 2023 10:46:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 2 Aug 2023 10:46:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: pull request: rtw89: 8851b: update firmware to v0.29.41.1
Thread-Topic: pull request: rtw89: 8851b: update firmware to v0.29.41.1
Thread-Index: AQHZxOuEIn3qDV6G5ECsRKO/r3tpyg==
Date:   Wed, 2 Aug 2023 02:46:21 +0000
Message-ID: <d42463c65334bc1799648b116b9e0daecf57c844.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F039494D5DBB747B133432C5D54E889@realtek.com>
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

SGksDQoNClVwZGF0ZSA4ODUxYiBmaXJtd2FyZSBvZiBydHc4OSBkcml2ZXIgdG8gdjAuMjkuNDEu
MQ0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0KLS0tDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2lu
Y2UgY29tbWl0IDI1M2NjMTc5ZDg0OWZjODI0ODk3NzNiMmI1NTNhNDk4NThkODcyNWY6DQoNCiAg
YW1kZ3B1OiBVcGRhdGUgRE1DVUIgZm9yIERDTjMxNCAmIFllbGxvdyBDYXJwICgyMDIzLTA3LTMx
IDExOjIyOjAyIC0wNDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoNCg0KICBodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL2xpbnV4LWZpcm13YXJlLmdpdCBIRUFE
DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAyOWYxODVkNzVjNDVhYjk2NDczYjRl
ZTA2YmM4MmMwYjNmZjk2NmI1Og0KDQogIHJ0dzg5OiA4ODUxYjogdXBkYXRlIGZpcm13YXJlIHRv
IHYwLjI5LjQxLjEgKDIwMjMtMDgtMDIgMTA6NDE6NTkgKzA4MDApDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNoaW4t
WWVuIExlZSAoMSk6DQogICAgICBydHc4OTogODg1MWI6IHVwZGF0ZSBmaXJtd2FyZSB0byB2MC4y
OS40MS4xDQoNCiBydHc4OS9ydHc4ODUxYl9mdy5iaW4gfCBCaW4gMTA5MDU0NCAtPiAxMTYxMDA4
IGJ5dGVzDQogMSBmaWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkN
Cg0K
