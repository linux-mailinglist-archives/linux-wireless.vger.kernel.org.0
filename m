Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629C77DBCB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjHPILd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbjHPILJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010F13E
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173468; x=1723709468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C2YVoWjXqd5QXIIDahNyEGJzw7CVFMfke0NpOkZJF+Q=;
  b=E8OBe33zUqZBT4H4Z3fYizP0GIfZx/TF4Cbcrm1XlBbTMDoPTH4yl1YI
   bbZ44wvNdAk8i21vomIKvKJ7M9FbVt23WUMhTRggmk+grkChnOTYSDRJN
   /Yj4txJF3SJC8vm0C8eJfwyHSM25rh5FgAXQAi8etAkGGfuKMTvtVic5t
   W1/JUjuseSnc6MhNAe+CEm0aGD07TVzvr14v6hmUCE7kUCWQcS8EXNIlH
   BEyVp/0qcJgLgqnfelUX+4esm3AMeBnOV/rYI7Uvn+zLdGK7EwpqBglHn
   qAph2qms48Z5j5AjIX7mprVvICn6ZTV0R6pFmYRwQ4v8MC246/3ljrpDI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447772"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098713"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098713"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/12] wifi: iwlwifi: updates intended for v6.6 2023-08-16 
Date:   Wed, 16 Aug 2023 11:10:42 +0300
Message-Id: <20230816081054.245480-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.6.

It contains a few small cleanups and bugfixes along with patches
which clean up pcie and tx datapath.

Thanks,
Gregory

Gregory Greenman (1):
  wifi: iwlwifi: add Razer to ppag approved list

Johannes Berg (10):
  wifi: iwlwifi: mvm: advertise MLO only if EHT is enabled
  wifi: iwlwifi: api: fix a small upper/lower-case typo
  wifi: iwlwifi: remove WARN from read_mem32()
  wifi: iwlwifi: pcie: clean up gen1/gen2 TFD unmap
  wifi: iwlwifi: remove 'def_rx_queue' struct member
  wifi: iwlwifi: pcie: move gen1 TB handling to header
  wifi: iwlwifi: queue: move iwl_txq_gen2_set_tb() up
  wifi: iwlwifi: pcie: point invalid TFDs to invalid data
  wifi: iwlwifi: mvm: enable HE TX/RX <242 tone RU on new RFs
  wifi: iwlwifi: mvm: support flush on AP interfaces

Mukesh Sisodiya (1):
  wifi: iwlwifi: remove memory check for LMAC error address

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   2 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   2 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  11 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  31 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  24 +--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 142 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  26 ++--
 13 files changed, 156 insertions(+), 112 deletions(-)

-- 
2.38.1

