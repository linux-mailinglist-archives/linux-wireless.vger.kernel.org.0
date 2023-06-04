Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643187215B3
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFDJLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFDJLq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:11:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CEF135
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869904; x=1717405904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCkqH6sT485Lq/EbXbQ9qX+FxrRevJPe88Eyws1Lghw=;
  b=Tlfus+GCcVQ8Uq46z/4kLzizLOAO+wNzMFnrUSw5jL74a8HrcwMzLSsi
   +T6fqvrCOR3gI8c3maxiAWpCzAk2ZbmxgskEdVzfEt4uiXd/sJx2+MQdl
   5MW+ryUOT/IcZgND2LzlGcJWfuu9eVb8TlyAvSsA0Sd7p+uWz/25Cr7Mm
   9i8XgyzFxRv/eEWk8fr/6NmX5h7t95ZYFjhKydHoB1koVjYxBhdcxhkVd
   lYvqjS5aixikJYqAl7Iaxnm+lKyYaAjeJ+Rk8nChkpG+2jo3OZrfrb3yx
   OdwumJh1aQtrxPkn0+d3mqnDHaVTjXJnk7gjUxb7lSesBCrtMWNqkn3Nc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526460"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804243"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804243"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/16] cfg80211/mac80211 patches from our internal tree 2023-06-04 
Date:   Sun,  4 Jun 2023 12:11:12 +0300
Message-Id: <20230604091128.609335-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, cleanups and
bugfixes.

This patch set depends on the previous cfg80211/mac80211
patch set from 2023-05-04.

Thanks,
Gregory

Anjaneyulu (2):
  wifi: mac80211: remove typecast in a call to ieee80211_config_bw()
  wifi: mac80211: Modify type of "changed" variable.

Emmanuel Grumbach (1):
  wifi: mac80211: provide a helper to fetch the medium synchronization
    delay

Ilan Peer (1):
  wifi: mac80211_hwsim: Fix possible NULL dereference

Johannes Berg (9):
  wifi: mac80211: don't translate beacon/presp addrs
  wifi: mac80211: mlme: fix non-inheritence element
  wifi: cfg80211: reject bad AP MLD address
  wifi: mac80211: recalc min chandef for new STA links
  wifi: mac80211: move sta_info_move_state() up
  wifi: mac80211: batch recalc during STA flush
  wifi: mac80211: use correct iftype HE cap
  wifi: mac80211: add helpers to access sband iftype data
  wifi: mac80211: stop warning after reconfig failures

Mukesh Sisodiya (3):
  wifi: mac80211: use u64 to hold enum ieee80211_bss_change flags
  wifi: mac80211: refactor ieee80211_select_link_key()
  wifi: mac80211_hwsim: check the return value of nla_put_u32

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   5 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   9 +-
 include/linux/ieee80211.h                     |  35 +++
 include/net/mac80211.h                        |  47 +++-
 net/mac80211/cfg.c                            |  81 +++---
 net/mac80211/chan.c                           |   6 +-
 net/mac80211/driver-ops.h                     |  10 +-
 net/mac80211/eht.c                            |   5 +-
 net/mac80211/he.c                             |  14 +-
 net/mac80211/ibss.c                           |  16 +-
 net/mac80211/ieee80211_i.h                    |  19 +-
 net/mac80211/iface.c                          |   7 +-
 net/mac80211/main.c                           |   4 +-
 net/mac80211/mesh.c                           |  30 +--
 net/mac80211/mesh.h                           |  19 +-
 net/mac80211/mesh_plink.c                     |  37 +--
 net/mac80211/mesh_ps.c                        |   7 +-
 net/mac80211/mlme.c                           |  55 ++--
 net/mac80211/ocb.c                            |   4 +-
 net/mac80211/rx.c                             |   4 +-
 net/mac80211/sta_info.c                       | 235 ++++++++++--------
 net/mac80211/tx.c                             |  28 +--
 net/mac80211/util.c                           |  16 +-
 net/wireless/nl80211.c                        |   2 +
 26 files changed, 404 insertions(+), 302 deletions(-)

-- 
2.38.1

