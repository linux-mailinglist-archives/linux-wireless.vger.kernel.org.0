Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4622F68
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfETIzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:21 -0400
Received: from nbd.name ([46.4.11.11]:41434 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbfETIzU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:20 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4i-0002Y7-JH; Mon, 20 May 2019 10:55:16 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 0/8] ath11k: add HE support
Date:   Mon, 20 May 2019 10:55:00 +0200
Message-Id: <20190520085508.5888-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds initial support for HE mode to the ath11k driver.

Things that still need to implemented
* ppe_threshold support

Changes in V2:
* generate sband_iftype data from FW provided capabilities
* properly handle rx_status for HE frames
* fix regression in basic VHF phymode
* various minor cleanups

Changes in V3
* make the he_cap generating code future-proof
* move phymode lookup to an array

Changes in V4
* remove dependency in local patch

Changes in V5
* populate he_oper field when preparing peer assoc
* populate ppet field when preparing peer assoc
* fix 80p80 phymode when preparing peer assoc
* address review comments

John Crispin (8):
  mac80211: propagate HE operation info into ieee80211_sta
  ath11k: fix some whitespace errors
  ath11k: move phymode selection from function to array lookup
  ath11k: add HE handling to the debug code
  ath11k: extend reading of FW capabilities
  ath11k: add defines for max MCS rates per phymode
  ath11k: handle rx status for HE frames
  ath11k: add HE support

 drivers/net/wireless/ath/ath11k/core.h        |  11 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  24 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  18 +-
 drivers/net/wireless/ath/ath11k/mac.c         | 357 ++++++++++++++----
 drivers/net/wireless/ath/ath11k/reg.c         |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c         |  13 +-
 drivers/net/wireless/ath/ath11k/wmi.h         |  44 ++-
 include/net/mac80211.h                        |   2 +
 include/uapi/linux/nl80211.h                  |   4 +
 net/mac80211/he.c                             |  14 +
 net/mac80211/ieee80211_i.h                    |   5 +
 net/mac80211/mlme.c                           |   1 +
 12 files changed, 392 insertions(+), 102 deletions(-)

-- 
2.20.1

