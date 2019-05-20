Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F1231E7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 13:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfETLCN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 07:02:13 -0400
Received: from nbd.name ([46.4.11.11]:47758 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730854AbfETLCN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 07:02:13 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSg3V-0003rt-LE; Mon, 20 May 2019 13:02:09 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 0/7] mac80211: HE: add TWT and SPR/OBSSPD support
Date:   Mon, 20 May 2019 13:01:57 +0200
Message-Id: <20190520110204.27588-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for propagating the TWT and OBSS PD information
from userland/assocs to a wireless driver. The patches for making use of
these features inside ath11k are also included.

I already have the hostapd patches ready and will send them once these
changes are inside nl80211.h.

John Crispin (7):
  mac80211: dynamically enable the TWT requester support on STA
    interfaces
  mac80211: allow turning TWT responder support on and off via netlink
  ath11k: add TWT support
  mac80211: HE: add Spatial Reuse IE parsing support
  mac80211: allow setting spatial reuse parameters when bringing up an
    AP
  mac80211: propagate spatial reuse info into ieee80211_sta
  ath11k: add spatial reuse support

 drivers/net/wireless/ath/ath11k/mac.c |  22 +++++
 drivers/net/wireless/ath/ath11k/wmi.c | 126 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  87 ++++++++++++++++++
 include/linux/ieee80211.h             |  49 ++++++++++
 include/net/cfg80211.h                |  17 ++++
 include/net/mac80211.h                |  10 ++
 include/uapi/linux/nl80211.h          |  31 +++++++
 net/mac80211/cfg.c                    |   7 +-
 net/mac80211/he.c                     |  24 +++++
 net/mac80211/ieee80211_i.h            |   5 +
 net/mac80211/mlme.c                   |  19 +++-
 net/mac80211/util.c                   |   4 +
 net/wireless/nl80211.c                |  47 ++++++++++
 13 files changed, 445 insertions(+), 3 deletions(-)

-- 
2.20.1

