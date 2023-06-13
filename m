Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B56D72E377
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbjFMM5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjFMM5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A91919A7
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661059; x=1718197059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=05/2/gPtsXiXIUL8HkQxGzGw7yyeSpRXquZc5EtO/DY=;
  b=M76iBPpNKlpd1PcVE9Tp8kvLbTWNo1CqvxP7xAy+fzbUvMNl6V2NB0EQ
   h8ehL1bc9VK6Rr7P8T+JuIFav4jV8SRrtFC5bb9JBZ5mEAesu3dGSdYEC
   Df870uWBwuUWdkJlOuY2hdLQukJJlh0EdNgGeN+hniDUVMKp6FdDR+cdV
   KVz/VFsNB68Ulmqu/fiXtZa3a58IiM8eJCx5hu0hB8PTZkoBDdm7xeI3b
   mwUc09ykwZ21RxHggd2Uga8f/usElZfP9pA5sGC219vMIWSo04prt0XeJ
   sV3/n1G9eptVoPcq4ACJXtDB2CTTPtaSjXX+7BSJsgSZt6NPwMTrWYPlF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973693"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973693"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880745"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880745"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/14] wifi: iwlwifi: updates intended for v6.5 2023-06-13 
Date:   Tue, 13 Jun 2023 15:57:13 +0300
Message-Id: <20230613125727.300445-1-gregory.greenman@intel.com>
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

Alon Giladi (1):
  wifi: iwlwifi: improve debug prints in iwl_read_ppag_table()

Ariel Malamud (1):
  wifi: iwlwifi: mvm: Refactor iwl_mvm_get_lmac_id()

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: allow ADD_STA not to be advertised by the firwmare

Gregory Greenman (2):
  wifi: iwlwifi: mvm: add support for Extra EHT LTF
  wifi: iwlwifi: mvm: fix potential array out of bounds access

Haim Dreyfuss (1):
  wifi: iwlwifi: mvm: rename BTM support flag and its TLV

Johannes Berg (6):
  wifi: iwlwifi: mvm: support U-SIG EHT validate checks
  wifi: iwlwifi: mvm: put only a single IGTK into FW
  wifi: iwlwifi: dbg-tlv: fix DRAM data init
  wifi: iwlwifi: pcie: clear FW debug memory on init
  wifi: iwlwifi: pcie: remove redundant argument
  wifi: iwlwifi: dbg-tlv: clear FW debug memory on init

Mukesh Sisodiya (2):
  wifi: iwlwifi: mvm: initialize the rx_vec before using it.
  wifi: iwlwifi: support version C0 of BZ and GL devices

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 27 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 37 ++++++----
 .../wireless/intel/iwlwifi/fw/api/binding.h   |  8 ---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  2 +
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 49 +++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 +
 .../net/wireless/intel/iwlwifi/mvm/binding.c  | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  7 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 72 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 12 +++-
 .../wireless/intel/iwlwifi/mvm/offloading.c   |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 15 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 14 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 14 +++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
 include/linux/ieee80211.h                     |  1 +
 include/net/ieee80211_radiotap.h              |  2 +
 27 files changed, 249 insertions(+), 82 deletions(-)

-- 
2.38.1

