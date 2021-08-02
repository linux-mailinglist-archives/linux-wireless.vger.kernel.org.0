Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE33DDB03
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhHBO2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50948 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234102AbhHBO2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvl-001xts-6N; Mon, 02 Aug 2021 17:28:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:25 +0300
Message-Id: <iwlwifi.20210802172232.3db450ebbb3c.Ic63f85b85a043256318da49d7b5a63f7dddf3986@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802142829.109448-1-luca@coelho.fi>
References: <20210802142829.109448-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/12] iwlwifi: remove trailing semicolon in macro definition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 80475c7a6fba..3cd7b423c588 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -318,7 +318,7 @@ iwlagn_accumulative_statistics(struct iwl_priv *priv,
 		    (__le32 *)&priv->delta_stats._name,		\
 		    (__le32 *)&priv->max_delta_stats._name,	\
 		    (__le32 *)&priv->accum_stats._name,		\
-		    sizeof(*_name));
+		    sizeof(*_name))
 
 	ACCUM(common);
 	ACCUM(rx_non_phy);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index 01580c9175f3..3e81e9369224 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -142,7 +142,7 @@ enum iwl_bt_mxbox_dw3 {
 					 "\t%s: %d%s",			    \
 					 #_field,			    \
 					 BT_MBOX_MSG(notif, _num, _field),  \
-					 true ? "\n" : ", ");
+					 true ? "\n" : ", ")
 enum iwl_bt_activity_grading {
 	BT_OFF			= 0,
 	BT_ON_NO_CONNECTION	= 1,
-- 
2.32.0

