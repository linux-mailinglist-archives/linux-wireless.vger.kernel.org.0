Return-Path: <linux-wireless+bounces-4410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BB872DA7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 04:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EFF1F25DBB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 03:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7098833;
	Wed,  6 Mar 2024 03:47:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EC17BBB
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696843; cv=none; b=Aa2L531ETpuAz5i+ECb4yaz509/pdXY42MCn70+uUzAACWx/MltZwAsjqr4S0Jy5HLqinrXW5hR+VPuawsrQ11ZyxkYEElMtUUR2Qe6fV2gWwmBd6JxFtCYHH6IDLvLXdnM0zu4DIcsXe4hXZvEbCerPKdzSDkrhzj2X9qWixEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696843; c=relaxed/simple;
	bh=HQ3k12dEO59YSbRVvGXkdQDMpoEKGzT3zOuMD+JI9co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=or3wl9sgwj0SslFQYGezSBxV4IRyzRAmWJFMZ8135ny3eFr4uGW+hsGyx5F7oI8sojUK2rjQpHA1kDo6V6MLIKKtCpiarvE3TbV0zZrVm+wnVGcmMhEXPA1etn3k/zgnE605ih5X/osqgAkezIu/WlIIxKwVEQEn1My+hmVDE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4263lFdV5482470, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4263lFdV5482470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:47:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 11:47:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 11:47:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: coex: Add TDMA slot parameter setting version 7
Date: Wed, 6 Mar 2024 11:45:56 +0800
Message-ID: <20240306034558.19648-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306034558.19648-1-pkshih@realtek.com>
References: <20240306034558.19648-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

In order to packet up the slots information, the TLV header has updated.
TDMA slot parameters also use the TLV header to packet up to H2C, so
upgrade to version 7.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 291 ++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/coex.h |  48 ++++
 drivers/net/wireless/realtek/rtw89/core.h |  45 +++-
 3 files changed, 304 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index a999e7a109e0..3a8c34786004 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -55,7 +55,6 @@ enum btc_mlme_state {
 	MLME_LINKED,
 };
 
-#define FCXONESLOT_VER 1
 struct btc_fbtc_1slot {
 	u8 fver;
 	u8 sid; /* slot id */
@@ -257,6 +256,13 @@ struct rtw89_btc_btf_set_slot_table {
 	struct rtw89_btc_fbtc_slot tbls[] __counted_by(tbl_num);
 } __packed;
 
+struct rtw89_btc_btf_set_slot_table_v7 {
+	u8 type;
+	u8 ver;
+	u8 len;
+	struct rtw89_btc_fbtc_slot_v7 v7[CXST_MAX];
+} __packed;
+
 struct rtw89_btc_btf_set_mon_reg {
 	u8 fver;
 	u8 reg_num;
@@ -1227,8 +1233,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_SLOT:
 		pcinfo = &pfwinfo->rpt_fbtc_slots.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_slots.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo);
+		if (ver->fcxslots == 1) {
+			pfinfo = &pfwinfo->rpt_fbtc_slots.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo.v1);
+		} else if (ver->fcxslots == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_slots.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo.v7);
+		} else {
+			goto err;
+		}
 		pcinfo->req_fver = ver->fcxslots;
 		break;
 	case BTC_RPT_TYPE_CYSTA:
@@ -1502,14 +1515,25 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			goto err;
 		break;
 	case BTC_RPT_TYPE_SLOT:
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): check %d %zu\n",
-			    __func__, BTC_DCNT_SLOT_NONSYNC,
-			    sizeof(dm->slot_now));
-		_chk_btc_err(rtwdev, BTC_DCNT_SLOT_NONSYNC,
-			     memcmp(dm->slot_now,
-				    pfwinfo->rpt_fbtc_slots.finfo.slot,
-				    sizeof(dm->slot_now)));
+		if (ver->fcxslots == 7) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): check %d %zu\n",
+				    __func__, BTC_DCNT_SLOT_NONSYNC,
+				    sizeof(dm->slot_now.v7));
+			_chk_btc_err(rtwdev, BTC_DCNT_SLOT_NONSYNC,
+				     memcmp(dm->slot_now.v7,
+					    pfwinfo->rpt_fbtc_slots.finfo.v7.slot,
+					    sizeof(dm->slot_now.v7)));
+		} else if (ver->fcxslots == 1) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): check %d %zu\n",
+				    __func__, BTC_DCNT_SLOT_NONSYNC,
+				    sizeof(dm->slot_now.v1));
+			_chk_btc_err(rtwdev, BTC_DCNT_SLOT_NONSYNC,
+				     memcmp(dm->slot_now.v1,
+					    pfwinfo->rpt_fbtc_slots.finfo.v1.slot,
+					    sizeof(dm->slot_now.v1)));
+		}
 		break;
 	case BTC_RPT_TYPE_CYSTA:
 		if (ver->fcxcysta == 2) {
@@ -1525,10 +1549,17 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 
 			/* Check diff time between WL slot and W1/E2G slot */
 			if (dm->tdma_now.type == CXTDMA_OFF &&
-			    dm->tdma_now.ext_ctrl == CXECTL_EXT)
-				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_E2G].dur);
-			else
-				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+			    dm->tdma_now.ext_ctrl == CXECTL_EXT) {
+				if (ver->fcxslots == 1)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v1[CXST_E2G].dur);
+				else if (ver->fcxslots == 7)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v7[CXST_E2G].dur);
+			} else {
+				if (ver->fcxslots == 1)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v1[CXST_W1].dur);
+				else if (ver->fcxslots == 7)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v7[CXST_W1].dur);
+			}
 
 			if (le16_to_cpu(pcysta->v2.tavg_cycle[CXT_WL]) > wl_slot_set) {
 				diff_t = le16_to_cpu(pcysta->v2.tavg_cycle[CXT_WL]) - wl_slot_set;
@@ -1558,7 +1589,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 
 			/* Check diff time between real WL slot and W1 slot */
 			if (dm->tdma_now.type == CXTDMA_OFF) {
-				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+				if (ver->fcxslots == 1)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v1[CXST_W1].dur);
+				else if (ver->fcxslots == 7)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v7[CXST_W1].dur);
 				wl_slot_real = le16_to_cpu(pcysta->v3.cycle_time.tavg[CXT_WL]);
 				if (wl_slot_real > wl_slot_set) {
 					diff_t = wl_slot_real - wl_slot_set;
@@ -1599,7 +1633,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 
 			/* Check diff time between real WL slot and W1 slot */
 			if (dm->tdma_now.type == CXTDMA_OFF) {
-				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+				if (ver->fcxslots == 1)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v1[CXST_W1].dur);
+				else if (ver->fcxslots == 7)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v7[CXST_W1].dur);
 				wl_slot_real = le16_to_cpu(pcysta->v4.cycle_time.tavg[CXT_WL]);
 				if (wl_slot_real > wl_slot_set) {
 					diff_t = wl_slot_real - wl_slot_set;
@@ -1641,7 +1678,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 
 			/* Check diff time between real WL slot and W1 slot */
 			if (dm->tdma_now.type == CXTDMA_OFF) {
-				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+				if (ver->fcxslots == 1)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v1[CXST_W1].dur);
+				else if (ver->fcxslots == 7)
+					wl_slot_set = le16_to_cpu(dm->slot_now.v7[CXST_W1].dur);
 				wl_slot_real = le16_to_cpu(pcysta->v5.cycle_time.tavg[CXT_WL]);
 
 				if (wl_slot_real > wl_slot_set)
@@ -1784,7 +1824,7 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 		    dm->tdma.ext_ctrl);
 }
 
-static void _append_slot(struct rtw89_dev *rtwdev)
+static void _append_slot_v1(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -1799,8 +1839,8 @@ static void _append_slot(struct rtw89_dev *rtwdev)
 
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!btc->update_policy_force &&
-		    !memcmp(&dm->slot[i], &dm->slot_now[i],
-			    sizeof(dm->slot[i])))
+		    !memcmp(&dm->slot.v1[i], &dm->slot_now.v1[i],
+			    sizeof(dm->slot.v1[i])))
 			continue;
 
 		len = btc->policy_len;
@@ -1810,14 +1850,14 @@ static void _append_slot(struct rtw89_dev *rtwdev)
 		tlv->type = CXPOLICY_SLOT;
 		tlv->len = sizeof(*v);
 
-		v->fver = FCXONESLOT_VER;
+		v->fver = btc->ver->fcxslots;
 		v->sid = i;
-		v->slot = dm->slot[i];
+		v->slot = dm->slot.v1[i];
 
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): slot-%d: dur=%d, table=0x%08x, type=%d\n",
-			    __func__, i, dm->slot[i].dur, dm->slot[i].cxtbl,
-			    dm->slot[i].cxtype);
+			    __func__, i, dm->slot.v1[i].dur, dm->slot.v1[i].cxtbl,
+			    dm->slot.v1[i].cxtype);
 		cnt++;
 
 		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v);
@@ -1829,6 +1869,71 @@ static void _append_slot(struct rtw89_dev *rtwdev)
 			    __func__, cnt);
 }
 
+static void _append_slot_v7(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc_btf_tlv_v7 *tlv = NULL;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 i, cnt = 0;
+	u16 len;
+
+	for (i = 0; i < CXST_MAX; i++) {
+		if (!btc->update_policy_force &&
+		    !memcmp(&dm->slot.v7[i], &dm->slot_now.v7[i],
+			    sizeof(dm->slot.v7[i])))
+			continue;
+
+		len = btc->policy_len;
+
+		if (!tlv) {
+			if ((len + BTC_TLV_HDR_LEN_V7) > RTW89_BTC_POLICY_MAXLEN) {
+				rtw89_debug(rtwdev, RTW89_DBG_BTC,
+					    "[BTC], %s(): buff overflow!\n", __func__);
+				break;
+			}
+
+			tlv = (struct rtw89_btc_btf_tlv_v7 *)&btc->policy[len];
+			tlv->type = CXPOLICY_SLOT;
+			tlv->ver = btc->ver->fcxslots;
+			tlv->len = sizeof(dm->slot.v7[0]) + BTC_TLV_SLOT_ID_LEN_V7;
+			len += BTC_TLV_HDR_LEN_V7;
+		}
+
+		if ((len + (u16)tlv->len) > RTW89_BTC_POLICY_MAXLEN) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): buff overflow!\n", __func__);
+			break;
+		}
+
+		btc->policy[len] = i; /* slot-id */
+		memcpy(&btc->policy[len + 1], &dm->slot.v7[i],
+		       sizeof(dm->slot.v7[0]));
+		len += tlv->len;
+
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s: policy_len=%d, slot-%d: dur=%d, type=%d, table=0x%08x\n",
+			    __func__, btc->policy_len, i, dm->slot.v7[i].dur,
+			    dm->slot.v7[i].cxtype, dm->slot.v7[i].cxtbl);
+		cnt++;
+		btc->policy_len = len; /* update total length */
+	}
+
+	if (cnt > 0)
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s: slot update (cnt=%d, len=%d)!!\n",
+			    __func__, cnt, btc->policy_len);
+}
+
+static void _append_slot(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+
+	if (btc->ver->fcxslots == 7)
+		_append_slot_v7(rtwdev);
+	else
+		_append_slot_v1(rtwdev);
+}
+
 static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -1974,6 +2079,45 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 	return bit_map;
 }
 
+static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_btf_tlv_v7 *tlv_v7 = NULL;
+	struct rtw89_btc_btf_set_slot_table *tbl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u16 n, len;
+
+	if (ver->fcxslots == 7) {
+		len = sizeof(*tlv_v7) + sizeof(dm->slot.v7);
+		tlv_v7 = kmalloc(len, GFP_KERNEL);
+		if (!tlv_v7)
+			return;
+
+		tlv_v7->type = SET_SLOT_TABLE;
+		tlv_v7->ver = ver->fcxslots;
+		tlv_v7->len = sizeof(dm->slot.v7);
+		memcpy(tlv_v7->val, dm->slot.v7, sizeof(dm->slot.v7));
+
+		_send_fw_cmd(rtwdev, BTFC_SET, SET_SLOT_TABLE, (u8 *)tlv_v7, len);
+
+		kfree(tlv_v7);
+	} else {
+		n = struct_size(tbl, tbls, CXST_MAX);
+		tbl = kmalloc(n, GFP_KERNEL);
+		if (!tbl)
+			return;
+
+		tbl->fver = BTF_SET_SLOT_TABLE_VER;
+		tbl->tbl_num = CXST_MAX;
+		memcpy(tbl->tbls, dm->slot.v1, flex_array_size(tbl, tbls, CXST_MAX));
+
+		_send_fw_cmd(rtwdev, BTFC_SET, SET_SLOT_TABLE, tbl, n);
+
+		kfree(tbl);
+	}
+}
+
 static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 				u32 rpt_map, bool rpt_state)
 {
@@ -2010,26 +2154,6 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 		fwinfo->rpt_en_map = val;
 }
 
-static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev, u8 num,
-				   struct rtw89_btc_fbtc_slot *s)
-{
-	struct rtw89_btc_btf_set_slot_table *tbl;
-	u16 n;
-
-	n = struct_size(tbl, tbls, num);
-	tbl = kmalloc(n, GFP_KERNEL);
-	if (!tbl)
-		return;
-
-	tbl->fver = BTF_SET_SLOT_TABLE_VER;
-	tbl->tbl_num = num;
-	memcpy(tbl->tbls, s, flex_array_size(tbl, tbls, num));
-
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_SLOT_TABLE, tbl, n);
-
-	kfree(tbl);
-}
-
 static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -2128,7 +2252,10 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 			   btc->policy, btc->policy_len);
 	if (!ret) {
 		memcpy(&dm->tdma_now, &dm->tdma, sizeof(dm->tdma_now));
-		memcpy(&dm->slot_now, &dm->slot, sizeof(dm->slot_now));
+		if (btc->ver->fcxslots == 7)
+			memcpy(&dm->slot_now.v7, &dm->slot.v7, sizeof(dm->slot_now.v7));
+		else
+			memcpy(&dm->slot_now.v1, &dm->slot.v1, sizeof(dm->slot_now.v1));
 	}
 
 	if (btc->update_policy_force)
@@ -2801,19 +2928,6 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 #define _tdma_set_tog(btc, wtg) ({(btc)->dm.tdma.wtgle_n = wtg; })
 #define _tdma_set_lek(btc, lek) ({(btc)->dm.tdma.leak_n = lek; })
 
-#define _slot_set(btc, sid, dura, tbl, type) \
-	do { \
-		typeof(sid) _sid = (sid); \
-		typeof(btc) _btc = (btc); \
-		_btc->dm.slot[_sid].dur = cpu_to_le16(dura);\
-		_btc->dm.slot[_sid].cxtbl = cpu_to_le32(tbl); \
-		_btc->dm.slot[_sid].cxtype = cpu_to_le16(type); \
-	} while (0)
-
-#define _slot_set_dur(btc, sid, dura) (btc)->dm.slot[sid].dur = cpu_to_le16(dura)
-#define _slot_set_tbl(btc, sid, tbl) (btc)->dm.slot[sid].cxtbl = cpu_to_le32(tbl)
-#define _slot_set_type(btc, sid, type) (btc)->dm.slot[sid].cxtype = cpu_to_le16(type)
-
 struct btc_btinfo_lb2 {
 	u8 connect: 1;
 	u8 sco_busy: 1;
@@ -2888,7 +3002,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
-	struct rtw89_btc_fbtc_slot *s = dm->slot;
+	struct rtw89_btc_fbtc_slot *s = dm->slot.v1;
 	u8 type;
 	u32 tbl_w1, tbl_b1, tbl_b4;
 
@@ -3199,7 +3313,6 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
-	struct rtw89_btc_fbtc_slot *s = dm->slot;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &btc->cx.wl.role_info_v1;
 	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt.link_info.hid_desc;
 	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt.link_info.hfp_desc;
@@ -3247,13 +3360,15 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	case BTC_CXP_USERDEF0:
 		btc->update_policy_force = true;
 		*t = t_def[CXTD_OFF];
-		s[CXST_OFF] = s_def[CXST_OFF];
+		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
+			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
 		_slot_set_tbl(btc, CXST_OFF, cxtbl[2]);
 		break;
 	case BTC_CXP_OFF: /* TDMA off */
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
 		*t = t_def[CXTD_OFF];
-		s[CXST_OFF] = s_def[CXST_OFF];
+		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
+			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
 
 		switch (policy_type) {
 		case BTC_CXP_OFF_BT:
@@ -3294,7 +3409,8 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	case BTC_CXP_OFFB: /* TDMA off + beacon protect */
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
 		*t = t_def[CXTD_OFF_B2];
-		s[CXST_OFF] = s_def[CXST_OFF];
+		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
+			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
 
 		switch (policy_type) {
 		case BTC_CXP_OFFB_BWB0:
@@ -3315,21 +3431,29 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 
 		switch (policy_type) {
 		case BTC_CXP_OFFE_DEF:
-			s[CXST_E2G] = s_def[CXST_E2G];
-			s[CXST_E5G] = s_def[CXST_E5G];
-			s[CXST_EBT] = s_def[CXST_EBT];
-			s[CXST_ENULL] = s_def[CXST_ENULL];
+			_slot_set_le(btc, CXST_E2G, s_def[CXST_E2G].dur,
+				     s_def[CXST_E2G].cxtbl, s_def[CXST_E2G].cxtype);
+			_slot_set_le(btc, CXST_E5G, s_def[CXST_E5G].dur,
+				     s_def[CXST_E5G].cxtbl, s_def[CXST_E5G].cxtype);
+			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
+				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
 			break;
 		case BTC_CXP_OFFE_DEF2:
 			_slot_set(btc, CXST_E2G, 20, cxtbl[1], SLOT_ISO);
-			s[CXST_E5G] = s_def[CXST_E5G];
-			s[CXST_EBT] = s_def[CXST_EBT];
-			s[CXST_ENULL] = s_def[CXST_ENULL];
+			_slot_set_le(btc, CXST_E5G, s_def[CXST_E5G].dur,
+				     s_def[CXST_E5G].cxtbl, s_def[CXST_E5G].cxtype);
+			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
+				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
 			break;
 		default:
 			break;
 		}
-		s[CXST_OFF] = s_def[CXST_OFF];
+		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
+			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
 		break;
 	case BTC_CXP_FIX: /* TDMA Fix-Slot */
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
@@ -6306,8 +6430,8 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 
 	_set_init_info(rtwdev);
 	_set_wl_tx_power(rtwdev, RTW89_BTC_WL_DEF_TX_PWR);
-	rtw89_btc_fw_set_slots(rtwdev, CXST_MAX, dm->slot);
 	btc_fw_set_monreg(rtwdev);
+	rtw89_btc_fw_set_slots(rtwdev);
 	_fw_set_drv_info(rtwdev, CXDRVINFO_INIT);
 	_fw_set_drv_info(rtwdev, CXDRVINFO_CTRL);
 
@@ -8043,22 +8167,35 @@ static void _show_fbtc_slots(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_fbtc_slot *s;
+	u16 dur, cxtype;
+	u32 tbl;
 	u8 i = 0;
 
 	for (i = 0; i < CXST_MAX; i++) {
-		s = &dm->slot_now[i];
+		if (btc->ver->fcxslots == 1) {
+			dur = le16_to_cpu(dm->slot_now.v1[i].dur);
+			tbl = le32_to_cpu(dm->slot_now.v1[i].cxtbl);
+			cxtype = le16_to_cpu(dm->slot_now.v1[i].cxtype);
+		} else if (btc->ver->fcxslots == 7) {
+			dur = le16_to_cpu(dm->slot_now.v7[i].dur);
+			tbl = le32_to_cpu(dm->slot_now.v7[i].cxtbl);
+			cxtype = le16_to_cpu(dm->slot_now.v7[i].cxtype);
+		} else {
+			return;
+		}
+
 		if (i % 5 == 0)
 			seq_printf(m,
 				   " %-15s : %5s[%03d/0x%x/%d]",
 				   "[slot_list]",
 				   id_to_slot((u32)i),
-				   s->dur, s->cxtbl, s->cxtype);
+				   dur, tbl, cxtype);
 		else
 			seq_printf(m,
 				   ", %5s[%03d/0x%x/%d]",
 				   id_to_slot((u32)i),
-				   s->dur, s->cxtbl, s->cxtype);
+				   dur, tbl, cxtype);
+
 		if (i % 5 == 4)
 			seq_puts(m, "\n");
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 671f52fe8931..43c5e3626121 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -8,6 +8,7 @@
 #include "core.h"
 
 #define BTC_H2C_MAXLEN 2020
+#define BTC_TLV_SLOT_ID_LEN_V7 1
 
 enum btc_mode {
 	BTC_MODE_NORMAL,
@@ -285,4 +286,51 @@ static inline u32 rtw89_get_antpath_type(u8 phy_map, u8 type)
 	return ((phy_map << 8) + type);
 }
 
+static inline
+void _slot_set_le(struct rtw89_btc *btc, u8 sid, __le16 dura, __le32 tbl, __le16 type)
+{
+	if (btc->ver->fcxslots == 1) {
+		btc->dm.slot.v1[sid].dur = dura;
+		btc->dm.slot.v1[sid].cxtbl = tbl;
+		btc->dm.slot.v1[sid].cxtype = type;
+	} else if (btc->ver->fcxslots == 7) {
+		btc->dm.slot.v7[sid].dur = dura;
+		btc->dm.slot.v7[sid].cxtype = type;
+		btc->dm.slot.v7[sid].cxtbl = tbl;
+	}
+}
+
+static inline
+void _slot_set(struct rtw89_btc *btc, u8 sid, u16 dura, u32 tbl, u16 type)
+{
+	_slot_set_le(btc, sid, cpu_to_le16(dura), cpu_to_le32(tbl), cpu_to_le16(type));
+}
+
+static inline
+void _slot_set_dur(struct rtw89_btc *btc, u8 sid, u16 dura)
+{
+	if (btc->ver->fcxslots == 1)
+		btc->dm.slot.v1[sid].dur = cpu_to_le16(dura);
+	else if (btc->ver->fcxslots == 7)
+		btc->dm.slot.v7[sid].dur = cpu_to_le16(dura);
+}
+
+static inline
+void _slot_set_type(struct rtw89_btc *btc, u8 sid, u16 type)
+{
+	if (btc->ver->fcxslots == 1)
+		btc->dm.slot.v1[sid].cxtype = cpu_to_le16(type);
+	else if (btc->ver->fcxslots == 7)
+		btc->dm.slot.v7[sid].cxtype = cpu_to_le16(type);
+}
+
+static inline
+void _slot_set_tbl(struct rtw89_btc *btc, u8 sid, u32 tbl)
+{
+	if (btc->ver->fcxslots == 1)
+		btc->dm.slot.v1[sid].cxtbl = cpu_to_le32(tbl);
+	else if (btc->ver->fcxslots == 7)
+		btc->dm.slot.v7[sid].cxtbl = cpu_to_le32(tbl);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bc10ebb785a2..fc1ed8612cf1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2293,6 +2293,40 @@ struct rtw89_btc_fbtc_slots {
 	struct rtw89_btc_fbtc_slot slot[CXST_MAX];
 } __packed;
 
+struct rtw89_btc_fbtc_slot_v7 {
+	__le16 dur; /* slot duration */
+	__le16 cxtype;
+	__le32 cxtbl;
+} __packed;
+
+struct rtw89_btc_fbtc_slot_u16 {
+	__le16 dur; /* slot duration */
+	__le16 cxtype;
+	__le16 cxtbl_l16; /* coex table [15:0] */
+	__le16 cxtbl_h16; /* coex table [31:16] */
+} __packed;
+
+struct rtw89_btc_fbtc_1slot_v7 {
+	u8 fver;
+	u8 sid; /* slot id */
+	__le16 rsvd;
+	struct rtw89_btc_fbtc_slot_v7 slot;
+} __packed;
+
+struct rtw89_btc_fbtc_slots_v7 {
+	u8 fver;
+	u8 slot_cnt;
+	u8 rsvd0;
+	u8 rsvd1;
+	struct rtw89_btc_fbtc_slot_u16 slot[CXST_MAX];
+	__le32 update_map;
+} __packed;
+
+union rtw89_btc_fbtc_slots_info {
+	struct rtw89_btc_fbtc_slots v1;
+	struct rtw89_btc_fbtc_slots_v7 v7;
+} __packed;
+
 struct rtw89_btc_fbtc_step {
 	u8 type;
 	u8 val;
@@ -2611,9 +2645,14 @@ struct rtw89_btc_trx_info {
 	u32 rx_err_ratio;
 };
 
+union rtw89_btc_fbtc_slot_u {
+	struct rtw89_btc_fbtc_slot v1[CXST_MAX];
+	struct rtw89_btc_fbtc_slot_v7 v7[CXST_MAX];
+};
+
 struct rtw89_btc_dm {
-	struct rtw89_btc_fbtc_slot slot[CXST_MAX];
-	struct rtw89_btc_fbtc_slot slot_now[CXST_MAX];
+	union rtw89_btc_fbtc_slot_u slot;
+	union rtw89_btc_fbtc_slot_u slot_now;
 	struct rtw89_btc_fbtc_tdma tdma;
 	struct rtw89_btc_fbtc_tdma tdma_now;
 	struct rtw89_mac_ax_coex_gnt gnt;
@@ -2754,7 +2793,7 @@ struct rtw89_btc_rpt_fbtc_tdma {
 
 struct rtw89_btc_rpt_fbtc_slots {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_slots finfo; /* info from fw */
+	union rtw89_btc_fbtc_slots_info finfo; /* info from fw */
 };
 
 struct rtw89_btc_rpt_fbtc_cysta {
-- 
2.25.1


