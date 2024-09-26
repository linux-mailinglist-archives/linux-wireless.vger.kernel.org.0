Return-Path: <linux-wireless+bounces-13243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF39879DE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 21:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7E81C245DE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA7185B70;
	Thu, 26 Sep 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="t/F+5ucy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3D18452C;
	Thu, 26 Sep 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380661; cv=none; b=kqVMtf9b4BF7A4jcWUhj4bB8n3fNBKB+REdsaDjMezLCm4/sAPVxUtlMhsLCFzQ7gfnK/hLZT44E3DhTkUhxNtgSqhja4k7FJPOmo5tQ7mQzVq1NxRGfq2HeNMlicgt/EUTJ/ZE11PyXquCqHL+AwQ1e8Jx88QhVa5zS9qqsBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380661; c=relaxed/simple;
	bh=7IdB4dp2e7dd24F5nb10NbmyBhBrq0SvEOnfno3U5Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRiJHf1gn+MiZx5LeaqvIOHgLS+wnsmWrrslLQ57ngx8HMhoSaELGsC7FyHKkn7idefAQeADW47L74BwhEp1Bjl4KY1pWha/NkweK8IKwUjBxlNEawRFr8f1bYo/ehri5Hv1d0Q7MO9S63y3ZTlXE6Lu5uvyfhRCIVlARXKoVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=t/F+5ucy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2525888DB5;
	Thu, 26 Sep 2024 21:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727380656;
	bh=paaseMB0vCFsj+9GPhnuQLDEdm/m7t/d70WayqI3Y5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/F+5ucykkwNoEIhQSBkaTTqr135hocMwZL7HQAR2e0kHCaC6D49R9u0rfz8/7a4D
	 SOkxIO3pIfqw2XtslsEWMfY4xO747ol4inoN4BY7XhLUip6cZYd9uhCOjuN+c9x8c1
	 UmX/hSJvNBYyLjk6FrEdFCCw88knbCU30eEBsjoh5UJa/pVMzTH/0vWzMlwH7+SQXp
	 8kzJX2VDvCCPcWMmBlWh2BpERMWuJpURLLRHVOVA4tf5xsKeNFPaygY0nukYuvxGx5
	 R23IdJzFToCyLZtlsNpuMACZLawhTn+zL5TXxF9H+w85lJ2pv1d6yjEPFC6b07TtXb
	 j5+cGzqC6Keig==
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
Subject: [PATCH v6 6/7] wifi: wilc1000: Register wiphy after reading out chipid
Date: Thu, 26 Sep 2024 21:55:46 +0200
Message-ID: <20240926195700.2823751-6-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240926195700.2823751-1-marex@denx.de>
References: <20240926195700.2823751-1-marex@denx.de>
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

Register wiphy after reading out chipid, so the chipid can be
used to determine chip features and not advertise WPA3/SAE
support to userspace on WILC3000. Note that wilc_netdev_cleanup()
will deregister the wiphy in fail path.

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
V6: - Rebase on next-20240926
---
 .../net/wireless/microchip/wilc1000/cfg80211.c    | 15 ++++++++-------
 .../net/wireless/microchip/wilc1000/cfg80211.h    |  1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c    |  4 ++++
 drivers/net/wireless/microchip/wilc1000/spi.c     |  4 ++++
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 11e0f8a473467..30015c5920467 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1761,7 +1761,6 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
 {
 	struct wiphy *wiphy;
 	struct wilc *wl;
-	int ret;
 
 	wiphy = wiphy_new(&wilc_cfg80211_ops, sizeof(*wl));
 	if (!wiphy)
@@ -1804,14 +1803,8 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
 				BIT(NL80211_IFTYPE_P2P_GO) |
 				BIT(NL80211_IFTYPE_P2P_CLIENT);
 	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-	wiphy->features |= NL80211_FEATURE_SAE;
 	set_wiphy_dev(wiphy, dev);
 	wl->wiphy = wiphy;
-	ret = wiphy_register(wiphy);
-	if (ret) {
-		wiphy_free(wiphy);
-		return NULL;
-	}
 	return wl;
 }
 
@@ -1861,6 +1854,14 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 }
 EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
 
+int wilc_cfg80211_register(struct wilc *wilc)
+{
+	wilc->wiphy->features |= NL80211_FEATURE_SAE;
+
+	return wiphy_register(wilc->wiphy);
+}
+EXPORT_SYMBOL_GPL(wilc_cfg80211_register);
+
 int wilc_init_host_int(struct net_device *net)
 {
 	int ret;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.h b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
index fc04cc6615c1f..2dc9c1c42d609 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.h
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
@@ -10,6 +10,7 @@
 
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		       const struct wilc_hif_func *ops);
+int wilc_cfg80211_register(struct wilc *wilc);
 void wilc_deinit_host_int(struct net_device *net);
 int wilc_init_host_int(struct net_device *net);
 void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size);
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 9173f6f3beabf..56a929281d6a7 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -186,6 +186,10 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	if (ret)
 		goto dispose_irq;
 
+	ret = wilc_cfg80211_register(wilc);
+	if (ret)
+		goto dispose_irq;
+
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 81cf82c9175ef..28d211ee60096 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -249,6 +249,10 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (ret)
 		goto power_down;
 
+	ret = wilc_cfg80211_register(wilc);
+	if (ret)
+		goto power_down;
+
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
-- 
2.45.2


