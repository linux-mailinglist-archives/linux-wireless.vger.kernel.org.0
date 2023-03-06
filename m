Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E76AB44C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCFBXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 20:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFBX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 20:23:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9BA264
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 17:23:27 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3261N34h8022088, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3261N34h8022088
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 6 Mar 2023 09:23:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Mar 2023 09:22:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Mar 2023 09:22:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 6 Mar 2023 09:22:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: pull request: rtlwifi: Add firmware v16.0 for RTL8710BU aka RTL8188GU
Thread-Topic: pull request: rtlwifi: Add firmware v16.0 for RTL8710BU aka
 RTL8188GU
Thread-Index: AQHZT8ob3WvWEi+5y0G+Qry/CArSug==
Date:   Mon, 6 Mar 2023 01:22:25 +0000
Message-ID: <ab0289ec80471df43308c550e9fe4e0ac8b9cdc5.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvNSDkuIvljYggMDc6MzY6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4D915ACAFD45E40A9CCB11365BF3A6B@realtek.com>
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

SGksDQoNCnJ0bDh4eHh1IGlzIGdvaW5nIHRvIHN1cHBvcnQgODcxMEJVLCBzbyBhZGQgZmlybXdh
cmUgZm9yIHRoaXMgZGV2aWNlLg0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0KLS0tDQpUaGUgZm9s
bG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDYwOTcxYTY0ODVlZTYwNGM0N2NjOTA1ZmY3N2M1
ODNhZTAwMWY5ZGY6DQoNCiAgTWVyZ2UgYnJhbmNoICdsaXF1aWRpby0yMDIzMDIyMicgb2YgaHR0
cHM6Ly9naXRodWIuY29tL2RjaGlja2xlcy9saW51eC1maXJtd2FyZSAoMjAyMy0wMi0yNw0KMTI6
MzM6MDcgLTA1MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
DQogIGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUuZ2l0IEhFQUQNCg0K
Zm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDRjYzNlZGE2MzYwZjBkYWEzMTY0N2RlMTI5
YTAwMWU0MDg2MDJlOTc6DQoNCiAgcnRsd2lmaTogQWRkIGZpcm13YXJlIHYxNi4wIGZvciBSVEw4
NzEwQlUgYWthIFJUTDgxODhHVSAoMjAyMy0wMy0wNiAwOToxNjo1OCArMDgwMCkNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KQml0dGVyYmx1ZSBTbWl0aCAoMSk6DQogICAgICBydGx3aWZpOiBBZGQgZmlybXdhcmUgdjE2
LjAgZm9yIFJUTDg3MTBCVSBha2EgUlRMODE4OEdVDQoNCiBXSEVOQ0UgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA1ICsrKysrDQogcnRsd2lmaS9ydGw4NzEwYnVmd19TTUlDLmJpbiB8IEJpbiAw
IC0+IDIzNzUwIGJ5dGVzDQogcnRsd2lmaS9ydGw4NzEwYnVmd19VTUMuYmluICB8IEJpbiAwIC0+
IDIyNjU0IGJ5dGVzDQogMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgcnRsd2lmaS9ydGw4NzEwYnVmd19TTUlDLmJpbg0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBydGx3aWZpL3J0bDg3MTBidWZ3X1VNQy5iaW4NCg0KDQo=
