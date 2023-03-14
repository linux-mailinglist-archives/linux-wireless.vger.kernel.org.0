Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7A6B9D67
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCNRtz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCNRtx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:49:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FBA8C70
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816188; x=1710352188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FVWLQJENLT0Ge+0+dAt5V6Cytib08+G5VdzfI5A6++4=;
  b=fFij0R+kNLA6wAOX8f8YOZAw1hsvB4VjPj+LTH8buQb3JLM8v/Lwhvha
   1QOR4WWS5F1dAsCjvTP9tRWw82EyaH6ZZ2kqbdk9aDztqOf9cvKn/QTA7
   NlC/3/AVm5hua6Q3hDlkDkUxZZua8CjePDImzEZwpbe0RjVGpTr+PSPm8
   t3zXrIL9+r1CexvEQ4pDQSD/NgzsidXOzW4ougSTbIM4c6ka9z/aJ5Ehy
   2KeSUi+R24vqW5u6MHyr7Fx6k5mHsVnojB75W41f9WY8h0gyJu20eNOz7
   NhRk8AANMqb6CTAsZUW7otFPtlTz0iQA0JH1mR1nZm32XENfWmyAZKGih
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149451"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149451"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200421"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200421"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/22] wifi: iwlwifi: updates intended for v6.4 2023-03-14 
Date:   Tue, 14 Mar 2023 19:49:12 +0200
Message-Id: <20230314174934.893149-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's a new set of iwlwifi patches.
The changes are:
* MLO preparations
* A few debug (yoyo) improvements
* Cleanups and bug fixes

Thanks,
Gregory

Johannes Berg (3):
  wifi: iwlwifi: mvm: avoid sta lookup in queue alloc
  wifi: iwlwifi: mvm: rs: print BAD_RATE for invalid HT/VHT index
  wifi: iwlwifi: fw: pnvm: fix uefi reduced TX power loading

Julia Lawall (1):
  wifi: iwlwifi: fix typos in comment

Miri Korenblit (11):
  wifi: iwlwifi: mvm: Refactor STA_HE_CTXT_CMD sending flow
  wifi: iwlwifi: mvm: Refactor MAC_CONTEXT_CMD sending flow
  wifi: iwlwifi: mvm: add support for the new MAC CTXT command
  wifi: iwlwifi: mvm: add support for the new LINK command
  wifi: iwlwifi: mvm: add support for the new STA related commands
  wifi: iwlwifi: mvm: Add an add_interface() callback for mld mode
  wifi: iwlwifi: mvm: Add a remove_interface() callback for mld mode
  wifi: iwlwifi: mvm: refactor __iwl_mvm_assign_vif_chanctx()
  wifi: iwlwifi: mvm: add an assign_vif_chanctx() callback for MLD mode
  wifi: iwlwifi: mvm: refactor __iwl_mvm_unassign_vif_chanctx()
  wifi: iwlwifi: mvm: add an unassign_vif_chanctx() callback for MLD mode

Mukesh Sisodiya (3):
  wifi: iwlwifi: yoyo: Add new tlv for dump file name extension
  wifi: iwlwifi: yoyo: Add driver defined dump file name
  wifi: iwlwifi: Update configurations for Bnj and Bz devices

Solomon Tan (3):
  wifi: iwlwifi: Remove prohibited spaces
  wifi: iwlwifi: Add required space before open '('
  wifi: iwlwifi: Replace space with tabs as code indent

Tom Rix (1):
  wifi: iwlwifi: mvm: remove setting of 'sta' parameter

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  38 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 416 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  32 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  58 ++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  17 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  20 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   4 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   3 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 175 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 359 +++++++++------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 304 ++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 271 ++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 253 +++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 339 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  59 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  60 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  25 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  15 +
 26 files changed, 2185 insertions(+), 301 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c

-- 
2.38.1

