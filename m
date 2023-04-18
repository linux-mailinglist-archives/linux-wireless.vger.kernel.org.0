Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4A6E6553
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjDRNE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjDRNEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 09:04:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71917CC1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 06:04:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so1178876f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681823073; x=1684415073;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGy6jodUmVwrRPcXwmnMYYQa5rZSP0qhmnxkzslhlMM=;
        b=W6eElZdn6wiETG1DO7EK8StBqdW+WCtnpSJSSQM2FzzT6lv08AGJQJGiAEJJ1ntxp0
         dSTnRMDsjBs0iinVfmjmKVR3pYak1Bhmw1/ZnHGyjIjU8UN8P99xgizZyomEvEBboAtS
         PZsaCsu6Kk+ggc/oBQbNLvc9L5I9Nh39bVdpvYTe9DpRDNoEjxW5NP85xEtVwUm6+k8s
         LwclqiH0yJgcdNdi5P2yXqRJ9YWAOC7f8kQ1WIJQAd5e5AUjV+Wn7+SgIN16gtw8cZxm
         6S3LkarMF/j3HKpc+XboqhOKG/DS8ffsIGm6dqnm+xyd+c6rB+2ni788zbQOPV4OcLpj
         uABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823073; x=1684415073;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGy6jodUmVwrRPcXwmnMYYQa5rZSP0qhmnxkzslhlMM=;
        b=K6ojuLUv/AayL6gd+We/zrq5bmbzYGFnByICvcL2ShTz+HF+iVsn9vXBbCapXBbMol
         YZ820UUYRh0MMog5WDLEkgrJdbcXjbceELw8TANm2Nw8YLkc6iL6MX9cA+yebvNntz+r
         wX2NG9XqupsFgb4n4xF3V5UxcwPEbL8jFOp1yd3CUY39ScfuOOoqrJVjMeudFG+q8x51
         LFkwTEvVaR5F/Y66Rs//87qrQVvb+xpfPq/Tey87GduU3rgimiY/J0rwPuJHtYujmIWZ
         Or2MGfa1vaZMioNYjioeqoIg0YEy5RotBgA2Pso/9Y6CHsTrd7QT/+Zb5MpcorQ4ps4S
         CjQQ==
X-Gm-Message-State: AAQBX9f+8eQ41BiqlPrCWjLRPRPQloZOldP/yKq1nE7QDjzahnme0uJa
        mRkdeypT2jS8EBuCmWI+KXFt8W5BAlw=
X-Google-Smtp-Source: AKy350bjjMQUQwgHEpPZglAKECdrfl2ZenvA3eOE6k6JdAXZkHTlSBaF+3UtHjvJGjaGoN6ccgabVQ==
X-Received: by 2002:adf:eb84:0:b0:2fb:c131:ad12 with SMTP id t4-20020adfeb84000000b002fbc131ad12mr2248961wrn.63.1681823073081;
        Tue, 18 Apr 2023 06:04:33 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d6a89000000b002cf1c435afcsm13127774wru.11.2023.04.18.06.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:04:32 -0700 (PDT)
Message-ID: <be2cd114-38c6-d539-446a-a35a872449fc@gmail.com>
Date:   Tue, 18 Apr 2023 16:04:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Support USB RX aggregation for the newer
 chips
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver can receive several frames in the same USB transfer.
Add the code to handle this in rtl8xxxu_parse_rxdesc24(), even though
currently all the relevant chips send only one frame per USB transfer
(RTL8723BU, RTL8192EU, RTL8188FU, RTL8710BU).

rtl8xxxu_parse_rxdesc16() used by RTL8723AU, RTL8192CU, and RTL8188EU
already handles RX aggregation.

This was tested with RTL8188FU, RTL8192EU, RTL8710BU, and RTL8192FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 117 ++++++++++++------
 1 file changed, 76 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd8c8c6d53d6..5fccd898d607 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6197,61 +6197,96 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 {
 	struct ieee80211_hw *hw = priv->hw;
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	struct rtl8xxxu_rxdesc24 *rx_desc =
-		(struct rtl8xxxu_rxdesc24 *)skb->data;
+	struct ieee80211_rx_status *rx_status;
+	struct rtl8xxxu_rxdesc24 *rx_desc;
 	struct rtl8723au_phy_stats *phy_stats;
-	__le32 *_rx_desc_le = (__le32 *)skb->data;
-	u32 *_rx_desc = (u32 *)skb->data;
+	struct sk_buff *next_skb = NULL;
+	__le32 *_rx_desc_le;
+	u32 *_rx_desc;
 	int drvinfo_sz, desc_shift;
-	int i;
+	int i, pkt_len, urb_len, pkt_offset;
 
-	for (i = 0; i < (sizeof(struct rtl8xxxu_rxdesc24) / sizeof(u32)); i++)
-		_rx_desc[i] = le32_to_cpu(_rx_desc_le[i]);
+	urb_len = skb->len;
 
-	memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
+	if (urb_len < sizeof(struct rtl8xxxu_rxdesc24)) {
+		kfree_skb(skb);
+		return RX_TYPE_ERROR;
+	}
 
-	skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc24));
+	do {
+		rx_desc = (struct rtl8xxxu_rxdesc24 *)skb->data;
+		_rx_desc_le = (__le32 *)skb->data;
+		_rx_desc = (u32 *)skb->data;
 
-	phy_stats = (struct rtl8723au_phy_stats *)skb->data;
+		for (i = 0; i < (sizeof(struct rtl8xxxu_rxdesc24) / sizeof(u32)); i++)
+			_rx_desc[i] = le32_to_cpu(_rx_desc_le[i]);
 
-	drvinfo_sz = rx_desc->drvinfo_sz * 8;
-	desc_shift = rx_desc->shift;
-	skb_pull(skb, drvinfo_sz + desc_shift);
+		pkt_len = rx_desc->pktlen;
 
-	if (rx_desc->rpt_sel) {
-		struct device *dev = &priv->udev->dev;
-		dev_dbg(dev, "%s: C2H packet\n", __func__);
-		rtl8723bu_handle_c2h(priv, skb);
-		return RX_TYPE_C2H;
-	}
+		drvinfo_sz = rx_desc->drvinfo_sz * 8;
+		desc_shift = rx_desc->shift;
+		pkt_offset = roundup(pkt_len + drvinfo_sz + desc_shift +
+				     sizeof(struct rtl8xxxu_rxdesc24), 8);
 
-	if (rx_desc->phy_stats)
-		priv->fops->parse_phystats(priv, rx_status, phy_stats,
-					   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
-					   rx_desc->crc32 || rx_desc->icverr);
+		/*
+		 * Only clone the skb if there's enough data at the end to
+		 * at least cover the rx descriptor
+		 */
+		if (urb_len >= (pkt_offset + sizeof(struct rtl8xxxu_rxdesc24)))
+			next_skb = skb_clone(skb, GFP_ATOMIC);
 
-	rx_status->mactime = rx_desc->tsfl;
-	rx_status->flag |= RX_FLAG_MACTIME_START;
+		rx_status = IEEE80211_SKB_RXCB(skb);
+		memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
 
-	if (!rx_desc->swdec)
-		rx_status->flag |= RX_FLAG_DECRYPTED;
-	if (rx_desc->crc32)
-		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (rx_desc->bw)
-		rx_status->bw = RATE_INFO_BW_40;
+		skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc24));
 
-	if (rx_desc->rxmcs >= DESC_RATE_MCS0) {
-		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
-	} else {
-		rx_status->rate_idx = rx_desc->rxmcs;
-	}
+		phy_stats = (struct rtl8723au_phy_stats *)skb->data;
+
+		skb_pull(skb, drvinfo_sz + desc_shift);
+
+		skb_trim(skb, pkt_len);
+
+		if (rx_desc->rpt_sel) {
+			struct device *dev = &priv->udev->dev;
+			dev_dbg(dev, "%s: C2H packet\n", __func__);
+			rtl8723bu_handle_c2h(priv, skb);
+		} else {
+			if (rx_desc->phy_stats)
+				priv->fops->parse_phystats(priv, rx_status, phy_stats,
+							   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
+							   rx_desc->crc32 || rx_desc->icverr);
+
+			rx_status->mactime = rx_desc->tsfl;
+			rx_status->flag |= RX_FLAG_MACTIME_START;
+
+			if (!rx_desc->swdec)
+				rx_status->flag |= RX_FLAG_DECRYPTED;
+			if (rx_desc->crc32)
+				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+			if (rx_desc->bw)
+				rx_status->bw = RATE_INFO_BW_40;
 
-	rx_status->freq = hw->conf.chandef.chan->center_freq;
-	rx_status->band = hw->conf.chandef.chan->band;
+			if (rx_desc->rxmcs >= DESC_RATE_MCS0) {
+				rx_status->encoding = RX_ENC_HT;
+				rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
+			} else {
+				rx_status->rate_idx = rx_desc->rxmcs;
+			}
+
+			rx_status->freq = hw->conf.chandef.chan->center_freq;
+			rx_status->band = hw->conf.chandef.chan->band;
+
+			ieee80211_rx_irqsafe(hw, skb);
+		}
+
+		skb = next_skb;
+		if (skb)
+			skb_pull(next_skb, pkt_offset);
+
+		urb_len -= pkt_offset;
+		next_skb = NULL;
+	} while (skb && urb_len >= sizeof(struct rtl8xxxu_rxdesc24));
 
-	ieee80211_rx_irqsafe(hw, skb);
 	return RX_TYPE_DATA_PKT;
 }
 
-- 
2.39.2
