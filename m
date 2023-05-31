Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F377187C7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjEaQvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEaQvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252C6BE
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551869; x=1717087869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I1JBOYn6BL7jPjdZ+ovy+Sq9Heh1A8hoO+UuOGfTsAg=;
  b=Xxv5soWs+TfB8kQ0pabDS816Uujftdboc3xMUA8PvNULwuPS5igpisB2
   kV4zdyuiwdyx0C54sOCX98vXAK65KLewTmacCUq/oHt0sYnX2z/zFFXlY
   WPQaq4T2xEYnlrkbgXJpmRsfamQa/wuSKi5W7XS2ehdoRP3AvPMEuY0ax
   LBUOrcnLyqW+aMumbIwz3rO/hZGKarSKxpkQnTgkEnZZf16HR3nX7VnAH
   tadwxh9NpdAIfOEB8V76J4dXGWEcZ/rVuj78+DNa+myJ9kLesG8gA28ar
   YkfjiWD2Xc0GO1wlbTVw3CjESXm53ZgE1blELKyaYBqV3sx6DrgOjUViW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890358"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890358"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987943"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987943"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/14] wifi: iwlwifi: updates intended for v6.5 2023-05-31 
Date:   Wed, 31 May 2023 19:49:52 +0300
Message-Id: <20230531165006.273284-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
* bugfixes and cleanups
* ACPI vendors list fixes
* BSS Transition Management offload
* MLO support for FTM

Thanks,
Gregory

Alon Giladi (2):
  wifi: iwlwifi: Add vendors to TAS approved list
  wifi: iwlwifi: Add Dell to ppag approved list

Avraham Stern (1):
  wifi: iwlwifi: mvm: FTM initiator MLO support

Benjamin Berg (1):
  wifi: iwlwifi: do not log undefined DRAM buffers unnecessarily

Golan Ben Ami (1):
  wifi: iwlwifi: acpi: add other Google OEMs to the ppag approved list

Haim Dreyfuss (1):
  wifi: iwlwifi: mvm: offload BTM response during D3

Johannes Berg (7):
  wifi: iwlwifi: fix Bz checksum start/result offset
  wifi: iwlwifi: mvm: support injection rate control
  wifi: iwlwifi: mvm: clarify EHT RU allocation bits
  wifi: iwlwifi: pcie: adjust Bz device timings
  wifi: iwlwifi: mvm: tell firmware about per-STA MFP enablement
  wifi: iwlwifi: mvm: remove warning for beacon filtering error
  wifi: iwlwifi: mvm: send time sync only if needed

Mukesh Sisodiya (1):
  wifi: iwlwifi: remove dead code in iwl_dump_ini_imr_get_size()

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 22 +++++++
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  2 +
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 12 ++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  7 ++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 45 ++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 33 ++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  5 ++
 .../wireless/intel/iwlwifi/mvm/offloading.c   |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 62 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 10 +--
 15 files changed, 179 insertions(+), 43 deletions(-)

-- 
2.38.1

