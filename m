Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10921234D7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLQSbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 13:31:00 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:41378 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLQSbA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 13:31:00 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 9A9EA13C283;
        Tue, 17 Dec 2019 10:30:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9A9EA13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576607459;
        bh=5MlmKT3mi2SoMnizjD/6lgz07Bk4wdPhtOhx81nMw9I=;
        h=From:To:Cc:Subject:Date:From;
        b=a1siVhNPjdc829gZTWHPPb4SbIEf2UwtNtOOBy8t/p5yuEls2Yl34ObwcVYj5Cwjd
         ypGJ33I9NSh/KIUa5ehvdvXVI+LIZ+hH2c6dQ/XsPgPxy9W0ZimNiY5//w7za6VleJ
         5UMyfajBhzhufG+moaaFxAiWzY2ZLmjNt+uEW6bQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] mac80211: Fix setting txpower to zero.
Date:   Tue, 17 Dec 2019 10:30:57 -0800
Message-Id: <20191217183057.24586-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

With multiple VIFS ath10k, and probably others, tries to find the
minimum txpower for all vifs and uses that when setting txpower in
the firmware.

If a second vif is added and starts to scan, it's txpower is not initialized yet
and it set to zero.

ath10k had a patch to ignore zero values, but then it is impossible to actually set
txpower to zero.

So, instead initialize the txpower to -1 in mac80211, and let drivers know that
means the power has not been set and so should be ignored.

This should fix regression in:

commit 88407beb1b1462f706a1950a355fd086e1c450b6
Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
Date:   Tue Dec 13 14:55:19 2016 -0800

    ath10k: fix incorrect txpower set by P2P_DEVICE interface

Tested on ath10k 9984 with ath10k-ct firmware.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Use INT_MIN instead of -1 to mean invalid value

 drivers/net/wireless/ath/ath10k/mac.c | 3 ++-
 drivers/net/wireless/ath/ath9k/main.c | 3 +++
 drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
 include/net/mac80211.h                | 2 +-
 net/mac80211/iface.c                  | 1 +
 net/mac80211/main.c                   | 2 ++
 6 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 83cc8778ca1e..3ca4ccaee32a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5103,7 +5103,8 @@ static int ath10k_mac_txpower_recalc(struct ath10k *ar)
 	lockdep_assert_held(&ar->conf_mutex);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (arvif->txpower <= 0)
+		/* txpower not initialized yet? */
+		if (arvif->txpower == INT_MIN)
 			continue;
 
 		if (txpower == -1)
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 0548aa3702e3..983b6d6c89f0 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1196,6 +1196,9 @@ static void ath9k_tpc_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 {
 	int *power = data;
 
+	if (vif->bss_conf.txpower == INT_MIN)
+		return;
+
 	if (*power < vif->bss_conf.txpower)
 		*power = vif->bss_conf.txpower;
 }
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 31e7b108279c..e60d4737fc6e 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2095,10 +2095,13 @@ static void setup_frame_info(struct ieee80211_hw *hw,
 
 	if (tx_info->control.vif) {
 		struct ieee80211_vif *vif = tx_info->control.vif;
-
+		if (vif->bss_conf.txpower == INT_MIN)
+			goto nonvifpower;
 		txpower = 2 * vif->bss_conf.txpower;
 	} else {
-		struct ath_softc *sc = hw->priv;
+		struct ath_softc *sc;
+	nonvifpower:
+		sc = hw->priv;
 
 		txpower = sc->cur_chan->cur_txpower;
 	}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index aa145808e57a..927647791004 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -573,7 +573,7 @@ struct ieee80211_ftm_responder_params {
  * @ssid: The SSID of the current vif. Valid in AP and IBSS mode.
  * @ssid_len: Length of SSID given in @ssid.
  * @hidden_ssid: The SSID of the current vif is hidden. Only valid in AP-mode.
- * @txpower: TX power in dBm
+ * @txpower: TX power in dBm.  INT_MIN means not configured.
  * @txpower_type: TX power adjustment used to control per packet Transmit
  *	Power Control (TPC) in lower driver for the current vif. In particular
  *	TPC is enabled if value passed in %txpower_type is
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index af8b09214786..f8facaea8790 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1402,6 +1402,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	sdata->control_port_no_encrypt = false;
 	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
 	sdata->vif.bss_conf.idle = true;
+	sdata->vif.bss_conf.txpower = INT_MIN; /* unset */
 
 	sdata->noack_map = 0;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6cca0853f183..413484d07838 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -146,6 +146,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 			continue;
 		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
+		if (sdata->vif.bss_conf.txpower == INT_MIN)
+			continue;
 		power = min(power, sdata->vif.bss_conf.txpower);
 	}
 	rcu_read_unlock();
-- 
2.20.1

