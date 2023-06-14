Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F172F9AE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbjFNJpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbjFNJo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62B294F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735762; x=1718271762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F8i6ngU3V0afFCAoBN36JVI876C1xlJ5U3ElbMoPXKk=;
  b=HaENZw1mc0X1d5PJ+OdMAR8FDxzt5WdJU9mZTQGbX5FKKEcyjVXzgZMu
   4yKuA0NVQgfk+T7E4/NfNtyw4IoQUg0/DbAP0LMxQnCe1JSd4nJUDFjKw
   6U8jKeKPjYKeOOgzyKDarZERY/SlkX91En7q0gsAaEGpS+0EFAC1gnQmq
   71V64MY7AYKEgqQDOzXHY6Z03J/SSqpmSjka7gpne15+eeODIXGnx7AsV
   2YFYrIay5O8d4dHTvMgAZdZvgviPjsgWm2ceE4vr3WABI/0Ge/NM8LcPg
   kRl3PpTmbBmD4yV+nrsrDeHGEXYfjQyTsj3ghXn3b2NFWIXUsrJH9CjKo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049788"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989766"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989766"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/20] wifi: iwlwifi: updates intended for v6.5 2023-06-14 
Date:   Wed, 14 Jun 2023 12:41:17 +0300
Message-Id: <20230614094137.379897-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.

It contains normal developement, cleanups and bugfixes.
It depends on the previous patch sets I've sent.  

Thanks,
Gregory

Anjaneyulu (4):
  wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
  wifi: iwlwifi: mvm: Validate tid is in valid range before using it
  wifi: iwlwifi: Validate slots_num before allocating memory
  wifi: iwlwifi: add a few rate index validity checks

Ariel Malamud (1):
  wifi: iwlwifi: fw: Add new FSEQ defines to fw dump

Ilan Peer (1):
  wifi: iwlwifi: Correctly indicate support for VHT TX STBC

Johannes Berg (14):
  wifi: iwlwifi: mvm: correctly access HE/EHT sband capa
  wifi: iwlwifi: fw: make some ACPI functions static
  wifi: iwlwifi: mvm: use iwl_mvm_is_vendor_in_approved_list()
  wifi: iwlwifi: pull from TXQs with softirqs disabled
  wifi: iwlwifi: pcie: double-check ACK interrupt after timeout
  wifi: iwlwifi: mvm: add a few NULL pointer checks
  wifi: iwlwifi: mvm: check link during TX
  wifi: iwlwifi: mvm: disable new TX csum mode completely
  wifi: iwlwifi: mvm: store WMM params per link
  wifi: iwlwifi: use array as array argument
  wifi: iwlwifi: mvm: always send spec link ID in link commands
  wifi: iwlwifi: add some FW misbehaviour check infrastructure
  wifi: iwlwifi: implement WPFC ACPI table loading
  wifi: iwlwifi: mvm: track u-APSD misbehaving AP by AP address

 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  9 ++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 64 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 41 ++++--------
 .../wireless/intel/iwlwifi/fw/api/config.h    | 15 ++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 16 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  6 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  6 +-
 .../wireless/intel/iwlwifi/mvm/constants.h    |  6 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 45 +++----------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 21 ++++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  8 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 16 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  9 ++-
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 35 ++++++----
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 46 +++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 11 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 19 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 19 ++++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  5 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 13 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  5 +-
 26 files changed, 265 insertions(+), 182 deletions(-)

-- 
2.38.1

