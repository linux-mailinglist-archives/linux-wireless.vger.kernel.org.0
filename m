Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32EC2CBD35
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgLBMmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 07:42:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33962 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbgLBMmm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 07:42:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kkRSF-0037gb-Rw; Wed, 02 Dec 2020 14:41:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  2 Dec 2020 14:41:50 +0200
Message-Id: <iwlwifi.20201202143859.375bec857ccb.I83884286b688965293e9810381808039bd7eedae@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202124151.55050-1-luca@coelho.fi>
References: <20201202124151.55050-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 2/3] iwlwifi: pcie: invert values of NO_160 device config entries
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The NO_160 flag specifies if the device doesn't have 160 MHz support,
but we errorneously assumed the opposite.  If the flag was set, we
were considering that 160 MHz was supported, but it's actually the
opposite.  Fix it by inverting the bits, i.e. NO_160 is 0x1 and 160
is 0x0.

Fixes: d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device tables")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ca4967b81d01..580b07a43856 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -491,8 +491,8 @@ struct iwl_cfg {
 #define IWL_CFG_RF_ID_HR		0x7
 #define IWL_CFG_RF_ID_HR1		0x4
 
-#define IWL_CFG_NO_160			0x0
-#define IWL_CFG_160			0x1
+#define IWL_CFG_NO_160			0x1
+#define IWL_CFG_160			0x0
 
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
-- 
2.29.2

