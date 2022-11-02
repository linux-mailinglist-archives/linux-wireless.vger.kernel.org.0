Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF6616574
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKBPAn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBPAm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E352FE
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401240; x=1698937240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qV/ftOs8ILXXP4qgdKVd56dEYKNSwuXnZ0inSUEFhOw=;
  b=hi2M9bxGlCVH365ZB3Wa8mJ8v9T3Q+kIKcs8C8nIeqTAaw3Xbe664jvz
   r3+x0EuS+tbYSL1SZ7HMTpQwCl7PPTveBrVdlzjavwd+mLK038MNByPfa
   OoDNmn8jTPV1wsjpCWnG9uaBbQqjYQIaAFGdvBErpFA8pTHHMiVYbypYM
   C0WHRYUPM5Uqy2QsRk1RgJX4olXyqXXoIKFjjAWDtHs+GXJvFKj4x8/Ir
   2BKYYdNiQCsyMi0WrDYuBaw87AcQzx47Mkh29Dk4GpIiwqP8oZxRV3ZWm
   eH4eITT+YCSoZGsD3qavbqd79Mlbe8h0Hp8HTY06sEy00fb3VJIjotjm3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523353"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523353"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810373"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810373"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:24 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/11] iwlwifi: updates intended for v6.2 2022-11-02 
Date:   Wed,  2 Nov 2022 16:59:47 +0200
Message-Id: <20221102145958.342864-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the second set of patches intended for v6.2.
It contains some small new features, cleanups and bugfixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Thanks,
Gregory

Avraham Stern (4):
  wifi: iwlwifi: mei: implement PLDR flow
  wifi: iwlwifi: mei: use wait_event_timeout() return value
  wifi: iwlwifi: iwlmei: report disconnection as temporary
  wifi: iwlwifi: mei: wait for the mac to stop on suspend

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix getting the lowest rate

Johannes Berg (2):
  wifi: iwlwifi: mvm: use old checksum for Bz A-step
  wifi: iwlwifi: mvm: support new key API

Luca Coelho (2):
  wifi: iwlwifi: cfg: disable STBC for BL step A devices
  wifi: iwlwifi: mvm: print an error instead of a warning on invalid
    rate

Rotem Saado (2):
  wifi: iwlwifi: dbg: add support for DBGC4 on BZ family and above
  wifi: iwlwifi: dbg: use bit of DRAM alloc ID to store failed allocs

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  36 ++-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  79 ++++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  21 ++
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 130 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  |  51 ++++
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   7 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  60 ++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  20 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 226 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   7 +-
 18 files changed, 641 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c

-- 
2.35.3

