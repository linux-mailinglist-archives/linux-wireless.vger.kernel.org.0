Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06C1B8E0E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDZIt1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Apr 2020 04:49:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62388 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbgDZIt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Apr 2020 04:49:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587890967; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uSHYMmN9UQDBMmbEHTA2TbEzHZBRDSXtjSYjkAp7IBc=; b=dFVgspwiLSr1yRW8p1n05NgwivZhdhPVIOwmHPBTU0QzcD4EVbMZQR2xxk68UmtQc5KoI3BR
 7I66Y4Z7HBoBpPOhOUWXhWwjwtSx6kmS95kDjo8kS5II0Mo2alEJo/Gu7mc+F5JLUSf25IVC
 PrX8/2Y9kxp4966S+JBpimrhUY8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea54afe.7f7372c4b0a0-smtp-out-n03;
 Sun, 26 Apr 2020 08:49:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B73FC433F2; Sun, 26 Apr 2020 08:49:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36BD9C433D2;
        Sun, 26 Apr 2020 08:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36BD9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/2] ath9k: Set RX filter based to allow broadcast Action frame RX
Date:   Sun, 26 Apr 2020 11:47:32 +0300
Message-Id: <20200426084733.7889-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
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
 drivers/net/wireless/ath/ath9k/init.c | 2 ++
 drivers/net/wireless/ath/ath9k/main.c | 1 +
 drivers/net/wireless/ath/ath9k/recv.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

This depends on "mac80211: Process multicast RX registration for Action
frames" from mac80211-next.

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 17c318902cb8..289a2444d534 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -1012,6 +1012,8 @@ static void ath9k_set_hw_capab(struct ath_softc *sc, struct ieee80211_hw *hw)
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 }
 
 int ath9k_init_device(u16 devid, struct ath_softc *sc,
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 457e9b0d21ca..a47f6e978095 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1476,6 +1476,7 @@ static int ath9k_config(struct ieee80211_hw *hw, u32 changed)
 	FIF_OTHER_BSS |				\
 	FIF_BCN_PRBRESP_PROMISC |		\
 	FIF_PROBE_REQ |				\
+	FIF_MCAST_ACTION |			\
 	FIF_FCSFAIL)
 
 /* FIXME: sc->sc_full_reset ? */
diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 06e660858766..0c0624a3b40d 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -413,7 +413,8 @@ u32 ath_calcrxfilter(struct ath_softc *sc)
 	if (sc->cur_chandef.width != NL80211_CHAN_WIDTH_20_NOHT)
 		rfilt |= ATH9K_RX_FILTER_COMP_BAR;
 
-	if (sc->cur_chan->nvifs > 1 || (sc->cur_chan->rxfilter & FIF_OTHER_BSS)) {
+	if (sc->cur_chan->nvifs > 1 ||
+	    (sc->cur_chan->rxfilter & (FIF_OTHER_BSS | FIF_MCAST_ACTION))) {
 		/* This is needed for older chips */
 		if (sc->sc_ah->hw_version.macVersion <= AR_SREV_VERSION_9160)
 			rfilt |= ATH9K_RX_FILTER_PROM;
-- 
2.20.1
