Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D38557903
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiFWLsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiFWLsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 07:48:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF084BFEA
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 04:48:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25NBm6Ml9000739, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25NBm6Ml9000739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 19:48:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 23 Jun 2022 19:48:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.027; Thu, 23 Jun 2022 19:48:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: pull request: rtw88: 8822c: Update normal firmware to v9.9.13
Thread-Topic: pull request: rtw88: 8822c: Update normal firmware to v9.9.13
Thread-Index: AQHYhvcY0jbwk/MbBk++mQlR0Ka+9A==
Date:   Thu, 23 Jun 2022 11:48:03 +0000
Message-ID: <8fa3de7a18829a865933c4d4ab2b49f6e60a1054.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.223]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjMg5LiK5Y2IIDA4OjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7618FB3C4D7BC44BC3C61B7EA94DAD0@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClVwZGF0ZSA4ODIyYyBmaXJtd2FyZSBvZiBydHc4OCBkcml2ZXIgdG8gOS45LjEyLzku
OS4xMy4NCg0KVGhhbmsgeW91DQpQaW5nLUtlDQoNCi0tLQ0KVGhlIGZvbGxvd2luZyBjaGFuZ2Vz
IHNpbmNlIGNvbW1pdCA3ZWVmNTBmODM4OTZkYzU3NDU4MmQ2OWEzNmE2NDM3MjIzNjViMDRjOg0K
DQogIHJ0dzg4OiA4ODIyYzogVXBkYXRlIG5vcm1hbCBmaXJtd2FyZSB0byB2OS45LjEzICgyMDIy
LTA2LTIzIDE5OjM5OjU4ICswODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL2xpbnV4LWZpcm13YXJlLmdp
dCANCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDdlZWY1MGY4Mzg5NmRjNTc0NTgy
ZDY5YTM2YTY0MzcyMjM2NWIwNGM6DQoNCiAgcnR3ODg6IDg4MjJjOiBVcGRhdGUgbm9ybWFsIGZp
cm13YXJlIHRvIHY5LjkuMTMgKDIwMjItMDYtMjMgMTk6Mzk6NTggKzA4MDApDQo=
