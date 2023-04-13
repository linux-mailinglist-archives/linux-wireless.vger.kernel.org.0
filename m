Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187566E0811
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDMHqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDMHqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:46:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC596199
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371976; x=1712907976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WB5FDYTcF4Otb3L3HZTEx2iwxNL53FvELfrlVnfRIlw=;
  b=cF63QVYbq0Dcfm21jexoBUKbbOPuGLS/Dn+i0FRW1/N6KUWKQbNm1O4N
   y4vneIU+TkAQCahHPxeuu+tK6L27ZNXd0jcywff8aCahuEw3LdivC9grD
   y3bClBbDj3FMVxno7ipMM+QfDxvkKSmD31qSSJ/dZwwHED3bsAAxhrHH6
   dFeV7GFpx9E+bm+E2xf9x+BTDU96miFQdyrs8hJM52fR/w6jOVN/H3WHc
   IMf5oO3AM3+HY3nHNhD1h8YiRFMCCvtrUzulDfKwnQn2vgIzbHkjH4SzG
   jb4gywSFY0qqMjjRHJqE7vjxvwhnMdeeZlaamRegzSbd1M3goYRCqydVY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736117"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736117"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034857"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034857"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: don't set CHECKSUM_COMPLETE for unsupported protocols
Date:   Thu, 13 Apr 2023 10:44:15 +0300
Message-Id: <20230413102635.a2a35286f0ca.I50daa9445a6465514c44f5096c32adef64beba5f@changeid>
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

On Bz devices, CHECKSUM_COMPLETE was set for unsupported protocols
which results in a warning. Fix it.

Fixes: b6f5b647f694 ("iwlwifi: mvm: handle RX checksum on Bz devices")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 5d803e537b00..31e1d0ccdec5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -172,8 +172,7 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 * Starting from Bz hardware, it calculates starting directly after
 	 * the MAC header, so that matches mac80211's expectation.
 	 */
-	if (skb->ip_summed == CHECKSUM_COMPLETE &&
-	    mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ) {
+	if (skb->ip_summed == CHECKSUM_COMPLETE) {
 		struct {
 			u8 hdr[6];
 			__be16 type;
@@ -188,7 +187,7 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 			      shdr->type != htons(ETH_P_PAE) &&
 			      shdr->type != htons(ETH_P_TDLS))))
 			skb->ip_summed = CHECKSUM_NONE;
-		else
+		else if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
 			/* mac80211 assumes full CSUM including SNAP header */
 			skb_postpush_rcsum(skb, shdr, sizeof(*shdr));
 	}
-- 
2.38.1

