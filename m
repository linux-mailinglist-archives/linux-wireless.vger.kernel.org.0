Return-Path: <linux-wireless+bounces-11690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81995866E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60671C24ED5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED60190066;
	Tue, 20 Aug 2024 12:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473318FC61
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155235; cv=none; b=EFnYFcPkrnZfF8QORFhTL16K7Cs9F+jSvOTR+rjV1N0vI/o2CkASwCyOe+doxn/+4iOE9zBqoaHXT5F9ONTIy1ivf5CZTIGBUN4wrVmhNqwLAqjJR6iCSNT72EO64fQw8co8hlKKVgLTw8zes0ti5yQillEagUUkXApLVl8NkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155235; c=relaxed/simple;
	bh=vqxhDFbYSzTeyfcEHZVDl4FpS/x8cflMA1VyvVQPBwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clu7PzO3BYV+TBF28shI0SSLqf8Hcqi5BtOPmlx2Cj5tY6IiuqKwjVS9fEsl1Ko3hdohZNNmzh9oMhIaNgjRKplN9PDK0w2IK9zXMH5eBjcRSnbRAJ+cXHnHDevhlOvlzi1vBqvpx53KcRZfdq2u813MRBmte47GMnINyWjwa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000xp-HF; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-001lNv-13; Tue, 20 Aug 2024 14:00:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1a;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:55 +0200
Subject: [PATCH 30/31] wifi: mwifiex: move common settings out of
 switch/case
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-30-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=3401;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=vqxhDFbYSzTeyfcEHZVDl4FpS/x8cflMA1VyvVQPBwY=;
 b=8K2aPQKSCDVmNk6pujH7L+S3sQQ75dBem19rjkBH/jhkOGaMDxLM200+y9wKLS0XmwO1LIi9/
 CvHZtua/yhnCWo8uooK1DgwhQTAfF1umT7JQNK4bUU8b1JDnwLjSOLN
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

In mwifiex_add_virtual_intf() several settings done in a switch/case
are the same in all cases. Move them out of the switch/case to
deduplicate the code.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 43 +++++++------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a704886049c64..45f85493985b9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2849,18 +2849,18 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	if (!adapter)
 		return ERR_PTR(-EFAULT);
 
+	priv = mwifiex_get_unused_priv(adapter);
+	if (!priv) {
+		mwifiex_dbg(adapter, ERROR,
+			    "could not get free private struct\n");
+		return ERR_PTR(-EFAULT);
+	}
+
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_ADHOC:
-		priv = mwifiex_get_unused_priv(adapter);
-		if (!priv) {
-			mwifiex_dbg(adapter, ERROR,
-				    "could not get free private struct\n");
-			return ERR_PTR(-EFAULT);
-		}
 
-		priv->wdev.wiphy = wiphy;
 		priv->wdev.iftype = NL80211_IFTYPE_STATION;
 
 		if (type == NL80211_IFTYPE_UNSPECIFIED)
@@ -2869,39 +2869,18 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			priv->bss_mode = type;
 
 		priv->bss_type = MWIFIEX_BSS_TYPE_STA;
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
 
 		break;
 	case NL80211_IFTYPE_AP:
-		priv = mwifiex_get_unused_priv(adapter);
-		if (!priv) {
-			mwifiex_dbg(adapter, ERROR,
-				    "could not get free private struct\n");
-			return ERR_PTR(-EFAULT);
-		}
-
-		priv->wdev.wiphy = wiphy;
 		priv->wdev.iftype = NL80211_IFTYPE_AP;
 
 		priv->bss_type = MWIFIEX_BSS_TYPE_UAP;
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_UAP;
-		priv->bss_started = 0;
 		priv->bss_mode = type;
 
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
-		priv = mwifiex_get_unused_priv(adapter);
-		if (!priv) {
-			mwifiex_dbg(adapter, ERROR,
-				    "could not get free private struct\n");
-			return ERR_PTR(-EFAULT);
-		}
-
-		priv->wdev.wiphy = wiphy;
 		/* At start-up, wpa_supplicant tries to change the interface
 		 * to NL80211_IFTYPE_STATION if it is not managed mode.
 		 */
@@ -2914,10 +2893,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 		 */
 		priv->bss_type = MWIFIEX_BSS_TYPE_P2P;
 
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
-		priv->bss_started = 0;
 
 		if (mwifiex_cfg80211_init_p2p_client(priv)) {
 			memset(&priv->wdev, 0, sizeof(priv->wdev));
@@ -2931,6 +2907,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 		return ERR_PTR(-EINVAL);
 	}
 
+	priv->wdev.wiphy = wiphy;
+	priv->bss_priority = 0;
+	priv->bss_started = 0;
+	priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
+
 	dev = alloc_netdev_mqs(sizeof(struct mwifiex_private *), name,
 			       name_assign_type, ether_setup,
 			       IEEE80211_NUM_ACS, 1);

-- 
2.39.2


