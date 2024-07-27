Return-Path: <linux-wireless+bounces-10557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76793DDC5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302612834B8
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E0941C89;
	Sat, 27 Jul 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZOVpic3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18D40875
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067639; cv=none; b=cj8aVVmPuF4HW5kvPJhPk8WFyoIkwnsvfvLGfpGEhT0S6QKlquQhtuRE28g3eRUDagWy9ZR77074i+CbOs3nq4a6d6xcQULEJFhcgwZMZfsS3ZAE2etvTGJiNBMst1vvwmuRWs3db5g/llq9l8kDMPE8Mc6WkNA6zNCmVVTwxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067639; c=relaxed/simple;
	bh=sKBrk+mUX3o/0EH4qtU/j9EfyMxGv5nvAcRjrgZEPB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXOLGh7dyhfkqgkPtELXXuXqPT/5CUvAGfWsOgKca2bkwbu3IgLjGX6xXwMMBuPH/K9g8rSCJbN+Q9AGMG5mRYhuRPk1H+i2HDiYiedt/XdFzsafgRnSVHXZz245igC8ixAaVyYsp0D8J/WR/9CRM6Yg9Q9eqQtryy4jEAnYYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZOVpic3S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87EqF41417416, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067634; bh=sKBrk+mUX3o/0EH4qtU/j9EfyMxGv5nvAcRjrgZEPB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZOVpic3SjaT/Vzas71DMDl4keR95Xp+RepnPhO4WN2te0zHPmD7RbKmuLXGa+5eZQ
	 YUAuJwSh7T29niQHT9xwKy5kROjepvgWTyeiV5e9EdQ84AgzFU5DOO7y1mlzPV9RL6
	 2bQYsQM7y7/zWfzUWS8JwcM9mF1z967tSsUSdVETHju6kzrTaMI9nC1IHemk7bZPCD
	 AtIUIXJvA8FDCFAH9Hu8f3WalvIJ7JwuhklizYuYtOYYlkS2yZ2m1GFauE32Q9s24p
	 wfLw11DtoRMX92pJHX7QmFJVa2EzzZvXvwCuRuoaUqVNjhGl1xqUb0ebLDOYMZbFa9
	 hQQOnqPyt99ew==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87EqF41417416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:13 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/7] wifi: rtw89: mcc: stop at a role holding chanctx
Date: Sat, 27 Jul 2024 16:06:45 +0800
Message-ID: <20240727080650.12195-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240727080650.12195-1-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In general, MCC (multi-channel concurrency) stops when some chanctx is
unassigned. Originally, we let FW to stop at a fixed role. However, it
might be the one to be unassigned.

So, iterate MCC roles and select one which is still holding chanctx.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 37 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.c   |  5 +--
 drivers/net/wireless/realtek/rtw89/fw.h   |  2 +-
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 3789c98de36a..0d848aef72b9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1934,22 +1934,53 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+struct rtw89_mcc_stop_sel {
+	u8 mac_id;
+	u8 slot_idx;
+};
+
+static void rtw89_mcc_stop_sel_fill(struct rtw89_mcc_stop_sel *sel,
+				    const struct rtw89_mcc_role *mcc_role)
+{
+	sel->mac_id = mcc_role->rtwvif->mac_id;
+	sel->slot_idx = mcc_role->slot_idx;
+}
+
+static int rtw89_mcc_stop_sel_iterator(struct rtw89_dev *rtwdev,
+				       struct rtw89_mcc_role *mcc_role,
+				       unsigned int ordered_idx,
+				       void *data)
+{
+	struct rtw89_mcc_stop_sel *sel = data;
+
+	if (!mcc_role->rtwvif->chanctx_assigned)
+		return 0;
+
+	rtw89_mcc_stop_sel_fill(sel, mcc_role);
+	return 1; /* break iteration */
+}
+
 static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_stop_sel sel;
 	int ret;
 
-	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC stop\n");
+	/* by default, stop at ref */
+	rtw89_mcc_stop_sel_fill(&sel, ref);
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_stop_sel_iterator, &sel);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC stop at <macid %d>\n", sel.mac_id);
 
 	if (rtw89_concurrent_via_mrc(rtwdev)) {
-		ret = rtw89_fw_h2c_mrc_del(rtwdev, mcc->group);
+		ret = rtw89_fw_h2c_mrc_del(rtwdev, mcc->group, sel.slot_idx);
 		if (ret)
 			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 				    "MRC h2c failed to trigger del: %d\n", ret);
 	} else {
 		ret = rtw89_fw_h2c_stop_mcc(rtwdev, mcc->group,
-					    ref->rtwvif->mac_id, true);
+					    sel.mac_id, true);
 		if (ret)
 			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 				    "MCC h2c failed to trigger stop: %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c83274950793..6ff7cd77a259 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7345,7 +7345,7 @@ int rtw89_fw_h2c_mrc_start(struct rtw89_dev *rtwdev,
 	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
 }
 
-int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx)
+int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx, u8 slot_idx)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
 	struct rtw89_h2c_mrc_del *h2c;
@@ -7362,7 +7362,8 @@ int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx)
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_mrc_del *)skb->data;
 
-	h2c->w0 = le32_encode_bits(sch_idx, RTW89_H2C_MRC_DEL_W0_SCH_IDX);
+	h2c->w0 = le32_encode_bits(sch_idx, RTW89_H2C_MRC_DEL_W0_SCH_IDX) |
+		  le32_encode_bits(slot_idx, RTW89_H2C_MRC_DEL_W0_STOP_SLOT_IDX);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 935f89c09054..7d48383c6244 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4499,7 +4499,7 @@ int rtw89_fw_h2c_mrc_add(struct rtw89_dev *rtwdev,
 			 const struct rtw89_fw_mrc_add_arg *arg);
 int rtw89_fw_h2c_mrc_start(struct rtw89_dev *rtwdev,
 			   const struct rtw89_fw_mrc_start_arg *arg);
-int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx);
+int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx, u8 slot_idx);
 int rtw89_fw_h2c_mrc_req_tsf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_fw_mrc_req_tsf_arg *arg,
 			     struct rtw89_mac_mrc_tsf_rpt *rpt);
-- 
2.25.1


