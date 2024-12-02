Return-Path: <linux-wireless+bounces-15822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D109E02AC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 14:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804182833DF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC244204F71;
	Mon,  2 Dec 2024 12:58:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAEB1FF611
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144300; cv=none; b=OoIhQOqu1St0GX29OTg/doR423Za9FvSOb0HQixb2CSC/AuO14uXRDqQRtOEvdCaIEZ7lNc2nDVcPhBTYAX70uyAblGuXztDwhzKFNUf4535MSoStqvqP67NH87cwD3B38Rv9aLKkW4lPtdJX9Fk/wc8/EkUPMZLwd4v/OpH5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144300; c=relaxed/simple;
	bh=L7BvnIL4DXQmcjzasQtcRSJHZGaDYANoGBFLqeozp6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTZEk8FP/vjTnhrb/0f/oTTZOXSduvgaYK5Xk+heW3PkX7YcVG/B3UuIv4E+D0C0z5LEePAUKhSott4lHrBtw+gsiGmeU0cN0W+FacsKTY2qWIQQUNTLoMRr7mAqt+u738h2iEeIdJmIDZQHAaiqgpH/m/lFReh7o9yqoPQ//XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI608-0000ZT-NM; Mon, 02 Dec 2024 13:58:08 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-001IdK-0t;
	Mon, 02 Dec 2024 13:58:08 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-00Boj9-37;
	Mon, 02 Dec 2024 13:58:07 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 02 Dec 2024 13:58:00 +0100
Subject: [PATCH v3 01/12] wifi: mwifiex: add missing locking
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-mwifiex-cleanup-1-v3-1-317a6ce0dd5b@pengutronix.de>
References: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
In-Reply-To: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144287; l=1673;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=L7BvnIL4DXQmcjzasQtcRSJHZGaDYANoGBFLqeozp6s=;
 b=MJ37ZEMQJZXKN25jKS3L6LC4zgrNxafRv+wvjcw1a5Ob4u9am8FfNl9CXJ/ciCKAY7KwA+3q2
 UTZFcWyP8T6DpVJ0uUGe0wvkLzX2u4BdmiLDyjsyAVbGIT2SDha9ddp
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


