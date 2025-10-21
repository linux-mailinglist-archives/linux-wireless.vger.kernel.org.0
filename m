Return-Path: <linux-wireless+bounces-28141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE229BF6CC4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DC6481D80
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35C32ABD0;
	Tue, 21 Oct 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="d7CLhQOA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF2338587
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053666; cv=none; b=t/AjhtzqpAyV5SJBxJpED7pYFspRHxYUyiViUD89QuukyJEb3y3CRhhb0ViMB8qsVnBjn/M0brKDNKvNPXXpKJWgXEPqjuXqlNNeocuHqC9q5Bep8+aX8UoE+j59kpNCPZd/jiHZhU5KrU7TCJMw/F8GS07OwpGYAF4tzbNvgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053666; c=relaxed/simple;
	bh=GfYZzcj3M6s2/kNc7vqqyT0Y+PqEUaUdjDJNtqWlvBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxAr7+Fnral2T7c4Bpf8yOqC8s88NNLtGAbe+B5VuTy/obzVP1pAiUzlZT29KvpaDIcVwIxksAaKnn8nt0WUoyZYk7RXy0nPSWxYhzF82Buyv8V3QRyFmcEmbQpv7RiWqtfD38MP8vf9lkjZ3V6O62FnAcwyLufIpYbXix6LoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=d7CLhQOA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYJ5G03088093, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053659; bh=aSILFCbMfCcOXFjRs2MXkcDwaOMGxRL3aOufVW+q2Z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=d7CLhQOAHCgsPmJu9N0KCyPFn9N2cSOW0MUTuHvdj0u3+Bsv/2I5+R+Tvvx+BqRSN
	 DyffnjdeChM+GzZ9bi7I8Ij+f352ruTAX5f+pksAC+AsH59lvqnu4W2QSAYhtS4aW1
	 LjD8yifkuuBEy6LBum8tp7P8Eik1F98M/gBKwMF5aoAY/Gsa/wjsw5ZDXoDJjiOxiF
	 xr1w8Gq70ZZkZupc2yA3fYh71rw5aGFgM6GJk1r1W0xWnB73PSNP27ObhHpuD/PLc0
	 WS8OUFIMgCEoOSdoUa7LKl9XeZwApF6IhqOYsugz30BXMmAQT/L2C9hQeaEjN++jGT
	 UE8GWFApnQTGg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYJ5G03088093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:19 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:19 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 1/8] wifi: rtw89: splice C2H events queue to local to prevent racing
Date: Tue, 21 Oct 2025 21:33:55 +0800
Message-ID: <20251021133402.15467-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RX task enqueues C2H events and fork a C2H work to handle events, but
the work uses skb_queue_walk_safe() without a lock causing potential
racing. Use skb_queue_splice() and its friends with spin_lock to splice
the queue to local, and then still use skb_queue_walk_safe() to iterate
all events.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 31 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ab904a7def1b..9a926bb2cf00 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6891,11 +6891,18 @@ void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						c2h_work);
 	struct sk_buff *skb, *tmp;
+	struct sk_buff_head c2hq;
+	unsigned long flags;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
-	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
-		skb_unlink(skb, &rtwdev->c2h_queue);
+	__skb_queue_head_init(&c2hq);
+
+	spin_lock_irqsave(&rtwdev->c2h_queue.lock, flags);
+	skb_queue_splice_init(&rtwdev->c2h_queue, &c2hq);
+	spin_unlock_irqrestore(&rtwdev->c2h_queue.lock, flags);
+
+	skb_queue_walk_safe(&c2hq, skb, tmp) {
 		rtw89_fw_c2h_cmd_handle(rtwdev, skb);
 		dev_kfree_skb_any(skb);
 	}
@@ -6905,17 +6912,19 @@ void rtw89_fw_c2h_purge_obsoleted_scan_events(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct sk_buff *skb, *tmp;
-	int limit;
+	struct sk_buff_head c2hq;
+	unsigned long flags;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
-	limit = skb_queue_len(&rtwdev->c2h_queue);
+	__skb_queue_head_init(&c2hq);
 
-	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
-		struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(skb);
+	spin_lock_irqsave(&rtwdev->c2h_queue.lock, flags);
+	skb_queue_splice_init(&rtwdev->c2h_queue, &c2hq);
+	spin_unlock_irqrestore(&rtwdev->c2h_queue.lock, flags);
 
-		if (--limit < 0)
-			return;
+	skb_queue_walk_safe(&c2hq, skb, tmp) {
+		struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(skb);
 
 		if (!attr->is_scan_event || attr->scan_seq == scan_info->seq)
 			continue;
@@ -6924,9 +6933,13 @@ void rtw89_fw_c2h_purge_obsoleted_scan_events(struct rtw89_dev *rtwdev)
 			    "purge obsoleted scan event with seq=%d (cur=%d)\n",
 			    attr->scan_seq, scan_info->seq);
 
-		skb_unlink(skb, &rtwdev->c2h_queue);
+		__skb_unlink(skb, &c2hq);
 		dev_kfree_skb_any(skb);
 	}
+
+	spin_lock_irqsave(&rtwdev->c2h_queue.lock, flags);
+	skb_queue_splice(&c2hq, &rtwdev->c2h_queue);
+	spin_unlock_irqrestore(&rtwdev->c2h_queue.lock, flags);
 }
 
 static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
-- 
2.25.1


