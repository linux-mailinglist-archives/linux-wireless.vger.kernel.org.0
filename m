Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46C83165D6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBJL7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 06:59:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44964 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231278AbhBJL5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:57:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9o6q-0049Ur-5w; Wed, 10 Feb 2021 13:56:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 13:56:28 +0200
Message-Id: <iwlwifi.20210210135352.9d037b8f5098.I3c88af130d9e270517c8bac8eb02e11f817fe959@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210115637.276676-1-luca@coelho.fi>
References: <20210210115637.276676-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 03/12] iwlwifi: acpi: fix PPAG table sizes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were erroneously adding 3 extra values to the table size
calculation, when we should actually add only a 2 (one for the domain
type and one for the enabled/disabled flag).  Fix this for both
revisions we support.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 1cce30d1ef55..62665dfee3cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -54,9 +54,9 @@
 #define ACPI_WGDS_TABLE_SIZE		3
 
 #define ACPI_PPAG_WIFI_DATA_SIZE	((IWL_NUM_CHAIN_LIMITS * \
-					IWL_NUM_SUB_BANDS) + 3)
+					  IWL_NUM_SUB_BANDS) + 2)
 #define ACPI_PPAG_WIFI_DATA_SIZE_V2	((IWL_NUM_CHAIN_LIMITS * \
-					IWL_NUM_SUB_BANDS_V2) + 3)
+					  IWL_NUM_SUB_BANDS_V2) + 2)
 
 /* PPAG gain value bounds in 1/8 dBm */
 #define ACPI_PPAG_MIN_LB -16
-- 
2.30.0

