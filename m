Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7743E074A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbhHDSMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 14:12:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14340 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237520AbhHDSMt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 14:12:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628100757; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YHpXMJRZpoJmaQV1ah1HjLRlJ7e+sclU9XDYMISB9O0=; b=P2vcTW/Gjv7/app9Anmv5fhGWvDhSorKD1TuSrj+i5HMTE23Tk1Albc8eAYy/7zuiL2qkslX
 yx7vcVg/2E/W09o05o4fca6gyoWYbGTMvc2sRyg8OGlHoOfbVxIzMJUp+kFb+d7BxT7XMaoS
 364yHk2v2da8mFB2w+qKDFp8MBA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 610ad8931a9008a23ebea663 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 18:12:35
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AFC2C43217; Wed,  4 Aug 2021 18:12:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-77-199-nat.elisa-mobile.fi [85.76.77.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4236EC43460;
        Wed,  4 Aug 2021 18:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4236EC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/3] ath11k: enable 6G channels for WCN6855
Date:   Wed,  4 Aug 2021 21:12:16 +0300
Message-Id: <20210804181217.88751-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804181217.88751-1-jouni@codeaurora.org>
References: <20210804181217.88751-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

For some chips such as WCN6855, single_pdev_only is set in struct
ath11k_hw_params which means ath11k calls ieee80211_register_hw() only
once and create only one device interface, and that device interface
supports all 2G/5G/6G channels.

ath11k_mac_setup_channels_rates() sets up the channels and it is called
for each device interface. It is called only once for single_pdev_only,
and then set up all channels for 2G/5G/6G. The logic of
ath11k_mac_setup_channels_rates() is not suitable for single_pdev_only,
it leads to all 6G channels being disabled for the device interface
which is single_pdev_only such as WCN6855.

Add channel frequency checks for the 6G band and enable the 6G channels
properly based on what is supported by the chip.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c83a968fc7ba..04a8f82e3a17 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7213,7 +7213,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 					   u32 supported_bands)
 {
 	struct ieee80211_supported_band *band;
-	struct ath11k_hal_reg_capabilities_ext *reg_cap;
+	struct ath11k_hal_reg_capabilities_ext *reg_cap, *temp_reg_cap;
 	void *channels;
 	u32 phy_id;
 
@@ -7223,6 +7223,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 		     ATH11K_NUM_CHANS);
 
 	reg_cap = &ar->ab->hal_reg_cap[ar->pdev_idx];
+	temp_reg_cap = reg_cap;
 
 	if (supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		channels = kmemdup(ath11k_2ghz_channels,
@@ -7241,11 +7242,11 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 
 		if (ar->ab->hw_params.single_pdev_only) {
 			phy_id = ath11k_get_phy_id(ar, WMI_HOST_WLAN_2G_CAP);
-			reg_cap = &ar->ab->hal_reg_cap[phy_id];
+			temp_reg_cap = &ar->ab->hal_reg_cap[phy_id];
 		}
 		ath11k_mac_update_ch_list(ar, band,
-					  reg_cap->low_2ghz_chan,
-					  reg_cap->high_2ghz_chan);
+					  temp_reg_cap->low_2ghz_chan,
+					  temp_reg_cap->high_2ghz_chan);
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
@@ -7265,9 +7266,15 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 			band->n_bitrates = ath11k_a_rates_size;
 			band->bitrates = ath11k_a_rates;
 			ar->hw->wiphy->bands[NL80211_BAND_6GHZ] = band;
+
+			if (ar->ab->hw_params.single_pdev_only) {
+				phy_id = ath11k_get_phy_id(ar, WMI_HOST_WLAN_5G_CAP);
+				temp_reg_cap = &ar->ab->hal_reg_cap[phy_id];
+			}
+
 			ath11k_mac_update_ch_list(ar, band,
-						  reg_cap->low_5ghz_chan,
-						  reg_cap->high_5ghz_chan);
+						  temp_reg_cap->low_5ghz_chan,
+						  temp_reg_cap->high_5ghz_chan);
 		}
 
 		if (reg_cap->low_5ghz_chan < ATH11K_MIN_6G_FREQ) {
@@ -7290,12 +7297,12 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 
 			if (ar->ab->hw_params.single_pdev_only) {
 				phy_id = ath11k_get_phy_id(ar, WMI_HOST_WLAN_5G_CAP);
-				reg_cap = &ar->ab->hal_reg_cap[phy_id];
+				temp_reg_cap = &ar->ab->hal_reg_cap[phy_id];
 			}
 
 			ath11k_mac_update_ch_list(ar, band,
-						  reg_cap->low_5ghz_chan,
-						  reg_cap->high_5ghz_chan);
+						  temp_reg_cap->low_5ghz_chan,
+						  temp_reg_cap->high_5ghz_chan);
 		}
 	}
 
-- 
2.25.1

