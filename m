Return-Path: <linux-wireless+bounces-12239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B19657E1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19141C22367
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D661531C3;
	Fri, 30 Aug 2024 06:56:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4708153BE3
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001017; cv=none; b=WlX1uBapic1DSXrsHmJJRIDgKT0Wt0KHpPiQrIJlz2E0rG7nf+KM4w2ajP5O9I7J2i7brygiUCFHO4KyqVmAq3Q5jMBgiGKdprr/H/Zco+e/DRelQcIbvQksOef/kPXcqWpQu48qlZEYc0PupQyxJGrmhKPw+YnRMYACcP+Em1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001017; c=relaxed/simple;
	bh=BlIxAcwGa+8upDBGYvXg5ZROmK8JfZqh6uiMdaTixcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F2j3rNMlAvBMEBDYXJc7utOQ+ueQHfNBfwOhsJx228YzpwIl2zTsz/M+3GOW07AnAIl/RwJVey58SXNMzQ7iWTlHooJa1Noi3xZGpKsze09lbHAbom0aIdLFhURJJKic23EKty7XvHAjlS+5WVwVVuAsjSwQu2MbEpgxTWatXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sjvYp-0000cY-9V; Fri, 30 Aug 2024 08:56:43 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sjvYo-0045i3-D7; Fri, 30 Aug 2024 08:56:42 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sjvYo-00FVXZ-15;
	Fri, 30 Aug 2024 08:56:42 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 30 Aug 2024 08:56:40 +0200
Subject: [PATCH] wifi: mwifiex: Ensure all STA and AP use the same channel
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIACdt0WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC2MD3dzyzLTM1Ard5IzU5GxdkJq81BzdNBNDw0RDU7OkpFQDJaDegqL
 UtMwKsLnRsbW1AMMXMMZnAAAA
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725001002; l=4512;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=BlIxAcwGa+8upDBGYvXg5ZROmK8JfZqh6uiMdaTixcM=;
 b=ACXByfCHTjsW6GcXK75L1BrF519tdKThFURlWV6ju0MkWrTBkL22xshKW0JYSki3gkT2Q6BRM
 sYWik4RLguQAi9c0EAs9VMYUfEPH5qBUACJ9JKzYMHtJCPefZVza3nl
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The mwifiex chips support simultaneous Accesspoint and station mode,
but this only works when all are using the same channel. The downstream
driver uses ECSA which makes the Accesspoint automatically switch to the
channel the station is going to use.  Until this is implemented in the
mwifiex driver at least catch this situation and bail out with an error.
Userspace doesn't have a meaningful way to figure out what went wrong,
so print an error message to give the user a clue.

Without this patch the driver would timeout on the
HostCmd_CMD_802_11_ASSOCIATE command when creating a station with a
channel different from the one that an existing accesspoint uses.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c  | 52 ++++++++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/main.h      |  1 +
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c |  3 ++
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 5697a02e6b8d3..0d3bf624cd3de 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2054,6 +2054,55 @@ static int mwifiex_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
+bool mwifiex_channel_conflict(struct mwifiex_private *priv, struct ieee80211_channel *ch)
+{
+	struct mwifiex_adapter *adapter = priv->adapter;
+	struct mwifiex_current_bss_params *bss_params;
+	u8 band;
+	int freq, i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		struct mwifiex_private *p = adapter->priv[i];
+		struct ieee80211_channel *used = NULL;
+
+		if (p == priv)
+			continue;
+
+		switch (GET_BSS_ROLE(p)) {
+		case MWIFIEX_BSS_ROLE_UAP:
+			if (!netif_carrier_ok(p->netdev))
+				break;
+
+			if (!cfg80211_chandef_valid(&p->bss_chandef))
+				break;
+
+			used = p->bss_chandef.chan;
+
+			break;
+		case MWIFIEX_BSS_ROLE_STA:
+			if (!p->media_connected)
+				break;
+
+			bss_params = &p->curr_bss_params;
+			band = mwifiex_band_to_radio_type(bss_params->band);
+			freq = ieee80211_channel_to_frequency(bss_params->bss_descriptor.channel,
+							      band);
+
+			used = ieee80211_get_channel(priv->wdev.wiphy, freq);
+
+			break;
+		}
+
+		if (used && !ieee80211_channel_equal(used, ch)) {
+			mwifiex_dbg(priv->adapter, MSG,
+				    "all AP and STA must operate on same channel\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 /* cfg80211 operation handler for start_ap.
  * Function sets beacon period, DTIM period, SSID and security into
  * AP config structure.
@@ -2069,6 +2118,9 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
 		return -1;
 
+	if (!mwifiex_channel_conflict(priv, params->chandef.chan))
+		return -EBUSY;
+
 	bss_cfg = kzalloc(sizeof(struct mwifiex_uap_bss_param), GFP_KERNEL);
 	if (!bss_cfg)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 529863edd7a25..b68dbf884156b 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1697,6 +1697,7 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
 			    struct net_device *dev,
 			    bool external, u8 *new_mac);
 void mwifiex_devdump_tmo_func(unsigned long function_context);
+bool mwifiex_channel_conflict(struct mwifiex_private *priv, struct ieee80211_channel *ch);
 
 #ifdef CONFIG_DEBUG_FS
 void mwifiex_debugfs_init(void);
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index d3cba6895f8ce..9794816d8a0c6 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -291,6 +291,9 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 		if (!bss_desc)
 			return -1;
 
+		if (!mwifiex_channel_conflict(priv, bss->channel))
+			return -EBUSY;
+
 		if (mwifiex_band_to_radio_type(bss_desc->bss_band) ==
 						HostCmd_SCAN_RADIO_TYPE_BG) {
 			config_bands = BAND_B | BAND_G | BAND_GN;

---
base-commit: 67a72043aa2e6f60f7bbe7bfa598ba168f16d04f
change-id: 20240830-mwifiex-check-channel-f411a156bbe0

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


