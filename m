Return-Path: <linux-wireless+bounces-21810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F09A95AA4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB1B3B61BD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544C15990C;
	Tue, 22 Apr 2025 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KVzmKPsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8A191F6A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286438; cv=none; b=TEfRslClQSaztliVO8M7JZI3mQXOIgxhFOMLZ0m96tpruK3qSn2fnuHUB+omaQ7ruV9aGLQsLDOK9k2Zf5+XXvx7UZ8+EwJvlpE32i87+OYgbkWMKCrvU6AqT1dEbUMywYJ5YtGaR/qdDOcED4K8jYt8Kt5AbuEDGsd6w3Juiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286438; c=relaxed/simple;
	bh=44JLo5NUffhs5XHuaWUsdgdk8hf8PzxXH+y/XC30FuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+yW0+DCJOUIxP15gYi1HNKPfF1QP5fXHwPsUxUAY0jgEpEdufowuhMwuHh2S6GVk7WSj/fm8Ly0Qdgh0XelxrIUhW56yusemen9bTtDF9nAkY21xPmlmCCPaUYd1qgPABL953I3UjmJYaqlnWH7Za9RbrPlDo3Om7YPi7sus3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KVzmKPsj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lDHS13859535, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286433; bh=44JLo5NUffhs5XHuaWUsdgdk8hf8PzxXH+y/XC30FuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KVzmKPsj3fnBDBMLNrJyx7oExmyBP8IgpWgPwy6gSq2kK1/ccGxysZ1S66TbAvRWO
	 gwXuBq65nS19Gj2BpsH1PjBtcrD6yMoPODlWg1BdeC2PZV2K00KnU5k1aPQOCcFBnX
	 ZAgpw9z1Kb42X6wcojytRu7xNYNf+ui8UP3bOyXdU+ECWbuWt/bi8K9tQh5I/Vjg4z
	 lylLTA4rEZXTwvfsPlBtyXpHVYQRszFp/58mr//iBqCre9gR0nrKe+hxN+d+9mIG7y
	 pPGLt3U8aspGeF3uLWgTOLP/z5WMKlo3sJ50yKwIvoGW+sm6x1rrzN8+7/8FRXPk3/
	 nJnAjTCyIbYiA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lDHS13859535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/12] wifi: rtw89: mcc: make GO announce one-time NoA for HW scan process
Date: Tue, 22 Apr 2025 09:46:13 +0800
Message-ID: <20250422014620.18421-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

Since FW cannot handle HW scan process and MCC (multi-channel concurrency)
mode simultaneously, if a HW scan is requested during MCC, MCC mode will be
paused temporarily. Then, the GO role if any might be absent. So, calculate
an estimated time for the requested HW scan process and search for existing
GO roles to fill one-time NoA.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ae402d4c3773..4173794e3892 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7313,11 +7313,87 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static void rtw89_hw_scan_update_link_beacon_noa(struct rtw89_dev *rtwdev,
+						 struct rtw89_vif_link *rtwvif_link,
+						 u16 tu)
+{
+	struct ieee80211_p2p_noa_desc noa_desc = {};
+	u64 tsf;
+	int ret;
+
+	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
+	if (ret) {
+		rtw89_warn(rtwdev, "%s: failed to get tsf\n", __func__);
+		return;
+	}
+
+	noa_desc.start_time = cpu_to_le32(tsf);
+	noa_desc.interval = cpu_to_le32(ieee80211_tu_to_usec(tu));
+	noa_desc.duration = cpu_to_le32(ieee80211_tu_to_usec(tu));
+	noa_desc.count = 1;
+
+	rtw89_p2p_noa_renew(rtwvif_link);
+	rtw89_p2p_noa_append(rtwvif_link, &noa_desc);
+	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
+}
+
+static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev,
+					    const struct cfg80211_scan_request *req)
+{
+	const struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	const struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_mac_chinfo_ax *chinfo_ax;
+	struct rtw89_mac_chinfo_be *chinfo_be;
+	struct rtw89_vif_link *rtwvif_link;
+	struct list_head *pos, *tmp;
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+	u16 tu = 0;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	list_for_each_safe(pos, tmp, &scan_info->chan_list) {
+		switch (chip->chip_gen) {
+		case RTW89_CHIP_AX:
+			chinfo_ax = list_entry(pos, typeof(*chinfo_ax), list);
+			tu += chinfo_ax->period;
+			break;
+		case RTW89_CHIP_BE:
+			chinfo_be = list_entry(pos, typeof(*chinfo_be), list);
+			tu += chinfo_be->period;
+			break;
+		default:
+			rtw89_warn(rtwdev, "%s: invalid chip gen %d\n",
+				   __func__, chip->chip_gen);
+			return;
+		}
+	}
+
+	if (unlikely(tu == 0)) {
+		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+			    "%s: cannot estimate needed TU\n", __func__);
+		return;
+	}
+
+	list_for_each_entry(rtwvif, &mgnt->active_list, mgnt_entry) {
+		unsigned int link_id;
+
+		vif = rtwvif_to_vif(rtwvif);
+		if (vif->type != NL80211_IFTYPE_AP || !vif->p2p)
+			continue;
+
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_hw_scan_update_link_beacon_noa(rtwdev, rtwvif_link, tu);
+	}
+}
+
 int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 			struct rtw89_vif_link *rtwvif_link,
 			struct ieee80211_scan_request *scan_req)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
 	struct cfg80211_scan_request *req = &scan_req->req;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
@@ -7362,6 +7438,9 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
 
+	if (mode == RTW89_ENTITY_MODE_MCC)
+		rtw89_hw_scan_update_beacon_noa(rtwdev, req);
+
 	return 0;
 }
 
-- 
2.25.1


