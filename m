Return-Path: <linux-wireless+bounces-12942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3397BB55
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5771F250A0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197318B492;
	Wed, 18 Sep 2024 11:10:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2718A94F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657840; cv=none; b=HS8hevL48SVXXvYuxdt1O852gfImYJ9Ye2XkkyGya927o5x+PjdR2oMFDUWVBhVs1lKFfOrzTDiXZBSgygm5CJmmWdtksCbnEEtFF2Xn1rwiwWn9BAebCDkAXPgFHnJjhwd3eOcWm7mAOF+Hty7R05EQ360LUAJ1X4nAdX1oajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657840; c=relaxed/simple;
	bh=L7BvnIL4DXQmcjzasQtcRSJHZGaDYANoGBFLqeozp6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow2ye1H0TYFt4aVwPd+pcRYbyuLsyNMpEhtIvKKWbWC0pYMpAghx2u7G2W8ecus6QfzKXrQv36n1J5K4a6AvTtCNB0wxe5bAWdHF7mm5SK9X00wXBng2RhQxIW6n9icN935vJtK0tJwNLh76qA3Qz6JEUpbdFDgY4TxGma2fKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZs-0007wc-Pi; Wed, 18 Sep 2024 13:10:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-008nT6-Dh; Wed, 18 Sep 2024 13:10:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-0086AC-14;
	Wed, 18 Sep 2024 13:10:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 18 Sep 2024 13:10:26 +0200
Subject: [PATCH v2 01/12] wifi: mwifiex: add missing locking
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726657831; l=1673;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=L7BvnIL4DXQmcjzasQtcRSJHZGaDYANoGBFLqeozp6s=;
 b=Ba4x/t+6l0pf5YwCfdgP3q0rpRO38vnCK9uf64/8WomytVrzVrQkq/nppHlkT73KV7HwZTMLr
 aJtw94t62BVBcAPdjuUCab4+ldgnH9SsldDGSaeh60EJrxydii4cVWe
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
with the wiphy locked, so lock it before calling these functions.

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 2 ++
 drivers/net/wireless/marvell/mwifiex/util.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 7894102f03eb0..cdfb307e75131 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -938,8 +938,10 @@ void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter)
 		assoc_resp.links[0].bss = priv->req_bss;
 		assoc_resp.buf = priv->assoc_rsp_buf;
 		assoc_resp.len = priv->assoc_rsp_size;
+		wiphy_lock(priv->wdev.wiphy);
 		cfg80211_rx_assoc_resp(priv->netdev,
 				       &assoc_resp);
+		wiphy_unlock(priv->wdev.wiphy);
 		priv->assoc_rsp_size = 0;
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 42c04bf858da3..1f1f6280a0f25 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -494,7 +494,9 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 			}
 		}
 
+		wiphy_lock(priv->wdev.wiphy);
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
+		wiphy_unlock(priv->wdev.wiphy);
 	}
 
 	if (priv->adapter->host_mlme_enabled &&

-- 
2.39.5


