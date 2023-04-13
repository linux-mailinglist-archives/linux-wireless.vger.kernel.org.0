Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7529B6E0805
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDMHpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDMHpY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0786BA
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371922; x=1712907922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vLplp7zZrbo9e9pka3AD+Moj+9roOddUH6BPcrsQFI=;
  b=XSvRFr4uMLZu+XwvDSPUC+fZ2kUwQY+67FuqL01LRFW6j6HXT6V2k/xe
   /9GN6xs4W7n/2icfikpSh6A0qzvvXfnsXE3A05Mc3eczPMDOqEwNG3eqe
   LBOWvr4LOgqOOZ7CStEESIAUpEqLX0ljrEButuFmsHHRNMXQfsmB3wUY7
   Qs+2Xk9lmNSjheJ5esEuN8nrlU9bvYi4zv35Sc8HHlcv/bYucx9g7iEU7
   P0CRhpsdoUP22yMOsRTJaYs1sQL2pPLOWf58ZN3NgA5E4EK7loWP+i65p
   yqCdNV+E9A0PGW0A/AijVdrQoMUIeJg/vC93rpDFRUCKPEgJMK88xLyux
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735968"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735968"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034732"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034732"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: use OFDM rate if IEEE80211_TX_CTL_NO_CCK_RATE is set
Date:   Thu, 13 Apr 2023 10:44:06 +0300
Message-Id: <20230413102635.a322d18b5eb1.Icc46027a03f90feffb6fab49a5d82e54829d3dd9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
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

From: Avraham Stern <avraham.stern@intel.com>

IEEE80211_TX_CTL_NO_CCK_RATE indicates that CCK rates should not be
used, but is ignored by the driver. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2c842938656d..9a6e7dd166c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -343,7 +343,8 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	 * For non 2 GHZ band, remap mac80211 rate
 	 * indices into driver indices
 	 */
-	if (info->band != NL80211_BAND_2GHZ)
+	if (info->band != NL80211_BAND_2GHZ ||
+	    (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE))
 		rate_idx += IWL_FIRST_OFDM_RATE;
 
 	/* For 2.4 GHZ band, check that there is no need to remap */
-- 
2.38.1

