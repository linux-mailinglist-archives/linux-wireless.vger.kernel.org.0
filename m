Return-Path: <linux-wireless+bounces-21376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8819AA84086
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815C61B81DDE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1105281507;
	Thu, 10 Apr 2025 10:24:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC92165E9
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280685; cv=none; b=rne3P0tkN5sM1leaM8d6Iv6Hedg+NvMh/TvaS4EXjJHnYe6WmKpGuJleSxF2/kiQmGciXFXeWHGx0rN9GCzIoiurD6lkRo6Jhd/E7jvyBF4pVJ1JDvPQS64nHiMZ6YWoJZy8h/Q+L3K6Hv7C4mXC8wqm/pDEI9He8TnRcerFgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280685; c=relaxed/simple;
	bh=5KbUjdnS2aAFU8RuRz4T2Qr5Fc8KYXahzn80h5q/0xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8hOeW6DLnlG1p4b4MvLecUUE2ZqodJBsvHf9gRiMStb1137c5SHJxlpl29m7SMYpF7dXb2eAxh6YZJiqAfmGrvgaGYInDLTmukc+3w2YmurvqBf4vNAFhZ9pRiPcmid1SEqExLGY8uWQlhkSfsMQT921WVofmwXBisJF5Qi5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DJ-5i; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fn2-2q;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2R;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:24:33 +0200
Subject: [PATCH wireless-next v6 9/9] wifi: mwifiex: move common settings
 out of switch/case
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-cleanup-1-v6-9-a6bbd4ac4d37@pengutronix.de>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=3023;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=5KbUjdnS2aAFU8RuRz4T2Qr5Fc8KYXahzn80h5q/0xs=;
 b=dqBbjz67T45R6mTygkqn6N5S530t1gHpAyohVWkutSaUqP5ew4HXtnG2cKTVlcQwmAWE055qs
 ZpJSseqWjEhA0LqzrJTXB2o4X4yF9T3e71satyFv6aV25FjYhsLohvR
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

In mwifiex_add_virtual_intf() several settings done in a switch/case
are the same in all cases. Move them out of the switch/case to
deduplicate the code.

bss_started is not initialized in all switch/case branches, but it is
only used in AP mode in the driver, so it doesn't hurt to move its
initialization out of the switch/case as well.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Francesco Dolcini <francesco@dolcini.it>
Acked-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 1d9bc8f980c8d..5d6f4d2922b64 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3007,7 +3007,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EFAULT);
 		}
 
-		priv->wdev.wiphy = wiphy;
 		priv->wdev.iftype = NL80211_IFTYPE_STATION;
 
 		if (type == NL80211_IFTYPE_UNSPECIFIED)
@@ -3016,8 +3015,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			priv->bss_mode = type;
 
 		priv->bss_type = MWIFIEX_BSS_TYPE_STA;
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
 
 		break;
@@ -3037,14 +3034,10 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EFAULT);
 		}
 
-		priv->wdev.wiphy = wiphy;
 		priv->wdev.iftype = NL80211_IFTYPE_AP;
 
 		priv->bss_type = MWIFIEX_BSS_TYPE_UAP;
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_UAP;
-		priv->bss_started = 0;
 		priv->bss_mode = type;
 
 		break;
@@ -3064,7 +3057,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EFAULT);
 		}
 
-		priv->wdev.wiphy = wiphy;
 		/* At start-up, wpa_supplicant tries to change the interface
 		 * to NL80211_IFTYPE_STATION if it is not managed mode.
 		 */
@@ -3077,10 +3069,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 		 */
 		priv->bss_type = MWIFIEX_BSS_TYPE_P2P;
 
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
-		priv->bss_started = 0;
 
 		if (mwifiex_cfg80211_init_p2p_client(priv)) {
 			memset(&priv->wdev, 0, sizeof(priv->wdev));
@@ -3094,6 +3083,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
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
2.39.5


