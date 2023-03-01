Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893EA6A6A8E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCAKKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCAKKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90A1E5FA
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665408; x=1709201408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EI+AkXojZaJfcPWzORDpSjuzK9YdixBS/Brv3D2UUj0=;
  b=HYNb9jCAAmDesDQRW0heyK7aG+bTukm6MeNjy24bWXIzK01sfwBBTjSm
   JuNbrMaueV1qtUC67CL62QHaCO78BUi+mJDEpOOsxOK+ESu7r2/+4N8oC
   qsy55mhNYBsLnRHOT0xk9v07sVjPGQarF0ZDmI3GLjPIye3qJ8B6SB+f/
   VeSKw1PNQilWLyj8ct5+Kn87IxBjoAxjxlBcpQK0A57N0nKCi1TLdIKT/
   KGfNHGuWkgU9KxcSGlmq01IN0QGDUlX/IiOzKOpRjP3nl2Vy9fJt1DxdQ
   ZcCDocTv1gARwlfQH4bz3aAgcutE33tOiUrdakHKlq2VvGlAF+qdGJOnY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662733"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:09:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738588981"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738588981"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:09:51 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 00/23] cfg80211/mac80211 patches from our internal tree 2023-02-21 
Date:   Wed,  1 Mar 2023 12:09:12 +0200
Message-Id: <20230301100935.170922-1-gregory.greenman@intel.com>
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

In this v2 patch series I've combined two patch series I sent before
and fixed all the comments.

The changes are:
* HW timestamping updates
* A few MLO adjustments
* Bug fixes and cleanups
* Prepartions for adding EHT and new radiotap format

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
  wifi: nl80211: Update the documentation of
    NL80211_SCAN_FLAG_COLOCATED_6GHZ
  wifi: mac80211_hwsim: Indicate support for
    NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT

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

Mordechay Goodstein (6):
  wifi: mac80211: clear all bits that relate rtap fields on skb
  wifi: wireless: return primary channel regardless of DUP
  wifi: wireless: correct validation 6G Band for primary channel
  wifi: wireless: cleanup unused function parameters
  wifi: ieee80211_radiotap: Add EHT radiotap definitions
  wifi: mac80211: add support for driver adding radiotap TLVs

 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  27 ++-
 drivers/net/wireless/mac80211_hwsim.c         |  48 ++--
 include/net/cfg80211.h                        |  36 ++-
 include/net/ieee80211_radiotap.h              | 207 +++++++++++++++-
 include/net/mac80211.h                        |  63 ++---
 include/uapi/linux/nl80211.h                  |  31 ++-
 net/mac80211/cfg.c                            |  19 +-
 net/mac80211/debugfs_netdev.c                 | 223 +++++++++++++-----
 net/mac80211/debugfs_netdev.h                 |  16 ++
 net/mac80211/driver-ops.c                     |  25 +-
 net/mac80211/driver-ops.h                     |  16 ++
 net/mac80211/ieee80211_i.h                    |   4 +
 net/mac80211/link.c                           |   5 +
 net/mac80211/mlme.c                           |   6 +-
 net/mac80211/rx.c                             |  93 +++-----
 net/mac80211/scan.c                           |   8 +-
 net/mac80211/tx.c                             |  10 +
 net/wireless/nl80211.c                        |  71 ++++--
 net/wireless/rdev-ops.h                       |  17 ++
 net/wireless/scan.c                           |  39 +--
 net/wireless/trace.h                          |  36 ++-
 21 files changed, 752 insertions(+), 248 deletions(-)

-- 
2.38.1

