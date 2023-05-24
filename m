Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE370FCE5
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjEXRoj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEXRoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:44:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B24E5A
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950235; x=1716486235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HYIJ4gAnvwwmXURZUmMDJb26GS7GD3LERFZ+qOnBns0=;
  b=QcRTUj+J0zNS0xcHw5+sA2cepaajPz3xjVXwWUUfxfLyyx2DDTpNVA39
   VM+GOZvXmQCFcwbm3ELIn3P9PntBdkmqOf3VjX342Yty5sPufeUlWEw+g
   cjNvDvqJUC5HY4/ZEoUou1eqPgpg9zw/IVsSQxz/ONzo+yBnnt1HHqhz4
   b0Xp9JDmdXwG+V4ErKccqOVbYcWFC5rQwyt5WtrvTpibdWFDpLO8XxOoe
   OQacBIt2ByM2uq2ME92FeV22AxrPpc76nTgY7S60ll7BQIzrGkbZP5EFG
   YTgFqEJ5Vevnif1wDqY9+rQeuyLRr+7NhNJQA016ycVkGJHCbtJvu4DXC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000292"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769547855"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769547855"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:30 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/14] wifi: iwlwifi: updates intended for v6.5 2023-05-24 
Date:   Wed, 24 May 2023 20:41:57 +0300
Message-Id: <20230524174211.1482360-1-gregory.greenman@intel.com>
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

This patch set includes iwlwifi patches intended for v6.5.
It primarily focus on the following areas:
* continuation of MLO work
* bugfixes
* cleanups

Thanks,
Gregory

Abhishek Naik (1):
  wifi: iwlwifi: update response for mcc_update command

Alon Giladi (1):
  wifi: iwlwifi: support PPAG in China for older FW cmd version

Ariel Malamud (1):
  wifi: iwlwifi: fw: Add new ODM vendor to ppag approved list

Avraham Stern (1):
  wifi: iwlwifi: mvm: support PASN for MLO

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: update the FW apis for LINK and MAC commands

Golan Ben Ami (1):
  wifi: iwlwifi: cfg: freeze 22500 devices FW API

Gregory Greenman (2):
  wifi: iwlwifi: mvm: adjust csa notifications and commands to MLO
  wifi: iwlwifi: disable RX STBC when a device doesn't support it

Haim Dreyfuss (1):
  wifi: iwlwifi: don't silently ignore missing suspend or resume ops

Johannes Berg (3):
  wifi: iwlwifi: mvm: make internal callback structs const
  wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_add_interface_common()
  wifi: iwlwifi: mvm: remove useless code

Miri Korenblit (1):
  wifi: iwlwifi: mvm: Make iwl_mvm_diversity_iter() MLO aware

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: use link ID in missed beacon notification

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  20 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  16 ++-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  59 ++++++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  22 ++-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  35 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 127 ++++++++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   6 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  94 +++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 122 ++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  27 ++--
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  10 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  33 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  58 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  50 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  20 +--
 22 files changed, 506 insertions(+), 232 deletions(-)

-- 
2.38.1

