Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F2A7368B6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjFTKEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjFTKEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CF1B0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255469; x=1718791469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X2Qln6YHQqFCaGCTvZhCP1a91BxN4vMjFzJNeM0GCOk=;
  b=cGPhMvTRkUlgInU1JrIs+7PpsCIRjLyPGlMUgiX5UCUU9u3pYZJv8iiX
   j3NbkJVwhNxCu3VNFKrcDVTwq+JzCTuBIfEH5hzKZi+0TnlHUU3NEUUjS
   +0/+i5joBSwp/eCce/dtVgbXKFlGVaP1FaeUPinLLuXLTE+ttlc+KTo9u
   Ep0cXaJSfl6D+dO8fL92GC1RI5wengxnI4qctLQFPaCV9sJVYiTS6zIWw
   M/8iD/WfdsiUfrg8dW4wTnhtkpi2jQ5Cz5+Auz2aiCvrnKP/C54qHm60x
   IgAR4jZ5Ykqwt4UeXhlvPbrfE/gbTR9eoFjwphLKg1mkCmVQJGQM0JLym
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819513"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819513"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838142582"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838142582"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/19] wifi: iwlwifi: updates intended for v6.5 2023-06-20 
Date:   Tue, 20 Jun 2023 13:03:46 +0300
Message-Id: <20230620100405.45117-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.

It contains normal developement, cleanups and bugfixes.

Thanks,
Gregory

Benjamin Berg (1):
  wifi: iwlwifi: mvm: send LARI configuration earlier

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: check the right csa_active
  wifi: iwlwifi: mvm: make iwl_mvm_set_fw_mu_edca_params mld aware

Ilan Peer (1):
  wifi: iwlwifi: mvm: Add support for scan version 17

Johannes Berg (13):
  wifi: iwlwifi: pcie: refactor RB status size calculation
  wifi: iwlwifi: pcie: add size assertions
  wifi: iwlwifi: nvm: handle EHT/320 MHz regulatory flag
  wifi: iwlwifi: mvm: use EHT maximum MPDU length on 2.4 GHz
  wifi: iwlwifi: mvm: use min_t() for agg_size
  wifi: iwlwifi: mvm: add EHT A-MPDU size exponent support
  wifi: iwlwifi: limit EHT capabilities based on PCIe link speed
  wifi: iwlwifi: remove disable_dummy_notification
  wifi: iwlwifi: mvm: support new flush_sta method
  wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
  wifi: iwlwifi: mvm: avoid baid size integer overflow
  wifi: iwlwifi: mvm: check only affected links
  wifi: iwlwifi: mvm: adjust skip-over-dtim in D3

Miri Korenblit (1):
  wifi: iwlwifi: fw: send marker cmd before suspend cmd

Mukesh Sisodiya (1):
  wifi: iwlwifi: Add support for new PCI Id

 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  28 +++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  56 ++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   2 +
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  22 ----
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 -
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  22 +++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  38 +++++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  15 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 113 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  34 ++++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  11 ++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  24 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |   7 ++
 24 files changed, 302 insertions(+), 122 deletions(-)

-- 
2.38.1

