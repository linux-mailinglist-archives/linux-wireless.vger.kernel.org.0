Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08376FA220
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjEHIY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEHIYo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:24:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815701707
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534283; x=1715070283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XHkaj0jvmzl1f7PNpnG3do7Qju1IXmKs6HxdqjLSwjg=;
  b=LohjVDhkLyLyrN9WNd46/5UOLT2Xm/vqdQpS2i4pL/8yIjr29XBLKZNo
   +qnlh55KufczBm4J23EqoECK9rXo7CQzsVhIODZ/DWfW2OravtZNb1VAK
   yUSYpF1GR6Sg+O4j7BRZICByz9zPuaQhWpJ98pa9hqEO4JMtQGCkQMnbp
   RYwNnmKEKDzIdsYoXa+sTDDAEWxVNI5GhhvU1D3Y+ArQp8HvpxJy9NIu/
   Z+mhg0EEW1r4Ek8V217j9ovssjDOnpRYv80Fjd3KMUD49/PSmhkqs72zl
   qlqqWC8/nVJFo9RQh9yRCkp209zXuQLTALUzdjN+oNWl0Nbh0Z+7lxsGT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949841"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949841"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982542"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982542"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/14] wifi: iwlwifi: updates intended for v6.4 2023-05-08 
Date:   Mon,  8 May 2023 11:24:19 +0300
Message-Id: <20230508082433.1349733-1-gregory.greenman@intel.com>
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

Hi,

Here's the first set of patches for v6.5
It contains the continuation of MLO work (mostly small fixes
and adjustments) as well as a few other small changes.

Thanks,
Gregory

Avraham Stern (1):
  wifi: iwlwifi: mvm: support PASN for MLO

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: update the FW apis for LINK and MAC commands
  wifi: iwlwifi: pass the esr_transition_timeout to the firmware

Golan Ben Ami (1):
  wifi: iwlwifi: cfg: freeze 22500 devices FW API

Gregory Greenman (1):
  wifi: iwlwifi: mvm: adjust csa notifications and commands to MLO

Haim Dreyfuss (1):
  wifi: iwlwifi: don't silently ignore missing suspend or resume ops

Johannes Berg (6):
  wifi: iwlwifi: mvm: make internal callback structs const
  wifi: iwlwifi: mvm: always free dup_data
  wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_add_interface_common()
  wifi: iwlwifi: mvm: don't double-init spinlock
  wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock
  wifi: iwlwifi: mvm: fix number of concurrent link checks

Miri Korenblit (1):
  wifi: iwlwifi: mvm: Make iwl_mvm_diversity_iter() MLO aware

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: use link ID in missed beacon notification

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  20 +--
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  57 ++++++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  22 +++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  18 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  94 +++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 123 ++++++++----------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  27 ++--
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  13 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  15 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  22 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  31 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  46 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   9 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  20 +--
 17 files changed, 342 insertions(+), 184 deletions(-)

-- 
2.38.1

