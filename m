Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC73788001
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjHYGhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbjHYGgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 02:36:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62CE51BDB
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 23:36:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37P6a2J31013971, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37P6a2J31013971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 14:36:02 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 25 Aug 2023 14:36:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Aug 2023 14:36:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 25 Aug 2023 14:36:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: pull request: rtw89: update 8851b and 8852b firmware to v0.29.41.2 and v0.29.29.3 respectively
Thread-Topic: pull request: rtw89: update 8851b and 8852b firmware to
 v0.29.41.2 and v0.29.29.3 respectively
Thread-Index: AQHZ1x5woak1hwseR0qFQRMbZI3uZA==
Date:   Fri, 25 Aug 2023 06:36:11 +0000
Message-ID: <65ae8880b5ed2ed726256c8954bb0e457e75b950.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E9C6D06FA808440B780A25FAC2F980B@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk1CU1NJRCBudW1iZXIgY291bGQgcG90ZW50aWFsbHkgZXhjZWVkIGFycmF5IHNpemUs
IHNvIHVwZGF0ZSBmaXJtd2FyZSB0bw0KZml4IHRoZSBwcm9ibGVtIGZvciA4ODUxYiBhbmQgODg1
MmIuDQoNClRoYW5rIHlvdQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBz
aW5jZSBjb21taXQgMGUwNDhiMDYxYmRlNzlhZDczNWM3YjdiNTE2MWVlMWJkMzQwMDE1MDoNCg0K
ICBNZXJnZSBicmFuY2ggJ2Zvci11cHN0cmVhbScgb2YgaHR0cHM6Ly9naXRodWIuY29tL0NpcnJ1
c0xvZ2ljL2xpbnV4LWZpcm13YXJlICgyMDIzLTA4LTE0IDEzOjAzOjQxDQotMDQwMCkNCg0KYXJl
IGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIu
Y29tL3Brc2hpaC9saW51eC1maXJtd2FyZS5naXQgSEVBRA0KDQpmb3IgeW91IHRvIGZldGNoIGNo
YW5nZXMgdXAgdG8gZWY0MWFlOGY2NTNjMzAyZjcxYWUxMDBmODY0NjMwYTNiNjYxMDUxMjoNCg0K
ICBydHc4OTogODg1MmI6IHVwZGF0ZSBmdyB0byB2MC4yOS4yOS4zICgyMDIzLTA4LTI1IDE0OjI5
OjUyICswODAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDaGluLVllbiBMZWUgKDIpOg0KICAgICAgcnR3ODk6IDg4
NTFiOiB1cGRhdGUgZncgdG8gdjAuMjkuNDEuMg0KICAgICAgcnR3ODk6IDg4NTJiOiB1cGRhdGUg
ZncgdG8gdjAuMjkuMjkuMw0KDQogcnR3ODkvcnR3ODg1MWJfZncuYmluICAgfCBCaW4gMTE2MTAw
OCAtPiAxMTYwOTg0IGJ5dGVzDQogcnR3ODkvcnR3ODg1MmJfZnctMS5iaW4gfCBCaW4gMTE4NDk5
MiAtPiAxMjM3NzA0IGJ5dGVzDQogMiBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pDQoNCg==
