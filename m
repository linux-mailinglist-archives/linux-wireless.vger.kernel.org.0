Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610A26D90AF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjDFHnP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjDFHmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 03:42:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5C7A8D
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 00:42:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3367fn7tB005656, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3367fn7tB005656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 15:41:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 6 Apr 2023 15:42:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 6 Apr 2023 15:42:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 6 Apr 2023 15:42:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     Timlee <timlee@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull request: rtw89: update firmware of 8852b and 8852c
Thread-Topic: pull request: rtw89: update firmware of 8852b and 8852c
Thread-Index: AQHZaFtKYkxwST97a0G0PKpVUG5xpg==
Date:   Thu, 6 Apr 2023 07:42:08 +0000
Message-ID: <72e35b08661be39a97b12896c26496874418950d.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C0928E1CF4E8F4385B9E49374950CDB@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
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

SGksDQoNClVwZGF0ZSB0d28gZmlybXdhcmUgb2YgcnR3ODkgZHJpdmVyIC0tIDg4NTJiIHYwLjI5
LjI5LjEgYW5kIDg4NTJjIHYwLjI3LjU2LjEzLg0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0KLS0t
DQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDJlOTJhNDlmOTBmNzNjOGVkYzQ0
YjI1YzZlNjY5ZDVlNzA4OTNjOTA6DQoNCiAgbnZpZGlhOiB1cGRhdGUgVHUxMHggYW5kIFR1MTF4
IHNpZ25lZCBmaXJtd2FyZSB0byBzdXBwb3J0IG5ld2VyIFR1cmluZyBIVyAoMjAyMy0wNC0wNCAw
ODowMzo1Mw0KLTA0MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
Og0KDQogIGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUuZ2l0IEhFQUQN
Cg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDlmNzUwMmYxZGJiMTZhZWEyMTIyMDA0
ZGQ2MDdlMDNjYTZhNjJjMGI6DQoNCiAgcnR3ODk6IDg4NTJiOiB1cGRhdGUgZm9ybWF0LTEgZncg
dG8gdjAuMjkuMjkuMSAoMjAyMy0wNC0wNiAxNTozMjoxMiArMDgwMCkNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQ2hp
bi1ZZW4gTGVlICgxKToNCiAgICAgIHJ0dzg5OiA4ODUyYzogdXBkYXRlIGZ3IHRvIHYwLjI3LjU2
LjEzDQoNClBpbmctS2UgU2hpaCAoMSk6DQogICAgICBydHc4OTogODg1MmI6IHVwZGF0ZSBmb3Jt
YXQtMSBmdyB0byB2MC4yOS4yOS4xDQoNCiBydHc4OS9ydHc4ODUyYl9mdy0xLmJpbiB8IEJpbiAx
MTg4NDg4IC0+IDExODQ5OTIgYnl0ZXMNCiBydHc4OS9ydHc4ODUyY19mdy5iaW4gICB8IEJpbiAx
NTMyNjU2IC0+IDE1MzI3MzYgYnl0ZXMNCiAyIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkNCg0K
