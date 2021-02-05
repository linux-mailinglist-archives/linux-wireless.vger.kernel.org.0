Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE831076F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 10:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBEJMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:12:09 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43746 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230111AbhBEJHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7x4i-0044i1-5T; Fri, 05 Feb 2021 11:06:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  5 Feb 2021 11:06:33 +0200
Message-Id: <iwlwifi.20210205110447.46cd538c90bf.I92179567d96938598806b560be59d787c2a8cc16@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205090642.1553849-1-luca@coelho.fi>
References: <20210205090642.1553849-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [RESEND PATCH 03/12] iwlwifi: fw api: make hdr a zero-size array again
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In struct iwl_tx_cmd, there's no risk (as Arnd implied) that we
might access this as an array, as it's really not an array and
cannot be - there's only a single 802.11 header per frame. The
only reason for this member is for being able to access it a
bit more nicely.

On the other hand, this structure is used as a sub-struct in a
few places, and then some compilers (e.g. clang with certain
options) complain as you shouldn't have structs with variable-
length fields embedded in other structs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 644ced53160a..95038b1a8c6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -238,7 +238,7 @@ struct iwl_tx_cmd {
 	__le16 pm_frame_timeout;
 	__le16 reserved4;
 	u8 payload[0];
-	struct ieee80211_hdr hdr[];
+	struct ieee80211_hdr hdr[0];
 } __packed; /* TX_CMD_API_S_VER_6 */
 
 struct iwl_dram_sec_info {
-- 
2.30.0

