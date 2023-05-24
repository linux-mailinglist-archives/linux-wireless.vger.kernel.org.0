Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B270EA6A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 02:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjEXApF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 20:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjEXApD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 20:45:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E5B5
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 17:44:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34O0iXQy9011346, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34O0iXQy9011346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 08:44:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 24 May 2023 08:44:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 24 May 2023 08:44:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 24 May 2023 08:44:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull request [v2]: rtw89: 8851b: add firmware v0.29.41.0
Thread-Topic: pull request [v2]: rtw89: 8851b: add firmware v0.29.41.0
Thread-Index: AdmN2K1wMvVRYge3Ts2HesAmQ7eBCg==
Date:   Wed, 24 May 2023 00:44:44 +0000
Message-ID: <bb354783d5c6464a87a3e2d90a0a13bd@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Thank you
Ping-Ke

---
The following changes since commit 1ba3519eab0fbc3cedf6b423ea0470461b902c1b:

  Merge branch 'dev-queue' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware (2023-05-23 13:07:29 -0400)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git HEAD

for you to fetch changes up to d0ea9ba17f908b3976cd37f81a68747e811a4fcf:

  rtw89: 8851b: add firmware v0.29.41.0 (2023-05-24 08:39:48 +0800)

----------------------------------------------------------------
Ping-Ke Shih (1):
      rtw89: 8851b: add firmware v0.29.41.0

 WHENCE                |   1 +
 rtw89/rtw8851b_fw.bin | Bin 0 -> 1090544 bytes
 2 files changed, 1 insertion(+)
 create mode 100644 rtw89/rtw8851b_fw.bin

