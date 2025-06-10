Return-Path: <linux-wireless+bounces-23932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26083AD388B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB2D1BA0681
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6EB2E338B;
	Tue, 10 Jun 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R2T25Txs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD782E339C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560483; cv=none; b=GuZ2zgKX8G6m8+PvCNouaSUpCEG3Wal9QTuKTzljHrrNQm9oNT3DccZ3jEQlB/sjvfy5f8vFihUNmDxKvNirnVKhkSjfq7VxMEGLVA0c1Lw0imdVnFoGB1EkDm8ocIQGIVNO7KAnlEpXwoEue8jsaGR5WGrRIyPXECf1AE6iq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560483; c=relaxed/simple;
	bh=5Pg+9E9K8xkBZEjyDky9X5LIKdgLJfoGfhxvA/dAUTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTeM2Lt8FlKHoBgXuFgu0nP35xLMk8SZmpe/G19WaBqEp8qwdi6PfBu9gG94b4zH0J27oFqkR+Vxq1h2yGC5ICcnllm6JhHr3TZwHPYW7cA2GSkKXIMxYc1R+bqRH/JdNN78ajAj/IoNR4qatbARZ0Mwr50lmCgeyrRorfcSeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R2T25Txs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1IIP02995489, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560478; bh=+BOyrpa7Z8r/9YEDqqjzGxX9jwI1sEoybPPfg/v1W/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R2T25TxsNy77s/V7i/dMrpKhte5wyjqR/pwrCcuTSskot9e/nJoUnB3Jvjv3KMb/X
	 u8JP6znvn2umVKRG643+wxhUx4UoyzvkWbKzm9DVt7KXnLGyNsLZcjQFflitCw2sKo
	 iTB+8Ca+XCNFmzt56YRxPhcSIBMRbNFJOhW/ha0LxAKP4AmlqqwRFGyE/f6zxOfwbi
	 ajBTnhDGOWcHkmEUbMlbVIAw0oZXFYWERLJzCve7sIbiYOTFl3qwGleAdX/hmblXic
	 3f/sH2isd4kHGCJMxzJPszgpOhrGO3vUUXe/cFl1n2pf8i2uT52eoDI4I8DubVHtfJ
	 SE1SmaZioUhVg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1IIP02995489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:19 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/12] wifi: rtw89: mcc: stop TX during MCC prepare
Date: Tue, 10 Jun 2025 21:00:27 +0800
Message-ID: <20250610130034.14692-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Stop TX during the MCC configuration period to prevent packet leakage.
The stop time is defined as 'start_tsf - tsf', which means the duration
from when MCC configuration begins until MCC starts.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 35 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  2 ++
 drivers/net/wireless/realtek/rtw89/core.c |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2575aa174b05..7539bba2e094 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1602,6 +1602,35 @@ static bool rtw89_mcc_duration_decision_on_bt(struct rtw89_dev *rtwdev)
 	return false;
 }
 
+void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						mcc_prepare_done_work.work);
+
+	lockdep_assert_wiphy(wiphy);
+
+	ieee80211_wake_queues(rtwdev->hw);
+}
+
+static void rtw89_mcc_prepare(struct rtw89_dev *rtwdev, bool start)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+
+	if (start) {
+		ieee80211_stop_queues(rtwdev->hw);
+
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work,
+					 usecs_to_jiffies(config->prepare_delay));
+	} else {
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work, 0);
+		wiphy_delayed_work_flush(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work);
+	}
+}
+
 static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1637,6 +1666,8 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 
 	config->start_tsf = start_tsf;
 	config->start_tsf_in_aux_domain = tsf_aux + start_tsf - tsf;
+	config->prepare_delay = start_tsf - tsf;
+
 	return 0;
 }
 
@@ -2247,6 +2278,8 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
 
 	rtw89_mcc_start_beacon_noa(rtwdev);
+
+	rtw89_mcc_prepare(rtwdev, true);
 	return 0;
 }
 
@@ -2335,6 +2368,8 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 
 	rtw89_mcc_stop_beacon_noa(rtwdev);
+
+	rtw89_mcc_prepare(rtwdev, false);
 }
 
 static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 6036f3ca6f67..5f10f3955e5c 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -133,6 +133,8 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 #define rtw89_mgnt_chan_get(rtwdev, link_index) \
 	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
 
+void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work);
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e7e2315d1867..130e89743991 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4884,6 +4884,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_bt_devinfo_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_rfk_chk_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->cfo_track_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->mcc_prepare_done_work);
 	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->antdiv_work);
 
@@ -5110,6 +5111,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_delayed_work_init(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
 	wiphy_delayed_work_init(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	wiphy_delayed_work_init(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	wiphy_delayed_work_init(&rtwdev->mcc_prepare_done_work, rtw89_mcc_prepare_done_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
 	wiphy_delayed_work_init(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 84c0d5814747..ce2f13313826 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5742,6 +5742,7 @@ struct rtw89_mcc_config {
 	struct rtw89_mcc_sync sync;
 	u64 start_tsf;
 	u64 start_tsf_in_aux_domain;
+	u64 prepare_delay;
 	u16 mcc_interval; /* TU */
 	u16 beacon_offset; /* TU */
 };
@@ -5872,6 +5873,7 @@ struct rtw89_dev {
 	struct wiphy_delayed_work coex_bt_devinfo_work;
 	struct wiphy_delayed_work coex_rfk_chk_work;
 	struct wiphy_delayed_work cfo_track_work;
+	struct wiphy_delayed_work mcc_prepare_done_work;
 	struct delayed_work forbid_ba_work;
 	struct wiphy_delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
-- 
2.25.1


