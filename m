Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78F767FE9
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGNPoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 11:44:34 -0400
Received: from nbd.name ([46.4.11.11]:59370 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNPoe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 11:44:34 -0400
Received: from p5dcfb359.dip0.t-ipconnect.de ([93.207.179.89] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmgfv-0007cJ-KA; Sun, 14 Jul 2019 17:44:32 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 0/6] mac80211: add HE TX rate reporting to radiotap
Date:   Sun, 14 Jul 2019 17:44:13 +0200
Message-Id: <20190714154419.11854-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now struct ieee80211_tx_rate cannot hold HE rates. Lets extend
struct ieee80211_tx_status instead and use ieee80211_tx_status_ext()
to propagate the information to the subsystem.

John Crispin (6):
  mac80211: add xmit rate to struct ieee80211_tx_status
  mac80211: propagate struct ieee80211_tx_status into
    ieee80211_tx_monitor()
  mac80211: add struct ieee80211_tx_status support to
    ieee80211_add_tx_radiotap_header
  ath11k: drop tx_info from ath11k_sta
  ath11k: add HE rate accounting to driver
  ath11k: switch to using ieee80211_tx_status_ext()

 drivers/net/wireless/ath/ath11k/core.h        |   3 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |   7 +
 drivers/net/wireless/ath/ath11k/dp.h          |   9 +
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  82 ++++----
 drivers/net/wireless/ath/ath11k/dp_tx.c       |  20 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c      |  13 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h      |  30 +++
 drivers/net/wireless/ath/ath11k/rx_desc.h     |   8 +
 include/net/mac80211.h                        |   2 +
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/status.c                         | 180 ++++++++++++++++--
 net/mac80211/tx.c                             |   3 +-
 12 files changed, 291 insertions(+), 69 deletions(-)

-- 
2.20.1

