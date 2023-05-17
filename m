Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7743F705D77
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 04:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjEQCv7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 22:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjEQCv6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 22:51:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DEE4201
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 19:51:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34H2pdyF7027378, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34H2pdyF7027378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 17 May 2023 10:51:39 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 17 May 2023 10:51:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 May 2023 10:51:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 17 May 2023 10:51:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: pull request: rtlwifi: update firmware v6.0 for RTL8192FU and v28.0 for RTL8188EU 
Thread-Topic: pull request: rtlwifi: update firmware v6.0 for RTL8192FU and
 v28.0 for RTL8188EU 
Thread-Index: AdmIahpavq8CU354RU2wXeaqoANnoQ==
Date:   Wed, 17 May 2023 02:51:47 +0000
Message-ID: <97eb7e849c46445180f6e77d565f831b@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Update firmware for chips newly supported by rtl8xxxu.

Thank you
Ping-Ke

---
The following changes since commit 512909428e46953e4ade391387aef1305f52029c:

  Merge branch 'main' of https://github.com/CirrusLogic/linux-firmware (2023-05-15 13:24:26 -0400)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git HEAD

for you to fetch changes up to 08b854f020666a5df3d1987f6c01c8c2b780de7e:

  rtlwifi: Add firmware v6.0 for RTL8192FU (2023-05-17 10:09:36 +0800)

----------------------------------------------------------------
Bitterblue Smith (2):
      rtlwifi: Update firmware for RTL8188EU to v28.0
      rtlwifi: Add firmware v6.0 for RTL8192FU

 WHENCE                  |  23 ++++++++++++++---------
 rtlwifi/rtl8188eufw.bin | Bin 13904 -> 15262 bytes
 rtlwifi/rtl8192fufw.bin | Bin 0 -> 32416 bytes
 3 files changed, 14 insertions(+), 9 deletions(-)
 create mode 100644 rtlwifi/rtl8192fufw.bin

