Return-Path: <linux-wireless+bounces-22440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA29AA8D00
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1114A3A6133
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B514B965;
	Mon,  5 May 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bY7WrZ6y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E81E3775
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429930; cv=none; b=d43dbZ7VTB0l/y7Sblgdq2ot/o3uJOa32E7b4NbpUxnEuLFXTJpedrFKalM2yKoUggIiaDWSYBBq5VfCNl6H1YCiQbsjb0NZoT96b2SYB4OpnQkUEwoe8716IF1hbmEdXh7Hzu8cd1xgWPn6+tJjsM6mipBhLSvw3IsmKjCWh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429930; c=relaxed/simple;
	bh=QzuqAi3ioXgkjvfJA/XanFpTbX0Ad87d/3yPf55UdHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsYLLiqJt3HuniepZhKn+i9MVxGpKshuaGKJKe/SJursyxedURgRIawjs1IBnr8TbrSDlyyfk3y4tifTjrsOMm2sXCpkgfT1bZ9LioiMN5sIDW50O/bspdh89WGAX2NqxxcY/X2uyWWTKnyMFpjwzBBmgmtz/Zx7y8LQd/8Ib78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bY7WrZ6y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457PQPu83831294, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429926; bh=QzuqAi3ioXgkjvfJA/XanFpTbX0Ad87d/3yPf55UdHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bY7WrZ6yfesRtIJR4lP7eqTfmJPK6sJ8CM8pj6wBx7LQoAFprL47NPBLrWD/7TakV
	 Vl0dG+OGJwH1HpLejMZQrObveVBKI42iw8ZjboW8uDL4hUX1PPmSDALl38NwUGMhpb
	 FOdgK0+MSUowI6dXmfDev6KwhT+ASk7NoJvMjfDb/8ssIqw1QiE3fTTjaSrpDX+P/q
	 PrRbSVgdwP4bQi0Uk098X/aZ3uDQsuh44IqSCrUKTAuCJXgXLA37YiG8jC+nvnytJJ
	 7usI8moM/14P1SRgnaI1o/0KMnYc5gO8BDJcvVBthMMhJ9RWGLqEoiSDGfpTyL1uOm
	 K/hGbq1vLMXyw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457PQPu83831294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/11] wifi: rtw89: debug: add mlo_mode dbgfs
Date: Mon, 5 May 2025 15:24:39 +0800
Message-ID: <20250505072440.45113-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

Add an dbgfs mlo_mode to get/set MLO mode. And, support to trigger MLSR
switching. Setting it will automatically disable MLO Dynamic Mechanism
(DM). Then MLO things can follow commands via dbgfs mlo_mode instead of
MLO DM. The disabled DM(s) can be checked/cleared via dbgfs disable_dm.

The following is an use example.

Read it to show current MLD status.
	$ cat mlo_mode

	MLD(s) status: (MLO DM: enable)
		#0: MLO mode 0, valid 0x6, active 0x2

Write it to switch to MLSR on link id 2.
	$ echo 0 2 > mlo_mode
	$ cat mlo_mode

	MLD(s) status: (MLO DM: disable)
		#0: MLO mode 0, valid 0x6, active 0x4

Besides, to be safer, add RWLOCK attribute to dbgfs disable_dm.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |   4 +
 drivers/net/wireless/realtek/rtw89/core.h  |   1 +
 drivers/net/wireless/realtek/rtw89/debug.c | 114 ++++++++++++++++++++-
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 95bdd46376bf..22a0c54de716 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3708,9 +3708,13 @@ static void rtw89_core_mlsr_link_decision(struct rtw89_dev *rtwdev,
 
 static void rtw89_core_mlo_track(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	struct ieee80211_vif *vif;
 	struct rtw89_vif *rtwvif;
 
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_MLO))
+		return;
+
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		vif = rtwvif_to_vif(rtwvif);
 		if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a432dd846a1f..c0f2b62bc43b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4842,6 +4842,7 @@ enum rtw89_dm_type {
 	RTW89_DM_DYNAMIC_EDCCA,
 	RTW89_DM_THERMAL_PROTECT,
 	RTW89_DM_TAS,
+	RTW89_DM_MLO,
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 5442e3c9cbb7..d6016fa107fb 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -85,6 +85,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv phy_info;
 	struct rtw89_debugfs_priv stations;
 	struct rtw89_debugfs_priv disable_dm;
+	struct rtw89_debugfs_priv mlo_mode;
 };
 
 struct rtw89_debugfs_iter_data {
@@ -4136,6 +4137,35 @@ static ssize_t rtw89_debug_priv_stations_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
+static void rtw89_debug_disable_dm_cfg_bmap(struct rtw89_dev *rtwdev, u32 new)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 old = hal->disabled_dm_bitmap;
+
+	if (new == old)
+		return;
+
+	hal->disabled_dm_bitmap = new;
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE, "Disable DM: 0x%x -> 0x%x\n", old, new);
+}
+
+static void rtw89_debug_disable_dm_set_flag(struct rtw89_dev *rtwdev, u8 flag)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 cur = hal->disabled_dm_bitmap;
+
+	rtw89_debug_disable_dm_cfg_bmap(rtwdev, cur | BIT(flag));
+}
+
+static void rtw89_debug_disable_dm_clr_flag(struct rtw89_dev *rtwdev, u8 flag)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 cur = hal->disabled_dm_bitmap;
+
+	rtw89_debug_disable_dm_cfg_bmap(rtwdev, cur & ~BIT(flag));
+}
+
 #define DM_INFO(type) {RTW89_DM_ ## type, #type}
 
 static const struct rtw89_disabled_dm_info {
@@ -4145,6 +4175,7 @@ static const struct rtw89_disabled_dm_info {
 	DM_INFO(DYNAMIC_EDCCA),
 	DM_INFO(THERMAL_PROTECT),
 	DM_INFO(TAS),
+	DM_INFO(MLO),
 };
 
 static ssize_t
@@ -4178,7 +4209,6 @@ rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
 				struct rtw89_debugfs_priv *debugfs_priv,
 				const char *buf, size_t count)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	u32 conf;
 	int ret;
 
@@ -4186,7 +4216,83 @@ rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
 	if (ret)
 		return -EINVAL;
 
-	hal->disabled_dm_bitmap = conf;
+	rtw89_debug_disable_dm_cfg_bmap(rtwdev, conf);
+
+	return count;
+}
+
+static void rtw89_debug_mlo_mode_set_mlsr(struct rtw89_dev *rtwdev,
+					  unsigned int link_id)
+{
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
+		if (!ieee80211_vif_is_mld(vif))
+			continue;
+
+		rtw89_core_mlsr_switch(rtwdev, rtwvif, link_id);
+	}
+}
+
+static ssize_t
+rtw89_debug_priv_mlo_mode_get(struct rtw89_dev *rtwdev,
+			      struct rtw89_debugfs_priv *debugfs_priv,
+			      char *buf, size_t bufsz)
+{
+	bool mlo_dm_dis = rtwdev->hal.disabled_dm_bitmap & BIT(RTW89_DM_MLO);
+	char *p = buf, *end = buf + bufsz;
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+	int count = 0;
+
+	p += scnprintf(p, end - p, "MLD(s) status: (MLO DM: %s)\n",
+		       str_disable_enable(mlo_dm_dis));
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
+		if (!ieee80211_vif_is_mld(vif))
+			continue;
+
+		p += scnprintf(p, end - p,
+			       "\t#%u: MLO mode %x, valid 0x%x, active 0x%x\n",
+			       count++, rtwvif->mlo_mode, vif->valid_links,
+			       vif->active_links);
+	}
+
+	if (count == 0)
+		p += scnprintf(p, end - p, "\t(None)\n");
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_mlo_mode_set(struct rtw89_dev *rtwdev,
+			      struct rtw89_debugfs_priv *debugfs_priv,
+			      const char *buf, size_t count)
+{
+	u8 num, mlo_mode;
+	u32 argv;
+
+	num = sscanf(buf, "%hhx %u", &mlo_mode, &argv);
+	if (num != 2)
+		return -EINVAL;
+
+	rtw89_debug_disable_dm_set_flag(rtwdev, RTW89_DM_MLO);
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE, "Set MLO mode to %x\n", mlo_mode);
+
+	switch (mlo_mode) {
+	case RTW89_MLO_MODE_MLSR:
+		rtw89_debug_mlo_mode_set_mlsr(rtwdev, argv);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_STATE, "Unsupported MLO mode\n");
+		rtw89_debug_disable_dm_clr_flag(rtwdev, RTW89_DM_MLO);
+
+		return -EOPNOTSUPP;
+	}
 
 	return count;
 }
@@ -4247,7 +4353,8 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual, WLOCK),
 	.phy_info = rtw89_debug_priv_get(phy_info),
 	.stations = rtw89_debug_priv_get(stations, RLOCK),
-	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm),
+	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm, RWLOCK),
+	.mlo_mode = rtw89_debug_priv_set_and_get(mlo_mode, RWLOCK),
 };
 
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
@@ -4292,6 +4399,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_r(phy_info);
 	rtw89_debugfs_add_r(stations);
 	rtw89_debugfs_add_rw(disable_dm);
+	rtw89_debugfs_add_rw(mlo_mode);
 }
 
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
-- 
2.25.1


