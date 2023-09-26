Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A67AE767
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjIZIHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjIZIHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B482C10A
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715653; x=1727251653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xJFpSrMR2PfBNDT0v2TyQYC6jpMJwP7jbNB7opoco7k=;
  b=FZPDMnS+FgfFIaW1qr/pxk/8yZvBhP2T+7LZ0O8CrUs4KgqvU6xiNtaS
   C54nFe5u+ZRC89Iq2/RgXE4XFM6JnaaysTS8o62V2A1Go/DyuAnT82do6
   nNv+e5lvlDNvTrGzp9kYAQf6Egw45dIWyGqWesUZf/wufLiOF9LEeA0q0
   ddeyI1BnuCDNDSBbvDYF/ErsNPP0qDfvI2kvxKQFis49gg+DFJxH1w9b4
   Co/CVUpAWwgcIKguzZYrhJwTvgskYK/juBEwLCa9dM3Nkz89RsZ4NOPDE
   qwY5Oq7ESjAfJwIKRZVdaiZe0txObLRk2XpzF0qsRYH/p26suiD33nZcA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797220"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369252"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369252"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/9] wifi: iwlwifi: updates - 2023-09-26 
Date:   Tue, 26 Sep 2023 11:07:12 +0300
Message-Id: <20230926080721.876640-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7.
It contains bugfixes and advances firmware version to 84.

Thanks,
Gregory

Avraham Stern (2):
  wifi: iwlwifi: mvm: update station's MFP flag after association
  wifi: iwlwifi: mvm: fix removing pasn station for responder

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 84 for AX/BZ/SC devices

Johannes Berg (6):
  wifi: iwlwifi: pcie: propagate iwl_pcie_gen2_apm_init() error
  wifi: iwlwifi: skip opmode start retries on dead transport
  wifi: iwlwifi: fix opmode start/stop race
  wifi: iwlwifi: pcie: clean up WFPM control bits
  wifi: iwlwifi: mvm: offload IGTK in AP if BIGTK is supported
  wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK

 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 19 ++++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 -
 .../intel/iwlwifi/mvm/ftm-responder.c         |  9 ++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  9 ++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  4 ++--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  5 ++++-
 10 files changed, 53 insertions(+), 21 deletions(-)

-- 
2.38.1

