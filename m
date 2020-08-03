Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0571239DA7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHCDKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHCDKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC1C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so32806684wra.5
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqKg5fMNYtu+7rDsvVA0MaJs3YtAp5XzgNcl5s+4fd4=;
        b=Saycvz9MQ9Ohv0fJwdZdL/qyjUexJZnwD+Jrd/rK+5zUNqDDjy08AThpekjcgt5BuN
         4D2EllRjUNbN5nh7iSUc9B7T71SRu5tzAbMyTMUs6IYJQRc67bOaBgwLMa6fX5iJzBvU
         LomJCMpSRXLHqK+YDCXXhozAPPR5ZkDtw1UC0H2oMAKsDh+FTeI8ThyUa3RSMBz/o3/a
         j+HOlWwhP4Nfj2PWP01tNP+jEA+Bavh1TU8/7e6ca4OHRl1+CZE31jr64yeYLVnACcSk
         ha8ew0Pj0Dj/97Vkd+wbGt48XimpsAipAS70CMMFhpsE6dJAosw4GL9h3EvbutQeP7da
         n7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqKg5fMNYtu+7rDsvVA0MaJs3YtAp5XzgNcl5s+4fd4=;
        b=buk1tptq8n8j6XdVXZZ6kwhz7TJ/WVl1wODOOXPjCRiCqEE8XHVw6sJOgue+tNlJfc
         vMDqgfJiFLyoi/j27awOsIokx4tTxzZtlsZGml3gVaoSZfbAf5+s4B32aF8Qh/KkGmdX
         EIYqhkLCQYSUKIXl7rj/jXhrhK9Ia9I6Mz0sa4NXWLTFqJpETna6yvmUoZvI8vb6ENRx
         K7hnaQ06fjO7mji1NrKSO4E5+YkAw7l7hfGYsydGz4DeVaPClLtsPDaREa7KcrcuK/cj
         Sd0TiHOXZJyOfCk9DvaKOfcLVDNqsKF5iSV3g5Elu7MWj1xYprIpfz95xuj6gYFFYEWJ
         S+yg==
X-Gm-Message-State: AOAM530NBUtC1czRJOqjaqDaXtmaTqQUl1pgGxjvEqUxtmekuiAqnOL5
        mkluxDAJpRuVyvu5KIQLvv5Yvw==
X-Google-Smtp-Source: ABdhPJwCrPCJ79rBanCyISinoLx0gq5j/s+Qg9arBytY/gl29Ttb4g3I6rS0QRJTip2/8Dn0qmH8TQ==
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr12550541wrc.377.1596424253092;
        Sun, 02 Aug 2020 20:10:53 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:52 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 06/36] wcn36xx: Add Supported rates V1 structure
Date:   Mon,  3 Aug 2020 04:11:02 +0100
Message-Id: <20200803031132.1427063-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 8df3184a348d..5daac448d4e2 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1405,6 +1405,76 @@ struct wcn36xx_hal_config_sta_req_msg {
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

