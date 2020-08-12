Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE26A242BD4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHLPBs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHLPBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:01 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D8C061385
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:00 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFN-0002OP-3C; Wed, 12 Aug 2020 17:00:57 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 0/9] mac80211: add multiple bssid / EMA
Date:   Wed, 12 Aug 2020 17:00:41 +0200
Message-Id: <20200812150050.2683396-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series addss multiple bssid and EMA beacons.

The V3 series has a lot of changes to V2. The biggest being the added
support for EMA. As we might have HW that can offload this we need to
pass the multiple bssid elements to the kernel. This gives us a lot of
flexibility for supporting different hardware.

John Crispin (9):
  nl80211: add basic multiple bssid support
  mac80211: add multiple bssid support to interface handling
  mac80211: add multiple bssid support to beacon handling
  mac80211: add multiple bssid/ema support to bcn templating
  ath11k: add a struct to pass parameters into ath11k_wmi_vdev_up
  ath11k: add the multiple bssid WMI commands
  ath11k: add multiple bssid support to device creation
  ath11k: add EMA beacon support
  ath11k: set the multiple bssid hw flags and capabilities

 drivers/net/wireless/ath/ath11k/mac.c |  83 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c |  20 +++--
 drivers/net/wireless/ath/ath11k/wmi.h |  22 ++++-
 include/net/cfg80211.h                |  35 ++++++++
 include/net/mac80211.h                |  42 +++++++++-
 include/uapi/linux/nl80211.h          |  22 +++++
 net/mac80211/cfg.c                    | 113 +++++++++++++++++++++++++-
 net/mac80211/debugfs.c                |   1 +
 net/mac80211/ieee80211_i.h            |   2 +
 net/mac80211/iface.c                  |   7 ++
 net/mac80211/tx.c                     |  49 ++++++++++-
 net/wireless/nl80211.c                |  40 +++++++++
 12 files changed, 408 insertions(+), 28 deletions(-)

-- 
2.25.1

