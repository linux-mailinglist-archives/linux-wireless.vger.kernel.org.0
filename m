Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0484E261A8C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgIHSgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F202C061389
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so311856wmm.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b80YWigxhp2Bij0sjpEU6Mw77SxZ6jTq1LZAsmGVkXg=;
        b=BmeQlZuuR6UaVzlxK9RT6pnJ5Idmtcj5x+/TTHzd2kQkxaijREoOfMKq+JT5/2qDtC
         GiGjo0+ndlCRSLR2kVLm3l8DiTAuvUe9bXmAnzTXldNc1nirOwCBhtpt80pmQy6T4DTG
         1nw4UJ33xdrxsNYFqOxsT5ACeyRlN6F8HPxHL9YetcHJrXlxJmaf2zNvrcdiuGl2AEEQ
         G1ZQAfSI3EItDujzlkWmbWgcLprFdduih1uBVaM6DhJ2Qs8AQjF2MTvV3YP7qSLSUzUH
         etov4Ha2YxpTLbq1AutdxDUDpngNegUcxgcDtm8VsXkz46dRUgaSwhaqxVAzTaDGR1RH
         aj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b80YWigxhp2Bij0sjpEU6Mw77SxZ6jTq1LZAsmGVkXg=;
        b=gT4ThsNsHtkX0Nof5V6F+RpR7lKsFjujeSYL2s3J/huLueRY2juYYVSSHa8t4BMrdF
         x8pRli/5k3qeVjLyuNus3fOGDF0P6bhiB8bPBYYayODrAZMz7LCG4PafrjkvoH4So0BC
         EpjMfWqj4tr+ekJgUrK0uw+0rLw63OJQuGv0/QbhwOipdICPKEfWbdfCDVsxhmrQ3D0w
         a8Ons8j9/Nay5YeVthvRnYpxdfl9amHpgdzToHCHo8QYd5YoF2J8w27lT4EYEZ8XIwqo
         pTnVhAwwEt/Ozl9TcStr1ffAEjPqJzHa5/KvzJ4RsCvDcE8Ui+9wNmuSslF9gKI6YQHJ
         D3LQ==
X-Gm-Message-State: AOAM533ox/o3BUC7FQYYkEEXG4ASyyWYOT4MzUFaJXsinTiCI5sYG97m
        CLGbfusAh5SKSK36pw8JtAqyvw==
X-Google-Smtp-Source: ABdhPJxwR917BxM4zjf/LNaZZTXnoZeZoCN6MJ6fIzVfHtO8MEO0QSSFdhAdyd0NPIiZUMu+rBhPFg==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr436231wmm.38.1599589497240;
        Tue, 08 Sep 2020 11:24:57 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c4sm334348wrp.85.2020.09.08.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:56 -0700 (PDT)
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/2] wcn36xx: Advertise ieee802.11 VHT flags
Date:   Tue,  8 Sep 2020 19:25:42 +0100
Message-Id: <20200908182542.2870535-3-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182542.2870535-1-pure.logic@nexus-software.ie>
References: <20200908182542.2870535-1-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This patch adds ieee802.11 VHT flags for the wcn3680b.

- RX_STBC1
- SU Beamformee
- MU Beamformee
- VHT80 SGI
- Single spatial stream

RX LDPC is declared as supported in the datasheet but not enabled at this
time.

After this patch is applied an AP should see the wcn3680 as an 802.11ac
capable device.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 9c283c110e07..9e97513feeb5 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1200,6 +1200,35 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
 };
 
+static void
+wcn36xx_set_ieee80211_vht_caps(struct ieee80211_sta_vht_cap *vht_cap)
+{
+	vht_cap->vht_supported = true;
+
+	vht_cap->cap = (IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895 |
+			IEEE80211_VHT_CAP_SHORT_GI_80 |
+			IEEE80211_VHT_CAP_RXSTBC_1 |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT |
+			7 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
+
+	vht_cap->vht_mcs.rx_mcs_map =
+		cpu_to_le16(IEEE80211_VHT_MCS_SUPPORT_0_9 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 14);
+
+	vht_cap->vht_mcs.rx_highest = cpu_to_le16(433);
+	vht_cap->vht_mcs.tx_highest = vht_cap->vht_mcs.rx_highest;
+
+	vht_cap->vht_mcs.tx_mcs_map = vht_cap->vht_mcs.rx_mcs_map;
+}
+
 static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 {
 	static const u32 cipher_suites[] = {
@@ -1228,6 +1257,9 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 		wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] = &wcn_band_5ghz;
 	}
 
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		wcn36xx_set_ieee80211_vht_caps(&wcn_band_5ghz.vht_cap);
+
 	wcn->hw->wiphy->max_scan_ssids = WCN36XX_MAX_SCAN_SSIDS;
 	wcn->hw->wiphy->max_scan_ie_len = WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

