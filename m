Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9858612BC7
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3RSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJ3RSd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C5E85
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150310; x=1698686310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcGPokfPkElkitnSMvjvst0rXIATw025XfXs0k7Ixkg=;
  b=n048kdgN9WXJb+qJ42MWWosO4njvj6WI9OF8XtpnHNy5jBD3BsSrozBE
   GMBwLaZTuXxslx5LSYXxJiuNzUdj2hliB8X+johHNznomw3atpZHrP/vS
   1xVj1H1eXPJI3V6hnQKmERiz9aOY9S/5CEMhCYB7IJ0Fa4uFf1/dRC7EM
   snyIbWcFkRH2NvLb2S4ixFCWAcZ8BQT4ekbFZnUDgc6f6bbfagW57DhcP
   q/B/tITzXmhy5su7YRP+hrVWLijri32ibzfxxqNDHd+CJ0CiVuntZuyz9
   HG0oQ94+lN6HRQMKN3aA3EU3Gp+7oP6E530IT8KPiCkGh3Yn3y86WBBgI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="372973236"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="372973236"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290252"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290252"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:28 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/6] wifi: iwlwifi: mei: fix tx DHCP packet for devices with new Tx API
Date:   Sun, 30 Oct 2022 19:17:43 +0200
Message-Id: <20221030191011.12dc42133502.Idd744ffeeb84b880eb497963ee02563cbb959a42@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221030171745.132081-1-gregory.greenman@intel.com>
References: <20221030171745.132081-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Devices with new Tx API have the IV introduced by the HW and it is not
present in the skb at all. Hence we don't need to tell
iwl_mvm_mei_tx_copy_to_csme to jump over 8 bytes to get to the ethernet
header.

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 86d20e13bf47..ba335f57771c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1171,9 +1171,15 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	/* From now on, we cannot access info->control */
 	iwl_mvm_skb_prepare_status(skb, dev_cmd);
 
+	/*
+	 * The IV is introduced by the HW for new tx api, and it is not present
+	 * in the skb, hence, don't tell iwl_mvm_mei_tx_copy_to_csme about the
+	 * IV for those devices.
+	 */
 	if (ieee80211_is_data(fc))
 		iwl_mvm_mei_tx_copy_to_csme(mvm, skb,
-					    info->control.hw_key ?
+					    info->control.hw_key &&
+					    !iwl_mvm_has_new_tx_api(mvm) ?
 					    info->control.hw_key->iv_len : 0);
 
 	if (iwl_trans_tx(mvm->trans, skb, dev_cmd, txq_id))
-- 
2.35.3

