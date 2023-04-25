Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315B6EE259
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjDYNBK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjDYNBG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8E6D313
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 06:01:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f7a7f9667bso3503889f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427663; x=1685019663;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmPoewPWtnwui1uDUkvfZnUeluRkJ6v288tRZwsjuSU=;
        b=QniMdxgy6+QC7BxOqL5qtoF4o6Rw8fNOJRbXbZEDRjiIE+37iNHRjetwZDpQHiATw9
         xGMpBoLtXqwdlZHkLyppwv7fNPTZMQ7SAbP7fCGNjZeD2mwxOqa/x24i0OZVxWCyNo0d
         1mQWIRy+ys3R+EfBRtQIIHwOJH4J4R1VpMKGuUWpdrYeIwy7B9UzJgW4kIpG2Sc/9Sen
         SDCwiyDYooZMPpy5cWMXJMAN9bHV5jl8DB6FhfiFXWDrn3HT89T10Koe2u2KBt73leCH
         BXRGf27wesIVdEv8mLePhGEAGuK9Qcn1FdCZVNxjJXYlrvWR7bnqocff5EJBoVhe/4it
         AlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427663; x=1685019663;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmPoewPWtnwui1uDUkvfZnUeluRkJ6v288tRZwsjuSU=;
        b=X/e7GaruSM1TOTexlRBYa6eVw3FiIhy/t9g1uvmNduYc7bn1/9h6NaqmeoBxsKxKYy
         5wy7tKLdjJqKvX5iH7N6pSjsBmFJgA7D2dPmdFahTnx35bAVYK+EeIMbzurL4nar95DZ
         LcAKSTwzbkmkxcz4kNGBTTug7tqJB5i7FXbiaGRK4y6uIYaMsGVCQKAxUbkOJ3tco+kj
         kQSe+RgGiUIAKH8j1h0ifaBjLvehXTToIkds2cRB8ZOIVN/LMEoh+Qt+c5qOSS9Aosk3
         nP7EobvycJafr9do+En7P9FZegrWBXE1XJduhKFHN+X3fIyItkFsH9mDehAKH1ezoD3n
         2q9g==
X-Gm-Message-State: AAQBX9cE8cwpt32/8Rj5iwHuSlWCeOZwI2qWSPoRbIPBtZ2St4Hl84+H
        EPtwtizMjRcwAPhS//00simkgTJzgD0=
X-Google-Smtp-Source: AKy350apRRu7Zro+QnzDdE+HOOEQWzWH6D7EFw4WHCe2Nhb3+r9gpm0eCOFt87DvDP+ZTJql+Q+6lA==
X-Received: by 2002:adf:f8c6:0:b0:2f6:1f96:a95 with SMTP id f6-20020adff8c6000000b002f61f960a95mr11663000wrq.33.1682427662463;
        Tue, 25 Apr 2023 06:01:02 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4cc7000000b002fa5a73bf9bsm13045580wrt.89.2023.04.25.06.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:01:02 -0700 (PDT)
Message-ID: <16d2d1ff-6438-10c9-347f-6e14dd358ccf@gmail.com>
Date:   Tue, 25 Apr 2023 16:01:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Support USB RX aggregation for the newer
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

This was tested with RTL8188FU, RTL8192EU, RTL8710BU, and RTL8192FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Suggestion by Ping-Ke Shih:
   - Add variable hdr to make a long line shorter.
 - Don't say rtl8xxxu_parse_rxdesc16() already handles RX aggregation.
   That function needs more work.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 119 ++++++++++++------
 1 file changed, 78 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd8c8c6d53d6..1ce18dc8a41e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6197,61 +6197,98 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
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
+
+		/*
+		 * Only clone the skb if there's enough data at the end to
+		 * at least cover the rx descriptor
+		 */
+		if (urb_len >= (pkt_offset + sizeof(struct rtl8xxxu_rxdesc24)))
+			next_skb = skb_clone(skb, GFP_ATOMIC);
 
-	if (rx_desc->phy_stats)
-		priv->fops->parse_phystats(priv, rx_status, phy_stats,
-					   rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
-					   rx_desc->crc32 || rx_desc->icverr);
+		rx_status = IEEE80211_SKB_RXCB(skb);
+		memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
 
-	rx_status->mactime = rx_desc->tsfl;
-	rx_status->flag |= RX_FLAG_MACTIME_START;
+		skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc24));
 
-	if (!rx_desc->swdec)
-		rx_status->flag |= RX_FLAG_DECRYPTED;
-	if (rx_desc->crc32)
-		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (rx_desc->bw)
-		rx_status->bw = RATE_INFO_BW_40;
+		phy_stats = (struct rtl8723au_phy_stats *)skb->data;
 
-	if (rx_desc->rxmcs >= DESC_RATE_MCS0) {
-		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
-	} else {
-		rx_status->rate_idx = rx_desc->rxmcs;
-	}
+		skb_pull(skb, drvinfo_sz + desc_shift);
 
-	rx_status->freq = hw->conf.chandef.chan->center_freq;
-	rx_status->band = hw->conf.chandef.chan->band;
+		skb_trim(skb, pkt_len);
+
+		if (rx_desc->rpt_sel) {
+			struct device *dev = &priv->udev->dev;
+			dev_dbg(dev, "%s: C2H packet\n", __func__);
+			rtl8723bu_handle_c2h(priv, skb);
+		} else {
+			struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+			if (rx_desc->phy_stats)
+				priv->fops->parse_phystats(priv, rx_status, phy_stats,
+							   rx_desc->rxmcs, hdr,
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
+
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
