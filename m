Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278422C5B5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfE1LuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 07:50:07 -0400
Received: from nbd.name ([46.4.11.11]:55658 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfE1LuG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 07:50:06 -0400
Received: from p5dcfb1b7.dip0.t-ipconnect.de ([93.207.177.183] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hVacG-0005pk-0k; Tue, 28 May 2019 13:50:04 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 0/6] mac80211: HE: add TWT and SPR/OBSSPD support
Date:   Tue, 28 May 2019 13:49:46 +0200
Message-Id: <20190528114952.838-1-john@phrozen.org>
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

Changes in V2
* always use bss_conf as per request from Johannes

John Crispin (6):
  mac80211: dynamically enable the TWT requester support on STA
    interfaces
  mac80211: allow turning TWT responder support on and off via netlink
  ath11k: add TWT support
  mac80211: HE: add Spatial Reuse IE parsing support
  mac80211: allow setting spatial reuse parameters from bss_conf
  ath11k: add spatial reuse support

 drivers/net/wireless/ath/ath11k/mac.c |  22 +++++
 drivers/net/wireless/ath/ath11k/wmi.c | 126 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  87 ++++++++++++++++++
 include/linux/ieee80211.h             |  49 ++++++++++
 include/net/cfg80211.h                |  17 ++++
 include/net/mac80211.h                |   9 ++
 include/uapi/linux/nl80211.h          |  31 +++++++
 net/mac80211/cfg.c                    |   7 +-
 net/mac80211/he.c                     |  24 +++++
 net/mac80211/ieee80211_i.h            |   4 +
 net/mac80211/mlme.c                   |  19 +++-
 net/mac80211/util.c                   |   4 +
 net/wireless/nl80211.c                |  47 ++++++++++
 13 files changed, 443 insertions(+), 3 deletions(-)

-- 
2.20.1

