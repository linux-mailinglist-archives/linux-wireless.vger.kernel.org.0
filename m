Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638D648F366
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 01:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiAOAOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 19:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiAOAOl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 19:14:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075FC061574
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:14:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so8500999wme.4
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifHYhg9lgz2l6KYN7T9KQIx0nPNIgtcpUCQsgxaZoMA=;
        b=cEZobe3snZg+LS4DBgbyL+R1NnTrsVz4ydN3qdF2fYCqWlQJ2Cbq0kRi3abHgg7Pyy
         NgWOJ4ucNJSD/RwOM4pGct8X8eu9gQ+q+1iVBmAKh3s/eOcQKsDZY1YHEd/Z0lb/5uSo
         N9ZnAvYjWeccj/mcO2lISmWEm2oNOhCy+mlvo15+8Kl5jR7IBJYLevx1cHiWztgXZVFo
         mE85SWgDW/A8RAT97lG+y7af438dJAo8KI4OovWH8pTbmNxRfDwvBpfdb/x3N4o067rN
         je1p4BvhgPoAPP1SoKxtIUtiayxy9+LxkbjSev42BMmryHqvwDbpH7oNb+ygIsGbCk7g
         bm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifHYhg9lgz2l6KYN7T9KQIx0nPNIgtcpUCQsgxaZoMA=;
        b=MsOkMa58htl6Yjd3OxWWqN3lqhs2o+lHkt4XAOklK4rJGlmwOXgwZHRTo+9yGCSz94
         D0VS27go7Bf4DjIVVLjPlCGSOvZEoYps/ziCt3gXyuLGbff5lSewEP/ck/y/fzlElr4F
         egD02pBFBVGtt9wyOw5dQIKUvRZ1SHVIKMPNmMcodLZ15dWSnQFfkGhpyY2WBuB4U2db
         2aFsjMG5w6NBo32xebrUTAl9H75rEVhfzKfPCK5Sb2v9G51CkNxNzcG2Wx4I7BSuSn70
         IHRsJRF6u5QTUp9AsCUsAXk6aClMWqHIg5x+xI/ePXRxe7GHZuY+JwmJrZiozAPLuyph
         wt4g==
X-Gm-Message-State: AOAM5302kl/tsRc5Oj+/Rzm/tgil4r81ENghJXiqpLkT7n8j46n1DEzS
        cJXgUEI2FtYv7F9badI+qfhbuQ==
X-Google-Smtp-Source: ABdhPJy7eTZGLQwGRzwQzVazxS1C7tp0MuDjMawxGWQ8D2Y552msPJne3hTr5go8CvPmQR4BUufGqw==
X-Received: by 2002:a05:600c:2194:: with SMTP id e20mr17727570wme.149.1642205679516;
        Fri, 14 Jan 2022 16:14:39 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15sm7379494wmq.6.2022.01.14.16.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:14:39 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/4] wcn36xx: Track SNR and RSSI for each RX frame
Date:   Sat, 15 Jan 2022 00:16:45 +0000
Message-Id: <20220115001646.3981501-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220115001646.3981501-1-bryan.odonoghue@linaro.org>
References: <20220115001646.3981501-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The BDs for each RX frame contain both the RSSI and SNR for the received
frame. If we track and store this information it can be useful to us in
get_survey() and potentially elsewhere.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 12 +++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 31 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 10 +++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index d2b99f6112f6b..0e1f3dc4f69d4 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -331,6 +331,7 @@ static int wcn36xx_start(struct ieee80211_hw *hw)
 
 	INIT_LIST_HEAD(&wcn->vif_list);
 	spin_lock_init(&wcn->dxe_lock);
+	spin_lock_init(&wcn->survey_lock);
 
 	return 0;
 
@@ -394,6 +395,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 	struct wcn36xx_vif *tmp;
 	struct ieee80211_supported_band *band;
 	struct ieee80211_channel *channel;
+	unsigned long flags;
 	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(wcn->hw->wiphy->bands); i++) {
@@ -415,8 +417,10 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 		return;
 	}
 
+	spin_lock_irqsave(&wcn->survey_lock, flags);
 	wcn->band = band;
 	wcn->channel = channel;
+	spin_unlock_irqrestore(&wcn->survey_lock, flags);
 
 	list_for_each_entry(tmp, &wcn->vif_list, list) {
 		vif = wcn36xx_priv_to_vif(tmp);
@@ -1562,6 +1566,7 @@ static int wcn36xx_probe(struct platform_device *pdev)
 	void *wcnss;
 	int ret;
 	const u8 *addr;
+	int n_channels;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "platform probe\n");
 
@@ -1589,6 +1594,13 @@ static int wcn36xx_probe(struct platform_device *pdev)
 		goto out_wq;
 	}
 
+	n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
+	wcn->chan_survey = devm_kmalloc(wcn->dev, n_channels, GFP_KERNEL);
+	if (!wcn->chan_survey) {
+		ret = -ENOMEM;
+		goto out_wq;
+	}
+
 	ret = dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
 	if (ret < 0) {
 		wcn36xx_err("failed to set DMA mask: %d\n", ret);
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index a3eb476c2cbc4..8e8f014225dba 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -271,6 +271,34 @@ static void __skb_queue_purge_irq(struct sk_buff_head *list)
 		dev_kfree_skb_irq(skb);
 }
 
+static void wcn36xx_update_survey(struct wcn36xx *wcn, int rssi, int snr,
+				  int band, int freq)
+{
+	static struct ieee80211_channel *channel;
+	struct ieee80211_supported_band *sband;
+	int idx;
+	int i;
+
+	idx = 0;
+	if (band == NL80211_BAND_5GHZ)
+		idx = wcn->hw->wiphy->bands[NL80211_BAND_2GHZ]->n_channels;
+
+	sband = wcn->hw->wiphy->bands[band];
+	channel = sband->channels;
+
+	for (i = 0; i < sband->n_channels; i++, channel++) {
+		if (channel->center_freq == freq) {
+			idx += i;
+			break;
+		}
+	}
+
+	spin_lock(&wcn->survey_lock);
+	wcn->chan_survey[idx].rssi = rssi;
+	wcn->chan_survey[idx].snr = snr;
+	spin_unlock(&wcn->survey_lock);
+}
+
 int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 {
 	struct ieee80211_rx_status status;
@@ -348,6 +376,9 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 		status.freq = WCN36XX_CENTER_FREQ(wcn);
 	}
 
+	 wcn36xx_update_survey(wcn, status.signal, get_snr(bd),
+			       status.band, status.freq);
+
 	if (bd->rate_id < ARRAY_SIZE(wcn36xx_rate_table)) {
 		rate = &wcn36xx_rate_table[bd->rate_id];
 		status.encoding = rate->encoding;
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index dd2570e468084..81eaa74601d0f 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -194,7 +194,14 @@ struct wcn36xx_sta {
 	enum wcn36xx_ampdu_state ampdu_state[16];
 	int non_agg_frame_ct;
 };
+
 struct wcn36xx_dxe_ch;
+
+struct wcn36xx_chan_survey {
+	s8	rssi;
+	u8	snr;
+};
+
 struct wcn36xx {
 	struct ieee80211_hw	*hw;
 	struct device		*dev;
@@ -284,6 +291,9 @@ struct wcn36xx {
 
 	struct ieee80211_supported_band *band;
 	struct ieee80211_channel *channel;
+
+	spinlock_t survey_lock;		/* protects chan_survey */
+	struct wcn36xx_chan_survey	*chan_survey;
 };
 
 static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
-- 
2.33.0

