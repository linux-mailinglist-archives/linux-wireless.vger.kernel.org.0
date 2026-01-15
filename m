Return-Path: <linux-wireless+bounces-30852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06935D29319
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B90303AAFD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB303101B4;
	Thu, 15 Jan 2026 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="Ie1n+7Me"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail98.out.titan.email (mail98.out.titan.email [54.147.227.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA427221F0C
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.147.227.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518666; cv=none; b=SmBYVRzaDNex9RtrORFkPthW32hf+7+Fd/mC448j2o8TR9r2HYjrM4p6og34F/S9GlQZYeu1H0f6lTiGRqgp+OJQJhe3bAL5nuLfyiOEfU96Gh1oDAPCVS9OeJxhXctFwid/TiH2KEet1vkNeyoPiHBkISfJIBXN5lrQrcqCB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518666; c=relaxed/simple;
	bh=fBv2f12feifY8wF1hPxoNaVMJPUARJsaM+/TfG5oBOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoQ/+Dn1BJdV3j40Y5ZQrHSLsMpsYaMWHCQNUaqKc89PYuRVMsLT2uieMQYwYOSTXIMdw0dQQVow7hAjq2xB1fts0rfK65t1FKF7y3yialMR20UzSyeNDXa4gn1kTzk+qMul9hYi9b+fqiVPHLJe/si1LzCE0emIY9rP87DwanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=Ie1n+7Me; arc=none smtp.client-ip=54.147.227.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dsdql3Jk4z9rwC;
	Thu, 15 Jan 2026 23:05:23 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=p77J1AaXk9D4bj2Ip6l6ApJZep9hAAMxDc041t0rslU=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=from:to:cc:subject:date:references:message-id:in-reply-to:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1768518323; v=1;
	b=Ie1n+7MeY37eqqxEUi9fOrM9HeGshQ5M+xmWz+RvZHJZ+GhLT5IpMFPti1yIsK9YASv0ytUc
	p6vCogaTWqymJU2nr4pnMBD6k/6NzlgfImiAMypHPqA1FxhqbEaZT/Jb57saL+GJBzxoAtNP/9s
	yuP4YkzWzs3FCyFOlX9v95Ec=
Received: from fedora (unknown [94.156.148.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dsdqk1gnDz9rvf;
	Thu, 15 Jan 2026 23:05:22 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com
Cc: linux-wireless@vger.kernel.org,
	lucid_duck@justthetip.ca
Subject: [PATCH 1/3] wifi: mt76: update timer APIs for kernel 6.18
Date: Thu, 15 Jan 2026 15:02:50 -0800
Message-ID: <20260115230252.43391-2-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115230252.43391-1-lucid_duck@justthetip.ca>
References: <20260115230252.43391-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1768518323317111536.13754.5063913116587785920@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=696972b3
	a=rfUqlbiNABtMf1sfwYNRFA==:117 a=rfUqlbiNABtMf1sfwYNRFA==:17
	a=CEWIc4RMnpUA:10 a=ThxqNdz_AAAA:8 a=pGLkceISAAAA:8
	a=lsSCHvNKD0E-IetmaV0A:9 a=X5WbqfxFh8zCdCUNm0Nt:22

Kernel 6.18 introduced several timer API changes:
- hrtimer_init() replaced with hrtimer_setup()
- del_timer_sync() renamed to timer_delete_sync()
- from_timer() macro removed, use container_of() directly
- asm/unaligned.h moved to linux/unaligned.h

Update all mt76 timer usage to the new APIs for kernel 6.18+
compatibility.

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 mt76.h             | 1 +
 mt7615/main.c      | 6 +++---
 mt7615/pci_mac.c   | 4 ++--
 mt7615/usb.c       | 2 +-
 mt76x0/eeprom.c    | 2 +-
 mt76x02_eeprom.c   | 2 +-
 mt76x02_usb_core.c | 4 ++--
 mt76x2/eeprom.c    | 2 +-
 mt7925/main.c      | 4 ++--
 mt792x_core.c      | 6 +++---
 10 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/mt76.h b/mt76.h
index 646cc8e..4f48167 100644
--- a/mt76.h
+++ b/mt76.h
@@ -19,6 +19,7 @@
 #include "airoha_offload.h"
 #endif
 #include <linux/soc/mediatek/mtk_wed.h>
+#include <linux/version.h>
 #include <net/netlink.h>
 #include <net/mac80211.h>
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,6,0)
diff --git a/mt7615/main.c b/mt7615/main.c
index a18aa0d..2ac2ba8 100644
--- a/mt7615/main.c
+++ b/mt7615/main.c
@@ -97,7 +97,7 @@ static void mt7615_stop(struct ieee80211_hw *hw, bool suspend)
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
@@ -1046,7 +1046,7 @@ void mt7615_roc_work(struct work_struct *work)
 
 void mt7615_roc_timer(struct timer_list *timer)
 {
-	struct mt7615_phy *phy = from_timer(phy, timer, roc_timer);
+	struct mt7615_phy *phy = container_of(timer, struct mt7615_phy, roc_timer);
 
 	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
 }
@@ -1197,7 +1197,7 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return 0;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	mt7615_mutex_acquire(phy->dev);
diff --git a/mt7615/pci_mac.c b/mt7615/pci_mac.c
index d83d8ec..53cb1ee 100644
--- a/mt7615/pci_mac.c
+++ b/mt7615/pci_mac.c
@@ -220,12 +220,12 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	del_timer_sync(&dev->phy.roc_timer);
+	timer_delete_sync(&dev->phy.roc_timer);
 	cancel_work_sync(&dev->phy.roc_work);
 	if (phy2) {
 		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
-		del_timer_sync(&phy2->roc_timer);
+		timer_delete_sync(&phy2->roc_timer);
 		cancel_work_sync(&phy2->roc_work);
 	}
 
diff --git a/mt7615/usb.c b/mt7615/usb.c
index 7736ae3..d91feff 100644
--- a/mt7615/usb.c
+++ b/mt7615/usb.c
@@ -85,7 +85,7 @@ static void mt7663u_stop(struct ieee80211_hw *hw, bool suspend)
 	struct mt7615_dev *dev = hw->priv;
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
diff --git a/mt76x0/eeprom.c b/mt76x0/eeprom.c
index f6720a4..d4506b8 100644
--- a/mt76x0/eeprom.c
+++ b/mt76x0/eeprom.c
@@ -10,7 +10,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/etherdevice.h>
-#include <asm/unaligned.h>
+#include <linux/unaligned.h>
 #include "mt76x0.h"
 #include "eeprom.h"
 #include "../mt76x02_phy.h"
diff --git a/mt76x02_eeprom.c b/mt76x02_eeprom.c
index 2a15bd2..d16be0c 100644
--- a/mt76x02_eeprom.c
+++ b/mt76x02_eeprom.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
 
-#include <asm/unaligned.h>
+#include <linux/unaligned.h>
 
 #include "mt76x02_eeprom.h"
 
diff --git a/mt76x02_usb_core.c b/mt76x02_usb_core.c
index c94c2f6..4ca311d 100644
--- a/mt76x02_usb_core.c
+++ b/mt76x02_usb_core.c
@@ -264,8 +264,8 @@ void mt76x02u_init_beacon_config(struct mt76x02_dev *dev)
 	};
 	dev->beacon_ops = &beacon_ops;
 
-	hrtimer_init(&dev->pre_tbtt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dev->pre_tbtt_timer.function = mt76x02u_pre_tbtt_interrupt;
+	hrtimer_setup(&dev->pre_tbtt_timer, mt76x02u_pre_tbtt_interrupt,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	INIT_WORK(&dev->pre_tbtt_work, mt76x02u_pre_tbtt_work);
 
 	mt76x02_init_beacon_config(dev);
diff --git a/mt76x2/eeprom.c b/mt76x2/eeprom.c
index e1e317a..782813a 100644
--- a/mt76x2/eeprom.c
+++ b/mt76x2/eeprom.c
@@ -5,7 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <asm/unaligned.h>
+#include <linux/unaligned.h>
 #include "mt76x2.h"
 #include "eeprom.h"
 
diff --git a/mt7925/main.c b/mt7925/main.c
index 307850a..2d358a9 100644
--- a/mt7925/main.c
+++ b/mt7925/main.c
@@ -457,7 +457,7 @@ void mt7925_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
@@ -489,7 +489,7 @@ static int mt7925_abort_roc(struct mt792x_phy *phy,
 {
 	int err = 0;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	mt792x_mutex_acquire(phy->dev);
diff --git a/mt792x_core.c b/mt792x_core.c
index cc488ee..530e489 100644
--- a/mt792x_core.c
+++ b/mt792x_core.c
@@ -305,7 +305,7 @@ EXPORT_SYMBOL_GPL(mt792x_tx_worker);
 
 void mt792x_roc_timer(struct timer_list *timer)
 {
-	struct mt792x_phy *phy = from_timer(phy, timer, roc_timer);
+	struct mt792x_phy *phy = container_of(timer, struct mt792x_phy, roc_timer);
 
 	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
 }
@@ -313,7 +313,7 @@ EXPORT_SYMBOL_GPL(mt792x_roc_timer);
 
 void mt792x_csa_timer(struct timer_list *timer)
 {
-	struct mt792x_vif *mvif = from_timer(mvif, timer, csa_timer);
+	struct mt792x_vif *mvif = container_of(timer, struct mt792x_vif, csa_timer);
 
 	ieee80211_queue_work(mvif->phy->mt76->hw, &mvif->csa_work);
 }
@@ -362,7 +362,7 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 
 	if (vif->bss_conf.csa_active) {
-		del_timer_sync(&mvif->csa_timer);
+		timer_delete_sync(&mvif->csa_timer);
 		cancel_work_sync(&mvif->csa_work);
 	}
 }
-- 
2.52.0


