Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD497E83EB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 10:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfJ2JNO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 05:13:14 -0400
Received: from nbd.name ([46.4.11.11]:53976 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfJ2JNN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 05:13:13 -0400
Received: from p5dcfbe82.dip0.t-ipconnect.de ([93.207.190.130] helo=bertha.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iPNYs-0005ZW-Q4; Tue, 29 Oct 2019 10:13:10 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V9 0/3] mac80211: add 802.11 encapsulation offloading
Date:   Tue, 29 Oct 2019 10:13:01 +0100
Message-Id: <20191029091304.7330-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series picks up prior work from QCA. The patch is currently shipped
inside QSDK as part of the wlan-open package.

Changes in V9
* implement comments from Johannes
* add tx status reporting
* let the driver decide if tx frag will break encap mode
* use true/false for bool values
* move use_4addr check to driver

Changes in V8
* fix double locking when setting frag threshold

Changes in V7
* dont mask out monitor support when encap is available. Instead turn encap
  of if a monitor device is brought up or already present

Changes in V6
* the conditional masking out monitor support was inverse

Changes in V5
* implement comments from Johannes

Changes in V4
* disable encap when TKIP is used instead of refusing TKIP
* use a flag inside tx_info instead of an extra element
* move 4addr detection into ieee80211_set_hw_80211_encap()
* ieee80211_tx_dequeue() was dropping out to early

Changes in V3
* rebase on latest kernel
* various code style clean ups
* give some of the variables and functions more obvious names
* move the code that disables support for non-linear frames to the core
* disable monitor and tkip support

John Crispin (3):
  mac80211: move store skb ack code to its own function
  mac80211: add hw 80211 encapsulation offloading support
  ath10k: add tx hw 802.11 encapusaltion offloading support

 drivers/net/wireless/ath/ath10k/core.c   |  11 ++
 drivers/net/wireless/ath/ath10k/core.h   |   3 +
 drivers/net/wireless/ath/ath10k/htt_tx.c |  24 ++-
 drivers/net/wireless/ath/ath10k/mac.c    |  76 ++++++--
 drivers/net/wireless/ath/ath10k/txrx.c   |  11 +-
 include/net/mac80211.h                   |  39 ++++
 net/mac80211/debugfs.c                   |   1 +
 net/mac80211/ieee80211_i.h               |   9 +
 net/mac80211/iface.c                     |  68 +++++++
 net/mac80211/key.c                       |   7 +
 net/mac80211/status.c                    |  74 +++++++
 net/mac80211/tx.c                        | 233 ++++++++++++++++++++---
 12 files changed, 506 insertions(+), 50 deletions(-)

-- 
2.20.1

