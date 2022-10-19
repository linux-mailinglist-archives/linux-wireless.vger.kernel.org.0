Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E29B6037A6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 03:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJSBtq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 21:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJSBto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 21:49:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF72A1D0C7
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 18:49:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29J1mcwP7028999, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29J1mcwP7028999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 19 Oct 2022 09:48:38 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 19 Oct 2022 09:49:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 19 Oct 2022 09:49:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Wed, 19 Oct 2022 09:49:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: pull request: rtlwifi: Add firmware v4.0 for RTL8188FU
Thread-Topic: pull request: rtlwifi: Add firmware v4.0 for RTL8188FU
Thread-Index: AdjjW++tFCB/oTmxTDOyoYxH6CssYg==
Date:   Wed, 19 Oct 2022 01:49:09 +0000
Message-ID: <fabce04424f945a7a51cc466919d4a01@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/10/18_=3F=3F_11:53:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
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

Hi,

Add firmware 4.0 for RTL8188FU based on Bitterblue's patch [0], but revise
WHENCE and commit message to reflect name from original SDK. Also, I have
confirmed the firmware content is expected. 

Thank you
Ping-Ke

[0] https://lore.kernel.org/linux-firmware/CA+5PVA4gbbVsKN6bB8ktod4hPTeiKPSkJrmKVjtoagpz2XAYbQ@mail.gmail.com/

---
The following changes since commit 48407ffd7adb9511701547068b1e6f0956bd1c94:

  cnm: update chips&media wave521c firmware. (2022-10-17 10:20:43 -0400)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git HEAD

for you to fetch changes up to 9aa8db1ccb9a83eeb3f5daf71e4206d218648c49:

  rtlwifi: Add firmware v4.0 for RTL8188FU (2022-10-19 09:36:55 +0800)

----------------------------------------------------------------
Bitterblue Smith (1):
      rtlwifi: Add firmware v4.0 for RTL8188FU

 WHENCE                  |   6 ++++++
 rtlwifi/rtl8188fufw.bin | Bin 0 -> 21020 bytes
 2 files changed, 6 insertions(+)
 create mode 100644 rtlwifi/rtl8188fufw.bin

