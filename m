Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914861657F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKBPBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKBPBP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:01:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D201F2A974
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401272; x=1698937272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ujq1o3vuZTDNTB4gcu1aJxu/TTs3rto43eqWGXMRkI=;
  b=ZZ78WaH9O8i6VUTkLHgb/so3XSNbaOpwWho6qbbAqjY0/q43uzD3HjpQ
   fb2zFwvOiWxCYbIdSB6qDof61JfC6WRoHXeZlzOJbdG73S1WB2c0EfMut
   QWU57+4GOQGEPPKc9rJkFgbdfodMMZYDtpDL0J0Duzl0bo/5DmHoZB9kN
   YlCoBEJBXsCcOpm1zeHa07MDwdqPfUd24PMhaS03XalGV4EEBU/vHfuN/
   HnKGtUZa5To1Barz4Ah6cVqg9hFdO+qaHvBKAqP00TKnNG1AzXjQwagHq
   Vrt7X8GZsAUYT8S7MK8adLPpQfSjA+h10yAjQIcAewUdFVC31L1hhXFfI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523607"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523607"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:01:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810727"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810727"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:59 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: iwlmei: report disconnection as temporary
Date:   Wed,  2 Nov 2022 16:59:57 +0200
Message-Id: <20221102165239.401665457652.Ie5de9eacc5a51cf0965a08c202caf3fbc3a91ec4@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Disconnections are reported to CSME as long link down. As a result,
CSME will take ownership right away so the host doesn't have a
chance to reconnect, although in many cases it could quickly reconnect
and preserve host connectivity.
Report disconnections as temporary so CSME will give the host some
grace time to reconnect.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index ef5d2938deb5..9a49361cd059 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1535,7 +1535,7 @@ void iwl_mei_host_disassociated(void)
 	struct iwl_sap_notif_host_link_down msg = {
 		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_HOST_LINK_DOWN),
 		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
-		.type = HOST_LINK_DOWN_TYPE_LONG,
+		.type = HOST_LINK_DOWN_TYPE_TEMPORARY,
 	};
 
 	mutex_lock(&iwl_mei_mutex);
-- 
2.35.3

