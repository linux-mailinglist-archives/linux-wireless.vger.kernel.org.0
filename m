Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ABE509F53
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351963AbiDUMNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383230AbiDUMM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFD2ED73
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9MPr8028945, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9MPr8028945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:09:22 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/14] rtw89: 8852c: extend PCI code to support 8852ce and add 8852c chip_ops
Date:   Thu, 21 Apr 2022 20:08:49 +0800
Message-ID: <20220421120903.73715-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
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

The PCI code of 8852CE is different from 8852AE. The IMR/ISR addresses are
different, and 8852CE has a special low power mode that uses another set
of addresses. To handle the special mode, we add a special interrupt
threadfn to handle packets, because regular NAPI poll function does many
things that can't access at this mode.

Another special handle is RPP (TX skb completion) prior to TX BD (TX ring
completion). In low mode power, it can be possible, so we extend the code
to handle this case as well as normal mode.

Patch 3/14 is to optimize count of reading IO, and patch 8/14 is to resolve
some warnings happened on 8852ce, because PCI ring registers are power-off
after running power-off function. These registers on 8852ae aren't
power-off.

Patches 9/14-14/14 are to add chip ops of 8852c as description of the
patches individually.

Ping-Ke Shih (14):
  rtw89: pci: add variant IMR/ISR and configure functions
  rtw89: pci: add variant RPWM/CPWM to enter low power mode
  rtw89: pci: reclaim TX BD only if it really need
  rtw89: pci: does RX in interrupt threadfn if low power mode
  rtw89: ser: re-enable interrupt in threadfn if under_recovery
  rtw89: ps: access TX/RX rings via another registers in low power mode
  rtw89: pci: allow to process RPP prior to TX BD
  rtw89: don't flush hci queues and send h2c if power is off
  rtw89: add RF H2C to notify firmware
  rtw89: 8852c: configure default BB TX/RX path
  rtw89: 8852c: implement chip_ops related to TX power
  rtw89: 8852c: implement chip_ops::get_thermal
  rtw89: 8852c: fill freq and band of RX status by PPDU report
  rtw89: 8852c: add chip_ops related to BTC

 drivers/net/wireless/realtek/rtw89/core.c     |  10 +
 drivers/net/wireless/realtek/rtw89/core.h     |  34 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  39 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  12 +
 drivers/net/wireless/realtek/rtw89/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/pci.c      | 339 ++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      | 144 ++++
 drivers/net/wireless/realtek/rtw89/phy.c      |   1 +
 drivers/net/wireless/realtek/rtw89/ps.c       |  34 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  83 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   8 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 766 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  16 +
 15 files changed, 1438 insertions(+), 57 deletions(-)

-- 
2.25.1

