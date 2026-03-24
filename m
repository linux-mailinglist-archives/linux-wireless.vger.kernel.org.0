Return-Path: <linux-wireless+bounces-33757-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pu4Eg4uwml5ZwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33757-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:24:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F5B302CFB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67C133038408
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 06:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111361ACED5;
	Tue, 24 Mar 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OXb/NyC6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD82BD5B4
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333277; cv=none; b=NrUKedH40KTFD6kABUWq30bnB5Z7+AO9XdQr/wW8CFG4TgEg/OiFyi72XgY8DynQg8MxkFz1ptxwrFLxftOzLj8QIupngZmG60X2JjypM5QwqcujCqyUgtYXJsj9Lt/oakNp6qusWH56K9I+qdg1XBvjfe3QMZs0oEubadRZrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333277; c=relaxed/simple;
	bh=ng3FTDHZc/XYd+RkYNDnEU8KszmKb9SC6RFb3BScLkY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujy3c/s0TjrF30Q0mmOdO6VZpZINAfyo2ISkeRbHtPBkH/SrZzN3CG1cfqZ8Bovg8BF9ye+DYbZZPz9Q4h4OWPy5m/SmFiTQJu3t0zbTFNU3mGqgeM5q+XGurVyv8Ob/CUE3FsAb9FCPMCniJipj+L8LPhnurnpMn/mbAV8OJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OXb/NyC6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O6LCZa8557192, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774333272; bh=P4nptx+4DhFKQ8socjzHPOUgXWoWEnBsyNIhKxGu64Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OXb/NyC6wYiyTVdWpnmQIvnLZHhKbK6Sl97+1e721A8KwZWI1GLynp1935t07mg4P
	 zECasugwRoCDK/kvYv+1xdZ1pVcgRmvJBECrLtAFQjpyrjoUidDVxspiq4JaGolE7L
	 fMIXXnwMD+lvzUyx1edBm5ezn+UI6tLUWQKXV/Fpy8Q0sT5ltsRBWqMvbGZ5uqyvd+
	 FbRtoACR+3Kn3j1DT8Hto8SF79lSmy7RSE8OH/01P15YjFn7o4Du/IrgM9GQCmMP2Q
	 2gxIycoISMXtD7KblVVtEz+jEy8tWuCAp4xf0XQYd06sFqpS/qp5+ShoNfe/SvqV3U
	 heUemlq/9sqBw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O6LCZa8557192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:21:12 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 14:21:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 rtw-next 1/7] wifi: rtw89: 8922d: add definition of quota, registers and efuse block
Date: Tue, 24 Mar 2026 14:20:43 +0800
Message-ID: <20260324062049.52266-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260324062049.52266-1-pkshih@realtek.com>
References: <20260324062049.52266-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33757-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05F5B302CFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The quota is used to configure memory size for TX/RX, and the definition
of registers includes H2C command, C2H event, WoWLAN reason, IMR of CMAC
and DMAC, ACK rate selector, RF kill GPIO, and BB functions of dynamic
initial gain and EDCCA. The layout of efuse block is to define logic
map of efuse, such as MAC address and RF calibration values.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  30 +++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 238 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h |  10 +
 3 files changed, 278 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.h

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9b605617c3f0..2cb35458a822 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8737,6 +8737,7 @@
 #define R_PHY_STS_BITMAP_EHT 0x0788
 #define R_PHY_STS_BITMAP_EHT_BE4 0x20788
 #define R_EDCCA_RPTREG_SEL_BE 0x078C
+#define R_EDCCA_RPTREG_SEL_BE4 0x2078C
 #define B_EDCCA_RPTREG_SEL_BE_MSK GENMASK(22, 20)
 #define R_PMAC_GNT 0x0980
 #define B_PMAC_GNT_TXEN BIT(0)
@@ -8850,6 +8851,7 @@
 #define R_UDP_COEEF 0x0CBC
 #define B_UDP_COEEF BIT(19)
 #define R_TX_COLLISION_T2R_ST_BE 0x0CC8
+#define R_TX_COLLISION_T2R_ST_BE4 0x20CC8
 #define B_TX_COLLISION_T2R_ST_BE_M GENMASK(13, 8)
 #define R_RXHT_MCS_LIMIT 0x0D18
 #define B_RXHT_MCS_LIMIT GENMASK(9, 8)
@@ -9078,7 +9080,11 @@
 #define R_P1_EN_SOUND_WO_NDP 0x2D7C
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
 #define R_EDCCA_RPT_A_BE 0x2E38
+#define R_EDCCA_RPT_A_BE4 0x2EE30
+#define R_EDCCA_RPT_A_BE4_C1 0x2FE30
 #define R_EDCCA_RPT_B_BE 0x2E3C
+#define R_EDCCA_RPT_B_BE4 0x2EE34
+#define R_EDCCA_RPT_B_BE4_C1 0x2FE34
 #define R_EDCCA_RPT_P1_A_BE 0x2E40
 #define R_EDCCA_RPT_P1_B_BE 0x2E44
 #define R_S1_HW_SI_DIS 0x3200
@@ -9262,11 +9268,13 @@
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V1 0x4C24
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V2 0x46E8
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V3 0x41C8
+#define R_PATH0_P20_FOLLOW_BY_PAGCUGC_BE4 0x241C8
 #define B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC 0x46A4
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V1 0x4C28
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V2 0x46EC
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V3 0x41CC
+#define R_PATH0_S20_FOLLOW_BY_PAGCUGC_BE4 0x241CC
 #define B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH0_RXB_INIT_V1 0x46A8
 #define B_PATH0_RXB_INIT_IDX_MSK_V1 GENMASK(14, 10)
@@ -9313,11 +9321,13 @@
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V1 0x4CE8
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V2 0x47A8
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V3 0x45C8
+#define R_PATH1_P20_FOLLOW_BY_PAGCUGC_BE4 0x245C8
 #define B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC 0x4778
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V1 0x4CEC
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V2 0x47AC
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V3 0x45CC
+#define R_PATH1_S20_FOLLOW_BY_PAGCUGC_BE4 0x245CC
 #define B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_G_TIA0_LNA6_OP1DB_V1 0x4778
 #define B_PATH1_G_TIA0_LNA6_OP1DB_V1 GENMASK(7, 0)
@@ -9338,6 +9348,7 @@
 #define R_SEG0R_PD 0x481C
 #define R_SEG0R_PD_V1 0x4860
 #define R_SEG0R_PD_V2 0x6A74
+#define R_SEG0R_PD_BE4 0x26210
 #define R_SEG0R_EDCCA_LVL 0x4840
 #define R_SEG0R_EDCCA_LVL_V1 0x4884
 #define B_EDCCA_LVL_MSK3 GENMASK(31, 24)
@@ -9476,9 +9487,11 @@
 #define B_DCFO_COMP_S0_V1_MSK GENMASK(13, 0)
 #define R_BMODE_PDTH_V1 0x4B64
 #define R_BMODE_PDTH_V2 0x6708
+#define R_BMODE_PDTH_BE4 0x26040
 #define B_BMODE_PDTH_LOWER_BOUND_MSK_V1 GENMASK(31, 24)
 #define R_BMODE_PDTH_EN_V1 0x4B74
 #define R_BMODE_PDTH_EN_V2 0x6718
+#define R_BMODE_PDTH_EN_BE4 0x26050
 #define B_BMODE_PDTH_LIMIT_EN_MSK_V1 BIT(30)
 #define R_BSS_CLR_VLD_V2 0x4EBC
 #define B_BSS_CLR_VLD0_V2 BIT(2)
@@ -9653,7 +9666,9 @@
 #define R_CCK_FC0INV 0x675c
 #define B_CCK_FC0INV GENMASK(18, 0)
 #define R_SEG0R_EDCCA_LVL_BE 0x69EC
+#define R_SEG0R_EDCCA_LVL_BE4 0x2623C
 #define R_SEG0R_PPDU_LVL_BE 0x69F0
+#define R_SEG0R_PPDU_LVL_BE4 0x26240
 #define R_SEGSND 0x6A14
 #define B_SEGSND_EN BIT(31)
 #define R_DBCC 0x6B48
@@ -10380,6 +10395,9 @@
 #define B_SW_SI_DATA_DAT_BE4 GENMASK(19, 0)
 #define R_SW_SI_READ_ADDR_BE4 0x20378
 #define B_SW_SI_READ_ADDR_BE4 GENMASK(10, 0)
+#define R_EDCCA_RPT_SEL_BE4 0x20780
+#define R_EDCCA_RPT_SEL_BE4_C1 0x21780
+#define B_EDCCA_RPT_SEL_BE4_MSK 0xE0000
 #define R_IFS_T1_AVG_BE4 0x20EDC
 #define B_IFS_T1_AVG_BE4 GENMASK(15, 0)
 #define B_IFS_T2_AVG_BE4 GENMASK(31, 16)
@@ -10402,6 +10420,18 @@
 #define B_IFS_T3_HIS_BE4 GENMASK(15, 0)
 #define B_IFS_T4_HIS_BE4 GENMASK(31, 16)
 
+#define R_PATH0_RXIDX_INIT_BE4 0x24108
+#define B_PATH0_RXIDX_INIT_BE4 GENMASK(29, 25)
+#define R_PATH0_LNA_INIT_BE4 0x24158
+#define B_PATH0_LNA_INIT_IDX_BE4 GENMASK(14, 12)
+#define R_PATH0_TIA_INIT_BE4 0x24168
+#define B_PATH0_TIA_INIT_IDX_BE4 BIT(18)
+#define R_PATH1_RXIDX_INIT_BE4 0x24508
+#define B_PATH1_RXIDX_INIT_BE4 GENMASK(29, 25)
+#define R_PATH1_LNA_INIT_BE4 0x24558
+#define B_PATH1_LNA_INIT_IDX_BE4 GENMASK(14, 12)
+#define R_PATH1_TIA_INIT_BE4 0x24568
+#define B_PATH1_TIA_INIT_IDX_BE4 BIT(18)
 #define R_TX_CFR_MANUAL_EN_BE4 0x2483C
 #define B_TX_CFR_MANUAL_EN_BE4_M BIT(30)
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
new file mode 100644
index 000000000000..6a90ded1b33e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2026  Realtek Corporation
+ */
+
+#include "efuse.h"
+#include "mac.h"
+#include "reg.h"
+#include "rtw8922d.h"
+
+#define RTW8922D_FW_FORMAT_MAX 0
+#define RTW8922D_FW_BASENAME "rtw89/rtw8922d_fw"
+#define RTW8922D_MODULE_FIRMWARE \
+	RTW89_GEN_MODULE_FWNAME(RTW8922D_FW_BASENAME, RTW8922D_FW_FORMAT_MAX)
+
+#define RTW8922DS_FW_FORMAT_MAX 0
+#define RTW8922DS_FW_BASENAME "rtw89/rtw8922ds_fw"
+#define RTW8922DS_MODULE_FIRMWARE \
+	RTW89_GEN_MODULE_FWNAME(RTW8922DS_FW_BASENAME, RTW8922DS_FW_FORMAT_MAX)
+
+static const struct rtw89_hfc_ch_cfg rtw8922d_hfc_chcfg_pcie[] = {
+	{2, 603, 0}, /* ACH 0 */
+	{0, 601, 0}, /* ACH 1 */
+	{2, 603, 0}, /* ACH 2 */
+	{0, 601, 0}, /* ACH 3 */
+	{2, 603, 0}, /* ACH 4 */
+	{0, 601, 0}, /* ACH 5 */
+	{2, 603, 0}, /* ACH 6 */
+	{0, 601, 0}, /* ACH 7 */
+	{2, 603, 0}, /* B0MGQ */
+	{0, 601, 0}, /* B0HIQ */
+	{2, 603, 0}, /* B1MGQ */
+	{0, 601, 0}, /* B1HIQ */
+	{0, 0, 0}, /* FWCMDQ */
+	{0, 0, 0}, /* BMC */
+	{0, 0, 0}, /* H2D */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922d_hfc_pubcfg_pcie = {
+	613, /* Group 0 */
+	0, /* Group 1 */
+	613, /* Public Max */
+	0, /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8922d_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8922d_hfc_chcfg_pcie, &rtw8922d_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
+	[RTW89_QTA_DBCC] = {rtw8922d_hfc_chcfg_pcie, &rtw8922d_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
+static const struct rtw89_dle_mem rtw8922d_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size16_v1,
+			   &rtw89_mac_size.ple_size20_v1, &rtw89_mac_size.wde_qt19_v1,
+			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt42_v2,
+			   &rtw89_mac_size.ple_qt43_v2, &rtw89_mac_size.ple_rsvd_qt9,
+			   &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
+			   &rtw89_mac_size.dle_input18},
+	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &rtw89_mac_size.wde_size16_v1,
+			   &rtw89_mac_size.ple_size20_v1, &rtw89_mac_size.wde_qt19_v1,
+			   &rtw89_mac_size.wde_qt19_v1, &rtw89_mac_size.ple_qt42_v2,
+			   &rtw89_mac_size.ple_qt43_v2, &rtw89_mac_size.ple_rsvd_qt9,
+			   &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
+			   &rtw89_mac_size.dle_input18},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size18_v1,
+			    &rtw89_mac_size.ple_size22_v1, &rtw89_mac_size.wde_qt3,
+			    &rtw89_mac_size.wde_qt3, &rtw89_mac_size.ple_qt5_v2,
+			    &rtw89_mac_size.ple_qt5_v2, &rtw89_mac_size.ple_rsvd_qt1,
+			    &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size2,
+			    &rtw89_mac_size.dle_input3},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const u32 rtw8922d_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_BE_H2CREG_DATA0, R_BE_H2CREG_DATA1, R_BE_H2CREG_DATA2,
+	R_BE_H2CREG_DATA3
+};
+
+static const u32 rtw8922d_c2h_regs[RTW89_H2CREG_MAX] = {
+	R_BE_C2HREG_DATA0, R_BE_C2HREG_DATA1, R_BE_C2HREG_DATA2,
+	R_BE_C2HREG_DATA3
+};
+
+static const u32 rtw8922d_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_BE_DBG_WOW, R_BE_DBG_WOW,
+};
+
+static const struct rtw89_page_regs rtw8922d_page_regs = {
+	.hci_fc_ctrl	= R_BE_HCI_FC_CTRL,
+	.ch_page_ctrl	= R_BE_CH_PAGE_CTRL,
+	.ach_page_ctrl	= R_BE_CH0_PAGE_CTRL,
+	.ach_page_info	= R_BE_CH0_PAGE_INFO,
+	.pub_page_info3	= R_BE_PUB_PAGE_INFO3,
+	.pub_page_ctrl1	= R_BE_PUB_PAGE_CTRL1,
+	.pub_page_ctrl2	= R_BE_PUB_PAGE_CTRL2,
+	.pub_page_info1	= R_BE_PUB_PAGE_INFO1,
+	.pub_page_info2 = R_BE_PUB_PAGE_INFO2,
+	.wp_page_ctrl1	= R_BE_WP_PAGE_CTRL1,
+	.wp_page_ctrl2	= R_BE_WP_PAGE_CTRL2,
+	.wp_page_info1	= R_BE_WP_PAGE_INFO1,
+};
+
+static const struct rtw89_reg_imr rtw8922d_imr_dmac_regs[] = {
+	{R_BE_HCI_BUF_IMR, B_BE_HCI_BUF_IMR_CLR, B_BE_HCI_BUF_IMR_SET},
+	{R_BE_DISP_HOST_IMR, B_BE_DISP_HOST_IMR_CLR_V1, B_BE_DISP_HOST_IMR_SET_V1},
+	{R_BE_DISP_CPU_IMR, B_BE_DISP_CPU_IMR_CLR_V1, B_BE_DISP_CPU_IMR_SET_V1},
+	{R_BE_DISP_OTHER_IMR, B_BE_DISP_OTHER_IMR_CLR_V1, B_BE_DISP_OTHER_IMR_SET_V1},
+	{R_BE_PKTIN_ERR_IMR, B_BE_PKTIN_ERR_IMR_CLR, B_BE_PKTIN_ERR_IMR_SET},
+	{R_BE_MLO_ERR_IDCT_IMR, B_BE_MLO_ERR_IDCT_IMR_CLR, B_BE_MLO_ERR_IDCT_IMR_SET},
+	{R_BE_MPDU_TX_ERR_IMR, B_BE_MPDU_TX_ERR_IMR_CLR, B_BE_MPDU_TX_ERR_IMR_SET},
+	{R_BE_MPDU_RX_ERR_IMR, B_BE_MPDU_RX_ERR_IMR_CLR, B_BE_MPDU_RX_ERR_IMR_SET},
+	{R_BE_SEC_ERROR_IMR, B_BE_SEC_ERROR_IMR_CLR, B_BE_SEC_ERROR_IMR_SET},
+	{R_BE_CPUIO_ERR_IMR, B_BE_CPUIO_ERR_IMR_CLR, B_BE_CPUIO_ERR_IMR_SET},
+	{R_BE_WDE_ERR_IMR, B_BE_WDE_ERR_IMR_CLR, B_BE_WDE_ERR_IMR_SET},
+	{R_BE_PLE_ERR_IMR, B_BE_PLE_ERR_IMR_CLR, B_BE_PLE_ERR_IMR_SET},
+	{R_BE_WDRLS_ERR_IMR, B_BE_WDRLS_ERR_IMR_CLR, B_BE_WDRLS_ERR_IMR_SET},
+	{R_BE_TXPKTCTL_B0_ERRFLAG_IMR, B_BE_TXPKTCTL_B0_ERRFLAG_IMR_CLR,
+	 B_BE_TXPKTCTL_B0_ERRFLAG_IMR_SET},
+	{R_BE_TXPKTCTL_B1_ERRFLAG_IMR, B_BE_TXPKTCTL_B1_ERRFLAG_IMR_CLR,
+	 B_BE_TXPKTCTL_B1_ERRFLAG_IMR_SET},
+	{R_BE_BBRPT_COM_ERR_IMR, B_BE_BBRPT_COM_ERR_IMR_CLR, B_BE_BBRPT_COM_ERR_IMR_SET},
+	{R_BE_BBRPT_CHINFO_ERR_IMR, B_BE_BBRPT_CHINFO_ERR_IMR_CLR,
+	 B_BE_BBRPT_CHINFO_ERR_IMR_SET},
+	{R_BE_BBRPT_DFS_ERR_IMR, B_BE_BBRPT_DFS_ERR_IMR_CLR, B_BE_BBRPT_DFS_ERR_IMR_SET},
+	{R_BE_LA_ERRFLAG_IMR, B_BE_LA_ERRFLAG_IMR_CLR, B_BE_LA_ERRFLAG_IMR_SET},
+	{R_BE_CH_INFO_DBGFLAG_IMR, B_BE_CH_INFO_DBGFLAG_IMR_CLR, B_BE_CH_INFO_DBGFLAG_IMR_SET},
+	{R_BE_PLRLS_ERR_IMR_V1, B_BE_PLRLS_ERR_IMR_V1_CLR, B_BE_PLRLS_ERR_IMR_V1_SET},
+	{R_BE_HAXI_IDCT_MSK, B_BE_HAXI_IDCT_MSK_CLR, B_BE_HAXI_IDCT_MSK_SET},
+};
+
+static const struct rtw89_imr_table rtw8922d_imr_dmac_table = {
+	.regs = rtw8922d_imr_dmac_regs,
+	.n_regs = ARRAY_SIZE(rtw8922d_imr_dmac_regs),
+};
+
+static const struct rtw89_reg_imr rtw8922d_imr_cmac_regs[] = {
+	{R_BE_RESP_IMR, B_BE_RESP_IMR_CLR_V1, B_BE_RESP_IMR_SET_V1},
+	{R_BE_RESP_IMR1, B_BE_RESP_IMR1_CLR, B_BE_RESP_IMR1_SET},
+	{R_BE_RX_ERROR_FLAG_IMR, B_BE_RX_ERROR_FLAG_IMR_CLR_V1, B_BE_RX_ERROR_FLAG_IMR_SET_V1},
+	{R_BE_TX_ERROR_FLAG_IMR, B_BE_TX_ERROR_FLAG_IMR_CLR, B_BE_TX_ERROR_FLAG_IMR_SET},
+	{R_BE_RX_ERROR_FLAG_IMR_1, B_BE_TX_ERROR_FLAG_IMR_1_CLR, B_BE_TX_ERROR_FLAG_IMR_1_SET},
+	{R_BE_PTCL_IMR1, B_BE_PTCL_IMR1_CLR, B_BE_PTCL_IMR1_SET},
+	{R_BE_PTCL_IMR0, B_BE_PTCL_IMR0_CLR, B_BE_PTCL_IMR0_SET},
+	{R_BE_PTCL_IMR_2, B_BE_PTCL_IMR_2_CLR, B_BE_PTCL_IMR_2_SET},
+	{R_BE_SCHEDULE_ERR_IMR, B_BE_SCHEDULE_ERR_IMR_CLR, B_BE_SCHEDULE_ERR_IMR_SET},
+	{R_BE_C0_TXPWR_IMR, B_BE_C0_TXPWR_IMR_CLR, B_BE_C0_TXPWR_IMR_SET},
+	{R_BE_TRXPTCL_ERROR_INDICA_MASK, B_BE_TRXPTCL_ERROR_INDICA_MASK_CLR,
+	 B_BE_TRXPTCL_ERROR_INDICA_MASK_SET},
+	{R_BE_RX_ERR_IMR, B_BE_RX_ERR_IMR_CLR, B_BE_RX_ERR_IMR_SET},
+	{R_BE_PHYINFO_ERR_IMR_V1, B_BE_PHYINFO_ERR_IMR_V1_CLR, B_BE_PHYINFO_ERR_IMR_V1_SET},
+};
+
+static const struct rtw89_imr_table rtw8922d_imr_cmac_table = {
+	.regs = rtw8922d_imr_cmac_regs,
+	.n_regs = ARRAY_SIZE(rtw8922d_imr_cmac_regs),
+};
+
+static const struct rtw89_rrsr_cfgs rtw8922d_rrsr_cfgs = {
+	.ref_rate = {R_BE_TRXPTCL_RESP_1, B_BE_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_BE_PTCL_RRSR1, B_BE_RSC_MASK, 2},
+};
+
+static const struct rtw89_rfkill_regs rtw8922d_rfkill_regs = {
+	.pinmux = {R_BE_GPIO8_15_FUNC_SEL,
+		   B_BE_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_BE_GPIO_EXT_CTRL + 2,
+		 (B_BE_GPIO_MOD_9 | B_BE_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
+static const struct rtw89_dig_regs rtw8922d_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD_BE4,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_BE4,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_BE4,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
+	.p0_lna_init = {R_PATH0_LNA_INIT_BE4, B_PATH0_LNA_INIT_IDX_BE4},
+	.p1_lna_init = {R_PATH1_LNA_INIT_BE4, B_PATH1_LNA_INIT_IDX_BE4},
+	.p0_tia_init = {R_PATH0_TIA_INIT_BE4, B_PATH0_TIA_INIT_IDX_BE4},
+	.p1_tia_init = {R_PATH1_TIA_INIT_BE4, B_PATH1_TIA_INIT_IDX_BE4},
+	.p0_rxb_init = {R_PATH0_RXIDX_INIT_BE4, B_PATH0_RXIDX_INIT_BE4},
+	.p1_rxb_init = {R_PATH1_RXIDX_INIT_BE4, B_PATH1_RXIDX_INIT_BE4},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC_BE4,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC_BE4,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC_BE4,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC_BE4,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
+static const struct rtw89_edcca_regs rtw8922d_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL_BE4,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_PPDU_LVL_BE4,
+	.ppdu_mask			= B_EDCCA_LVL_MSK1,
+	.p = {{
+		.rpt_a			= R_EDCCA_RPT_A_BE4,
+		.rpt_b			= R_EDCCA_RPT_B_BE4,
+		.rpt_sel		= R_EDCCA_RPT_SEL_BE4,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_BE4_MSK,
+	}, {
+		.rpt_a			= R_EDCCA_RPT_A_BE4_C1,
+		.rpt_b			= R_EDCCA_RPT_A_BE4_C1,
+		.rpt_sel		= R_EDCCA_RPT_SEL_BE4_C1,
+		.rpt_sel_mask		= B_EDCCA_RPT_SEL_BE4_MSK,
+	}},
+	.rpt_sel_be			= R_EDCCA_RPTREG_SEL_BE4,
+	.rpt_sel_be_mask		= B_EDCCA_RPTREG_SEL_BE_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST_BE4,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_BE_M,
+};
+
+static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
+	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
+	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
+	[RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO]	= {.offset = 0x20000, .size = 0x4800},
+	[RTW89_EFUSE_BLOCK_HCI_DIG_USB]		= {.offset = 0x30000, .size = 0x890},
+	[RTW89_EFUSE_BLOCK_HCI_PHY_PCIE]	= {.offset = 0x40000, .size = 0x400},
+	[RTW89_EFUSE_BLOCK_HCI_PHY_USB3]	= {.offset = 0x50000, .size = 0x80},
+	[RTW89_EFUSE_BLOCK_HCI_PHY_USB2]	= {.offset = 0x60000, .size = 0x50},
+	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
+};
+
+MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
+MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11be wireless 8922D driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.h b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
new file mode 100644
index 000000000000..7ef3f263274e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2026  Realtek Corporation
+ */
+
+#ifndef __RTW89_8922D_H__
+#define __RTW89_8922D_H__
+
+#include "core.h"
+
+#endif
-- 
2.25.1


