Return-Path: <linux-wireless+bounces-8981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026C9074AF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720442822E4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95132145B25;
	Thu, 13 Jun 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TXvnPkH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E1144D21;
	Thu, 13 Jun 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287822; cv=none; b=GHm3lIiN+HZ4XXjaEQiHz1X8YIfP1QJfC7D3z3PX91SGP2mjmatjYNK0V3Za2czlZmvzvlilvwp5ka39IKkcbA+dGVDlU7/BMCWulJJxGyYvVBuFhgVq/hYo8KrLsW776Jz78cWspuAhHaIYgh7DXJHS4qTllXT0J5RxWUgIL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287822; c=relaxed/simple;
	bh=GpFmutC7qNS5D63XKNVZU++STRMERLCcpZP+B831mbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abJ/ZOjurIjrspJgkBjYw3OtZzu7Afz4ZVH34Kgmbk1rzVgTuRhbX3hkaNkz6dcS0XHqXbp+LBSGbeMJUlrUVBVs96B6hKHP73/a1m9UvEvWYw5IpgH94cb0/o22Y+Eka6JFoQA0nOlgAwEdbxqvz0ZmQ3lKXu2J3+zxvZKYlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TXvnPkH9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 697C61BF212;
	Thu, 13 Jun 2024 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RClnKQFv64FuSlC1HxBHws576hIZFiDk+emFZ0rBLhM=;
	b=TXvnPkH95jxbM/0Oh9ooTTmgWKqly+qkpsIe4F8gyGh1TkJMU7P+cIP4hvbi7hBaTudAr2
	QV4dF3kmbt+bzXGoqQDGMoFjukC49S83olv85zb9wE1B5kX3M+ZQo6mOXw7Pi3nKfNtrDw
	PEMDi8SMu1rUsVXOGQ4fTlXHQcgnApyhrWnIykBr+qV6WwB+q94i2tkIHzHDJ0J3KDaM7v
	olvbg+mZRK3rk66BXKyuGtyjBDg+qtsSHllStXNvTT/t+sLeJcJBSFBdaj9ckWcWEN+0N/
	0Xt+q6Fj49WpMWYVbXob72Dg3CSFa4ffNh6K3Y6RpCY3dnSStDOtCZ8CitgmKw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Jun 2024 16:06:44 +0200
Subject: [PATCH 5/6] wifi: wilc1000: remove suspend/resume from cfg80211
 part
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-wilc_suspend-v1-5-c2f766d0988c@bootlin.com>
References: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
In-Reply-To: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

WILC1000 suspend/resume implementation is currently composed of two parts:
suspend/resume ops implemented in cfg80211 ops, which merely sets a
flag, and suspend/resume ops in sdio/spi driver which, based on this flag,
execute or not the suspend/resume mechanism. This dual set of ops is not
really needed , so keep only the sdio part to implement suspend/resume.

While doing so, remove the now unused suspend_event flag.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 19 -------------------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  1 -
 drivers/net/wireless/microchip/wilc1000/sdio.c     |  6 ++----
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index ba02e6cfd3ae..eb37b228d54e 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1617,23 +1617,6 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	return 0;
 }
 
-static int wilc_suspend(struct wiphy *wiphy, struct cfg80211_wowlan *wow)
-{
-	struct wilc *wl = wiphy_priv(wiphy);
-
-	if (!wow && wilc_wlan_get_num_conn_ifcs(wl))
-		wl->suspend_event = true;
-	else
-		wl->suspend_event = false;
-
-	return 0;
-}
-
-static int wilc_resume(struct wiphy *wiphy)
-{
-	return 0;
-}
-
 static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
 {
 	struct wilc *wl = wiphy_priv(wiphy);
@@ -1739,8 +1722,6 @@ static const struct cfg80211_ops wilc_cfg80211_ops = {
 	.set_power_mgmt = set_power_mgmt,
 	.set_cqm_rssi_config = set_cqm_rssi_config,
 
-	.suspend = wilc_suspend,
-	.resume = wilc_resume,
 	.set_wakeup = wilc_set_wakeup,
 	.set_tx_power = set_tx_power,
 	.get_tx_power = get_tx_power,
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index e59d1b6f5d7d..95bc8b8fe65a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -272,7 +272,6 @@ struct wilc {
 	const struct firmware *firmware;
 
 	struct device *dev;
-	bool suspend_event;
 
 	struct workqueue_struct *hif_workqueue;
 	struct wilc_cfg cfg;
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 21398a3c600b..4e7014670945 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -980,8 +980,7 @@ static int wilc_sdio_suspend(struct device *dev)
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
 
-	if (wilc->suspend_event)
-		host_sleep_notify(wilc);
+	host_sleep_notify(wilc);
 
 	ret = wilc_sdio_reset(wilc);
 	if (ret) {
@@ -1000,8 +999,7 @@ static int wilc_sdio_resume(struct device *dev)
 	dev_info(dev, "sdio resume\n");
 	wilc_sdio_init(wilc, true);
 
-	if (wilc->suspend_event)
-		host_wakeup_notify(wilc);
+	host_wakeup_notify(wilc);
 
 	return 0;
 }

-- 
2.45.2


