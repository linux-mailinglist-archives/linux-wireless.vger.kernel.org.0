Return-Path: <linux-wireless+bounces-33539-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EEFAriivGns1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33539-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:28:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 682912D4BDF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EFCD31A39D4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD02E62C6;
	Fri, 20 Mar 2026 01:25:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882E2DA76F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969912; cv=none; b=p7EU3kfUQyVn+74aK9/roIWt2YAhhjT7suIaqh7bNzryxsHpToCiUY8qJ3l3jdQEZmxw+0OPt5eg7OhAPiP0IX9ijk24kADv2ni76YP8ayUuyAXkgNeW2W7iH7FeylDcZNTU6xbM3/bmBooXQSbUCl0UO+ND/UlNDQthK1omCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969912; c=relaxed/simple;
	bh=JjE0637pcnwOXC0khbMoNdB4WUERbKw2hmEt/HWjgOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuVqbDyItMYmZEFjZHYIYZZQQ2l9opm4J2EPf4GWWhbrItDRqlTPIMH49jJ3GrIZBwe6KugLfRGC6LLoBhqTZdrqhQjEhx5vXNfYYoYTB6oTet86VdhZ0It3a1J/XOTjzJAge3sSHSmcZzZ3iYQLeLaW+V1ZHw+GVBJzLYyZn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1112554eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969908; x=1774574708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=suEW+QJFcSsgWhqrlb5+SoMaziekppWcaVGrKT6pk3Q=;
        b=a4TzyLRSimaxjDfLc/MpTlrZKJlBwKs9iX870A/q8mP0mDj/xIOCMgg6yt4cL7QOpk
         dZF7Upft1Km0HYtIUx6HRxj6E5kIcALIkopFnGszdPx0mSGGK3X7PWe1Cjq4T3ltbw+j
         4dHforGHVnfQPeLECLHaNpBkpGsLykoI0tg1J0rvtqT79fkVNJeHlhQ9Nw6kn6Xa4wJ/
         vikGHH4cVIL2RvXzjtEErBonS7YEv6T0mz+5iNAjUg57iIiet17aj5Yh/f7X27ddQTxg
         TMtgYj6jMz6OXQGXfeijbVrAHcTfrv85uAYHT3C+t+Xu8zuRZH3f95imkb4PN8NoyHSD
         YY7A==
X-Forwarded-Encrypted: i=1; AJvYcCW0kvJKZFuNIvK7sIknNBuxazJW81dURE3dzm+fMnIW8LG8bywd1rsN3KupMmpnDUaHNaydg+Fs5fQq1l0bZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDYSGc2jKc4Pd1DNjInS/fX6cFhFVmVjJX0YZD+aFR6z1csXb
	BURTFrg4l11YEZ2p3PJFy1rAli+Zi8NBeq65wN+YvJlUzgy1glkcW0w=
X-Gm-Gg: ATEYQzx2n4mAZSOnTtTtgRgrAVknCZcdTeRxSzC8x/ZI0glI2R+UBf0zpXrVWqpk/pO
	7TtQk1OOZRnBfUtXwU6v7pXlRX/GqpSPJEfDKkFbvjqok17E72D9aU4bWU2NB1dnku6pnRXZ6aq
	FEhARDY+h2jFUh87rhf4uFrK8q3ElbO2booxz4Dzl+DCWSZsjFUElwEWVTQzkjGJmzDjCcFskr1
	6NcMirI9yozfAOsYgPW6cf9qTakUurX/d3bkd30cVtEopNNVgEnbevScmQfwvvZsH0zv115qSZ2
	Z4X2n4LuxEByfdRKL1YKAc4Whb8W/5Y71Ah+MRQDVIpjZo2BXscYhvy0HYO1FFNXn9qXxvgBKvr
	y3+5HLz935YDCHjLobf8uFjDZJDASlUyDF9ai+esODDm1pnFn8NnO0h/EyGDUSAgRgP/mKhtRtd
	KFZ7ghbZFchKCYGCHDwSwIyRF7YoKuK/3fnwGSfK+BCM6tqOwUCzd1ZiWwbi0Cq6mCqMimXGmgc
	NFLG7Q8zYfBJHfRWw==
X-Received: by 2002:a05:7300:6428:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2c10987b1cbmr609228eec.14.1773969908079;
        Thu, 19 Mar 2026 18:25:08 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2e6c30sm1101353eec.25.2026.03.19.18.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 04/13] net: move promiscuity handling into dev_rx_mode_work
Date: Thu, 19 Mar 2026 18:24:52 -0700
Message-ID: <20260320012501.2033548-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33539-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.142];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,intel.com:email]
X-Rspamd-Queue-Id: 682912D4BDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move unicast promiscuity tracking into dev_rx_mode_work so it runs
under netdev_ops_lock instead of under the addr_lock spinlock. This
is required because __dev_set_promiscuity calls dev_change_rx_flags
and __dev_notify_flags, both of which may need to sleep.

Change ASSERT_RTNL() to netdev_ops_assert_locked() in
__dev_set_promiscuity, netif_set_allmulti and __dev_change_flags
since these are now called from the work queue under the ops lock.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |  4 ++
 net/core/dev.c                          | 79 +++++++++++++++++--------
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index dc83d78d3b27..5cdaa1a3dcc8 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -298,6 +298,10 @@ struct net_device synchronization rules
 	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
 	of the unicast and multicast address lists.
 
+ndo_change_rx_flags:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
 	(i.e. no ``rtnl_lock`` and no device instance lock). The rest of
diff --git a/net/core/dev.c b/net/core/dev.c
index fedc423306fc..fc5c9b14faa0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9574,7 +9574,7 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9610,16 +9610,8 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 
 		dev_change_rx_flags(dev, IFF_PROMISC);
 	}
-	if (notify) {
-		/* The ops lock is only required to ensure consistent locking
-		 * for `NETDEV_CHANGE` notifiers. This function is sometimes
-		 * called without the lock, even for devices that are ops
-		 * locked, such as in `dev_uc_sync_multiple` when using
-		 * bonding or teaming.
-		 */
-		netdev_ops_assert_locked(dev);
+	if (notify)
 		__dev_notify_flags(dev, old_flags, IFF_PROMISC, 0, NULL);
-	}
 	return 0;
 }
 
@@ -9641,7 +9633,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9671,12 +9663,36 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+/**
+ * dev_uc_promisc_update() - evaluate whether uc_promisc should be toggled.
+ * @dev: device
+ *
+ * Must be called under netif_addr_lock_bh.
+ * Return: +1 to enter promisc, -1 to leave, 0 for no change.
+ */
+static int dev_uc_promisc_update(struct net_device *dev)
+{
+	if (dev->priv_flags & IFF_UNICAST_FLT)
+		return 0;
+
+	if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
+		dev->uc_promisc = true;
+		return 1;
+	}
+	if (netdev_uc_empty(dev) && dev->uc_promisc) {
+		dev->uc_promisc = false;
+		return -1;
+	}
+	return 0;
+}
+
 static void dev_rx_mode_work(struct work_struct *work)
 {
 	struct net_device *dev = container_of(work, struct net_device,
 					      rx_mode_work);
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 	int err;
 
 	__hw_addr_init(&uc_snap);
@@ -9704,16 +9720,29 @@ static void dev_rx_mode_work(struct work_struct *work)
 		if (!err)
 			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
 						      dev->addr_len);
-		netif_addr_unlock_bh(dev);
 
 		if (err) {
 			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
 			__hw_addr_flush(&uc_snap);
 			__hw_addr_flush(&uc_ref);
 			__hw_addr_flush(&mc_snap);
+			netif_addr_unlock_bh(dev);
 			goto out;
 		}
 
+		promisc_inc = dev_uc_promisc_update(dev);
+
+		netif_addr_unlock_bh(dev);
+	} else {
+		netif_addr_lock_bh(dev);
+		promisc_inc = dev_uc_promisc_update(dev);
+		netif_addr_unlock_bh(dev);
+	}
+
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
+
+	if (ops->ndo_set_rx_mode_async) {
 		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
 
 		netif_addr_lock_bh(dev);
@@ -9722,6 +9751,10 @@ static void dev_rx_mode_work(struct work_struct *work)
 		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
 					 &mc_ref, dev->addr_len);
 		netif_addr_unlock_bh(dev);
+	} else if (ops->ndo_set_rx_mode) {
+		netif_addr_lock_bh(dev);
+		ops->ndo_set_rx_mode(dev);
+		netif_addr_unlock_bh(dev);
 	}
 
 out:
@@ -9740,28 +9773,22 @@ static void dev_rx_mode_work(struct work_struct *work)
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 
 	/* dev_open will call this function so the list will stay sane. */
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
 
-	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
-		/* Unicast addresses changes may only happen under the rtnl,
-		 * therefore calling __dev_set_promiscuity here is safe.
-		 */
-		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
-			__dev_set_promiscuity(dev, 1, false);
-			dev->uc_promisc = true;
-		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
-			__dev_set_promiscuity(dev, -1, false);
-			dev->uc_promisc = false;
-		}
-	}
+	/* Legacy path for non-ops locked HW devices. */
+
+	promisc_inc = dev_uc_promisc_update(dev);
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 
 	if (ops->ndo_set_rx_mode)
 		ops->ndo_set_rx_mode(dev);
@@ -9811,7 +9838,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	unsigned int old_flags = dev->flags;
 	int ret;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/*
 	 *	Set the flags on our device.
-- 
2.53.0


