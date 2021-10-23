Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCD43828D
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhJWJNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhJWJNl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0904A6101C;
        Sat, 23 Oct 2021 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980283;
        bh=yRNcg5Cile/UzTcLetLbI53HyysdwSJZEpwNn54eGaM=;
        h=From:To:Cc:Subject:Date:From;
        b=tMEWE0nHZo2iL9RCgJGpCDEe7chQXPHTsSNOppLIKrNA+tFmCvBCfXsFBnzo8vyNi
         dVU3uNMpJVdN2HoYb76MRLtO0/ybZPwZPtntfG5tDLUldB0C2A1xRC3w9b1UBm9yPi
         29LGChebCuw1RkFgudNtPHXWmDcELYOstS3ohN2stLLFV1kQYHaU/+JOGc+GgD86pT
         PDFeEeDXR014+B96Jg5qZyW4RW1T88AdTQm6AhPsFK0z/qAtxGErIQxkHkymprJzhv
         IY2Od/iOKu7Mn2DIKiwaAp3IR2jnZKXO9GBQTli3hTR45DkyH0KGMPCiAOucIfMn4t
         LJwcQ5fVnwPnw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 0/6] add offchannel radar chain support
Date:   Sat, 23 Oct 2021 11:10:49 +0200
Message-Id: <cover.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to configure a dedicated chain available for radar
detection on some hw (e.g. mt7915). This chain can't be used to transmit or
receive frames and it is bounded to a running wdev.
Offchannel radar/CAC detection allows to avoid the CAC downtime switching
to a different channel during CAC detection on the selected radar channel.
hostapd will implement the logic to select and configure the monitored
channel.

Changes since v1:
- introduce offchanel chain ownership through offchan_radar_wdev pointer
- spilt patch 1/5 in cfg80211 and mac80211 part
- move cac work from driver code to cfg80211

Changes since rfc:
- rely on NL80211_CMD_RADAR_DETECT netlink msg to configure offchannel radar
  chain

Lorenzo Bianconi (6):
  cfg80211: introduce set_radar_offchan callback
  mac80211: introduce set_radar_offchan callback
  cfg80211: introduce the capability to configure offchannel CAC
    detection
  cfg80211: introduce cfg80211_cac_offchan_event routine
  cfg80211: introduce offchannel cac delayed work
  cfg80211: introduce NL80211_EXT_FEATURE_RADAR_OFFCHAN feature flag

 include/net/cfg80211.h       |  24 +++++++
 include/net/mac80211.h       |  10 +++
 include/uapi/linux/nl80211.h |  13 ++++
 net/mac80211/cfg.c           |  13 ++++
 net/wireless/ap.c            |   2 +
 net/wireless/core.c          |   2 +
 net/wireless/core.h          |  15 +++++
 net/wireless/mlme.c          | 117 +++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       |  17 +++--
 net/wireless/rdev-ops.h      |  18 ++++++
 net/wireless/trace.h         |  19 ++++++
 11 files changed, 244 insertions(+), 6 deletions(-)

-- 
2.31.1

