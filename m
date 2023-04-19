Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F716E76FE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjDSKCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjDSKCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14710F0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:12 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LQYdVJUDPySzchOT4vFVGYN+gmULBehJeGoz9HQ8Srs=;
        b=A7l00uWUE5kWUIA73mZye17zRaGV23DW62/DJq8qnR1ZFoyxJnXSAtImSdHUboHgtWflJ3
        o2opCTlw0io0t20PO48L7YOG3Buo0VlOmBALeOIAXOj43+omfQo9b5McScExTmo2WaX3fz
        343Rkvfn754rTk9Aii546r+830tQD54vT2+hFY8u7NcaDLM5q0mJIMl1F1+X7nSAUojn6d
        OufXSd2PSd2LB3MtAM4GUYr3z4s+nZCnNwH8mCuQtgeTa8B7r96xnqGV6L1PsRwGwg13YF
        aJ3aM+SiYUEQfJAr1NwYxOk6uOFhCHY2JtitBkBdDkTJslIXRNkfLbIZJwHfDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LQYdVJUDPySzchOT4vFVGYN+gmULBehJeGoz9HQ8Srs=;
        b=gSBwr6K05kVfm0j4gVcZTShhMXDO6lsD21C5S0fidmBFA4U/XYjUQAUkn5D0Rufv7lCQPa
        YJvWFvHY3J6Gi5DQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Date:   Wed, 19 Apr 2023 12:01:27 +0200
Message-Id: <20230419100145.159191-1-martin.kaistra@linutronix.de>
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

Also while doing some measurements with iperf3 to compare with the
vendor driver, I saw, that TCP traffic from AP to STA is slower than in
the vendor driver. For UDP it looks fine. I hope I can get some help to
fix this.

* vendor driver:

  without 802.11n:
    UDP (AP -> STA): 27 Mbits/sec
    UDP (STA -> AP): 33 Mbits/sec
    TCP (AP -> STA): 24 Mbits/sec
    TCP (STA -> AP): 26 Mbits/sec

  with 802.11n:
    UDP (AP -> STA): 51 Mbits/sec
    UDP (STA -> AP): 35 Mbits/sec
    TCP (AP -> STA): 40 Mbits/sec
    TCP (STA -> AP): 36 Mbits/sec

* rtl8xxxu:

  without 802.11n:
    UDP (AP -> STA): 25 Mbits/sec
    UDP (STA -> AP): 31 Mbits/sec
    TCP (AP -> STA):  3 Mbits/sec !
    TCP (STA -> AP): 25 Mbits/sec

  with 802.11n:
    UDP (AP -> STA): 41 Mbits/sec
    UDP (STA -> AP): 36 Mbits/sec
    TCP (AP -> STA):  3 Mbits/sec !
    TCP (STA -> AP): 32 Mbits/sec

Thanks,
  Martin

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

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  39 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |   3 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |   2 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 346 ++++++++++++++----
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   5 +
 5 files changed, 311 insertions(+), 84 deletions(-)

-- 
2.30.2

