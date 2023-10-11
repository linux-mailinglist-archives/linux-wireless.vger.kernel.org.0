Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B187C4FAD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjJKKJJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjJKKIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED71BD7
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018870; x=1728554870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q3sGEuWUn7vJSsxn+b31vY9pKZWOXd/6TX6gRt/TXsg=;
  b=TqTbawd17+yk0Z4zvD/KRXw124N/Zfcx88syfRb8HGNoMIUyfvB4KdN2
   +sN00HHEEGck9UI2tisa3qLvtIFxdETzY4voAY+EQWVyQTQFoTdONC9nH
   bmlL0Amk6Uf7spaChp1UbLEsC95Wy9ux7B/M6hpfUOK8sYSMyNS6MgiPx
   NQ6nQ/BDHM+eN65jsS9ojpWs+bCnI9PVMGfuXtfxd7tYI7ICQ79yhcl8a
   D2pqHSV3icQndGSPmucDM2vkooY/5ogZUfOphSoan+3Pzqam32q4fvwrp
   OITUdJUIdpA4Hp2ODdF1PLMIKSyohSW+JtrX7tUl6dLmNT4JAczAx9uHs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670570"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670570"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050253"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050253"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/16] wifi: iwlwifi: mvm: Fix unreachable code path
Date:   Wed, 11 Oct 2023 13:07:18 +0300
Message-Id: <20231011130030.39d76eeea781.I2dc1fc6152a2cd4cf68827f4d3bf83e2293d3dfb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Fix unreachable code path that was introduced in the P2P Device
linking refactoring.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 56945047e4f6..f33c8a00d326 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1637,11 +1637,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	goto out_unlock;
 
-	if (mvm->bf_allowed_vif == mvmvif) {
-		mvm->bf_allowed_vif = NULL;
-		vif->driver_flags &= ~(IEEE80211_VIF_BEACON_FILTER |
-				       IEEE80211_VIF_SUPPORTS_CQM_RSSI);
-	}
  out_remove_mac:
 	mvmvif->deflink.phy_ctxt = NULL;
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
-- 
2.38.1

