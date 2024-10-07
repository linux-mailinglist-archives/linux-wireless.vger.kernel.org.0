Return-Path: <linux-wireless+bounces-13638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724249936E8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F71C20F49
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B61DCB2B;
	Mon,  7 Oct 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d7uU8jyj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D935139587
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327337; cv=none; b=qzwexs8/jJ/QgUtfbY4C5yU0M8aZzm/Mx/ErkYlZDtsEJ7ylhBwyf3TkfqURy6xtk5EtN3HKteEgQlL+0iAmNahIyMv6/BCc1JJo3ZzZx32djUmTbp3KY6pIi+L7Wqx1tgqvxh3pyP0KgFqr8t9yIb1HiLtgRu40zC7/R5SW7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327337; c=relaxed/simple;
	bh=VnzXwNlITAk2r/l75nmqmKmF+no7rjIQ/quH8CHLovw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBHZbJLpqa4nPQg661dwEMNXBkcOSA4MKSzpzeqhroytL649tOo4h4BmXQIVAX8O6StqD/yfB0VPfJ1clahwTBzTzLUYYMe0r6gAQucDajtGKPwJYDUtMAQNMA3fmoZYBTJtGcdZbs4lxEuASPuT8xB8mf/8xgVELW7pKQqhhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d7uU8jyj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=suDhCS3V4oEPLjo+nIRTLL1+3fzmATAoj+gou88TTUE=; t=1728327335; x=1729536935; 
	b=d7uU8jyjZxm+y2F/082M5p81LVMrq2pvy1QTMOgU/wOS7ta37pnc9IM/DiDheJueBoBMR8Vcmcj
	4E0qHTx/i0792jHR/1e+084v75mVZjyvI5JaKk7L5jOH2a1VuPFjLDMg12Dw6Xs8O5XlrtI6cNjh9
	EpMW6xLvH9ml4akErO8heakTbetMMC2z9YSiprPg0AFmVYjb0dgrWUJhmcfbElSBYJpFFS9TLgJld
	JQqf0vxVzJE1ljOpz+p61x7KUkDQQzxM31k+/SPRQFwfWFqkl+Q9wxb8U9M51NpQbiLilJFULLRG9
	xrlV07LdqcZewkp4phudzO3AVLybg8m/ikRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxstI-00000003Uop-2lEG;
	Mon, 07 Oct 2024 20:55:32 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: wext/libipw: move spy implementation to libipw
Date: Mon,  7 Oct 2024 20:55:30 +0200
Message-ID: <20241007205530.995eeb87604e.Ib2197cb056ff05746d3521a5fba637062acb7314@changeid>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no driver left using this other than ipw2200,
so move the data bookkeeping and code into libipw.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/ipw2x00/Makefile   |  1 +
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  | 10 +--
 drivers/net/wireless/intel/ipw2x00/libipw.h   | 13 ++++
 .../net/wireless/intel/ipw2x00/libipw_rx.c    |  2 +-
 .../net/wireless/intel/ipw2x00/libipw_spy.c   | 62 +++++++++----------
 include/net/iw_handler.h                      | 18 ------
 6 files changed, 51 insertions(+), 55 deletions(-)
 rename net/wireless/wext-spy.c => drivers/net/wireless/intel/ipw2x00/libipw_spy.c (81%)

diff --git a/drivers/net/wireless/intel/ipw2x00/Makefile b/drivers/net/wireless/intel/ipw2x00/Makefile
index 60c5faccbe15..91e6091c4ebf 100644
--- a/drivers/net/wireless/intel/ipw2x00/Makefile
+++ b/drivers/net/wireless/intel/ipw2x00/Makefile
@@ -13,6 +13,7 @@ libipw-objs := \
 	libipw_rx.o \
 	libipw_wx.o \
 	libipw_geo.o \
+	libipw_spy.o \
 	libipw_crypto.o \
 	libipw_crypto_ccmp.o \
 	libipw_crypto_tkip.o \
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index f4fd1fc784b7..0008b4615731 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -9856,10 +9856,10 @@ static iw_handler ipw_wx_handlers[] = {
 	IW_HANDLER(SIOCGIWENCODE, ipw_wx_get_encode),
 	IW_HANDLER(SIOCSIWPOWER, ipw_wx_set_power),
 	IW_HANDLER(SIOCGIWPOWER, ipw_wx_get_power),
-	IW_HANDLER(SIOCSIWSPY, iw_handler_set_spy),
-	IW_HANDLER(SIOCGIWSPY, iw_handler_get_spy),
-	IW_HANDLER(SIOCSIWTHRSPY, iw_handler_set_thrspy),
-	IW_HANDLER(SIOCGIWTHRSPY, iw_handler_get_thrspy),
+	IW_HANDLER(SIOCSIWSPY, ipw_wx_set_spy),
+	IW_HANDLER(SIOCGIWSPY, ipw_wx_get_spy),
+	IW_HANDLER(SIOCSIWTHRSPY, ipw_wx_set_thrspy),
+	IW_HANDLER(SIOCGIWTHRSPY, ipw_wx_get_thrspy),
 	IW_HANDLER(SIOCSIWGENIE, ipw_wx_set_genie),
 	IW_HANDLER(SIOCGIWGENIE, ipw_wx_get_genie),
 	IW_HANDLER(SIOCSIWMLME, ipw_wx_set_mlme),
@@ -11636,7 +11636,7 @@ static int ipw_pci_probe(struct pci_dev *pdev,
 	priv->ieee->worst_rssi = -85;
 
 	net_dev->netdev_ops = &ipw_netdev_ops;
-	priv->wireless_data.spy_data = &priv->ieee->spy_data;
+	priv->ieee->spy_enabled = true;
 	net_dev->wireless_data = &priv->wireless_data;
 	net_dev->wireless_handlers = &ipw_wx_handler_def;
 	net_dev->ethtool_ops = &ipw_ethtool_ops;
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index bc727c99ff3c..3c20353e5a41 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -788,6 +788,7 @@ struct libipw_device {
 
 	int iw_mode;		/* operating mode (IW_MODE_*) */
 	struct iw_spy_data spy_data;	/* iwspy support */
+	bool spy_enabled;
 
 	spinlock_t lock;
 
@@ -1083,4 +1084,16 @@ void libipw_crypto_tkip_exit(void);
 void libipw_crypto_ccmp_exit(void);
 void libipw_crypto_exit(void);
 
+
+int ipw_wx_set_spy(struct net_device *dev, struct iw_request_info *info,
+		   union iwreq_data *wrqu, char *extra);
+int ipw_wx_get_spy(struct net_device *dev, struct iw_request_info *info,
+		   union iwreq_data *wrqu, char *extra);
+int ipw_wx_set_thrspy(struct net_device *dev, struct iw_request_info *info,
+		      union iwreq_data *wrqu, char *extra);
+int ipw_wx_get_thrspy(struct net_device *dev, struct iw_request_info *info,
+		      union iwreq_data *wrqu, char *extra);
+void libipw_spy_update(struct net_device *dev, unsigned char *address,
+		       struct iw_quality *wstats);
+
 #endif				/* LIBIPW_H */
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 1fe05e73a17c..7e41cb7bbfe0 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -393,7 +393,7 @@ int libipw_rx(struct libipw_device *ieee, struct sk_buff *skb,
 			wstats.updated |= IW_QUAL_QUAL_INVALID;
 
 		/* Update spy records */
-		wireless_spy_update(ieee->dev, hdr->addr2, &wstats);
+		libipw_spy_update(ieee->dev, hdr->addr2, &wstats);
 	}
 #endif				/* IW_WIRELESS_SPY */
 #endif				/* CONFIG_WIRELESS_EXT */
diff --git a/net/wireless/wext-spy.c b/drivers/net/wireless/intel/ipw2x00/libipw_spy.c
similarity index 81%
rename from net/wireless/wext-spy.c
rename to drivers/net/wireless/intel/ipw2x00/libipw_spy.c
index b379a0371653..979aeb10aeeb 100644
--- a/net/wireless/wext-spy.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_spy.c
@@ -14,19 +14,20 @@
 #include <net/iw_handler.h>
 #include <net/arp.h>
 #include <net/wext.h>
+#include "libipw.h"
 
-static inline struct iw_spy_data *get_spydata(struct net_device *dev)
+static struct iw_spy_data *get_spydata(struct net_device *dev)
 {
-	/* This is the new way */
-	if (dev->wireless_data)
-		return dev->wireless_data->spy_data;
+	if (dev->wireless_data && dev->wireless_data->libipw &&
+	    dev->wireless_data->libipw->spy_enabled)
+		return &dev->wireless_data->libipw->spy_data;
 	return NULL;
 }
 
-int iw_handler_set_spy(struct net_device *	dev,
-		       struct iw_request_info *	info,
-		       union iwreq_data *	wrqu,
-		       char *			extra)
+int ipw_wx_set_spy(struct net_device *		dev,
+		   struct iw_request_info *	info,
+		   union iwreq_data *		wrqu,
+		   char *			extra)
 {
 	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct sockaddr *	address = (struct sockaddr *) extra;
@@ -36,15 +37,15 @@ int iw_handler_set_spy(struct net_device *	dev,
 		return -EOPNOTSUPP;
 
 	/* Disable spy collection while we copy the addresses.
-	 * While we copy addresses, any call to wireless_spy_update()
+	 * While we copy addresses, any call to libipw_spy_update()
 	 * will NOP. This is OK, as anyway the addresses are changing. */
 	spydata->spy_number = 0;
 
-	/* We want to operate without locking, because wireless_spy_update()
+	/* We want to operate without locking, because libipw_spy_update()
 	 * most likely will happen in the interrupt handler, and therefore
 	 * have its own locking constraints and needs performance.
 	 * The rtnl_lock() make sure we don't race with the other iw_handlers.
-	 * This make sure wireless_spy_update() "see" that the spy list
+	 * This make sure libipw_spy_update() "see" that the spy list
 	 * is temporarily disabled. */
 	smp_wmb();
 
@@ -69,12 +70,12 @@ int iw_handler_set_spy(struct net_device *	dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(iw_handler_set_spy);
+EXPORT_SYMBOL(ipw_wx_set_spy);
 
-int iw_handler_get_spy(struct net_device *	dev,
-		       struct iw_request_info *	info,
-		       union iwreq_data *	wrqu,
-		       char *			extra)
+int ipw_wx_get_spy(struct net_device *		dev,
+		   struct iw_request_info *	info,
+		   union iwreq_data *		wrqu,
+		   char *			extra)
 {
 	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct sockaddr *	address = (struct sockaddr *) extra;
@@ -101,16 +102,16 @@ int iw_handler_get_spy(struct net_device *	dev,
 		spydata->spy_stat[i].updated &= ~IW_QUAL_ALL_UPDATED;
 	return 0;
 }
-EXPORT_SYMBOL(iw_handler_get_spy);
+EXPORT_SYMBOL(ipw_wx_get_spy);
 
 /*------------------------------------------------------------------*/
 /*
  * Standard Wireless Handler : set spy threshold
  */
-int iw_handler_set_thrspy(struct net_device *	dev,
-			  struct iw_request_info *info,
-			  union iwreq_data *	wrqu,
-			  char *		extra)
+int ipw_wx_set_thrspy(struct net_device *	dev,
+		      struct iw_request_info *	info,
+		      union iwreq_data *	wrqu,
+		      char *			extra)
 {
 	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct iw_thrspy *	threshold = (struct iw_thrspy *) extra;
@@ -128,16 +129,16 @@ int iw_handler_set_thrspy(struct net_device *	dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(iw_handler_set_thrspy);
+EXPORT_SYMBOL(ipw_wx_set_thrspy);
 
 /*------------------------------------------------------------------*/
 /*
  * Standard Wireless Handler : get spy threshold
  */
-int iw_handler_get_thrspy(struct net_device *	dev,
-			  struct iw_request_info *info,
-			  union iwreq_data *	wrqu,
-			  char *		extra)
+int ipw_wx_get_thrspy(struct net_device *	dev,
+		      struct iw_request_info *	info,
+		      union iwreq_data *	wrqu,
+		      char *			extra)
 {
 	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct iw_thrspy *	threshold = (struct iw_thrspy *) extra;
@@ -152,7 +153,7 @@ int iw_handler_get_thrspy(struct net_device *	dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(iw_handler_get_thrspy);
+EXPORT_SYMBOL(ipw_wx_get_thrspy);
 
 /*------------------------------------------------------------------*/
 /*
@@ -189,9 +190,9 @@ static void iw_send_thrspy_event(struct net_device *	dev,
  * small, this is good enough. If we wanted to support larger number of
  * spy addresses, we should use something more efficient...
  */
-void wireless_spy_update(struct net_device *	dev,
-			 unsigned char *	address,
-			 struct iw_quality *	wstats)
+void libipw_spy_update(struct net_device *	dev,
+		       unsigned char *		address,
+		       struct iw_quality *	wstats)
 {
 	struct iw_spy_data *	spydata = get_spydata(dev);
 	int			i;
@@ -229,4 +230,3 @@ void wireless_spy_update(struct net_device *	dev,
 		}
 	}
 }
-EXPORT_SYMBOL(wireless_spy_update);
diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index 7af1082ea9a0..a7b502958d27 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -418,8 +418,6 @@ struct iw_spy_data {
 struct libipw_device;
 /* The struct */
 struct iw_public_data {
-	/* Driver enhanced spy support */
-	struct iw_spy_data *		spy_data;
 	/* Legacy structure managed by the ipw2x00-specific IEEE 802.11 layer */
 	struct libipw_device *		libipw;
 };
@@ -443,22 +441,6 @@ static inline void wireless_nlevent_flush(void) {}
 /* We may need a function to send a stream of events to user space.
  * More on that later... */
 
-/* Standard handler for SIOCSIWSPY */
-int iw_handler_set_spy(struct net_device *dev, struct iw_request_info *info,
-		       union iwreq_data *wrqu, char *extra);
-/* Standard handler for SIOCGIWSPY */
-int iw_handler_get_spy(struct net_device *dev, struct iw_request_info *info,
-		       union iwreq_data *wrqu, char *extra);
-/* Standard handler for SIOCSIWTHRSPY */
-int iw_handler_set_thrspy(struct net_device *dev, struct iw_request_info *info,
-			  union iwreq_data *wrqu, char *extra);
-/* Standard handler for SIOCGIWTHRSPY */
-int iw_handler_get_thrspy(struct net_device *dev, struct iw_request_info *info,
-			  union iwreq_data *wrqu, char *extra);
-/* Driver call to update spy records */
-void wireless_spy_update(struct net_device *dev, unsigned char *address,
-			 struct iw_quality *wstats);
-
 /************************* INLINE FUNCTIONS *************************/
 /*
  * Function that are so simple that it's more efficient inlining them
-- 
2.46.2


