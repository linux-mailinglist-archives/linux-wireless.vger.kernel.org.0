Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A82789D19
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjH0LF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0LFt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:05:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AB1180
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134346; x=1724670346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c61SiZptGY7pFDWvAAHkIMrFJhwmJqMuDwE2b9Z247M=;
  b=Z3xWUAqs6/Kgye39SiuVAMcxjFfGTNrbFFmBbNYPOiGvRyXSFTp6VQAj
   TPIYvxJsRVh0tHbXPl/HF0vBk7m3altv2i7Y+FNxFXDHkViU0AXcD8FKh
   FwXBL4MGLyARpq/mQYC3tS7TA39knw+3dsnSUGp/v4njsoEvUaOILOqot
   uAQMGf9H8Ctno9K27yYRm09wkR8oRr8htMvhyN+93J5cSFR8fTgFjIKJ8
   QGFkjxW/ochGaPTUg9BHOL0TT0EfTkeN7GjSgk7hmF3NKvTm4Ehcq3XHu
   16e7Qk1Cz7/V9cORVnT0Q4eV6WRgfJafHZ/nrhJsqFjYEZPlTsEzyP+UT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301529"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632939"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] cfg80211/mac80211 patches from our internal tree 2023-08-27 
Date:   Sun, 27 Aug 2023 14:05:17 +0300
Message-Id: <20230827110532.348304-1-gregory.greenman@intel.com>
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
  wifi: cfg80211: add ieee80211_fragment_element to public API
  wifi: mac80211: add more warnings about inserting sta info

Emmanuel Grumbach (1):
  wifi: mac80211: add support for mld in ieee80211_chswitch_done

Ilan Peer (2):
  wifi: mac80211: Print local link address during authentication
  wifi: mac80211: Do not force off-channel for management Tx with MLO

Johannes Berg (10):
  wifi: cfg80211: fix off-by-one in element defrag
  wifi: cfg80211: add first kunit tests, for element defrag
  wifi: mac80211: add an element parsing unit test
  wifi: mac80211: remove unnecessary struct forward declaration
  wifi: mac80211: fix various kernel-doc issues
  wifi: cfg80211: reg: fix various kernel-doc issues
  wifi: mac80211_hwsim: clean up kernel-doc
  wifi: mac80211: fix # of MSDU in A-MSDU calculation
  wifi: mac80211: take MBSSID/EHT data also from probe resp
  wifi: mac80211: fix channel switch link data

 .../net/wireless/intel/iwlegacy/4965-mac.c    |   2 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 drivers/net/wireless/ti/wlcore/main.c         |   6 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h |  19 +--
 include/net/cfg80211.h                        |  12 ++
 include/net/mac80211.h                        |   8 +-
 net/mac80211/Kconfig                          |  11 ++
 net/mac80211/Makefile                         |   2 +
 net/mac80211/cfg.c                            |  42 ++---
 net/mac80211/driver-ops.h                     |   6 +-
 net/mac80211/ieee80211_i.h                    |  21 +--
 net/mac80211/mlme.c                           |  73 +++++---
 net/mac80211/offchannel.c                     |   8 +-
 net/mac80211/sta_info.c                       |  10 +-
 net/mac80211/sta_info.h                       |   4 +-
 net/mac80211/tests/Makefile                   |   3 +
 net/mac80211/tests/elems.c                    | 101 +++++++++++
 net/mac80211/tests/module.c                   |  10 ++
 net/mac80211/util.c                           |  30 +---
 net/wireless/Kconfig                          |  11 ++
 net/wireless/Makefile                         |   1 +
 net/wireless/reg.h                            |  16 +-
 net/wireless/scan.c                           |   4 +-
 net/wireless/tests/Makefile                   |   3 +
 net/wireless/tests/fragmentation.c            | 157 ++++++++++++++++++
 net/wireless/tests/module.c                   |  10 ++
 net/wireless/util.c                           |  29 ++++
 33 files changed, 500 insertions(+), 126 deletions(-)
 create mode 100644 net/mac80211/tests/Makefile
 create mode 100644 net/mac80211/tests/elems.c
 create mode 100644 net/mac80211/tests/module.c
 create mode 100644 net/wireless/tests/Makefile
 create mode 100644 net/wireless/tests/fragmentation.c
 create mode 100644 net/wireless/tests/module.c

-- 
2.38.1

