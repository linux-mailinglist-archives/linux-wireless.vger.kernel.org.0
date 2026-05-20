Return-Path: <linux-wireless+bounces-36712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNfNF/DGDWr93AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 16:36:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00F58FB82
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB513117C6B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFA3E8358;
	Wed, 20 May 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BieRtyJb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A93E6385
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286473; cv=none; b=ZGbv+rU6w2kKeeUai5twef9aVWVmRRQD7vQh3T6XVArvEkZqPgacJi6WRH8NGgnTxYj0JUXBYw2dF3CFRDqCJM8ZOymNWD+HoUZ9b9QDYHSO/dOi070gnIYg8nr9trtvv4i9KuFkeYoCK9oBz8jlFSkB6YRlxLRQwXXUEEcY7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286473; c=relaxed/simple;
	bh=kRh9ZyZgTFLNgKW16KlXiIAN5c3WuKJNoZKEYOQDPe4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hoyiCh3YAFvwlv1AMiNeyLa/1BBdaYuZA0LP/B6u96sWDSYAIneSBfwzqVrbj6zIssSJ9xJQBARGe3ZRUCVtLcwbDBbGK2j5cA3sOMCiT0s1VHlHyXpu/L3VCjNSe6P4DRZXSduT1yrZZtAwCTORMdL45063s5w8hRff1NeFeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BieRtyJb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44c350a5b87so3032060f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286470; x=1779891270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o7s0p7+ewffOY+jxFRsTxauDV2UMf0ksHaluVvtmEk=;
        b=BieRtyJbIcCQ/x8GKY2f+9lg7NmNdKlYdMKvtFNqv+ZeRsSOS6F1DAaPxDW91eFzXv
         DRn8VS7A/Js70Td7kGz3e7mx0NclrGSYhB0C1A6DKz69smTT8Jc+HTGRLBHiZGlCL7C2
         eTcaL6P31LBdlUPhPPXriJrNEDHLAi13jen75wpdu9YgzBS0yyRzPnYRPnn1AEP8u6ZD
         binmTaNUsC0AK+ypbA2RfqFiBdwztVQrT99NeeoFLdR1hel8DdMbot661zaURNuDAGzQ
         d2uWk1tnNKViDEvEB7HqibXvu7pF1Xr4fiMqvY5H/NWp3EEAHoTbfNhFfoM5dtqWtKnm
         ShIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286470; x=1779891270;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1o7s0p7+ewffOY+jxFRsTxauDV2UMf0ksHaluVvtmEk=;
        b=pal14Rsb79anrFBKilvT6Lj6id4Lr7PwW3b1bVxQtLR1dNHpa9Ujnjby8qNaPVAPsK
         WdeFh5roiG6ncfizlW1o0KVg2FUY9BE0FMIg2fFKTKfZwhSVDIaGggHjylv55uaixuKU
         c2vru3DCPSfArxJHddCuRUEWHQEocZMG2CpGvQ6Yz2IP0EO7xo/DVdvfbs6q2oo7tyyc
         J6/mC6W16DRPUhlM+hZDo1mpbjd76GPloijeD+o7CsExzakAft+P4oBwMXbiXg/iWhNu
         c6QhHGeDs3eXG+4yJtgDMHRCmoM3/mYA1uEPoeLIkg5WxxgbrVS43LX0nniskagUmWRs
         z1bw==
X-Gm-Message-State: AOJu0YzY/oqcd/8wnEzzqnVo9Dw0LnzxFNySd/FqLUYv0MfmwVi0P33v
	jghs637tCVPkBdfN2hPJxUONf9JrKjF/VLALTMnYDmGqaUE3xedeCQyfAar09Q==
X-Gm-Gg: Acq92OEaqH2TYNvKCgM6W8azIKlON1autuKCblzTsPdNv8EwqMkoeYI3ii23xh6GSvg
	SUEmJGi+UV50eifw5z58DNMvx/wVNCu/iPqjQ9yrNMAFN6bJAZgHs/bPNxRc2AhWxhaRUZxEBCj
	PJAKFxixRK4Ui3MBY/0D2+jPgAr6X096FSjtm+/5bOQcowvbKLES1PmUXDoO7aOfSU/WGBpZXPD
	SPq7Q5Gg8+Zy8gQF2yguqlY0H0BtiD/KstQX9CgkbclHDh+WCXUmGye+FenNKRl2UJDFrxlXMTw
	QnL8/IWOFwbIYc7bHrYcBnHOX1ZzatIdDGHBbDHiFuzOeoLgBOWh7auEfjhfiMjhQb9BfrLO6R0
	McYfwE8oeTDwJsC93QvckoGTEI3ZhbPpXbOsENADo/52fUTBVlB63FLPzzKfe/wdyaBZlFqPfvM
	8nwDUqaQqUJNJXzvbQM6iPs3VBhz05bEKhwqUTCCZLMw==
X-Received: by 2002:a05:600c:927:b0:48f:fe2a:1089 with SMTP id 5b1f17b1804b1-48ffe2a10f9mr165175025e9.5.1779286469823;
        Wed, 20 May 2026 07:14:29 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe58638sm128812205e9.17.2026.05.20.07.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:14:29 -0700 (PDT)
Message-ID: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
Date: Wed, 20 May 2026 17:14:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2] wifi: rtw88: Add more validation for the RX
 descriptor
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, LB F <goainwo@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Fiona Klute <fiona.klute@gmx.de>, andrej.skvortzov@gmail.com,
 anarsoul@gmail.com, Zhen XIN <zhen.xin@nokia-sbell.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	TAGGED_FROM(0.00)[bounces-36712-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA00F58FB82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some RTL8821CE cards can return frames with corrupted RX descriptor,
causing warnings and crashes if they are passed to the upper layers.

The PHY status size field is 4 bits wide, but in rtw88 its value should
only be 0 or 4. Checking this catches most of the corrupt frames.

If a PHY status is present, the PHY status size should not be 0.

The frame size should not be less than or equal to 4 and should not
exceed 11454.

The rate should not exceed 4SS MCS9.

Discard the frame if any of these checks fail.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Also drop frames with invalid rate.
---
 drivers/net/wireless/realtek/rtw88/pci.c  | 16 +++++++-----
 drivers/net/wireless/realtek/rtw88/rx.c   | 31 +++++++++++++++--------
 drivers/net/wireless/realtek/rtw88/rx.h   |  6 ++---
 drivers/net/wireless/realtek/rtw88/sdio.c |  8 +++++-
 drivers/net/wireless/realtek/rtw88/usb.c  |  9 ++++---
 5 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index c2bf44e880cf..a30467228912 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1042,20 +1042,21 @@ static int rtw_pci_get_hw_rx_ring_nr(struct rtw_dev *rtwdev,
 static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 			   u8 hw_queue, u32 limit)
 {
+	struct rtw_pci_rx_ring *ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct napi_struct *napi = &rtwpci->napi;
-	struct rtw_pci_rx_ring *ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
-	struct rtw_rx_pkt_stat pkt_stat;
+	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
+	u32 buf_desc_sz = chip->rx_buf_desc_sz;
 	struct ieee80211_rx_status rx_status;
+	struct rtw_rx_pkt_stat pkt_stat;
 	struct sk_buff *skb, *new;
 	u32 cur_rp = ring->r.rp;
 	u32 count, rx_done = 0;
 	u32 pkt_offset;
-	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
-	u32 buf_desc_sz = chip->rx_buf_desc_sz;
+	dma_addr_t dma;
 	u32 new_len;
 	u8 *rx_desc;
-	dma_addr_t dma;
+	int ret;
 
 	count = rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci);
 	count = min(count, limit);
@@ -1067,7 +1068,10 @@ static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 		dma_sync_single_for_cpu(rtwdev->dev, dma, RTK_PCI_RX_BUF_SIZE,
 					DMA_FROM_DEVICE);
 		rx_desc = skb->data;
-		rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat, &rx_status);
+		ret = rtw_rx_query_rx_desc(rtwdev, rx_desc,
+					   &pkt_stat, &rx_status);
+		if (ret)
+			goto next_rp;
 
 		/* offset from rx_desc to payload */
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index d9e11343d498..01fd299abb7f 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -3,6 +3,7 @@
  */
 
 #include "main.h"
+#include "mac.h"
 #include "rx.h"
 #include "ps.h"
 #include "debug.h"
@@ -261,9 +262,9 @@ static void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 	}
 }
 
-void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
-			  struct rtw_rx_pkt_stat *pkt_stat,
-			  struct ieee80211_rx_status *rx_status)
+int rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
+			 struct rtw_rx_pkt_stat *pkt_stat,
+			 struct ieee80211_rx_status *rx_status)
 {
 	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
 	struct rtw_rx_desc *rx_desc = rx_desc8;
@@ -295,20 +296,28 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
 
 	pkt_stat->tsf_low = le32_get_bits(rx_desc->w5, RTW_RX_DESC_W5_TSFL);
 
-	if (unlikely(pkt_stat->rate >= DESC_RATE_MAX)) {
-		rtw_dbg(rtwdev, RTW_DBG_UNEXP,
-			"unexpected RX rate=0x%x\n", pkt_stat->rate);
+	if (unlikely(pkt_stat->rate >= DESC_RATE_MAX))
+		return -EINVAL;
 
-		pkt_stat->rate = DESC_RATE1M;
-		pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
-	}
+	if (unlikely(pkt_stat->drv_info_sz &&
+		     pkt_stat->drv_info_sz != PHY_STATUS_SIZE))
+		return -EINVAL;
+
+	if (unlikely(pkt_stat->phy_status && !pkt_stat->drv_info_sz))
+		return -EINVAL;
+
+	if (unlikely(pkt_stat->pkt_len > IEEE80211_MAX_MPDU_LEN_VHT_11454))
+		return -EINVAL;
 
 	/* drv_info_sz is in unit of 8-bytes */
 	pkt_stat->drv_info_sz *= 8;
 
 	/* c2h cmd pkt's rx/phy status is not interested */
 	if (pkt_stat->is_c2h)
-		return;
+		return 0;
+
+	if (unlikely(pkt_stat->pkt_len <= FCS_LEN))
+		return -EINVAL;
 
 	phy_status = rx_desc8 + desc_sz + pkt_stat->shift;
 	hdr = phy_status + pkt_stat->drv_info_sz;
@@ -318,5 +327,7 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
 		rtwdev->chip->ops->query_phy_status(rtwdev, phy_status, pkt_stat);
 
 	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status);
+
+	return 0;
 }
 EXPORT_SYMBOL(rtw_rx_query_rx_desc);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireless/realtek/rtw88/rx.h
index 6b7dee245c0a..74359f641c76 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -45,9 +45,9 @@ struct rtw_rx_desc {
 
 void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct sk_buff *skb);
-void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
-			  struct rtw_rx_pkt_stat *pkt_stat,
-			  struct ieee80211_rx_status *rx_status);
+int rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
+			 struct rtw_rx_pkt_stat *pkt_stat,
+			 struct ieee80211_rx_status *rx_status);
 void rtw_update_rx_freq_from_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 				struct ieee80211_rx_status *rx_status,
 				struct rtw_rx_pkt_stat *pkt_stat);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 1318e94f8524..5b40d74b16ee 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -995,7 +995,13 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 	while (true) {
 		rx_desc = skb->data;
-		rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat, &rx_status);
+		ret = rtw_rx_query_rx_desc(rtwdev, rx_desc,
+					   &pkt_stat, &rx_status);
+		if (ret) {
+			dev_kfree_skb_any(skb);
+			return;
+		}
+
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
 			     pkt_stat.shift;
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 718940ebba31..6dd8ffedab9a 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -610,8 +610,8 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 	u32 max_skb_len = pkt_desc_sz + PHY_STATUS_SIZE * 8 +
 			  IEEE80211_MAX_MPDU_LEN_VHT_11454;
 	u32 pkt_offset, next_pkt, skb_len;
+	int limit, ret;
 	u8 *rx_desc;
-	int limit;
 
 	for (limit = 0; limit < 200; limit++) {
 		rx_skb = skb_dequeue(&rtwusb->rx_queue);
@@ -627,8 +627,11 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 		rx_desc = rx_skb->data;
 
 		do {
-			rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat,
-					     &rx_status);
+			ret = rtw_rx_query_rx_desc(rtwdev, rx_desc,
+						   &pkt_stat, &rx_status);
+			if (ret)
+				break;
+
 			pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
 				     pkt_stat.shift;
 
-- 
2.54.0


