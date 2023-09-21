Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC07A9BF1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjIUTFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIUTEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8815F59964
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318623; x=1726854623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=maioTPbq2nf50tdn/l8GHF6ulm3B3w4g5gF4t4q8OcU=;
  b=Ul0nLnTC8wU7sFZqBqaG7z1oVDFpFLx5pkM2KmkR/r7qd7IeY0dch9dH
   n46ZE3zPoq7AzJMmz0dzhWNpVjKP1m6TadD86urTA6ryhr34Z9H65g058
   SG/VGh1VlIbAtQdDc+T1F2SWCsMS9bs6oG8sHGtqbJOFJZ8wAItA16SnS
   DWV5VPAsaiyPlyx9YES/GY0s35DCC8Fqoq0PHp8mHqy2Ky/IFeyOPPgS8
   BGuz9SygH6anFIXqhPiyHmNgaA3Th6A+8zvp0rxXcKzg3xs04gPZaFWPd
   OwUgpFPcSq8chNx4szd+VsHsCBUSuMxvCDqMaCoArztKa/K8Ed+iCPmcn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305186"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305186"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545331"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545331"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/12] wifi: iwlwifi: updates - 2023-09-21 
Date:   Thu, 21 Sep 2023 11:57:58 +0300
Message-Id: <20230921085810.693048-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7.

The main changes are:
* driver implementation of set_antenna() API
* a few MLO fixes
* small regulatory feature (China 2022 regulatory)
* error recovery improvements
* support new CRF (Companion RF) type
* fixes and cleanups

Thanks,
Gregory

Anjaneyulu (1):
  wifi: iwlwifi: implement enable/disable for China 2022 regulatory

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: support set_antenna()

Johannes Berg (8):
  wifi: iwlwifi: mvm: iterate active links for STA queues
  wifi: iwlwifi: mvm: handle link-STA allocation in restart
  wifi: iwlwifi: pcie: (re-)assign BAR0 on driver bind
  wifi: iwlwifi: fail NIC access fast on dead NIC
  wifi: iwlwifi: mvm: make pldr_sync AX210 specific
  wifi: iwlwifi: mvm: refactor TX rate handling
  wifi: iwlwifi: mvm: support injection antenna control
  wifi: iwlwifi: mvm: check for iwl_mvm_mld_update_sta() errors

Mukesh Sisodiya (1):
  wifi: iwlwifi: add mapping of a periphery register crf for WH RF

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: add support for new wowlan_info_notif

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  18 ++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  46 ++++-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   6 +-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   6 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   5 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  76 ++++++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 165 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  15 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  25 +++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  23 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  29 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  90 ++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  12 ++
 23 files changed, 468 insertions(+), 112 deletions(-)

-- 
2.38.1

