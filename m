Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975A133374
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFCPZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 11:25:34 -0400
Received: from narfation.org ([79.140.41.39]:59414 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfFCPZe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 11:25:34 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970CA3FE0000000000000DF6.dip0.t-ipconnect.de [IPv6:2003:c5:970c:a3fe::df6])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 7A5A611011C;
        Mon,  3 Jun 2019 17:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1559575531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SSrcVBztvjIi1xyN1jAaZOAKwrHAF2mGSbg780mY7go=;
        b=jnHo8yFksNUE1NHpT2ZTsPUnlkM116w+4cfNJOG8HzuBz4xOFYbXeFJ1AdKLDZlEqZrhbx
        oIFI0VYVjusbW6yMX8PW0gPuKYWQ3xWJS8coi3kjmV8hvBRX5ZVpjVc5YYMaIm51M58aU2
        ZUWs2Iup8DUIYYcJh0AmQMGtVae2C8s=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>
Subject: [PATCH v2] ath10k: avoid leaving .bss_info_changed prematurely
Date:   Mon,  3 Jun 2019 17:25:07 +0200
Message-Id: <20190603152507.22011-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1559575531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SSrcVBztvjIi1xyN1jAaZOAKwrHAF2mGSbg780mY7go=;
        b=jkeIAHx6E7aEZDSQrHwocC7qS8y4EMRxA9znqWg1bxdJh2vsZUvean3olk6Hi5ci1VQPeP
        mjxAi4LhRvbalb+7JfTlX3eToCgLCXFniohgrnn5eeYwzcjU1ym7y3dACH/ntICsAAtd5r
        fzl6uzDFtn+PbGTxExdjLMzLiP+3QqE=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1559575531; a=rsa-sha256;
        cv=none;
        b=SSGAxdp0waSEIXJEURQHLuEUEKP9LAHrg2YztOY8PAv6lzONmHN2Dhe8ZbQhphHfmgMv+m
        FZNF3H4Yn6DDV8TA5DTxTDuU+jPgifEjmhjSGOs3nxKxBS7NhvahEilFfjYsUrfuzSJKzM
        rXkTKBoqAbknQM9j90trC/2SB55UbOM=
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

v2:

* rebased on top of commit 9e7251fa3897 ("ath10k: Check tx_stats before
  use it")

 drivers/net/wireless/ath/ath10k/mac.c | 64 ++++++++++++++++-----------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 98a7842e09b1..90f59117a04d 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5582,6 +5582,40 @@ static void ath10k_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static void ath10k_recalculate_mgmt_rate(struct ath10k *ar,
+					 struct ieee80211_vif *vif)
+{
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	const struct ieee80211_supported_band *sband;
+	struct cfg80211_chan_def def;
+	u8 basic_rate_idx;
+	int hw_rate_code;
+	u32 vdev_param;
+	u16 bitrate;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (WARN_ON(ath10k_mac_vif_chan(vif, &def)))
+		return;
+
+	sband = ar->hw->wiphy->bands[def.chan->band];
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
@@ -5592,10 +5626,9 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
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
 
@@ -5819,29 +5852,8 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id,  ret);
 	}
 
-	if (changed & BSS_CHANGED_BASIC_RATES) {
-		if (WARN_ON(ath10k_mac_vif_chan(vif, &def))) {
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
+	if (changed & BSS_CHANGED_BASIC_RATES)
+		ath10k_recalculate_mgmt_rate(ar, vif);
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.20.1

