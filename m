Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F6966DD2A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjAQMEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 07:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjAQMEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 07:04:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011D736B15
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 04:04:03 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30HC3tj86022689, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30HC3tj86022689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Jan 2023 20:03:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 17 Jan 2023 20:03:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Jan 2023 20:03:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 17 Jan 2023 20:03:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull request: rtw89: 8852c: update fw to v0.27.56.10
Thread-Topic: pull request: rtw89: 8852c: update fw to v0.27.56.10
Thread-Index: AQHZKmvGYPnKs/cPfUmuD8EDLzC3xA==
Date:   Tue, 17 Jan 2023 12:03:56 +0000
Message-ID: <b00c91825affe825a7411391a10135bec0354664.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.17.65]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTcg5LiK5Y2IIDEwOjU3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <484609BDE03E1744BDBA08E14B0F7868@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClVwZGF0ZSA4ODUyYyBmaXJtd2FyZSBvZiBydHc4OSBkcml2ZXIgdG8gdjAuMjcuNTYu
MTANCg0KVGhhbmsgeW91DQpQaW5nLUtlDQoNCi0tLQ0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNp
bmNlIGNvbW1pdCBhMWFkMWQ1YjUwNjI2ZjJkMTI2YWRmMTk2NGNlMGU5OGNiYjhiMzlkOg0KDQog
IGFtZGdwdTogYWRkIFZDTjQuMC40IGZpcm13YXJlIGZyb20gYW1kLTUuNCAoMjAyMy0wMS0xMCAx
MDowODo0MCAtMDUwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6
DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9saW51eC1maXJtd2FyZS5naXQgSEVBRA0K
DQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZmM1YTI1ZmEwMjJjN2UyOGVjZmMyY2Vk
NGVhMzA5YWQ2MWNhMTQyZToNCg0KICBydHc4OTogODg1MmM6IHVwZGF0ZSBmdyB0byB2MC4yNy41
Ni4xMCAoMjAyMy0wMS0xNyAxOTo1Nzo0MyArMDgwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUGluZy1LZSBTaGlo
ICgxKToNCiAgICAgIHJ0dzg5OiA4ODUyYzogdXBkYXRlIGZ3IHRvIHYwLjI3LjU2LjEwDQoNCiBy
dHc4OS9ydHc4ODUyY19mdy5iaW4gfCBCaW4gMTUzMjYwOCAtPiAxNTMyNjU2IGJ5dGVzDQogMSBm
aWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KDQo=
