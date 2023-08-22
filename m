Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099D783AFE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjHVHdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjHVHdn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:33:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF1C184
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689621; x=1724225621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5MHvZF6VB1FNjw9XIsVKL/XzoxG/yHr3Gs5I+Bkkdnw=;
  b=FrBmsjX15LXr8EME+Bv0D5nEvNdfDz3S7WH9qDr/a8XW9DTQ56vORATn
   069eDZFfgFLPiBLE6CtpCDUjrxkV2Kjaot99z0+as7N97dn2vz6JqJYpq
   1p3iYRL+4I+1rW6G0Zknn8UAbC30oDRKAeBx+Le0cklmN88lQ0NYScb0/
   TTLVbvRCuzl7TjDSkpYWjvxJ4PxJU2XWe+WiQ6jl6eZ/a14DQcqvValzy
   xKM8Zb/7YjS1cdmRzQBAVwqXXeW89K3gU4OO5tNJMh7oHOqIL92b6dn6Z
   hTXdkCHPC8n0xfI9NjhOeCtMGJECoyfg8SZ65V1ze9Iq3CzrIbmLp4fci
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363968759"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="363968759"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826229611"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826229611"
Received: from msharshe-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.209.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/5] wifi: iwlmei: send HOST_GOES_DOWN message even if wiamt is disabled
Date:   Tue, 22 Aug 2023 10:33:17 +0300
Message-Id: <20230822103048.2baad50eb1c3.If7b7c1dc2d6bfc6bacf7f6c72972f19714d9d973@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822073319.466640-1-gregory.greenman@intel.com>
References: <20230822073319.466640-1-gregory.greenman@intel.com>
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

From: Avraham Stern <avraham.stern@intel.com>

The HOST_GOES_DOWN message should be sent even if wiamt is disabled.
Otherwise wiamt may still use the shared memory (e.g. if enabled
later) while it's no longer valid.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 42 +++++++++----------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 908506f98242..27f45f5ea264 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -2070,33 +2070,29 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 
 	mutex_lock(&iwl_mei_mutex);
 
-	if (mei->amt_enabled) {
-		/*
-		 * Tell CSME that we are going down so that it won't access the
-		 * memory anymore, make sure this message goes through immediately.
-		 */
-		mei->csa_throttled = false;
-		iwl_mei_send_sap_msg(mei->cldev,
-				     SAP_MSG_NOTIF_HOST_GOES_DOWN);
-
-		for (i = 0; i < SEND_SAP_MAX_WAIT_ITERATION; i++) {
-			if (!iwl_mei_host_to_me_data_pending(mei))
-				break;
+	/* Tell CSME that we are going down so that it won't access the
+	 * memory anymore, make sure this message goes through immediately.
+	 */
+	mei->csa_throttled = false;
+	iwl_mei_send_sap_msg(mei->cldev,
+			     SAP_MSG_NOTIF_HOST_GOES_DOWN);
 
-			msleep(20);
-		}
+	for (i = 0; i < SEND_SAP_MAX_WAIT_ITERATION; i++) {
+		if (!iwl_mei_host_to_me_data_pending(mei))
+			break;
 
-		/*
-		 * If we couldn't make sure that CSME saw the HOST_GOES_DOWN
-		 * message, it means that it will probably keep reading memory
-		 * that we are going to unmap and free, expect IOMMU error
-		 * messages.
-		 */
-		if (i == SEND_SAP_MAX_WAIT_ITERATION)
-			dev_err(&mei->cldev->dev,
-				"Couldn't get ACK from CSME on HOST_GOES_DOWN message\n");
+		msleep(20);
 	}
 
+	/* If we couldn't make sure that CSME saw the HOST_GOES_DOWN
+	 * message, it means that it will probably keep reading memory
+	 * that we are going to unmap and free, expect IOMMU error
+	 * messages.
+	 */
+	if (i == SEND_SAP_MAX_WAIT_ITERATION)
+		dev_err(&mei->cldev->dev,
+			"Couldn't get ACK from CSME on HOST_GOES_DOWN message\n");
+
 	mutex_unlock(&iwl_mei_mutex);
 
 	/*
-- 
2.38.1

