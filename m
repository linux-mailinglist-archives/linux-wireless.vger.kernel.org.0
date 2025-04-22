Return-Path: <linux-wireless+bounces-21811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33914A95AA5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164C23B5F0B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB34156678;
	Tue, 22 Apr 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BOJRSRbO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75B191F6D
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286440; cv=none; b=nUwaPqH7RYRmLNvRc0G4AHYSJn8voLDPy0brs0xfOHsC9D1bhu9F5qSkuA7Wh8UC87fW4wChO7+8x8lNMXFhr5Tx+ymQZs51z+2gVkV/mEkh1+YDVoDAAZsQKzICuyJWaWCjolS9hKkz+0s8SLWNbdIGbwccNwkbLSBDds7LYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286440; c=relaxed/simple;
	bh=S4N/iqv2AF2a4jZqQFAVQtAzm3EVxTw1WCXqlv8tV3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3yD92tz+HXI8GsFpB/b9uco3lK9f+2t7lFcXJTKk13MSZq3ZLqgj1M30triefma99sxDU8+IW0446UI+1YJ8p1iBukKbwvM2M8QO03pVe8pxkSA+CoCNSuKPNPY+dX2lHadbTgD6v3Xu2jCO0eG3e2Vt6zdexa6q0Sq9Zen3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BOJRSRbO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lFWV13859541, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286435; bh=S4N/iqv2AF2a4jZqQFAVQtAzm3EVxTw1WCXqlv8tV3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BOJRSRbOZKVg6SG/W7dUvJch47OB7h07EjRh1J/XTBQZ79C7hhV1kryWuO38TLieo
	 ygIt1D26P/qf1OLXE3/bbU2Bc26IM86c6lUGiBNcLfjQVQT9/caNTz4oqPJT8/kW/h
	 GzUo/T+I6y7jTRHmTzPKFCkZh915dpwGBFib4mx5z0CZGyoJLfXoEkKZ8b7ossGUKf
	 21VvNu6PKsYJztQcYSk6IFsAJ8x1PuTKviN6enWX4Qiex4KK/jIHY7L4dLC276py1H
	 7WeE8ihBn2zZXHS/FcozC1ewK9NRqlNOhpZljJXRtZusVJV2bD6TxIEkejNReHd8zI
	 DRv0bCPQVBYnw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lFWV13859541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/12] wifi: rtw89: don't re-randomize TSF of AP/GO
Date: Tue, 22 Apr 2025 09:46:14 +0800
Message-ID: <20250422014620.18421-7-pkshih@realtek.com>
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

When APs or GOs are up, their TSF start point are randomized to avoid
collisions. However, the TSF of an existing AP/GO would be randomized
multiple times. It caused the TSF is discontinuous to the corresponding
STA/GC sides. So, once TSF has been randomized, don't re-randomize it
unless SER (system error recovery) happens unfortunately.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 drivers/net/wireless/realtek/rtw89/ser.c      | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 189b3526ea9b..ae5df39b68cd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3507,6 +3507,7 @@ struct rtw89_vif_link {
 	u8 hit_rule;
 	u8 last_noa_nr;
 	u64 sync_bcn_tsf;
+	bool rand_tsf_done;
 	bool trigger;
 	bool lsig_txop;
 	u8 tgt_ind;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 650e25f11fe4..592fbb6d2728 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4631,11 +4631,17 @@ static void rtw89_mac_port_tsf_sync_rand(struct rtw89_dev *rtwdev,
 	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE || rtwvif_link == rtwvif_src)
 		return;
 
+	if (rtwvif_link->rand_tsf_done)
+		goto out;
+
 	/* adjust offset randomly to avoid beacon conflict */
 	offset = offset - offset / 4 + get_random_u32() % (offset / 2);
 	rtw89_mac_port_tsf_sync(rtwdev, rtwvif_link, rtwvif_src,
 				(*n_offset) * offset);
 
+	rtwvif_link->rand_tsf_done = true;
+
+out:
 	(*n_offset)++;
 }
 
@@ -4866,6 +4872,8 @@ void rtw89_mac_set_he_tb(struct rtw89_dev *rtwdev,
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif_link);
+
+	rtwvif_link->rand_tsf_done = false;
 }
 
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index d51e3267ab6c..f4384c1c8cb0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -119,6 +119,7 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	rtwvif_link->chanctx_assigned = false;
 	rtwvif_link->chanctx_idx = RTW89_CHANCTX_0;
 	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+	rtwvif_link->rand_tsf_done = false;
 
 	rcu_read_lock();
 
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 0740e303680c..6ab25d71b050 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -309,6 +309,7 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
 		rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
 		rtwvif_link->trigger = false;
+		rtwvif_link->rand_tsf_done = false;
 	}
 }
 
-- 
2.25.1


