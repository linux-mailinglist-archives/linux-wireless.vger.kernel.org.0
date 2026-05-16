Return-Path: <linux-wireless+bounces-36512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y9/5EcyCCGrntAMAu9opvQ
	(envelope-from <linux-wireless+bounces-36512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:44:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C979A55C268
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5997930054E4
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D86175A7D;
	Sat, 16 May 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk7xL/zY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A832D0C62
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942663; cv=none; b=q0mPf9yXjW0Y/660m+BZQMZegdQ/3Upyx17CPYTe5SshkIKwK7YKEgZTZ/4P7/mOcCNafgzcVBmXroBVI9LgOJWRyGEPR7FlQQewPgsTjmyGp7WHglKlohQcFYkQOBjz44nXp90QIQRzDky1VccAV+DgodFgLc6hbXpyKM32fJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942663; c=relaxed/simple;
	bh=hhX7VupnZIBNU+xCJPhIxaCAp+psYvacWXM4YDd7NVU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XoxS+NJ7htrjOOVXWOzbC6XZh+X4JdCINYYbG0YQUGk9CJcjeS4IR6JH9njSYmig5Oec1cMf+EMFaHgftH+WX9fPNaKK4quG0OjJArjM37lG43CjSq8ONOAanavq02Z/gfusiEtEIbZM0YXTUWPNLEoqjt7K/4XeWkiRvbC7MFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk7xL/zY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso7754925e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778942660; x=1779547460; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZl5Qjxutj9MrVHdhqPPFp6qk1obCFQzA8z6kde5/fU=;
        b=Wk7xL/zYkZ9KPBmYQ4dhzA9SWU0IT+OClkXuY4BoT+BTZxWsO4mZiKzNREty4czxJQ
         JxK52UGyrLU18OGpgCcuAlmJU88g7agX7FYXqJQFzZwoCSRrulBowMP43ZPzR5KNdRww
         Ebt+78yAl39T9q0bU1vCDeu8v8cP+DKYVDjznolbgKWoxTeqR0MmVnZ0JHw5lEtiersU
         4RGVDMwQUDcFVGhirAUsy6WaGWc0NA40uZ4LKqjoEiiLaqCiEijCHVuHwgVo+/SdPtjb
         14G4R0iTiQHDrsxpiWJ5RAHcrHiKPUPt+rNjcSyOVnaSqRqQeyzqd/S9TNDDdsD00Zhe
         PXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778942660; x=1779547460;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZl5Qjxutj9MrVHdhqPPFp6qk1obCFQzA8z6kde5/fU=;
        b=SQfu/ASP00pA9v5U3orbTd2FR+S90HI9gaxA3awHxRu8ZsmZpvAD1SmCsqFHEU9CH5
         /suAVecfEG1ZekVmtbfs9x3bdJTtHQh7lWq7znfM0ayQpmxwd0BDdZcF+J4etVsj6g9A
         l2JmWmUvxSWoJ87UOUMja3bk2BpwI0+e/uxe8vYAU9u/LbGnMNlejxxvKmAA/DoQVPbH
         nvOs8sSlJBqmnL7SHctcENTwEyFjtWSLIfYLiCDEelg19y7ZF8VpBZoc0wquvfbEZSTL
         lleGMHNoWW/cnAcp5YXStmEXipCRzTmeel/6jeCcitNW2pD+ogd5a5j2lFGbX763a5Cg
         A//A==
X-Gm-Message-State: AOJu0YysAyhqo3hX6fLDluoxA3YC7N8a1rHwseFd6mc9wdK9y6xJ+yPJ
	EYXydiwkbux5yAEhR95/5GPHxrtie/vY03bTlfN+Ga/XtM1jx4Cxql5Wc/vojA==
X-Gm-Gg: Acq92OGgAlueqGhacbW8G5WfSMsQP8ynRM0NW7F/abi4+NGtrigOcHIOrYaAZM4Zz7z
	l5A8dwFFzj9cXVNjiJBCuBFSFGzM3+suCCEwiL2b/6B9P4VMplQ8cLa4Dgya/sXZpbCJip0aHBf
	d+UgkrKuqe5eUfCsYKbUqLMHr2444oKRIsqyLJm2kRJB52lWZ4fi9avbBzzSzLRlJFq6nj9dO9Y
	7vdgV7w/WerVbVyP7DibNbVyMZt79OH6cdmKZDUsSk0w4Wz1mRpD+5g6ZTUAf1QadziZt7T9dBS
	KoSCCM7XvbuRn8jyQw8O0ubRtdEB0jFqpLH52qsRiEIBWGeai8dOwcRh66wsNm1VcCef2S+iZnz
	NeTPXMeIXmdcyttPTbr9CMobWnfGGBNhVVjAujTooocYvjND9BFx57l6BLyglITxWL7vbl+VxY6
	WdO1eySrufGYr0qzewKOHsP0AQjztddg==
X-Received: by 2002:a05:600c:6094:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-48ff64cc4b5mr41812725e9.22.1778942660193;
        Sat, 16 May 2026 07:44:20 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm132054975e9.4.2026.05.16.07.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:44:19 -0700 (PDT)
Message-ID: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
Date: Sat, 16 May 2026 17:44:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, LB F <goainwo@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Fiona Klute <fiona.klute@gmx.de>, andrej.skvortzov@gmail.com,
 anarsoul@gmail.com, Zhen XIN <zhen.xin@nokia-sbell.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX
 descriptor
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C979A55C268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	TAGGED_FROM(0.00)[bounces-36512-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Some RTL8821CE cards can return frames with corrupted RX descriptor,
causing warnings and crashes if they are passed to the upper layers.

The PHY status size field is 4 bits wide, but in rtw88 its value should
only be 0 or 4. Checking this catches most of the corrupt frames.

If a PHY status is present, the PHY status size should not be 0.

The frame size should not be less than or equal to 4 and should not
exceed 11454.

Discard the frame if any of these checks fail.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c  | 16 +++++++++------
 drivers/net/wireless/realtek/rtw88/rx.c   | 24 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/rx.h   |  6 +++---
 drivers/net/wireless/realtek/rtw88/sdio.c |  8 +++++++-
 drivers/net/wireless/realtek/rtw88/usb.c  |  9 ++++++---
 5 files changed, 46 insertions(+), 17 deletions(-)

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
index d9e11343d498..65f6db3d7fcb 100644
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
@@ -303,12 +304,25 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
 		pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
 	}
 
+	if (unlikely(pkt_stat->drv_info_sz &&
+		     pkt_stat->drv_info_sz != PHY_STATUS_SIZE))
+		return -EINVAL;
+
+	if (unlikely(pkt_stat->phy_status && !pkt_stat->drv_info_sz))
+		return -EINVAL;
+
+	if (unlikely(pkt_stat->pkt_len > IEEE80211_MAX_MPDU_LEN_VHT_11454))
+		return -EINVAL;
+
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
@@ -318,5 +332,7 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
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
2.53.0


