Return-Path: <linux-wireless+bounces-8169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBF8D165F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44DBB23237
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A3F6EB64;
	Tue, 28 May 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uvVmAvka"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531013C67D;
	Tue, 28 May 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885411; cv=none; b=pa64TPzA+BcC/LEGr5DN7ENr6kiqT6NhLwCPPb57LzUG7RUZOMc8mSkLQmuk4HiD7lSZo0I19UftLQFO5h8kJqZwtvDVpQjQFLo3bC9TqxWUGeSIFcK+jzy4GdwAzutx8Tr4keuw7zmcNnV7ngCXVwSdZ4VJkp+hywVA0MwX8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885411; c=relaxed/simple;
	bh=ZTuQx8KWX8IIRC4V1mv9m6I/bJUNiGJlReVGGo5xTPE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=SY6Jzrj+F4LfozMYdmunr6KcIUDY8BJkizFNgXf45bx19BuSRWsRLFDYtuv/MS6oavtdqzakXMJWDPOo06w92G8PgDpkl0X9LVXI08/J8PXnlVx/IYSXOS5eB+cU73FNoa2I4yQBLd7Npa0lSzs/DtteHnSRbZSUqlzc4Ryj3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uvVmAvka; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ukatyUGGzQjNlOG2AgclIuThkOQwBsrQhRxKVAE/XuQ=; b=uvVmAvkaXyeNSsbacpgpHuEd+g
	smGpxFhvxCfi8kO0lkIUNy6fKCBMWpGGm7HBZUQedHQlqqQgtsTjGLyqLjtilVd7HiPwy7sCNRK9/
	ZFWghfI/Yha+Y36b++wfW/NkichBpG9SlFcfKKsqPFJmNbAuf2anfYPslXe0+AU/Yg6einDGIaP7y
	aVn/NrQW49jXqMk1soKKs5YKHwP8hbbnxzMKgdEA8o9ENNTOvk+w+KvZ4aZzaTfMsaN47h5laA188
	1FJou77ZW6LfV/TWKKTwcRTa+WDYrY9XmSGylhQMvFT6Kp2GYZ+ZcjFW2VBDDIShG3vSa8JMjjJuF
	UFkEun3w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39186 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsK0-0004TA-21;
	Tue, 28 May 2024 09:36:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsK3-00E8Uo-Ab; Tue, 28 May 2024 09:36:43 +0100
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: wlcore: fix wlcore AP mode
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsK3-00E8Uo-Ab@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 09:36:43 +0100

From: Johannes Berg <johannes.berg@intel.com>

Using wl183x devices in AP mode with various firmwares is not stable.

The driver currently adds a station to firmware with basic rates when it
is first known to the stack using the CMD_ADD_PEER command. Once the
station has finished authorising, another CMD_ADD_PEER command is issued
to update the firmware with the rates the station can use.

However, after a random amount of time, the firmware ignores the power
management nullfunc frames from the station, and tries to send packets
while the station is asleep, resulting in lots of retries dropping down
in rate due to no response. This restricts the available bandwidth.

With this happening with several stations, the user visible effect is
the latency of interactive connections increases significantly, packets
get dropped, and in general the WiFi connections become unreliable and
unstable.

Eventually, the firmware transmit queue appears to get stuck - with
packets and blocks allocated that never clear.

TI have a couple of patches that address this, but they touch the
mac80211 core to disable NL80211_FEATURE_FULL_AP_CLIENT_STATE for *all*
wireless drivers, which has the effect of not adding the station to the
stack until later when the rates are known. This is a sledge hammer
approach to solving the problem.

The solution implemented here has the same effect, but without
impacting all drivers.

We delay adding the station to firmware until it has been authorised
in the driver, and correspondingly remove the station when unwinding
from authorised state. Adding the station to firmware allocates a hlid,
which will now happen later than the driver expects. Therefore, we need
to track when this happens so that we transmit using the correct hlid.

This patch is an equivalent fix to these two patches in TI's
wilink8-wlan repository:

https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0004-mac80211-patch.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7
https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0005-wlcore-patch.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7

Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Co-developed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>"
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wlcore/cmd.c      |  7 -------
 drivers/net/wireless/ti/wlcore/main.c     | 17 ++++++++---------
 drivers/net/wireless/ti/wlcore/tx.c       |  7 ++-----
 drivers/net/wireless/ti/wlcore/wlcore_i.h |  6 ++++++
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index a939fd89a7f5..92fc2d456c2c 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1566,13 +1566,6 @@ int wl12xx_cmd_add_peer(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 		cpu_to_le32(wl1271_tx_enabled_rates_get(wl, sta_rates,
 							wlvif->band));
 
-	if (!cmd->supported_rates) {
-		wl1271_debug(DEBUG_CMD,
-			     "peer has no supported rates yet, configuring basic rates: 0x%x",
-			     wlvif->basic_rate_set);
-		cmd->supported_rates = cpu_to_le32(wlvif->basic_rate_set);
-	}
-
 	wl1271_debug(DEBUG_CMD, "new peer rates=0x%x queues=0x%x",
 		     cmd->supported_rates, sta->uapsd_queues);
 
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ef12169f8044..492cd7aef44f 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5139,19 +5139,23 @@ static int wl12xx_update_sta_state(struct wl1271 *wl,
 
 	/* Add station (AP mode) */
 	if (is_ap &&
-	    old_state == IEEE80211_STA_NOTEXIST &&
-	    new_state == IEEE80211_STA_NONE) {
+	    old_state == IEEE80211_STA_AUTH &&
+	    new_state == IEEE80211_STA_ASSOC) {
 		ret = wl12xx_sta_add(wl, wlvif, sta);
 		if (ret)
 			return ret;
 
+		wl_sta->fw_added = true;
+
 		wlcore_update_inconn_sta(wl, wlvif, wl_sta, true);
 	}
 
 	/* Remove station (AP mode) */
 	if (is_ap &&
-	    old_state == IEEE80211_STA_NONE &&
-	    new_state == IEEE80211_STA_NOTEXIST) {
+	    old_state == IEEE80211_STA_ASSOC &&
+	    new_state == IEEE80211_STA_AUTH) {
+		wl_sta->fw_added = false;
+
 		/* must not fail */
 		wl12xx_sta_remove(wl, wlvif, sta);
 
@@ -5165,11 +5169,6 @@ static int wl12xx_update_sta_state(struct wl1271 *wl,
 		if (ret < 0)
 			return ret;
 
-		/* reconfigure rates */
-		ret = wl12xx_cmd_add_peer(wl, wlvif, sta, wl_sta->hlid);
-		if (ret < 0)
-			return ret;
-
 		ret = wl1271_acx_set_ht_capabilities(wl, &sta->deflink.ht_cap,
 						     true,
 						     wl_sta->hlid);
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 7bd3ce2f0804..464587d16ab2 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -140,11 +140,8 @@ EXPORT_SYMBOL(wl12xx_is_dummy_packet);
 static u8 wl12xx_tx_get_hlid_ap(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 				struct sk_buff *skb, struct ieee80211_sta *sta)
 {
-	if (sta) {
-		struct wl1271_station *wl_sta;
-
-		wl_sta = (struct wl1271_station *)sta->drv_priv;
-		return wl_sta->hlid;
+	if (sta && wl1271_station(sta)->fw_added) {
+		return wl1271_station(sta)->hlid;
 	} else {
 		struct ieee80211_hdr *hdr;
 
diff --git a/drivers/net/wireless/ti/wlcore/wlcore_i.h b/drivers/net/wireless/ti/wlcore/wlcore_i.h
index eefae3f867b9..817a8a61cac6 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore_i.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore_i.h
@@ -324,6 +324,7 @@ struct wl12xx_rx_filter {
 
 struct wl1271_station {
 	u8 hlid;
+	bool fw_added;
 	bool in_connection;
 
 	/*
@@ -335,6 +336,11 @@ struct wl1271_station {
 	u64 total_freed_pkts;
 };
 
+static inline struct wl1271_station *wl1271_station(struct ieee80211_sta *sta)
+{
+	return (struct wl1271_station *)sta->drv_priv;
+}
+
 struct wl12xx_vif {
 	struct wl1271 *wl;
 	struct list_head list;
-- 
2.30.2


