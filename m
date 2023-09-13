Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993E79E74F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjIML5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIML5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D321996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606224; x=1726142224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TGmBPL+GaM78eowuKPOClQpc/piH2zT1TIV6+Rewbbc=;
  b=bSBEVGfwPTsrWQq3pOAGC53+DQ71lM/QxKGd4hRvR7FFTPXxAod4om60
   +jWjLjclc6t6+Jk44Fit956FCJW4vNB2pm3puwuWtGMK55D4oyhvndPos
   YzWqeV2pCfn/ZVyWTjLvBzZ2EFoJ2tmics4s+azWbuY5lW6SFm7sMCVfS
   jMvBDDMH2lR5Gww6okCZbMC+5tpDl7iRUv1cb223uVb7pLkNsubJ0KtNB
   jj2hN6PSUGwZFl00mEmRH6UwJLdpnuemHZIu8yi/0yewZQfumYXsX1Krb
   +pTti2jTYK2GC0XDnYQZbYkKpjduH7lcPGN+pHfNWGdlTzAreerqh8c5v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368902955"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368902955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470911"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470911"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2023-09-13 
Date:   Wed, 13 Sep 2023 14:56:36 +0300
Message-Id: <20230913115651.190558-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7.

* a few small features (like adding support to set_antenna() and
  disabling power save during dransition to d3)
* error handling and recovery enhancements
* cleanups

Thanks,
Gregory

Emmanuel Grumbach (4):
  wifi: iwlwifi: mvm: log dropped frames
  wifi: iwlwifi: mvm: fix recovery flow in CSA
  wifi: iwlwifi: mvm: support set_antenna()
  wifi: iwlwifi: mvm: add a debug print when we get a BAR

Gregory Greenman (1):
  wifi: iwlwifi: fw: disable firmware debug asserts

Johannes Berg (6):
  wifi: iwlwifi: pcie: rescan bus if no parent
  wifi: iwlwifi: pcie: give up mem read if HW is dead
  wifi: iwlwifi: pcie: enable TOP fatal error interrupt
  wifi: iwlwifi: mvm: make "pldr_sync" mode effective
  wifi: iwlwifi: update context info structure definitions
  wifi: iwlwifi: mvm: move listen interval to constants

Miri Korenblit (3):
  wifi: iwlwifi: remove dead-code
  wifi: iwlwifi: Use FW rate for non-data frames
  wifi: iwlwifi: no power save during transition to D3

Shaul Triebitz (1):
  wifi: iwlwifi: mvm: enable FILS DF Tx on non-PSC channel

 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 22 ++++++
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 25 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |  1 -
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  2 +
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  5 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 76 ++++++++++++++++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    | 19 +++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +
 .../wireless/intel/iwlwifi/mvm/constants.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 24 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 16 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 56 +++++++++-----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 32 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  | 12 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  8 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  9 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 14 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  6 ++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 21 ++++-
 25 files changed, 307 insertions(+), 65 deletions(-)

-- 
2.38.1

