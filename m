Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D246FB0E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhLJHKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:04 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50804 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233061AbhLJHKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:03 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZz6-001F9v-PL; Fri, 10 Dec 2021 09:06:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:12 +0200
Message-Id: <iwlwifi.20211210090244.eb33452fcdc6.I8133ef3aaa0234cb116189c87d22c3f10235105e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/11] iwlwifi: fw: remove dead error log code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The struct iwl_error_event_table_v1 is unused, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 47 --------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 358fc2d999d5..6c59506ea00d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -19,53 +19,6 @@
  * read with u32-sized accesses, any members with a different size
  * need to be ordered correctly though!
  */
-struct iwl_error_event_table_v1 {
-	u32 valid;		/* (nonzero) valid, (0) log is empty */
-	u32 error_id;		/* type of error */
-	u32 pc;			/* program counter */
-	u32 blink1;		/* branch link */
-	u32 blink2;		/* branch link */
-	u32 ilink1;		/* interrupt link */
-	u32 ilink2;		/* interrupt link */
-	u32 data1;		/* error-specific data */
-	u32 data2;		/* error-specific data */
-	u32 data3;		/* error-specific data */
-	u32 bcon_time;		/* beacon timer */
-	u32 tsf_low;		/* network timestamp function timer */
-	u32 tsf_hi;		/* network timestamp function timer */
-	u32 gp1;		/* GP1 timer register */
-	u32 gp2;		/* GP2 timer register */
-	u32 gp3;		/* GP3 timer register */
-	u32 ucode_ver;		/* uCode version */
-	u32 hw_ver;		/* HW Silicon version */
-	u32 brd_ver;		/* HW board version */
-	u32 log_pc;		/* log program counter */
-	u32 frame_ptr;		/* frame pointer */
-	u32 stack_ptr;		/* stack pointer */
-	u32 hcmd;		/* last host command header */
-	u32 isr0;		/* isr status register LMPM_NIC_ISR0:
-				 * rxtx_flag */
-	u32 isr1;		/* isr status register LMPM_NIC_ISR1:
-				 * host_flag */
-	u32 isr2;		/* isr status register LMPM_NIC_ISR2:
-				 * enc_flag */
-	u32 isr3;		/* isr status register LMPM_NIC_ISR3:
-				 * time_flag */
-	u32 isr4;		/* isr status register LMPM_NIC_ISR4:
-				 * wico interrupt */
-	u32 isr_pref;		/* isr status register LMPM_NIC_PREF_STAT */
-	u32 wait_event;		/* wait event() caller address */
-	u32 l2p_control;	/* L2pControlField */
-	u32 l2p_duration;	/* L2pDurationField */
-	u32 l2p_mhvalid;	/* L2pMhValidBits */
-	u32 l2p_addr_match;	/* L2pAddrMatchStat */
-	u32 lmpm_pmg_sel;	/* indicate which clocks are turned on
-				 * (LMPM_PMG_SEL) */
-	u32 u_timestamp;	/* indicate when the date and time of the
-				 * compilation */
-	u32 flow_handler;	/* FH read/write pointers, RX credit */
-} __packed /* LOG_ERROR_TABLE_API_S_VER_1 */;
-
 struct iwl_error_event_table {
 	u32 valid;		/* (nonzero) valid, (0) log is empty */
 	u32 error_id;		/* type of error */
-- 
2.34.1

