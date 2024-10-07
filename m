Return-Path: <linux-wireless+bounces-13628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449219935D9
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9811C23828
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84913B58B;
	Mon,  7 Oct 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HspODCLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5611DDC38;
	Mon,  7 Oct 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324961; cv=none; b=UagumXwaxhn9Oda5M7tH+k9vABYEQOCIMQaggyy1WUNRSAi864s811AsyP2w4D+S0kgygQ2SCE6FIBgcMdLdXUDlF2Z2iUEIk2QbYG+IhaZk1U+ai7fhFAGhC7efdg0emKsw4zmNDvKi67HmnGL7rPrSv1rlIx/SoovF+agqVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324961; c=relaxed/simple;
	bh=sDtOhk+DLZDrWHhoEv3eyBJJiaNUqcoHcs6lHLdxSus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MK7wuS5HppGPBjts2P7aLyCewyn4vTCR+dnKi+AWzJvmjIdTSlL0UyxmbzGQQdTPqazlhT1jvNzC710NUJLo7dFW9njb/LIm+19jyloqr+h91nt+z2JymQfP3D/sV3D/VXpseC0hQAZGYgOJgvG32EEFEkZoG96bubMJvwzaOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HspODCLs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tcsZS62XHqpjcEGPjb12q7OIj72IEs2t1MNYp9q2s0M=;
	t=1728324957; x=1729534557; b=HspODCLslotVjEZb+3AZG1tuBOQaKF7LURZPgCFtKyXp01/
	wFpB3iQp0l8I4NtfjgxV6i2bwUjCAg/ETSvq3RLd9QBWjmCuL+YLdEcAtBMCsR4OHHu39MD8mNDeo
	Ymge+RGJbbIPXLc+Hen9Wwv+GOAG4R3+oj8ozpUrJ4QQv1jn8vsQcD5VOJJGpB9zoq9VzOf+GMPg8
	MWuBaYQohyVEtcil5gMbSp94CYjYIfvEj8GWFOyVC/5VHxHHrElh/bVCTitDCotT5UpbjyqHAAJbk
	DkALKHPCCYJT62BlComz2PzBb/1bsifkHp14BbCNtSvwhxWtWwuSeEgB+8A1tccw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsGw-00000003TpG-2cEA;
	Mon, 07 Oct 2024 20:15:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] wifi: ipw2x00/lib80211: move remaining lib80211 into libipw
Date: Mon,  7 Oct 2024 20:10:55 +0200
Message-ID: <20241007201545.c5bf91757d2e.Ib9876d2fe3c90f11d6df458b16d0b7d4bf551a8d@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007181545.63207-7-johannes@sipsolutions.net>
References: <20241007181545.63207-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's already much code in libipw that used to be shared
with more drivers, but now with the prior cleanups, those old
Intel ipw2x00 drivers are also the only ones using whatever is
now left of lib80211. Move lib80211 entirely into libipw.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/ipw2x00/Kconfig    |   6 -
 drivers/net/wireless/intel/ipw2x00/Makefile   |   6 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |   7 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  |   4 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h  |   2 -
 drivers/net/wireless/intel/ipw2x00/libipw.h   | 101 ++++++-
 .../wireless/intel/ipw2x00/libipw_crypto.c    | 247 +++++++++++++++++
 .../intel/ipw2x00/libipw_crypto_ccmp.c        |  74 +++--
 .../intel/ipw2x00/libipw_crypto_tkip.c        | 102 ++++---
 .../intel/ipw2x00/libipw_crypto_wep.c         |  73 +++--
 .../wireless/intel/ipw2x00/libipw_module.c    |  36 ++-
 .../net/wireless/intel/ipw2x00/libipw_rx.c    |   9 +-
 .../net/wireless/intel/ipw2x00/libipw_tx.c    |   4 +-
 .../net/wireless/intel/ipw2x00/libipw_wx.c    |  43 ++-
 include/net/lib80211.h                        | 122 ---------
 net/wireless/Makefile                         |   4 -
 net/wireless/lib80211.c                       | 257 ------------------
 17 files changed, 523 insertions(+), 574 deletions(-)
 create mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
 rename net/wireless/lib80211_crypt_ccmp.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c (83%)
 rename net/wireless/lib80211_crypt_tkip.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c (87%)
 rename net/wireless/lib80211_crypt_wep.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c (72%)
 delete mode 100644 include/net/lib80211.h
 delete mode 100644 net/wireless/lib80211.c

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index 1650d5865aa0..d9c042772399 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -10,7 +10,6 @@ config IPW2100
 	select WEXT_SPY
 	select WEXT_PRIV
 	select FW_LOADER
-	select LIB80211
 	select LIBIPW
 	help
 	  A driver for the Intel PRO/Wireless 2100 Network
@@ -72,7 +71,6 @@ config IPW2200
 	select WEXT_SPY
 	select WEXT_PRIV
 	select FW_LOADER
-	select LIB80211
 	select LIBIPW
 	help
 	  A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
@@ -162,10 +160,6 @@ config LIBIPW
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	select CRC32
-	select LIB80211
-	select LIB80211_CRYPT_WEP
-	select LIB80211_CRYPT_TKIP
-	select LIB80211_CRYPT_CCMP
 	help
 	This option enables the hardware independent IEEE 802.11
 	networking stack.  This component is deprecated in favor of the
diff --git a/drivers/net/wireless/intel/ipw2x00/Makefile b/drivers/net/wireless/intel/ipw2x00/Makefile
index e1ec50359dff..60c5faccbe15 100644
--- a/drivers/net/wireless/intel/ipw2x00/Makefile
+++ b/drivers/net/wireless/intel/ipw2x00/Makefile
@@ -12,4 +12,8 @@ libipw-objs := \
 	libipw_tx.o \
 	libipw_rx.o \
 	libipw_wx.o \
-	libipw_geo.o
+	libipw_geo.o \
+	libipw_crypto.o \
+	libipw_crypto_ccmp.o \
+	libipw_crypto_tkip.o \
+	libipw_crypto_wep.o
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index b6636002c7d2..a89e06c1b8ee 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -148,9 +148,6 @@ that only one external action is invoked at a time.
 #include <linux/acpi.h>
 #include <linux/ctype.h>
 #include <linux/pm_qos.h>
-
-#include <net/lib80211.h>
-
 #include "ipw2100.h"
 #include "ipw.h"
 
@@ -7571,7 +7568,7 @@ static int ipw2100_wx_set_auth(struct net_device *dev,
 	struct ipw2100_priv *priv = libipw_priv(dev);
 	struct libipw_device *ieee = priv->ieee;
 	struct iw_param *param = &wrqu->param;
-	struct lib80211_crypt_data *crypt;
+	struct libipw_crypt_data *crypt;
 	unsigned long flags;
 	int ret = 0;
 
@@ -7663,7 +7660,7 @@ static int ipw2100_wx_get_auth(struct net_device *dev,
 {
 	struct ipw2100_priv *priv = libipw_priv(dev);
 	struct libipw_device *ieee = priv->ieee;
-	struct lib80211_crypt_data *crypt;
+	struct libipw_crypt_data *crypt;
 	struct iw_param *param = &wrqu->param;
 
 	switch (param->flags & IW_AUTH_INDEX) {
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index eed9ef17bc29..f4fd1fc784b7 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -6549,7 +6549,7 @@ static int ipw_wx_set_auth(struct net_device *dev,
 	struct ipw_priv *priv = libipw_priv(dev);
 	struct libipw_device *ieee = priv->ieee;
 	struct iw_param *param = &wrqu->param;
-	struct lib80211_crypt_data *crypt;
+	struct libipw_crypt_data *crypt;
 	unsigned long flags;
 	int ret = 0;
 
@@ -6648,7 +6648,7 @@ static int ipw_wx_get_auth(struct net_device *dev,
 {
 	struct ipw_priv *priv = libipw_priv(dev);
 	struct libipw_device *ieee = priv->ieee;
-	struct lib80211_crypt_data *crypt;
+	struct libipw_crypt_data *crypt;
 	struct iw_param *param = &wrqu->param;
 
 	switch (param->flags & IW_AUTH_INDEX) {
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 8ebf09121e17..46f119123b49 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -31,8 +31,6 @@
 #include <linux/wireless.h>
 #include <linux/jiffies.h>
 #include <asm/io.h>
-
-#include <net/lib80211.h>
 #include <net/ieee80211_radiotap.h>
 
 #define DRV_NAME	"ipw2200"
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index bad080d33c07..bc727c99ff3c 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -25,8 +25,6 @@
 #include <linux/kernel.h>	/* ARRAY_SIZE */
 #include <linux/wireless.h>
 #include <linux/ieee80211.h>
-
-#include <net/lib80211.h>
 #include <net/cfg80211.h>
 
 #define LIBIPW_VERSION "git-1.1.13"
@@ -699,6 +697,76 @@ struct libipw_geo {
 	struct libipw_channel a[LIBIPW_52GHZ_CHANNELS];
 };
 
+#define NUM_WEP_KEYS	4
+
+enum {
+	IEEE80211_CRYPTO_TKIP_COUNTERMEASURES = (1 << 0),
+};
+
+struct module;
+
+struct libipw_crypto_ops {
+	const char *name;
+	struct list_head list;
+
+	/* init new crypto context (e.g., allocate private data space,
+	 * select IV, etc.); returns NULL on failure or pointer to allocated
+	 * private data on success */
+	void *(*init) (int keyidx);
+
+	/* deinitialize crypto context and free allocated private data */
+	void (*deinit) (void *priv);
+
+	/* encrypt/decrypt return < 0 on error or >= 0 on success. The return
+	 * value from decrypt_mpdu is passed as the keyidx value for
+	 * decrypt_msdu. skb must have enough head and tail room for the
+	 * encryption; if not, error will be returned; these functions are
+	 * called for all MPDUs (i.e., fragments).
+	 */
+	int (*encrypt_mpdu) (struct sk_buff * skb, int hdr_len, void *priv);
+	int (*decrypt_mpdu) (struct sk_buff * skb, int hdr_len, void *priv);
+
+	/* These functions are called for full MSDUs, i.e. full frames.
+	 * These can be NULL if full MSDU operations are not needed. */
+	int (*encrypt_msdu) (struct sk_buff * skb, int hdr_len, void *priv);
+	int (*decrypt_msdu) (struct sk_buff * skb, int keyidx, int hdr_len,
+			     void *priv);
+
+	int (*set_key) (void *key, int len, u8 * seq, void *priv);
+	int (*get_key) (void *key, int len, u8 * seq, void *priv);
+
+	/* procfs handler for printing out key information and possible
+	 * statistics */
+	void (*print_stats) (struct seq_file *m, void *priv);
+
+	/* Crypto specific flag get/set for configuration settings */
+	unsigned long (*get_flags) (void *priv);
+	unsigned long (*set_flags) (unsigned long flags, void *priv);
+
+	/* maximum number of bytes added by encryption; encrypt buf is
+	 * allocated with extra_prefix_len bytes, copy of in_buf, and
+	 * extra_postfix_len; encrypt need not use all this space, but
+	 * the result must start at the beginning of the buffer and correct
+	 * length must be returned */
+	int extra_mpdu_prefix_len, extra_mpdu_postfix_len;
+	int extra_msdu_prefix_len, extra_msdu_postfix_len;
+
+	struct module *owner;
+};
+
+struct libipw_crypt_info {
+	char *name;
+	/* Most clients will already have a lock,
+	   so just point to that. */
+	spinlock_t *lock;
+
+	struct libipw_crypt_data *crypt[NUM_WEP_KEYS];
+	int tx_keyidx;		/* default TX key index (crypt[tx_keyidx]) */
+	struct list_head crypt_deinit_list;
+	struct timer_list crypt_deinit_timer;
+	int crypt_quiesced;
+};
+
 struct libipw_device {
 	struct net_device *dev;
 	struct wireless_dev wdev;
@@ -751,7 +819,7 @@ struct libipw_device {
 	size_t wpa_ie_len;
 	u8 *wpa_ie;
 
-	struct lib80211_crypt_info crypt_info;
+	struct libipw_crypt_info crypt_info;
 
 	int bcrx_sta_key;	/* use individual keys to override default keys even
 				 * with RX of broad/multicast frames */
@@ -988,4 +1056,31 @@ static inline int libipw_get_scans(struct libipw_device *ieee)
 	return ieee->scans;
 }
 
+struct libipw_crypt_data {
+	struct list_head list;	/* delayed deletion list */
+	const struct libipw_crypto_ops *ops;
+	void *priv;
+	atomic_t refcnt;
+};
+
+int libipw_crypt_info_init(struct libipw_crypt_info *info, char *name,
+			   spinlock_t *lock);
+void libipw_crypt_info_free(struct libipw_crypt_info *info);
+int libipw_register_crypto_ops(const struct libipw_crypto_ops *ops);
+int libipw_unregister_crypto_ops(const struct libipw_crypto_ops *ops);
+const struct libipw_crypto_ops *libipw_get_crypto_ops(const char *name);
+void libipw_crypt_delayed_deinit(struct libipw_crypt_info *info,
+				 struct libipw_crypt_data **crypt);
+
+/* must be called in the listed order */
+int libipw_crypto_init(void);
+int libipw_crypto_ccmp_init(void);
+int libipw_crypto_tkip_init(void);
+int libipw_crypto_wep_init(void);
+
+void libipw_crypto_wep_exit(void);
+void libipw_crypto_tkip_exit(void);
+void libipw_crypto_ccmp_exit(void);
+void libipw_crypto_exit(void);
+
 #endif				/* LIBIPW_H */
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
new file mode 100644
index 000000000000..44d3eedac873
--- /dev/null
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * libipw -- common bits for IPW drivers
+ *
+ * Copyright(c) 2008 John W. Linville <linville@tuxdriver.com>
+ *
+ * Portions copied from old ieee80211 component, w/ original copyright
+ * notices below:
+ *
+ * Host AP crypto routines
+ *
+ * Copyright (c) 2002-2003, Jouni Malinen <j@w1.fi>
+ * Portions Copyright (C) 2004, Intel Corporation <jketreno@linux.intel.com>
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/ieee80211.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include "libipw.h"
+
+struct libipw_crypto_alg {
+	struct list_head list;
+	const struct libipw_crypto_ops *ops;
+};
+
+static LIST_HEAD(libipw_crypto_algs);
+static DEFINE_SPINLOCK(libipw_crypto_lock);
+
+static void libipw_crypt_deinit_entries(struct libipw_crypt_info *info,
+					  int force);
+static void libipw_crypt_quiescing(struct libipw_crypt_info *info);
+static void libipw_crypt_deinit_handler(struct timer_list *t);
+
+int libipw_crypt_info_init(struct libipw_crypt_info *info, char *name,
+				spinlock_t *lock)
+{
+	memset(info, 0, sizeof(*info));
+
+	info->name = name;
+	info->lock = lock;
+
+	INIT_LIST_HEAD(&info->crypt_deinit_list);
+	timer_setup(&info->crypt_deinit_timer, libipw_crypt_deinit_handler,
+		    0);
+
+	return 0;
+}
+EXPORT_SYMBOL(libipw_crypt_info_init);
+
+void libipw_crypt_info_free(struct libipw_crypt_info *info)
+{
+	int i;
+
+        libipw_crypt_quiescing(info);
+        del_timer_sync(&info->crypt_deinit_timer);
+        libipw_crypt_deinit_entries(info, 1);
+
+        for (i = 0; i < NUM_WEP_KEYS; i++) {
+                struct libipw_crypt_data *crypt = info->crypt[i];
+                if (crypt) {
+                        if (crypt->ops) {
+                                crypt->ops->deinit(crypt->priv);
+                                module_put(crypt->ops->owner);
+                        }
+                        kfree(crypt);
+                        info->crypt[i] = NULL;
+                }
+        }
+}
+EXPORT_SYMBOL(libipw_crypt_info_free);
+
+static void libipw_crypt_deinit_entries(struct libipw_crypt_info *info,
+					int force)
+{
+	struct libipw_crypt_data *entry, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(info->lock, flags);
+	list_for_each_entry_safe(entry, next, &info->crypt_deinit_list, list) {
+		if (atomic_read(&entry->refcnt) != 0 && !force)
+			continue;
+
+		list_del(&entry->list);
+
+		if (entry->ops) {
+			entry->ops->deinit(entry->priv);
+			module_put(entry->ops->owner);
+		}
+		kfree(entry);
+	}
+	spin_unlock_irqrestore(info->lock, flags);
+}
+
+/* After this, crypt_deinit_list won't accept new members */
+static void libipw_crypt_quiescing(struct libipw_crypt_info *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(info->lock, flags);
+	info->crypt_quiesced = 1;
+	spin_unlock_irqrestore(info->lock, flags);
+}
+
+static void libipw_crypt_deinit_handler(struct timer_list *t)
+{
+	struct libipw_crypt_info *info = from_timer(info, t,
+						    crypt_deinit_timer);
+	unsigned long flags;
+
+	libipw_crypt_deinit_entries(info, 0);
+
+	spin_lock_irqsave(info->lock, flags);
+	if (!list_empty(&info->crypt_deinit_list) && !info->crypt_quiesced) {
+		printk(KERN_DEBUG "%s: entries remaining in delayed crypt "
+		       "deletion list\n", info->name);
+		info->crypt_deinit_timer.expires = jiffies + HZ;
+		add_timer(&info->crypt_deinit_timer);
+	}
+	spin_unlock_irqrestore(info->lock, flags);
+}
+
+void libipw_crypt_delayed_deinit(struct libipw_crypt_info *info,
+				 struct libipw_crypt_data **crypt)
+{
+	struct libipw_crypt_data *tmp;
+	unsigned long flags;
+
+	if (*crypt == NULL)
+		return;
+
+	tmp = *crypt;
+	*crypt = NULL;
+
+	/* must not run ops->deinit() while there may be pending encrypt or
+	 * decrypt operations. Use a list of delayed deinits to avoid needing
+	 * locking. */
+
+	spin_lock_irqsave(info->lock, flags);
+	if (!info->crypt_quiesced) {
+		list_add(&tmp->list, &info->crypt_deinit_list);
+		if (!timer_pending(&info->crypt_deinit_timer)) {
+			info->crypt_deinit_timer.expires = jiffies + HZ;
+			add_timer(&info->crypt_deinit_timer);
+		}
+	}
+	spin_unlock_irqrestore(info->lock, flags);
+}
+EXPORT_SYMBOL(libipw_crypt_delayed_deinit);
+
+int libipw_register_crypto_ops(const struct libipw_crypto_ops *ops)
+{
+	unsigned long flags;
+	struct libipw_crypto_alg *alg;
+
+	alg = kzalloc(sizeof(*alg), GFP_KERNEL);
+	if (alg == NULL)
+		return -ENOMEM;
+
+	alg->ops = ops;
+
+	spin_lock_irqsave(&libipw_crypto_lock, flags);
+	list_add(&alg->list, &libipw_crypto_algs);
+	spin_unlock_irqrestore(&libipw_crypto_lock, flags);
+
+	printk(KERN_DEBUG "libipw_crypt: registered algorithm '%s'\n",
+	       ops->name);
+
+	return 0;
+}
+EXPORT_SYMBOL(libipw_register_crypto_ops);
+
+int libipw_unregister_crypto_ops(const struct libipw_crypto_ops *ops)
+{
+	struct libipw_crypto_alg *alg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&libipw_crypto_lock, flags);
+	list_for_each_entry(alg, &libipw_crypto_algs, list) {
+		if (alg->ops == ops)
+			goto found;
+	}
+	spin_unlock_irqrestore(&libipw_crypto_lock, flags);
+	return -EINVAL;
+
+      found:
+	printk(KERN_DEBUG "libipw_crypt: unregistered algorithm '%s'\n",
+	       ops->name);
+	list_del(&alg->list);
+	spin_unlock_irqrestore(&libipw_crypto_lock, flags);
+	kfree(alg);
+	return 0;
+}
+EXPORT_SYMBOL(libipw_unregister_crypto_ops);
+
+const struct libipw_crypto_ops *libipw_get_crypto_ops(const char *name)
+{
+	struct libipw_crypto_alg *alg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&libipw_crypto_lock, flags);
+	list_for_each_entry(alg, &libipw_crypto_algs, list) {
+		if (strcmp(alg->ops->name, name) == 0)
+			goto found;
+	}
+	spin_unlock_irqrestore(&libipw_crypto_lock, flags);
+	return NULL;
+
+      found:
+	spin_unlock_irqrestore(&libipw_crypto_lock, flags);
+	return alg->ops;
+}
+EXPORT_SYMBOL(libipw_get_crypto_ops);
+
+static void *libipw_crypt_null_init(int keyidx)
+{
+	return (void *)1;
+}
+
+static void libipw_crypt_null_deinit(void *priv)
+{
+}
+
+static const struct libipw_crypto_ops libipw_crypt_null = {
+	.name = "NULL",
+	.init = libipw_crypt_null_init,
+	.deinit = libipw_crypt_null_deinit,
+	.owner = THIS_MODULE,
+};
+
+int __init libipw_crypto_init(void)
+{
+	return libipw_register_crypto_ops(&libipw_crypt_null);
+}
+
+void __exit libipw_crypto_exit(void)
+{
+	libipw_unregister_crypto_ops(&libipw_crypt_null);
+	BUG_ON(!list_empty(&libipw_crypto_algs));
+
+}
diff --git a/net/wireless/lib80211_crypt_ccmp.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c
similarity index 83%
rename from net/wireless/lib80211_crypt_ccmp.c
rename to drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c
index 5aad139130e1..796fd97f3543 100644
--- a/net/wireless/lib80211_crypt_ccmp.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * lib80211 crypt: host-based CCMP encryption implementation for lib80211
+ * libipw crypt: host-based CCMP encryption implementation for libipw
  *
  * Copyright (c) 2003-2004, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2008, John W. Linville <linville@tuxdriver.com>
@@ -18,17 +18,10 @@
 #include <linux/if_arp.h>
 #include <asm/string.h>
 #include <linux/wireless.h>
-
 #include <linux/ieee80211.h>
-
 #include <linux/crypto.h>
 #include <crypto/aead.h>
-
-#include <net/lib80211.h>
-
-MODULE_AUTHOR("Jouni Malinen");
-MODULE_DESCRIPTION("Host AP crypt: CCMP");
-MODULE_LICENSE("GPL");
+#include "libipw.h"
 
 #define AES_BLOCK_LEN 16
 #define CCMP_HDR_LEN 8
@@ -36,7 +29,7 @@ MODULE_LICENSE("GPL");
 #define CCMP_TK_LEN 16
 #define CCMP_PN_LEN 6
 
-struct lib80211_ccmp_data {
+struct libipw_ccmp_data {
 	u8 key[CCMP_TK_LEN];
 	int key_set;
 
@@ -56,9 +49,9 @@ struct lib80211_ccmp_data {
 	u8 rx_aad[2 * AES_BLOCK_LEN];
 };
 
-static void *lib80211_ccmp_init(int key_idx)
+static void *libipw_ccmp_init(int key_idx)
 {
-	struct lib80211_ccmp_data *priv;
+	struct libipw_ccmp_data *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
 	if (priv == NULL)
@@ -83,9 +76,9 @@ static void *lib80211_ccmp_init(int key_idx)
 	return NULL;
 }
 
-static void lib80211_ccmp_deinit(void *priv)
+static void libipw_ccmp_deinit(void *priv)
 {
-	struct lib80211_ccmp_data *_priv = priv;
+	struct libipw_ccmp_data *_priv = priv;
 	if (_priv && _priv->tfm)
 		crypto_free_aead(_priv->tfm);
 	kfree(priv);
@@ -150,10 +143,10 @@ static int ccmp_init_iv_and_aad(const struct ieee80211_hdr *hdr,
 	return aad_len;
 }
 
-static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
+static int libipw_ccmp_hdr(struct sk_buff *skb, int hdr_len,
 			      u8 *aeskey, int keylen, void *priv)
 {
-	struct lib80211_ccmp_data *key = priv;
+	struct libipw_ccmp_data *key = priv;
 	int i;
 	u8 *pos;
 
@@ -187,9 +180,9 @@ static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
 	return CCMP_HDR_LEN;
 }
 
-static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
+static int libipw_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
-	struct lib80211_ccmp_data *key = priv;
+	struct libipw_ccmp_data *key = priv;
 	struct ieee80211_hdr *hdr;
 	struct aead_request *req;
 	struct scatterlist sg[2];
@@ -202,7 +195,7 @@ static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		return -1;
 
 	data_len = skb->len - hdr_len;
-	len = lib80211_ccmp_hdr(skb, hdr_len, NULL, 0, priv);
+	len = libipw_ccmp_hdr(skb, hdr_len, NULL, 0, priv);
 	if (len < 0)
 		return -1;
 
@@ -251,9 +244,9 @@ static inline int ccmp_replay_check(u8 *pn_n, u8 *pn_o)
 	return 0;
 }
 
-static int lib80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
+static int libipw_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
-	struct lib80211_ccmp_data *key = priv;
+	struct libipw_ccmp_data *key = priv;
 	u8 keyidx, *pos;
 	struct ieee80211_hdr *hdr;
 	struct aead_request *req;
@@ -344,9 +337,9 @@ static int lib80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-static int lib80211_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
+static int libipw_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
 {
-	struct lib80211_ccmp_data *data = priv;
+	struct libipw_ccmp_data *data = priv;
 	int keyidx;
 	struct crypto_aead *tfm = data->tfm;
 
@@ -376,9 +369,9 @@ static int lib80211_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
 	return 0;
 }
 
-static int lib80211_ccmp_get_key(void *key, int len, u8 * seq, void *priv)
+static int libipw_ccmp_get_key(void *key, int len, u8 * seq, void *priv)
 {
-	struct lib80211_ccmp_data *data = priv;
+	struct libipw_ccmp_data *data = priv;
 
 	if (len < CCMP_TK_LEN)
 		return -1;
@@ -399,9 +392,9 @@ static int lib80211_ccmp_get_key(void *key, int len, u8 * seq, void *priv)
 	return CCMP_TK_LEN;
 }
 
-static void lib80211_ccmp_print_stats(struct seq_file *m, void *priv)
+static void libipw_ccmp_print_stats(struct seq_file *m, void *priv)
 {
-	struct lib80211_ccmp_data *ccmp = priv;
+	struct libipw_ccmp_data *ccmp = priv;
 
 	seq_printf(m,
 		   "key[%d] alg=CCMP key_set=%d "
@@ -418,31 +411,28 @@ static void lib80211_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
 }
 
-static const struct lib80211_crypto_ops lib80211_crypt_ccmp = {
+static const struct libipw_crypto_ops libipw_crypt_ccmp = {
 	.name = "CCMP",
-	.init = lib80211_ccmp_init,
-	.deinit = lib80211_ccmp_deinit,
-	.encrypt_mpdu = lib80211_ccmp_encrypt,
-	.decrypt_mpdu = lib80211_ccmp_decrypt,
+	.init = libipw_ccmp_init,
+	.deinit = libipw_ccmp_deinit,
+	.encrypt_mpdu = libipw_ccmp_encrypt,
+	.decrypt_mpdu = libipw_ccmp_decrypt,
 	.encrypt_msdu = NULL,
 	.decrypt_msdu = NULL,
-	.set_key = lib80211_ccmp_set_key,
-	.get_key = lib80211_ccmp_get_key,
-	.print_stats = lib80211_ccmp_print_stats,
+	.set_key = libipw_ccmp_set_key,
+	.get_key = libipw_ccmp_get_key,
+	.print_stats = libipw_ccmp_print_stats,
 	.extra_mpdu_prefix_len = CCMP_HDR_LEN,
 	.extra_mpdu_postfix_len = CCMP_MIC_LEN,
 	.owner = THIS_MODULE,
 };
 
-static int __init lib80211_crypto_ccmp_init(void)
+int __init libipw_crypto_ccmp_init(void)
 {
-	return lib80211_register_crypto_ops(&lib80211_crypt_ccmp);
+	return libipw_register_crypto_ops(&libipw_crypt_ccmp);
 }
 
-static void __exit lib80211_crypto_ccmp_exit(void)
+void __exit libipw_crypto_ccmp_exit(void)
 {
-	lib80211_unregister_crypto_ops(&lib80211_crypt_ccmp);
+	libipw_unregister_crypto_ops(&libipw_crypt_ccmp);
 }
-
-module_init(lib80211_crypto_ccmp_init);
-module_exit(lib80211_crypto_ccmp_exit);
diff --git a/net/wireless/lib80211_crypt_tkip.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
similarity index 87%
rename from net/wireless/lib80211_crypt_tkip.c
rename to drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
index 63e68e5e121e..06973ad6fac6 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * lib80211 crypt: host-based TKIP encryption implementation for lib80211
+ * libipw crypt: host-based TKIP encryption implementation for libipw
  *
  * Copyright (c) 2003-2004, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2008, John W. Linville <linville@tuxdriver.com>
@@ -21,25 +21,18 @@
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <asm/string.h>
-
 #include <linux/wireless.h>
 #include <linux/ieee80211.h>
 #include <net/iw_handler.h>
-
 #include <crypto/arc4.h>
 #include <crypto/hash.h>
 #include <linux/crypto.h>
 #include <linux/crc32.h>
-
-#include <net/lib80211.h>
-
-MODULE_AUTHOR("Jouni Malinen");
-MODULE_DESCRIPTION("lib80211 crypt: TKIP");
-MODULE_LICENSE("GPL");
+#include "libipw.h"
 
 #define TKIP_HDR_LEN 8
 
-struct lib80211_tkip_data {
+struct libipw_tkip_data {
 #define TKIP_KEY_LEN 32
 	u8 key[TKIP_KEY_LEN];
 	int key_set;
@@ -73,23 +66,23 @@ struct lib80211_tkip_data {
 	unsigned long flags;
 };
 
-static unsigned long lib80211_tkip_set_flags(unsigned long flags, void *priv)
+static unsigned long libipw_tkip_set_flags(unsigned long flags, void *priv)
 {
-	struct lib80211_tkip_data *_priv = priv;
+	struct libipw_tkip_data *_priv = priv;
 	unsigned long old_flags = _priv->flags;
 	_priv->flags = flags;
 	return old_flags;
 }
 
-static unsigned long lib80211_tkip_get_flags(void *priv)
+static unsigned long libipw_tkip_get_flags(void *priv)
 {
-	struct lib80211_tkip_data *_priv = priv;
+	struct libipw_tkip_data *_priv = priv;
 	return _priv->flags;
 }
 
-static void *lib80211_tkip_init(int key_idx)
+static void *libipw_tkip_init(int key_idx)
 {
-	struct lib80211_tkip_data *priv;
+	struct libipw_tkip_data *priv;
 
 	if (fips_enabled)
 		return NULL;
@@ -124,9 +117,9 @@ static void *lib80211_tkip_init(int key_idx)
 	return NULL;
 }
 
-static void lib80211_tkip_deinit(void *priv)
+static void libipw_tkip_deinit(void *priv)
 {
-	struct lib80211_tkip_data *_priv = priv;
+	struct libipw_tkip_data *_priv = priv;
 	if (_priv) {
 		crypto_free_shash(_priv->tx_tfm_michael);
 		crypto_free_shash(_priv->rx_tfm_michael);
@@ -280,10 +273,10 @@ static void tkip_mixing_phase2(u8 * WEPSeed, const u8 * TK, const u16 * TTAK,
 #endif
 }
 
-static int lib80211_tkip_hdr(struct sk_buff *skb, int hdr_len,
+static int libipw_tkip_hdr(struct sk_buff *skb, int hdr_len,
 			      u8 * rc4key, int keylen, void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 	u8 *pos;
 	struct ieee80211_hdr *hdr;
 
@@ -324,9 +317,9 @@ static int lib80211_tkip_hdr(struct sk_buff *skb, int hdr_len,
 	return TKIP_HDR_LEN;
 }
 
-static int lib80211_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
+static int libipw_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 	int len;
 	u8 rc4key[16], *pos, *icv;
 	u32 crc;
@@ -344,7 +337,7 @@ static int lib80211_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	len = skb->len - hdr_len;
 	pos = skb->data + hdr_len;
 
-	if ((lib80211_tkip_hdr(skb, hdr_len, rc4key, 16, priv)) < 0)
+	if ((libipw_tkip_hdr(skb, hdr_len, rc4key, 16, priv)) < 0)
 		return -1;
 
 	crc = ~crc32_le(~0, pos, len);
@@ -373,9 +366,9 @@ static inline int tkip_replay_check(u32 iv32_n, u16 iv16_n,
 	return 0;
 }
 
-static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
+static int libipw_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 	u8 rc4key[16];
 	u8 keyidx, *pos;
 	u32 iv32;
@@ -538,10 +531,10 @@ static void michael_mic_hdr(struct sk_buff *skb, u8 * hdr)
 	hdr[13] = hdr[14] = hdr[15] = 0;	/* reserved */
 }
 
-static int lib80211_michael_mic_add(struct sk_buff *skb, int hdr_len,
+static int libipw_michael_mic_add(struct sk_buff *skb, int hdr_len,
 				     void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 	u8 *pos;
 
 	if (skb_tailroom(skb) < 8 || skb->len < hdr_len) {
@@ -560,7 +553,7 @@ static int lib80211_michael_mic_add(struct sk_buff *skb, int hdr_len,
 	return 0;
 }
 
-static void lib80211_michael_mic_failure(struct net_device *dev,
+static void libipw_michael_mic_failure(struct net_device *dev,
 					  struct ieee80211_hdr *hdr,
 					  int keyidx)
 {
@@ -581,10 +574,10 @@ static void lib80211_michael_mic_failure(struct net_device *dev,
 	wireless_send_event(dev, IWEVMICHAELMICFAILURE, &wrqu, (char *)&ev);
 }
 
-static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
+static int libipw_michael_mic_verify(struct sk_buff *skb, int keyidx,
 					int hdr_len, void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 	u8 mic[8];
 
 	if (!tkey->key_set)
@@ -602,7 +595,7 @@ static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
 		       skb->dev ? skb->dev->name : "N/A", hdr->addr2,
 		       keyidx);
 		if (skb->dev)
-			lib80211_michael_mic_failure(skb->dev, hdr, keyidx);
+			libipw_michael_mic_failure(skb->dev, hdr, keyidx);
 		tkey->dot11RSNAStatsTKIPLocalMICFailures++;
 		return -1;
 	}
@@ -617,9 +610,9 @@ static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	return 0;
 }
 
-static int lib80211_tkip_set_key(void *key, int len, u8 * seq, void *priv)
+static int libipw_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 	int keyidx;
 	struct crypto_shash *tfm = tkey->tx_tfm_michael;
 	struct arc4_ctx *tfm2 = &tkey->tx_ctx_arc4;
@@ -650,9 +643,9 @@ static int lib80211_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 	return 0;
 }
 
-static int lib80211_tkip_get_key(void *key, int len, u8 * seq, void *priv)
+static int libipw_tkip_get_key(void *key, int len, u8 * seq, void *priv)
 {
-	struct lib80211_tkip_data *tkey = priv;
+	struct libipw_tkip_data *tkey = priv;
 
 	if (len < TKIP_KEY_LEN)
 		return -1;
@@ -679,9 +672,9 @@ static int lib80211_tkip_get_key(void *key, int len, u8 * seq, void *priv)
 	return TKIP_KEY_LEN;
 }
 
-static void lib80211_tkip_print_stats(struct seq_file *m, void *priv)
+static void libipw_tkip_print_stats(struct seq_file *m, void *priv)
 {
-	struct lib80211_tkip_data *tkip = priv;
+	struct libipw_tkip_data *tkip = priv;
 	seq_printf(m,
 		   "key[%d] alg=TKIP key_set=%d "
 		   "tx_pn=%02x%02x%02x%02x%02x%02x "
@@ -705,34 +698,31 @@ static void lib80211_tkip_print_stats(struct seq_file *m, void *priv)
 		   tkip->dot11RSNAStatsTKIPLocalMICFailures);
 }
 
-static const struct lib80211_crypto_ops lib80211_crypt_tkip = {
+static const struct libipw_crypto_ops libipw_crypt_tkip = {
 	.name = "TKIP",
-	.init = lib80211_tkip_init,
-	.deinit = lib80211_tkip_deinit,
-	.encrypt_mpdu = lib80211_tkip_encrypt,
-	.decrypt_mpdu = lib80211_tkip_decrypt,
-	.encrypt_msdu = lib80211_michael_mic_add,
-	.decrypt_msdu = lib80211_michael_mic_verify,
-	.set_key = lib80211_tkip_set_key,
-	.get_key = lib80211_tkip_get_key,
-	.print_stats = lib80211_tkip_print_stats,
+	.init = libipw_tkip_init,
+	.deinit = libipw_tkip_deinit,
+	.encrypt_mpdu = libipw_tkip_encrypt,
+	.decrypt_mpdu = libipw_tkip_decrypt,
+	.encrypt_msdu = libipw_michael_mic_add,
+	.decrypt_msdu = libipw_michael_mic_verify,
+	.set_key = libipw_tkip_set_key,
+	.get_key = libipw_tkip_get_key,
+	.print_stats = libipw_tkip_print_stats,
 	.extra_mpdu_prefix_len = 4 + 4,	/* IV + ExtIV */
 	.extra_mpdu_postfix_len = 4,	/* ICV */
 	.extra_msdu_postfix_len = 8,	/* MIC */
-	.get_flags = lib80211_tkip_get_flags,
-	.set_flags = lib80211_tkip_set_flags,
+	.get_flags = libipw_tkip_get_flags,
+	.set_flags = libipw_tkip_set_flags,
 	.owner = THIS_MODULE,
 };
 
-static int __init lib80211_crypto_tkip_init(void)
+int __init libipw_crypto_tkip_init(void)
 {
-	return lib80211_register_crypto_ops(&lib80211_crypt_tkip);
+	return libipw_register_crypto_ops(&libipw_crypt_tkip);
 }
 
-static void __exit lib80211_crypto_tkip_exit(void)
+void __exit libipw_crypto_tkip_exit(void)
 {
-	lib80211_unregister_crypto_ops(&lib80211_crypt_tkip);
+	libipw_unregister_crypto_ops(&libipw_crypt_tkip);
 }
-
-module_init(lib80211_crypto_tkip_init);
-module_exit(lib80211_crypto_tkip_exit);
diff --git a/net/wireless/lib80211_crypt_wep.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c
similarity index 72%
rename from net/wireless/lib80211_crypt_wep.c
rename to drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c
index 3b148c7bef85..c3a4ccb9de17 100644
--- a/net/wireless/lib80211_crypt_wep.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * lib80211 crypt: host-based WEP encryption implementation for lib80211
+ * libipw crypt: host-based WEP encryption implementation for libipw
  *
  * Copyright (c) 2002-2004, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2008, John W. Linville <linville@tuxdriver.com>
@@ -16,17 +16,11 @@
 #include <linux/skbuff.h>
 #include <linux/mm.h>
 #include <asm/string.h>
-
-#include <net/lib80211.h>
-
 #include <crypto/arc4.h>
 #include <linux/crc32.h>
+#include "libipw.h"
 
-MODULE_AUTHOR("Jouni Malinen");
-MODULE_DESCRIPTION("lib80211 crypt: WEP");
-MODULE_LICENSE("GPL");
-
-struct lib80211_wep_data {
+struct libipw_wep_data {
 	u32 iv;
 #define WEP_KEY_LEN 13
 	u8 key[WEP_KEY_LEN + 1];
@@ -36,9 +30,9 @@ struct lib80211_wep_data {
 	struct arc4_ctx rx_ctx;
 };
 
-static void *lib80211_wep_init(int keyidx)
+static void *libipw_wep_init(int keyidx)
 {
-	struct lib80211_wep_data *priv;
+	struct libipw_wep_data *priv;
 
 	if (fips_enabled)
 		return NULL;
@@ -54,16 +48,16 @@ static void *lib80211_wep_init(int keyidx)
 	return priv;
 }
 
-static void lib80211_wep_deinit(void *priv)
+static void libipw_wep_deinit(void *priv)
 {
 	kfree_sensitive(priv);
 }
 
 /* Add WEP IV/key info to a frame that has at least 4 bytes of headroom */
-static int lib80211_wep_build_iv(struct sk_buff *skb, int hdr_len,
+static int libipw_wep_build_iv(struct sk_buff *skb, int hdr_len,
 			       u8 *key, int keylen, void *priv)
 {
-	struct lib80211_wep_data *wep = priv;
+	struct libipw_wep_data *wep = priv;
 	u32 klen;
 	u8 *pos;
 
@@ -102,19 +96,19 @@ static int lib80211_wep_build_iv(struct sk_buff *skb, int hdr_len,
  *
  * WEP frame payload: IV + TX key idx, RC4(data), ICV = RC4(CRC32(data))
  */
-static int lib80211_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
+static int libipw_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
-	struct lib80211_wep_data *wep = priv;
+	struct libipw_wep_data *wep = priv;
 	u32 crc, klen, len;
 	u8 *pos, *icv;
 	u8 key[WEP_KEY_LEN + 3];
 
-	/* other checks are in lib80211_wep_build_iv */
+	/* other checks are in libipw_wep_build_iv */
 	if (skb_tailroom(skb) < 4)
 		return -1;
 
 	/* add the IV to the frame */
-	if (lib80211_wep_build_iv(skb, hdr_len, NULL, 0, priv))
+	if (libipw_wep_build_iv(skb, hdr_len, NULL, 0, priv))
 		return -1;
 
 	/* Copy the IV into the first 3 bytes of the key */
@@ -148,9 +142,9 @@ static int lib80211_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
  * Returns 0 if frame was decrypted successfully and ICV was correct and -1 on
  * failure. If frame is OK, IV and ICV will be removed.
  */
-static int lib80211_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
+static int libipw_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
-	struct lib80211_wep_data *wep = priv;
+	struct libipw_wep_data *wep = priv;
 	u32 crc, klen, plen;
 	u8 key[WEP_KEY_LEN + 3];
 	u8 keyidx, *pos, icv[4];
@@ -195,9 +189,9 @@ static int lib80211_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return 0;
 }
 
-static int lib80211_wep_set_key(void *key, int len, u8 * seq, void *priv)
+static int libipw_wep_set_key(void *key, int len, u8 * seq, void *priv)
 {
-	struct lib80211_wep_data *wep = priv;
+	struct libipw_wep_data *wep = priv;
 
 	if (len < 0 || len > WEP_KEY_LEN)
 		return -1;
@@ -208,9 +202,9 @@ static int lib80211_wep_set_key(void *key, int len, u8 * seq, void *priv)
 	return 0;
 }
 
-static int lib80211_wep_get_key(void *key, int len, u8 * seq, void *priv)
+static int libipw_wep_get_key(void *key, int len, u8 * seq, void *priv)
 {
-	struct lib80211_wep_data *wep = priv;
+	struct libipw_wep_data *wep = priv;
 
 	if (len < wep->key_len)
 		return -1;
@@ -220,37 +214,34 @@ static int lib80211_wep_get_key(void *key, int len, u8 * seq, void *priv)
 	return wep->key_len;
 }
 
-static void lib80211_wep_print_stats(struct seq_file *m, void *priv)
+static void libipw_wep_print_stats(struct seq_file *m, void *priv)
 {
-	struct lib80211_wep_data *wep = priv;
+	struct libipw_wep_data *wep = priv;
 	seq_printf(m, "key[%d] alg=WEP len=%d\n", wep->key_idx, wep->key_len);
 }
 
-static const struct lib80211_crypto_ops lib80211_crypt_wep = {
+static const struct libipw_crypto_ops libipw_crypt_wep = {
 	.name = "WEP",
-	.init = lib80211_wep_init,
-	.deinit = lib80211_wep_deinit,
-	.encrypt_mpdu = lib80211_wep_encrypt,
-	.decrypt_mpdu = lib80211_wep_decrypt,
+	.init = libipw_wep_init,
+	.deinit = libipw_wep_deinit,
+	.encrypt_mpdu = libipw_wep_encrypt,
+	.decrypt_mpdu = libipw_wep_decrypt,
 	.encrypt_msdu = NULL,
 	.decrypt_msdu = NULL,
-	.set_key = lib80211_wep_set_key,
-	.get_key = lib80211_wep_get_key,
-	.print_stats = lib80211_wep_print_stats,
+	.set_key = libipw_wep_set_key,
+	.get_key = libipw_wep_get_key,
+	.print_stats = libipw_wep_print_stats,
 	.extra_mpdu_prefix_len = 4,	/* IV */
 	.extra_mpdu_postfix_len = 4,	/* ICV */
 	.owner = THIS_MODULE,
 };
 
-static int __init lib80211_crypto_wep_init(void)
+int __init libipw_crypto_wep_init(void)
 {
-	return lib80211_register_crypto_ops(&lib80211_crypt_wep);
+	return libipw_register_crypto_ops(&libipw_crypt_wep);
 }
 
-static void __exit lib80211_crypto_wep_exit(void)
+void __exit libipw_crypto_wep_exit(void)
 {
-	lib80211_unregister_crypto_ops(&lib80211_crypt_wep);
+	libipw_unregister_crypto_ops(&libipw_crypt_wep);
 }
-
-module_init(lib80211_crypto_wep_init);
-module_exit(lib80211_crypto_wep_exit);
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_module.c b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
index 43bab92a4148..0a16127bfd68 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_module.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
@@ -169,7 +169,7 @@ struct net_device *alloc_libipw(int sizeof_priv, int monitor)
 
 	spin_lock_init(&ieee->lock);
 
-	lib80211_crypt_info_init(&ieee->crypt_info, dev->name, &ieee->lock);
+	libipw_crypt_info_init(&ieee->crypt_info, dev->name, &ieee->lock);
 
 	ieee->wpa_enabled = 0;
 	ieee->drop_unencrypted = 0;
@@ -191,7 +191,7 @@ void free_libipw(struct net_device *dev, int monitor)
 {
 	struct libipw_device *ieee = netdev_priv(dev);
 
-	lib80211_crypt_info_free(&ieee->crypt_info);
+	libipw_crypt_info_free(&ieee->crypt_info);
 
 	libipw_networks_free(ieee);
 
@@ -251,6 +251,7 @@ static const struct proc_ops debug_level_proc_ops = {
 
 static int __init libipw_init(void)
 {
+	int err;
 #ifdef CONFIG_LIBIPW_DEBUG
 	struct proc_dir_entry *e;
 
@@ -273,7 +274,33 @@ static int __init libipw_init(void)
 	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
 	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
 
+	err = libipw_crypto_init();
+	if (err)
+		goto remove_debugfs;
+	err = libipw_crypto_ccmp_init();
+	if (err)
+		goto uninit_crypto;
+	err = libipw_crypto_tkip_init();
+	if (err)
+		goto uninit_crypto_ccmp;
+	err = libipw_crypto_wep_init();
+	if (err)
+		goto uninit_crypto_tkip;
+
 	return 0;
+uninit_crypto_tkip:
+	libipw_crypto_tkip_exit();
+uninit_crypto_ccmp:
+	libipw_crypto_ccmp_exit();
+uninit_crypto:
+	libipw_crypto_exit();
+remove_debugfs:
+#ifdef CONFIG_LIBIPW_DEBUG
+	remove_proc_entry("debug_level", libipw_proc);
+	remove_proc_entry(DRV_PROCNAME, init_net.proc_net);
+	libipw_proc = NULL;
+#endif
+	return err;
 }
 
 static void __exit libipw_exit(void)
@@ -285,6 +312,11 @@ static void __exit libipw_exit(void)
 		libipw_proc = NULL;
 	}
 #endif				/* CONFIG_LIBIPW_DEBUG */
+
+	libipw_crypto_ccmp_exit();
+	libipw_crypto_tkip_exit();
+	libipw_crypto_wep_exit();
+	libipw_crypto_exit();
 }
 
 #ifdef CONFIG_LIBIPW_DEBUG
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 48d6870bbf4e..1fe05e73a17c 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -27,9 +27,6 @@
 #include <linux/etherdevice.h>
 #include <linux/uaccess.h>
 #include <linux/ctype.h>
-
-#include <net/lib80211.h>
-
 #include "libipw.h"
 
 static void libipw_monitor_rx(struct libipw_device *ieee,
@@ -266,7 +263,7 @@ static int libipw_is_eapol_frame(struct libipw_device *ieee,
 /* Called only as a tasklet (software IRQ), by libipw_rx */
 static int
 libipw_rx_frame_decrypt(struct libipw_device *ieee, struct sk_buff *skb,
-			   struct lib80211_crypt_data *crypt)
+			   struct libipw_crypt_data *crypt)
 {
 	struct libipw_hdr_3addr *hdr;
 	int res, hdrlen;
@@ -298,7 +295,7 @@ libipw_rx_frame_decrypt(struct libipw_device *ieee, struct sk_buff *skb,
 static int
 libipw_rx_frame_decrypt_msdu(struct libipw_device *ieee,
 				struct sk_buff *skb, int keyidx,
-				struct lib80211_crypt_data *crypt)
+				struct libipw_crypt_data *crypt)
 {
 	struct libipw_hdr_3addr *hdr;
 	int res, hdrlen;
@@ -345,7 +342,7 @@ int libipw_rx(struct libipw_device *ieee, struct sk_buff *skb,
 #endif
 	u8 dst[ETH_ALEN];
 	u8 src[ETH_ALEN];
-	struct lib80211_crypt_data *crypt = NULL;
+	struct libipw_crypt_data *crypt = NULL;
 	int keyidx = 0;
 	int can_be_decrypted = 0;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
index e22a6732a4c3..80edaa3dea9c 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
@@ -138,7 +138,7 @@ static int libipw_copy_snap(u8 * data, __be16 h_proto)
 static int libipw_encrypt_fragment(struct libipw_device *ieee,
 					     struct sk_buff *frag, int hdr_len)
 {
-	struct lib80211_crypt_data *crypt =
+	struct libipw_crypt_data *crypt =
 		ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	int res;
 
@@ -255,7 +255,7 @@ netdev_tx_t libipw_xmit(struct sk_buff *skb, struct net_device *dev)
 		.qos_ctl = 0
 	};
 	u8 dest[ETH_ALEN], src[ETH_ALEN];
-	struct lib80211_crypt_data *crypt;
+	struct libipw_crypt_data *crypt;
 	int priority = skb->priority;
 	int snapped = 0;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
index dbc7153d0a3d..db71d81b0d4f 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
@@ -21,10 +21,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/jiffies.h>
-
-#include <net/lib80211.h>
 #include <linux/wireless.h>
-
 #include "libipw.h"
 
 static const char *libipw_modes[] = {
@@ -303,7 +300,7 @@ int libipw_wx_set_encode(struct libipw_device *ieee,
 		.flags = 0
 	};
 	int i, key, key_provided, len;
-	struct lib80211_crypt_data **crypt;
+	struct libipw_crypt_data **crypt;
 	int host_crypto = ieee->host_encrypt || ieee->host_decrypt;
 
 	LIBIPW_DEBUG_WX("SET_ENCODE\n");
@@ -328,7 +325,7 @@ int libipw_wx_set_encode(struct libipw_device *ieee,
 		if (key_provided && *crypt) {
 			LIBIPW_DEBUG_WX("Disabling encryption on key %d.\n",
 					   key);
-			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
+			libipw_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 		} else
 			LIBIPW_DEBUG_WX("Disabling encryption.\n");
 
@@ -338,7 +335,7 @@ int libipw_wx_set_encode(struct libipw_device *ieee,
 			if (ieee->crypt_info.crypt[i] != NULL) {
 				if (key_provided)
 					break;
-				lib80211_crypt_delayed_deinit(&ieee->crypt_info,
+				libipw_crypt_delayed_deinit(&ieee->crypt_info,
 							       &ieee->crypt_info.crypt[i]);
 			}
 		}
@@ -361,21 +358,21 @@ int libipw_wx_set_encode(struct libipw_device *ieee,
 	    strcmp((*crypt)->ops->name, "WEP") != 0) {
 		/* changing to use WEP; deinit previously used algorithm
 		 * on this key */
-		lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
+		libipw_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 	}
 
 	if (*crypt == NULL && host_crypto) {
-		struct lib80211_crypt_data *new_crypt;
+		struct libipw_crypt_data *new_crypt;
 
 		/* take WEP into use */
-		new_crypt = kzalloc(sizeof(struct lib80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct libipw_crypt_data),
 				    GFP_KERNEL);
 		if (new_crypt == NULL)
 			return -ENOMEM;
-		new_crypt->ops = lib80211_get_crypto_ops("WEP");
+		new_crypt->ops = libipw_get_crypto_ops("WEP");
 		if (!new_crypt->ops) {
-			request_module("lib80211_crypt_wep");
-			new_crypt->ops = lib80211_get_crypto_ops("WEP");
+			request_module("libipw_crypt_wep");
+			new_crypt->ops = libipw_get_crypto_ops("WEP");
 		}
 
 		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
@@ -386,7 +383,7 @@ int libipw_wx_set_encode(struct libipw_device *ieee,
 			new_crypt = NULL;
 
 			printk(KERN_WARNING "%s: could not initialize WEP: "
-			       "load module lib80211_crypt_wep\n", dev->name);
+			       "load module libipw_crypt_wep\n", dev->name);
 			return -EOPNOTSUPP;
 		}
 		*crypt = new_crypt;
@@ -509,8 +506,8 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 	int i, idx, ret = 0;
 	int group_key = 0;
 	const char *alg, *module;
-	const struct lib80211_crypto_ops *ops;
-	struct lib80211_crypt_data **crypt;
+	const struct libipw_crypto_ops *ops;
+	struct libipw_crypt_data **crypt;
 
 	struct libipw_security sec = {
 		.flags = 0,
@@ -541,7 +538,7 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 	if ((encoding->flags & IW_ENCODE_DISABLED) ||
 	    ext->alg == IW_ENCODE_ALG_NONE) {
 		if (*crypt)
-			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
+			libipw_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 
 		for (i = 0; i < WEP_KEYS; i++)
 			if (ieee->crypt_info.crypt[i] != NULL)
@@ -567,15 +564,15 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 	switch (ext->alg) {
 	case IW_ENCODE_ALG_WEP:
 		alg = "WEP";
-		module = "lib80211_crypt_wep";
+		module = "libipw_crypt_wep";
 		break;
 	case IW_ENCODE_ALG_TKIP:
 		alg = "TKIP";
-		module = "lib80211_crypt_tkip";
+		module = "libipw_crypt_tkip";
 		break;
 	case IW_ENCODE_ALG_CCMP:
 		alg = "CCMP";
-		module = "lib80211_crypt_ccmp";
+		module = "libipw_crypt_ccmp";
 		break;
 	default:
 		LIBIPW_DEBUG_WX("%s: unknown crypto alg %d\n",
@@ -584,10 +581,10 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 		goto done;
 	}
 
-	ops = lib80211_get_crypto_ops(alg);
+	ops = libipw_get_crypto_ops(alg);
 	if (ops == NULL) {
 		request_module(module);
-		ops = lib80211_get_crypto_ops(alg);
+		ops = libipw_get_crypto_ops(alg);
 	}
 	if (ops == NULL) {
 		LIBIPW_DEBUG_WX("%s: unknown crypto alg %d\n",
@@ -597,9 +594,9 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 	}
 
 	if (*crypt == NULL || (*crypt)->ops != ops) {
-		struct lib80211_crypt_data *new_crypt;
+		struct libipw_crypt_data *new_crypt;
 
-		lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
+		libipw_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 
 		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
 		if (new_crypt == NULL) {
diff --git a/include/net/lib80211.h b/include/net/lib80211.h
deleted file mode 100644
index fd0f15d87d80..000000000000
--- a/include/net/lib80211.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * lib80211.h -- common bits for IEEE802.11 wireless drivers
- *
- * Copyright (c) 2008, John W. Linville <linville@tuxdriver.com>
- *
- * Some bits copied from old ieee80211 component, w/ original copyright
- * notices below:
- *
- * Original code based on Host AP (software wireless LAN access point) driver
- * for Intersil Prism2/2.5/3.
- *
- * Copyright (c) 2001-2002, SSH Communications Security Corp and Jouni Malinen
- * <j@w1.fi>
- * Copyright (c) 2002-2003, Jouni Malinen <j@w1.fi>
- *
- * Adaption to a generic IEEE 802.11 stack by James Ketrenos
- * <jketreno@linux.intel.com>
- *
- * Copyright (c) 2004, Intel Corporation
- *
- */
-
-#ifndef LIB80211_H
-#define LIB80211_H
-
-#include <linux/types.h>
-#include <linux/list.h>
-#include <linux/atomic.h>
-#include <linux/if.h>
-#include <linux/skbuff.h>
-#include <linux/ieee80211.h>
-#include <linux/timer.h>
-#include <linux/seq_file.h>
-
-#define NUM_WEP_KEYS	4
-
-enum {
-	IEEE80211_CRYPTO_TKIP_COUNTERMEASURES = (1 << 0),
-};
-
-struct module;
-
-struct lib80211_crypto_ops {
-	const char *name;
-	struct list_head list;
-
-	/* init new crypto context (e.g., allocate private data space,
-	 * select IV, etc.); returns NULL on failure or pointer to allocated
-	 * private data on success */
-	void *(*init) (int keyidx);
-
-	/* deinitialize crypto context and free allocated private data */
-	void (*deinit) (void *priv);
-
-	/* encrypt/decrypt return < 0 on error or >= 0 on success. The return
-	 * value from decrypt_mpdu is passed as the keyidx value for
-	 * decrypt_msdu. skb must have enough head and tail room for the
-	 * encryption; if not, error will be returned; these functions are
-	 * called for all MPDUs (i.e., fragments).
-	 */
-	int (*encrypt_mpdu) (struct sk_buff * skb, int hdr_len, void *priv);
-	int (*decrypt_mpdu) (struct sk_buff * skb, int hdr_len, void *priv);
-
-	/* These functions are called for full MSDUs, i.e. full frames.
-	 * These can be NULL if full MSDU operations are not needed. */
-	int (*encrypt_msdu) (struct sk_buff * skb, int hdr_len, void *priv);
-	int (*decrypt_msdu) (struct sk_buff * skb, int keyidx, int hdr_len,
-			     void *priv);
-
-	int (*set_key) (void *key, int len, u8 * seq, void *priv);
-	int (*get_key) (void *key, int len, u8 * seq, void *priv);
-
-	/* procfs handler for printing out key information and possible
-	 * statistics */
-	void (*print_stats) (struct seq_file *m, void *priv);
-
-	/* Crypto specific flag get/set for configuration settings */
-	unsigned long (*get_flags) (void *priv);
-	unsigned long (*set_flags) (unsigned long flags, void *priv);
-
-	/* maximum number of bytes added by encryption; encrypt buf is
-	 * allocated with extra_prefix_len bytes, copy of in_buf, and
-	 * extra_postfix_len; encrypt need not use all this space, but
-	 * the result must start at the beginning of the buffer and correct
-	 * length must be returned */
-	int extra_mpdu_prefix_len, extra_mpdu_postfix_len;
-	int extra_msdu_prefix_len, extra_msdu_postfix_len;
-
-	struct module *owner;
-};
-
-struct lib80211_crypt_data {
-	struct list_head list;	/* delayed deletion list */
-	const struct lib80211_crypto_ops *ops;
-	void *priv;
-	atomic_t refcnt;
-};
-
-struct lib80211_crypt_info {
-	char *name;
-	/* Most clients will already have a lock,
-	   so just point to that. */
-	spinlock_t *lock;
-
-	struct lib80211_crypt_data *crypt[NUM_WEP_KEYS];
-	int tx_keyidx;		/* default TX key index (crypt[tx_keyidx]) */
-	struct list_head crypt_deinit_list;
-	struct timer_list crypt_deinit_timer;
-	int crypt_quiesced;
-};
-
-int lib80211_crypt_info_init(struct lib80211_crypt_info *info, char *name,
-                                spinlock_t *lock);
-void lib80211_crypt_info_free(struct lib80211_crypt_info *info);
-int lib80211_register_crypto_ops(const struct lib80211_crypto_ops *ops);
-int lib80211_unregister_crypto_ops(const struct lib80211_crypto_ops *ops);
-const struct lib80211_crypto_ops *lib80211_get_crypto_ops(const char *name);
-void lib80211_crypt_delayed_deinit(struct lib80211_crypt_info *info,
-				    struct lib80211_crypt_data **crypt);
-
-#endif /* LIB80211_H */
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 1d49cc8b6da1..27f211bd9954 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CFG80211) += cfg80211.o
-obj-$(CONFIG_LIB80211) += lib80211.o
-obj-$(CONFIG_LIB80211_CRYPT_WEP) += lib80211_crypt_wep.o
-obj-$(CONFIG_LIB80211_CRYPT_CCMP) += lib80211_crypt_ccmp.o
-obj-$(CONFIG_LIB80211_CRYPT_TKIP) += lib80211_crypt_tkip.o
 obj-y += tests/
 
 obj-$(CONFIG_WEXT_CORE) += wext-core.o
diff --git a/net/wireless/lib80211.c b/net/wireless/lib80211.c
deleted file mode 100644
index 64c447040786..000000000000
--- a/net/wireless/lib80211.c
+++ /dev/null
@@ -1,257 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * lib80211 -- common bits for IEEE802.11 drivers
- *
- * Copyright(c) 2008 John W. Linville <linville@tuxdriver.com>
- *
- * Portions copied from old ieee80211 component, w/ original copyright
- * notices below:
- *
- * Host AP crypto routines
- *
- * Copyright (c) 2002-2003, Jouni Malinen <j@w1.fi>
- * Portions Copyright (C) 2004, Intel Corporation <jketreno@linux.intel.com>
- *
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/ctype.h>
-#include <linux/ieee80211.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-
-#include <net/lib80211.h>
-
-#define DRV_DESCRIPTION	"common routines for IEEE802.11 drivers"
-
-MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR("John W. Linville <linville@tuxdriver.com>");
-MODULE_LICENSE("GPL");
-
-struct lib80211_crypto_alg {
-	struct list_head list;
-	const struct lib80211_crypto_ops *ops;
-};
-
-static LIST_HEAD(lib80211_crypto_algs);
-static DEFINE_SPINLOCK(lib80211_crypto_lock);
-
-static void lib80211_crypt_deinit_entries(struct lib80211_crypt_info *info,
-					  int force);
-static void lib80211_crypt_quiescing(struct lib80211_crypt_info *info);
-static void lib80211_crypt_deinit_handler(struct timer_list *t);
-
-int lib80211_crypt_info_init(struct lib80211_crypt_info *info, char *name,
-				spinlock_t *lock)
-{
-	memset(info, 0, sizeof(*info));
-
-	info->name = name;
-	info->lock = lock;
-
-	INIT_LIST_HEAD(&info->crypt_deinit_list);
-	timer_setup(&info->crypt_deinit_timer, lib80211_crypt_deinit_handler,
-		    0);
-
-	return 0;
-}
-EXPORT_SYMBOL(lib80211_crypt_info_init);
-
-void lib80211_crypt_info_free(struct lib80211_crypt_info *info)
-{
-	int i;
-
-        lib80211_crypt_quiescing(info);
-        del_timer_sync(&info->crypt_deinit_timer);
-        lib80211_crypt_deinit_entries(info, 1);
-
-        for (i = 0; i < NUM_WEP_KEYS; i++) {
-                struct lib80211_crypt_data *crypt = info->crypt[i];
-                if (crypt) {
-                        if (crypt->ops) {
-                                crypt->ops->deinit(crypt->priv);
-                                module_put(crypt->ops->owner);
-                        }
-                        kfree(crypt);
-                        info->crypt[i] = NULL;
-                }
-        }
-}
-EXPORT_SYMBOL(lib80211_crypt_info_free);
-
-static void lib80211_crypt_deinit_entries(struct lib80211_crypt_info *info,
-					  int force)
-{
-	struct lib80211_crypt_data *entry, *next;
-	unsigned long flags;
-
-	spin_lock_irqsave(info->lock, flags);
-	list_for_each_entry_safe(entry, next, &info->crypt_deinit_list, list) {
-		if (atomic_read(&entry->refcnt) != 0 && !force)
-			continue;
-
-		list_del(&entry->list);
-
-		if (entry->ops) {
-			entry->ops->deinit(entry->priv);
-			module_put(entry->ops->owner);
-		}
-		kfree(entry);
-	}
-	spin_unlock_irqrestore(info->lock, flags);
-}
-
-/* After this, crypt_deinit_list won't accept new members */
-static void lib80211_crypt_quiescing(struct lib80211_crypt_info *info)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(info->lock, flags);
-	info->crypt_quiesced = 1;
-	spin_unlock_irqrestore(info->lock, flags);
-}
-
-static void lib80211_crypt_deinit_handler(struct timer_list *t)
-{
-	struct lib80211_crypt_info *info = from_timer(info, t,
-						      crypt_deinit_timer);
-	unsigned long flags;
-
-	lib80211_crypt_deinit_entries(info, 0);
-
-	spin_lock_irqsave(info->lock, flags);
-	if (!list_empty(&info->crypt_deinit_list) && !info->crypt_quiesced) {
-		printk(KERN_DEBUG "%s: entries remaining in delayed crypt "
-		       "deletion list\n", info->name);
-		info->crypt_deinit_timer.expires = jiffies + HZ;
-		add_timer(&info->crypt_deinit_timer);
-	}
-	spin_unlock_irqrestore(info->lock, flags);
-}
-
-void lib80211_crypt_delayed_deinit(struct lib80211_crypt_info *info,
-				    struct lib80211_crypt_data **crypt)
-{
-	struct lib80211_crypt_data *tmp;
-	unsigned long flags;
-
-	if (*crypt == NULL)
-		return;
-
-	tmp = *crypt;
-	*crypt = NULL;
-
-	/* must not run ops->deinit() while there may be pending encrypt or
-	 * decrypt operations. Use a list of delayed deinits to avoid needing
-	 * locking. */
-
-	spin_lock_irqsave(info->lock, flags);
-	if (!info->crypt_quiesced) {
-		list_add(&tmp->list, &info->crypt_deinit_list);
-		if (!timer_pending(&info->crypt_deinit_timer)) {
-			info->crypt_deinit_timer.expires = jiffies + HZ;
-			add_timer(&info->crypt_deinit_timer);
-		}
-	}
-	spin_unlock_irqrestore(info->lock, flags);
-}
-EXPORT_SYMBOL(lib80211_crypt_delayed_deinit);
-
-int lib80211_register_crypto_ops(const struct lib80211_crypto_ops *ops)
-{
-	unsigned long flags;
-	struct lib80211_crypto_alg *alg;
-
-	alg = kzalloc(sizeof(*alg), GFP_KERNEL);
-	if (alg == NULL)
-		return -ENOMEM;
-
-	alg->ops = ops;
-
-	spin_lock_irqsave(&lib80211_crypto_lock, flags);
-	list_add(&alg->list, &lib80211_crypto_algs);
-	spin_unlock_irqrestore(&lib80211_crypto_lock, flags);
-
-	printk(KERN_DEBUG "lib80211_crypt: registered algorithm '%s'\n",
-	       ops->name);
-
-	return 0;
-}
-EXPORT_SYMBOL(lib80211_register_crypto_ops);
-
-int lib80211_unregister_crypto_ops(const struct lib80211_crypto_ops *ops)
-{
-	struct lib80211_crypto_alg *alg;
-	unsigned long flags;
-
-	spin_lock_irqsave(&lib80211_crypto_lock, flags);
-	list_for_each_entry(alg, &lib80211_crypto_algs, list) {
-		if (alg->ops == ops)
-			goto found;
-	}
-	spin_unlock_irqrestore(&lib80211_crypto_lock, flags);
-	return -EINVAL;
-
-      found:
-	printk(KERN_DEBUG "lib80211_crypt: unregistered algorithm '%s'\n",
-	       ops->name);
-	list_del(&alg->list);
-	spin_unlock_irqrestore(&lib80211_crypto_lock, flags);
-	kfree(alg);
-	return 0;
-}
-EXPORT_SYMBOL(lib80211_unregister_crypto_ops);
-
-const struct lib80211_crypto_ops *lib80211_get_crypto_ops(const char *name)
-{
-	struct lib80211_crypto_alg *alg;
-	unsigned long flags;
-
-	spin_lock_irqsave(&lib80211_crypto_lock, flags);
-	list_for_each_entry(alg, &lib80211_crypto_algs, list) {
-		if (strcmp(alg->ops->name, name) == 0)
-			goto found;
-	}
-	spin_unlock_irqrestore(&lib80211_crypto_lock, flags);
-	return NULL;
-
-      found:
-	spin_unlock_irqrestore(&lib80211_crypto_lock, flags);
-	return alg->ops;
-}
-EXPORT_SYMBOL(lib80211_get_crypto_ops);
-
-static void *lib80211_crypt_null_init(int keyidx)
-{
-	return (void *)1;
-}
-
-static void lib80211_crypt_null_deinit(void *priv)
-{
-}
-
-static const struct lib80211_crypto_ops lib80211_crypt_null = {
-	.name = "NULL",
-	.init = lib80211_crypt_null_init,
-	.deinit = lib80211_crypt_null_deinit,
-	.owner = THIS_MODULE,
-};
-
-static int __init lib80211_init(void)
-{
-	pr_info(DRV_DESCRIPTION "\n");
-	return lib80211_register_crypto_ops(&lib80211_crypt_null);
-}
-
-static void __exit lib80211_exit(void)
-{
-	lib80211_unregister_crypto_ops(&lib80211_crypt_null);
-	BUG_ON(!list_empty(&lib80211_crypto_algs));
-}
-
-module_init(lib80211_init);
-module_exit(lib80211_exit);
-- 
2.46.2


