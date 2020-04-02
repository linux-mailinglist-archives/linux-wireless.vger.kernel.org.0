Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6A19B9CB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgDBBS0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:26 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46494 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733237AbgDBBSZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id AF9A94F7AF2;
        Thu,  2 Apr 2020 01:18:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jf91vdxU9gf9; Thu,  2 Apr 2020 01:18:20 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id CDAA84F7AF5;
        Thu,  2 Apr 2020 01:18:12 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 5/9] cfg80211: report frequency in KHz for management RX
Date:   Wed,  1 Apr 2020 18:18:06 -0700
Message-Id: <20200402011810.22947-6-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402011810.22947-1-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Expect and convert drivers to report the RX frequency to
cfg80211_rx_mgmt() and cfg80211_report_obss_beacon() in
KHz

This doesn't actually change the nl80211 API yet.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 drivers/net/wireless/ath/ath6kl/wmi.c                  | 5 +++--
 drivers/net/wireless/ath/wil6210/wmi.c                 | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 6 ++++--
 drivers/net/wireless/marvell/mwifiex/util.c            | 3 ++-
 drivers/staging/wilc1000/cfg80211.c                    | 2 +-
 include/net/cfg80211.h                                 | 4 ++--
 net/mac80211/rx.c                                      | 6 ++++--
 net/wireless/nl80211.c                                 | 5 +++--
 8 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 6885d2ded53a..4b70ffe04e58 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -619,7 +619,8 @@ static int ath6kl_wmi_rx_probe_req_event_rx(struct wmi *wmi, u8 *datap, int len,
 		   dlen, freq, vif->probe_req_report);
 
 	if (vif->probe_req_report || vif->nw_type == AP_NETWORK)
-		cfg80211_rx_mgmt(&vif->wdev, freq, 0, ev->data, dlen, 0);
+		cfg80211_rx_mgmt(&vif->wdev, MHZ_TO_KHZ(freq), 0, ev->data,
+				 dlen, 0);
 
 	return 0;
 }
@@ -658,7 +659,7 @@ static int ath6kl_wmi_rx_action_event_rx(struct wmi *wmi, u8 *datap, int len,
 		return -EINVAL;
 	}
 	ath6kl_dbg(ATH6KL_DBG_WMI, "rx_action: len=%u freq=%u\n", dlen, freq);
-	cfg80211_rx_mgmt(&vif->wdev, freq, 0, ev->data, dlen, 0);
+	cfg80211_rx_mgmt(&vif->wdev, MHZ_TO_KHZ(freq), 0, ev->data, dlen, 0);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 23e1ed6a9d6d..860c9e2656e5 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -905,7 +905,8 @@ static void wmi_evt_rx_mgmt(struct wil6210_vif *vif, int id, void *d, int len)
 		}
 	} else {
 		mutex_lock(&wil->vif_mutex);
-		cfg80211_rx_mgmt(vif_to_radio_wdev(wil, vif), freq, signal,
+		cfg80211_rx_mgmt(vif_to_radio_wdev(wil, vif),
+				 MHZ_TO_KHZ(freq), signal,
 				 (void *)rx_mgmt_frame, d_len, 0);
 		mutex_unlock(&wil->vif_mutex);
 	}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 1f5deea5a288..f4881b389148 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1423,7 +1423,8 @@ int brcmf_p2p_notify_action_frame_rx(struct brcmf_if *ifp,
 					      NL80211_BAND_5GHZ);
 
 	wdev = &ifp->vif->wdev;
-	cfg80211_rx_mgmt(wdev, freq, 0, (u8 *)mgmt_frame, mgmt_frame_len, 0);
+	cfg80211_rx_mgmt(wdev, MHZ_TO_KHZ(freq), 0, (u8 *)mgmt_frame,
+			 mgmt_frame_len, 0);
 
 	kfree(mgmt_frame);
 	return 0;
@@ -1908,7 +1909,8 @@ s32 brcmf_p2p_notify_rx_mgmt_p2p_probereq(struct brcmf_if *ifp,
 					      NL80211_BAND_2GHZ :
 					      NL80211_BAND_5GHZ);
 
-	cfg80211_rx_mgmt(&vif->wdev, freq, 0, mgmt_frame, mgmt_frame_len, 0);
+	cfg80211_rx_mgmt(&vif->wdev, MHZ_TO_KHZ(freq), 0, mgmt_frame,
+			 mgmt_frame_len, 0);
 
 	brcmf_dbg(INFO, "mgmt_frame_len (%d) , e->datalen (%d), chanspec (%04x), freq (%d)\n",
 		  mgmt_frame_len, e->datalen, ch.chspec, freq);
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index de89a1e710b1..8d449d723dd2 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -425,7 +425,8 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 	pkt_len -= ETH_ALEN + sizeof(pkt_len);
 	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
 
-	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
+	cfg80211_rx_mgmt(&priv->wdev,
+			 MHZ_TO_KHZ(priv->roc_cfg.chan.center_freq),
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
 
diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000/cfg80211.c
index 4863e516ff13..93c3716435de 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -1077,7 +1077,7 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 		}
 	}
 
-	cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
+	cfg80211_rx_mgmt(&priv->wdev, MHZ_TO_KHZ(freq), 0, buff, size, 0);
 }
 
 static void wilc_wfi_mgmt_tx_complete(void *priv, int status)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9da99a7bdfbf..d7518bbb46cf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6953,7 +6953,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
 /**
  * cfg80211_rx_mgmt - notification of received, unprocessed management frame
  * @wdev: wireless device receiving the frame
- * @freq: Frequency on which the frame was received in MHz
+ * @freq: Frequency on which the frame was received in KHz
  * @sig_dbm: signal strength in dBm, or 0 if unknown
  * @buf: Management frame (header + body)
  * @len: length of the frame data
@@ -7171,7 +7171,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
  * @wiphy: The wiphy that received the beacon
  * @frame: the frame
  * @len: length of the frame
- * @freq: frequency the frame was received on
+ * @freq: frequency the frame was received on in KHz
  * @sig_dbm: signal strength in dBm, or 0 if unknown
  *
  * Use this function to report to userspace when a beacon was
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0b6dca4c0c7d..a9f632992853 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3085,7 +3085,8 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 
 		cfg80211_report_obss_beacon(rx->local->hw.wiphy,
 					    rx->skb->data, rx->skb->len,
-					    status->freq, sig);
+					    ieee80211_rx_status_to_khz(status),
+					    sig);
 		rx->flags |= IEEE80211_RX_BEACON_REPORTED;
 	}
 
@@ -3431,7 +3432,8 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 	    !(status->flag & RX_FLAG_NO_SIGNAL_VAL))
 		sig = status->signal;
 
-	if (cfg80211_rx_mgmt(&rx->sdata->wdev, status->freq, sig,
+	if (cfg80211_rx_mgmt(&rx->sdata->wdev,
+			     ieee80211_rx_status_to_khz(status), sig,
 			     rx->skb->data, rx->skb->len, 0)) {
 		if (rx->sta)
 			rx->sta->rx_stats.packets++;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5fa402144cda..6ff2130f33ff 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16226,7 +16226,7 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 					netdev->ifindex)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
-	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, freq) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, KHZ_TO_MHZ(freq)) ||
 	    (sig_dbm &&
 	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
 	    nla_put(msg, NL80211_ATTR_FRAME, len, buf) ||
@@ -16877,7 +16877,8 @@ void cfg80211_report_obss_beacon(struct wiphy *wiphy,
 
 		if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 		    (freq &&
-		     nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, freq)) ||
+		     nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ,
+				 KHZ_TO_MHZ(freq))) ||
 		    (sig_dbm &&
 		     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
 		    nla_put(msg, NL80211_ATTR_FRAME, len, frame))
-- 
2.20.1

