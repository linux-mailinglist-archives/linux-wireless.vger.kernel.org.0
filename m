Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA767D891
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjAZWgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjAZWgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341DC37F00
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772601; x=1706308601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iygedBPO5jUtaM9KdJmA4GjW+aAo0AXJJGGZYuCd+ZI=;
  b=IfWepGkYVvw0dU3n4HLrD1OuZ67YM+wl9IXhRpuXeiKc2R9ERRCPfIb9
   apxpwbku+LcqD+e78mQMvQddSrzp1N99yjwXzeKNgsmC+knV0mCkWnFWq
   cr9NFWPggm6vef5ydL5krzHg72Uqs9ITacv9N1wwXw3qOLEIQyYiG3YEW
   XufYGN5pO6IVpUB2yGh3FcPHH1EaZ8HAtbrzfjIHXoLJOUdYlDLdJxeJ9
   Xlivt/RJCLm/CIm6BZFBUaTIYKTXww4UzrxM9ykVtaXJSlIqt5hPxc9Xy
   qJ5qUd4WT/gsoHPHVe4J45aK8iNCekG3C9VMh5rHepuSAYUQ35L8bP6Y2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098777"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986328"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986328"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:40 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/12] wifi: iwlwifi: mei: fix compilation errors in rfkill()
Date:   Fri, 27 Jan 2023 00:28:21 +0200
Message-Id: <20230126222821.305122-2-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

The rfkill() callback was invoked with wrong parameters.
It was missed since MEI is defined now as depending on BROKEN.
Fix that.

Fixes: d288067ede4b ("wifi: iwlwifi: mei: avoid blocking sap messages handling due to rtnl lock")
Fixes: 5aa7ce31bd84 ("wifi: iwlwifi: mei: make sure ownership confirmed message is sent")
Fixes: 95170a46b7dd ("wifi: iwlwifi: mei: don't send SAP commands if AMT is disabled")
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index f9d11935ed97..67dfb77fedf7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -788,7 +788,7 @@ static void iwl_mei_handle_amt_state(struct mei_cl_device *cldev,
 	if (mei->amt_enabled)
 		iwl_mei_set_init_conf(mei);
 	else if (iwl_mei_cache.ops)
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false, false);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
 
 	schedule_work(&mei->netdev_work);
 
@@ -829,7 +829,7 @@ static void iwl_mei_handle_csme_taking_ownership(struct mei_cl_device *cldev,
 		 */
 		mei->csme_taking_ownership = true;
 
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true, true);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true);
 	} else {
 		iwl_mei_send_sap_msg(cldev,
 				     SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED);
@@ -1774,7 +1774,7 @@ int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
 			if (mei->amt_enabled)
 				iwl_mei_send_sap_msg(mei->cldev,
 						     SAP_MSG_NOTIF_WIFIDR_UP);
-			ops->rfkill(priv, mei->link_prot_state, false);
+			ops->rfkill(priv, mei->link_prot_state);
 		}
 	}
 	ret = 0;
-- 
2.38.1

