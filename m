Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B149B70F191
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjEXI5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbjEXI53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 04:57:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9890132
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 01:57:27 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34O8YebsE031126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34O8YebsE031126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 16:34:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 24 May 2023 16:34:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 24 May 2023 16:34:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 24 May 2023 16:34:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull reques [v3]t: rtw89: 8851b: add firmware v0.29.41.0
Thread-Topic: pull reques [v3]t: rtw89: 8851b: add firmware v0.29.41.0
Thread-Index: AdmOGmoMCVNQIP+kRjGOG3ZL0CKpxA==
Date:   Wed, 24 May 2023 08:34:51 +0000
Message-ID: <7c011b352b344cae8fa6b3a1beb71d8f@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Add initial firmware of rtw89 driver for newly supported chip 8851BE.

Add the missing WHENCE by v2.
Modify driver description to mention RTL8851B by v3.

Thank you
Ping-Ke
---
The following changes since commit 1ba3519eab0fbc3cedf6b423ea0470461b902c1b:

  Merge branch 'dev-queue' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware (2023-05-23 13:07:29 -0400)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git HEAD

for you to fetch changes up to c10facaf11266da21db27de9af1c51756ecd07bf:

  rtw89: 8851b: add firmware v0.29.41.0 (2023-05-24 16:30:58 +0800)

----------------------------------------------------------------
Ping-Ke Shih (1):
      rtw89: 8851b: add firmware v0.29.41.0

 WHENCE                |   3 ++-
 rtw89/rtw8851b_fw.bin | Bin 0 -> 1090544 bytes
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 rtw89/rtw8851b_fw.bin

