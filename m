Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD5261A40
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbgIHSeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbgIHSdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE7C061786
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:32:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so318071wmi.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRcXSsP0h8e9IS2VQuraEEtCBH2iNJGE784+etRBZqo=;
        b=BX5h/5u+qTOsYg0C36KXsWJoQcDs6erWyXWVry3V5ZbAJiZ+8rHHd/LDahMsh0Rev3
         t3dQSR0UBKp4AfzvhKUCnjnzlc2CjUxt1O59x2Q2rFO2481Y7lm/J33tvDwOLmDQ4KVN
         hHTJeeN1pOenqNs+tiengnGW7n7eJbYkcIUFdSN8HFLnv5my8WfkmfDpZifoW8bmccm6
         g4d9L/Uikhg3LtKcuMoZYv7apqGQycv5OnBoPKp+jIcKt53dNkP3afsIr/Fc9HWF9TqI
         3QyKToG9RS73iGFoeKhKaCEs3bjsNCBSoC0qj7JwlRolNuNX855VdlWX/5bybXASPxQ+
         7K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRcXSsP0h8e9IS2VQuraEEtCBH2iNJGE784+etRBZqo=;
        b=WybzoKxYvdIpK6O1TyGAjDVEF7UkFuxbi5i+cPV9m71hLYjeT1V7dn63rPUUXe91CG
         qlynlHspG1x4M/geuRFdzgQ0ehDFnpd/O7zdjf37MCl7+xOb0mxwyqADPAhv11q08LnN
         x4EDnLtXnImeefgvHXPiADO7ZMUhFOEEB9/wvNmi5a8FDnI5ebl/gmlXLbCx97ttmWT+
         +bDcybj4ok8q1rI4e5LHhAbyt5w1zkzkmQ7FbviDilwR0N3RST1DjgVFiSFfZiRRDB5h
         y9sjEwaB36ksB7362lDLFSOojyRXXDCeNEPMZHK/DrBkB5Rr4kbsyk2Bi4UjYlgynoqj
         u0Cg==
X-Gm-Message-State: AOAM533dMuIeoRTyL1YJbreOZJBo1VMl9lMErwOqiuQcB/m0iFjU/cpo
        SXftvi+A+bg09g8C1STDxbxZJg==
X-Google-Smtp-Source: ABdhPJzz3q8wiuKHQtdxKZSlsqj2HWk2dVb6Ly1ixlhVNLhtG4dc6tx4pYcdoIzzo96X1mnLC+LfcA==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr391511wmi.135.1599589967227;
        Tue, 08 Sep 2020 11:32:47 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm380267wrv.72.2020.09.08.11.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:32:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/2] wcn36xx: Advertise ieee802.11 VHT flags
Date:   Tue,  8 Sep 2020 19:33:31 +0100
Message-Id: <20200908183331.2871016-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908183331.2871016-1-bryan.odonoghue@linaro.org>
References: <20200908183331.2871016-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

