Return-Path: <linux-wireless+bounces-11221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F894CDFF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 12:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB981F23381
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CF192B9F;
	Fri,  9 Aug 2024 09:52:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAA192B9E
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197124; cv=none; b=H2a/sDqPQ+JXC4UtcLtO7LsSaIib8rrqD9NeMdyTemhtw661k215+KNb+3UR9Hlu5b42FBTpi9L61kwZ4qJNC0QzpDl76VwG4jgVewJzvo0gL0KEuGABJW/BeWi8NzWUSZppyktO7vTt55Fhzff73y0OYJQFY2dM5A18Hhrw0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197124; c=relaxed/simple;
	bh=g7RoypxajwXMZFrzck4NL/lXCeP518asaqyIT4KhpQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VcsXXQr/GeajJLL0xEutv78UQpN2YAE4hK7DjHzhZNYOP1Mg367ZA7KLvLMsU/OUcEvhtf2pvjaZYp6aYe8dPnWrmKTJaCT57XbYy8TN/K5m38DGle7EsPT2nCz3YkeeGBFu2TBgCumgU15eYBNFrSIwd/7KkjqNkpENrBOw7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1scMHu-0005n8-1j; Fri, 09 Aug 2024 11:51:58 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1scMHt-005dSz-7j; Fri, 09 Aug 2024 11:51:57 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1scMHt-003x37-0U;
	Fri, 09 Aug 2024 11:51:57 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 09 Aug 2024 11:51:48 +0200
Subject: [PATCH] wifi: mwifiex: keep mwifiex_cfg80211_ops constant
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALPmtWYC/zWNQQqDMBQFryJ/3cBPIjbtVUoRiS/2Q6shaasg3
 t0guJxZzKyUkQSZ7tVKCX/JMo0F9KUi/+rGAUr6wmTY1Oz4pj6zBMGi+l98i+++OE3rw+DYaN1
 OMSt7ZUbjrIO3VGIxIchyjB7PbdsBK7gBGXgAAAA=
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, 
 David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723197117; l=3264;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=g7RoypxajwXMZFrzck4NL/lXCeP518asaqyIT4KhpQ4=;
 b=QJo3gZs3iu5FXBmRKM8pc/02iIp80T32stDNK5pCl+cSbs+QqyiobaO+6p4c6s/PtqHzIX/PD
 H+TkmSBZx40CnzbevJ+xLlZTCaPeRY+agFR+ev/7cABifjmIkB3dMPZ
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

With host_mlme support being added mwifiex_cfg80211_ops is no longer
constant, but supplemented with the host_mlme related ops when host_mlme
support is enabled. This doesn't work with multiple adapters when only
few of then have host_mlme support. Duplicate mwifiex_cfg80211_ops
before using it and keep the original constant.

While at it mark mwifiex_cfg80211_ops const to prevent people from
changing it again during runtime.

Fixes: 36995892c271c ("wifi: mwifiex: add host mlme for client mode")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Kalle, the commit breaking it still sits in wireless-next. Feel free to
squash this into the original commit if convenient for you.
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e9123..e36ef075fe053 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4570,7 +4570,7 @@ mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
 }
 
 /* station cfg80211 operations */
-static struct cfg80211_ops mwifiex_cfg80211_ops = {
+static const struct cfg80211_ops mwifiex_cfg80211_ops = {
 	.add_virtual_intf = mwifiex_add_virtual_intf,
 	.del_virtual_intf = mwifiex_del_virtual_intf,
 	.change_virtual_intf = mwifiex_cfg80211_change_virtual_intf,
@@ -4705,24 +4705,28 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	struct mwifiex_private *priv = adapter->priv[MWIFIEX_BSS_TYPE_STA];
 	u8 *country_code;
 	u32 thr, retry;
+	struct cfg80211_ops *ops;
+
+	ops = devm_kmemdup(adapter->dev, &mwifiex_cfg80211_ops,
+			   sizeof(mwifiex_cfg80211_ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
 
 	/* create a new wiphy for use with cfg80211 */
-	wiphy = wiphy_new(&mwifiex_cfg80211_ops,
-			  sizeof(struct mwifiex_adapter *));
+	wiphy = wiphy_new(ops, sizeof(struct mwifiex_adapter *));
 	if (!wiphy) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: creating new wiphy\n", __func__);
 		return -ENOMEM;
 	}
 	if (adapter->host_mlme_enabled) {
-		mwifiex_cfg80211_ops.auth = mwifiex_cfg80211_authenticate;
-		mwifiex_cfg80211_ops.assoc = mwifiex_cfg80211_associate;
-		mwifiex_cfg80211_ops.deauth = mwifiex_cfg80211_deauthenticate;
-		mwifiex_cfg80211_ops.disassoc = mwifiex_cfg80211_disassociate;
-		mwifiex_cfg80211_ops.disconnect = NULL;
-		mwifiex_cfg80211_ops.connect = NULL;
-		mwifiex_cfg80211_ops.probe_client =
-			mwifiex_cfg80211_probe_client;
+		ops->auth = mwifiex_cfg80211_authenticate;
+		ops->assoc = mwifiex_cfg80211_associate;
+		ops->deauth = mwifiex_cfg80211_deauthenticate;
+		ops->disassoc = mwifiex_cfg80211_disassociate;
+		ops->disconnect = NULL;
+		ops->connect = NULL;
+		ops->probe_client = mwifiex_cfg80211_probe_client;
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;

---
base-commit: 4ab9f870a6335af27507d1f3bfb29635d956af48
change-id: 20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-3700e6838ec3

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


