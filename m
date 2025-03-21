Return-Path: <linux-wireless+bounces-20638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403DA6B64F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DA317174D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B301F151B;
	Fri, 21 Mar 2025 08:50:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19121B87EE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547030; cv=none; b=bAFLmU87G7FULt8Qqn3b/0X3UgZhjYnzyTr+0ipT3MgVmYC3I9jX1dlbw0OCzzKIcO2LQl9UYQ+2KX0h63NfUgpuJc7QJZhk+YaJDGHL83Uq3laY054ChNcB2ajt4HD0ndBNB6PaAorI5KNHgj8wJAuGt4yzcyixL1Pkkl5ZptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547030; c=relaxed/simple;
	bh=vgSog7ia/akrXqtyaMhLsb1dQPWkb43Fj97lsrxPZIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lx4f38zXlW/znxGiFaa2STtaSr9W4WA6R2AsWCS6uMSXHlFudK0BF3kj76Is30OsuFvWzEbtE/WN5soO8NRmB4nmgukUQs3zeD1g76ChKI+OUrty0NUXIGuR8mxCulxPJ50llk34sc7/RAqniye0QoHNx7ZkxgBmWguACwT9Hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY51-0001Lu-Da; Fri, 21 Mar 2025 09:50:15 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY4z-000taS-2Y;
	Fri, 21 Mar 2025 09:50:14 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY50-003L3W-0E;
	Fri, 21 Mar 2025 09:50:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 21 Mar 2025 09:50:09 +0100
Subject: [PATCH v4 09/10] wifi: mwifiex: move common settings out of
 switch/case
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-mwifiex-cleanup-1-v4-9-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742547014; l=2972;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=vgSog7ia/akrXqtyaMhLsb1dQPWkb43Fj97lsrxPZIE=;
 b=EABmz1BFvH+xCYrJ5SW7Jiivtu5790rI517Yw0e3M2yK7ahYF7z9jc9tEpbkKUYtBnRv5MrkG
 rpiCjEC7KnHBWaVmVUsLHFrBcnU/Mn6QsnawZ2WVx0DZLZz3CVo/dYL
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


