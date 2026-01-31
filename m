Return-Path: <linux-wireless+bounces-31410-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIlCOlFQfWnORQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31410-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 01:44:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869EBFAE4
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 01:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB3453003836
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D1E30F80B;
	Sat, 31 Jan 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoiHGZOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE830C60B
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769820235; cv=none; b=gNggebOtDJA0Xu8YYWuYbsTdl6c6Lzbzy+i+yJzVHhCBj0tMftpuz9IU8WKS8uW5aGDf+e/4IaMP5INOkqr/LxvBAUj4Mf6QTicEm5wEWpXvWI/smnX64PmM3g5rJuLJYa2ffYe10TX9+9iDgectWsgIgqRALqkATyT2je1RVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769820235; c=relaxed/simple;
	bh=gAMxZn0Bbk69ZZJxMKMKvrwOH+mTYEZ1m8iOZgJYkZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyVVijQfxyqG6PirLY7SlSyQ4WFDjfRWNjZtLsV5539Sjdua08XSASUdsmnq/BbPsh8LYUbYUFYoHlY7tc3cRX2zyX9c6RNASqqyer46xKnvKz7IceXlT31FMd/wLvXdCFIAInwq1lmlA8Chn1z3JI+I1HKfKEMz8MeYMk8X1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoiHGZOq; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12336c0a8b6so3812821c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769820230; x=1770425030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz/w+ViHe1NFxGhmvKw2Td3oBT35x8hZuCkuGLcRPRE=;
        b=EoiHGZOq1n+YqkmJ8RdCd+vjNLjMRY8d7N0js7XEzTUkM/k4VsCUrOCG8r9Rtltflp
         SURYEBQwRWjFb/LLK3zls1RwRTQcw6yeyP82KeLblFalF8WOg1kOC++vEb62lgRoy1y3
         AhCZfU724LbU6Kw6WFzNfGik3fy/yXDXi4982mgcQ/5AvZFn0TfaDWIEM+zNdypUc1sS
         IxvURZ4X584Lima7TJXbyOmxXA2RHa77Pg4KBmwtN0lC6JBQzfzn2NX4azPIU1awHW/J
         VwXPcO0KL0i0aKGD8I4RkYUXCoxNjJ5GlQvsO6lNd7K4ZWivXKPKJrjy7dqF2f7P2inL
         zNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769820230; x=1770425030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz/w+ViHe1NFxGhmvKw2Td3oBT35x8hZuCkuGLcRPRE=;
        b=lNK4NEX66fZyy/8hOQ75AzZIT2T0yTQOq5O4/ZE1z0GxbEpDPc72/kaX6VGKM+F/hz
         WOHeeYN0+4FYtgNQtdS7KbuXUCeq3ou/51+Hq0+KMxqCLjDztvLmqFdIA4Gla4d95axO
         KwdZuDb4NfPf5cCPVRPOgQj1jEfTfUj8aK9vfv42lVOKejz+225i4Ed0mBG7FO0Bq2Hn
         qBRqsM6MpOGRGqBvhkRlQr96H3u73BrOun9H5vtzY/4CQrhMzoyO1JWbuVS4Fq0eupA1
         y399FsqyxlbFB8en2ojcHyJizPibN1v7+QGRuk6jpQv6B26s+0b/VKqNjGLbhCj6CXzh
         84Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWvDaU9YJ3KorQ4f7v1Xb7jDdXONUA+AaSz7JHv+cVf7OjAgJesFkveb6I/RrmzDfi4cd+MfbHND+mTUH24aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzczfXMo9JGEW2iEWsD4P4Qp54WVGKm0BD/kS3jsxUIdhDe04Ir
	6e/4wBqy1ayQEnc5U/pReS2oyNt3aj/6RFFZyyc8ANsr/u5yMp36E4ak
X-Gm-Gg: AZuq6aKmTlt3xIhvCM7VajRaZmDJOGRsRhepPN+NlRW0RBECurUCCdMI3udTF+1/im4
	LPn+u3HIFz90N3ANMqtV/4ZixgWjI0Uxe/W5T+gUIcuA57ZHREN5+Fqov9kwVJyV6GwONy58u/J
	r7WxCVZUKpPc68ZCvgtWfGCixMlbenVU4zic9PAY3C5o3yTVJRQxn14aVvIEj1cF/3taJ71oCws
	oBugjvKKDy8dsXwgDR8+ZaQn22kruOt5Hg3R/yJeGsQ49N6RVSJpznUIiTuww1NcArA6Dds6l7/
	CxbrDj1OseejhTBVYNC/wA7K/m/FG0UuTdb6cDVL+xmqTIoP7KTpA3K6B7mavcBjoiu6fnyBvpo
	j7Ye8ONI5U0+sWFoZvf2bNqYq6w8PG/EdfF/rIZM9pN37vcUEnvsseMc0X9YDxweONgmP74Brth
	qf5p9GsI6voqzfQbH/hg7aqQM3X0jPU3UfV8EyRTZgwQM2YPOTdJJ6r9Yq3w1NDgIXhWKcaGr+l
	B0BsGYsNccA+HoeH6+8XGfUT3VD1jMOpuhctv3X1SvmizPDn4b8iMhppRa4y4/n7qGoxr4OisAm
	e2Us
X-Received: by 2002:a05:7022:e25:b0:11b:9386:a3cf with SMTP id a92af1059eb24-125c10211dbmr2225916c88.48.1769820229772;
        Fri, 30 Jan 2026 16:43:49 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8f2sm14710638eec.7.2026.01.30.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:43:49 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Ping-Ke Shih <pkshih@realtek.com>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH net-next] net: remove unnecessary module_init/exit functions
Date: Fri, 30 Jan 2026 16:42:56 -0800
Message-ID: <20260131004327.18112-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,intel.com,toke.dk,realtek.com,posteo.net,hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-31410-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,che.eu:email,mellanox.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2869EBFAE4
X-Rspamd-Action: no action

Many network drivers have unnecessary empty module_init and module_exit
functions. Remove them (including some that just print a message). Note
that if a module_init function exists, a module_exit function must also
exist; otherwise, the module cannot be unloaded.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020.c                 | 16 ----------
 drivers/net/can/sja1000/sja1000.c             | 16 ----------
 drivers/net/ethernet/8390/8390.c              | 14 ---------
 drivers/net/ethernet/8390/8390p.c             | 11 -------
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 12 --------
 drivers/net/hamradio/hdlcdrv.c                | 20 -------------
 drivers/net/net_failover.c                    | 13 ---------
 drivers/net/wireless/ath/ath9k/common.c       | 12 --------
 .../realtek/rtlwifi/btcoexist/rtl_btc.c       | 13 ---------
 drivers/net/wireless/rsi/rsi_91x_main.c       | 29 -------------------
 10 files changed, 156 deletions(-)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index a0053e3992a3..b8526805ffac 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -401,19 +401,3 @@ EXPORT_SYMBOL(com20020_netdev_ops);
 
 MODULE_DESCRIPTION("ARCnet COM20020 chipset core driver");
 MODULE_LICENSE("GPL");
-
-#ifdef MODULE
-
-static int __init com20020_module_init(void)
-{
-	if (BUGLVL(D_NORMAL))
-		pr_info("%s\n", "COM20020 chipset support (by David Woodhouse et al.)");
-	return 0;
-}
-
-static void __exit com20020_module_exit(void)
-{
-}
-module_init(com20020_module_init);
-module_exit(com20020_module_exit);
-#endif				/* MODULE */
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index a8fa0d6516b9..7c5aa8d399d4 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -725,19 +725,3 @@ void unregister_sja1000dev(struct net_device *dev)
 	unregister_candev(dev);
 }
 EXPORT_SYMBOL_GPL(unregister_sja1000dev);
-
-static __init int sja1000_init(void)
-{
-	printk(KERN_INFO "%s CAN netdevice driver\n", DRV_NAME);
-
-	return 0;
-}
-
-module_init(sja1000_init);
-
-static __exit void sja1000_exit(void)
-{
-	printk(KERN_INFO "%s: driver removed\n", DRV_NAME);
-}
-
-module_exit(sja1000_exit);
diff --git a/drivers/net/ethernet/8390/8390.c b/drivers/net/ethernet/8390/8390.c
index c5636245f1ca..8e4354568f04 100644
--- a/drivers/net/ethernet/8390/8390.c
+++ b/drivers/net/ethernet/8390/8390.c
@@ -86,19 +86,5 @@ void NS8390_init(struct net_device *dev, int startp)
 }
 EXPORT_SYMBOL(NS8390_init);
 
-#if defined(MODULE)
-
-static int __init ns8390_module_init(void)
-{
-	return 0;
-}
-
-static void __exit ns8390_module_exit(void)
-{
-}
-
-module_init(ns8390_module_init);
-module_exit(ns8390_module_exit);
-#endif /* MODULE */
 MODULE_DESCRIPTION("National Semiconductor 8390 core driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/8390p.c b/drivers/net/ethernet/8390/8390p.c
index 6d429b11e9c6..a0bfc8e34f79 100644
--- a/drivers/net/ethernet/8390/8390p.c
+++ b/drivers/net/ethernet/8390/8390p.c
@@ -91,16 +91,5 @@ void NS8390p_init(struct net_device *dev, int startp)
 }
 EXPORT_SYMBOL(NS8390p_init);
 
-static int __init NS8390p_init_module(void)
-{
-	return 0;
-}
-
-static void __exit NS8390p_cleanup_module(void)
-{
-}
-
-module_init(NS8390p_init_module);
-module_exit(NS8390p_cleanup_module);
 MODULE_DESCRIPTION("National Semiconductor 8390 core for ISA driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 8769cba2c746..7da9ef254b72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2542,18 +2542,6 @@ void mlxsw_pci_driver_unregister(struct pci_driver *pci_driver)
 }
 EXPORT_SYMBOL(mlxsw_pci_driver_unregister);
 
-static int __init mlxsw_pci_module_init(void)
-{
-	return 0;
-}
-
-static void __exit mlxsw_pci_module_exit(void)
-{
-}
-
-module_init(mlxsw_pci_module_init);
-module_exit(mlxsw_pci_module_exit);
-
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Jiri Pirko <jiri@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox switch PCI interface driver");
diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
index 2263029d1a20..3b88e465d08f 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -742,26 +742,6 @@ EXPORT_SYMBOL(hdlcdrv_unregister);
 
 /* --------------------------------------------------------------------- */
 
-static int __init hdlcdrv_init_driver(void)
-{
-	printk(KERN_INFO "hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA\n");
-	printk(KERN_INFO "hdlcdrv: version 0.8\n");
-	return 0;
-}
-
-/* --------------------------------------------------------------------- */
-
-static void __exit hdlcdrv_cleanup_driver(void)
-{
-	printk(KERN_INFO "hdlcdrv: cleanup\n");
-}
-
-/* --------------------------------------------------------------------- */
-
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Packet Radio network interface HDLC encoder/decoder");
 MODULE_LICENSE("GPL");
-module_init(hdlcdrv_init_driver);
-module_exit(hdlcdrv_cleanup_driver);
-
-/* --------------------------------------------------------------------- */
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 5b50d9186f12..d0361aaf25ef 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -819,18 +819,5 @@ void net_failover_destroy(struct failover *failover)
 }
 EXPORT_SYMBOL_GPL(net_failover_destroy);
 
-static __init int
-net_failover_init(void)
-{
-	return 0;
-}
-module_init(net_failover_init);
-
-static __exit
-void net_failover_exit(void)
-{
-}
-module_exit(net_failover_exit);
-
 MODULE_DESCRIPTION("Failover driver for Paravirtual drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wireless/ath/ath9k/common.c b/drivers/net/wireless/ath/ath9k/common.c
index ffcf2276eb92..f55b3afb3777 100644
--- a/drivers/net/wireless/ath/ath9k/common.c
+++ b/drivers/net/wireless/ath/ath9k/common.c
@@ -403,15 +403,3 @@ void ath9k_cmn_init_crypto(struct ath_hw *ah)
 		ath_hw_keyreset(common, (u16) i);
 }
 EXPORT_SYMBOL(ath9k_cmn_init_crypto);
-
-static int __init ath9k_cmn_init(void)
-{
-	return 0;
-}
-module_init(ath9k_cmn_init);
-
-static void __exit ath9k_cmn_exit(void)
-{
-	return;
-}
-module_exit(ath9k_cmn_exit);
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
index 4641999f3fe9..e88d92d3ae7a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
@@ -519,16 +519,3 @@ MODULE_AUTHOR("Realtek WlanFAE	<wlanfae@realtek.com>");
 MODULE_AUTHOR("Larry Finger	<Larry.FInger@lwfinger.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 802.11n PCI wireless core");
-
-static int __init rtl_btcoexist_module_init(void)
-{
-	return 0;
-}
-
-static void __exit rtl_btcoexist_module_exit(void)
-{
-	return;
-}
-
-module_init(rtl_btcoexist_module_init);
-module_exit(rtl_btcoexist_module_exit);
diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 2112d8d277a9..a9bb37d5d581 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -425,35 +425,6 @@ void rsi_91x_deinit(struct rsi_hw *adapter)
 }
 EXPORT_SYMBOL_GPL(rsi_91x_deinit);
 
-/**
- * rsi_91x_hal_module_init() - This function is invoked when the module is
- *			       loaded into the kernel.
- *			       It registers the client driver.
- * @void: Void.
- *
- * Return: 0 on success, -1 on failure.
- */
-static int rsi_91x_hal_module_init(void)
-{
-	rsi_dbg(INIT_ZONE, "%s: Module init called\n", __func__);
-	return 0;
-}
-
-/**
- * rsi_91x_hal_module_exit() - This function is called at the time of
- *			       removing/unloading the module.
- *			       It unregisters the client driver.
- * @void: Void.
- *
- * Return: None.
- */
-static void rsi_91x_hal_module_exit(void)
-{
-	rsi_dbg(INIT_ZONE, "%s: Module exit called\n", __func__);
-}
-
-module_init(rsi_91x_hal_module_init);
-module_exit(rsi_91x_hal_module_exit);
 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("Station driver for RSI 91x devices");
 MODULE_VERSION("0.1");
-- 
2.43.0


