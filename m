Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53566C7D3B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjCXLcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCXLb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 07:31:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4286E1B55B
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 04:31:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32OBUssV6010541, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32OBUssV6010541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 24 Mar 2023 19:30:54 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Mar 2023 19:31:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 24 Mar 2023 19:31:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 24 Mar 2023 19:31:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: pull request: rtw88: 8822c: Update normal firmware to v9.9.15
Thread-Topic: pull request: rtw88: 8822c: Update normal firmware to v9.9.15
Thread-Index: AQHZXkQg4BVPI2F8DkqQ1aXRQNZG/w==
Date:   Fri, 24 Mar 2023 11:31:08 +0000
Message-ID: <b02dace035e2b58686f8c7f449be6be3f32a6485.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.18.182]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMjQg5LiK5Y2IIDA5OjM1OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6B81FB31EDBA4DA6327ECBFA79BCBE@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClVwZGF0ZSA4ODIyYyBmaXJtd2FyZSBvZiBydHc4OCBkcml2ZXIgdG8gdjkuOS4xNQ0K
DQpUaGFuayB5b3UNClBpbmctS2UNCg0KLS0tDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2Ug
Y29tbWl0IGJjZGNmYmNmMGE4ZjI0YTkxNGI4YzE2MzkwNmU2Y2U5M2Q3Zjg4OTc6DQoNCiAgbGlu
dXgtZmlybXdhcmU6IFVwZGF0ZSBmaXJtd2FyZSBmaWxlIGZvciBJbnRlbCBCbHVldG9vdGggQVgx
MDEgKDIwMjMtMDMtMjAgMDg6MzQ6MjcgLTA0MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdp
dCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmly
bXdhcmUuZ2l0IEhFQUQNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGU0MGE1YjYz
MjQzZGJjMGE3NzU0M2QzOTc1NjU4ZmQ2NjhlZjI1ODY6DQoNCiAgcnR3ODg6IDg4MjJjOiBVcGRh
dGUgbm9ybWFsIGZpcm13YXJlIHRvIHY5LjkuMTUgKDIwMjMtMDMtMjQgMTk6MjY6NTcgKzA4MDAp
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NClBvLUhhbyBIdWFuZyAoMSk6DQogICAgICBydHc4ODogODgyMmM6IFVwZGF0
ZSBub3JtYWwgZmlybXdhcmUgdG8gdjkuOS4xNQ0KDQogcnR3ODgvcnR3ODgyMmNfZncuYmluIHwg
QmluIDIwMjU1MiAtPiAyMDI2MDAgYnl0ZXMNCiAxIGZpbGUgY2hhbmdlZCwgMCBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQ0KDQo=
