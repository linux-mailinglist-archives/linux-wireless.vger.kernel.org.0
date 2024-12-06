Return-Path: <linux-wireless+bounces-15950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37F9E670C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B41885737
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF01198A0F;
	Fri,  6 Dec 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rXNPg5cY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5E1BC9F6
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464669; cv=none; b=g8HAtPcANCfUT5ulhhtDtDxFHFGuNvxAdmGB9WjEhrzzEoRvTCsH+k9Tubj9RPAxUvqxLeGv3kzh7IAHPSM4q6umBOQd3J77w7cASU/sFPwfe2HTJwZ5ULgrKP+1QWrrhSwLI/e5de0nIwV4PacnHDQ4nvOAFMJ5fvSvjqx1sRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464669; c=relaxed/simple;
	bh=d3jgKMbqnUoenwxhk456Eil/bTB2f+ckqYhqtXWxVHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxkgMMbM+YepxQNHKvTNtOfK4WuIKgq+VqFJsRP7OVcCE4w40Ze4PVzFTtzDxgVMGeTBdEvomdPtDC4GSSkJTYB0MNTp+Bg0f8Cmnl5wBBvR7p1OqO+ftsblTdWLarJkPHS/+K6NrrkeOmwXlDEei+37d88JPOr8n2r6ZwwoW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rXNPg5cY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65vihC74127282, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464664; bh=d3jgKMbqnUoenwxhk456Eil/bTB2f+ckqYhqtXWxVHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rXNPg5cY0VF4nb5nt2vE7cH9cKBV0GXlmvNS3wBPbe+rca9yuLdEuEB2knVsKZpPl
	 VCKVWXAJqN+Td+OSaSyS0UpfvmoD0akaikiUyxJ/j1oY+BZjdH3M5JJq6wq2RLVOtQ
	 EyPz2LHHQtNKEuzkQucL+XDCKrJsoayOLBhZ1rYSMNxeuuAvdbiOndO6TY4gkCWLBj
	 VAHCU35fVIv+AtJc097VZ4PZu7uNhk9g3goN3iV0Fan3wcoSiI8UUNdnOPRPsiRaSq
	 hXF44vFYbwdb8erQICV5gtKAW2c1Q++2ecyvVZaEjScKAc/6VdDxKMhf+GfZV5oLeh
	 0IPrKxyzegJ2w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65vihC74127282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 2/7] wifi: rtw89: ps: refactor channel info to firmware before entering PS
Date: Fri, 6 Dec 2024 13:57:11 +0800
Message-ID: <20241206055716.18598-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
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

In PS mode, firmware needs hardware parameters related to channel info
to configure hardware itself. Before entering PS, driver prepares these
info to firmware via firmware H2C command.

Since firmware only consider PS for single one vif, change the argument
of entry function to rtwvif, and only consider first link for this old
H2C command that only support legacy.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 35 +++++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h |  3 +--
 drivers/net/wireless/realtek/rtw89/ps.c |  3 ++-
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c604ea1d39f1..d17c6037c9a6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2594,14 +2594,17 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif_link->chanctx_idx);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_chan *chan;
+	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_h2c_lps_ch_info *h2c;
 	u32 len = sizeof(*h2c);
+	unsigned int link_id;
 	struct sk_buff *skb;
+	bool no_chan = true;
+	u8 phy_idx;
 	u32 done;
 	int ret;
 
@@ -2616,11 +2619,27 @@ int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_lps_ch_info *)skb->data;
 
-	h2c->info[0].central_ch = chan->channel;
-	h2c->info[0].pri_ch = chan->primary_channel;
-	h2c->info[0].band = chan->band_type;
-	h2c->info[0].bw = chan->band_width;
-	h2c->mlo_dbcc_mode_lps = cpu_to_le32(MLO_2_PLUS_0_1RF);
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		phy_idx = rtwvif_link->phy_idx;
+		if (phy_idx >= ARRAY_SIZE(h2c->info))
+			continue;
+
+		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+		no_chan = false;
+
+		h2c->info[phy_idx].central_ch = chan->channel;
+		h2c->info[phy_idx].pri_ch = chan->primary_channel;
+		h2c->info[phy_idx].band = chan->band_type;
+		h2c->info[phy_idx].bw = chan->band_width;
+	}
+
+	if (no_chan) {
+		rtw89_err(rtwdev, "no chan for h2c lps_ch_info\n");
+		ret = -ENOENT;
+		goto fail;
+	}
+
+	h2c->mlo_dbcc_mode_lps = cpu_to_le32(rtwdev->mlo_dbcc_mode);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_DM,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 95681c390bb8..b38705868caa 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4638,8 +4638,7 @@ int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
 
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
-int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif_link *rtwvif_link);
+int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       bool enable);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(struct rtw89_dev *rtwdev, u32 len);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 5e3a5e3c9776..a8b4b9095dc8 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -93,7 +93,6 @@ static void __rtw89_enter_lps_link(struct rtw89_dev *rtwdev,
 
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_FW_CTRL);
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
-	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif_link);
 }
 
 static void __rtw89_leave_lps(struct rtw89_dev *rtwdev,
@@ -137,6 +136,8 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			can_ps_mode = false;
 	}
 
+	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
+
 	if (ps_mode && can_ps_mode)
 		__rtw89_enter_ps_mode(rtwdev);
 }
-- 
2.25.1


