Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFD7A8B9F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjITSZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITSZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:25:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523DCF
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234342; x=1726770342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OwuT2P9MtNVbPsj7Pouvta5ro4izHRkMOBvDIozPO8M=;
  b=ALFujjpvY/Dz+Dz1umHWh4hXaGyXQiaaL3UziO8e6qd25KzSWl54+mwn
   s3rQPu2GEkazMHYra0pGxb6YuDOeOKZFfKJQU3pid8/rr5eTsE8tVE0U9
   mdY4TuBuazAQA20/zw2KiJJPzu26NytqIA43BEciWEUwIaDtH9It4iJCE
   VqUb4GwH7eSzFubeOEZG7VsG9GAk20rHn+Cwew1k9CqVfmlU2XqYrzoEN
   mzvLqhJORf0VwySiImXOxwg/tnALVdci8RPTaFh/U5UnXlNnGTDY+vL6S
   UBxgXetByIRUN8s0P4dVax0lkk1arL35TrV2MFA2Li8xi9YHsHPzCVeoU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556213"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556213"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424120"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424120"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:25:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 00/18] cfg80211/mac80211 patches from our internal tree 2023-09-18 
Date:   Wed, 20 Sep 2023 21:25:11 +0300
Message-Id: <20230920182529.659973-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

v2: Modified patches 13 and 14 according to the received comments
(update draft version to D4, rename t2l_map to ttlm to have the
same terminology as the draft and add some kernel-doc); Fixed
typo in commit message of patch 11.

The changes in this patch set are:

* add implementation for set_antenna API
* CSA fixes
* initial support for TID to link mapping
* MLO improvements
* fixes and cleanups

Thanks,
Gregory

Ayala Beker (3):
  wifi: mac80211: don't connect to an AP while it's in a CSA process
  wifi: mac80211: add support for parsing TID to Link mapping element
  wifi: mac80211: support handling of advertised TID-to-link mapping

Benjamin Berg (3):
  wifi: cfg80211: report per-link errors during association
  wifi: mac80211: report per-link error during association
  wifi: mac80211: reject MLO channel configuration if not supported

Emmanuel Grumbach (1):
  wifi: mac80211: update the rx_chains after set_antenna()

Ilan Peer (3):
  wifi: cfg80211: Fix 6GHz scan configuration
  wifi: mac80211: Notify the low level driver on change in MLO valid
    links
  wifi: mac80211_hwsim: Handle BSS_CHANGED_VALID_LINKS

Johannes Berg (8):
  wifi: mac80211: use bandwidth indication element for CSA
  wifi: mac80211: relax RCU check in for_each_vif_active_link()
  wifi: mac80211: allow for_each_sta_active_link() under RCU
  wifi: cfg80211: reg: describe return values in kernel-doc
  wifi: mac80211: describe return values in kernel-doc
  wifi: mac80211_hwsim: move kernel-doc description
  wifi: mac80211: work around Cisco AP 9115 VHT MPDU length
  wifi: mac80211: support antenna control in injection

 drivers/net/wireless/virtual/mac80211_hwsim.c |  26 +-
 include/linux/ieee80211.h                     |  83 +++++
 include/net/cfg80211.h                        |   3 +
 include/net/mac80211.h                        |  12 +-
 net/mac80211/cfg.c                            |  11 +-
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |  22 +-
 net/mac80211/main.c                           |   3 +-
 net/mac80211/mesh_plink.c                     |   2 +-
 net/mac80211/mlme.c                           | 284 +++++++++++++++++-
 net/mac80211/spectmgmt.c                      |  13 +-
 net/mac80211/tx.c                             |  16 +
 net/mac80211/util.c                           |  52 +++-
 net/mac80211/vht.c                            |  16 +-
 net/wireless/nl80211.c                        |  50 ++-
 net/wireless/reg.c                            |  16 +-
 net/wireless/scan.c                           |   4 +
 17 files changed, 562 insertions(+), 53 deletions(-)

-- 
2.38.1

