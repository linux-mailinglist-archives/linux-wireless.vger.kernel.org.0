Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F396E07FF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDMHpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDMHpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019683E5
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371907; x=1712907907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wrmz82dx/DsOCf6rn5CFoGOUKR+v/6IqU+u1+4VOvg0=;
  b=VpG2N5ALb1mVuCiQYMbCUicM04xLGGZmo8Sy+8L2oJFo7hSKNXINDSMg
   WlDgKgKNxvUKdwwJOBu4BhN6GSJKusy2kFZakaUTVXgk8iXQwotwuxfrV
   LuIHGpy+BbXQyVjBqiQgmMVMbfkpliUVVLJAh9F1ftBvF/4iREJXj8bWB
   vkZne5KXNNXcDZjfwC/yU7c5NvqTU7g19S62y4gygnAZENqMYnmr9kypm
   nxlEzaSKjuHoTEav3IWMqztyk+Oq51k8NkZMeh0oaweeFKQhAn1BhtYS/
   U4bwHqQuJ9eIVyCX5ZCXss7u09IIXkzJVAgztsNVH0G3Qc5ZT6nYBhq8v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735906"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034648"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034648"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates intended for v6.4 2023-04-13
Date:   Thu, 13 Apr 2023 10:44:00 +0300
Message-Id: <20230413074415.1054160-1-gregory.greenman@intel.com>
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

Here's the next set of iwlwifi patches for v6.4.
It's the ususal developement, mostly cleanups and bugfixes.

Thanks,
Gregory


Avraham Stern (3):
  wifi: iwlwifi: mvm: use OFDM rate if IEEE80211_TX_CTL_NO_CCK_RATE is set
  wifi: iwlwifi: trans: don't trigger d3 interrupt twice
  wifi: iwlwifi: mvm: don't set CHECKSUM_COMPLETE for unsupported protocols

Daniel Gabay (1):
  wifi: iwlwifi: nvm: Update HE capabilities on 6GHz band for EHT device

Golan Ben Ami (1):
  wifi: iwlwifi: mvm: enable bz hw checksum from c step

Johannes Berg (5):
  wifi: iwlwifi: debug: fix crash in __iwl_err()
  wifi: iwlwifi: nvm-parse: enable 160/320 MHz for AP mode
  wifi: iwlwifi: mvm: convert TID to FW value on queue remove
  wifi: iwlwifi: mvm: fix A-MSDU checks
  wifi: iwlwifi: mvm: refactor TX csum mode check

Miri Korenblit (1):
  wifi: iwlwifi: add a validity check of queue_id in iwl_txq_reclaim

Mukesh Sisodiya (4):
  wifi: iwlwifi: Update configuration for SO,SOF MAC and HR RF
  wifi: iwlwifi: mvm: move function sequence
  wifi: iwlwifi: Update init sequence if tx diversity supported
  wifi: iwlwifi: Update configurations for Bnj-a0 and specific rf devices

 .../net/wireless/intel/iwlwifi/iwl-debug.c    |   3 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |   5 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 224 +++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  13 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  11 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  10 +-
 13 files changed, 176 insertions(+), 144 deletions(-)

-- 
2.38.1

