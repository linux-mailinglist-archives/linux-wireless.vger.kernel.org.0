Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1564CBBC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 15:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiLNOBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 09:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLNOB2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 09:01:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19A7B65EA
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 06:01:25 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BEE0RBt8010997, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BEE0RBt8010997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Dec 2022 22:00:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 14 Dec 2022 22:01:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Dec 2022 22:01:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 14 Dec 2022 22:01:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: pull request: rtw89: 8852c: update fw to v0.27.56.9
Thread-Topic: pull request: rtw89: 8852c: update fw to v0.27.56.9
Thread-Index: AQHZD8SIR/Dk1apsNkuwxqUejT+OFg==
Date:   Wed, 14 Dec 2022 14:01:15 +0000
Message-ID: <f3f5066578b088ee35dd7103a36bb6fc7c543ead.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.60]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE0IOS4iuWNiCAxMDoyMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <70DAD0797F0584418AB3D5DD55C545FC@realtek.com>
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

SGksDQoNClVwZGF0ZSA4ODUyYyBmaXJtd2FyZSBvZiBydHc4OSBkcml2ZXIgdG8gMC4yNy41Ni45
DQoNClRoYW5rIHlvdQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQgZjNjMjgzZTE5OGQzZmI2OWY1MTgzYjhkZWE0ZmQzMmI4YzNjYmU3NjoNCg0KICBh
bWRncHU6IHVwZGF0ZWQgbmF2aTEwIGZpcm13YXJlIGZvciBhbWQtNS40ICgyMDIyLTEyLTE0IDA3
OjQyOjA1IC0wNTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoN
Cg0KICBodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL2xpbnV4LWZpcm13YXJlLmdpdCBIRUFEDQoN
CmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBjOWMxOTU4M2Y3MTcyMTk2M2I0MzVmYzZi
YzlkMWVhYjQ5YzczYWQ0Og0KDQogIHJ0dzg5OiA4ODUyYzogdXBkYXRlIGZ3IHRvIHYwLjI3LjU2
LjkgKDIwMjItMTItMTQgMjE6NTU6NTggKzA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNoaW4tWWVuIExlZSAo
MSk6DQogICAgICBydHc4OTogODg1MmM6IHVwZGF0ZSBmdyB0byB2MC4yNy41Ni45DQoNClBpbmct
S2UgU2hpaCAoMSk6DQogICAgICBydHc4OTogODg1MmM6IHVwZGF0ZSBmdyB0byB2MC4yNy41Ni44
DQoNCiBydHc4OS9ydHc4ODUyY19mdy5iaW4gfCBCaW4gMTUxNjA0MCAtPiAxNTMyNjA4IGJ5dGVz
DQogMSBmaWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KDQo=
