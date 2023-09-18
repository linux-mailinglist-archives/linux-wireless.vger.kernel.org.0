Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F27A480D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbjIRLLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbjIRLLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DAAE6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035487; x=1726571487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z7ZkAsYv6A3V4CbXA0U2r76lZE2XwcMiq0/pRHTY7wA=;
  b=YB0RPAdwr9kiF7PKOs+4kKSUHQHT1adsML4ZHAEqfypKjcuRrVK0TXXN
   0qHEFBzjoCYVn6xUrVH4uTaXZqZuva5FX84oWFz7gHTTa0CC618a/p0WS
   Eal4be5/O5QRvyy/Jtm8dR7TrXPWwZ4X4vYhXbJzKXDnDZb5CBhxy3of2
   UlAFEYK+TkHk73dcfqsmYmyv2+RQu5X1W+mhV1CLh2GA4qTbTtfh5OBGm
   pqkt2xX9/siEhGd1pwuJq+PIq+3QnsGK0+9VaxdOq+9WZaxoYMhAwL0m+
   bxOxDdFNcOfmABXJ4jiBx2s+KQeDF99esp1B8BpNGPQreZA7z6XYZjiw+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535675"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535675"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025177"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025177"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/18] cfg80211/mac80211 patches from our internal tree 2023-09-18 
Date:   Mon, 18 Sep 2023 14:10:45 +0300
Message-Id: <20230918111103.435195-1-gregory.greenman@intel.com>
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

The changes are:

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
  wifi: mac80211: Notify the low level driver on change in MLO valid links
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
 include/linux/ieee80211.h                     |  76 +++++
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
 17 files changed, 555 insertions(+), 53 deletions(-)

-- 
2.38.1

