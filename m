Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC643E13C2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhHELWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241010AbhHELWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRr-00243p-FZ; Thu, 05 Aug 2021 14:22:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:50 +0300
Message-Id: <iwlwifi.20210805141826.91dec6fad3e8.Ica42d5538d83b1407efe0c441c61aa8830e7496d@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805112158.460799-1-luca@coelho.fi>
References: <20210805112158.460799-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: remove unused ACPI_WGDS_TABLE_SIZE definition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When we started supporting the new FW API for the geo profiles, we
stopped using this definition, but left it there.  Remove it now.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 2d98f7e903e7..85cf4cb1336e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -65,8 +65,6 @@
 #define APCI_WTAS_BLACK_LIST_MAX	16
 #define ACPI_WTAS_WIFI_DATA_SIZE	(3 + APCI_WTAS_BLACK_LIST_MAX)
 
-#define ACPI_WGDS_TABLE_SIZE		3
-
 #define ACPI_PPAG_WIFI_DATA_SIZE_V1	((IWL_NUM_CHAIN_LIMITS * \
 					  IWL_NUM_SUB_BANDS_V1) + 2)
 #define ACPI_PPAG_WIFI_DATA_SIZE_V2	((IWL_NUM_CHAIN_LIMITS * \
-- 
2.32.0

