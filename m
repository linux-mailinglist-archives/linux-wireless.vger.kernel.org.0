Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873947A7496
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjITHpK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjITHoz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9BFD8
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:48 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7iYgtD802820, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7iYgtD802820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Sep 2023 15:44:34 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: support to load TX power tables from firmware file
Date:   Wed, 20 Sep 2023 15:43:15 +0800
Message-ID: <20230920074322.42898-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

We proposed firmware elements to have PHY parameters that are simple tuple
of {addr, value}, and this patchset is to add nine kinds of TX power tables
to firmware elements. Since TX power tables can be possibly increasing
dimension or value range in the future, it is much complicated than
parameter tables.

We keep existing WiFi 6 chips use tables built-in arrays in drivers, but
preserve rooms to make it possible to move arrays into firmware file
as well. So, patches in this patchset adjust struct also for this purpose.

About backward/forward compatibility:
This is the most important and complicated stuff of this patchset. The
method basically to achieve compatibility is to pad zeros.

1. encode scheme
   Consider a TX power value in driver
     power[x][y] = a
   The indices part are also encoded into firmware file
     x, y, a
   For example,
     power[5][6] = 9      --> 05 06 09

2. compatibility
   When array dimension is increasing, it could become something like
     power[x][y][z] = b
   For example,
     power[5][6][4] = 9   --> 05 06 09 04
                                       ^^
     (note: the new dimension must be encoded as the last digit)

   (I explain further based on these examples)

2.1. driver backward compatibility (new driver + old firmware)
   From driver point of view, a tuple from firmware is 3 digits, so it
   allocates a expected 4-digit tuple array first, and copy 3 digits into
   the array. Base on above example, tuple in old firmware is recognized as
   05 06 09 00  --> power[5][6][0] = 9
            ^^ This pending zero is existing in firmware, but driver adds it

2.2. driver forward compatibility (old driver + new firmware)
   Like above example, old driver allocates 3-digit tuple array first, and
   only copy 3-digits into the array if remaining digits are zeros. For
   example,
   05 06 09 04 --> only for new driver; don't recognize
   05 06 09 00 --> power[5][6] = 9
            ^^ remaining digits must be zeros

   Summarize the flow:
   1. pre-condition
      n = tuple size in firmware
      m = tuple size expected by driver
   2.1. n == m
        - copy n digits into array
   2.2. n < m (new driver + old firmware)
        - allocate/zero m digits tuple array
        - copy n digits into array
   2.3. n > m (old driver + new firmware)
        - if m + 1 ~ n digits aren't all zeros, ignore this tuple
        - copy m digits into array
   3. from tuple to regular C array.

Patch 1/7~6/7 are to adjust enum and struct, and patch 7/7 is to load
TX power from firmware. The remaining patches in hand are to set TX power
to WiFi 7 chips. I will submit them later.

Firmware elements layout for reference:

  +===========================================+
  |      WiFi CPU multi-firmware              |
  |                             +-------------+
  |                             |   padding   |
  +===========================================+
  | elm ID 1 | elm size |  other header data  |
  +----------+----------+                     |
  |                                           |
  +-------------------------------------------+
  | content (variable length)                 |
  |                             +-------------+
  |                             |   padding   |
  +===========================================+
  | elm ID 2 | elm size |  other header data  |
  +----------+----------+                     |
  |                                           |
  +-------------------------------------------+
  | content (variable length)                 |
  |                   +-----------------------+
  |                   |
  +===================+

Element header:

 +===========================================+
 |  elm ID  | elm size | version  |   rsvd0  |
 +----------+----------+----------+----------+
 |        rsvd1/2      |  element_priv[]     |
 +-------------------------------------------+

Ping-Ke Shih (1):
  wifi: rtw89: add subband index of primary channel to struct rtw89_chan

Zong-Zhe Yang (6):
  wifi: rtw89: indicate TX shape table inside RFE parameter
  wifi: rtw89: indicate TX power by rate table inside RFE parameter
  wifi: rtw89: phy: refine helpers used for raw TX power
  wifi: rtw89: load TX power by rate when RFE parms setup
  wifi: rtw89: phy: extend TX power common stuffs for Wi-Fi 7 chips
  wifi: rtw89: load TX power related tables from FW elements

 drivers/net/wireless/realtek/rtw89/chan.c     |  15 +
 drivers/net/wireless/realtek/rtw89/core.c     |  25 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 152 ++++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 530 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 130 +++++
 drivers/net/wireless/realtek/rtw89/phy.c      |  97 ++--
 drivers/net/wireless/realtek/rtw89/phy.h      |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   6 +-
 .../wireless/realtek/rtw89/rtw8851b_table.c   |   6 +
 .../wireless/realtek/rtw89/rtw8851b_table.h   |   3 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 -
 .../wireless/realtek/rtw89/rtw8852a_table.c   |   2 +
 .../wireless/realtek/rtw89/rtw8852a_table.h   |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   6 +-
 .../wireless/realtek/rtw89/rtw8852b_table.c   |   4 +
 .../wireless/realtek/rtw89/rtw8852b_table.h   |   3 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   6 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   |   4 +
 .../wireless/realtek/rtw89/rtw8852c_table.h   |   3 -
 19 files changed, 910 insertions(+), 87 deletions(-)

-- 
2.25.1

