Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC05E668
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGCOUB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 10:20:01 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:42492 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOUA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 10:20:00 -0400
Received: from sven-desktop.home.narfation.org (p4FCB2E24.dip0.t-ipconnect.de [79.203.46.36])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 7D51A208EF;
        Wed,  3 Jul 2019 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562163597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MYt/pi4ZaqYfxhdq3CCToSFwdfb9v4RHhLfc0xm19CU=;
        b=I/OLfzS2swNiq061jAVEuubW0hbcy8KQWOlvFTSgX3Rhx8pr/BkTrJSDf1gIsZGjNFgxB1
        ENp6NV06HMygVStP1p40YY5taE42n3MyOkP8MtKxfKMFO0PZhH+IYRlH+QauiNUPs2Q3+u
        yWaFt8F7cF+xGs+MQWKkOspyY9b36Ak=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>
Subject: [PATCH v3] ath10k: avoid leaving .bss_info_changed prematurely
Date:   Wed,  3 Jul 2019 16:19:49 +0200
Message-Id: <20190703141949.9295-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562163597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MYt/pi4ZaqYfxhdq3CCToSFwdfb9v4RHhLfc0xm19CU=;
        b=AqIMeDALqpJxoP4P66EPitpwdaoMpva7lIDEgU0giqU/e+boWgVZ1L8I3oEDWp95oLG/Wp
        yP/c5/AatvZMQJDeKft1ncgQyyLUxHil8ORaAkjPpP7+ZSXLOisqJjrp4CBwx5fsq74vgb
        aijGoh192/AQeBvzs2LH+Eak7yUIRnA=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1562163597; a=rsa-sha256;
        cv=none;
        b=GAwlcKcYSHsDZuiHLQ1fAHcPFrDtI4dFlTb3MQeKYYojmuXZFY+jb9BLUeiEql6uJQptzo
        qkFhOLsoXgPst5KsRAX8vUVMLjhQ53tGuKYAJVms2tD0qNJmQ6y7fRSfB9hkCn+Hxn06oR
        PGCj4XBwR+UlWqQ9gcdHoJkxWL/50vk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

ath10k_bss_info_changed() handles various events from the upper layers. It
parses the changed bitfield and then configures the driver/firmware
accordingly. Each detected event is handled in a separate scope which is
independent of each other - but in the same function.

The commit f279294e9ee2 ("ath10k: add support for configuring management
packet rate") changed this behavior by returning from this function
prematurely when some precondition was not fulfilled. All new event
handlers added after the BSS_CHANGED_BASIC_RATES event handler would then
also be skipped.

Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
---
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Sriram R <srirrama@codeaurora.org>

Only compile tested

v3:

* rebased on top of commit 9e80ad37f678 ("ath10k: Drop WARN_ON()s that always
  trigger during system resume")

v2:

* rebased on top of commit 9e7251fa3897 ("ath10k: Check tx_stats before
  use it")

 drivers/net/wireless/ath/ath10k/mac.c | 62 ++++++++++++++++-----------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e43a566eef77..329c052a8dc0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5634,6 +5634,37 @@ static void ath10k_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static void ath10k_recalculate_mgmt_rate(struct ath10k *ar,
+					 struct ieee80211_vif *vif,
+					 struct cfg80211_chan_def *def)
+{
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	const struct ieee80211_supported_band *sband;
+	u8 basic_rate_idx;
+	int hw_rate_code;
+	u32 vdev_param;
+	u16 bitrate;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	sband = ar->hw->wiphy->bands[def->chan->band];
+	basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
+	bitrate = sband->bitrates[basic_rate_idx].bitrate;
+
+	hw_rate_code = ath10k_mac_get_rate_hw_value(bitrate);
+	if (hw_rate_code < 0) {
+		ath10k_warn(ar, "bitrate not supported %d\n", bitrate);
+		return;
+	}
+
+	vdev_param = ar->wmi.vdev_param->mgmt_rate;
+	ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
+					hw_rate_code);
+	if (ret)
+		ath10k_warn(ar, "failed to set mgmt tx rate %d\n", ret);
+}
+
 static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -5644,10 +5675,9 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 	struct cfg80211_chan_def def;
 	u32 vdev_param, pdev_param, slottime, preamble;
 	u16 bitrate, hw_value;
-	u8 rate, basic_rate_idx, rateidx;
-	int ret = 0, hw_rate_code, mcast_rate;
+	u8 rate, rateidx;
+	int ret = 0, mcast_rate;
 	enum nl80211_band band;
-	const struct ieee80211_supported_band *sband;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5871,29 +5901,9 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id,  ret);
 	}
 
-	if (changed & BSS_CHANGED_BASIC_RATES) {
-		if (ath10k_mac_vif_chan(vif, &def)) {
-			mutex_unlock(&ar->conf_mutex);
-			return;
-		}
-
-		sband = ar->hw->wiphy->bands[def.chan->band];
-		basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
-		bitrate = sband->bitrates[basic_rate_idx].bitrate;
-
-		hw_rate_code = ath10k_mac_get_rate_hw_value(bitrate);
-		if (hw_rate_code < 0) {
-			ath10k_warn(ar, "bitrate not supported %d\n", bitrate);
-			mutex_unlock(&ar->conf_mutex);
-			return;
-		}
-
-		vdev_param = ar->wmi.vdev_param->mgmt_rate;
-		ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
-						hw_rate_code);
-		if (ret)
-			ath10k_warn(ar, "failed to set mgmt tx rate %d\n", ret);
-	}
+	if (changed & BSS_CHANGED_BASIC_RATES &&
+	    !ath10k_mac_vif_chan(arvif->vif, &def))
+		ath10k_recalculate_mgmt_rate(ar, vif, &def);
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.20.1

