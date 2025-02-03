Return-Path: <linux-wireless+bounces-18281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F579A25312
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC643A2E9D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D71E5707;
	Mon,  3 Feb 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AxZmWiPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28B1E9905
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567801; cv=none; b=AI8gGjoLTLlD8X7hN7G+5Fi/PGW+IiwCjSR/ClTWk4DPk1U2aDrvFnduHgvK0cJ2Yl0ukisETEEFRYkxOG7mefXloWgQ6tk9ozCwe3YpHwSo04pTp1ef1OGNkjLEv1iEH1i1fl1LAcIdNYOzj/YT8g+9HpJog0oCu6IZoo+4bP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567801; c=relaxed/simple;
	bh=+xiO9O+Fo3Qt8U/StoIyPoEntx8j0gGpe4JLu+0drLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3H+u3MDEl8Mf+xvxLPMZ8NpwDKwWx2ropWr6MGt/EZj2peu0OMZxMjSq0mjSRsMqCPsSnsyWW996TdXjQt4Zwfkkr2hDAyAVet50HGD8oXpV4uL0Z3Xrsq3/BdMBiXqAiQhrOkfOa+FBMyY2iDT3yOHfZi/6uv5lod+pY72kA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AxZmWiPH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5137TubbE1321548, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738567796; bh=+xiO9O+Fo3Qt8U/StoIyPoEntx8j0gGpe4JLu+0drLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AxZmWiPH9KQ0tbcHPCVCI2kelp+m/zAnbzZtAwONgRyN/N3jUrHdxf+En7SFv9GWZ
	 K/xcUCRQ8seGftBE5uiZ1pdC9QNKR1IgWWn51IdvMZy5hAJmPw62M4JG+cipgr5l2/
	 m+ROXWX2Ohtl9rcElLbalpsG1IGa8RLPFVjN6EDL2EA/V5omr+H1mlEm63RQvjDj5Q
	 d/eXT7R/vbCLhb2XDJ1zB4OcNNm/uyvxlgnja2qqD7eJkpAzfdNmHL8Qg0NJDAnRss
	 DRUsMcvVgQvGnuVtLvfTLF7n1mWza2S16um4ZQuFRAKao85z9SD4z+grcTIezsn+zo
	 77z/VjDsIOU/w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5137TubbE1321548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:29:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 15:29:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 15:29:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: ps: update H2C command with more info for PS
Date: Mon, 3 Feb 2025 15:29:09 +0800
Message-ID: <20250203072911.47313-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203072911.47313-1-pkshih@realtek.com>
References: <20250203072911.47313-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Eric Huang <echuang@realtek.com>

Adding beacon BW offset, OP1dB table and rfe_type to lps_ml_cmn_info.
These information will help FW to configure RX more accurately.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  5 ++++-
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 18 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 +++++-
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ad28f11f2d24..8d5dc22fb508 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2192,8 +2192,11 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		}
 		pkt_stat->beacon_nr++;
 
-		if (phy_ppdu)
+		if (phy_ppdu) {
 			ewma_rssi_add(&rtwdev->phystat.bcn_rssi, phy_ppdu->rssi_avg);
+			if (!test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
+				rtwvif_link->bcn_bw_idx = phy_ppdu->bw_idx;
+		}
 
 		pkt_stat->beacon_rate = desc_info->data_rate;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 61fe2705cac6..b3fdd8eded21 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3501,6 +3501,7 @@ struct rtw89_vif_link {
 	u8 self_role;
 	u8 wmm;
 	u8 bcn_hit_cond;
+	u8 bcn_bw_idx;
 	u8 hit_rule;
 	u8 last_noa_nr;
 	u64 sync_bcn_tsf;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1afce0a0b905..c86a0d328435 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2795,7 +2795,9 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	static const u8 bcn_bw_ofst[] = {0, 0, 0, 3, 6, 9, 0, 12};
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_h2c_lps_ml_cmn_info *h2c;
 	struct rtw89_vif_link *rtwvif_link;
 	const struct rtw89_chan *chan;
@@ -2803,6 +2805,7 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 	u32 len = sizeof(*h2c);
 	unsigned int link_id;
 	struct sk_buff *skb;
+	u8 beacon_bw_ofst;
 	u8 gain_band;
 	u32 done;
 	u8 path;
@@ -2820,9 +2823,10 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_lps_ml_cmn_info *)skb->data;
 
-	h2c->fmt_id = 0x1;
+	h2c->fmt_id = 0x3;
 
 	h2c->mlo_dbcc_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	h2c->rfe_type = efuse->rfe_type;
 
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
 		path = rtwvif_link->phy_idx == RTW89_PHY_1 ? RF_PATH_B : RF_PATH_A;
@@ -2843,9 +2847,21 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 			h2c->tia_gain[rtwvif_link->phy_idx][i] =
 				cpu_to_le16(gain->tia_gain[gain_band][bw_idx][path][i]);
 		}
+
+		if (rtwvif_link->bcn_bw_idx < ARRAY_SIZE(bcn_bw_ofst)) {
+			beacon_bw_ofst = bcn_bw_ofst[rtwvif_link->bcn_bw_idx];
+			h2c->dup_bcn_ofst[rtwvif_link->phy_idx] = beacon_bw_ofst;
+		}
+
 		memcpy(h2c->lna_gain[rtwvif_link->phy_idx],
 		       gain->lna_gain[gain_band][bw_idx][path],
 		       LNA_GAIN_NUM);
+		memcpy(h2c->tia_lna_op1db[rtwvif_link->phy_idx],
+		       gain->tia_lna_op1db[gain_band][bw_idx][path],
+		       LNA_GAIN_NUM + 1);
+		memcpy(h2c->lna_op1db[rtwvif_link->phy_idx],
+		       gain->lna_op1db[gain_band][bw_idx][path],
+		       LNA_GAIN_NUM);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index fb107c0a29d7..994d109a9c3c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1801,7 +1801,8 @@ struct rtw89_h2c_lps_ch_info {
 
 struct rtw89_h2c_lps_ml_cmn_info {
 	u8 fmt_id;
-	u8 rsvd0[3];
+	u8 rfe_type;
+	u8 rsvd0[2];
 	__le32 mlo_dbcc_mode;
 	u8 central_ch[RTW89_PHY_NUM];
 	u8 pri_ch[RTW89_PHY_NUM];
@@ -1812,6 +1813,9 @@ struct rtw89_h2c_lps_ml_cmn_info {
 	__le16 tia_gain[RTW89_PHY_NUM][TIA_GAIN_NUM];
 	u8 lna_gain[RTW89_PHY_NUM][LNA_GAIN_NUM];
 	u8 rsvd2[2];
+	u8 tia_lna_op1db[RTW89_PHY_NUM][LNA_GAIN_NUM + 1];
+	u8 lna_op1db[RTW89_PHY_NUM][LNA_GAIN_NUM];
+	u8 dup_bcn_ofst[RTW89_PHY_NUM];
 } __packed;
 
 static inline void RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(void *cmd, u32 val)
-- 
2.25.1


