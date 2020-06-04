Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207021EDDAB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgFDHKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgFDHKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:10:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58DC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:10:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0k-0001P3-88; Thu, 04 Jun 2020 09:09:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 00/12] mac80211: add multiple bssid support
Date:   Thu,  4 Jun 2020 09:09:40 +0200
Message-Id: <20200604070952.15481-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Multiple bssid allows us to share a single beacon amongst several VAPs.
This essentially safes airtime. This feature is achieved by adding an
additional IE to the transmitting VAPs beacon. This new IE contains
the additional SSIDs and their non-inheritance information.

This series is still missing handling for TIM, which will be sent in a
follow-up series.

John Crispin (12):
  nl80211: add basic multiple bssid support
  nl80211: add attributes for multiple bssid related settings
  nl80211: add attributes to set beacon transmit mode
  mac80211: add multiple bssid support
  mac80211: add multiple bssid IE parsing
  mac80211: propagate multi bssid settings when starting an AP
  mac80211: propagate beacon tx mode to the driver
  ath11k: pass multiple bssid info to FW when a new vdev is created
  ath11k: add a struct to pass parameters into ath11k_wmi_vdev_up
  ath11k: add the multiple bssid IE offset to the beacon template
  ath11k: set beacon tx mode
  ath11k: set the multiple bssid hw cap

 drivers/net/wireless/ath/ath11k/mac.c | 72 ++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c | 20 +++++---
 drivers/net/wireless/ath/ath11k/wmi.h | 22 +++++++-
 include/net/cfg80211.h                | 23 +++++++++
 include/net/mac80211.h                | 29 +++++++++++
 include/uapi/linux/nl80211.h          | 49 ++++++++++++++++++
 net/mac80211/cfg.c                    | 64 ++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h            |  2 +
 net/mac80211/iface.c                  | 16 ++++++
 net/mac80211/tx.c                     | 10 ++++
 net/mac80211/util.c                   | 31 ++++++++++++
 net/wireless/nl80211.c                | 36 ++++++++++++++
 12 files changed, 358 insertions(+), 16 deletions(-)

-- 
2.20.1

