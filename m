Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D72261A62
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgIHSfT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgIHSc3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9215AC061383
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id q9so290545wmj.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhCY8oQAJMhMp7rjCQoI5czE5oev8Z6ZeTgeJVUiBkc=;
        b=tMYJBYlDunT0VqZ6aVGMfhNKOZo40P08UIcoTouaW1lnyAwvyTzrhseLnZeEj1awnx
         h2iF48axAFDSV5b9ws/rkkoWDN50DR6/L0iVDXRW69SjWBWgWFCnhP4yLQJkyEfzEOco
         dycTyx8DsZNRS3opSd8hrd7l5a4FIBNWhN4127mQp/6Jtuel0Va1bsejqkZAK3nprSwV
         +gd5dhy0VWTZ1I7ImgkFIZmv8jGIfN0EVqkxIc+1fxmCl89tCLOMAkNqgmQUpsnjVzKK
         0L4z0PNR195t9AympQAOaBjDmW7chUY5DTMMUs0TTeY2HzWrq7+NgypJmoJKC3AE3q23
         a5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhCY8oQAJMhMp7rjCQoI5czE5oev8Z6ZeTgeJVUiBkc=;
        b=pMvKoyT+4VI6DLnwTAjo+8Vykx8eJ6K4W49yCnPIjW4shL4jcjiDjYkIzXnVejhmQQ
         VJzOZVF5fzQTo6iW9IG7BGxgU29P3OoNL9k9syC0h9wq2VQbfHoNGCllKSC7jQDhHmPu
         VQDk3P8qfFXiWihEBVqBzA4ZgutyHrob5Xc9m321+X3q8aRlBzv7XHSg/a59Oosu/v7u
         7KI72Y9tyy7TqDm2BinFd0bfy/dw2MxcBZPi0k0ldvh+7sjW4MdVULsWensiSTE8QC4A
         PHtKkfpeT6ipvgr5rhBmLicIBMvNOfVUq8g1+SJ+CCPD0ycuOTXnPX8dE72JX9ZJht74
         6H+A==
X-Gm-Message-State: AOAM531eNONQW4WZwEEssG4llYCOwDQUmLpg3t+WHP4f54qchePOHd7e
        UrSm8IsMdmKMACOMrU5CNB0O8Q==
X-Google-Smtp-Source: ABdhPJzp7/mCXfGbVFJp3oJqGLlZb9BhyNO/v7q/b8Y25H4xRurY3hDs6IS1iNwhaop1ITnTQ7/Qjw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr406613wml.25.1599589483250;
        Tue, 08 Sep 2020 11:24:43 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b84sm381427wmd.0.2020.09.08.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:42 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/4] wcn36xx: Extend HAL param config list
Date:   Tue,  8 Sep 2020 19:25:26 +0100
Message-Id: <20200908182529.2870478-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
References: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to get 802.11ac working the way we want, additional parameters
need to be passed down to the firmware.

This patch takes the full remaining set of parameters defined in the
downstream riva/inc/wlan_hal_cfg.h and imports them into hal.h with some
minor name length adjustments.

This addition will allow us to pass a larger firmware configuration set
later on.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 124 ++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 3cceeaf0136f..65ef893f2736 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -726,7 +726,129 @@ enum pe_stats_mask {
 #define WCN36XX_HAL_CFG_AP_LINK_MONITOR_TIMEOUT		102
 #define WCN36XX_HAL_CFG_BTC_DWELL_TIME_MULTIPLIER	103
 #define WCN36XX_HAL_CFG_ENABLE_TDLS_OXYGEN_MODE		104
-#define WCN36XX_HAL_CFG_MAX_PARAMS			105
+#define WCN36XX_HAL_CFG_ENABLE_NAT_KEEP_ALIVE_FILTER	105
+#define WCN36XX_HAL_CFG_ENABLE_SAP_OBSS_PROT		106
+#define WCN36XX_HAL_CFG_PSPOLL_DATA_RECEP_TIMEOUT	107
+#define WCN36XX_HAL_CFG_TDLS_PUAPSD_BUFFER_STA_CAPABLE	108
+#define WCN36XX_HAL_CFG_TDLS_PUAPSD_MASK		109
+#define WCN36XX_HAL_CFG_TDLS_PUAPSD_INACTIVITY_TIME	110
+#define WCN36XX_HAL_CFG_TDLS_PUAPSD_RX_FRAME_THRESHOLD	111
+#define WCN36XX_HAL_CFG_ANTENNA_DIVERSITY		112
+#define WCN36XX_HAL_CFG_ATH_DISABLE			113
+#define WCN36XX_HAL_CFG_FLEXCONNECT_POWER_FACTOR	114
+#define WCN36XX_HAL_CFG_ENABLE_ADAPTIVE_RX_DRAIN	115
+#define WCN36XX_HAL_CFG_TDLS_OFF_CHANNEL_CAPABLE	116
+#define WCN36XX_HAL_CFG_MWS_COEX_V1_WAN_FREQ		117
+#define WCN36XX_HAL_CFG_MWS_COEX_V1_WLAN_FREQ		118
+#define WCN36XX_HAL_CFG_MWS_COEX_V1_CONFIG		119
+#define WCN36XX_HAL_CFG_MWS_COEX_V1_CONFIG2		120
+#define WCN36XX_HAL_CFG_MWS_COEX_V2_WAN_FREQ		121
+#define WCN36XX_HAL_CFG_MWS_COEX_V2_WLAN_FREQ		122
+#define WCN36XX_HAL_CFG_MWS_COEX_V2_CONFIG		123
+#define WCN36XX_HAL_CFG_MWS_COEX_V2_CONFIG2		124
+#define WCN36XX_HAL_CFG_MWS_COEX_V3_WAN_FREQ		125
+#define WCN36XX_HAL_CFG_MWS_COEX_V3_WLAN_FREQ		126
+#define WCN36XX_HAL_CFG_MWS_COEX_V3_CONFIG		127
+#define WCN36XX_HAL_CFG_MWS_COEX_V3_CONFIG2		128
+#define WCN36XX_HAL_CFG_MWS_COEX_V4_WAN_FREQ		129
+#define WCN36XX_HAL_CFG_MWS_COEX_V4_WLAN_FREQ		130
+#define WCN36XX_HAL_CFG_MWS_COEX_V4_CONFIG		131
+#define WCN36XX_HAL_CFG_MWS_COEX_V4_CONFIG2		132
+#define WCN36XX_HAL_CFG_MWS_COEX_V5_WAN_FREQ		133
+#define WCN36XX_HAL_CFG_MWS_COEX_V5_WLAN_FREQ		134
+#define WCN36XX_HAL_CFG_MWS_COEX_V5_CONFIG		135
+#define WCN36XX_HAL_CFG_MWS_COEX_V5_CONFIG2		136
+#define WCN36XX_HAL_CFG_MWS_COEX_V6_WAN_FREQ		137
+#define WCN36XX_HAL_CFG_MWS_COEX_V6_WLAN_FREQ		138
+#define WCN36XX_HAL_CFG_MWS_COEX_V6_CONFIG		139
+#define WCN36XX_HAL_CFG_MWS_COEX_V6_CONFIG2		140
+#define WCN36XX_HAL_CFG_MWS_COEX_V7_WAN_FREQ		141
+#define WCN36XX_HAL_CFG_MWS_COEX_V7_WLAN_FREQ		142
+#define WCN36XX_HAL_CFG_MWS_COEX_V7_CONFIG		143
+#define WCN36XX_HAL_CFG_MWS_COEX_V7_CONFIG2		144
+#define WCN36XX_HAL_CFG_MWS_COEX_V8_WAN_FREQ		145
+#define WCN36XX_HAL_CFG_MWS_COEX_V8_WLAN_FREQ		146
+#define WCN36XX_HAL_CFG_MWS_COEX_V8_CONFIG		147
+#define WCN36XX_HAL_CFG_MWS_COEX_V8_CONFIG2		148
+#define WCN36XX_HAL_CFG_MWS_COEX_V9_WAN_FREQ		149
+#define WCN36XX_HAL_CFG_MWS_COEX_V9_WLAN_FREQ		150
+#define WCN36XX_HAL_CFG_MWS_COEX_V9_CONFIG		151
+#define WCN36XX_HAL_CFG_MWS_COEX_V9_CONFIG2		152
+#define WCN36XX_HAL_CFG_MWS_COEX_V10_WAN_FREQ		153
+#define WCN36XX_HAL_CFG_MWS_COEX_V10_WLAN_FREQ		154
+#define WCN36XX_HAL_CFG_MWS_COEX_V10_CONFIG		155
+#define WCN36XX_HAL_CFG_MWS_COEX_V10_CONFIG2		156
+#define WCN36XX_HAL_CFG_MWS_COEX_MODEM_BACKOFF		157
+#define WCN36XX_HAL_CFG_MWS_COEX_CONFIG1		158
+#define WCN36XX_HAL_CFG_MWS_COEX_CONFIG2		159
+#define WCN36XX_HAL_CFG_MWS_COEX_CONFIG3		160
+#define WCN36XX_HAL_CFG_MWS_COEX_CONFIG4		161
+#define WCN36XX_HAL_CFG_MWS_COEX_CONFIG5		162
+#define WCN36XX_HAL_CFG_MWS_COEX_CONFIG6		163
+#define WCN36XX_HAL_CFG_SAR_POWER_BACKOFF		164
+#define WCN36XX_HAL_CFG_GO_LINK_MONITOR_TIMEOUT		165
+#define WCN36XX_HAL_CFG_BTC_STATIC_OPP_WLAN_ACTIVE_WLAN_LEN	166
+#define WCN36XX_HAL_CFG_BTC_STATIC_OPP_WLAN_ACTIVE_BT_LEN	167
+#define WCN36XX_HAL_CFG_BTC_SAP_STATIC_OPP_ACTIVE_WLAN_LEN	168
+#define WCN36XX_HAL_CFG_BTC_SAP_STATIC_OPP_ACTIVE_BT_LEN	169
+#define WCN36XX_HAL_CFG_RMC_FIXED_RATE			170
+#define WCN36XX_HAL_CFG_ASD_PROBE_INTERVAL		171
+#define WCN36XX_HAL_CFG_ASD_TRIGGER_THRESHOLD		172
+#define WCN36XX_HAL_CFG_ASD_RTT_RSSI_HYST_THRESHOLD	173
+#define WCN36XX_HAL_CFG_BTC_CTS2S_ON_STA_DURING_SCO	174
+#define WCN36XX_HAL_CFG_SHORT_PREAMBLE			175
+#define WCN36XX_HAL_CFG_SHORT_SLOT_TIME			176
+#define WCN36XX_HAL_CFG_DELAYED_BA			177
+#define WCN36XX_HAL_CFG_IMMEDIATE_BA			178
+#define WCN36XX_HAL_CFG_DOT11_MODE			179
+#define WCN36XX_HAL_CFG_HT_CAPS				180
+#define WCN36XX_HAL_CFG_AMPDU_PARAMS			181
+#define WCN36XX_HAL_CFG_TX_BF_INFO			182
+#define WCN36XX_HAL_CFG_ASC_CAP_INFO			183
+#define WCN36XX_HAL_CFG_EXT_HT_CAPS			184
+#define WCN36XX_HAL_CFG_QOS_ENABLED			185
+#define WCN36XX_HAL_CFG_WME_ENABLED			186
+#define WCN36XX_HAL_CFG_WSM_ENABLED			187
+#define WCN36XX_HAL_CFG_WMM_ENABLED			188
+#define WCN36XX_HAL_CFG_UAPSD_PER_AC_BITMASK		189
+#define WCN36XX_HAL_CFG_MCS_RATES			190
+#define WCN36XX_HAL_CFG_VHT_CAPS			191
+#define WCN36XX_HAL_CFG_VHT_RX_SUPP_MCS			192
+#define WCN36XX_HAL_CFG_VHT_TX_SUPP_MCS			193
+#define WCN36XX_HAL_CFG_RA_FILTER_ENABLE		194
+#define WCN36XX_HAL_CFG_RA_RATE_LIMIT_INTERVAL		195
+#define WCN36XX_HAL_CFG_BTC_FATAL_HID_NSNIFF_BLK	196
+#define WCN36XX_HAL_CFG_BTC_CRITICAL_HID_NSNIFF_BLK	197
+#define WCN36XX_HAL_CFG_BTC_DYN_A2DP_TX_QUEUE_THOLD	198
+#define WCN36XX_HAL_CFG_BTC_DYN_OPP_TX_QUEUE_THOLD	199
+#define WCN36XX_HAL_CFG_LINK_FAIL_TIMEOUT		200
+#define WCN36XX_HAL_CFG_MAX_UAPSD_CONSEC_SP		201
+#define WCN36XX_HAL_CFG_MAX_UAPSD_CONSEC_RX_CNT		202
+#define WCN36XX_HAL_CFG_MAX_UAPSD_CONSEC_TX_CNT		203
+#define WCN36XX_HAL_CFG_MAX_UAPSD_CONSEC_RX_CNT_MEAS_WINDOW	204
+#define WCN36XX_HAL_CFG_MAX_UAPSD_CONSEC_TX_CNT_MEAS_WINDOW	205
+#define WCN36XX_HAL_CFG_MAX_PSPOLL_IN_WMM_UAPSD_PS_MODE	206
+#define WCN36XX_HAL_CFG_MAX_UAPSD_INACTIVITY_INTERVALS	207
+#define WCN36XX_HAL_CFG_ENABLE_DYNAMIC_WMMPS		208
+#define WCN36XX_HAL_CFG_BURST_MODE_BE_TXOP_VALUE	209
+#define WCN36XX_HAL_CFG_ENABLE_DYNAMIC_RA_START_RATE	210
+#define WCN36XX_HAL_CFG_BTC_FAST_WLAN_CONN_PREF		211
+#define WCN36XX_HAL_CFG_ENABLE_RTSCTS_HTVHT		212
+#define WCN36XX_HAL_CFG_BTC_STATIC_OPP_WLAN_IDLE_WLAN_LEN	213
+#define WCN36XX_HAL_CFG_BTC_STATIC_OPP_WLAN_IDLE_BT_LEN	214
+#define WCN36XX_HAL_CFG_LINK_FAIL_TX_CNT		215
+#define WCN36XX_HAL_CFG_TOGGLE_ARP_BDRATES		216
+#define WCN36XX_HAL_CFG_OPTIMIZE_CA_EVENT		217
+#define WCN36XX_HAL_CFG_EXT_SCAN_CONC_MODE		218
+#define WCN36XX_HAL_CFG_BAR_WAKEUP_HOST_DISABLE		219
+#define WCN36XX_HAL_CFG_SAR_BOFFSET_CORRECTION_ENABLE	220
+#define WCN36XX_HAL_CFG_UNITS_OF_BCN_WAIT_TIME		221
+#define WCN36XX_HAL_CFG_CONS_BCNMISS_COUNT		222
+#define WCN36XX_HAL_CFG_BTC_DISABLE_WLAN_LINK_CRITICAL	223
+#define WCN36XX_HAL_CFG_DISABLE_SCAN_DURING_SCO		224
+#define WCN36XX_HAL_CFG_TRIGGER_NULLFRAME_BEFORE_HB	225
+#define WCN36XX_HAL_CFG_ENABLE_POWERSAVE_OFFLOAD	226
+#define WCN36XX_HAL_CFG_MAX_PARAMS			227
 
 /* Specify the starting bitrate, 11B and 11A/G rates can be specified in
  * multiples of 0.5 So for 5.5 mbps => 11. for MCS 0 - 7 rates, Bit 7 should
-- 
2.27.0

