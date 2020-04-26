Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78B1B8E0D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgDZItO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Apr 2020 04:49:14 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52851 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgDZItO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Apr 2020 04:49:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587890954; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2uh+UYAEeknHm00lVExQboD1cMy+EjeqkW7jVF4vYhg=; b=p0E9aOAUxAckkeZXf5t/yZUljTnNdS7uIjpGzQzRPlv7/uiTfiUqwJa+4VtOmns+Vyf3I5Pb
 WuJABt8qL6lrKqq5Io3rvvdPTuuKH1Z6Y94uxFqqfQLsfcCvz0zRiWLVBrslGe+On+Fxiw1w
 D06vWV4EQzEuJDp2cWPAuGPniEE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea54b01.7f737a987650-smtp-out-n03;
 Sun, 26 Apr 2020 08:49:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC433C433CB; Sun, 26 Apr 2020 08:49:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D70CC433D2;
        Sun, 26 Apr 2020 08:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D70CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/2] ath9k_htc: Set RX filter based to allow broadcast Action frame RX
Date:   Sun, 26 Apr 2020 11:47:33 +0300
Message-Id: <20200426084733.7889-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426084733.7889-1-jouni@codeaurora.org>
References: <20200426084733.7889-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Advertise support for multicast frame registration and update the RX
filter based on the recently added FIF_MCAST_ACTION to allow broadcast
Action frames to be received. This is needed for Device Provisioning
Protocol (DPP) use cases that use broadcast Public Action frames.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 2 ++
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 1 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

This depends on "mac80211: Process multicast RX registration for Action
frames" from mac80211-next.

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index d961095ab01f..3fdaaf74acfe 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -780,6 +780,8 @@ static void ath9k_set_hw_capab(struct ath9k_htc_priv *priv,
 	SET_IEEE80211_PERM_ADDR(hw, common->macaddr);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 }
 
 static int ath9k_init_firmware_version(struct ath9k_htc_priv *priv)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 791f6633667c..2b7832b1c800 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1251,6 +1251,7 @@ static int ath9k_htc_config(struct ieee80211_hw *hw, u32 changed)
 	FIF_OTHER_BSS |				\
 	FIF_BCN_PRBRESP_PROMISC |		\
 	FIF_PROBE_REQ |				\
+	FIF_MCAST_ACTION |			\
 	FIF_FCSFAIL)
 
 static void ath9k_htc_configure_filter(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 9cec5c216e1f..10dfc01ddedd 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -893,7 +893,8 @@ u32 ath9k_htc_calcrxfilter(struct ath9k_htc_priv *priv)
 	if (priv->rxfilter & FIF_PSPOLL)
 		rfilt |= ATH9K_RX_FILTER_PSPOLL;
 
-	if (priv->nvifs > 1 || priv->rxfilter & FIF_OTHER_BSS)
+	if (priv->nvifs > 1 ||
+	    priv->rxfilter & (FIF_OTHER_BSS | FIF_MCAST_ACTION))
 		rfilt |= ATH9K_RX_FILTER_MCAST_BCAST_ALL;
 
 	return rfilt;
-- 
2.20.1
