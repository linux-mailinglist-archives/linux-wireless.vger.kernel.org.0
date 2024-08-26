Return-Path: <linux-wireless+bounces-11975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB095EF7C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3812C2828AF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065D21509A5;
	Mon, 26 Aug 2024 11:12:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E013E033
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670720; cv=none; b=KpiqHbPppAG0H1/6flK+PQ3N8Is0M4HuGwZUyFMF+fDlOqThdtPalQTvc8t0Mx78E/kBYoOmZmlUz7xGlZCT+hoWpBOkmj94n9uBR6MBmUIch7/wRSThlbEGDuyC0HPy4+YJmd5R+Sr9sUVX/rTMHmDuqEuUCs5AhO8S/t3Y9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670720; c=relaxed/simple;
	bh=GpgZsamkk9VjRuCQ4SGNogieDhgOzbWRsa6ERFX6PgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwoSlxKVkHAf0/sz6bsS29dyYuMvcjAPZ0VFhvA1Sdm1hu6kB0jVnvczCSo3zJWDEgHdKxFjaCMARuJKvA/EcacjfcJbfqQq8aUORCPc9GwT8P2K0igrwzGXMZWpkcWGONIso7NHKTvMBvEpuLLAil9cIWqvZgOaJjLjRyjkKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXdc-0005UA-Kf; Mon, 26 Aug 2024 13:11:56 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXdc-003AwW-64; Mon, 26 Aug 2024 13:11:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-31;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:32 +0200
Subject: [PATCH 11/12] wifi: mwifiex: move common settings out of
 switch/case
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-11-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=2728;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=GpgZsamkk9VjRuCQ4SGNogieDhgOzbWRsa6ERFX6PgQ=;
 b=suu7O4mu0gjjVto6PPvYxNWOsYjS6NWEUgQUIkEg45DUi7anP+dMteTtdI7ieDqFfEruHHRyX
 bEoExPn0TbOBnQ1/xNCQp/uXYlj2eEBrrCfOmTXAhd1RhgGtw7coR4p
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
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 8746943c17788..2ce54a3fc32f8 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3005,7 +3005,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EFAULT);
 		}
 
-		priv->wdev.wiphy = wiphy;
 		priv->wdev.iftype = NL80211_IFTYPE_STATION;
 
 		if (type == NL80211_IFTYPE_UNSPECIFIED)
@@ -3014,8 +3013,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			priv->bss_mode = type;
 
 		priv->bss_type = MWIFIEX_BSS_TYPE_STA;
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
 
 		break;
@@ -3035,14 +3032,10 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
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
@@ -3062,7 +3055,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EFAULT);
 		}
 
-		priv->wdev.wiphy = wiphy;
 		/* At start-up, wpa_supplicant tries to change the interface
 		 * to NL80211_IFTYPE_STATION if it is not managed mode.
 		 */
@@ -3075,10 +3067,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 		 */
 		priv->bss_type = MWIFIEX_BSS_TYPE_P2P;
 
-		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
-		priv->bss_priority = 0;
 		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
-		priv->bss_started = 0;
 
 		if (mwifiex_cfg80211_init_p2p_client(priv)) {
 			memset(&priv->wdev, 0, sizeof(priv->wdev));
@@ -3092,6 +3081,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
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


