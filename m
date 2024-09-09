Return-Path: <linux-wireless+bounces-12695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F59722BD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D671F2385E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C9A18B474;
	Mon,  9 Sep 2024 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ouLhq5Ei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769DC18A6A1;
	Mon,  9 Sep 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910264; cv=none; b=mweUuN8yhK2M4ZQsUqJNStWjnWq58GDmZswWomzLb7Rz57Ek+9Ymz1zevrNsd9MgZjHIjBpBS6pws/Nfgr1fSlw5eg77Z8v9EaFZOdrvFF9ndhLHLW8jKzghx84la3VeyOh/WKnKuReDpzCog4f+sQH0uQKddKrn5FLK/jNpezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910264; c=relaxed/simple;
	bh=qxjn6GWauHWZhtwtpRvQNIEokgLDG5gnjPFyBPlENDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnPYLwmptEI8RnN/iJKcMcJbAOGHWb+H7nocJiRjL1ImbpfXQXEo+1hg4ZmbhNkfkq2g0K8fxrWYQ4TbZjdGW2USMru8oBstF1nR4n+KNnOIpzaZvcGk9mYpMPlziCg0kPABEq0tRokUAMxvXPjON2RWLBRcr9d5Q1UNag0LGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ouLhq5Ei; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 26F9288E1B;
	Mon,  9 Sep 2024 21:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725910255;
	bh=nDmXuFqEqA4ZhC5gzMqRtrUEvzsn1a7WIidh2iziyHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouLhq5Ei7e3c+i3To7AFMn2kTldpOyVShkjyMWZwUDvl7peytJLIQOwjRF1UhIE40
	 7x1toNLkeR3aZtkeOazGRcAczCEUeBcT466y2Y5H/Ze4MDCzhWcuDWGnOE2mFpNNkh
	 CieKsNjSgBGgoILgyym9JNa9U0Vshu+GrvYatShy6ah2/YZ+gCqynTAFTk+xvPduDI
	 tbehmKEp3EuPVG0b08RKfXxmNLcg1/PFtaEVCFfO7H/gi/hr8P5bzmwwvkhfPXqVaj
	 +qTmmoHyCFGb//C2r9UMXcbJ193KbQp9O05YIfwa8EfMgE+LwzMcbHvYccj4+9m0k3
	 TEOmT0REuzuFQ==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
Subject: [PATCH v5 5/9] wifi: wilc1000: Fold wilc_create_wiphy() into cfg80211.c
Date: Mon,  9 Sep 2024 21:29:46 +0200
Message-ID: <20240909193035.69823-5-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909193035.69823-1-marex@denx.de>
References: <20240909193035.69823-1-marex@denx.de>
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


