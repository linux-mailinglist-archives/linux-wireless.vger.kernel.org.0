Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0C72823F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjFHOHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbjFHOHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015081BE8
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233229; x=1717769229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ja3Qt5W7dw3/Vh6S287WL2e89IHYKZ7Pmy52t9dqoSY=;
  b=fsojvROl7hBlg2bhOk0o2vG8majiQn1otmSPjHBS4PjllgyG9HwSE8rk
   D93iS5+6S3Mg2lJHX/ySl/rBEjtVk455jSC+F43soF2tY6S/NZRSXv2Kc
   wMcrXB1Kmg4Et2nb6S9hh+O5VmfrNKxtLgvwV7fCCfD9sIqO1kt+IpshD
   O2xgEG72leh5CKoFWRc2olUH7Q8gJ+8plif/4ZZB7A2PYLJ1roeftOPah
   mrGXQTN07pHPJ8qdjrg02kEjTE5BkIeChldIvIqgLugypDRsNFFwH5RJz
   dB/K1XCXt23qOz7MtLN1LwuVLSt7gZQeZ31BWayhyIzt6H/n1a77Ywjcn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176185"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176185"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706069"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706069"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] cfg80211/mac80211 patches from our internal tree 2023-06-08 
Date:   Thu,  8 Jun 2023 16:35:56 +0300
Message-Id: <20230608133611.1303724-1-gregory.greenman@intel.com>
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

Hi

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, cleanups and
bugfixes. 

Thanks,
Gregory

Anjaneyulu (1):
  wifi: mac80211: pass roc->sdata to drv_cancel_remain_on_channel()

Benjamin Berg (3):
  wifi: cfg80211: fix link del callback to call correct handler
  wifi: mac80211: take lock before setting vif links
  wifi: mac80211: fix CSA processing while scanning

Ilan Peer (5):
  wifi: mac80211: Use active_links instead of valid_links in Tx
  wifi: mac80211: Add getter functions for vif MLD state
  wifi: mac80211_hwsim: Don't access vif valid links directly
  wifi: cfg80211: Support association to AP MLD with disabled links
  wifi: mac80211: Support disabled links during association

Johannes Berg (5):
  wifi: mac80211: include key action/command in tracing
  wifi: mac80211: fix link activation settings order
  wifi: mac80211: mlme: clarify WMM messages
  wifi: cfg80211: remove links only on AP
  wifi: mac80211: don't update rx_stats.last_rate for NDP

Miri Korenblit (1):
  wifi: mac80211: disable SMPS override via debugfs

 drivers/net/wireless/virtual/mac80211_hwsim.c |   5 +-
 include/net/cfg80211.h                        |   5 +-
 include/net/mac80211.h                        |  28 ++++-
 include/uapi/linux/nl80211.h                  |   7 +-
 net/mac80211/cfg.c                            |  15 ++-
 net/mac80211/debug.h                          |   8 +-
 net/mac80211/debugfs_netdev.c                 |   5 +-
 net/mac80211/ieee80211_i.h                    |   6 +-
 net/mac80211/iface.c                          |   4 +-
 net/mac80211/link.c                           |  46 ++++----
 net/mac80211/mlme.c                           | 103 ++++++++++--------
 net/mac80211/offchannel.c                     |   4 +-
 net/mac80211/rx.c                             |   8 +-
 net/mac80211/trace.h                          |   8 +-
 net/mac80211/tx.c                             |  28 ++---
 net/mac80211/util.c                           |  14 +--
 net/wireless/nl80211.c                        |  13 ++-
 net/wireless/rdev-ops.h                       |   6 +-
 net/wireless/util.c                           |   9 +-
 19 files changed, 204 insertions(+), 118 deletions(-)

-- 
2.38.1

