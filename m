Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8331160663
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2020 21:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgBPUm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Feb 2020 15:42:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37168 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPUm4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Feb 2020 15:42:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so17235861wru.4
        for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2020 12:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XyPwpmFnM6nIxcbDj+9/XVwqPfkQ/ZJUQm32q7IvYuE=;
        b=HR14qXV00/D+2x1BBlcuFq4U9FKxCbZKGX8juZ5RDJtauXB5HTsaFXNh9VNHUZscfc
         lm7Rl/6bFOJcKN2gCXuW5sbyJzUCNBbPy2c+3DQTcOk2sSkiyPn/uo50sbqlzj8ZCkQw
         fI9LoB5SKwhcGRvHjtKu8VG3QTRbEjJbHjms1FkTnDHq6nCzDBwAcL5kCy24jP1u3fM5
         nK2GGHJsm9Kv/zYn89I4Q7LfQohSEHtTRCzGyRDWK3+Jxrh/gRQlAopC+31RxDngVJDZ
         YfUbsOxb45MsX6c+wcYxedOJyxAk2OLca3xBq6lfOrJ4xFDNEOBrCKYHPRtdG7MWmpqk
         V0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XyPwpmFnM6nIxcbDj+9/XVwqPfkQ/ZJUQm32q7IvYuE=;
        b=HzNahEuVQTTIEBJsvz6JYhzW/LR+yzGj/vsrZ3am0Axpw5FcxQTitV/QidBT3Bndg3
         gktQSv3rOTYl5QGrlcb2Kg4FSVuazvnS56Ou1DyzNa5TxlpLkYRcapNS0GuNW5ThYEuZ
         I6ef78aXKY2zIjgl6eKNaD39BFds6hzPljCf0KqB5YnQE0P66vaLZOyPgkLoBrsrt4a/
         jE5YkkTFU9eRM+S2hcLRijgFHTm4r2etmD4Ci68XT+B9kflOChNhLXIrcFvt9jfAh2Eu
         dJ9CTzsUbJe6enqzSAgG3ubA7q1ctI+bWjV+RTdPDK6SrZ4NwhElm74fWipa83T0Va9F
         PCWw==
X-Gm-Message-State: APjAAAXSNVyYGu5URO+qA5/JUp4fLM7eclrtgvxv9FTHL+TSGZnBTZIk
        e9R8xx8wG9sOVk6sR28feczMIZ6g8JzRVA==
X-Google-Smtp-Source: APXvYqwGud5jf2LTR8l4MYMo2Nj3nEG5FIF4NYSeKs6gUdFOnmlL/M56wT8SMLcVqre9kqVsje8eXA==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr16355292wro.195.1581885772886;
        Sun, 16 Feb 2020 12:42:52 -0800 (PST)
Received: from t2b3 ([109.175.107.56])
        by smtp.gmail.com with ESMTPSA id l131sm17986888wmf.31.2020.02.16.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 12:42:52 -0800 (PST)
Date:   Sun, 16 Feb 2020 21:42:50 +0100
From:   Tobias Predel <tobias.predel@gmail.com>
To:     Bjoern Franke <bjo@schafweide.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
Message-ID: <20200216204250.GA2065@t2b3>
References: <20200214214134.GA12764@t2b3>
 <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
 <028ea5d3-1459-b37e-f996-72958be0ff4c@lwfinger.net>
 <dcd22888-4a60-59f4-3a8e-0b1a49b1e922@schafweide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd22888-4a60-59f4-3a8e-0b1a49b1e922@schafweide.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Sun, Feb 16, 2020 at 02:40:17PM +0100, Bjoern Franke wrote:
> Hi Larry,
> 
> > I deliberately stay behind the official kernel repo so as to avoid implementing
> > any regressions. As you are the one with the problem, you need to perform a
> > bisection to discover which change to rtw88 introduces your difficulty!!
> 
> Somebody commented the DKMS-package for your rtw88-branch with
> 
> "Thank you so much for this ! After kernel 5.5, that's the only way i can
> get functional wifi on my machine. (RTL8822BE) Deeply appreciate it."
> 
> So I assume I'm not the only one experiencing this issue.
> 
> But I can do a bisect if I find some time.
> 
> Regards
> Bjoern
> 
> [1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/

Hello,

no success so far with git bisecting. But maybe ripgrep and git blame
comes to rescue.

Commit 1131ad7fe57541b78db92d1332c69158e13762dc (rtw88: flush hardware
tx queues) introduced that warning I see a lot ("timed out to flush queue X"), 
so maybe that's suspicious, especially when packages could be dropped because the queue
is flushed. 

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index d8c5da342b11..f40877bc9c9a 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -719,6 +719,93 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 	return ret;
 }
 
+static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
+{
+	struct rtw_rqpn *rqpn = rtwdev->fifo.rqpn;
+	u32 prio_queues = 0;
+
+	if (queues & BIT(IEEE80211_AC_VO))
+		prio_queues |= BIT(rqpn->dma_map_vo);
+	if (queues & BIT(IEEE80211_AC_VI))
+		prio_queues |= BIT(rqpn->dma_map_vi);
+	if (queues & BIT(IEEE80211_AC_BE))
+		prio_queues |= BIT(rqpn->dma_map_be);
+	if (queues & BIT(IEEE80211_AC_BK))
+		prio_queues |= BIT(rqpn->dma_map_bk);
+
+	return prio_queues;
+}
+
+static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
+				       u32 prio_queue, bool drop)
+{
+	u32 addr;
+	u16 avail_page, rsvd_page;
+	int i;
+
+	switch (prio_queue) {
+	case RTW_DMA_MAPPING_EXTRA:
+		addr = REG_FIFOPAGE_INFO_4;
+		break;
+	case RTW_DMA_MAPPING_LOW:
+		addr = REG_FIFOPAGE_INFO_2;
+		break;
+	case RTW_DMA_MAPPING_NORMAL:
+		addr = REG_FIFOPAGE_INFO_3;
+		break;
+	case RTW_DMA_MAPPING_HIGH:
+		addr = REG_FIFOPAGE_INFO_1;
+		break;
+	default:
+		return;
+	}
+
+	/* check if all of the reserved pages are available for 100 msecs */
+	for (i = 0; i < 5; i++) {
+		rsvd_page = rtw_read16(rtwdev, addr);
+		avail_page = rtw_read16(rtwdev, addr + 2);
+		if (rsvd_page == avail_page)
+			return;
+
+		msleep(20);
+	}
+
+	/* priority queue is still not empty, throw a warning,
+	 *
+	 * Note that if we want to flush the tx queue when having a lot of
+	 * traffic (ex, 100Mbps up), some of the packets could be dropped.
+	 * And it requires like ~2secs to flush the full priority queue.
+	 */
+	if (!drop)
+		rtw_warn(rtwdev, "timed out to flush queue %d\n", prio_queue);
+}
+
+static void rtw_mac_flush_prio_queues(struct rtw_dev *rtwdev,
+				      u32 prio_queues, bool drop)
+{
+	u32 q;
+
+	for (q = 0; q < RTW_DMA_MAPPING_MAX; q++)
+		if (prio_queues & BIT(q))
+			__rtw_mac_flush_prio_queue(rtwdev, q, drop);
+}
+
+void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop)
+{
+	u32 prio_queues = 0;
+
+	/* If all of the hardware queues are requested to flush,
+	 * or the priority queues are not mapped yet,
+	 * flush all of the priority queues
+	 */
+	if (queues == BIT(rtwdev->hw->queues) - 1 || !rtwdev->fifo.rqpn)
+		prio_queues = BIT(RTW_DMA_MAPPING_MAX) - 1;
+	else
+		prio_queues = get_priority_queues(rtwdev, queues);
+
+	rtw_mac_flush_prio_queues(rtwdev, prio_queues, drop);
+}
+
 static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -743,6 +830,7 @@ static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 		return -EINVAL;
 	}
 
+	rtwdev->fifo.rqpn = rqpn;
 	txdma_pq_map |= BIT_TXDMA_HIQ_MAP(rqpn->dma_map_hi);
 	txdma_pq_map |= BIT_TXDMA_MGQ_MAP(rqpn->dma_map_mg);
 	txdma_pq_map |= BIT_TXDMA_BKQ_MAP(rqpn->dma_map_bk);
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index efe6f731f240..a67fa82973e4 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -31,5 +31,6 @@ int rtw_mac_power_on(struct rtw_dev *rtwdev);
 void rtw_mac_power_off(struct rtw_dev *rtwdev);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
+void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 9c77c86d3021..cb7436949ff6 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -589,6 +589,19 @@ static void rtw_ops_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
+static void rtw_ops_flush(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  u32 queues, bool drop)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_leave_lps_deep(rtwdev);
+
+	rtw_mac_flush_queues(rtwdev, queues, drop);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -608,5 +621,6 @@ const struct ieee80211_ops rtw_ops = {
 	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
 	.set_rts_threshold	= rtw_ops_set_rts_threshold,
 	.sta_statistics		= rtw_ops_sta_statistics,
+	.flush			= rtw_ops_flush,
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index cd34d4d77b52..00d2cf07a176 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -780,6 +780,7 @@ enum rtw_dma_mapping {
 	RTW_DMA_MAPPING_NORMAL	= 2,
 	RTW_DMA_MAPPING_HIGH	= 3,
 
+	RTW_DMA_MAPPING_MAX,
 	RTW_DMA_MAPPING_UNDEF,
 };
 
@@ -1286,7 +1287,7 @@ struct rtw_fifo_conf {
 	u16 rsvd_cpu_instr_addr;
 	u16 rsvd_fw_txbuf_addr;
 	u16 rsvd_csibuf_addr;
-	enum rtw_dma_mapping pq_map[RTW_PQ_MAP_NUM];
+	struct rtw_rqpn *rqpn;
 };
 
 struct rtw_fw_state {

I stick with commit 127eef1d46f80056fe9f18406c6eab38778d8a06 (rtw88: add
TX-AMSDU support) before 1131ad7fe57541b78db92d1332c69158e13762dc
(rtw88: flush hardware tx queues), and that has been working without any problem so far.

Maybe I'll find time to test further.

Regards,
Tobias

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
On Sun, Feb 16, 2020 at 02:40:17PM +0100, Bjoern Franke wrote:
> Hi Larry,
> 
> > I deliberately stay behind the official kernel repo so as to avoid implementing
> > any regressions. As you are the one with the problem, you need to perform a
> > bisection to discover which change to rtw88 introduces your difficulty!!
> 
> Somebody commented the DKMS-package for your rtw88-branch with
> 
> "Thank you so much for this ! After kernel 5.5, that's the only way i can
> get functional wifi on my machine. (RTL8822BE) Deeply appreciate it."
> 
> So I assume I'm not the only one experiencing this issue.
> 
> But I can do a bisect if I find some time.
> 
> Regards
> Bjoern
> 
> [1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
