Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DFA309EA9
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhAaUJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:09:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43162 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230134AbhAaUGn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:06:43 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMb-0041H2-Ne; Sun, 31 Jan 2021 20:22:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:10 +0200
Message-Id: <iwlwifi.20210131201908.ed6cf4960800.I661f14d84f864d3860db6fcb05b7f37ec804b6ef@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131182212.929755-1-luca@coelho.fi>
References: <20210131182212.929755-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: mvm: add Microsoft to the PPAG approved list
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Microsoft is now approved to use the PPAG feature.  Add it to the
approved list.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 54e994357c70..b5101c31071b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1055,6 +1055,11 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
 		},
 	},
+	{ .ident = "MSFT",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+		},
+	},
 };
 
 static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
-- 
2.29.2

