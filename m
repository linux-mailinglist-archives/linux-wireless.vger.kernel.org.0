Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99C6C0F03
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCTKgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCTKfc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E05EC77
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308501; x=1710844501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BepDNlXi2p8oNxwr06rmtn5b5qI70nduLqNzIF02g9Y=;
  b=Kwiv7sBw1MlIoh07bA/qgeaXz4XAk7suDvDHoE4mKN567mUcyhRYS4GU
   vxAXrdMcMwQjfY0QwZctEiNuuNzC5CPQ1LzVVseiKV/K3kqesN84D6KEA
   Dkusz9Isisqv87qgigDteWgarveZdNar09RcRU/v6n4/k48b3IryapF9N
   IHEQQOuZOroMzO3tRCfb8fHNYqAWMm8WPnF42IuezCRku3bIwpj93L9wK
   97lF4h6rL8ct0xSyxuEtyFRH2lkwNaEOQI88x9xma/Pi6D1ar+n+1tOBP
   oG6/d+e+xPFHugk4dB7UtZSWneKLqqeWzPR0CUQUWzRnk6zn67IR0Wrjf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997931"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523688"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523688"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/18] wifi: iwlwifi: mvm: refactor iwl_mvm_sta
Date:   Mon, 20 Mar 2023 12:33:13 +0200
Message-Id: <20230320122330.c8b86d8ddd3e.I9581235860b91654b4f6c3a8797c777702690998@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As the new MLD API is introduced, we have a new enumeration
for the different station types. Since struct iwl_mvm_sta's
sta_type field will be in use for both new and old API,
change its type to a unified one, so it can hold both.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 432768bfc433..a0c13c409ccd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -386,7 +386,7 @@ struct iwl_mvm_sta {
 	u32 mac_id_n_color;
 	u16 tid_disable_agg;
 	u16 max_agg_bufsize;
-	enum iwl_sta_type sta_type;
+	u8 sta_type;
 	enum ieee80211_sta_state sta_state;
 	bool bt_reduced_txpower;
 	bool next_status_eosp;
-- 
2.38.1

