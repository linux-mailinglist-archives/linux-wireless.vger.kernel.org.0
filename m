Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38E691703
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Feb 2023 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBJDJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Feb 2023 22:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBJDJy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Feb 2023 22:09:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294452597A
        for <linux-wireless@vger.kernel.org>; Thu,  9 Feb 2023 19:09:52 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31A39dFB2023826, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31A39dFB2023826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 10 Feb 2023 11:09:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Feb 2023 11:09:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 10 Feb 2023 11:09:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 10 Feb 2023 11:09:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: pull request: rtw88: 8822c: Update normal firmware to v9.9.14
Thread-Topic: pull request: rtw88: 8822c: Update normal firmware to v9.9.14
Thread-Index: AQHZPP0cT5hgR6R3akSr29YtOEwlqQ==
Date:   Fri, 10 Feb 2023 03:09:39 +0000
Message-ID: <95bf72c328de6450d8e0136317ea849830e4f67e.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzIvOSDkuIvljYggMTE6NDU6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1ED3F9C5D610A4CBA2575EE3C72646C@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClVwZGF0ZSA4ODIyYyBmaXJtd2FyZSBvZiBydHc4OCBkcml2ZXIgdG8gdjkuOS4xNA0K
DQpUaGFuayB5b3UNClBpbmctS2UNCg0KLS0tDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2Ug
Y29tbWl0IDVjMTFhMzc0Mjk0NzgxMGVlOGJmZmJkNDc2ZWI1YTFiMGM3OTk5ZjI6DQoNCiAgYW1k
Z3B1OiBBZGQgVkNOIDQuMC4yIGZpcm13YXJlICgyMDIzLTAxLTI1IDA3OjQwOjQxIC0wNTAwKQ0K
DQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dp
dGh1Yi5jb20vcGtzaGloL2xpbnV4LWZpcm13YXJlLmdpdCBIRUFEDQoNCmZvciB5b3UgdG8gZmV0
Y2ggY2hhbmdlcyB1cCB0byBjM2YzYmFhZGExY2NjOWI0YzhmNGJkODM4MDM2MTEwYmU2NDAwY2U1
Og0KDQogIHJ0dzg4OiA4ODIyYzogVXBkYXRlIG5vcm1hbCBmaXJtd2FyZSB0byB2OS45LjE0ICgy
MDIzLTAyLTEwIDExOjAyOjIxICswODAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDaGluLVllbiBMZWUgKDEpOg0K
ICAgICAgcnR3ODg6IDg4MjJjOiBVcGRhdGUgbm9ybWFsIGZpcm13YXJlIHRvIHY5LjkuMTQNCg0K
IHJ0dzg4L3J0dzg4MjJjX2Z3LmJpbiB8IEJpbiAyMDI1NTIgLT4gMjAyNTUyIGJ5dGVzDQogMSBm
aWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KDQo=
