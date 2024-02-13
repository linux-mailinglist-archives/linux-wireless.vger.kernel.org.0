Return-Path: <linux-wireless+bounces-3510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86C852A25
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C059C1C2112E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD9224D2;
	Tue, 13 Feb 2024 07:36:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE493224CF
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809786; cv=none; b=gr9/88j3P9VZGxww+mYzUNn7NK2VYupphJtql/kMDr+byVUjbMqK4mBWTdtHyTTubLTT9YIjS1semfkInhdW7Z6bDJ37zMJ601xaak3M0wgUd06ukKydqnLrxW4dmIyOmPojJonDi1oqJJY75zzT8o8lOonowE3+bc8Y3WgG8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809786; c=relaxed/simple;
	bh=u+0ZKr5gKUH04lIPfnMHy4/jB1NOmF+mCsSQ0W1qmo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6JihNxz/4bhYSXI22IQ9WB5Vsay3G3nfk+r9JH9izJEfGPXxOXVeSrqlcd5WdaGaop9U+CyzR6RjtHJyXNOAkxzdlISohPJBYzgFm6T2Ksme+XIiEAIY1ZfTZXPUaNZ9GI5TE8yEziw3GWOH75/IG7BYzoC7HAx1ErjZ6xyK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41D7aHxL51671708, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41D7aHxL51671708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:36:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 13 Feb 2024 15:36:17 +0800
Received: from [127.0.1.1] (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 Feb
 2024 15:36:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: fw: implement MRC H2C command functions
Date: Tue, 13 Feb 2024 15:35:12 +0800
Message-ID: <20240213073514.23796-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213073514.23796-1-pkshih@realtek.com>
References: <20240213073514.23796-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Implement MRC (multiple role concurrent) H2C commands. Mainly deal with
H2C format, LE type built from CPU value, default setting on some fields,
and then sending the command to FW. Besides, MRC start, MRC delete, and
MRC request TSF need to wait for a report from C2H events.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 366 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  94 ++++++
 2 files changed, 460 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 540ea16f048e..2ab45d0878f7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6669,6 +6669,372 @@ int rtw89_fw_h2c_mcc_set_duration(struct rtw89_dev *rtwdev,
 	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
 }
 
+static
+u32 rtw89_fw_h2c_mrc_add_slot(struct rtw89_dev *rtwdev,
+			      const struct rtw89_fw_mrc_add_slot_arg *slot_arg,
+			      struct rtw89_h2c_mrc_add_slot *slot_h2c)
+{
+	bool fill_h2c = !!slot_h2c;
+	unsigned int i;
+
+	if (!fill_h2c)
+		goto calc_len;
+
+	slot_h2c->w0 = le32_encode_bits(slot_arg->duration,
+					RTW89_H2C_MRC_ADD_SLOT_W0_DURATION) |
+		       le32_encode_bits(slot_arg->courtesy_en,
+					RTW89_H2C_MRC_ADD_SLOT_W0_COURTESY_EN) |
+		       le32_encode_bits(slot_arg->role_num,
+					RTW89_H2C_MRC_ADD_SLOT_W0_ROLE_NUM);
+	slot_h2c->w1 = le32_encode_bits(slot_arg->courtesy_period,
+					RTW89_H2C_MRC_ADD_SLOT_W1_COURTESY_PERIOD) |
+		       le32_encode_bits(slot_arg->courtesy_target,
+					RTW89_H2C_MRC_ADD_SLOT_W1_COURTESY_TARGET);
+
+	for (i = 0; i < slot_arg->role_num; i++) {
+		slot_h2c->roles[i].w0 =
+			le32_encode_bits(slot_arg->roles[i].macid,
+					 RTW89_H2C_MRC_ADD_ROLE_W0_MACID) |
+			le32_encode_bits(slot_arg->roles[i].role_type,
+					 RTW89_H2C_MRC_ADD_ROLE_W0_ROLE_TYPE) |
+			le32_encode_bits(slot_arg->roles[i].is_master,
+					 RTW89_H2C_MRC_ADD_ROLE_W0_IS_MASTER) |
+			le32_encode_bits(slot_arg->roles[i].en_tx_null,
+					 RTW89_H2C_MRC_ADD_ROLE_W0_TX_NULL_EN) |
+			le32_encode_bits(false,
+					 RTW89_H2C_MRC_ADD_ROLE_W0_IS_ALT_ROLE) |
+			le32_encode_bits(false,
+					 RTW89_H2C_MRC_ADD_ROLE_W0_ROLE_ALT_EN);
+		slot_h2c->roles[i].w1 =
+			le32_encode_bits(slot_arg->roles[i].central_ch,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_CENTRAL_CH_SEG) |
+			le32_encode_bits(slot_arg->roles[i].primary_ch,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_PRI_CH) |
+			le32_encode_bits(slot_arg->roles[i].bw,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_BW) |
+			le32_encode_bits(slot_arg->roles[i].band,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_CH_BAND_TYPE) |
+			le32_encode_bits(slot_arg->roles[i].null_early,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_NULL_EARLY) |
+			le32_encode_bits(false,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_RFK_BY_PASS) |
+			le32_encode_bits(true,
+					 RTW89_H2C_MRC_ADD_ROLE_W1_CAN_BTC);
+		slot_h2c->roles[i].macid_main_bitmap =
+			cpu_to_le32(slot_arg->roles[i].macid_main_bitmap);
+		slot_h2c->roles[i].macid_paired_bitmap =
+			cpu_to_le32(slot_arg->roles[i].macid_paired_bitmap);
+	}
+
+calc_len:
+	return struct_size(slot_h2c, roles, slot_arg->role_num);
+}
+
+int rtw89_fw_h2c_mrc_add(struct rtw89_dev *rtwdev,
+			 const struct rtw89_fw_mrc_add_arg *arg)
+{
+	struct rtw89_h2c_mrc_add *h2c_head;
+	struct sk_buff *skb;
+	unsigned int i;
+	void *tmp;
+	u32 len;
+	int ret;
+
+	len = sizeof(*h2c_head);
+	for (i = 0; i < arg->slot_num; i++)
+		len += rtw89_fw_h2c_mrc_add_slot(rtwdev, &arg->slots[i], NULL);
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc add\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	tmp = skb->data;
+
+	h2c_head = tmp;
+	h2c_head->w0 = le32_encode_bits(arg->sch_idx,
+					RTW89_H2C_MRC_ADD_W0_SCH_IDX) |
+		       le32_encode_bits(arg->sch_type,
+					RTW89_H2C_MRC_ADD_W0_SCH_TYPE) |
+		       le32_encode_bits(arg->slot_num,
+					RTW89_H2C_MRC_ADD_W0_SLOT_NUM) |
+		       le32_encode_bits(arg->btc_in_sch,
+					RTW89_H2C_MRC_ADD_W0_BTC_IN_SCH);
+
+	tmp += sizeof(*h2c_head);
+	for (i = 0; i < arg->slot_num; i++)
+		tmp += rtw89_fw_h2c_mrc_add_slot(rtwdev, &arg->slots[i], tmp);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_ADD_MRC, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		dev_kfree_skb_any(skb);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+int rtw89_fw_h2c_mrc_start(struct rtw89_dev *rtwdev,
+			   const struct rtw89_fw_mrc_start_arg *arg)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct rtw89_h2c_mrc_start *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc start\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mrc_start *)skb->data;
+
+	h2c->w0 = le32_encode_bits(arg->sch_idx,
+				   RTW89_H2C_MRC_START_W0_SCH_IDX) |
+		  le32_encode_bits(arg->old_sch_idx,
+				   RTW89_H2C_MRC_START_W0_OLD_SCH_IDX) |
+		  le32_encode_bits(arg->action,
+				   RTW89_H2C_MRC_START_W0_ACTION);
+
+	h2c->start_tsf_high = cpu_to_le32(arg->start_tsf >> 32);
+	h2c->start_tsf_low = cpu_to_le32(arg->start_tsf);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_START_MRC, 0, 0,
+			      len);
+
+	cond = RTW89_MRC_WAIT_COND(arg->sch_idx, H2C_FUNC_START_MRC);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct rtw89_h2c_mrc_del *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc del\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mrc_del *)skb->data;
+
+	h2c->w0 = le32_encode_bits(sch_idx, RTW89_H2C_MRC_DEL_W0_SCH_IDX);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_DEL_MRC, 0, 0,
+			      len);
+
+	cond = RTW89_MRC_WAIT_COND(sch_idx, H2C_FUNC_DEL_MRC);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+int rtw89_fw_h2c_mrc_req_tsf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_fw_mrc_req_tsf_arg *arg,
+			     struct rtw89_mac_mrc_tsf_rpt *rpt)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct rtw89_h2c_mrc_req_tsf *h2c;
+	struct rtw89_mac_mrc_tsf_rpt *tmp;
+	struct sk_buff *skb;
+	unsigned int i;
+	u32 len;
+	int ret;
+
+	len = struct_size(h2c, infos, arg->num);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc req tsf\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mrc_req_tsf *)skb->data;
+
+	h2c->req_tsf_num = arg->num;
+	for (i = 0; i < arg->num; i++)
+		h2c->infos[i] =
+			u8_encode_bits(arg->infos[i].band,
+				       RTW89_H2C_MRC_REQ_TSF_INFO_BAND) |
+			u8_encode_bits(arg->infos[i].port,
+				       RTW89_H2C_MRC_REQ_TSF_INFO_PORT);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_MRC_REQ_TSF, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, RTW89_MRC_WAIT_COND_REQ_TSF);
+	if (ret)
+		return ret;
+
+	tmp = (struct rtw89_mac_mrc_tsf_rpt *)wait->data.buf;
+	*rpt = *tmp;
+
+	return 0;
+}
+
+int rtw89_fw_h2c_mrc_upd_bitmap(struct rtw89_dev *rtwdev,
+				const struct rtw89_fw_mrc_upd_bitmap_arg *arg)
+{
+	struct rtw89_h2c_mrc_upd_bitmap *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc upd bitmap\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mrc_upd_bitmap *)skb->data;
+
+	h2c->w0 = le32_encode_bits(arg->sch_idx,
+				   RTW89_H2C_MRC_UPD_BITMAP_W0_SCH_IDX) |
+		  le32_encode_bits(arg->action,
+				   RTW89_H2C_MRC_UPD_BITMAP_W0_ACTION) |
+		  le32_encode_bits(arg->macid,
+				   RTW89_H2C_MRC_UPD_BITMAP_W0_MACID);
+	h2c->w1 = le32_encode_bits(arg->client_macid,
+				   RTW89_H2C_MRC_UPD_BITMAP_W1_CLIENT_MACID);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_MRC_UPD_BITMAP, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		dev_kfree_skb_any(skb);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+int rtw89_fw_h2c_mrc_sync(struct rtw89_dev *rtwdev,
+			  const struct rtw89_fw_mrc_sync_arg *arg)
+{
+	struct rtw89_h2c_mrc_sync *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc sync\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mrc_sync *)skb->data;
+
+	h2c->w0 = le32_encode_bits(true, RTW89_H2C_MRC_SYNC_W0_SYNC_EN) |
+		  le32_encode_bits(arg->src.port,
+				   RTW89_H2C_MRC_SYNC_W0_SRC_PORT) |
+		  le32_encode_bits(arg->src.band,
+				   RTW89_H2C_MRC_SYNC_W0_SRC_BAND) |
+		  le32_encode_bits(arg->dest.port,
+				   RTW89_H2C_MRC_SYNC_W0_DEST_PORT) |
+		  le32_encode_bits(arg->dest.band,
+				   RTW89_H2C_MRC_SYNC_W0_DEST_BAND);
+	h2c->w1 = le32_encode_bits(arg->offset, RTW89_H2C_MRC_SYNC_W1_OFFSET);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_MRC_SYNC, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		dev_kfree_skb_any(skb);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+int rtw89_fw_h2c_mrc_upd_duration(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_mrc_upd_duration_arg *arg)
+{
+	struct rtw89_h2c_mrc_upd_duration *h2c;
+	struct sk_buff *skb;
+	unsigned int i;
+	u32 len;
+	int ret;
+
+	len = struct_size(h2c, slots, arg->slot_num);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mrc upd duration\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mrc_upd_duration *)skb->data;
+
+	h2c->w0 = le32_encode_bits(arg->sch_idx,
+				   RTW89_H2C_MRC_UPD_DURATION_W0_SCH_IDX) |
+		  le32_encode_bits(arg->slot_num,
+				   RTW89_H2C_MRC_UPD_DURATION_W0_SLOT_NUM) |
+		  le32_encode_bits(false,
+				   RTW89_H2C_MRC_UPD_DURATION_W0_BTC_IN_SCH);
+
+	h2c->start_tsf_high = cpu_to_le32(arg->start_tsf >> 32);
+	h2c->start_tsf_low = cpu_to_le32(arg->start_tsf);
+
+	for (i = 0; i < arg->slot_num; i++) {
+		h2c->slots[i] =
+			le32_encode_bits(arg->slots[i].slot_idx,
+					 RTW89_H2C_MRC_UPD_DURATION_SLOT_SLOT_IDX) |
+			le32_encode_bits(arg->slots[i].duration,
+					 RTW89_H2C_MRC_UPD_DURATION_SLOT_DURATION);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MRC,
+			      H2C_FUNC_MRC_UPD_DURATION, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		dev_kfree_skb_any(skb);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static bool __fw_txpwr_entry_zero_ext(const void *ext_ptr, u8 ext_len)
 {
 	static const u8 zeros[U8_MAX] = {};
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d44df3897dd2..9c5464dcc081 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3397,6 +3397,45 @@ enum rtw89_h2c_mrc_role_types {
 	RTW89_H2C_MRC_ROLE_EMPTY = 2,
 };
 
+#define RTW89_MAC_MRC_MAX_ADD_SLOT_NUM 3
+#define RTW89_MAC_MRC_MAX_ADD_ROLE_NUM_PER_SLOT 1 /* before MLO */
+
+struct rtw89_fw_mrc_add_slot_arg {
+	u16 duration; /* unit: TU */
+	bool courtesy_en;
+	u8 courtesy_period;
+	u8 courtesy_target; /* slot idx */
+
+	unsigned int role_num;
+	struct {
+		enum rtw89_h2c_mrc_role_types role_type;
+		bool is_master;
+		bool en_tx_null;
+		enum rtw89_band band;
+		enum rtw89_bandwidth bw;
+		u8 macid;
+		u8 central_ch;
+		u8 primary_ch;
+		u8 null_early; /* unit: TU */
+
+		/* if MLD, for macid: [0, chip::support_mld_num)
+		 * otherwise, for macid: [0, 32)
+		 */
+		u32 macid_main_bitmap;
+		/* for MLD, bit X maps to macid: X + chip::support_mld_num */
+		u32 macid_paired_bitmap;
+	} roles[RTW89_MAC_MRC_MAX_ADD_ROLE_NUM_PER_SLOT];
+};
+
+struct rtw89_fw_mrc_add_arg {
+	u8 sch_idx;
+	enum rtw89_h2c_mrc_sch_types sch_type;
+	bool btc_in_sch;
+
+	unsigned int slot_num;
+	struct rtw89_fw_mrc_add_slot_arg slots[RTW89_MAC_MRC_MAX_ADD_SLOT_NUM];
+};
+
 struct rtw89_h2c_mrc_add_role {
 	__le32 w0;
 	__le32 w1;
@@ -3453,6 +3492,13 @@ enum rtw89_h2c_mrc_start_actions {
 	RTW89_H2C_MRC_START_ACTION_REPLACE_OLD = 1,
 };
 
+struct rtw89_fw_mrc_start_arg {
+	u8 sch_idx;
+	u8 old_sch_idx;
+	u64 start_tsf;
+	enum rtw89_h2c_mrc_start_actions action;
+};
+
 struct rtw89_h2c_mrc_start {
 	__le32 w0;
 	__le32 start_tsf_low;
@@ -3476,6 +3522,14 @@ struct rtw89_h2c_mrc_del {
 
 #define RTW89_MAC_MRC_MAX_REQ_TSF_NUM 2
 
+struct rtw89_fw_mrc_req_tsf_arg {
+	unsigned int num;
+	struct {
+		u8 band;
+		u8 port;
+	} infos[RTW89_MAC_MRC_MAX_REQ_TSF_NUM];
+};
+
 struct rtw89_h2c_mrc_req_tsf {
 	u8 req_tsf_num;
 	u8 infos[] __counted_by(req_tsf_num);
@@ -3489,6 +3543,13 @@ enum rtw89_h2c_mrc_upd_bitmap_actions {
 	RTW89_H2C_MRC_UPD_BITMAP_ACTION_ADD = 1,
 };
 
+struct rtw89_fw_mrc_upd_bitmap_arg {
+	u8 sch_idx;
+	u8 macid;
+	u8 client_macid;
+	enum rtw89_h2c_mrc_upd_bitmap_actions action;
+};
+
 struct rtw89_h2c_mrc_upd_bitmap {
 	__le32 w0;
 	__le32 w1;
@@ -3499,6 +3560,14 @@ struct rtw89_h2c_mrc_upd_bitmap {
 #define RTW89_H2C_MRC_UPD_BITMAP_W0_MACID GENMASK(31, 16)
 #define RTW89_H2C_MRC_UPD_BITMAP_W1_CLIENT_MACID GENMASK(15, 0)
 
+struct rtw89_fw_mrc_sync_arg {
+	u8 offset; /* unit: TU */
+	struct {
+		u8 band;
+		u8 port;
+	} src, dest;
+};
+
 struct rtw89_h2c_mrc_sync {
 	__le32 w0;
 	__le32 w1;
@@ -3511,6 +3580,17 @@ struct rtw89_h2c_mrc_sync {
 #define RTW89_H2C_MRC_SYNC_W0_DEST_BAND GENMASK(23, 20)
 #define RTW89_H2C_MRC_SYNC_W1_OFFSET GENMASK(15, 0)
 
+struct rtw89_fw_mrc_upd_duration_arg {
+	u8 sch_idx;
+	u64 start_tsf;
+
+	unsigned int slot_num;
+	struct {
+		u8 slot_idx;
+		u16 duration; /* unit: TU */
+	} slots[RTW89_MAC_MRC_MAX_ADD_SLOT_NUM];
+};
+
 struct rtw89_h2c_mrc_upd_duration {
 	__le32 w0;
 	__le32 start_tsf_low;
@@ -4565,6 +4645,20 @@ int rtw89_fw_h2c_mcc_sync(struct rtw89_dev *rtwdev, u8 group, u8 source,
 			  u8 target, u8 offset);
 int rtw89_fw_h2c_mcc_set_duration(struct rtw89_dev *rtwdev,
 				  const struct rtw89_fw_mcc_duration *p);
+int rtw89_fw_h2c_mrc_add(struct rtw89_dev *rtwdev,
+			 const struct rtw89_fw_mrc_add_arg *arg);
+int rtw89_fw_h2c_mrc_start(struct rtw89_dev *rtwdev,
+			   const struct rtw89_fw_mrc_start_arg *arg);
+int rtw89_fw_h2c_mrc_del(struct rtw89_dev *rtwdev, u8 sch_idx);
+int rtw89_fw_h2c_mrc_req_tsf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_fw_mrc_req_tsf_arg *arg,
+			     struct rtw89_mac_mrc_tsf_rpt *rpt);
+int rtw89_fw_h2c_mrc_upd_bitmap(struct rtw89_dev *rtwdev,
+				const struct rtw89_fw_mrc_upd_bitmap_arg *arg);
+int rtw89_fw_h2c_mrc_sync(struct rtw89_dev *rtwdev,
+			  const struct rtw89_fw_mrc_sync_arg *arg);
+int rtw89_fw_h2c_mrc_upd_duration(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_mrc_upd_duration_arg *arg);
 
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1


