Return-Path: <linux-wireless+bounces-11164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4C194CB1E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A1E282379
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DF17BA2;
	Fri,  9 Aug 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T6+sSO8X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0931741C6
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188048; cv=none; b=uduTqCXeghbH1MLVqMmsQdmIEEQWa9G4gLkafHSs7dMTcH8skfjPZtq1hYqJxtZnTNAQn0sZfs1iffBx3CudM8zlCU4gL0uv5XzC6mWR4kn+8vcYVV4aADSArZOwy1kHWfp7ivoxBkWOjF1dQmCt2Er5SfhkUrjHrdYwye3yIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188048; c=relaxed/simple;
	bh=VFJw0ZV3+n0OOowsxblWMpdnPwGolyXw1KIiXr273bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPs/Lk8Y0g4siwSYFRwWwHOSYkagVmEjQMZPMtTM0eX94gIWQ/E7V/13GOvhP9vOSEQMSCJgjHw9MOM2/HvNmeY2IoDygzl2Wt4cL4EMCHdR5BGLSVd8DWnZTLQ3MyEselKvdHWU1tpeMzbawEr3dBEJaxxrJc4fDm2GJ1v+9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T6+sSO8X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797Ki0jA514059, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188044; bh=VFJw0ZV3+n0OOowsxblWMpdnPwGolyXw1KIiXr273bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=T6+sSO8XdfX6GAstVcR5kA0DuXCuLkz9IcwXRUjkSexuHWSBqLSC7b1sVoZPZF2p9
	 UXdl7ipb9hOhf3NP+h1O488MVdBQXZI3aO0i1UuQM5og6yJ3K2Ombr3xayeeQb2Umo
	 TW6I9v1AOZ+j9+p/ZD60QK/3rMLmFpIY5dGT1MIvqqaoV6Eplxx4+ipl/T+p9zC0sB
	 ZrZmR6ipz1LW5kLbBd27gkLjMQmdJ3JK5yMC+YSDJLe7txaMKfkjAQ8nuYWty7yy0o
	 tv4QCXktpjH2PSiz1ZDxck2x0rZQxBPWluw24L1i3vFt5VSpydoic0pKou2C9wb7Y0
	 I46kvVqbMjbug==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797Ki0jA514059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:20:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:20:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 1/6] wifi: rtw89: 8852c: support firmware with fw_element
Date: Fri, 9 Aug 2024 15:20:07 +0800
Message-ID: <20240809072012.84152-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809072012.84152-1-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Firmware from v1 will include fw_element so that the driver will loading
parameters of BB and RF, TX power related tables from firmware. For the
current flow, if fw_element is present, the driver will prioritize
loading parameters and tables from firmware; otherwise, it will
revert to the original loading method.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 100 ++++++++++++------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 6e199e82690b..8fee820be258 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -5,6 +5,7 @@
 #include "chan.h"
 #include "coex.h"
 #include "debug.h"
+#include "fw.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852c.h"
@@ -2985,8 +2986,9 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	}						\
 	__val;						\
 })
-	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -3001,56 +3003,88 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	switch (subband) {
 	default:
 	case RTW89_CH_2G:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_2ga_p;
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_2ga_n;
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_2gb_p;
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_2gb_n;
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_2ga_p;
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_2ga_n;
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_2gb_p;
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_2gb_n;
 		break;
 	case RTW89_CH_5G_BAND_1:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[0];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[0];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[0];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[0];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[0];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[0];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[0];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[0];
 		break;
 	case RTW89_CH_5G_BAND_3:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[1];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[1];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[1];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[1];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[1];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[1];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[1];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[1];
 		break;
 	case RTW89_CH_5G_BAND_4:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[2];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[2];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[2];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[2];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[2];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[2];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[2];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[2];
 		break;
 	case RTW89_CH_6G_BAND_IDX0:
 	case RTW89_CH_6G_BAND_IDX1:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[0];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[0];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[0];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[0];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[0];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][0] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[0];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][0] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[0];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][0] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[0];
 		break;
 	case RTW89_CH_6G_BAND_IDX2:
 	case RTW89_CH_6G_BAND_IDX3:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[1];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[1];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[1];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[1];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][1] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[1];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][1] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[1];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][1] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[1];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][1] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[1];
 		break;
 	case RTW89_CH_6G_BAND_IDX4:
 	case RTW89_CH_6G_BAND_IDX5:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[2];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[2];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[2];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[2];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][2] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[2];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][2] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[2];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][2] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[2];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][2] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[2];
 		break;
 	case RTW89_CH_6G_BAND_IDX6:
 	case RTW89_CH_6G_BAND_IDX7:
-		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[3];
-		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[3];
-		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[3];
-		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[3];
+		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][3] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[3];
+		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][3] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[3];
+		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][3] :
+				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[3];
+		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][3] :
+				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[3];
 		break;
 	}
 
-- 
2.25.1


