Return-Path: <linux-wireless+bounces-32475-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK8JIuyGqGn2vQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32475-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:24:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3342B207051
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6967730238FB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 19:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F5C3D6CCD;
	Wed,  4 Mar 2026 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCh7Fhi1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19F3D75CF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652263; cv=none; b=kOPi/cOuL93CEgF7SW7pk951qmgppGQzuwWs0OqHh1s4pbur1KVvLENeegeDfk4WnfaasGkG5yhjdE00mN4kzWqpm+alabsaUrcMCtQpbtcNYpYi/v3Yu+Sh0P0P7IcZZqQh8Z4nu0N4id4zm9b/UKyLISjxexYIjFSd8AMrm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652263; c=relaxed/simple;
	bh=Jz94D8EaFkOhoL0aUNwiiImmgaQzQhtaZnhY+XaHLw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKouw6MpU90SpI/xCSKaSyXY5WQ10z1Myrq7R61J/clpql4GcYIFfbhjiTV/ttrmu2l7rlphzimvvV/Zhm+jVUQxF0LjR72hF9ULnrhQjdj6Y/UzPPSri0heV6RYeddTnQwmqRbcLdxk//6raCXUvrmRaDebBf+shg6zr71Wnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCh7Fhi1; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-679efb9eb0dso5537391eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652261; x=1773257061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxNST9zow/AHVZatDVFxrIoYusqakUqirmlL5pR85cE=;
        b=QCh7Fhi1I8W4lydCGn6tWTDJaUiukX4M+bmfFPIDsRR3fWioRBrcNoeEBlo1/cuiVr
         M3hw5zPEsbS2ci4mV928yVaM7B26kVlbakIjoAY/e3lkNdIhfP3zl/RkMMoyVUpo08yw
         7oT0FzTjKfYCTalQd+iG8sCM33dTS6iQNvdmLUfb9HNjCY/3Vesmq+eHemh28JiOoJI8
         z+Ec/lOgrFznZTLypnzcrDsPu7Vr4VfZOihvWys1Up9i8iHneJWdaBtIS0lyoFkwKAdt
         80VDHTJ+z+L4ignyR/PAi9u6RrgWVaNIYW65FDqn7jQ1Njywfu92Sz2/LHFrE+nQ6Q9s
         pC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652261; x=1773257061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxNST9zow/AHVZatDVFxrIoYusqakUqirmlL5pR85cE=;
        b=ISbTKPF7EV4MbIb9syDTlHLv3j+7MSZsigtWxkr/7tDyfSih/YOZ9GYBAnL55hwrE7
         9p+rZOq/3aC4mQJw86DfHmfg6zHzL/PH4T5vpl0EyQgAtnp5/8u9TDqIRYDjT3E4c2eb
         0Nuh2fBEF2eGkCt25z+OSVySphfiWa0PIOufac/vJFB1EZUDwxXjNCPIR5A2/HT0qlJS
         nnuIgWj02zjPru3yP+w4OCKNWnSLaSki8pkC+LRw6pohmhMZ6thFZYpvYr1Zcz7DIzUw
         DaVUar5tbhyIUzWVPgepWAcWuXC56oyPKFkBE/kmUWxe+B9w/q7PxEVKcF6zYQjQNQ72
         SEyw==
X-Gm-Message-State: AOJu0YzXin6N+17X1pHpqii6Ajv33APq35SlfUgRDooBGaInCuvd4lt4
	QdgKnb5rNWubR3RV+FSPAWdylBXrDXHaYPlbP0aoB4slG6oC+uYPbcNinjU4mjtdMTo=
X-Gm-Gg: ATEYQzzMY8wp+FF9UC++8esIPPTWUFcvQO9h6mnU86d0g0Dmhh9PZCjCAWA4WV3zAGm
	lJ0qHlMFynCxyGj9OCLyifMTPv+qdTzyzD1gn1gX4BFOftPS7Nb0OKi6J2azH9wKvT+q8WJSi2l
	xjYjPiA2bnqPvYqPFgkFaCUgBvMUzCneqmTuP3fFz3zswkxKUq8USmdEt6NAZeGiLjBSP8jSI9A
	0jiawTjroqNuaUfTUGr3nIxTI5lsN85hXeYA7xEl7imxM4LLnAesOeJ1tLAvyeSNfHlxQ6ffZ9e
	NqB9vR165awJTH/UMdSsBUO8ure+9mCxZoRNbo1yuLx62xPnXbpDbJR7aNmKCZF4yfEZl0NPdTE
	YnPZf/G40RkmTNWlDzTBcpAbMuTxrOX5dMrWEn4zYRvL8Db01uRDD1gZH8Rq6T/PB15AeTkIA0T
	Fw2wtNTXrHTTV0OpJ7M1YU8TB9keEsrEm00Bt5B/T3ewA8g4QSJ9v4EftnLHivROKe2l0WODVTS
	DUj1ncyjilQ1n7xHmcX/PRpwMC5om4kPNHAy/XY3Q==
X-Received: by 2002:a05:6820:1ca4:b0:674:2eda:cbe7 with SMTP id 006d021491bc7-67b17764b28mr1697480eaf.52.1772652260810;
        Wed, 04 Mar 2026 11:24:20 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:5b2b:e942:c11b:ed62])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d85297sm13294165eaf.11.2026.03.04.11.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:24:20 -0800 (PST)
From: Kerigan Creighton <kerigancreighton@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	wcn36xx@lists.infradead.org,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kerigan Creighton <kerigancreighton@gmail.com>
Subject: [PATCH 1/3] wifi: wcn36xx: add support for WCN3610
Date: Wed,  4 Mar 2026 13:24:07 -0600
Message-ID: <20260304192409.927562-1-kerigancreighton@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3342B207051
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-32475-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The WCN3610 is a 2.4GHz-only WLAN/BLE combo chip used in some
cheaper Android and Windows phones such as the Lumia 550, and
IoT devices like the Anki Vector robot. It shares a lot in
common with the WCN3620.

Tested on an Anki Vector 1.0 and 2.0 robot. Support for other
WCN36xx chips has not been affected.

The WCN3610 requires specific BTC configuration values for
stable Wi-Fi. Without these values, there's some packet loss.
An extra CFG table was made so other chips are not affected.

STA_POWERSAVE causes firmware bugs (long hangs) with the
WCN3610, thus it has been disabled just for this chip.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c    |  4 +-
 drivers/net/wireless/ath/wcn36xx/smd.c     | 70 +++++++++++++++++++++-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c3f0860873..6c90c13251 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1438,7 +1438,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 		BIT(NL80211_IFTYPE_MESH_POINT);
 
 	wcn->hw->wiphy->bands[NL80211_BAND_2GHZ] = &wcn_band_2ghz;
-	if (wcn->rf_id != RF_IRIS_WCN3620)
+	if (wcn->rf_id != RF_IRIS_WCN3620 && wcn->rf_id != RF_IRIS_WCN3610)
 		wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] = &wcn_band_5ghz;
 
 	if (wcn->rf_id == RF_IRIS_WCN3680)
@@ -1535,6 +1535,8 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 	/* External RF module */
 	iris_node = of_get_child_by_name(mmio_node, "iris");
 	if (iris_node) {
+		if (of_device_is_compatible(iris_node, "qcom,wcn3610"))
+			wcn->rf_id = RF_IRIS_WCN3610;
 		if (of_device_is_compatible(iris_node, "qcom,wcn3620"))
 			wcn->rf_id = RF_IRIS_WCN3620;
 		if (of_device_is_compatible(iris_node, "qcom,wcn3660") ||
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 813553edcb..7352c73f32 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -83,6 +83,70 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
 };
 
+static struct wcn36xx_cfg_val wcn3610_cfg_vals[] = {
+	WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
+	WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
+	WCN36XX_CFG_VAL(LOW_GAIN_OVERRIDE, 0),
+	WCN36XX_CFG_VAL(POWER_STATE_PER_CHAIN, 785),
+	WCN36XX_CFG_VAL(CAL_PERIOD, 5),
+	WCN36XX_CFG_VAL(CAL_CONTROL, 1),
+	WCN36XX_CFG_VAL(PROXIMITY, 0),
+	WCN36XX_CFG_VAL(NETWORK_DENSITY, 3),
+	WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
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
+	WCN36XX_CFG_VAL(RETRYRATE_SECONDARY, 131),
+	WCN36XX_CFG_VAL(RETRYRATE_TERTIARY, 129),
+	WCN36XX_CFG_VAL(FORCE_POLICY_PROTECTION, 5),
+	WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_24GHZ, 1),
+	WCN36XX_CFG_VAL(FIXED_RATE_MULTICAST_5GHZ, 5),
+	WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_5GHZ, 5),
+	WCN36XX_CFG_VAL(DEFAULT_RATE_INDEX_24GHZ, 6),
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
+	/*
+	 * BTC_EXECUTION_MODE
+	 * 0: SMART_COEX
+	 * 1: WLAN_ONLY
+	 * 2: PTA_ONLY
+	 * 3: SMART_MAX_WLAN
+	 * 4: SMART_MAX_BT
+	 * 5: SMART_BT_A2DP
+	 */
+	WCN36XX_CFG_VAL(BTC_EXECUTION_MODE, 2),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_WLAN_LEN, 90000),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_ACTIVE_BT_LEN, 60000),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_WLAN_LEN, 30000),
+	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_BT_LEN, 120000),
+	WCN36XX_CFG_VAL(BTC_FAST_WLAN_CONN_PREF, 1),
+	WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_BT, 120000),
+	WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_WLAN, 30000),
+	WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
+	WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
+	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 0), /* Let the firmware handle it */
+	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
+};
+
 static struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
 	WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
 	WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
@@ -632,6 +696,9 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
 		cfg_vals = wcn3680_cfg_vals;
 		cfg_elements = ARRAY_SIZE(wcn3680_cfg_vals);
+	} else if (wcn->rf_id == RF_IRIS_WCN3610) {
+		cfg_vals = wcn3610_cfg_vals;
+		cfg_elements = ARRAY_SIZE(wcn3610_cfg_vals);
 	} else {
 		cfg_vals = wcn36xx_cfg_vals;
 		cfg_elements = ARRAY_SIZE(wcn36xx_cfg_vals);
@@ -2380,7 +2447,8 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FEATURE_CAPS_EXCHANGE_REQ);
 
-	wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
+	if (wcn->rf_id != RF_IRIS_WCN3610)
+		wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
 		wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, DOT11AC);
 		wcn36xx_firmware_set_feat_caps(msg_body.feat_caps, WLAN_CH144);
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 7ee79593cd..cb409d48f7 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -96,6 +96,7 @@ enum wcn36xx_ampdu_state {
 #define WCN36XX_MAX_POWER(__wcn) (__wcn->hw->conf.chandef.chan->max_power)
 
 #define RF_UNKNOWN	0x0000
+#define RF_IRIS_WCN3610	0x3610
 #define RF_IRIS_WCN3620	0x3620
 #define RF_IRIS_WCN3660	0x3660
 #define RF_IRIS_WCN3680	0x3680
-- 
2.53.0


