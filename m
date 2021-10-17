Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB143078A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245178AbhJQJmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53682 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245173AbhJQJmm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eb-000YUg-C9; Sun, 17 Oct 2021 12:40:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:15 +0300
Message-Id: <iwlwifi.20211017123741.41563bea6610.I51a886fa75cca723c81877b386ba41b2a9db1122@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: add definitions for new rate & flags
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As a part of preparing to the new rate & flags,
add new needed definitions.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 148 +++++++++++++++++-
 1 file changed, 144 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index c150bae761be..8d7198897535 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -359,10 +359,6 @@ enum {
  */
 #define RATE_MCS_CHAN_WIDTH_POS		11
 #define RATE_MCS_CHAN_WIDTH_MSK_V1	(3 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_20		(0 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_40		(1 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_80		(2 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_160		(3 << RATE_MCS_CHAN_WIDTH_POS)
 
 /* Bit 13: (1) Short guard interval (0.4 usec), (0) normal GI (0.8 usec) */
 #define RATE_MCS_SGI_POS_V1		13
@@ -437,6 +433,150 @@ enum {
 #define RATE_MCS_CTS_REQUIRED_POS  (31)
 #define RATE_MCS_CTS_REQUIRED_MSK  (0x1 << RATE_MCS_CTS_REQUIRED_POS)
 
+/* rate_n_flags bit field version 2
+ *
+ * The 32-bit value has different layouts in the low 8 bits depending on the
+ * format. There are three formats, HT, VHT and legacy (11abg, with subformats
+ * for CCK and OFDM).
+ *
+ */
+
+/* Bits 10-8: rate format
+ * (0) Legacy CCK (1) Legacy OFDM (2) High-throughput (HT)
+ * (3) Very High-throughput (VHT) (4) High-efficiency (HE)
+ * (5) Extremely High-throughput (EHT)
+ */
+#define RATE_MCS_MOD_TYPE_POS		8
+#define RATE_MCS_MOD_TYPE_MSK		(0x7 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_CCK_MSK		(0 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_LEGACY_OFDM_MSK	(1 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_HT_MSK			(2 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_VHT_MSK		(3 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_HE_MSK			(4 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_EHT_MSK		(5 << RATE_MCS_MOD_TYPE_POS)
+
+/*
+ * Legacy CCK rate format for bits 0:3:
+ *
+ * (0) 0xa - 1 Mbps
+ * (1) 0x14 - 2 Mbps
+ * (2) 0x37 - 5.5 Mbps
+ * (3) 0x6e - 11 nbps
+ *
+ * Legacy OFDM rate format for bis 3:0:
+ *
+ * (0) 6 Mbps
+ * (1) 9 Mbps
+ * (2) 12 Mbps
+ * (3) 18 Mbps
+ * (4) 24 Mbps
+ * (5) 36 Mbps
+ * (6) 48 Mbps
+ * (7) 54 Mbps
+ *
+ */
+#define RATE_LEGACY_RATE_MSK		0x7
+
+/*
+ * HT, VHT, HE, EHT rate format for bits 3:0
+ * 3-0: MCS
+ *
+ */
+#define RATE_HT_MCS_CODE_MSK		0x7
+#define RATE_MCS_NSS_POS		4
+#define RATE_MCS_NSS_MSK		(1 << RATE_MCS_NSS_POS)
+#define RATE_MCS_CODE_MSK		0xf
+#define RATE_HT_MCS_INDEX(r)		((((r) & RATE_MCS_NSS_MSK) >> 1) | \
+					 ((r) & RATE_HT_MCS_CODE_MSK))
+
+/* Bits 7-5: reserved */
+
+/*
+ * Bits 13-11: (0) 20MHz, (1) 40MHz, (2) 80MHz, (3) 160MHz, (4) 320MHz
+ */
+#define RATE_MCS_CHAN_WIDTH_MSK			(0x7 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_20			(0 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_40			(1 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_80			(2 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_160			(3 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_320			(4 << RATE_MCS_CHAN_WIDTH_POS)
+
+/* Bit 15-14: Antenna selection:
+ * Bit 14: Ant A active
+ * Bit 15: Ant B active
+ *
+ * All relevant definitions are same as in v1
+ */
+
+/* Bit 16 (1) LDPC enables, (0) LDPC disabled */
+#define RATE_MCS_LDPC_POS	16
+#define RATE_MCS_LDPC_MSK	(1 << RATE_MCS_LDPC_POS)
+
+/* Bit 17: (0) SS, (1) SS*2 (same as v1) */
+
+/* Bit 18: OFDM-HE dual carrier mode (same as v1) */
+
+/* Bit 19: (0) Beamforming is off, (1) Beamforming is on (same as v1) */
+
+/*
+ * Bit 22-20: HE LTF type and guard interval
+ * CCK:
+ *	0			long preamble
+ *	1			short preamble
+ * HT/VHT:
+ *	0			0.8us
+ *	1			0.4us
+ * HE (ext) SU:
+ *	0			1xLTF+0.8us
+ *	1			2xLTF+0.8us
+ *	2			2xLTF+1.6us
+ *	3			4xLTF+3.2us
+ *	4			4xLTF+0.8us
+ * HE MU:
+ *	0			4xLTF+0.8us
+ *	1			2xLTF+0.8us
+ *	2			2xLTF+1.6us
+ *	3			4xLTF+3.2us
+ * HE TRIG:
+ *	0			1xLTF+1.6us
+ *	1			2xLTF+1.6us
+ *	2			4xLTF+3.2us
+ * */
+#define RATE_MCS_HE_GI_LTF_MSK		(0x7 << RATE_MCS_HE_GI_LTF_POS)
+#define RATE_MCS_SGI_POS		RATE_MCS_HE_GI_LTF_POS
+#define RATE_MCS_SGI_MSK		(1 << RATE_MCS_SGI_POS)
+
+/* Bit 24-23: HE type. (0) SU, (1) SU_EXT, (2) MU, (3) trigger based */
+#define RATE_MCS_HE_TYPE_POS		23
+#define RATE_MCS_HE_TYPE_SU		(0 << RATE_MCS_HE_TYPE_POS)
+#define RATE_MCS_HE_TYPE_EXT_SU		(1 << RATE_MCS_HE_TYPE_POS)
+#define RATE_MCS_HE_TYPE_MU		(2 << RATE_MCS_HE_TYPE_POS)
+#define RATE_MCS_HE_TYPE_TRIG		(3 << RATE_MCS_HE_TYPE_POS)
+#define RATE_MCS_HE_TYPE_MSK		(3 << RATE_MCS_HE_TYPE_POS)
+
+/* Bit 25: duplicate channel enabled
+ *
+ * if this bit is set, duplicate is according to BW (bits 11-13):
+ *
+ * CCK:  2x 20MHz
+ * OFDM Legacy: N x 20Mhz, (N = BW \ 2 , either 2, 4, 8, 16)
+ * EHT: 2 x BW/2, (80 - 2x40, 160 - 2x80, 320 - 2x160)
+ * */
+#define RATE_MCS_DUP_POS		25
+#define RATE_MCS_DUP_MSK		(1 << RATE_MCS_DUP_POS)
+
+/* Bit 26: (1) 106-tone RX (8 MHz RU), (0) normal bandwidth */
+#define RATE_MCS_HE_106T_POS		26
+#define RATE_MCS_HE_106T_MSK		(1 << RATE_MCS_HE_106T_POS)
+
+/* Bit 27: EHT extra LTF:
+ * instead of 1 LTF for SISO use 2 LTFs,
+ * instead of 2 LTFs for NSTS=2 use 4 LTFs*/
+#define RATE_MCS_EHT_EXTRA_LTF_POS	27
+#define RATE_MCS_EHT_EXTRA_LTF_MSK	(1 << RATE_MCS_EHT_EXTRA_LTF_POS)
+
+/* Bit 31-28: reserved */
+
 /* Link Quality definitions */
 
 /* # entries in rate scale table to support Tx retries */
-- 
2.33.0

