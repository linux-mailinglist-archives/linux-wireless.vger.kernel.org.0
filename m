Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971860572E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJTGO6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJTGO5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 02:14:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2F7BBE0F
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 23:14:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29K6E6fH4011529, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (mapi.realtek.com[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29K6E6fH4011529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Oct 2022 14:14:06 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 20 Oct 2022 14:14:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 20 Oct 2022 14:14:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Thu, 20 Oct 2022 14:14:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "James Hilliard" <james.hilliard1@gmail.com>
Subject: pull request: update Realtek 8188FU, 8192eu and 8852b firmware
Thread-Topic: pull request: update Realtek 8188FU, 8192eu and 8852b firmware
Thread-Index: AdjkSuEVKk/LT6yjQrKKOILUY5kGVA==
Date:   Thu, 20 Oct 2022 06:14:38 +0000
Message-ID: <fba70e8292fe40a88511c5d333564c9b@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/10/20_=3F=3F_03:38:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This pull-request is to update firmware from Realtek. That includes three
firmware:
 1. rtlwifi: Add firmware v4.0 for RTL8188FU 
    I have sent before, so please ignore previous pull-request [1].
 2. rtlwifi: update firmware for rtl8192eu to v35.7
    I revise commit message and check firmware content from [2].
 3. rtw89: 8852b: update fw to v0.27.32.1

Thank you
Ping-Ke

[1] https://lore.kernel.org/linux-firmware/fabce04424f945a7a51cc466919d4a01@realtek.com/T/#u
[2] https://lore.kernel.org/linux-firmware/20221014132729.2107129-1-james.hilliard1@gmail.com/

---
The following changes since commit 48407ffd7adb9511701547068b1e6f0956bd1c94:

  cnm: update chips&media wave521c firmware. (2022-10-17 10:20:43 -0400)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git HEAD

for you to fetch changes up to dae5d4603b0795a0ed42b9d5a6f4c4b5fbaa362d:

  rtw89: 8852b: update fw to v0.27.32.1 (2022-10-20 13:45:49 +0800)

----------------------------------------------------------------
Bitterblue Smith (1):
      rtlwifi: Add firmware v4.0 for RTL8188FU

James Hilliard (1):
      rtlwifi: update firmware for rtl8192eu to v35.7

Ping-Ke Shih (1):
      rtw89: 8852b: update fw to v0.27.32.1

 WHENCE                       |  11 ++++++++++-
 rtlwifi/rtl8188fufw.bin      | Bin 0 -> 21020 bytes
 rtlwifi/rtl8192eu_nic.bin    | Bin 31818 -> 32286 bytes
 rtlwifi/rtl8192eu_wowlan.bin | Bin 25878 -> 29008 bytes
 rtw89/rtw8852b_fw.bin        | Bin 1029056 -> 1035232 bytes
 5 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 rtlwifi/rtl8188fufw.bin

