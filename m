Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51CA97B1F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfHUNkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:40:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37848 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfHUNkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:40:07 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0Qob-0000lZ-AU; Wed, 21 Aug 2019 16:38:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:57 +0300
Message-Id: <20190821133800.23636-16-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 15/18] iwlwifi: dbg: add debug periphery registers to 9000 device family
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Add debug HW periphery registers to 9000 device family.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 34f4cda3b090..40b867f984cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -468,6 +468,9 @@ static const struct iwl_prph_range iwl_prph_dump_addr_9000[] = {
 	{ .start = 0x00a05400, .end = 0x00a056e8 },
 	{ .start = 0x00a08000, .end = 0x00a098bc },
 	{ .start = 0x00a02400, .end = 0x00a02758 },
+	{ .start = 0x00a04764, .end = 0x00a0476c },
+	{ .start = 0x00a04770, .end = 0x00a04774 },
+	{ .start = 0x00a04620, .end = 0x00a04624 },
 };
 
 static const struct iwl_prph_range iwl_prph_dump_addr_22000[] = {
-- 
2.23.0.rc1

