Return-Path: <linux-wireless+bounces-3511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A7852A26
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506E3284480
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7B224E4;
	Tue, 13 Feb 2024 07:36:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E466224CF
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809794; cv=none; b=DyBGGFTM6nR9qOO4yZ/JLFsp3swBcdzrFzSPWkvs+xqdLYKc2B7BtrwlWXLUjOQ0mPmaPhhUvVjSKdr+sY0NwKdvRBlM8ELRHMrxUCvmf3LKy3QM3WMsd9VjdLOW6jJF8ETnpuZ64iOMaHDRLbjc+ij6c4EWyh7KvyfqGmNUtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809794; c=relaxed/simple;
	bh=8IN/s16o0zH0Hj3t1paEHvmoqMAU/Xh0o7cdkLijhPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtjJqO3pEtDynRFl9FssF4GWagrYszic6F2K+xVRRBd9JWUbUCM3Y7iBmsh6GAz70h5AhGWJkKCob7FqSrrK+bdcRDjcEa1rBTFjCciSq2CurJfayrPg7/OJdzWvn7gwYvEt9DN8hCpinM9dhBMzVcWtSRtmJeuDTm713+SBCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41D7aPBZ11671715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41D7aPBZ11671715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:36:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 13 Feb 2024 15:36:26 +0800
Received: from [127.0.1.1] (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 Feb
 2024 15:36:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: chan: support MCC on Wi-Fi 7 chips
Date: Tue, 13 Feb 2024 15:35:13 +0800
Message-ID: <20240213073514.23796-5-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

On Wi-Fi 7 chips, concurrent stuffs are supported by FW MRC series
(multi-role concurrent) functions. And, driver has implemented the
corresponding SW handling in patches in front of this one. Now, we
extend SW MCC (multi-channel concurrent) flow to work on Wi-Fi 7
chips.

In SW point of view, things look as below.

|  SW  |                 |  FW func      |
|      |                 |  H2C/C2H      |
--------------------------------------------
|      |              ax                 |
|      |            /----|  FW MCC func  |
|  MCC | -- chip --+                     |
|      |            \----|  FW MRC func  |
|      |              be                 |

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 440 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |   7 +
 2 files changed, 420 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 7b9baf4db70f..051a3cad6101 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -322,6 +322,13 @@ static void rtw89_chanctx_notify(struct rtw89_dev *rtwdev,
 	}
 }
 
+static bool rtw89_concurrent_via_mrc(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+
+	return chip_gen == RTW89_CHIP_BE;
+}
+
 /* This function centrally manages how MCC roles are sorted and iterated.
  * And, it guarantees that ordered_idx is less than NUM_OF_RTW89_MCC_ROLES.
  * So, if data needs to pass an array for ordered_idx, the array can declare
@@ -374,16 +381,13 @@ static u32 rtw89_mcc_get_tbtt_ofst(struct rtw89_dev *rtwdev,
 	return remainder;
 }
 
-static u16 rtw89_mcc_get_bcn_ofst(struct rtw89_dev *rtwdev)
+static int __mcc_fw_req_tsf(struct rtw89_dev *rtwdev, u64 *tsf_ref, u64 *tsf_aux)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mac_mcc_tsf_rpt rpt = {};
 	struct rtw89_fw_mcc_tsf_req req = {};
-	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
-	u32 tbtt_ofst_ref, tbtt_ofst_aux;
-	u64 tsf_ref, tsf_aux;
 	int ret;
 
 	req.group = mcc->group;
@@ -393,11 +397,63 @@ static u16 rtw89_mcc_get_bcn_ofst(struct rtw89_dev *rtwdev)
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "MCC h2c failed to request tsf: %d\n", ret);
-		return RTW89_MCC_DFLT_BCN_OFST_TIME;
+		return ret;
+	}
+
+	*tsf_ref = (u64)rpt.tsf_x_high << 32 | rpt.tsf_x_low;
+	*tsf_aux = (u64)rpt.tsf_y_high << 32 | rpt.tsf_y_low;
+
+	return 0;
+}
+
+static int __mrc_fw_req_tsf(struct rtw89_dev *rtwdev, u64 *tsf_ref, u64 *tsf_aux)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_fw_mrc_req_tsf_arg arg = {};
+	struct rtw89_mac_mrc_tsf_rpt rpt = {};
+	int ret;
+
+	BUILD_BUG_ON(RTW89_MAC_MRC_MAX_REQ_TSF_NUM < NUM_OF_RTW89_MCC_ROLES);
+
+	arg.num = 2;
+	arg.infos[0].band = ref->rtwvif->mac_idx;
+	arg.infos[0].port = ref->rtwvif->port;
+	arg.infos[1].band = aux->rtwvif->mac_idx;
+	arg.infos[1].port = aux->rtwvif->port;
+
+	ret = rtw89_fw_h2c_mrc_req_tsf(rtwdev, &arg, &rpt);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC h2c failed to request tsf: %d\n", ret);
+		return ret;
 	}
 
-	tsf_ref = (u64)rpt.tsf_x_high << 32 | rpt.tsf_x_low;
-	tsf_aux = (u64)rpt.tsf_y_high << 32 | rpt.tsf_y_low;
+	*tsf_ref = rpt.tsfs[0];
+	*tsf_aux = rpt.tsfs[1];
+
+	return 0;
+}
+
+static u16 rtw89_mcc_get_bcn_ofst(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
+	u32 tbtt_ofst_ref, tbtt_ofst_aux;
+	u64 tsf_ref, tsf_aux;
+	int ret;
+
+	if (rtw89_concurrent_via_mrc(rtwdev))
+		ret = __mrc_fw_req_tsf(rtwdev, &tsf_ref, &tsf_aux);
+	else
+		ret = __mcc_fw_req_tsf(rtwdev, &tsf_ref, &tsf_aux);
+
+	if (ret)
+		return RTW89_MCC_DFLT_BCN_OFST_TIME;
+
 	tbtt_ofst_ref = rtw89_mcc_get_tbtt_ofst(rtwdev, ref, tsf_ref);
 	tbtt_ofst_aux = rtw89_mcc_get_tbtt_ofst(rtwdev, aux, tsf_aux);
 
@@ -420,6 +476,28 @@ void rtw89_mcc_role_fw_macid_bitmap_set_bit(struct rtw89_mcc_role *mcc_role,
 	mcc_role->macid_bitmap[idx] |= BIT(pos);
 }
 
+static
+u32 rtw89_mcc_role_fw_macid_bitmap_to_u32(struct rtw89_mcc_role *mcc_role)
+{
+	unsigned int macid;
+	unsigned int i, j;
+	u32 bitmap = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mcc_role->macid_bitmap); i++) {
+		for (j = 0; j < 8; j++) {
+			macid = i * 8 + j;
+			if (macid >= 32)
+				goto out;
+
+			if (mcc_role->macid_bitmap[i] & BIT(j))
+				bitmap |= BIT(macid);
+		}
+	}
+
+out:
+	return bitmap;
+}
+
 static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
@@ -1181,7 +1259,11 @@ static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
 	tsf_ofst_tgt = bcn_intvl_src_us - remainder;
 
 	config->sync.macid_tgt = tgt->rtwvif->mac_id;
+	config->sync.band_tgt = tgt->rtwvif->mac_idx;
+	config->sync.port_tgt = tgt->rtwvif->port;
 	config->sync.macid_src = src->rtwvif->mac_id;
+	config->sync.band_src = src->rtwvif->mac_idx;
+	config->sync.port_src = src->rtwvif->port;
 	config->sync.offset = tsf_ofst_tgt / 1024;
 	config->sync.enable = true;
 
@@ -1328,6 +1410,37 @@ static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *ro
 	return 0;
 }
 
+static
+void __mrc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role,
+		       struct rtw89_fw_mrc_add_arg *arg, u8 slot_idx)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_policy *policy = &role->policy;
+	struct rtw89_fw_mrc_add_slot_arg *slot_arg;
+	const struct rtw89_chan *chan;
+
+	slot_arg = &arg->slots[slot_idx];
+	role->slot_idx = slot_idx;
+
+	slot_arg->duration = role->duration;
+	slot_arg->role_num = 1;
+
+	chan = rtw89_chan_get(rtwdev, role->rtwvif->sub_entity_idx);
+
+	slot_arg->roles[0].role_type = RTW89_H2C_MRC_ROLE_WIFI;
+	slot_arg->roles[0].is_master = role == ref;
+	slot_arg->roles[0].band = chan->band_type;
+	slot_arg->roles[0].bw = chan->band_width;
+	slot_arg->roles[0].central_ch = chan->channel;
+	slot_arg->roles[0].primary_ch = chan->primary_channel;
+	slot_arg->roles[0].en_tx_null = !policy->dis_tx_null;
+	slot_arg->roles[0].null_early = policy->tx_null_early;
+	slot_arg->roles[0].macid = role->rtwvif->mac_id;
+	slot_arg->roles[0].macid_main_bitmap =
+		rtw89_mcc_role_fw_macid_bitmap_to_u32(role);
+}
+
 static int __mcc_fw_add_bt_role(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1349,6 +1462,20 @@ static int __mcc_fw_add_bt_role(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static
+void __mrc_fw_add_bt_role(struct rtw89_dev *rtwdev,
+			  struct rtw89_fw_mrc_add_arg *arg, u8 slot_idx)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_bt_role *bt_role = &mcc->bt_role;
+	struct rtw89_fw_mrc_add_slot_arg *slot_arg = &arg->slots[slot_idx];
+
+	slot_arg->duration = bt_role->duration;
+	slot_arg->role_num = 1;
+
+	slot_arg->roles[0].role_type = RTW89_H2C_MRC_ROLE_BT;
+}
+
 static int __mcc_fw_start(struct rtw89_dev *rtwdev, bool replace)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1434,6 +1561,130 @@ static int __mcc_fw_start(struct rtw89_dev *rtwdev, bool replace)
 	return 0;
 }
 
+static void __mrc_fw_add_courtesy(struct rtw89_dev *rtwdev,
+				  struct rtw89_fw_mrc_add_arg *arg)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_courtesy *courtesy = &pattern->courtesy;
+	struct rtw89_fw_mrc_add_slot_arg *slot_arg_src;
+	u8 slot_idx_tgt;
+
+	if (!courtesy->enable)
+		return;
+
+	if (courtesy->macid_src == ref->rtwvif->mac_id) {
+		slot_arg_src = &arg->slots[ref->slot_idx];
+		slot_idx_tgt = aux->slot_idx;
+	} else {
+		slot_arg_src = &arg->slots[aux->slot_idx];
+		slot_idx_tgt = ref->slot_idx;
+	}
+
+	slot_arg_src->courtesy_target = slot_idx_tgt;
+	slot_arg_src->courtesy_period = courtesy->slot_num;
+	slot_arg_src->courtesy_en = true;
+}
+
+static int __mrc_fw_start(struct rtw89_dev *rtwdev, bool replace)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_sync *sync = &config->sync;
+	struct rtw89_fw_mrc_start_arg start_arg = {};
+	struct rtw89_fw_mrc_add_arg add_arg = {};
+	int ret;
+
+	BUILD_BUG_ON(RTW89_MAC_MRC_MAX_ADD_SLOT_NUM <
+		     NUM_OF_RTW89_MCC_ROLES + 1 /* bt role */);
+
+	if (replace) {
+		start_arg.old_sch_idx = mcc->group;
+		start_arg.action = RTW89_H2C_MRC_START_ACTION_REPLACE_OLD;
+		mcc->group = RTW89_MCC_NEXT_GROUP(mcc->group);
+	}
+
+	add_arg.sch_idx = mcc->group;
+	add_arg.sch_type = RTW89_H2C_MRC_SCH_BAND0_ONLY;
+
+	switch (pattern->plan) {
+	case RTW89_MCC_PLAN_TAIL_BT:
+		__mrc_fw_add_role(rtwdev, ref, &add_arg, 0);
+		__mrc_fw_add_role(rtwdev, aux, &add_arg, 1);
+		__mrc_fw_add_bt_role(rtwdev, &add_arg, 2);
+
+		add_arg.slot_num = 3;
+		add_arg.btc_in_sch = true;
+		break;
+	case RTW89_MCC_PLAN_MID_BT:
+		__mrc_fw_add_role(rtwdev, ref, &add_arg, 0);
+		__mrc_fw_add_bt_role(rtwdev, &add_arg, 1);
+		__mrc_fw_add_role(rtwdev, aux, &add_arg, 2);
+
+		add_arg.slot_num = 3;
+		add_arg.btc_in_sch = true;
+		break;
+	case RTW89_MCC_PLAN_NO_BT:
+		__mrc_fw_add_role(rtwdev, ref, &add_arg, 0);
+		__mrc_fw_add_role(rtwdev, aux, &add_arg, 1);
+
+		add_arg.slot_num = 2;
+		add_arg.btc_in_sch = false;
+		break;
+	default:
+		rtw89_warn(rtwdev, "MCC unknown plan: %d\n", pattern->plan);
+		return -EFAULT;
+	}
+
+	__mrc_fw_add_courtesy(rtwdev, &add_arg);
+
+	ret = rtw89_fw_h2c_mrc_add(rtwdev, &add_arg);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC h2c failed to trigger add: %d\n", ret);
+		return ret;
+	}
+
+	if (sync->enable) {
+		struct rtw89_fw_mrc_sync_arg sync_arg = {
+			.offset = sync->offset,
+			.src = {
+				.band = sync->band_src,
+				.port = sync->port_src,
+			},
+			.dest = {
+				.band = sync->band_tgt,
+				.port = sync->port_tgt,
+			},
+		};
+
+		ret = rtw89_fw_h2c_mrc_sync(rtwdev, &sync_arg);
+		if (ret) {
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MRC h2c failed to trigger sync: %d\n", ret);
+			return ret;
+		}
+	}
+
+	start_arg.sch_idx = mcc->group;
+	start_arg.start_tsf = config->start_tsf;
+
+	ret = rtw89_fw_h2c_mrc_start(rtwdev, &start_arg);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC h2c failed to trigger start: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __mcc_fw_set_duration_no_bt(struct rtw89_dev *rtwdev, bool sync_changed)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1475,6 +1726,60 @@ static int __mcc_fw_set_duration_no_bt(struct rtw89_dev *rtwdev, bool sync_chang
 	return 0;
 }
 
+static int __mrc_fw_set_duration_no_bt(struct rtw89_dev *rtwdev, bool sync_changed)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_sync *sync = &config->sync;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_fw_mrc_upd_duration_arg dur_arg = {
+		.sch_idx = mcc->group,
+		.start_tsf = config->start_tsf,
+		.slot_num = 2,
+		.slots[0] = {
+			.slot_idx = ref->slot_idx,
+			.duration = ref->duration,
+		},
+		.slots[1] = {
+			.slot_idx = aux->slot_idx,
+			.duration = aux->duration,
+		},
+	};
+	struct rtw89_fw_mrc_sync_arg sync_arg = {
+		.offset = sync->offset,
+		.src = {
+			.band = sync->band_src,
+			.port = sync->port_src,
+		},
+		.dest = {
+			.band = sync->band_tgt,
+			.port = sync->port_tgt,
+		},
+
+	};
+	int ret;
+
+	ret = rtw89_fw_h2c_mrc_upd_duration(rtwdev, &dur_arg);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC h2c failed to update duration: %d\n", ret);
+		return ret;
+	}
+
+	if (!sync->enable || !sync_changed)
+		return 0;
+
+	ret = rtw89_fw_h2c_mrc_sync(rtwdev, &sync_arg);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC h2c failed to trigger sync: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1593,7 +1898,11 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	ret = __mcc_fw_start(rtwdev, false);
+	if (rtw89_concurrent_via_mrc(rtwdev))
+		ret = __mrc_fw_start(rtwdev, false);
+	else
+		ret = __mcc_fw_start(rtwdev, false);
+
 	if (ret)
 		return ret;
 
@@ -1611,16 +1920,23 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC stop\n");
 
-	ret = rtw89_fw_h2c_stop_mcc(rtwdev, mcc->group,
-				    ref->rtwvif->mac_id, true);
-	if (ret)
-		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-			    "MCC h2c failed to trigger stop: %d\n", ret);
+	if (rtw89_concurrent_via_mrc(rtwdev)) {
+		ret = rtw89_fw_h2c_mrc_del(rtwdev, mcc->group);
+		if (ret)
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MRC h2c failed to trigger del: %d\n", ret);
+	} else {
+		ret = rtw89_fw_h2c_stop_mcc(rtwdev, mcc->group,
+					    ref->rtwvif->mac_id, true);
+		if (ret)
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MCC h2c failed to trigger stop: %d\n", ret);
 
-	ret = rtw89_fw_h2c_del_mcc_group(rtwdev, mcc->group, true);
-	if (ret)
-		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-			    "MCC h2c failed to delete group: %d\n", ret);
+		ret = rtw89_fw_h2c_del_mcc_group(rtwdev, mcc->group, true);
+		if (ret)
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MCC h2c failed to delete group: %d\n", ret);
+	}
 
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 
@@ -1646,7 +1962,11 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 
 	if (old_cfg.pattern.plan != RTW89_MCC_PLAN_NO_BT ||
 	    config->pattern.plan != RTW89_MCC_PLAN_NO_BT) {
-		ret = __mcc_fw_start(rtwdev, true);
+		if (rtw89_concurrent_via_mrc(rtwdev))
+			ret = __mrc_fw_start(rtwdev, true);
+		else
+			ret = __mcc_fw_start(rtwdev, true);
+
 		if (ret)
 			return ret;
 	} else {
@@ -1655,7 +1975,11 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 		else
 			sync_changed = true;
 
-		ret = __mcc_fw_set_duration_no_bt(rtwdev, sync_changed);
+		if (rtw89_concurrent_via_mrc(rtwdev))
+			ret = __mrc_fw_set_duration_no_bt(rtwdev, sync_changed);
+		else
+			ret = __mcc_fw_set_duration_no_bt(rtwdev, sync_changed);
+
 		if (ret)
 			return ret;
 	}
@@ -1697,12 +2021,75 @@ static void rtw89_mcc_track(struct rtw89_dev *rtwdev)
 	rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_BCN_OFFSET_CHANGE);
 }
 
+static int __mcc_fw_upd_macid_bitmap(struct rtw89_dev *rtwdev,
+				     struct rtw89_mcc_role *upd)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	int ret;
+
+	ret = rtw89_fw_h2c_mcc_macid_bitmap(rtwdev, mcc->group,
+					    upd->rtwvif->mac_id,
+					    upd->macid_bitmap);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to update macid bitmap: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __mrc_fw_upd_macid_bitmap(struct rtw89_dev *rtwdev,
+				     struct rtw89_mcc_role *cur,
+				     struct rtw89_mcc_role *upd)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_fw_mrc_upd_bitmap_arg arg = {};
+	u32 old = rtw89_mcc_role_fw_macid_bitmap_to_u32(cur);
+	u32 new = rtw89_mcc_role_fw_macid_bitmap_to_u32(upd);
+	u32 add = new & ~old;
+	u32 del = old & ~new;
+	int ret;
+	int i;
+
+	arg.sch_idx = mcc->group;
+	arg.macid = upd->rtwvif->mac_id;
+
+	for (i = 0; i < 32; i++) {
+		if (add & BIT(i)) {
+			arg.client_macid = i;
+			arg.action = RTW89_H2C_MRC_UPD_BITMAP_ACTION_ADD;
+
+			ret = rtw89_fw_h2c_mrc_upd_bitmap(rtwdev, &arg);
+			if (ret)
+				goto err;
+		}
+	}
+
+	for (i = 0; i < 32; i++) {
+		if (del & BIT(i)) {
+			arg.client_macid = i;
+			arg.action = RTW89_H2C_MRC_UPD_BITMAP_ACTION_DEL;
+
+			ret = rtw89_fw_h2c_mrc_upd_bitmap(rtwdev, &arg);
+			if (ret)
+				goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MRC h2c failed to update bitmap: %d\n", ret);
+	return ret;
+}
+
 static int rtw89_mcc_upd_map_iterator(struct rtw89_dev *rtwdev,
 				      struct rtw89_mcc_role *mcc_role,
 				      unsigned int ordered_idx,
 				      void *data)
 {
-	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role upd = {
 		.rtwvif = mcc_role->rtwvif,
 	};
@@ -1716,14 +2103,13 @@ static int rtw89_mcc_upd_map_iterator(struct rtw89_dev *rtwdev,
 		   sizeof(mcc_role->macid_bitmap)) == 0)
 		return 0;
 
-	ret = rtw89_fw_h2c_mcc_macid_bitmap(rtwdev, mcc->group,
-					    upd.rtwvif->mac_id,
-					    upd.macid_bitmap);
-	if (ret) {
-		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-			    "MCC h2c failed to update macid bitmap: %d\n", ret);
+	if (rtw89_concurrent_via_mrc(rtwdev))
+		ret = __mrc_fw_upd_macid_bitmap(rtwdev, mcc_role, &upd);
+	else
+		ret = __mcc_fw_upd_macid_bitmap(rtwdev, &upd);
+
+	if (ret)
 		return ret;
-	}
 
 	memcpy(mcc_role->macid_bitmap, upd.macid_bitmap,
 	       sizeof(mcc_role->macid_bitmap));
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6269ae2539b2..d62d23015c48 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4868,6 +4868,9 @@ struct rtw89_mcc_role {
 	struct rtw89_mcc_policy policy;
 	struct rtw89_mcc_limit limit;
 
+	/* only valid when running with FW MRC mechanism */
+	u8 slot_idx;
+
 	/* byte-array in LE order for FW */
 	u8 macid_bitmap[BITS_TO_BYTES(RTW89_MAX_MAC_ID_NUM)];
 
@@ -4911,7 +4914,11 @@ struct rtw89_mcc_sync {
 	bool enable;
 	u16 offset; /* TU */
 	u8 macid_src;
+	u8 band_src;
+	u8 port_src;
 	u8 macid_tgt;
+	u8 band_tgt;
+	u8 port_tgt;
 };
 
 struct rtw89_mcc_config {
-- 
2.25.1


