Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B081783AFF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHVHdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjHVHdo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:33:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F52185
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689623; x=1724225623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6czQlxF7ZplpWqLhYFFnyP1ejAieInrxBajoq+3u3V4=;
  b=lcDpkf642PU1XOoYERZZOMNHCBd4Ky5OMDWOSDRaUfZPHkqJVhcSuYuT
   t332YXEA+U7GqYQrbdMk0WKliXb1F3Ho6En1g/B1+xO9vZnId0pD0Ur7w
   BTlIPgsXedq1E7D0Kus03PZqt6/6ZF7SpmQDisOp/L53cFe4BVHS84UaX
   bvu6UZa2Am7LY2bu0RFWt208AD381Rbk4kAItM8S3dT7aNC9egRZOY3qL
   xMCKYcGwtjmZxzpflXlPyTu3TO/K5QRpSdyphydi/MrWS1BUuAff0ioDn
   WnjfWsNWkE5NS59gBnJcti1Hmrl9+ulxhjcTulzgDBkfRsu5+/90id92M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363968771"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="363968771"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826229614"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826229614"
Received: from msharshe-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.209.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/5] wifi: iwlmei: send driver down SAP message only if wiamt is enabled
Date:   Tue, 22 Aug 2023 10:33:18 +0300
Message-Id: <20230822103048.100f41b84656.I583d3e18ea65793f53aa710af13e47f8af82b53d@changeid>
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

When wiamt is disabled the driver up SAP message is not sent, so
there is no need to send the driver down message as well.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 27f45f5ea264..78b78a772f54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1832,7 +1832,9 @@ void iwl_mei_unregister_complete(void)
 		struct iwl_mei *mei =
 			mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-		iwl_mei_send_sap_msg(mei->cldev, SAP_MSG_NOTIF_WIFIDR_DOWN);
+		if (mei->amt_enabled)
+			iwl_mei_send_sap_msg(mei->cldev,
+					     SAP_MSG_NOTIF_WIFIDR_DOWN);
 		mei->got_ownership = false;
 	}
 
-- 
2.38.1

