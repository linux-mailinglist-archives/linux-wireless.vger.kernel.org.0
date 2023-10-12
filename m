Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98707C6C94
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbjJLLme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbjJLLme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 07:42:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E9A9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 04:42:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2860C433C9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697110952;
        bh=5ml1vA2Ho0IqNhI9miMvL/upVCxyE4/sB85I4L4+9L4=;
        h=From:To:Subject:Date:From;
        b=LWx84aWaJLhbIlwZkbKwgmdSth09EfzGgVshmsQzkHJ9DUwG2sChZTF/upCl1q6vu
         Y9ntWDPxYTo2j++AQQAp0i9N1M37XOXe98fmr3ZH3fMEVs8JxSmtVMNzcdc+oPout+
         MJO9V2j9DnqoDgaw47BsXtFkrzeuNqlkAYu25wPospHl9WSpZIcicBimNeOMOq5rj5
         DqvgI1wXFeACwdpf3PitLUoHAuKvckmDpl/ti4TcG/qilZO8P7AosZ/Xwujxi9+oPa
         C3P7Lhq5yJF7uYinZwcNoAScd7phmhgNwAYBMqcY/a3zRwRMqBnCE7vfaatBKbbnbH
         SmFKrT9vF+UBA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] wifi: mac80211: workaround the two remaining htmldocs warnings
Date:   Thu, 12 Oct 2023 14:42:27 +0300
Message-Id: <20231012114229.2931808-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have two annoying htmldocs warnings left in wireless subsystem so add
workarounds for them.

v2:

o patch 2: rename the struct instead

o drop RFC label

v1: https://patchwork.kernel.org/project/linux-wireless/list/?series=791407&state=*&order=date

Kalle Valo (2):
  wifi: mac80211: rename ieee80211_tx_status() to
    ieee80211_tx_status_skb()
  wifi: mac80211: rename struct cfg80211_rx_assoc_resp to
    cfg80211_rx_assoc_resp_data

 Documentation/driver-api/80211/mac80211.rst   |  2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c       |  4 +--
 drivers/net/wireless/ath/ath5k/base.c         |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |  2 +-
 drivers/net/wireless/ath/ath9k/xmit.c         |  2 +-
 drivers/net/wireless/broadcom/b43/dma.c       |  4 +--
 drivers/net/wireless/broadcom/b43/pio.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  4 +--
 drivers/net/wireless/mediatek/mt7601u/tx.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  2 +-
 drivers/net/wireless/st/cw1200/txrx.c         |  2 +-
 drivers/net/wireless/ti/wl1251/tx.c           |  6 ++--
 include/net/cfg80211.h                        |  8 ++---
 include/net/mac80211.h                        | 30 +++++++++----------
 net/mac80211/main.c                           |  2 +-
 net/mac80211/mlme.c                           |  2 +-
 net/mac80211/status.c                         |  4 +--
 net/wireless/mlme.c                           |  2 +-
 net/wireless/nl80211.c                        |  2 +-
 net/wireless/nl80211.h                        |  2 +-
 net/wireless/trace.h                          |  2 +-
 22 files changed, 46 insertions(+), 46 deletions(-)


base-commit: 62d19b35808816dc2bdf5031e5401230f6a915ba
-- 
2.39.2

