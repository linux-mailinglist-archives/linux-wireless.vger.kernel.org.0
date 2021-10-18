Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165A3431665
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhJRKsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhJRKsw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 06:48:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A162C061714
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 03:46:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so40696356wrb.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d6iwtRfuZTETciNTWdG7oGNdEZ8SIS+Jv3Ox8wXHaJg=;
        b=CREtg5/Sp+R0I4teGevh/5aiIIv2BLPy9vA+BN5H6e3NsiVbdKeg4tjD+D+CYEteEa
         hdi7PS9OStq+vez2xtUfbI8P9TnBG/xn61y+LBq3kqem8C//1TQDtaySiSKttPkzkYQV
         CZ88lBg4IxMYkjiPzgBH7wEtAF9lOYFIRg6qa83a8yxGw3jFDQ6Cf7AgwMo/aOGz9WkD
         piHkWVtGr+qWQQ1Tc3HYMOgNSAiNRS4x/tEAooKuikm5K6Q81JHUcPMjUPr/Hhb8gYaC
         09wX0tN3M8+g9gs+r5IqR9vHjVtKYtEZmftRNjLU3YFLpSfTLwDWsgfd+y0jsVo/j0qj
         TbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d6iwtRfuZTETciNTWdG7oGNdEZ8SIS+Jv3Ox8wXHaJg=;
        b=4Hr++/zbee9bsSiz6hFyExLUEn65p8JEnBF7q+fLi1GLB3d5POobkOSDATdP3Hhp2C
         63t5QVn/qAOcdZMYwYA/ABKE088OMSfUPJvRFrXaNye10haUNIYOTbJtwcxIN7VcLfS6
         kKcRvQnf8TYavnNrc0h0/tcSFmsXyIyKEZDOZLU03tFPzY6K7Mx12LtJJDmDjzmk5wTP
         SDTgn3/SGI9BVmTy6kVuc+2BwqxbuOcY/jc6QGs7QjU0cfzScJM0OoQpXC/hs4cJQj1V
         hqdCO6/qzrekGZI1x/Q1oSgRWxe09G7+c32WX42a9MEp8/WtEdT6OQFfy0CJPESqOAif
         r6PA==
X-Gm-Message-State: AOAM5307SSFuTu12Bl+jutVHWzEaO8CiEQUVCGdUc7DTagn3IPE3zWVm
        WJiHrVU4ddPMulosd8jF6p+NaI4+YiZIwg==
X-Google-Smtp-Source: ABdhPJxr98ZFI6/OKUQ3KHu+YPqL56Xyh+SxfdTEFeIIdwI2GwAEo0XKyaVbDZD26ENi/Rgwf7pWjg==
X-Received: by 2002:adf:e390:: with SMTP id e16mr34975492wrm.217.1634553999896;
        Mon, 18 Oct 2021 03:46:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:9df5:c752:530b:345b])
        by smtp.gmail.com with ESMTPSA id r4sm15195945wrz.58.2021.10.18.03.46.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:46:39 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
Date:   Mon, 18 Oct 2021 12:57:57 +0200
Message-Id: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For packets originating from hardware scan, the channel and band is
included in the buffer descriptor (bd->rf_band & bd->rx_ch).

For 2Ghz band the channel value is directly reported in the 4-bit
rx_ch field. For 5Ghz band, the rx_ch field contains a mapping
index (given the 4-bit limitation).

The reserved0 value field is also used to extend 4-bit mapping to
5-bit mapping to support more than 16 5Ghz channels.

This change adds correct reporting of the frequency/band, that is
used in scan mechanism. And is required for 5Ghz hardware scan
support.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 23 +++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.h |  3 ++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index cab196b..a3ef497 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -31,6 +31,13 @@ struct wcn36xx_rate {
 	enum rate_info_bw bw;
 };
 
+/* Buffer descriptor rx_ch field is limited to 5-bit (4+1), a mapping is used
+ * for 11A Channels.
+ */
+static const u8 ab_rx_ch_map[] = { 36, 40, 44, 48, 52, 56, 60, 64, 100, 104,
+				   108, 112, 116, 120, 124, 128, 132, 136, 140,
+				   149, 153, 157, 161, 165, 144 };
+
 static const struct wcn36xx_rate wcn36xx_rate_table[] = {
 	/* 11b rates */
 	{  10, 0, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
@@ -291,6 +298,22 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	    ieee80211_is_probe_resp(hdr->frame_control))
 		status.boottime_ns = ktime_get_boottime_ns();
 
+	if (bd->scan_learn) {
+		/* If packet originates from hardware scanning, extract the
+		 * band/channel from bd descriptor.
+		 */
+		u8 hwch = (bd->reserved0 << 4) + bd->rx_ch;
+
+		if (bd->rf_band != 1 && hwch <= sizeof(ab_rx_ch_map) && hwch >= 1) {
+			status.band = NL80211_BAND_5GHZ;
+			status.freq = ieee80211_channel_to_frequency(ab_rx_ch_map[hwch - 1],
+								     status.band);
+		} else {
+			status.band = NL80211_BAND_2GHZ;
+			status.freq = ieee80211_channel_to_frequency(hwch, status.band);
+		}
+	}
+
 	memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.h b/drivers/net/wireless/ath/wcn36xx/txrx.h
index 032216e..b54311f 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.h
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.h
@@ -110,7 +110,8 @@ struct wcn36xx_rx_bd {
 	/* 0x44 */
 	u32	exp_seq_num:12;
 	u32	cur_seq_num:12;
-	u32	fr_type_subtype:8;
+	u32	rf_band:2;
+	u32	fr_type_subtype:6;
 
 	/* 0x48 */
 	u32	msdu_size:16;
-- 
2.7.4

