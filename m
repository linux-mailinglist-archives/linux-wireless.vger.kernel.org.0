Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C4CCCB9
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 06:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiCDFBA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 00:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiCDFA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 00:00:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598810A7C6
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 21:00:06 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2244xfXA3031539, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2244xfXA3031539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Mar 2022 12:59:41 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Mar 2022 12:59:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 20:59:40 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Fri, 4 Mar 2022 12:59:40 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: pull request: rtw89: 8852a: update fw to v0.13.36.0
Thread-Topic: pull request: rtw89: 8852a: update fw to v0.13.36.0
Thread-Index: AdgvhJKVLNsz8wrESaCjQiDabAWV3Q==
Date:   Fri, 4 Mar 2022 04:59:40 +0000
Message-ID: <da10ed115e1a4cfa82a6ace518cb3c57@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/3/3_=3F=3F_08:25:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Update firmware of rtw89 driver to v0.13.36.0

Thank you
Ping-Ke

---
The following changes since commit 7f866a1f1da1de427fe2e2875d2c380460080b2f:

  rtw89: 8852a: update fw to v0.13.36.0 (2022-03-04 11:49:01 +0800)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git

for you to fetch changes up to 7f866a1f1da1de427fe2e2875d2c380460080b2f:

  rtw89: 8852a: update fw to v0.13.36.0 (2022-03-04 11:49:01 +0800)

----------------------------------------------------------------

