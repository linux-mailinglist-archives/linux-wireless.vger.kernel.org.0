Return-Path: <linux-wireless+bounces-15605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E79D630D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEBF160FD3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1E1DF971;
	Fri, 22 Nov 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sjWmkvI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413A61DF74D
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296499; cv=none; b=T1w+0a6jDHdXSiQQS3v8ErKpOkkq5TxLoIbfW4vQe+rTSuJiuWba3mir6l1j9Djt2PyQueqahj9bHNjLz+GsqblyIFq7iw7R8NlfyKFzJQzWA3BGJuX8ZVN52hlXmID87LW3mrr2zBhvCM9NzXBJFyNIUYDc1u5i4YUOCQq9ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296499; c=relaxed/simple;
	bh=2sK9i2knehmjKRJPxucDZe89+AfDeKgd508Y7Rr9+DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0muj3uNVamfC5X9cNWWjo2wc12+R6ODNVo7CHA5NJlWHUIMI8J3JMtfRb6PSba2sepf09J8WRDzxnAEtUuZETLS3MSiVJam0uky7ygOGRphRJ/DREW0xLqaePL3UUJwaBRYCSUOgKxvQyoo2cjha/q/AkSdi/SkqaiOPNfgQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sjWmkvI+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fNvU2bajU6rYcrH0IMZ/hSrCRfM1CAKlWHAx/mNhG4M=; b=sjWmkvI+AMLPpzTJvU1oP+8s6x
	AXXEpTp9227zEL5oK4ZqUgqykhu/m6doIXLRCPy8zn7faUtba2kukQHDvLF1ImkquVqb6KbKJFDKv
	OMzSvkw485FExuP5cDRHFL2COwhqgkncuE3Oy3LZew9Xw8YdWHVY1sa/igMI8vbRZGwlftkwlaNEp
	9TVpKcZTqN82UBhMnAxUwUINfIs9w+OgjpDlfqNpxS79iXUIggu/86F2jdgnIDrDZ9lNJth99KgLG
	QIN7DlQJlzapVdbaTk3zox1ucMc01EUA5GMn+EYSedIWNDwMjvvmTwsiWrdd3Gk9PDtzsOCxfO01E
	hjVk8LiQ==;
Received: from 179-125-75-203-dinamico.pombonet.net.br ([179.125.75.203] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tEXS1-00B3IM-Gd; Fri, 22 Nov 2024 18:28:14 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 1/4] wifi: rtlwifi: remove unused check_buddy_priv
Date: Fri, 22 Nov 2024 14:27:15 -0300
Message-Id: <20241122172718.465539-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122172718.465539-1-cascardo@igalia.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2461c7d60f9f ("rtlwifi: Update header file") introduced a global
list of private data structures.

Later on, commit 26634c4b1868 ("rtlwifi Modify existing bits to match
vendor version 2013.02.07") started adding the private data to that list at
probe time and added a hook, check_buddy_priv to find the private data from
a similar device.

However, that function was never used.

Besides, though there is a lock for that list, it is never used. And when
the probe fails, the private data is never removed from the list. This
would cause a second probe to access freed memory.

Remove the unused hook, structures and members, which will prevent the
potential race condition on the list and its corruption during a second
probe when probe fails.

Fixes: 26634c4b1868 ("rtlwifi Modify existing bits to match vendor version 2013.02.07")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c |  7 ----
 drivers/net/wireless/realtek/rtlwifi/base.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c  | 44 ---------------------
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 12 ------
 4 files changed, 64 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index aab4605de9c4..fd28c7a722d8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -2696,9 +2696,6 @@ MODULE_AUTHOR("Larry Finger	<Larry.FInger@lwfinger.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 802.11n PCI wireless core");
 
-struct rtl_global_var rtl_global_var = {};
-EXPORT_SYMBOL_GPL(rtl_global_var);
-
 static int __init rtl_core_module_init(void)
 {
 	BUILD_BUG_ON(TX_PWR_BY_RATE_NUM_RATE < TX_PWR_BY_RATE_NUM_SECTION);
@@ -2712,10 +2709,6 @@ static int __init rtl_core_module_init(void)
 	/* add debugfs */
 	rtl_debugfs_add_topdir();
 
-	/* init some global vars */
-	INIT_LIST_HEAD(&rtl_global_var.glb_priv_list);
-	spin_lock_init(&rtl_global_var.glb_list_lock);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index f081a9a90563..f3a6a43a42ec 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -124,7 +124,6 @@ int rtl_send_smps_action(struct ieee80211_hw *hw,
 u8 *rtl_find_ie(u8 *data, unsigned int len, u8 ie);
 void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len);
 u8 rtl_tid_to_ac(u8 tid);
-extern struct rtl_global_var rtl_global_var;
 void rtl_phy_scan_operation_backup(struct ieee80211_hw *hw, u8 operation);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 40fc3c297a8a..4388066eb9e2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -295,46 +295,6 @@ static bool rtl_pci_get_amd_l1_patch(struct ieee80211_hw *hw)
 	return status;
 }
 
-static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
-				     struct rtl_priv **buddy_priv)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
-	struct rtl_priv *tpriv = NULL, *iter;
-	struct rtl_pci_priv *tpcipriv = NULL;
-
-	if (!list_empty(&rtlpriv->glb_var->glb_priv_list)) {
-		list_for_each_entry(iter, &rtlpriv->glb_var->glb_priv_list,
-				    list) {
-			tpcipriv = (struct rtl_pci_priv *)iter->priv;
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-				"pcipriv->ndis_adapter.funcnumber %x\n",
-				pcipriv->ndis_adapter.funcnumber);
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-				"tpcipriv->ndis_adapter.funcnumber %x\n",
-				tpcipriv->ndis_adapter.funcnumber);
-
-			if (pcipriv->ndis_adapter.busnumber ==
-			    tpcipriv->ndis_adapter.busnumber &&
-			    pcipriv->ndis_adapter.devnumber ==
-			    tpcipriv->ndis_adapter.devnumber &&
-			    pcipriv->ndis_adapter.funcnumber !=
-			    tpcipriv->ndis_adapter.funcnumber) {
-				tpriv = iter;
-				break;
-			}
-		}
-	}
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"find_buddy_priv %d\n", tpriv != NULL);
-
-	if (tpriv)
-		*buddy_priv = tpriv;
-
-	return tpriv != NULL;
-}
-
 static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 					struct ieee80211_hw *hw)
 {
@@ -2011,7 +1971,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
-	list_add_tail(&rtlpriv->list, &rtlpriv->glb_var->glb_priv_list);
 
 	return true;
 }
@@ -2158,7 +2117,6 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	rtlpriv->rtlhal.interface = INTF_PCI;
 	rtlpriv->cfg = (struct rtl_hal_cfg *)(id->driver_data);
 	rtlpriv->intf_ops = &rtl_pci_ops;
-	rtlpriv->glb_var = &rtl_global_var;
 	rtl_efuse_ops_init(hw);
 
 	/* MEM map */
@@ -2316,7 +2274,6 @@ void rtl_pci_disconnect(struct pci_dev *pdev)
 	if (rtlpci->using_msi)
 		pci_disable_msi(rtlpci->pdev);
 
-	list_del(&rtlpriv->list);
 	if (rtlpriv->io.pci_mem_start != 0) {
 		pci_iounmap(pdev, (void __iomem *)rtlpriv->io.pci_mem_start);
 		pci_release_regions(pdev);
@@ -2375,7 +2332,6 @@ EXPORT_SYMBOL(rtl_pci_resume);
 const struct rtl_intf_ops rtl_pci_ops = {
 	.adapter_start = rtl_pci_start,
 	.adapter_stop = rtl_pci_stop,
-	.check_buddy_priv = rtl_pci_check_buddy_priv,
 	.adapter_tx = rtl_pci_tx,
 	.flush = rtl_pci_flush,
 	.reset_trx_ring = rtl_pci_reset_trx_ring,
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index ae6e351bc83c..f1830ddcdd8c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2270,8 +2270,6 @@ struct rtl_intf_ops {
 	/*com */
 	int (*adapter_start)(struct ieee80211_hw *hw);
 	void (*adapter_stop)(struct ieee80211_hw *hw);
-	bool (*check_buddy_priv)(struct ieee80211_hw *hw,
-				 struct rtl_priv **buddy_priv);
 
 	int (*adapter_tx)(struct ieee80211_hw *hw,
 			  struct ieee80211_sta *sta,
@@ -2514,14 +2512,6 @@ struct dig_t {
 	u32 rssi_max;
 };
 
-struct rtl_global_var {
-	/* from this list we can get
-	 * other adapter's rtl_priv
-	 */
-	struct list_head glb_priv_list;
-	spinlock_t glb_list_lock;
-};
-
 #define IN_4WAY_TIMEOUT_TIME	(30 * MSEC_PER_SEC)	/* 30 seconds */
 
 struct rtl_btc_info {
@@ -2667,9 +2657,7 @@ struct rtl_scan_list {
 struct rtl_priv {
 	struct ieee80211_hw *hw;
 	struct completion firmware_loading_complete;
-	struct list_head list;
 	struct rtl_priv *buddy_priv;
-	struct rtl_global_var *glb_var;
 	struct rtl_dmsp_ctl dmsp_ctl;
 	struct rtl_locks locks;
 	struct rtl_works works;
-- 
2.34.1


