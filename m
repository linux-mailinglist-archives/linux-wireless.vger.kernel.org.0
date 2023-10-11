Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8267C4FA9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjJKKI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJKKIn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CCC19AF
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018861; x=1728554861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CDz+rR6DwU7lHttpVsKiR7BvfIT7lpXh9gDIC/NZzFM=;
  b=en8p9oa8y+WJE0azE3uXbUwDcyO4VggDs6UxqBlQZWda5yq4pzB+DFmC
   Au5fjqgPWKGn7XwmY9SZRFvIQIMw78NOn5eyUXkJCs6PhmQBKoBNUYQhA
   4+gBmu36TiVVA7s2/i4z4+Km3i6DzVaBsZ5Te02O5Wl8j44P3pLdNoV0d
   cO7BxKeYCRaRwWJgZgRlzcYaw9PWy/JVxiykZq3bsGIJ9SCjuY8cUySsv
   vToR8X/BvACfgxqZNrKrgRAzNAUeS+Z4vM4vuPSH1m+yb8ZZDHIz7J06u
   oh6T43pqUGxAjOmiKZ4sUS6drPE71JSdcQLy9yAq8lfILlUWIwFqaatCR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670543"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670543"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050209"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050209"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/16] wifi: iwlwifi: updates - 2023-10-11 
Date:   Wed, 11 Oct 2023 13:07:15 +0300
Message-Id: <20231011100731.361200-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7.

It contains:
* Version 3 of ROC
* MLO fixes and improvements
* cleanups and bugfixes, including a fix for W=1 compilation warning

Thanks,
Gregory

Alon Giladi (1):
  wifi: iwlwifi: send EDT table to FW

Emmanuel Grumbach (3):
  wifi: iwlwifi: mvm: don't add dummy phy context
  wifi: iwlwifi: mvm: fold the ref++ into iwl_mvm_phy_ctxt_add
  wifi: iwlwifi: mvm: fix the PHY context resolution for p2p device

Gregory Greenman (1):
  wifi: iwlwifi: fw: increase fw_version string size

Haim Dreyfuss (1):
  wifi: iwlwifi: mvm: extend alive timeout to 2 seconds

Ilan Peer (2):
  wifi: iwlwifi: mvm: Fix unreachable code path
  wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface

Johannes Berg (3):
  wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API
  wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()
  wifi: iwlwifi: mvm: remove TDLS stations from FW

Matt Chen (1):
  wifi: iwlmvm: fw: Add new OEM vendor to tas approved list

Miri Korenblit (2):
  wifi: iwlwifi: mvm: cleanup MLO and non-MLO unification code
  wifi: iwlwifi: add support for activating UNII-1 in WW via BIOS

Mukesh Sisodiya (1):
  wifi: iwlwifi: add new RF support for wifi7

Shaul Triebitz (1):
  wifi: iwlwifi: mvm: implement ROC version 3

 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   3 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  10 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  44 ++-
 .../intel/iwlwifi/fw/api/time-event.h         |  57 ++++
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  56 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 283 +++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  41 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   5 +
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  69 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  12 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  57 +++-
 .../wireless/intel/iwlwifi/mvm/time-event.h   |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  18 +-
 19 files changed, 442 insertions(+), 252 deletions(-)

-- 
2.38.1

