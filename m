Return-Path: <linux-wireless+bounces-25436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B917B04F89
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E95F4A7CC9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F702D1925;
	Tue, 15 Jul 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HMXiliEL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A32D12E9
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551621; cv=none; b=Mcc4AthG/LwnFbYS0F9byLgfYKBdtzu57O8adYboWzBbPhlR4Z5UVohAfHESionPg2x+egemyHYqz1pHFfQH6iCnasLYktHoECFIcTqgx8Q31+s2IY0fjBin3iYsyy9hSA0spDtZ0vLwLJ9ZrhObjQ5bNX5MFHXcaGPFN8QONfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551621; c=relaxed/simple;
	bh=Z4Ei3J7Q4zGd7bAUW+tQJTqlgQYcq5oloFVSvyS/gKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHAnvohC0D0QSuKw9ynIx8boF6T8qMndUohYIyaV6BDYY4MhCblAeLEnILPJQik0rEm96+yL/BAyMWZs6MD8aGx5lZHjN3bsz86F+kshkQN+X4NGDXMOVI1Nu0ROOPgIJS9J2HakHzBZg8f+3kK3RhJuKLJ8PUcPZY6CdngbwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HMXiliEL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F3rbCrB3971976, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752551617; bh=BMeB74mMFQ+GMM2bH11CTuFWVFIWXTfDJT9VFZ6thyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HMXiliEL8S1Di9cW8DIeK7mzXIEViuv2paqx4z4BIDj4tvzXHe3dUURfkVKYRSQs3
	 ibCxuH5h4TZJ8DjqvnNDDnSQACU5L5QTmCazb7uqHvEn++JhfLbMpWdHW1VClY3XQv
	 VAv1I9E5szhCmmKlW9jrhzm/8heMD2KGQXt40iOm+MsqLDaSzHXpSAw9GHsI3SPJeG
	 h4RgmkjEB/hZSEMuFVUeoVtqq1Mq9e3Pbe1PTklc/mWuW+O/adcDsuw1lAMr7QNT//
	 FV61Hjei4QLnryH+Mao6O24glBvhU+TJmbcsIsMOi/aOCuMOgfYlxVQHfCNa0aqQJt
	 Or4AhoReBeB+g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F3rbCrB3971976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 11:53:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 11:53:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 11:53:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 4/5] wifi: rtw89: purge obsoleted scan events with software sequence number
Date: Tue, 15 Jul 2025 11:52:58 +0800
Message-ID: <20250715035259.45061-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715035259.45061-1-pkshih@realtek.com>
References: <20250715035259.45061-1-pkshih@realtek.com>
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

The queued and obsoleted scan events can be wrongly treated as events of
new scan request, causing unexpected scan result. Attach a software
sequence number to scan request and its corresponding events. When a new
scan request is acknowledged by firmware, purge the scan events if its
sequence number is not belong to current request.

Normal case:

   mac80211                   event work        event BH
   -------------              ----------        --------
   scan req #1 ---->o
                    |
               <----o  <...........................o
                                  o
                                  |
       <--------------------------+
         ieee80211_scan_completed()

Abnormal case (late event work):

   mac80211                   event work        event BH
   -------------              ----------        --------
   scan req #1 ---->o
                    |
               <----o  <...........................o
                                  o #1

   scan cancel #2 ->o
                    |
               <----o  <...........................o
                                  o #2
                                  | (patch to avoid this)
   scan req #3 ---->o             |
                    |             |
               <----o  <..........|................o
                                  | o #3
       <--------------------------+
         ieee80211_scan_completed()

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 31 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  3 +++
 drivers/net/wireless/realtek/rtw89/mac.c  |  8 ++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 25 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.c  |  2 +-
 6 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a99a0dc710d8..43e10278e14d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5574,6 +5574,7 @@ struct rtw89_hw_scan_info {
 	bool connected;
 	bool abort;
 	u16 delay; /* in unit of ms */
+	u8 seq: 2;
 };
 
 enum rtw89_phy_bb_gain_band {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8230115c29b4..d26626bed960 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6759,6 +6759,34 @@ void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work)
 	}
 }
 
+void rtw89_fw_c2h_purge_obsoleted_scan_events(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct sk_buff *skb, *tmp;
+	int limit;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	limit = skb_queue_len(&rtwdev->c2h_queue);
+
+	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
+		struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(skb);
+
+		if (--limit < 0)
+			return;
+
+		if (!attr->is_scan_event || attr->scan_seq == scan_info->seq)
+			continue;
+
+		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+			    "purge obsoleted scan event with seq=%d (cur=%d)\n",
+			    attr->scan_seq, scan_info->seq);
+
+		skb_unlink(skb, &rtwdev->c2h_queue);
+		dev_kfree_skb_any(skb);
+	}
+}
+
 static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 				  struct rtw89_mac_h2c_info *info)
 {
@@ -8052,7 +8080,8 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 		opt.opch_end = connected ? 0 : RTW89_CHAN_INVALID;
 	}
 
-	ret = mac->scan_offload(rtwdev, &opt, rtwvif_link, false);
+	ret = rtw89_mac_scan_offload(rtwdev, &opt, rtwvif_link, false);
+
 out:
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b64edc9e8abe..7a4ad7a416b8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3570,6 +3570,8 @@ struct rtw89_fw_c2h_attr {
 	u8 class;
 	u8 func;
 	u16 len;
+	u8 is_scan_event: 1;
+	u8 scan_seq: 2;
 };
 
 static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
@@ -4755,6 +4757,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_fw_c2h_purge_obsoleted_scan_events(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta_link *rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3de3ea1e13ad..65d36fcad8b2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5165,6 +5165,7 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 {
 	/* N.B. This will run in interrupt context. */
 	struct rtw89_wait_info *fw_ofld_wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *ps_wait = &rtwdev->mac.ps_wait;
 	const struct rtw89_c2h_done_ack *c2h =
 		(const struct rtw89_c2h_done_ack *)skb_c2h->data;
@@ -5207,9 +5208,11 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
 		case H2C_FUNC_SCANOFLD:
+			scan_info->seq++;
 			cond = RTW89_SCANOFLD_WAIT_COND_START;
 			break;
 		case H2C_FUNC_SCANOFLD_BE:
+			scan_info->seq++;
 			cond = RTW89_SCANOFLD_BE_WAIT_COND_START;
 			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
@@ -5706,10 +5709,15 @@ static void rtw89_mac_c2h_scanofld_rsp_atomic(struct rtw89_dev *rtwdev,
 	const struct rtw89_c2h_scanofld *c2h =
 		(const struct rtw89_c2h_scanofld *)skb->data;
 	struct rtw89_wait_info *fw_ofld_wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(skb);
 	struct rtw89_completion_data data = {};
 	unsigned int cond;
 	u8 status, reason;
 
+	attr->is_scan_event = 1;
+	attr->scan_seq = scan_info->seq;
+
 	status = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_STATUS);
 	reason = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_RSN);
 	data.err = status != RTW89_SCAN_STATUS_SUCCESS;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9f596a06b3d0..241e89983c4a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -6,6 +6,7 @@
 #define __RTW89_MAC_H__
 
 #include "core.h"
+#include "fw.h"
 #include "reg.h"
 
 #define MAC_MEM_DUMP_PAGE_SIZE_AX 0x40000
@@ -1583,4 +1584,28 @@ void rtw89_fwdl_secure_idmem_share_mode(struct rtw89_dev *rtwdev, u8 mode)
 
 	return mac->fwdl_secure_idmem_share_mode(rtwdev, mode);
 }
+
+static inline
+int rtw89_mac_scan_offload(struct rtw89_dev *rtwdev,
+			   struct rtw89_scan_option *option,
+			   struct rtw89_vif_link *rtwvif_link,
+			   bool wowlan)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	int ret;
+
+	ret = mac->scan_offload(rtwdev, option, rtwvif_link, wowlan);
+
+	if (option->enable) {
+		/*
+		 * At this point, new scan request is acknowledged by firmware,
+		 * so scan events of previous scan request become obsoleted.
+		 * Purge the queued scan events to prevent interference to
+		 * current new request.
+		 */
+		rtw89_fw_c2h_purge_obsoleted_scan_events(rtwdev);
+	}
+
+	return ret;
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 4f759c75389e..4dd471b6dd30 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1489,7 +1489,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 		opt.opch_end = RTW89_CHAN_INVALID;
 	}
 
-	mac->scan_offload(rtwdev, &opt, rtwvif_link, true);
+	rtw89_mac_scan_offload(rtwdev, &opt, rtwvif_link, true);
 
 	return 0;
 }
-- 
2.25.1


