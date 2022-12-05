Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65A46424B3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLEIgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiLEIg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8F167E5
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229388; x=1701765388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uUOgARElcGAJZIDs1n5RZhHXTeF3Sh33JxSaZcAxef0=;
  b=I+sVr4RV9CrYAjk3tIfYSrSvLHbn66Vrydw6rw+SQOQRKWvsK78+0IbL
   vgCCaspp3fQ334z1aQrVPbBYF71E3eQIKpSEv0/cKHrXR1VUpyiEUpDrB
   Xb1DIrssslJmhuXI8pq7amuZoZq47kUs19yiFKRqeqhhUy+KVHHUWvigd
   2Qb6RLoWjE/EgnBcyZUcNnL20Cnub/jbotAmy7gm/5oaFSiGYEW95/tK/
   oVEa++2zDdmqujtLvahaLu7/9Sw0/3zGmpr8peynrkZ2IItAwijP326yX
   4at270MZg9xfU9eBRRNJS2enTq8y4eJdyQKnxm5sFSQVRAVnr4qEmC5xd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323041"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100328"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100328"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:08 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/11] updates intended for v6.2 2022-12-05 
Date:   Mon,  5 Dec 2022 10:35:37 +0200
Message-Id: <20221205083548.236620-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Here's an additional set of patches intended for v6.2 if time permits.
It contains a few adjustments for the new HW and FW API, several small
fixes and cleanups.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Thanks,
Gregory.

Jakob Koschel (1):
  wifi: iwlwifi: mvm: replace usage of found with dedicated list
    iterator variable

Johannes Berg (3):
  wifi: iwlwifi: nvm-parse: enable WiFi7 for Fm radio for now
  wifi: iwlwifi: modify new queue allocation command
  wifi: iwlwifi: fw: use correct IML/ROM status register

Miri Korenblit (1):
  wifi: iwlwifi: mvm: Don't use deprecated register

Mordechay Goodstein (1):
  wifi: iwlwifi: mvm: don't access packet before checking len

Mukesh Sisodiya (3):
  wifi: iwlwifi: dump: Update check for valid FW address
  wifi: iwlwifi: pcie: Add reading and storing of crf and cdb id.
  wifi: iwlwifi: dump: Update check for UMAC valid FW address

Naftali Goldstein (1):
  wifi: iwlwifi: mvm: d3: add TKIP to the GTK iterator

Tom Rix (1):
  wifi: iwlwifi: mei: clean up comments

 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 16 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  7 ++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  6 +--
 drivers/net/wireless/intel/iwlwifi/mei/main.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  | 10 ++---
 .../wireless/intel/iwlwifi/mei/trace-data.h   |  2 +-
 .../net/wireless/intel/iwlwifi/mei/trace.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  9 ++++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 12 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  6 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  9 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 38 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 26 ++++++++-----
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  7 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 33 +++++++++++-----
 17 files changed, 116 insertions(+), 75 deletions(-)

-- 
2.35.3

