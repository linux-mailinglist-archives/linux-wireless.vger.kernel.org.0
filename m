Return-Path: <linux-wireless+bounces-13505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87D99025F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1717F1F23BCD
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A0172BA9;
	Fri,  4 Oct 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qwwyS00Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A715B145;
	Fri,  4 Oct 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042394; cv=none; b=S3G6Q9kLcjrA7yOM+8Ulo+VoNA4439J0QRDXZPIfZL3+7hIJUTmbItyFvQySzHB4wYFMVlTmIioMB3QnWyS9PKyzR7T2e1rAF3yAR8P4AIMgJbD+hzBF+A87aePDYhMLRqx2G3WWgR577+PMSkqwxqXQ3CbkijLAGK0cJ8l22Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042394; c=relaxed/simple;
	bh=pLRL4uNAsBdSsl/8297mRFSQhpLkaHVbltaBLL3ow1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV4CagGW5XcGIoMmU7E8hgEGr3RZ9kycKryiWlFNYops/5LVi1HEI0SyCmeTO3jsalMMJY+xq2thebJovnEixqOmQv4KhNJVxeKvalGjrcmTQ/ch6C+0lNC8B5IrSR1bNTKDicHdeMmefWQt3jX4SqKRp3nsM1snEPsBGozrSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=qwwyS00Z; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9B86488B99;
	Fri,  4 Oct 2024 13:46:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728042385;
	bh=a3nF4CrOMK8QElXjgm9oSZ32dTmvVTGYmLRfuYBNZrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwwyS00ZixjpiPkkhhIHJCjLnkFuT3nZSJqjATqDAzByDsjzeenrptlKBJ/oup+Ot
	 8R7Ix76prANrFuEwknZD7NNmE06aExdQoK4ewsh76IrknUX55cGU+op9kJHYm+aqoE
	 KYR73AGIuZG82VOpoWO7U4o4EH4Q6YdV+cvUvstAYv9xt2lBrxnK6ZcZ7uMkScOA5S
	 h4xd43yvCydizXSJDCkDc24mJolJ4TZyBGqcNSuLeoTfFEc2Hk3EklPvMaVtP69lC1
	 Pt7y6dF5UL87lnSyeU5PcBBEkJrOypvfb22Sfckd/giiZjPXAqSbS+VwLOPn0ujuQ6
	 d+kv5w8f0RQhQ==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 5/7] wifi: wilc1000: Fold wilc_create_wiphy() into cfg80211.c
Date: Fri,  4 Oct 2024 13:44:14 +0200
Message-ID: <20241004114551.40236-5-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004114551.40236-1-marex@denx.de>
References: <20241004114551.40236-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The wilc_create_wiphy() is not used outside of cfg80211.c .
Make the function static and remove its entry from cfg80211.h

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V5: New patch
V6: - Add RB from Alexis
    - Rebase on next-20240926
V7: - Rebase on next-20241003 / wireless-next/main 5a4d42c1688c
      with v2 wifi: wilc1000: Keep slot powered on during suspend/resume
V8: No change
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 94 +++++++++----------
 .../wireless/microchip/wilc1000/cfg80211.h    |  1 -
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index eb37b228d54ea..11e0f8a473467 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1757,53 +1757,7 @@ void wlan_deinit_locks(struct wilc *wilc)
 	cleanup_srcu_struct(&wilc->srcu);
 }
 
-int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
-		       const struct wilc_hif_func *ops)
-{
-	struct wilc *wl;
-	int ret, i;
-
-	wl = wilc_create_wiphy(dev);
-	if (!wl)
-		return -EINVAL;
-
-	wlan_init_locks(wl);
-
-	ret = wilc_wlan_cfg_init(wl);
-	if (ret)
-		goto free_wl;
-
-	*wilc = wl;
-	wl->io_type = io_type;
-	wl->hif_func = ops;
-
-	for (i = 0; i < NQUEUES; i++)
-		INIT_LIST_HEAD(&wl->txq[i].txq_head.list);
-
-	INIT_LIST_HEAD(&wl->rxq_head.list);
-	INIT_LIST_HEAD(&wl->vif_list);
-
-	wl->hif_workqueue = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
-						    wiphy_name(wl->wiphy));
-	if (!wl->hif_workqueue) {
-		ret = -ENOMEM;
-		goto free_cfg;
-	}
-
-	return 0;
-
-free_cfg:
-	wilc_wlan_cfg_deinit(wl);
-
-free_wl:
-	wlan_deinit_locks(wl);
-	wiphy_unregister(wl->wiphy);
-	wiphy_free(wl->wiphy);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
-
-struct wilc *wilc_create_wiphy(struct device *dev)
+static struct wilc *wilc_create_wiphy(struct device *dev)
 {
 	struct wiphy *wiphy;
 	struct wilc *wl;
@@ -1861,6 +1815,52 @@ struct wilc *wilc_create_wiphy(struct device *dev)
 	return wl;
 }
 
+int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
+		       const struct wilc_hif_func *ops)
+{
+	struct wilc *wl;
+	int ret, i;
+
+	wl = wilc_create_wiphy(dev);
+	if (!wl)
+		return -EINVAL;
+
+	wlan_init_locks(wl);
+
+	ret = wilc_wlan_cfg_init(wl);
+	if (ret)
+		goto free_wl;
+
+	*wilc = wl;
+	wl->io_type = io_type;
+	wl->hif_func = ops;
+
+	for (i = 0; i < NQUEUES; i++)
+		INIT_LIST_HEAD(&wl->txq[i].txq_head.list);
+
+	INIT_LIST_HEAD(&wl->rxq_head.list);
+	INIT_LIST_HEAD(&wl->vif_list);
+
+	wl->hif_workqueue = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
+						    wiphy_name(wl->wiphy));
+	if (!wl->hif_workqueue) {
+		ret = -ENOMEM;
+		goto free_cfg;
+	}
+
+	return 0;
+
+free_cfg:
+	wilc_wlan_cfg_deinit(wl);
+
+free_wl:
+	wlan_deinit_locks(wl);
+	wiphy_unregister(wl->wiphy);
+	wiphy_free(wl->wiphy);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
+
 int wilc_init_host_int(struct net_device *net)
 {
 	int ret;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.h b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
index 8c65951cfaf96..fc04cc6615c1f 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.h
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
@@ -10,7 +10,6 @@
 
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		       const struct wilc_hif_func *ops);
-struct wilc *wilc_create_wiphy(struct device *dev);
 void wilc_deinit_host_int(struct net_device *net);
 int wilc_init_host_int(struct net_device *net);
 void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size);
-- 
2.45.2


