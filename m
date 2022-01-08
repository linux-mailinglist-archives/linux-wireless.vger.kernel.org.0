Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10244884D8
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 18:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiAHRI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 12:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiAHRI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 12:08:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD5C06173F
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 09:08:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a5so13705390wrh.5
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 09:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifHYhg9lgz2l6KYN7T9KQIx0nPNIgtcpUCQsgxaZoMA=;
        b=e1Sa4gmSEGM0KwszzJYbFkSYK3l6Cb9Ew3IhFTGgkPfmIdHXXtXUjggNeab/PXZDGs
         l+NxPfRyqTgPsY7yZF/GDfZTNt231h+9YLwSRbLFaWHD2jWX17xWAtwtCw4PHv37WKRX
         5TvccpZL+ZLmtQTt3GVeCl4+i70bW86QyAOT7sQSN39olY5V0KFLWEecaU83OEy4jwi/
         1W6OwPK0Hs362QhRUPZgw6lnhvg6/B1ccyIK0N7pxCbwlOzl8Stj8uIUgnSX9qLieMX2
         mLvhDGlktWbZsaQ6WH8kkFvGEGp6CXpztmKk/OeJyQMFN46hlqIZ9juU+pU4SEy1xvId
         Ob/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifHYhg9lgz2l6KYN7T9KQIx0nPNIgtcpUCQsgxaZoMA=;
        b=LKH9DrthnX+9reJg8oNnaclXYbQ1rCpV8mY2qS03+ui3lfkaizGFMKdpbRObW87sNp
         DMvk69YNLZ7+FCyQGS66Emhu+RS8uhMWB0tqJdvlmOfiaIJzJ/POsjS2ZhRlRThGoYuf
         9iUJ0G1nvqkdnlzfkXdRu3CW3UwohEoBsHdC6aSJ+CG0SVe7aViUITLNqkpQtgBii273
         98TwTxIcoe6U9Zc3GplaM37l1Zn/mfNwuI+R6R4SlN/mqtmoQ07bx30Cf8IG91HD7WoE
         Jl05+MwymxRRZAgYxX3Owdpw9A29GcKk43QLmWMdql6kZirZdBhCspuLEPwPEfbRwRwY
         twSw==
X-Gm-Message-State: AOAM533tFIveg+hg3bfzg6PPmpfDwgcIV+o0yaGEY7bEfHaLIwZtyILS
        ESWZDjNtDr2z8MUrAiUqkFl8hQ==
X-Google-Smtp-Source: ABdhPJzBFcGaNdgVByAcNh091Bc+Shqq/R5YirEAQkGwGenAx/ud00wx2RaylzjRn3qXlxpRapO0Vw==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr59849590wrx.411.1641661733832;
        Sat, 08 Jan 2022 09:08:53 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d22sm2154727wrb.83.2022.01.08.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:08:53 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 3/4] wcn36xx: Track SNR and RSSI for each RX frame
Date:   Sat,  8 Jan 2022 17:10:56 +0000
Message-Id: <20220108171057.1823315-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
References: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
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

