Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5766719FA9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjFAOUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjFAOUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DA3180
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629238; x=1717165238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r6qpHN/BGTbNVh7DnwmttQ4xOKnREuvh+NP9O9RQ19g=;
  b=J8/gvxkvOBld15XJxYdsIkunOZjmcMmC+5rzv7hmna03VoTkpgN+7Ef6
   2vvm3trXdf5eYrVDFrDknYfy/pTIJJbgFfEbtfZuQpnPl1N1hDq9y/NJQ
   NxYMB/M4SaIYpxVu15u/OnWYRSil8urKx2g/vA7hLeGFf9GaaxiJgR/Cu
   wdWHdWGF3qKZ+JyXCtn16n7Zpb5HWdfNvC6UG7ljkfAmTTHmGRLtwfLWp
   gKogV4MwDMlGxTgN1P0qMUF97Um6Za6PocVIxPYRqMGqDyKr7CAyB1687
   QTNkhvfEK7qfk23bbDLS54muSGfGQUY5A4qrbPQhyUDizcyo+f/JClsdB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931825"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812791"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812791"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/6] wifi: iwlwifi: api: use __le16 instead of u16
Date:   Thu,  1 Jun 2023 17:20:04 +0300
Message-Id: <20230601171633.29ebf70aa64e.I1263f6724e1c70ff5541f447b9744f143ee736a3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601142008.375040-1-gregory.greenman@intel.com>
References: <20230601142008.375040-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Even for reserved values we shouldn't use u16, that's just
error prone. Fix this to __le16.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index f92cac1da764..85d89f559f6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -537,7 +537,7 @@ union iwl_ppag_table_cmd {
 struct iwl_sar_offset_mapping_cmd {
 	u8 offset_map[MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE]
 		[MCC_TO_SAR_OFFSET_TABLE_COL_SIZE];
-	u16 reserved;
+	__le16 reserved;
 } __packed; /*SAR_OFFSET_MAPPING_TABLE_CMD_API_S*/
 
 /**
-- 
2.38.1

