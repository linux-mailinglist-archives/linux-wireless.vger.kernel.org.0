Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5534E90A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhC3NZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43630 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231960AbhC3NZL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMk-0007fg-SD; Tue, 30 Mar 2021 16:25:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:56 +0300
Message-Id: <iwlwifi.20210330162204.b87618a26ff8.Icf1d9c150ec108f30ce0e72c18b9350da6ae5087@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330132500.468321-1-luca@coelho.fi>
References: <20210330132500.468321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/12] iwlwifi: add 160Mhz to killer 1550 name
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: ybaruch <yaara.baruch@intel.com>

change the name of 1550 killer device to 160Mhz.

Signed-off-by: ybaruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index c4164bf508e5..df1297358379 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -168,7 +168,7 @@ const char iwl9462_160_name[] = "Intel(R) Wireless-AC 9462 160MHz";
 const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
 
 const char iwl9260_killer_1550_name[] =
-	"Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW)";
+	"Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW) 160MHz";
 const char iwl9560_killer_1550i_name[] =
 	"Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)";
 const char iwl9560_killer_1550s_name[] =
-- 
2.31.0

