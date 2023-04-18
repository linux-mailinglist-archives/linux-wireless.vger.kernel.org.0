Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB66E5D54
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjDRJ21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjDRJ21 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D8F170E
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810105; x=1713346105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6dkwW5yzi98MzgcCeFBhQYW8cwj0varEEGdVfLsj7FY=;
  b=lgkp+rn58TeKbnDNSU6vgvWwdQdYaCMNxCBimoMzhDDPJMipF/uWs6kq
   cMQMokX51gSnZ1vUh0yzhtVA59b7VPAFCTBC7/4kDPdbNZTB79Q36XkUd
   +csfskQxZx9/pE6zlfaR72AY1OGqEI07f26avxBsTQIHLpKt8pB3JDj8E
   gti6TcU2M+d4vpJwr05QO800Tb36IUvbY9RoK6aw05A876lKIMM9ezArN
   9IBbhVf4OjIEVtvi3ZEq2//J7HTYWAb7VjyRwUHC2kWY0O5Jzo2CBsm8L
   aDMBm5SbesFpwpeQAf8/ThKg+zYwye9Gphg4pzxoWCjFCVydvlCLatUxD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341137"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341137"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511190"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511190"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/11]  wifi: iwlwifi: updates intended for v6.4 2023-04-18
Date:   Tue, 18 Apr 2023 12:28:03 +0300
Message-Id: <20230418092814.1438734-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the last set of patches for v6.4.
Same as few patch sets before, this set contains the
ususal developement, small improvements, cleanups and
bugfixes.

Thanks,
Gregory

Alon Giladi (1):
  wifi: iwlwifi: fw: fix argument to efi.get_variable

Avraham Stern (4):
  wifi: iwlwifi: modify scan request and results when in link protection
  wifi: iwlwifi: mei: make mei filtered scan more aggressive
  wifi: iwlwifi: mei: re-ask for ownership after it was taken by CSME
  wifi: iwlwifi: mvm: fix RFKILL report when driver is going down

Gregory Greenman (1):
  wifi: iwlwifi: mvm: enable support for MLO APIs

Johannes Berg (4):
  wifi: iwlwifi: fw: fix memory leak in debugfs
  wifi: iwlwifi: mvm: fix MIC removal confusion
  wifi: iwlwifi: mvm: fix potential memory leak
  wifi: iwlwifi: mvm: prefer RCU_INIT_POINTER()

Mukesh Sisodiya (1):
  wifi: iwlwifi: Update support for b0 version

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 55 ++++++++++++
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 ++
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 40 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 14 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 25 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 32 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 90 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 35 ++++++--
 14 files changed, 273 insertions(+), 52 deletions(-)

-- 
2.38.1

