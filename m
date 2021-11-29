Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8E461691
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhK2NiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:13 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49760 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377634AbhK2NgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:12 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgm3-0012xo-6I; Mon, 29 Nov 2021 15:32:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:32 +0200
Message-Id: <20211129133248.83829-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/16] cfg80211/mac80211 patches from our internal tree 2021-11-29
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A bunch of patches with mac80211 and cfg80211 changes from our
internal tree.

Please review, though you have already reviewed (or even written!)
most if not all of them. ;)

Thanks!

Cheers,
Luca.


Ayala Beker (1):
  cfg80211: Use the HE operation IE to determine a 6GHz BSS channel

Ilan Peer (6):
  cfg80211: Add support for notifying association comeback
  mac80211: Notify cfg80211 about association comeback
  cfg80211: Fix order of enum nl80211_band_iftype_attr documentation
  mac80211: Remove a couple of obsolete TODO
  mac80211: Fix the size used for building probe request
  cfg80211: Acquire wiphy mutex on regulatory work

Johannes Berg (7):
  mac80211: add more HT/VHT/HE state logging
  [BUGFIX] cfg80211: check fixed size before ieee80211_he_oper_size()
  mac80211: mark TX-during-stop for TX in in_reconfig
  mac80211: do drv_reconfig_complete() before restarting all
  cfg80211: simplify cfg80211_chandef_valid()
  mac80211: fix lookup when adding AddBA extension element
  mac80211: agg-tx: don't schedule_and_wake_txq() under sta->lock

Mordechay Goodstein (1):
  mac80211: update channel context before station state

Nathan Errera (1):
  mac80211: introduce channel switch disconnect function

 include/net/cfg80211.h       | 12 +++++++
 include/net/mac80211.h       | 12 +++++++
 include/uapi/linux/nl80211.h | 10 ++++--
 net/mac80211/agg-rx.c        |  5 +--
 net/mac80211/agg-tx.c        | 10 ++++--
 net/mac80211/cfg.c           | 14 +++++++-
 net/mac80211/driver-ops.h    |  5 ++-
 net/mac80211/main.c          | 13 +++-----
 net/mac80211/mlme.c          | 54 +++++++++++++++++++++----------
 net/mac80211/sta_info.c      | 15 +++++----
 net/mac80211/util.c          | 16 +++++-----
 net/wireless/chan.c          | 62 +++++++++++++++++++-----------------
 net/wireless/nl80211.c       | 38 ++++++++++++++++++++++
 net/wireless/reg.c           |  8 +++--
 net/wireless/scan.c          | 48 +++++++++++++++++++++++++---
 net/wireless/trace.h         | 17 ++++++++++
 16 files changed, 256 insertions(+), 83 deletions(-)

-- 
2.33.1

