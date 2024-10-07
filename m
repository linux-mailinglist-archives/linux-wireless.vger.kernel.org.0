Return-Path: <linux-wireless+bounces-13639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B49936F2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEEEB209B0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C11D90CB;
	Mon,  7 Oct 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J42herDm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5A320F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327781; cv=none; b=q1ClvTpTXwLnJ6AzDEDtljQ+w1uDWkJ711+mioufBn3wkEiwd/sjAJOXQHfdMnuc4xqFmhlSi/vOiwLHhw7rY7ITBJpTEMMF9DTbLFRyfHy2fVoZN1N+8FsEcS7vuibHjNxs8Z4xVuogjfSRp2wGimVIhw0SgirWqa6rCUDKClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327781; c=relaxed/simple;
	bh=HkznQ4FVPA6lKAn1tur5vpWE+bkkDSC4CTcrFyErFds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivl0GQw45FEhX6vAFAmCgnwXeshMyfr7SisSvXRDaktuOKxQAfuGVlLUTvTjaAjOcrVqTRiEBF1W5SyHpPOCTsthRmDammtLSZcIigNwpCQMDaU2raAjb44tTS6AgHsVLpafzZfp8of2duhhdEOTjkiDb8wpM+OSnYhRvjIcarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J42herDm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=eUZbf72+zXB8hhnpYth2+ftLhnwTBWpD7PaGree3tAQ=; t=1728327779; x=1729537379; 
	b=J42herDmnlwSxlWR4LNuFr8WiWJ8Xaws8PBWXUDW5CGbenNY6JI905cPVEFX/iMyut6Utwze8i5
	7iIzb5DHAcEKhUzbvmhDI4JtRgDPjXgUs5RwtBdBNEbRSa8nQK+pu5IVK+cfyA2PYOaRwTHtetlzg
	YfjF8p/PmtM3n7aad6yj/cV2kW9So/pDz8uRU/5wj4sweeu7IyrpnErnhrzuiab8GUZ8OPAGgjfLY
	4HQuo751l/g/lPHrR7kO6FZUkjuHLsZo1lvPuFM2V1FMGXZKJ1vN3D7y1oB7CuhKEt5KrfOXU35or
	MC8Vk7e0K40J61JaxB9ovslPZwVfaiaVhKYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxt0S-00000003Uxg-2egU;
	Mon, 07 Oct 2024 21:02:56 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] wifi: wext/libipw: move spy implementation to libipw
Date: Mon,  7 Oct 2024 21:02:53 +0200
Message-ID: <20241007210254.037d864cda7d.Ib2197cb056ff05746d3521a5fba637062acb7314@changeid>
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
v2: fix Kconfig/Makefile
---
 drivers/net/wireless/intel/ipw2x00/Kconfig    |  3 -
 drivers/net/wireless/intel/ipw2x00/Makefile   |  1 +
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  | 10 +--
 drivers/net/wireless/intel/ipw2x00/libipw.h   | 13 ++++
 .../net/wireless/intel/ipw2x00/libipw_rx.c    |  2 +-
 .../net/wireless/intel/ipw2x00/libipw_spy.c   | 62 +++++++++----------
 include/net/iw_handler.h                      | 18 ------
 net/wireless/Kconfig                          |  3 -
 net/wireless/Makefile                         |  1 -
 9 files changed, 51 insertions(+), 62 deletions(-)
 rename net/wireless/wext-spy.c => drivers/net/wireless/intel/ipw2x00/libipw_spy.c (81%)

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index d9c042772399..ce34118f1e90 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -7,7 +7,6 @@ config IPW2100
 	tristate "Intel PRO/Wireless 2100 Network Connection"
 	depends on PCI && CFG80211
 	select WIRELESS_EXT
-	select WEXT_SPY
 	select WEXT_PRIV
 	select FW_LOADER
 	select LIBIPW
@@ -68,7 +67,6 @@ config IPW2200
 	depends on PCI && CFG80211
 	select CFG80211_WEXT_EXPORT
 	select WIRELESS_EXT
-	select WEXT_SPY
 	select WEXT_PRIV
 	select FW_LOADER
 	select LIBIPW
@@ -156,7 +154,6 @@ config LIBIPW
 	tristate
 	depends on PCI && CFG80211
 	select WIRELESS_EXT
-	select WEXT_SPY
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	select CRC32
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
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 733c53ad4de5..8c8bd8b75708 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -11,9 +11,6 @@ config WEXT_PROC
 	depends on PROC_FS
 	depends on WEXT_CORE
 
-config WEXT_SPY
-	bool
-
 config WEXT_PRIV
 	bool
 
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 27f211bd9954..62a83faf0e07 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -4,7 +4,6 @@ obj-y += tests/
 
 obj-$(CONFIG_WEXT_CORE) += wext-core.o
 obj-$(CONFIG_WEXT_PROC) += wext-proc.o
-obj-$(CONFIG_WEXT_SPY) += wext-spy.o
 obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
 
 cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
-- 
2.46.2


