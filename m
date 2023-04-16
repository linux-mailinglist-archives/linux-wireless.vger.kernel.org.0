Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3F6E3850
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDPMsE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDPMsA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8A43580
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649275; x=1713185275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ASiI5mcKVNRfguIkWIYcG9htqDIj8KRP57PO2eZxomg=;
  b=XT9g82p0KBD2h20pDSNT/rzZBklsliGPZlr/Hq39u3bfaInKe8mQdmla
   4Ww7F49uB0c3pnyTaHblbPl+Bh2dX04/2NvezhrMrJQTF6sBVEZXteMgN
   DtOvf3IT0YXusVh1k2Wj7xCrJDU9cxoAVnq+d2SukOFX0s/OUvjAONGGn
   GxI9ODDudSRvEinJ7gMq/RKfsRIe5JzsJ/hKIed+Vu93RRkEzaCnjm2x/
   JGeS5CcQEjHlRpbk+GrX0x8i4oQFquikptUeCWdxEA4HH0hClmXs190nb
   WWbckpJdtBTzhsbX/ExYgHyvvLeczv1xh+/JUCl4ITOQtaXj4WkrKgfdK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520545"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520545"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670412"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670412"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: nvm-parse: add full BW UL MU-MIMO support
Date:   Sun, 16 Apr 2023 15:47:25 +0300
Message-Id: <20230416154301.88b6aac6c876.Ibf2a7a38d7a172c371c347c9d4441e8c656cefe3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For some devices, in client mode, we support full bandwidth
uplink multi-user MIMO. Add the necessary capability.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 92a79df3e6d2..7dcb1c3ab728 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -938,6 +938,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		}
 	}
 
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210 && !is_ap)
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
+			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
+
 	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_GF:
 	case IWL_CFG_RF_TYPE_MR:
-- 
2.38.1

