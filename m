Return-Path: <linux-wireless+bounces-11605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E89566AB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEAE9B24438
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10E15CD60;
	Mon, 19 Aug 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PHpoDlxf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73E15CD7D
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059062; cv=none; b=XoMxI2uK5cCgcusZGSf2MxUMk9Jo2p5zbBJCQPcZb84RvwPv8ScmbWeJlZT2Gjd/x3nnpgV1h12BP4EpGrzpG3E2EOU4P8oyZvJJ8xOVhh/yg1PY6UtHxxLk+CtCIpZTVvpH57HdSa2CL6v/yGdwdcMyWswDeWRSxfV6/By1wIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059062; c=relaxed/simple;
	bh=95D0MJWBvQ7EetauD0w98vndvCspGBFY9JDr5VSwrkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz1Lz7fabOXYtgn3ZHgi+ZaWMHpdqxBBASLGz2MXzX9ZvxldJbStDSLNaZl7e5vcnYkKvTQuClvPA1kF7IjJGBEFu7yFyC5HyIkgdLMnVwC2Z75E9+6lUI7gNDZ78PDZV0ykZ363MMAYWxiY72IJ6vVQzSJHO2B/6qChka8y5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PHpoDlxf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9HbyY64125998, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059057; bh=95D0MJWBvQ7EetauD0w98vndvCspGBFY9JDr5VSwrkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PHpoDlxf+N6Bfbe+xRXyJp5vNnaQAuw9VE6XxqbtE9naWOPfsUzRLwR9sSDXuoCj0
	 KS4iLWw9OEub8iAEE8bqVqW81msL9eTGKXH1PAXWKKEBYlVWUbAP3rq8k3ZpkvoWZL
	 OxXO+qYqEEEs+dfo9i0tMTPVZVIs8iGxMPXo/nLZE2Knsw2ATX4oq1qf0UiK9StfKI
	 eDCWk/ker3KhJLrB4iBN4nKZZ9AlF8eQjSJ0DLi7VuSV+x92HZtBWTZrl82ly04rmq
	 3EeL/EGjXVU1Qw7oZ70xciuubWoebuLQQO8c1LcDuSC3o3Mv3YHz+GFB6fq7Jcvaw9
	 9xWKFidRE2wbg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9HbyY64125998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:17:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:17:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:17:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/8] wifi: rtw89: pass chan to rfk_band_changed()
Date: Mon, 19 Aug 2024 17:17:17 +0800
Message-ID: <20240819091724.33730-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819091724.33730-1-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com>
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

Originally, all chips have implemented rfk_band_changed() and access chan
with hard-code RTW89_CHANCTX_0 in it. But, it's problematic when the chip
supports multiple channels.

So, change the prototype of rfk_band_changed() and pass chan ahead. And,
we will refine the implementation of each chip in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h      | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 3 ++-
 8 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7b28f2c2a08e..e3b72a2b619f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -429,7 +429,7 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	if (!entity_active || chan_rcd->band_changed) {
 		rtw89_btc_ntfy_switch_band(rtwdev, phy_idx, chan->band_type);
-		rtw89_chip_rfk_band_changed(rtwdev, phy_idx);
+		rtw89_chip_rfk_band_changed(rtwdev, phy_idx, chan);
 	}
 
 	rtw89_set_entity_state(rtwdev, true);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3edb2f4372e4..da39c24d1660 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3544,7 +3544,8 @@ struct rtw89_chip_ops {
 	void (*rfk_init_late)(struct rtw89_dev *rtwdev);
 	void (*rfk_channel)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
-				 enum rtw89_phy_idx phy_idx);
+				 enum rtw89_phy_idx phy_idx,
+				 const struct rtw89_chan *chan);
 	void (*rfk_scan)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			 bool start);
 	void (*rfk_track)(struct rtw89_dev *rtwdev);
@@ -6174,12 +6175,13 @@ static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
 }
 
 static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
-					       enum rtw89_phy_idx phy_idx)
+					       enum rtw89_phy_idx phy_idx,
+					       const struct rtw89_chan *chan)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->rfk_band_changed)
-		chip->ops->rfk_band_changed(rtwdev, phy_idx);
+		chip->ops->rfk_band_changed(rtwdev, phy_idx, chan);
 }
 
 static inline void rtw89_chip_rfk_scan(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d1358b9a73f9..d5e42b2ad9ac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1601,7 +1601,8 @@ static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 }
 
 static void rtw8851b_rfk_band_changed(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_idx phy_idx)
+				      enum rtw89_phy_idx phy_idx,
+				      const struct rtw89_chan *chan)
 {
 	rtw8851b_tssi_scan(rtwdev, phy_idx);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1cbea8d665a2..365f074108d4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1361,7 +1361,8 @@ static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 }
 
 static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_idx phy_idx)
+				      enum rtw89_phy_idx phy_idx,
+				      const struct rtw89_chan *chan)
 {
 	rtw8852a_tssi_scan(rtwdev, phy_idx);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 36a81c3323f8..d055847d2de4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -573,7 +573,8 @@ static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 }
 
 static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_idx phy_idx)
+				      enum rtw89_phy_idx phy_idx,
+				      const struct rtw89_chan *chan)
 {
 	rtw8852b_tssi_scan(rtwdev, phy_idx);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 647bc98bcc5d..5eb38370aba4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -546,7 +546,8 @@ static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rt
 }
 
 static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
-				       enum rtw89_phy_idx phy_idx)
+				       enum rtw89_phy_idx phy_idx,
+				       const struct rtw89_chan *chan)
 {
 	rtw8852bt_tssi_scan(rtwdev, phy_idx);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 65e61a2ede27..1fde8a07f73c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1859,7 +1859,8 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 }
 
 static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_idx phy_idx)
+				      enum rtw89_phy_idx phy_idx,
+				      const struct rtw89_chan *chan)
 {
 	rtw8852c_tssi_scan(rtwdev, phy_idx);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 7f4ac8b63e48..d67bbbffb94e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2040,7 +2040,8 @@ static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 }
 
 static void rtw8922a_rfk_band_changed(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_idx phy_idx)
+				      enum rtw89_phy_idx phy_idx,
+				      const struct rtw89_chan *chan)
 {
 	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, RTW89_TSSI_SCAN, 6);
 }
-- 
2.25.1


