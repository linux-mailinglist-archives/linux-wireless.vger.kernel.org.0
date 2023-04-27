Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCC6F0310
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjD0JKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243347AbjD0JJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288CC19AB
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:45 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BiCSAL/FAO3XrlGhCMxRbm1N4L2I432wzwys0etnSUU=;
        b=d9m8IUd9JF+Z9pshbLXUt+qBhyUXcc6Qlw6i8jtdOrPcIjTlGdjEaWyjZtnEk2DSeBSvML
        HKasMA5N3GExQ3zrxThnFmG9EOIW/hFkoxb9+/DPCf+g3DVOA0aJtA62Yv+Wb+lfW6n242
        2+arzx+JsPe9ij7EnfayPrXmJoNr9yYBs1xiazY2Nz8FEKLxu00joKMWRqjeltrfk4bo6v
        sbXQgyaNczFXlpUJtDLKzu/Rb3/cHlzQG5ka9V71wNM3ulmAoYDdruczZPSzH+MFqE0R8K
        8yT06pCRlIhGANJMNBEj6guo8cr/ouXh79EFmYccd91AG9KYAGeF9t4XPKQr6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BiCSAL/FAO3XrlGhCMxRbm1N4L2I432wzwys0etnSUU=;
        b=+U3zM7Wr/1BMgNyRoQ29RiHaYrD3JENs5K8Qoe5g9nu9ZrgAq7gIyqtcfyQtgo1t9k0cuW
        l5YSv+y52Hx3N1Cg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Date:   Thu, 27 Apr 2023 11:09:04 +0200
Message-Id: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 336 ++++++++++++++----
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   5 +
 5 files changed, 299 insertions(+), 84 deletions(-)

-- 
2.30.2

