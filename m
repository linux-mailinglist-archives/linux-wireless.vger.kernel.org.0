Return-Path: <linux-wireless+bounces-10969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612094823D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC702839CA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647DF16B3AC;
	Mon,  5 Aug 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ftqS/ilC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE716133C
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885820; cv=none; b=W7z4Xu0S9T/Ut6BG3Vd3x6XTundCR4HBOnXv952qazMuqpetMTr9OJXjuYrL8NQkf8kprblzfcURMPLgkRkaKDFYJjrXmYdE+rdwgfCd79TANDha9y4Y2Ia3Igx0/YcawJQH5N+3clwHGPi1X5np+8PmGDOblj2X0J3UHim86AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885820; c=relaxed/simple;
	bh=2hLiD6mWjLsaMdlddNx5cmHR5eIT9sVYb1FPvf4+IIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUFvEOFiH/KnT7RtSHLT0NL4OFac03G13mXws6dIMw7NpKyZXt8fQ87l49TDKbQyUykFt5YEawJ/ZNf6epsnlCYqheHToCpwkY9e9XYn+bnbU5D/0ow30BndtMpvor+1XHMU7g2ZIt7+XUOl9JHzdV/XyKJC4EEe/oK7YBvhE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ftqS/ilC; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VO5VRibYsU5e1mJzCt+H1nqxnkdPtORhQHwCHd9SJzg=; b=ftqS/ilCPtSKrPXiDjDtvueH0+
	bGGDpAGW2WJ6DO48K0O8wj4FAHFY1aIIEtedhuhxWzC+f9prD7I3Mgp2QI29S0prrEEh37IoFTTwJ
	aj64ROWyzclHKLKKh927tikzylWV2B7ItSCAVkjlAwbVvEnsOSJrMZbfudIeTWNfZlcU=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3Iu-00EHlS-1I;
	Mon, 05 Aug 2024 21:23:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 3/6] wifi: mac80211: notify driver about per-radio monitor enabled state
Date: Mon,  5 Aug 2024 21:23:31 +0200
Message-ID: <b75992cb05270eb72fc9eaac3313ac3236701657.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows monitoring on one or more radios while minimizing performance
impact on the others.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h     |  3 +++
 net/mac80211/ieee80211_i.h |  6 ++++++
 net/mac80211/iface.c       | 26 +++++++++++++++++++++++++-
 net/mac80211/main.c        | 12 ++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9618c82262e3..7bee2d912efe 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1748,6 +1748,8 @@ enum ieee80211_smps_mode {
  *
  * @flags: configuration flags defined above
  *
+ * @monitor_radios: bitmask of radios with monitor mode enabled.
+ *
  * @listen_interval: listen interval in units of beacon interval
  * @ps_dtim_period: The DTIM period of the AP we're connected to, for use
  *	in power saving. Power saving will not be enabled until a beacon
@@ -1777,6 +1779,7 @@ enum ieee80211_smps_mode {
  */
 struct ieee80211_conf {
 	u32 flags;
+	u32 monitor_radios;
 	int power_level, dynamic_ps_timeout;
 
 	u16 listen_interval;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 304cce0b771d..3be9f8149117 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1330,6 +1330,10 @@ enum mac80211_scan_state {
 
 DECLARE_STATIC_KEY_FALSE(aql_disable);
 
+struct ieee80211_radio_data {
+	u32 monitors;
+};
+
 struct ieee80211_local {
 	/* embed the driver visible part.
 	 * don't cast (use the static inlines below), but we keep
@@ -1613,6 +1617,8 @@ struct ieee80211_local {
 	u8 ext_capa[8];
 
 	bool wbrf_supported;
+
+	struct ieee80211_radio_data *radio_data;
 };
 
 static inline struct ieee80211_sub_if_data *
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 56fed4f69427..4db867ae97f0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -601,6 +601,18 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
 		}
 
+		for (i = 0; i < local->hw.wiphy->n_radio; i++) {
+			if (!(sdata->wdev.radio_mask & BIT(i)))
+				continue;
+
+			local->radio_data[i].monitors--;
+			if (local->radio_data[i].monitors)
+				continue;
+
+			local->hw.conf.monitor_radios &= ~BIT(i);
+			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
+		}
+
 		ieee80211_adjust_monitor_flags(sdata, -1);
 		break;
 	case NL80211_IFTYPE_NAN:
@@ -1214,7 +1226,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	struct net_device *dev = wdev->netdev;
 	struct ieee80211_local *local = sdata->local;
 	u64 changed = 0;
-	int res;
+	int i, res;
 	u32 hw_reconf_flags = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1330,6 +1342,18 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
 		}
 
+		for (i = 0; i < local->hw.wiphy->n_radio; i++) {
+			if (!(sdata->wdev.radio_mask & BIT(i)))
+				continue;
+
+			local->radio_data[i].monitors++;
+			if (local->radio_data[i].monitors > 1)
+				continue;
+
+			local->hw.conf.monitor_radios |= BIT(i);
+			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
+		}
+
 		ieee80211_adjust_monitor_flags(sdata, 1);
 		ieee80211_configure_filter(local);
 		ieee80211_recalc_offload(local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6abf85a58133..2ce771744ea8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1348,6 +1348,16 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	if (!local->int_scan_req)
 		return -ENOMEM;
 
+	if (hw->wiphy->n_radio) {
+		local->radio_data = kcalloc(hw->wiphy->n_radio,
+					    sizeof(*local->radio_data),
+					    GFP_KERNEL);
+		if (!local->radio_data) {
+			result = -ENOMEM;
+			goto fail_workqueue;
+		}
+	}
+
 	eth_broadcast_addr(local->int_scan_req->bssid);
 
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
@@ -1642,6 +1652,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		local->wiphy_ciphers_allocated = false;
 	}
 	kfree(local->int_scan_req);
+	kfree(local->radio_data);
 	return result;
 }
 EXPORT_SYMBOL(ieee80211_register_hw);
@@ -1694,6 +1705,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	destroy_workqueue(local->workqueue);
 	ieee80211_led_exit(local);
 	kfree(local->int_scan_req);
+	kfree(local->radio_data);
 }
 EXPORT_SYMBOL(ieee80211_unregister_hw);
 
-- 
git-series 0.9.1

