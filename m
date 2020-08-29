Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10191256469
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgH2Dii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgH2DiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F7C061236
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so899294wrw.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrUSz+1vWHM3urmxg+gRDOL5sDh0IwWl1lMxkmx+/w8=;
        b=kv5UYtoW73TpFJamx3FmTdr9yf22LZNZwnNzYkMmBwJTDzwSmbUuqAWF4t0seCeyIa
         qILTgixj8EVNwAIyIZ9kQJuW2uKUnx6oH4KChF/ude7m79fvzPzgSiIQxyJfhFnw+amh
         4drFrrVFXTgru/A88Tdf773cW7usGhnDbln2JQv1+T5lhwJjMMsGDvdeZymBIyHNqzCR
         f6IRRndbGe98Zo0/yprgfwXcB73xcID0UV4gRLMjlZ49V54TsZzZeJzo+XVXctl2A61u
         RdGZQkzR/36FB6x/FXiHcN87nYj9yKxXoCVhQCF3KfEUNBLRdVnvtb9Nb2HwiCE0uMYJ
         UXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrUSz+1vWHM3urmxg+gRDOL5sDh0IwWl1lMxkmx+/w8=;
        b=r/J0RpkOrawv4OUWuszggO87B2oAGoDGSOCpwxcLmivS+ToyBeRmr9BWZ4wnyYVPG8
         uQPKfhEmxNmgNIY4S3SuNMHzu5KJ8kk9X5IRNkdlyeoLo317LJ6v6/3blOOGy1ai8/D4
         HDJwDjh/UOQh63bAX9CvzAWb+jDqrMnbaFLUNkYbKVxJPmBkeZVcPmk3jbCA6Fz4yMWT
         xFW27+yvsqBX3NrVm4N/9IoaK1P9h0Gj9BCj+VFBsBibog75dsyq6zDR5JBidFApuKse
         DiT7hj1ROWuDVH6Mx0TBNrh+/hk7d8If41g1GxKJPU3VL0ZivqFU43eoTYsIY83DGOW/
         ow0A==
X-Gm-Message-State: AOAM5335KzRUjJTlkmy7Aqe3z0nEWuQPNNxH7D4nzw1yvX7G3w0lUJXC
        7nLh8L98DtISXqpGDBIntgpCtw==
X-Google-Smtp-Source: ABdhPJy8Cjny82c2fQZw+7T7vYYGM8lrrRDV+tuFRRgwJNJqKvKlAGU9niRvjoKW1sGjGPshiYXXEA==
X-Received: by 2002:a5d:4352:: with SMTP id u18mr1752280wrr.239.1598672291473;
        Fri, 28 Aug 2020 20:38:11 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 08/10] wcn36xx: Add Supported rates V1 structure
Date:   Sat, 29 Aug 2020 04:38:44 +0100
Message-Id: <20200829033846.2167619-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds the supported rates V1 structure as defined in Prima
riva/inc/wlan_hal_msg.h

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index c7661fb50c10..573799274a02 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1413,6 +1413,76 @@ struct wcn36xx_hal_config_sta_req_msg {
 	struct wcn36xx_hal_config_sta_params sta_params;
 } __packed;
 
+struct wcn36xx_hal_supported_rates_v1 {
+	/* For Self STA Entry: this represents Self Mode.
+	 * For Peer Stations, this represents the mode of the peer.
+	 * On Station:
+	 *
+	 * --this mode is updated when PE adds the Self Entry.
+	 *
+	 * -- OR when PE sends 'ADD_BSS' message and station context in BSS
+	 *    is used to indicate the mode of the AP.
+	 *
+	 * ON AP:
+	 *
+	 * -- this mode is updated when PE sends 'ADD_BSS' and Sta entry
+	 *     for that BSS is used to indicate the self mode of the AP.
+	 *
+	 * -- OR when a station is associated, PE sends 'ADD_STA' message
+	 *    with this mode updated.
+	 */
+
+	enum sta_rate_mode op_rate_mode;
+
+	/* 11b, 11a and aniLegacyRates are IE rates which gives rate in
+	 * unit of 500Kbps
+	 */
+	u16 dsss_rates[WCN36XX_HAL_NUM_DSSS_RATES];
+	u16 ofdm_rates[WCN36XX_HAL_NUM_OFDM_RATES];
+	u16 legacy_rates[WCN36XX_HAL_NUM_POLARIS_RATES];
+	u16 reserved;
+
+	/* Taurus only supports 26 Titan Rates(no ESF/concat Rates will be
+	 * supported) First 26 bits are reserved for those Titan rates and
+	 * the last 4 bits(bit28-31) for Taurus, 2(bit26-27) bits are
+	 * reserved
+	 * Titan and Taurus Rates
+	 */
+	u32 enhanced_rate_bitmap;
+
+	/* 0-76 bits used, remaining reserved
+	 * bits 0-15 and 32 should be set.
+	 */
+	u8 supported_mcs_set[WCN36XX_HAL_MAC_MAX_SUPPORTED_MCS_SET];
+
+	/* RX Highest Supported Data Rate defines the highest data
+	 * rate that the STA is able to receive, in unites of 1Mbps.
+	 * This value is derived from "Supported MCS Set field" inside
+	 * the HT capability element.
+	 */
+	u16 rx_highest_data_rate;
+
+	/* Indicates the Maximum MCS that can be received for each spatial
+	 * stream.
+	 */
+	u16 vht_rx_mcs_map;
+
+	/* Indicates the highest VHT data rate that the STA is able to
+	 * receive.
+	 */
+	u16 vht_rx_highest_data_rate;
+
+	/* Indicates the Maximum MCS that can be transmitted for each spatial
+	 * stream.
+	 */
+	u16 vht_tx_mcs_map;
+
+	/* Indicates the highest VHT data rate that the STA is able to
+	 * transmit.
+	 */
+	u16 vht_tx_highest_data_rate;
+} __packed;
+
 struct wcn36xx_hal_config_sta_params_v1 {
 	/* BSSID of STA */
 	u8 bssid[ETH_ALEN];
-- 
2.27.0

