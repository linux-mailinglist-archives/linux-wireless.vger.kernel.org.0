Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E536F1B1D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbjD1PIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbjD1PIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25704EF5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:40 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vLfXhzKGUBGpqhKrM2KQdtZ6pveXyiOStB3HCLc5shU=;
        b=jvTJSdNJeLr0clNnN/BuluPxnznEH6xTrvqLfqZCjzrhMuxj7N+kOgN6JCP7d55xxXDKSv
        Nj56ljJQLgRxdheXkFTY43xC5cYLCp0MHxjrXDX98OHCfkjua57f/UIdMqAYC2rewoQKNT
        2WuXXMlGobK8E9cRXgsMuJTbFTTkSckodGa04ry7QILVMcsJ1LaxwPaK50v0kvFHS9AKxN
        t/tnWON1TxirnCMSlvKOb3fShYwGl7d7XdbI1btHtK2ZskFjXfIUAjw7YoqtkDjsOnqJKf
        YMMr4XiGfeOylMDYeUQZTtyw+Tq4VWIoPvQTze1dDr4PbaAsnVE61WYR2gJzBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vLfXhzKGUBGpqhKrM2KQdtZ6pveXyiOStB3HCLc5shU=;
        b=/SrfjLSb/jk37bemX6FNbyQII4dWFmmF90ju8Gc0RKVprcRw2AUVwhXItkxwcMwkZNJbhY
        L/+MO45t8WaSnACQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Date:   Fri, 28 Apr 2023 17:08:15 +0200
Message-Id: <20230428150833.218605-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series intends to bring AP mode support to the rtl8xxxu driver,
more specifically for the 8188f, because this is the HW I have.
The work is based on the vendor driver as I do not have access to
datasheets.

The iperf3 measurements for TCP in AP mode still look slower in the
AP->STA direction compared to the vendor driver, UDP looks fine. I still
hope, this can be fixed by future patches.

Thanks,
  Martin

v4 changelog:
- restructured beacon enable code in bss_info_changed 
v3 changelog:
- add some R-bs
- remove priv->beacon_enabled
- rename max_sta_num to max_macid_num
v2 changelog:
- dropped RFC prefix
- rebase patches to newest wireless-next
- add some R-bs
- new patch: "Add parameter force to rtl8xxxu_refresh_rate_mask"
- new patch: "Remove usage of ieee80211_get_tx_rate()"
- new patch: "Remove usage of tx_info->control.rates[0].flags"
- new patch: "Set maximum number of supported stations"
- add macro for broadcast/multicast frames macid
- add more explanation about beacon queue in commit message of patch 2
- add macros for bit definitions for beacon functions
- implement enable_beacon = false case
- fix beacon valid loop so that error condition is actually reached
- add more explanation about setting mac address register in add_interface
  in commit message of patch 6
- rename role macros for connect report h2c
- use bitmap for assigning macids
- add helper function for looking up assigned macids
- move patch 7 so we can use rtl8xxxu_get_macid helper
- add sta_remove callback
- do things in sta_add only in AP mode
- use IEEE80211_TX_CTL_ASSIGN_SEQ flag to determine when to use HW sequence
  numbers
- add priv->vif null pointer check in configure_filter, rework setting
  BSSID_BEACON/BSSID_MATCH in RCR

v1: https://lore.kernel.org/linux-wireless/20230322171905.492855-1-martin.kaistra@linutronix.de/
v2: https://lore.kernel.org/linux-wireless/20230419100145.159191-1-martin.kaistra@linutronix.de/
v3: https://lore.kernel.org/linux-wireless/20230427090922.165088-1-martin.kaistra@linutronix.de/

Martin Kaistra (18):
  wifi: rtl8xxxu: Add start_ap() callback
  wifi: rtl8xxxu: Select correct queue for beacon frames
  wifi: rtl8xxxu: Add beacon functions
  wifi: rtl8xxxu: Add set_tim() callback
  wifi: rtl8xxxu: Allow setting rts threshold to -1
  wifi: rtl8xxxu: Allow creating interface in AP mode
  wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
  wifi: rtl8xxxu: Add parameter role to report_connect
  wifi: rtl8xxxu: Add parameter force to rtl8xxxu_refresh_rate_mask
  wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
  wifi: rtl8xxxu: Put the macid in txdesc
  wifi: rtl8xxxu: Add parameter macid to update_rate_mask
  wifi: rtl8xxxu: Enable hw seq for mgmt/non-QoS data frames
  wifi: rtl8xxxu: Clean up filter configuration
  wifi: rtl8xxxu: Remove usage of ieee80211_get_tx_rate()
  wifi: rtl8xxxu: Remove usage of tx_info->control.rates[0].flags
  wifi: rtl8xxxu: Declare AP mode support for 8188f
  wifi: rtl8xxxu: Set maximum number of supported stations

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  37 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |   3 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |   2 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 337 ++++++++++++++----
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   5 +
 5 files changed, 300 insertions(+), 84 deletions(-)

-- 
2.30.2

