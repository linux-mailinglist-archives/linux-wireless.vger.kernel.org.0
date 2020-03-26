Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C990C193F73
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCZNJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:09:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44304 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbgCZNJz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:09:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGe-00044K-Ja; Thu, 26 Mar 2020 15:09:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:31 +0200
Message-Id: <20200326130943.623208-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 00/12] cfg80211/mac80211 patches from our internal tree 2020-03-26-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A bunch of patches with mac80211 and cfg80211 changes from our
internal tree.

Please review, though you have already reviewed most if not all of
them ;)

In v2 I replaced the Change-Ids with Message-Ids as it should be.

Cheers,
Luca.


Andrei Otcheretianski (1):
  mac80211: Don't destroy auth data in case of anti-clogging

Ilan Peer (4):
  cfg80211: Parse HE membership selector
  mac80211: Skip entries with HE membership selector
  mac80211: Fail association when AP has no legacy rates
  cfg80211: Do not warn on same channel at the end of CSA

Johannes Berg (4):
  mac80211: implement Operating Mode Notification extended NSS support
  mac80211: minstrel_ht_assign_best_tp_rates: remove redundant test
  mac80211_hwsim: indicate in IBSS that we have transmitted beacons
  mac80211: drop data frames without key on encrypted links

Mordechay Goodstein (2):
  mac80211: agg-tx: refactor sending addba
  mac80211: agg-tx: add an option to defer ADDBA transmit

Shaul Triebitz (1):
  mac80211: add twt_protected flag to the bss_conf structure

 drivers/net/wireless/intel/iwlwifi/mvm/rs.c |  6 +-
 drivers/net/wireless/mac80211_hwsim.c       |  6 ++
 include/linux/ieee80211.h                   | 13 +++-
 include/net/cfg80211.h                      |  3 +-
 include/net/mac80211.h                      |  8 ++-
 net/mac80211/agg-tx.c                       | 79 +++++++++++++--------
 net/mac80211/debugfs_sta.c                  |  3 +-
 net/mac80211/key.c                          | 20 +++---
 net/mac80211/mlme.c                         | 33 +++++++--
 net/mac80211/rc80211_minstrel_ht.c          |  3 +-
 net/mac80211/sta_info.h                     |  3 +
 net/mac80211/tx.c                           | 12 +++-
 net/mac80211/vht.c                          | 10 ++-
 net/wireless/nl80211.c                      |  2 +
 net/wireless/scan.c                         |  6 +-
 net/wireless/util.c                         | 26 +++----
 16 files changed, 163 insertions(+), 70 deletions(-)

-- 
2.25.1

