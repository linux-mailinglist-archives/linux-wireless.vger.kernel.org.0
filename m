Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3712DCAC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfE2MZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54272 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbfE2MZr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeL-0007wy-3Z; Wed, 29 May 2019 15:25:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 00/10] cfg80211/mac80211 patches from our internal tree 2019-05-29
Date:   Wed, 29 May 2019 15:25:27 +0300
Message-Id: <20190529122537.8564-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Some patches with mac80211 and cfg80211 changes from our internal
tree.

Please review, though you have already reviewed most if not all of
them ;)

Cheers,
Luca.


Avraham Stern (1):
  cfg80211: report measurement start TSF correctly

Ilan Peer (2):
  cfg80211: Add a function to iterate all BSS entries
  ieee80211: Add a missing extended capability flag definition

Johannes Berg (4):
  mac80211: call rate_control_send_low() internally
  mac80211: use STA info in rate_control_send_low()
  mac80211: fill low rate even for HAS_RATE_CONTROL
  mac80211: extend __rate_control_send_low warning

Luca Coelho (1):
  cfg80211: use BIT_ULL in cfg80211_parse_mbssid_data()

Mordechay Goodstein (1):
  cfg80211: util: fix bit count off by one

Naftali Goldstein (1):
  mac80211: do not start any work during reconfigure flow

 drivers/net/wireless/intel/iwlegacy/3945-rs.c |  3 --
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |  4 --
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   | 26 ++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  4 --
 drivers/net/wireless/realtek/rtlwifi/rc.c     |  3 --
 include/linux/ieee80211.h                     |  7 +++
 include/net/cfg80211.h                        | 20 +++++++++
 include/net/mac80211.h                        | 23 ----------
 net/mac80211/cfg.c                            |  4 +-
 net/mac80211/ieee80211_i.h                    |  7 +++
 net/mac80211/mlme.c                           |  7 ++-
 net/mac80211/rate.c                           | 28 ++++++------
 net/mac80211/rc80211_minstrel.c               |  5 +--
 net/mac80211/rc80211_minstrel_ht.c            |  4 +-
 net/mac80211/sta_info.c                       | 43 ++++++++++++++++++-
 net/mac80211/util.c                           |  4 ++
 net/wireless/pmsr.c                           |  4 +-
 net/wireless/scan.c                           | 25 ++++++++++-
 net/wireless/util.c                           |  2 +-
 19 files changed, 141 insertions(+), 82 deletions(-)

-- 
2.20.1

