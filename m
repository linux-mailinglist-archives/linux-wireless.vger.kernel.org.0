Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3549E34F6C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFDR7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 13:59:09 -0400
Received: from nbd.name ([46.4.11.11]:42738 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFDR7J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 13:59:09 -0400
Received: from pd95fd026.dip0.t-ipconnect.de ([217.95.208.38] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hYDiE-0004DI-Dw; Tue, 04 Jun 2019 19:59:06 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 0/2] mac80211: add 802.11 encapsulation offloading
Date:   Tue,  4 Jun 2019 19:58:58 +0200
Message-Id: <20190604175900.26818-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series picks up prior work from QCA. The patch is currently shipped
inside QSDK as part of the wlan-open package.

The series tries to address all feedback from the V2
-> https://patchwork.kernel.org/patch/9602585/

Changes in V3
* rebase on latest kernel
* various code style clean ups
* give some of the variables and functions more obvious names
* move the code that disables support for non-linear frames to the core
* disable monitor and tkip support

Changes in V4
* disable encap when TKIP is used instead of refusing TKIP
* use a flag inside tx_info instead of an extra element
* move 4addr detection into ieee80211_set_hw_80211_encap()
* ieee80211_tx_dequeue() was dropping out to early

Changes in V5
* implement comments from Johannes

Vasanthakumar Thiagarajan (2):
  mac80211: add hw 80211 encapsulation offloading support
  ath10k: add tx hw 802.11 encapusaltion offloading suppor

 drivers/net/wireless/ath/ath10k/core.c   |  11 ++
 drivers/net/wireless/ath/ath10k/core.h   |   3 +
 drivers/net/wireless/ath/ath10k/htt_tx.c |  24 +--
 drivers/net/wireless/ath/ath10k/mac.c    |  70 +++++++--
 drivers/net/wireless/ath/ath10k/txrx.c   |  11 +-
 include/net/mac80211.h                   |  25 +++
 net/mac80211/cfg.c                       |   6 +
 net/mac80211/debugfs.c                   |   1 +
 net/mac80211/ieee80211_i.h               |  10 ++
 net/mac80211/iface.c                     |  84 ++++++++++
 net/mac80211/key.c                       |   7 +
 net/mac80211/main.c                      |  10 +-
 net/mac80211/status.c                    |  79 ++++++++++
 net/mac80211/tx.c                        | 187 ++++++++++++++++++++++-
 14 files changed, 495 insertions(+), 33 deletions(-)

-- 
2.20.1

