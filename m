Return-Path: <linux-wireless+bounces-36015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE4pDsk9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E964DABD6
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70069300889C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9E23EAA4;
	Wed,  6 May 2026 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XCOui7k2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174343E4BA
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073031; cv=none; b=QuhE/Drl25ZARRIlSU+UrdaN///pF85+mtdKFY3xGNZbdpwTa4bFu36DLW19wZntFeKJ+ZuWH9jVcYMwlM5hQTxbhn1NTrVCNx8p0VFwPj7nxHbrYs9v/69HcjlnI+IFj0yVpOXq35qm44epQ8BTfJs4NFo8sFrGRxTHUOnvFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073031; c=relaxed/simple;
	bh=u9/cAG9ditsL/4hBcbC5SU29HaXzuZX7awBgzwQDWQc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+SoRp4N0W6mmyI8cgbLRzMGyxL6CZWz1yS1PbgB+4ce8k0BgCAw3LnE0vGDa9/3A6ouEvUl2HxJ6ZZ723prsAVEsrIJwACB+Q6G0Y3rqvtHr0Stoaajnf4tX5iZq3Y5oojdrS9D47RKj6bUiWHOZyfq+ccPadmKMj+/myrLd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XCOui7k2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DARKV01986879, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073027; bh=9YFA4WL8T9eAQxSerUNTeLuNbiNdtac7ar+5RV+JO+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XCOui7k2h0iTOSFdLMi3U5CvlzNulfAFlhk/KQbsO/DBdWbAg6dgn6H472R/X77bx
	 9iMoRCdDnRsYljZruQp2h71WOyqdyJ2d7wX7KoPeQSJibCokaHr1sP+FvljcyuOcyr
	 5NF/ToWr/GGrMaWEC6t9nHg/nAYLPEHWvFix5nxFlpnbUHJMSJZ6JoB1cYi7cfbhEc
	 VBnn+hQAfNAzSH+LPLVyaGR5R6TVn3fkDhgA//ErCIuJVKGjK3elNG3Wtiko97iAKt
	 MkalBelWhijXIkbs3eejD38CSs+dLkYe8iRmgXNKl+Un5BHvXI7vVUM6H7YaNBrDDW
	 AsmIdK5tp/LDw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DARKV01986879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:27 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:27 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:27 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 05/14] wifi: rtw89: phy: enable IE-09/IE-10 PHY status report for monitor mode
Date: Wed, 6 May 2026 21:09:51 +0800
Message-ID: <20260506131000.1706298-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: E9E964DABD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36015-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

The IE-09/IE-10 of PHY status contain SIG-A/SIG-B respectively, so enable
them in monitor mode to have rich information. If the parser detects
length invalid, ignore to reference IE-09/IE-10 to prevent accessing out
of range.

The RTL8922D is generation 2 of PHY status, which doesn't report SIG-B by
IE-10, so not enable it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 43 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  6 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++
 drivers/net/wireless/realtek/rtw89/phy.c      | 17 +++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |  9 ++++
 6 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index caedb2bd21d5..f877c2707c84 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2152,14 +2152,38 @@ static void rtw89_core_parse_phy_status_ie00_v2(struct rtw89_dev *rtwdev,
 		rpl_path[i] = tmp_rpl[i] >> 1;
 }
 
+static void rtw89_core_parse_phy_status_ie09(struct rtw89_dev *rtwdev,
+					     const struct rtw89_phy_sts_iehdr *iehdr,
+					     struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	phy_ppdu->ie09 = (const void *)iehdr;
+}
+
+static void rtw89_core_parse_phy_status_ie10(struct rtw89_dev *rtwdev,
+					     const struct rtw89_phy_sts_iehdr *iehdr,
+					     struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	phy_ppdu->ie10 = (const void *)iehdr;
+}
+
 static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev,
 					    const struct rtw89_phy_sts_iehdr *iehdr,
 					    struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
+	bool accept;
 	u8 ie;
 
 	ie = le32_get_bits(iehdr->w0, RTW89_PHY_STS_IEHDR_TYPE);
 
+	/*
+	 * For normal mode, only parse ppdu_sts that are A1-matched, except for
+	 * scanning that needs to get chan_idx in IE01.
+	 */
+	accept = phy_ppdu->to_self || ie == RTW89_PHYSTS_IE01_CMN_OFDM ||
+		 rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR;
+	if (!accept)
+		return 0;
+
 	switch (ie) {
 	case RTW89_PHYSTS_IE00_CMN_CCK:
 		rtw89_core_parse_phy_status_ie00(rtwdev, iehdr, phy_ppdu);
@@ -2169,6 +2193,12 @@ static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev,
 	case RTW89_PHYSTS_IE01_CMN_OFDM:
 		rtw89_core_parse_phy_status_ie01(rtwdev, iehdr, phy_ppdu);
 		break;
+	case RTW89_PHYSTS_IE09_FTR_0:
+		rtw89_core_parse_phy_status_ie09(rtwdev, iehdr, phy_ppdu);
+		break;
+	case RTW89_PHYSTS_IE10_FTR_PLCP_EXT:
+		rtw89_core_parse_phy_status_ie10(rtwdev, iehdr, phy_ppdu);
+		break;
 	default:
 		break;
 	}
@@ -2228,11 +2258,14 @@ static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
 static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 				       struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
-	u16 ie_len;
 	void *pos, *end;
+	bool accept;
+	u16 ie_len;
 
-	/* mark invalid reports and bypass them */
-	if (phy_ppdu->ie < RTW89_CCK_PKT)
+	/* for normal mode, mark invalid reports and bypass them */
+	accept = phy_ppdu->ie >= RTW89_CCK_PKT ||
+		 rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR;
+	if (!accept)
 		return -EINVAL;
 
 	pos = phy_ppdu->buf + PHY_STS_HDR_LEN;
@@ -2246,6 +2279,10 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 		rtw89_core_process_phy_status_ie(rtwdev, iehdr, phy_ppdu);
 		pos += ie_len;
 		if (pos > end || ie_len == 0) {
+			/* clear pointers to prevent accessing out of IE */
+			phy_ppdu->ie09 = NULL;
+			phy_ppdu->ie10 = NULL;
+
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 				    "phy status parse failed\n");
 			return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 66dbb1fc3ca8..ca716e95cb2c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -24,6 +24,8 @@ struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
 struct rtw89_phy_calc_efuse_gain;
+struct rtw89_phy_sts_ie09;
+struct rtw89_phy_sts_ie10;
 struct rtw89_debugfs;
 struct rtw89_regd_data;
 struct rtw89_wow_cam_info;
@@ -840,7 +842,7 @@ struct rtw89_rx_phy_ppdu {
 	u8 mac_id;
 	u8 chan_idx;
 	u8 phy_idx;
-	u8 ie;
+	u8 ie; /* enum rtw89_phy_status_bitmap */
 	u16 rate;
 	u8 rpl_avg;
 	u8 rpl_path[RF_PATH_MAX];
@@ -862,6 +864,8 @@ struct rtw89_rx_phy_ppdu {
 	bool to_self;
 	bool valid;
 	bool hdr_2_en;
+	const struct rtw89_phy_sts_ie09 *ie09; /* SIG-A */
+	const struct rtw89_phy_sts_ie10 *ie10; /* SIG-B */
 };
 
 enum rtw89_mac_idx {
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 2c6711133c80..330ece51286d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -98,6 +98,9 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 	    !rtwdev->scanning)
 		rtw89_enter_ips(rtwdev);
 
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR)
+		rtw89_physts_parsing_init(rtwdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 4f82b1a9fa4c..15483a86951d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -7085,10 +7085,21 @@ static void rtw89_physts_enable_hdr_2(struct rtw89_dev *rtwdev, enum rtw89_phy_i
 static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 monitor_mode_mu_ies = 0;
+	u32 monitor_mode_su_ies = 0;
 	u32 val;
 	u8 i;
 
+	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR) {
+		monitor_mode_mu_ies = BIT(RTW89_PHYSTS_IE09_FTR_0);
+		if (phy->physt_gen < 2)
+			monitor_mode_mu_ies |= BIT(RTW89_PHYSTS_IE10_FTR_PLCP_EXT);
+
+		monitor_mode_su_ies = BIT(RTW89_PHYSTS_IE09_FTR_0);
+	}
+
 	rtw89_physts_enable_fail_report(rtwdev, false, phy_idx);
 
 	/* enable hdr_2 for 8922D (PHYSTS_BE_GEN2 above) */
@@ -7102,6 +7113,7 @@ static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 		val = rtw89_physts_get_ie_bitmap(rtwdev, i, phy_idx);
 		if (i == RTW89_HE_MU || i == RTW89_VHT_MU) {
 			val |= BIT(RTW89_PHYSTS_IE13_DL_MU_DEF);
+			val |= monitor_mode_mu_ies;
 		} else if (i == RTW89_TRIG_BASE_PPDU) {
 			val |= BIT(RTW89_PHYSTS_IE13_DL_MU_DEF) |
 			       BIT(RTW89_PHYSTS_IE01_CMN_OFDM);
@@ -7115,11 +7127,14 @@ static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 				val |= BIT(RTW89_PHYSTS_IE20_DBG_OFDM_FD_USER_SEG_0);
 		}
 
+		if (i == RTW89_HE_PKT || i == RTW89_VHT_PKT)
+			val |= monitor_mode_su_ies;
+
 		rtw89_physts_set_ie_bitmap(rtwdev, i, val, phy_idx);
 	}
 }
 
-static void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
+void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
 {
 	__rtw89_physts_parsing_init(rtwdev, RTW89_PHY_0);
 	if (rtwdev->dbcc_en)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d8038ae5ca86..74fbf5baff58 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -914,6 +914,7 @@ void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
 void rtw89_phy_dm_reinit(struct rtw89_dev *rtwdev);
 void rtw89_phy_dm_init_data(struct rtw89_dev *rtwdev);
+void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev);
 void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
 void rtw89_phy_write32_idx_set(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 125ba2a9f145..18fe6d3d0f83 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -658,6 +658,15 @@ struct rtw89_phy_sts_ie01_v2 {
 #define RTW89_PHY_STS_IE01_V2_W9_RPL_FD_C GENMASK(11, 4)
 #define RTW89_PHY_STS_IE01_V2_W9_RPL_FD_D GENMASK(23, 16)
 
+struct rtw89_phy_sts_ie09 {
+	__le64 qw0;
+} __packed;
+
+struct rtw89_phy_sts_ie10 {
+	__le64 qw0;
+	u8 sigb[];
+} __packed;
+
 enum rtw89_tx_channel {
 	RTW89_TXCH_ACH0	= 0,
 	RTW89_TXCH_ACH1	= 1,
-- 
2.25.1


