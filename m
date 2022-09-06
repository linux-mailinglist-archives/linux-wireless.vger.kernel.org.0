Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377575AEB77
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiIFOAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241139AbiIFN7x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 09:59:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303915A33
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471829; x=1694007829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YrnNrQT39gvjKhlSVwD7IoHXwdbcVRsAPkt2h9NGiSI=;
  b=Yo/d+tLT+MCjQOliAqqTVpy2GrBqQzrD/BA1xeESjENOJr7Lv0UTniOR
   nnPzOpu2s8giV21tad4d4G1WspC8VRjo7XcIkRnWCkOsDFF0UBcfR7UwY
   y5Nx3CCor5+Yq6n89bwI68o32Zvy43MbRjNKpEhV2UHXaOpCVk0ePsNqd
   YEfqS4EW0I19nmKhA8cF6nWrqdVuAJWl4LOG7YVqqXtemFDUDxvUSb4im
   4+cCvzRFuOR6V16Vf5nOx8rD1GIv/94jD4//S6hKK4IgpqBbYBIWxa01L
   EcKM1JV3+I+C+0q4K30f30KXAWZ+2KRg4cKQWTjkW7MZ5CwOkQPgU9FOO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360542656"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360542656"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:42:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459506"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:42:53 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] iwlwifi: updates intended for v6.0 
Date:   Tue,  6 Sep 2022 16:42:04 +0300
Message-Id: <20220906134219.365090-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
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

After some hiatus, we're starting to send iwlwifi patches again.
Here's the first set of patches intended for v6.0. It contains
the usual development, new features and cleanups.

The changes are:
* Refactoring of some wowlan related code
* Fixes and cleanups
* Adding support for BZ device family

As usual, these commits are pushed to a pending branch, for kbuild bot.
I'll send a pull-request later.

Best regards,
Gregory

Haim Dreyfuss (5):
  wifi: iwlwifi: mvm: don't check D0I3 version
  wifi: iwlwifi: mvm: Add support for wowlan info notification
  wifi: iwlwifi: mvm: Add support for wowlan wake packet notification
  wifi: iwlwifi: mvm: Add support for d3 end notification
  wifi: iwlwifi: mvm: enable resume based on notifications

Haim, Dreyfuss (1):
  wifi: iwlwifi: mvm: trigger resume flow before wait for notifications

Ilan Peer (1):
  wifi: iwlwifi: mvm: Add handling for scan offload match info
    notification

Johannes Berg (5):
  wifi: iwlwifi: mvm: fix typo in struct iwl_rx_no_data API
  wifi: iwlwifi: mvm: rxmq: refactor mac80211 rx_status setting
  wifi: iwlwifi: mvm: rxmq: further unify some VHT/HE code
  wifi: iwlwifi: mvm: refactor iwl_mvm_set_sta_rate() a bit
  wifi: iwlwifi: cfg: remove IWL_DEVICE_BZ_COMMON macro

Naftali Goldstein (1):
  wifi: iwlwifi: mvm: d3: parse keys from wowlan info notification

Yaara Baruch (1):
  wifi: iwlwifi: pcie: add support for BZ devices

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: iterate over interfaces after an assert in d3

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  42 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  61 +-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  17 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  20 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 668 +++++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 376 +++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  19 +-
 13 files changed, 846 insertions(+), 413 deletions(-)

-- 
2.35.3

