Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4974A6D42
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiBBIty (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:49:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37922 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239659AbiBBItx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:49:53 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBKm-0004v8-Pp;
        Wed, 02 Feb 2022 10:49:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:33 +0200
Message-Id: <20220202084947.370289-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/14] cfg80211/mac80211 patches from our internal tree 2022-02-02
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


Avraham Stern (2):
  cfg80211: don't add non transmitted BSS to 6GHz scanned channels
  mac80211: fix struct ieee80211_tx_info size

Johannes Berg (8):
  mac80211: limit bandwidth in HE capabilities
  cfg80211/mac80211: assume CHECKSUM_COMPLETE includes SNAP
  ieee80211: fix -Wcast-qual warnings
  cfg80211: fix -Wcast-qual warnings
  ieee80211: radiotap: fix -Wcast-qual warnings
  mac80211: airtime: avoid variable shadowing
  cfg80211: pmsr: remove useless ifdef guards
  mac80211: remove unused macros

Mordechay Goodstein (4):
  mac80211: consider RX NSS in UHB connection
  mac80211: vht: use HE macros for parsing HE capabilities
  mac80211: mlme: add documentation from spec to code
  mac80211: mlme: validate peer HE supported rates

 drivers/net/wireless/ath/ath10k/txrx.c        |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c       |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   3 +
 include/linux/ieee80211.h                     |   8 +-
 include/net/cfg80211.h                        |  10 +-
 include/net/ieee80211_radiotap.h              |   4 +-
 include/net/mac80211.h                        |  19 +-
 net/mac80211/airtime.c                        |  11 +-
 net/mac80211/debugfs.c                        |   2 +
 net/mac80211/debugfs_key.c                    |   2 +-
 net/mac80211/debugfs_netdev.c                 |   4 +-
 net/mac80211/ieee80211_i.h                    |   2 +-
 net/mac80211/mesh.c                           |   2 +-
 net/mac80211/mlme.c                           | 183 +++++++++++++++++-
 net/mac80211/rc80211_minstrel_ht.c            |   2 +-
 net/mac80211/rx.c                             |   2 +
 net/mac80211/status.c                         |  14 +-
 net/mac80211/util.c                           |  27 ++-
 net/mac80211/vht.c                            |   4 +-
 net/wireless/pmsr.c                           |   4 -
 net/wireless/scan.c                           |   9 +-
 net/wireless/util.c                           |   8 +-
 23 files changed, 267 insertions(+), 62 deletions(-)

-- 
2.34.1

