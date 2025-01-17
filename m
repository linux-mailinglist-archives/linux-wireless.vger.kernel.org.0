Return-Path: <linux-wireless+bounces-17625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10666A14A21
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E79416120B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218481F63CF;
	Fri, 17 Jan 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JGLND2Ge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF641F8670
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098952; cv=none; b=cDHVrsjRds92d+ZZiIP29hsLDcPv5JH7K2/XkgjbzshO5MdMHDGU+u303EZogp4Zha6erd8trEqcc7JTaNSxUqaT3l4wams8Tm2wot7iSJPyDh0tndAbIb8kbhxSwkrNMeuV1F6z+qGHnuDW51xNprvgOvj3nwu/6JYUK1nE9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098952; c=relaxed/simple;
	bh=/CaNxImJfNGyCOW0AlWtESNJ2tMXCL1ZBdMuHh7CZVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH5NtuNnE74K6zP0X+xRC8LlKlYh4YchMMtaGVf4rXmD2185s/lBPDYqFMfatwaFwjGDaecji3s+fdRLFFy9p4Su4B5lStRDmkFUDoYbiJdgIJsea4ubj9Q5gWXdT/ndC4FXdQ6kw5Kk9lwvG6SQ9XC5X212WpD8z/aZI7E88PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JGLND2Ge; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7T3iB42337783, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098943; bh=/CaNxImJfNGyCOW0AlWtESNJ2tMXCL1ZBdMuHh7CZVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JGLND2GeD2acaTnLoXelv8BtUAc+glPT2jJV+8rfQcT0UtUgCk1CKox3yUs60dMyg
	 jFezSBjNlSZnimHD9JwQvCtl4h5n5MS+1aM/5GT04/c6hYO24UdwqaP/lmd8dHVCI+
	 1DICz6fj99bHThZ+EsIOmhrfR1eMwxBAn8xlYlsJODpc0cbUIExfQGcj8CooMFFz0m
	 dmEgwO7x8q1yXtz7Z8NF4ARYd2Jp6zafeTHIntNUZZ5PkBd/CtXyNPHoJfUwNlfni3
	 d7GNMqv5A69iRbsQlz6BiBjBlGs1Q1i0qzlAajovWqaReS6wFSZUgDui2oDfPz3Ihz
	 IMyyhsgtCBvHg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7T3iB42337783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: phy: add PHY context array to support functions per PHY
Date: Fri, 17 Jan 2025 15:28:22 +0800
Message-ID: <20250117072828.16728-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

To support MLO working on PHY 0 and PHY 1, extend existing PHY dynamic
mechanism from PHY 0 to PHY 0/1.

Implement a 2 elements array for two PHY instances, and pass pointer
of each element as argument to existing functions. Then existing algorithm
is kept, unchanged.

Also provide iterate and get function to access PHY context.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  3 ++
 drivers/net/wireless/realtek/rtw89/core.h | 46 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b7987c6b1cd5..42815a58a49a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4867,6 +4867,9 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		rtwdev->mlo_dbcc_mode = MLO_2_PLUS_0_1RF;
 	}
 
+	rtwdev->bbs[RTW89_PHY_0].phy_idx = RTW89_PHY_0;
+	rtwdev->bbs[RTW89_PHY_1].phy_idx = RTW89_PHY_1;
+
 	INIT_WORK(&btc->eapol_notify_work, rtw89_btc_ntfy_eapol_packet_work);
 	INIT_WORK(&btc->arp_notify_work, rtw89_btc_ntfy_arp_packet_work);
 	INIT_WORK(&btc->dhcp_notify_work, rtw89_btc_ntfy_dhcp_packet_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2e04d0eb9405..4e9700ebd7e5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5693,6 +5693,10 @@ struct rtw89_dev {
 	struct rtw89_phy_ul_tb_info ul_tb_info;
 	struct rtw89_antdiv_info antdiv;
 
+	struct rtw89_bb_ctx {
+		enum rtw89_phy_idx phy_idx;
+	} bbs[RTW89_PHY_NUM];
+
 	struct delayed_work track_work;
 	struct delayed_work chanctx_work;
 	struct delayed_work coex_act1_work;
@@ -6978,6 +6982,48 @@ static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
 	}
 }
 
+static inline u8 rtw89_get_active_phy_bitmap(struct rtw89_dev *rtwdev)
+{
+	if (!rtwdev->dbcc_en)
+		return BIT(RTW89_PHY_0);
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_0_PLUS_2_1RF:
+	case MLO_0_PLUS_2_2RF:
+		return BIT(RTW89_PHY_1);
+	case MLO_1_PLUS_1_1RF:
+	case MLO_1_PLUS_1_2RF:
+	case MLO_2_PLUS_2_2RF:
+	case DBCC_LEGACY:
+		return BIT(RTW89_PHY_0) | BIT(RTW89_PHY_1);
+	case MLO_2_PLUS_0_1RF:
+	case MLO_2_PLUS_0_2RF:
+	default:
+		return BIT(RTW89_PHY_0);
+	}
+}
+
+#define rtw89_for_each_active_bb(rtwdev, bb) \
+	for (u8 __active_bb_bitmap = rtw89_get_active_phy_bitmap(rtwdev), \
+	     __phy_idx = 0; __phy_idx < RTW89_PHY_NUM; __phy_idx++) \
+		if (__active_bb_bitmap & BIT(__phy_idx) && \
+		    (bb = &rtwdev->bbs[__phy_idx]))
+
+#define rtw89_for_each_capab_bb(rtwdev, bb) \
+	for (u8 __phy_idx_max = rtwdev->dbcc_en ? RTW89_PHY_1 : RTW89_PHY_0, \
+	     __phy_idx = 0; __phy_idx <= __phy_idx_max; __phy_idx++) \
+		if ((bb = &rtwdev->bbs[__phy_idx]))
+
+static inline
+struct rtw89_bb_ctx *rtw89_get_bb_ctx(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
+{
+	if (phy_idx >= RTW89_PHY_NUM)
+		return &rtwdev->bbs[RTW89_PHY_0];
+
+	return &rtwdev->bbs[phy_idx];
+}
+
 static inline bool rtw89_is_rtl885xb(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
-- 
2.25.1


