Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC57B1FB5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjI1Ofz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjI1Ofy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:35:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B121A8
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911752; x=1727447752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wThjmvkLHxS5fVpDgOEnIV35hHPEp0rBhZ/ZEE9CqV4=;
  b=FYAdthIAcqhfIpxw7GGfZAjiMb4ve7NwlciLr+ihchm3QOsF9OWf2fvB
   Dz5ZYF5LhrZbvOBkQC5FaHoxH5RvxJz+gdxCXo8/guoe6WX2aQ1Uzc8nQ
   3o3ILb8liiur98duHIA6ruHQPiAwDBLxSZv/QkPtlAyOYMND9soodV4oh
   c93G/zHB7if9ENi01sIjvaPrDzW714VOGyNUU3ImEwSrBKGHqQMx4Ewn0
   r83i/v+uI20Ec3vczOUXIO1kUoEM3NYSx6aWyJRqtxp0q+0kEOoyPjf7B
   XoGE/bU6XNAONrzrpo+6aLJ+P/xgM0SrEhbi5D11jROxHHOkMFy5o1W4v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688395"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688395"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590378"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590378"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/18] cfg80211/mac80211 patches from our internal tree 2023-09-28 
Date:   Thu, 28 Sep 2023 17:35:21 +0300
Message-Id: <20230928143539.1037500-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Thanks,
Gregory

Benjamin Berg (2):
  wifi: mac80211: cleanup auth_data only if association continues
  wifi: mac80211: mesh: fix some kdoc warnings

Emmanuel Grumbach (1):
  wifi: mac80211: fix a expired vs. cancel race in roc

Ilan Peer (5):
  wifi: mac80211: Rename and update IEEE80211_VIF_DISABLE_SMPS_OVERRIDE
  wifi: cfg80211: Include operating class 137 in 6GHz band
  wifi: cfg80211: Handle specific BSSID in 6GHz scanning
  wifi: mac80211: Fix setting vif links
  wifi: cfg80211: Fix typo in documentation

Johannes Berg (4):
  wifi: mac80211: drop robust action frames before assoc
  wifi: mac80211: don't recreate driver link debugfs in reconfig
  wifi: cfg80211: wext: convert return value to kernel-doc
  wifi: mac80211: flush STA queues on unauthorization

Miri Korenblit (6):
  wifi: mac80211: add a driver callback to add vif debugfs
  wifi: mac80211: handle debugfs when switching to/from MLO
  wifi: mac80211: Check if we had first beacon with relevant links
  wifi: mac80211: add link id to mgd_prepare_tx()
  wifi: mac80211: make mgd_protect_tdls_discover MLO-aware
  wifi: mac80211: purge TX queues in flush_queues flow

 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  5 +-
 include/net/cfg80211.h                        |  2 +-
 include/net/mac80211.h                        | 18 ++++--
 net/mac80211/cfg.c                            |  6 ++
 net/mac80211/debugfs_netdev.c                 | 28 +++++++--
 net/mac80211/debugfs_netdev.h                 | 15 ++++-
 net/mac80211/driver-ops.c                     | 23 +++++--
 net/mac80211/driver-ops.h                     | 32 +++++++++-
 net/mac80211/ieee80211_i.h                    |  1 +
 net/mac80211/iface.c                          |  2 +-
 net/mac80211/link.c                           |  7 ++-
 net/mac80211/mesh.c                           |  8 ++-
 net/mac80211/mesh_hwmp.c                      |  2 +
 net/mac80211/mesh_pathtbl.c                   | 20 ++++---
 net/mac80211/mesh_plink.c                     |  6 +-
 net/mac80211/mesh_ps.c                        |  6 +-
 net/mac80211/mesh_sync.c                      |  4 +-
 net/mac80211/mlme.c                           | 41 ++++++++++---
 net/mac80211/offchannel.c                     | 17 ++++++
 net/mac80211/rx.c                             |  9 +++
 net/mac80211/sta_info.c                       | 60 ++++++++++++-------
 net/mac80211/tdls.c                           |  2 +-
 net/mac80211/util.c                           | 13 ++++
 net/wireless/scan.c                           | 37 ++++++++++++
 net/wireless/util.c                           |  1 +
 net/wireless/wext-compat.c                    |  4 +-
 28 files changed, 304 insertions(+), 74 deletions(-)

-- 
2.38.1

