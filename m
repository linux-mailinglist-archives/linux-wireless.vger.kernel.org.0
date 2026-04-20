Return-Path: <linux-wireless+bounces-35002-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJMmEoqg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35002-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C9426956
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 846EE3004F28
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0AD3112BD;
	Mon, 20 Apr 2026 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DPoyW/aE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4637FF41
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656521; cv=none; b=Je2O79xryJdwTPGIhohIkxnvW7ttDpv03dZ1ur48pDCklokGdTvcV8uaTegoQXh1LAoPOidjTvw7VlRCwNguxBXvcVhpXFTtQ7lLGHB/d/0be4rsWMixIS1GG7/oKo5riyKKyF3ZcMhF2E6O99CtOQ4xJcZw4F8f4yai4bcbVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656521; c=relaxed/simple;
	bh=i5Vp870J+9f1XSIGkXUyO96aEd1hX649SntwsjykAGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbFqnYviMGWyKGD33Gdf3Ht5Hy5glrHdYGpRUeFD7yMEMBzj5s/qFO5TQn2Sxr793CWPjU08kgn4oH1ZuWBgYoAjM4YHzrOwhoCqX70KAvWjrKXuroPWBqPoD/EDSm2H5ZpAgkyBM0z9w7OAB9Bdtm/v2ZqEbeM0a4S6OzeaotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DPoyW/aE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3fuPdB426983, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656516; bh=+BjASEJOuljQ9W9Wfj42VKoG8frnCi8EJaVviDjxC7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DPoyW/aE1QHOcGM1IW8/2lq/x6SNHcNW1/Ik3hR8j/VH0M0Oa+0ednVAV/DY63u+G
	 uK2d944ZxooP81I1156ne/+zqwIhXv0rupcbS9IitKOWCONZOxLdDDmqgUrMo4f0Hf
	 j9uqfk9wPEt166Pm33XibKN3gJ2D7VLbkGHiOqaq5J3KEg2XVVruF5Fw/d35v/HnnJ
	 n6blir1q/8Neg3SRP7ZNsmkLBck0EjbKGoZ0Ug1VlrAW4somVqZ9fc2BfbGJrXEqTC
	 ZRlpIo1yQ1PiYFzu7Owvp9LqZQarA/6zs77y5Ea1pyNl8aTe36NFk13etbskv2GXaY
	 SKTiJi5kihTdw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3fuPdB426983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 09/16] wifi: rtw89: offload DMAC and CMAC init IO to firmware
Date: Mon, 20 Apr 2026 11:40:44 +0800
Message-ID: <20260420034051.17666-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-35002-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 232C9426956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yuan Li <leo.li@realtek.com>

During the initialization of DMAC and CMAC, the driver performs a
large number of consecutive register writes. Sending these I/O
requests individually over the host interface introduces significant
latency and delays the device bring-up process.

Optimize the initialization flow by wrapping the register write
sequences in mac.c and mac_be.c with rtw89_io_pack() and
rtw89_io_unpack(). This batches the operations and offloads them
to the firmware via H2C commands, which significantly accelerates
the overall initialization time.
(8852C USB2.0 AMD B450 1379 ms -> 1273 ms)

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 53 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 57 ++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 54aad37485d6..aac14d768bc3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2300,6 +2300,8 @@ static int preload_init_set_ax(struct rtw89_dev *rtwdev, u8 mac_idx,
 {
 	u32 reg, max_preld_size, min_rsvd_size;
 
+	rtw89_io_pack(rtwdev);
+
 	max_preld_size = (mac_idx == RTW89_MAC_0 ?
 			  PRELD_B0_ENT_NUM : PRELD_B1_ENT_NUM) * PRELD_AMSDU_SIZE;
 	reg = mac_idx == RTW89_MAC_0 ?
@@ -2313,6 +2315,8 @@ static int preload_init_set_ax(struct rtw89_dev *rtwdev, u8 mac_idx,
 	rtw89_write32_mask(rtwdev, reg, B_AX_B0_PRELD_NXT_TXENDWIN_MASK, PRELD_NEXT_WND);
 	rtw89_write32_mask(rtwdev, reg, B_AX_B0_PRELD_NXT_RSVMINSZ_MASK, min_rsvd_size);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2392,11 +2396,15 @@ static int sta_sch_init_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	rtw89_io_pack(rtwdev);
+
 	rtw89_write32_set(rtwdev, R_AX_SS_CTRL, B_AX_SS_WARM_INIT_FLG);
 	rtw89_write32_clr(rtwdev, R_AX_SS_CTRL, B_AX_SS_NONEMPTY_SS2FINFO_EN);
 
 	_patch_ss2f_path(rtwdev);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2408,12 +2416,16 @@ static int mpdu_proc_init_ax(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	rtw89_write32(rtwdev, R_AX_ACTION_FWD0, TRXCFG_MPDU_PROC_ACT_FRWD);
 	rtw89_write32(rtwdev, R_AX_TF_FWD, TRXCFG_MPDU_PROC_TF_FRWD);
 	rtw89_write32_set(rtwdev, R_AX_MPDU_PROC,
 			  B_AX_APPEND_FCS | B_AX_A_ICV_ERR);
 	rtw89_write32(rtwdev, R_AX_CUT_AMSDU_CTRL, TRXCFG_MPDU_PROC_CUT_CTRL);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2427,6 +2439,8 @@ static int sec_eng_init_ax(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	val = rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL);
 	/* init clock */
 	val |= (B_AX_CLK_EN_CGCMP | B_AX_CLK_EN_WAPI | B_AX_CLK_EN_WEP_TKIP);
@@ -2452,6 +2466,8 @@ static int sec_eng_init_ax(struct rtw89_dev *rtwdev)
 		rtw89_write32_mask(rtwdev, R_AX_SEC_DEBUG1,
 				   B_AX_TX_TIMEOUT_SEL_MASK, AX_TX_TO_VAL);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2535,6 +2551,8 @@ static int scheduler_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PREBKF_CFG_1, mac_idx);
 	if (rtwdev->chip->chip_id == RTL8852C)
 		rtw89_write32_mask(rtwdev, reg, B_AX_SIFS_MACTXEN_T1_MASK,
@@ -2563,6 +2581,8 @@ static int scheduler_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 				   SCH_PREBKF_24US);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2631,6 +2651,8 @@ static int rx_fltr_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	for (i = RTW89_MGNT; i <= RTW89_DATA; i++) {
 		ret = rtw89_mac_typ_fltr_opt_ax(rtwdev, i, RTW89_FWD_TO_HOST,
 						mac_idx);
@@ -2647,6 +2669,8 @@ static int rx_fltr_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write16(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_PLCP_HDR_FLTR, mac_idx),
 		      plcp_ftlr);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2693,6 +2717,8 @@ static int cca_ctrl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CCA_CONTROL, mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val |= (B_AX_TB_CHK_BASIC_NAV | B_AX_TB_CHK_BTCCA |
@@ -2713,16 +2739,22 @@ static int cca_ctrl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	_patch_dis_resp_chk(rtwdev, mac_idx);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
 static int nav_ctrl_init_ax(struct rtw89_dev *rtwdev)
 {
+	rtw89_io_pack(rtwdev);
+
 	rtw89_write32_set(rtwdev, R_AX_WMAC_NAV_CTL, B_AX_WMAC_PLCP_UP_NAV_EN |
 						     B_AX_WMAC_TF_UP_NAV_EN |
 						     B_AX_WMAC_NAV_UPPER_EN);
 	rtw89_write32_mask(rtwdev, R_AX_WMAC_NAV_CTL, B_AX_WMAC_NAV_UPPER_MASK, NAV_25MS);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2734,12 +2766,17 @@ static int spatial_reuse_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 	if (ret)
 		return ret;
+
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_SR_CTRL, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_AX_SR_EN);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BSSID_SRC_CTRL, mac_idx);
 	rtw89_write8_set(rtwdev, reg, B_AX_PLCP_SRC_EN);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2752,6 +2789,8 @@ static int tmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MAC_LOOPBACK, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_AX_MACLBK_EN);
 
@@ -2762,6 +2801,8 @@ static int tmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write32_mask(rtwdev, reg, B_AX_TXDFIFO_HIGH_MCS_THRE_MASK, TXDFIFO_HIGH_MCS_THRE);
 	rtw89_write32_mask(rtwdev, reg, B_AX_TXDFIFO_LOW_MCS_THRE_MASK, TXDFIFO_LOW_MCS_THRE);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2776,6 +2817,8 @@ static int trxptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_0, mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val &= ~B_AX_WMAC_SPEC_SIFS_CCK_MASK;
@@ -2806,6 +2849,8 @@ static int trxptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, rrsr->rsc.addr, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, rrsr->rsc.mask, rrsr->rsc.data);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -2840,6 +2885,8 @@ static int rmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	if (mac_idx == RTW89_MAC_0)
 		rst_bacam(rtwdev);
 
@@ -2881,6 +2928,8 @@ static int rmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PLCP_HDR_FLTR, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_AX_VHT_SU_SIGB_CRC_CHK);
 
+	rtw89_io_unpack(rtwdev);
+
 	return ret;
 }
 
@@ -2932,6 +2981,8 @@ static int ptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_SIFS_SETTING, mac_idx);
 		val = rtw89_read32(rtwdev, reg);
@@ -2969,6 +3020,8 @@ static int ptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 				   B_AX_AMPDU_MAX_LEN_VHT_MASK, 0x3FF80);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 39a28fd27412..a0fa8e059739 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1000,6 +1000,8 @@ static int mpdu_proc_init_be(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	rtw89_write32_set(rtwdev, R_BE_MPDU_PROC, B_BE_APPEND_FCS);
 	rtw89_write32(rtwdev, R_BE_CUT_AMSDU_CTRL, TRXCFG_MPDU_PROC_CUT_CTRL |
 						   B_BE_CA_CHK_ADDRCAM_EN);
@@ -1019,6 +1021,8 @@ static int mpdu_proc_init_be(struct rtw89_dev *rtwdev)
 	val32 = u32_replace_bits(val32, 1, B_BE_FWD_WLAN_CPU_TYPE_1_MASK);
 	rtw89_write32(rtwdev, R_BE_DISP_FWD_WLAN_0, val32);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1031,6 +1035,8 @@ static int sec_eng_init_be(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	val32 = rtw89_read32(rtwdev, R_BE_SEC_ENG_CTRL);
 	val32 |= B_BE_CLK_EN_CGCMP | B_BE_CLK_EN_WAPI | B_BE_CLK_EN_WEP_TKIP |
 		 B_BE_SEC_TX_ENC | B_BE_SEC_RX_DEC |
@@ -1041,6 +1047,8 @@ static int sec_eng_init_be(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_set(rtwdev, R_BE_SEC_MPDU_PROC, B_BE_APPEND_ICV | B_BE_APPEND_MIC);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1083,13 +1091,16 @@ static int mlo_init_be(struct rtw89_dev *rtwdev)
 	u32 reg;
 	int ret;
 
-	val32 = rtw89_read32(rtwdev, R_BE_MLO_INIT_CTL);
+	rtw89_io_pack(rtwdev);
 
+	val32 = rtw89_read32(rtwdev, R_BE_MLO_INIT_CTL);
 	val32 |= B_BE_MLO_TABLE_REINIT;
 	rtw89_write32(rtwdev, R_BE_MLO_INIT_CTL, val32);
 	val32 &= ~B_BE_MLO_TABLE_REINIT;
 	rtw89_write32(rtwdev, R_BE_MLO_INIT_CTL, val32);
 
+	rtw89_io_unpack(rtwdev);
+
 	ret = read_poll_timeout_atomic(rtw89_read32, val32,
 				       val32 & B_BE_MLO_TABLE_INIT_DONE,
 				       1, 1000, false, rtwdev, R_BE_MLO_INIT_CTL);
@@ -1101,9 +1112,13 @@ static int mlo_init_be(struct rtw89_dev *rtwdev)
 	else
 		reg = R_BE_SS_CTRL_V1;
 
+	rtw89_io_pack(rtwdev);
+
 	rtw89_write32_set(rtwdev, reg, B_BE_MLO_HW_CHGLINK_EN);
 	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_ACQCHK_CFG_0, B_BE_R_MACID_ACQ_CHK_EN);
 
+	rtw89_io_unpack(rtwdev);
+
 	return ret;
 }
 
@@ -1173,6 +1188,8 @@ static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	if (chip->chip_id == RTL8922D) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SCH_EXT_CTRL, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_BE_CWCNT_PLUS_MODE);
@@ -1216,6 +1233,8 @@ static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_set(rtwdev, reg, B_BE_TX_NAV_RST_EDCA_EN);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1292,6 +1311,8 @@ static int rx_fltr_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	u32 reg;
 	u32 val;
 
+	rtw89_io_pack(rtwdev);
+
 	rtw89_mac_typ_fltr_opt_be(rtwdev, RTW89_MGNT, RTW89_FWD_TO_HOST, mac_idx);
 	rtw89_mac_typ_fltr_opt_be(rtwdev, RTW89_CTRL, RTW89_FWD_TO_HOST, mac_idx);
 	rtw89_mac_typ_fltr_opt_be(rtwdev, RTW89_DATA, RTW89_FWD_TO_HOST, mac_idx);
@@ -1309,6 +1330,8 @@ static int rx_fltr_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	      B_BE_LSIG_PARITY_CHK_EN | B_BE_CCK_SIG_CHK | B_BE_CCK_CRC_CHK;
 	rtw89_write16(rtwdev, reg, val);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1322,6 +1345,8 @@ static int nav_ctrl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	u32 val32;
 	u32 reg;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_NAV_CTL, mac_idx);
 
 	val32 = rtw89_read32(rtwdev, reg);
@@ -1337,6 +1362,8 @@ static int nav_ctrl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_BE_WMAC_MBA_DUR_FORCE);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1349,12 +1376,16 @@ static int spatial_reuse_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_SR_CTRL, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_BE_SR_EN | B_BE_SR_CTRL_PLCP_EN);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_BSSID_SRC_CTRL, mac_idx);
 	rtw89_write8_set(rtwdev, reg, B_BE_PLCP_SRC_EN);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1364,6 +1395,8 @@ static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u32 reg;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TB_PPDU_CTRL, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_BE_QOSNULL_UPD_MUEDCA_EN);
 
@@ -1378,6 +1411,8 @@ static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_clr(rtwdev, reg, CLEAR_DTOP_DIS);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1394,6 +1429,8 @@ static int trxptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MAC_LOOPBACK, mac_idx);
 	val32 = rtw89_read32(rtwdev, reg);
 	val32 = u32_replace_bits(val32, S_BE_MACLBK_PLCP_DLY_DEF,
@@ -1453,6 +1490,8 @@ static int trxptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_mask(rtwdev, reg, B_BE_RSC_MASK, 1);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1495,6 +1534,8 @@ static int rmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 			return ret;
 	}
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_DLK_PROTECT_CTL, mac_idx);
 	val16 = rtw89_read16(rtwdev, reg);
 	val16 = u16_replace_bits(val16, TRXCFG_RMAC_DATA_TO, B_BE_RX_DLK_DATA_TIME_MASK);
@@ -1534,6 +1575,8 @@ static int rmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_set(rtwdev, reg, B_BE_DIS_CHK_MIN_LEN);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1555,10 +1598,14 @@ static int resp_pktctl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 	}
 
+	rtw89_io_pack(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RESP_CSI_RESERVED_PAGE, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_START_PAGE_MASK, qt_cfg.pktid);
 	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num + 1);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1602,6 +1649,8 @@ static int ptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	rtw89_io_pack(rtwdev);
+
 	if (is_qta_poh(rtwdev)) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SIFS_SETTING, mac_idx);
 		val32 = rtw89_read32(rtwdev, reg);
@@ -1671,6 +1720,8 @@ static int ptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 					       B_BE_PRELD_HIQ_P0_EN);
 	}
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
@@ -1965,6 +2016,8 @@ static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 	if (!(chip->chip_id == RTL8922A || rtw89_mac_chk_preload_allow(rtwdev)))
 		return 0;
 
+	rtw89_io_pack(rtwdev);
+
 	max_preld_size = mac_idx == RTW89_MAC_0 ?
 			 PRELD_B0_ENT_NUM : PRELD_B1_ENT_NUM;
 	if (chip->chip_id == RTL8922D)
@@ -1997,6 +2050,8 @@ static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 	val32 |= B_BE_B0_PRELD_FEN;
 	rtw89_write32(rtwdev, reg, val32);
 
+	rtw89_io_unpack(rtwdev);
+
 	return 0;
 }
 
-- 
2.25.1


