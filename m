Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48532633AD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgIIRIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgIIPgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0CAC0612EE
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so2721772wmi.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIQ++UKT6oYR/hsZfYsO+RMpd1GEFf72ZIvF9bXiPlQ=;
        b=p7EQWDcRumAhTs7BdQWkf3UhNppvw8UUCRbS+ZGlEBCWRIpVulDf4lH8vew/MRyvzO
         KzQTBdn1ObJErkSu98x9WEHrQK/NkxvS86ZnwtMi0ccOu7lZjmi91+zcr7uPthx4SF1Q
         4jWUomc9Km1MC9kNUIjDjzBgS/QEYyl+GTOuNhnLHGGr0E3MUf1/hwgDtbES6oRbXkiR
         QXAQmRnCO1Oe6LRCVqA0sLrEoq5epMJbAm+1FmZ+Gdu1VfOybosL4Nvx+xqdE2ht1I/k
         cbXidm9IU5R3gZWP+sza85b5kCUkW6V6CjbDvd/Xx+nS0sNK8kDAqIDVjFOwRQ6NuGiX
         lFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIQ++UKT6oYR/hsZfYsO+RMpd1GEFf72ZIvF9bXiPlQ=;
        b=Zj/juRMDESMiXwF3y+e44Z99vP/yGhHzinTK1urnqOjwUsWDWvWY2k8AUNCJvzXnwS
         huEa1EblbknY15NYuKNYVkhX4NetOTp2OH4Bafbzx9mJOuz+XCTJfwHDI8bBy6lO55vN
         C36MzZgEWUw3THFBCdWTenXL//svCcDziqqP7Xy2MpDcdKygV/0QGewXPN0FDdJ14TQ0
         Chkg/a6TOyW0LvMN20vo4XL9kOfZJNJESGxFIYae/oVrCswR6pQndq/mHZGFSCLDwdaP
         C4SV6MkvkBB3g31B41NEtF6ZqqTCz9ajE7IaSTmCJzlEdO0vIFVqwsCmJwvdUU6LrPQF
         d0Cw==
X-Gm-Message-State: AOAM533uMdNPDdbCjG2XAR7hBWTEBAH8OdqSx5PBYgPeHGS7hFEELpJo
        ySWf1OJ9vWSAXHBm8ewA1/x64Q==
X-Google-Smtp-Source: ABdhPJxG9JgJsVW6LesdHqUAY5NKh3ej57Pr0jBbtGuNRSYbHm4EJb6bpDEyVuhXKxtenvw9lXQXrg==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr4114936wmf.119.1599665791600;
        Wed, 09 Sep 2020 08:36:31 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m185sm4605220wmf.5.2020.09.09.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:30 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 2/4] wcn36xx: Define wcn3680 specific firmware parameters
Date:   Wed,  9 Sep 2020 16:37:15 +0100
Message-Id: <20200909153717.2905037-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
References: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit defines a firmware configuration for the wcn3680 which
represents a working downstream configuration. This configuration has been
successfully applied to the upstream driver with antecedent patches
resulting in the same or better through-put in comparison to the
downstream driver on the test hardware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 96 ++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 55d2609bd9a1..fda2fa0339d9 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -80,6 +80,102 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
 };
 
+struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
+	WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
+	WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
+	WCN36XX_CFG_VAL(LOW_GAIN_OVERRIDE, 0),
+	WCN36XX_CFG_VAL(POWER_STATE_PER_CHAIN, 785),
+	WCN36XX_CFG_VAL(CAL_PERIOD, 5),
+	WCN36XX_CFG_VAL(CAL_CONTROL, 1),
+	WCN36XX_CFG_VAL(PROXIMITY, 0),
+	WCN36XX_CFG_VAL(NETWORK_DENSITY, 3),
+	WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 4096),
+	WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
+	WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
+	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
+	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
+	WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
+	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
+	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
+	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_TWO, 15),
+	WCN36XX_CFG_VAL(FIXED_RATE, 0),
+	WCN36XX_CFG_VAL(RETRYRATE_POLICY, 4),
+	WCN36XX_CFG_VAL(RETRYRATE_SECONDARY, 0),
+	WCN36XX_CFG_VAL(RETRYRATE_TERTIARY, 0),
+	WCN36XX_CFG_VAL(FORCE_POLICY_PROTECTION, 5),
+	WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_24GHZ, 1),
+	WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_5GHZ, 5),
+	WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_24GHZ, 1),
+	WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_5GHZ, 5),
+	WCN36XX_CFG_VAL(MAX_BA_SESSIONS, 40),
+	WCN36XX_CFG_VAL(PS_DATA_INACTIVITY_TIMEOUT, 200),
+	WCN36XX_CFG_VAL(PS_ENABLE_BCN_FILTER, 1),
+	WCN36XX_CFG_VAL(PS_ENABLE_RSSI_MONITOR, 1),
+	WCN36XX_CFG_VAL(NUM_BEACON_PER_RSSI_AVERAGE, 20),
+	WCN36XX_CFG_VAL(STATS_PERIOD, 10),
+	WCN36XX_CFG_VAL(CFP_MAX_DURATION, 30000),
+	WCN36XX_CFG_VAL(FRAME_TRANS_ENABLED, 0),
+	WCN36XX_CFG_VAL(BA_THRESHOLD_HIGH, 128),
+	WCN36XX_CFG_VAL(MAX_BA_BUFFERS, 2560),
+	WCN36XX_CFG_VAL(DYNAMIC_PS_POLL_VALUE, 0),
+	WCN36XX_CFG_VAL(TX_PWR_CTRL_ENABLE, 1),
+	WCN36XX_CFG_VAL(ENABLE_CLOSE_LOOP, 1),
+	WCN36XX_CFG_VAL(ENABLE_LPWR_IMG_TRANSITION, 0),
+	WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_BT, 120000),
+	WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_WLAN, 30000),
+	WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
+	WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
+	WCN36XX_CFG_VAL(TDLS_PUAPSD_MASK, 0),
+	WCN36XX_CFG_VAL(TDLS_PUAPSD_BUFFER_STA_CAPABLE, 1),
+	WCN36XX_CFG_VAL(TDLS_PUAPSD_INACTIVITY_TIME, 0),
+	WCN36XX_CFG_VAL(TDLS_PUAPSD_RX_FRAME_THRESHOLD, 10),
+	WCN36XX_CFG_VAL(TDLS_OFF_CHANNEL_CAPABLE, 1),
+	WCN36XX_CFG_VAL(ENABLE_ADAPTIVE_RX_DRAIN, 1),
+	WCN36XX_CFG_VAL(FLEXCONNECT_POWER_FACTOR, 0),
+	WCN36XX_CFG_VAL(ANTENNA_DIVERSITY, 3),
+	WCN36XX_CFG_VAL(ATH_DISABLE, 0),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_WLAN_LEN, 60000),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_BT_LEN, 90000),
+	WCN36XX_CFG_VAL(BTC_SAP_STATIC_OPP_ACTIVE_WLAN_LEN, 30000),
+	WCN36XX_CFG_VAL(BTC_SAP_STATIC_OPP_ACTIVE_BT_LEN, 30000),
+	WCN36XX_CFG_VAL(ASD_PROBE_INTERVAL, 50),
+	WCN36XX_CFG_VAL(ASD_TRIGGER_THRESHOLD, -60),
+	WCN36XX_CFG_VAL(ASD_RTT_RSSI_HYST_THRESHOLD, 3),
+	WCN36XX_CFG_VAL(BTC_CTS2S_ON_STA_DURING_SCO, 0),
+	WCN36XX_CFG_VAL(RA_FILTER_ENABLE, 0),
+	WCN36XX_CFG_VAL(RA_RATE_LIMIT_INTERVAL, 60),
+	WCN36XX_CFG_VAL(BTC_FATAL_HID_NSNIFF_BLK, 2),
+	WCN36XX_CFG_VAL(BTC_CRITICAL_HID_NSNIFF_BLK, 1),
+	WCN36XX_CFG_VAL(BTC_DYN_A2DP_TX_QUEUE_THOLD, 0),
+	WCN36XX_CFG_VAL(BTC_DYN_OPP_TX_QUEUE_THOLD, 1),
+	WCN36XX_CFG_VAL(MAX_UAPSD_CONSEC_SP, 10),
+	WCN36XX_CFG_VAL(MAX_UAPSD_CONSEC_RX_CNT, 50),
+	WCN36XX_CFG_VAL(MAX_UAPSD_CONSEC_TX_CNT, 50),
+	WCN36XX_CFG_VAL(MAX_UAPSD_CONSEC_TX_CNT_MEAS_WINDOW, 500),
+	WCN36XX_CFG_VAL(MAX_UAPSD_CONSEC_RX_CNT_MEAS_WINDOW, 500),
+	WCN36XX_CFG_VAL(MAX_PSPOLL_IN_WMM_UAPSD_PS_MODE, 0),
+	WCN36XX_CFG_VAL(MAX_UAPSD_INACTIVITY_INTERVALS, 10),
+	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_WMMPS, 1),
+	WCN36XX_CFG_VAL(BURST_MODE_BE_TXOP_VALUE, 0),
+	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 136),
+	WCN36XX_CFG_VAL(BTC_FAST_WLAN_CONN_PREF, 1),
+	WCN36XX_CFG_VAL(ENABLE_RTSCTS_HTVHT, 0),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_WLAN_LEN, 30000),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_BT_LEN, 120000),
+	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 200),
+	WCN36XX_CFG_VAL(TOGGLE_ARP_BDRATES, 0),
+	WCN36XX_CFG_VAL(OPTIMIZE_CA_EVENT, 0),
+	WCN36XX_CFG_VAL(EXT_SCAN_CONC_MODE, 0),
+	WCN36XX_CFG_VAL(BAR_WAKEUP_HOST_DISABLE, 0),
+	WCN36XX_CFG_VAL(SAR_BOFFSET_CORRECTION_ENABLE, 0),
+	WCN36XX_CFG_VAL(BTC_DISABLE_WLAN_LINK_CRITICAL, 5),
+	WCN36XX_CFG_VAL(DISABLE_SCAN_DURING_SCO, 2),
+	WCN36XX_CFG_VAL(CONS_BCNMISS_COUNT, 0),
+	WCN36XX_CFG_VAL(UNITS_OF_BCN_WAIT_TIME, 0),
+	WCN36XX_CFG_VAL(TRIGGER_NULLFRAME_BEFORE_HB, 0),
+	WCN36XX_CFG_VAL(ENABLE_POWERSAVE_OFFLOAD, 0),
+};
+
 static int put_cfg_tlv_u32(struct wcn36xx *wcn, size_t *len, u32 id, u32 value)
 {
 	struct wcn36xx_hal_cfg *entry;
-- 
2.27.0

