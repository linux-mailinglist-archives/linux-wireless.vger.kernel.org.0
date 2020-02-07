Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F11554A0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgBGJ27 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:28:59 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44692 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGJ26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:58 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179SrTY018573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179SrTY018573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:53 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:52 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:52 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:52 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:51 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 6/8] rtw88: sar: apply dynamic SAR table to tx power limit
Date:   Fri, 7 Feb 2020 17:28:42 +0800
Message-ID: <20200207092844.29175-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092844.29175-1-yhchuang@realtek.com>
References: <20200207092844.29175-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

We apply four frequency ranges to calculate TX power, though RWRD defines
five ranges. RWGS is used to adjust SAR power limit value and define the
upper bound corresponding to geography.

Some sar_read::ops are added to convert to proper unit, because the units
and fields of SAR power limit for each customer ID are different.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/sar.c | 129 +++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
index d81a6511f138..80b8913d1a49 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.c
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -267,17 +267,101 @@ union rtw_sar_rwgs {
 	struct rtw_sar_rwgs_rt rt;
 };
 
+struct rtw_sar_geo_map {
+	int idx;	/* index of rwgs.geo[] */
+	int rd;		/* RTW_REGD_xxx */
+};
+
+static const struct rtw_sar_geo_map geo_map_hp[] = {
+	{RTW_SAR_RWGS_HP_FCC_IC,   RTW_REGD_FCC},
+	{RTW_SAR_RWGS_HP_FCC_IC,   RTW_REGD_IC},
+	{RTW_SAR_RWGS_HP_ETSI_MKK, RTW_REGD_ETSI},
+	{RTW_SAR_RWGS_HP_ETSI_MKK, RTW_REGD_MKK},
+	{RTW_SAR_RWGS_HP_WW_KCC,   RTW_REGD_KCC},
+	{RTW_SAR_RWGS_HP_WW_KCC,   RTW_REGD_WW},
+};
+
+static const struct rtw_sar_geo_map geo_map_rt[] = {
+	{RTW_SAR_RWGS_RT_FCC, RTW_REGD_FCC},
+	{RTW_SAR_RWGS_RT_CE,  RTW_REGD_ETSI},
+	{RTW_SAR_RWGS_RT_MKK, RTW_REGD_MKK},
+	{RTW_SAR_RWGS_RT_IC,  RTW_REGD_IC},
+	{RTW_SAR_RWGS_RT_KCC, RTW_REGD_KCC},
+	{RTW_SAR_RWGS_RT_WW,  RTW_REGD_WW},
+};
+
 struct rtw_sar_read {
+	int (*rwsi_mode)(struct rtw_dev *rtwdev, int path);
+	int (*rwrd_base_q3)(struct rtw_dev *rtwdev, int mode, int path, int chidx);
+	int (*rwgs_delta_q3)(struct rtw_dev *rtwdev, int gi, int path, int band);
+	int (*rwgs_max_q3)(struct rtw_dev *rtwdev, int gi, int band);
+	const struct rtw_sar_geo_map *gm, *gm_end;
 	int rwsi_sz;
 	int rwgs_sz;
 };
 
+static int rwsi_mode_hp(struct rtw_dev *rtwdev, int path)
+{
+	return rtwdev->sar.rwsi->hp.index[path] - 1;
+}
+
+static int rwrd_base_q3_hp(struct rtw_dev *rtwdev, int mode, int path, int chidx)
+{
+	int sar;
+
+	sar = rtwdev->sar.rwrd->mode[mode].chain[path].limit[chidx];
+
+	return (10 << 3) + (sar << 2);
+}
+
+static int rwgs_delta_q3_hp(struct rtw_dev *rtwdev, int gi, int path, int band)
+{
+	return rtwdev->sar.rwgs->hp.geo[gi].band[band].delta[path] << 2;
+}
+
+static int rwgs_max_q3_hp(struct rtw_dev *rtwdev, int gi, int band)
+{
+	return (10 << 3) + (rtwdev->sar.rwgs->hp.geo[gi].band[band].max << 2);
+}
+
 static const struct rtw_sar_read sar_read_hp = {
+	.rwsi_mode = rwsi_mode_hp,
+	.rwrd_base_q3 = rwrd_base_q3_hp,
+	.rwgs_delta_q3 = rwgs_delta_q3_hp,
+	.rwgs_max_q3 = rwgs_max_q3_hp,
+	.gm = geo_map_hp,
+	.gm_end = geo_map_hp + ARRAY_SIZE(geo_map_hp),
 	.rwsi_sz = sizeof(struct rtw_sar_rwsi_hp),
 	.rwgs_sz = sizeof(struct rtw_sar_rwgs_hp),
 };
 
+static int rwsi_mode_rt(struct rtw_dev *rtwdev, int path)
+{
+	return rtwdev->sar.rwsi->rt.index - 1;
+}
+
+static int rwrd_base_q3_rt(struct rtw_dev *rtwdev, int mode, int path, int chidx)
+{
+	return rtwdev->sar.rwrd->mode[mode].chain[path].limit[chidx] << 3;
+}
+
+static int rwgs_delta_q3_rt(struct rtw_dev *rtwdev, int gi, int path, int band)
+{
+	return rtwdev->sar.rwgs->rt.geo[gi].band[band].delta << 2;
+}
+
+static int rwgs_max_q3_rt(struct rtw_dev *rtwdev, int gi, int band)
+{
+	return rtwdev->sar.rwgs->rt.geo[gi].band[band].max;
+}
+
 static const struct rtw_sar_read sar_read_rt = {
+	.rwsi_mode = rwsi_mode_rt,
+	.rwrd_base_q3 = rwrd_base_q3_rt,
+	.rwgs_delta_q3 = rwgs_delta_q3_rt,
+	.rwgs_max_q3 = rwgs_max_q3_rt,
+	.gm = geo_map_rt,
+	.gm_end = geo_map_rt + ARRAY_SIZE(geo_map_rt),
 	.rwsi_sz = sizeof(struct rtw_sar_rwsi_rt),
 	.rwgs_sz = sizeof(struct rtw_sar_rwgs_rt),
 };
@@ -420,6 +504,49 @@ static bool is_valid_rwgs(struct rtw_dev *rtwdev, const struct rtw_sar_rwrd *rwr
 	return false;
 }
 
+static void rtw_sar_apply_dynamic_tables(struct rtw_dev *rtwdev)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	const struct rtw_sar_read *r = rtwdev->sar.read;
+	const struct rtw_sar_geo_map *gm = r->gm;
+	const struct rtw_sar_geo_map *gm_end = r->gm_end;
+	int path_num = min_t(int, RTW_SAR_RWRD_CHAIN_NR, hal->rf_path_num);
+	int path, mode;
+	int sar, delta, max;
+
+	for (; gm < gm_end; gm++) {
+		for (path = 0; path < path_num; path++) {
+			mode = r->rwsi_mode(rtwdev, path);
+
+			/* 2.4G part */
+			delta = r->rwgs_delta_q3(rtwdev, gm->idx, path, RTW_SAR_RWGS_2G);
+			max = r->rwgs_max_q3(rtwdev, gm->idx, RTW_SAR_RWGS_2G);
+
+			sar = r->rwrd_base_q3(rtwdev, mode, path, RTW_SAR_LMT_CH1_14);
+			sar = min(sar + delta, max);
+			rtw_phy_set_tx_power_sar(rtwdev, gm->rd, path, 1, 14, sar);
+
+			/* 5G part */
+			delta = r->rwgs_delta_q3(rtwdev, gm->idx, path, RTW_SAR_RWGS_5G);
+			max = r->rwgs_max_q3(rtwdev, gm->idx, RTW_SAR_RWGS_5G);
+
+			sar = r->rwrd_base_q3(rtwdev, mode, path, RTW_SAR_LMT_CH36_64);
+			sar = min(sar + delta, max);
+			rtw_phy_set_tx_power_sar(rtwdev, gm->rd, path, 36, 64, sar);
+
+			sar = r->rwrd_base_q3(rtwdev, mode, path, RTW_SAR_LMT_CH100_144);
+			sar = min(sar + delta, max);
+			rtw_phy_set_tx_power_sar(rtwdev, gm->rd, path, 100, 144, sar);
+
+			sar = r->rwrd_base_q3(rtwdev, mode, path, RTW_SAR_LMT_CH149_165);
+			sar = min(sar + delta, max);
+			rtw_phy_set_tx_power_sar(rtwdev, gm->rd, path, 149, 165, sar);
+		}
+	}
+
+	rtwdev->sar.source = RTW_SAR_SOURCE_ACPI_DYNAMIC;
+}
+
 static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
 {
 	struct rtw_sar_rwrd *rwrd;
@@ -457,6 +584,8 @@ static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
 	rtwdev->sar.rwsi = rwsi;
 	rtwdev->sar.rwgs = rwgs;
 
+	rtw_sar_apply_dynamic_tables(rtwdev);
+
 	rtw_dbg(rtwdev, RTW_DBG_REGD, "SAR: RWRD/RWSI/RWGS is adopted\n");
 
 	return 0;
-- 
2.17.1

