Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21DF4F7998
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbiDGI23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiDGI22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 04:28:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE777F222
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 01:26:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2378QCdC4014307, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2378QCdC4014307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 16:26:12 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 16:26:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 01:26:11 -0700
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Thu, 7 Apr 2022 16:26:11 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: pull request: rtw88: 8821c: Update normal firmware to v24.11.00
Thread-Topic: pull request: rtw88: 8821c: Update normal firmware to v24.11.00
Thread-Index: AQHYSlkjgwCeVK7dJ0ybKZ9OR83hhg==
Date:   Thu, 7 Apr 2022 08:26:11 +0000
Message-ID: <3ea2314b865bfd4799fc5edd998439bba4e59f2a.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.21.190]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyDkuIrljYggMDY6NTE6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4623B0DA97C6F4AA5854CC998DA35F1@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

SGksDQoNClVwZGF0ZSA4ODIxYyBmaXJtd2FyZSBvZiBydHc4OCBkcml2ZXIgdG8gdjI0LjExLjAw
DQoNClRoYW5rIHlvdQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQgMDczMzhmOWQzMzA4OWFiYTY4NTNjYjdiM2ExZDlhODY3NmM4MzU4MDoNCg0KICBy
dHc4ODogODgyMWM6IFVwZGF0ZSBub3JtYWwgZmlybXdhcmUgdG8gdjI0LjExLjAwICgyMDIyLTA0
LTA3IDE2OjIwOjQxICswODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9y
eSBhdDoNCg0KICBodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL2xpbnV4LWZpcm13YXJlLmdpdCAN
Cg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDA3MzM4ZjlkMzMwODlhYmE2ODUzY2I3
YjNhMWQ5YTg2NzZjODM1ODA6DQoNCiAgcnR3ODg6IDg4MjFjOiBVcGRhdGUgbm9ybWFsIGZpcm13
YXJlIHRvIHYyNC4xMS4wMCAoMjAyMi0wNC0wNyAxNjoyMDo0MSArMDgwMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQo=
