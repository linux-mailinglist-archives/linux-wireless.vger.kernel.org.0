Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B726A05AC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjBWKKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjBWKKQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD851928
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147009; x=1708683009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4fp3OBf0I3iq1QQ5DJWx6FG9ApEiQxdo28XXpa+IMiU=;
  b=Tt5UDTCGULjEl5OhYoDaQoxulNX9UP8IgSDdxY+5Z9B6tawiexNcRchs
   4FPVrYD0oYRKqstu1PMLyvhWsiudH5gR+7yRVN6olJtO1nzT2H4SGGIdR
   XjnNBlqmfuyLs2nwQMQ6tl4sE3+64RglOO7N/wS/hndDpPgsyb3SpqcWu
   zqcxrTBqsJz+fB+T4/KW2i66tM5Dfm5wBkHmrRhk0bqUHwB7MJ94wR5CC
   lcUG3S5lx61XNBrREwtCcisTo59ZDBGnRMhvMjs0p2zqUmSkSOinrU0S2
   zmbOvlqkh+An33Q4bA553s26xhzxEsvddX6G/czM6jnW9yqV/7P82URtN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396148"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396148"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796244808"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796244808"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:06 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/21] cfg80211/mac80211 patches from our internal tree 2023-02-21
Date:   Thu, 23 Feb 2023 12:09:21 +0200
Message-Id: <20230223100942.767589-1-gregory.greenman@intel.com>
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

A bunch of patches from our internal tree with mac80211 and cfg80211
changes. It's the usual developement, cleanups and bugfixes.

The changes are:
* HW timestamping updates
* A few MLO adjustments
* Bug fixes and cleanups

The changes were tested by kbuild bot in the pending branch.

Thanks,
Gregory


Avraham Stern (2):
  wifi: nl80211/cfg80211: add command to enable/disable HW timestamping
  wifi: mac80211: add support for set_hw_timestamp command

Benjamin Berg (3):
  wifi: mac80211: add pointer from bss_conf to vif
  wifi: mac80211: remove SMPS from AP debugfs
  wifi: mac80211: add netdev per-link debugfs data and driver hook

Ilan Peer (2):
  wifi: nl80211: Update the documentation of NL80211_SCAN_FLAG_COLOCATED_6GHZ
  wifi: mac80211_hwsim: Indicate support for NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT

Johannes Berg (10):
  wifi: mac80211: adjust scan cancel comment/check
  wifi: mac80211: check key taint for beacon protection
  wifi: mac80211: allow beacon protection HW offload
  wifi: cfg80211/mac80211: report link ID on control port RX
  wifi: mac80211: warn only once on AP probe
  wifi: nl80211: fix NULL-ptr deref in offchan check
  wifi: mac80211: mlme: remove pointless sta check
  wifi: mac80211: simplify reasoning about EHT capa handling
  wifi: mac80211: fix ieee80211_link_set_associated() type
  wifi: cfg80211: fix MLO connection ownership

Mordechay Goodstein (4):
  wifi: mac80211: clear all bits that relate rtap fields on skb
  wifi: net: wireless: return primary channel regardless of DUP
  wifi: net: wireless: correct validation 6G Band for primary channel
  wifi: net: wireless: cleanup unused function parameters

 drivers/net/wireless/mac80211_hwsim.c |   3 +
 include/net/cfg80211.h                |  36 ++++-
 include/net/mac80211.h                |  19 +++
 include/uapi/linux/nl80211.h          |  31 +++-
 net/mac80211/cfg.c                    |  19 ++-
 net/mac80211/debugfs_netdev.c         | 223 +++++++++++++++++++-------
 net/mac80211/debugfs_netdev.h         |  16 ++
 net/mac80211/driver-ops.c             |  25 ++-
 net/mac80211/driver-ops.h             |  16 ++
 net/mac80211/ieee80211_i.h            |   4 +
 net/mac80211/link.c                   |   5 +
 net/mac80211/mlme.c                   |   6 +-
 net/mac80211/rx.c                     |  13 +-
 net/mac80211/scan.c                   |   8 +-
 net/mac80211/tx.c                     |  10 ++
 net/wireless/nl80211.c                |  71 ++++++--
 net/wireless/rdev-ops.h               |  17 ++
 net/wireless/scan.c                   |  39 ++---
 net/wireless/trace.h                  |  36 ++++-
 19 files changed, 477 insertions(+), 120 deletions(-)

-- 
2.38.1

