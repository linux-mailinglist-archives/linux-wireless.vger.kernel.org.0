Return-Path: <linux-wireless+bounces-32375-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLEwModzpmkuQAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32375-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 06:37:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD711E9494
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 06:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0297C3074E0E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F62D46B2;
	Tue,  3 Mar 2026 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kv5G/KZp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE212CDA5
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772516223; cv=none; b=GozCntf4LiqgexY0OS0l702KD4cvE9SNd5B/xvODH//RCX/A/gRTO0JEce20hZQJZDKQYMilR3k5833dsZLbW5Rvx7S6qZEC6Jft5dPLXEu2oior6g2LTuGA364a8x+xX6O17zFvSLLYNzGV9w5ksH3DucAQma4fDGMqOJ8tTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772516223; c=relaxed/simple;
	bh=CjcLAZ75dBudYbJQU2Wu+68A345ILAmE/l+JpaV9n60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cccpYsbvN3jKPlCkfuQ0VQBIWv8xtViOWqMdp/0HiLpELSLoZT51GGb8ytN44O+L1XwL1Vyq5JB6/yHOLf2YY14g/dj1VGeQHJDGf/pKWztiGe/OxYVhB+jEbBhOrOyWHF0Hxy5+LA/ze2UQLkmlFCpnxSahACeeYNTTHhO7rJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kv5G/KZp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f9c1b70216c211f1bcd7499a721e883d-20260303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oKPlvqaM8hImZCQ5w/scQ7fp97KZPGf8mv9ivOTsvk0=;
	b=kv5G/KZp3vsjE9+VEnc1WMeF1EXpL5Kwqtux1qHXFhyG5TwzKu10RWj8VUFG7JxTx7hjgG1LrMrg+i6aK1BSjXomG0hscgoqlsy7gecoKH5wWvXXAxF8JUe3iI+H1QJ5rW9+DMZAclpsSRWx0cx9OKGIcKmcuvAgDB9T7RVuwF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:355a0c26-beaf-4956-96a4-9cab19b0f930,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:c183cb5b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9c1b70216c211f1bcd7499a721e883d-20260303
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 872988736; Tue, 03 Mar 2026 13:36:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Mar 2026 13:36:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Mar 2026 13:36:48 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>
Subject: [PATCH v2 1/5] wifi: mt76: mt7921: refactor regulatory domain handling to regd.[ch]
Date: Tue, 3 Mar 2026 13:36:33 +0800
Message-ID: <20260303053637.465465-1-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Queue-Id: 6AD711E9494
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32375-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Move regd logic to regd.c and regd.h files

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
---
v2: Switch SPDX to BSD-3-Clause-Clear; remove unused <linux/of_net.h>;
decouple regd.h from mt7921.h with forward declarations
(no functional change).
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  98 +----------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   1 +
 .../net/wireless/mediatek/mt76/mt7921/regd.c  | 103 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/regd.h  |  15 +++
 7 files changed, 122 insertions(+), 99 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 2ad3c1cc3779..3ef7c9c45386 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 obj-$(CONFIG_MT7921S) += mt7921s.o
 obj-$(CONFIG_MT7921U) += mt7921u.o
 
-mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o
+mt7921-common-y := mac.o mcu.o regd.o main.o init.o debugfs.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o
 mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 8e7790702191..49be2fa4e3fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -9,6 +9,7 @@
 #include "mt7921.h"
 #include "../mt76_connac2_mac.h"
 #include "mcu.h"
+#include "regd.h"
 
 static ssize_t mt7921_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
@@ -60,103 +61,6 @@ static int mt7921_thermal_init(struct mt792x_phy *phy)
 	return PTR_ERR_OR_ZERO(hwmon);
 }
 
-static void
-mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
-{
-#define IS_UNII_INVALID(idx, sfreq, efreq) \
-	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
-	struct ieee80211_supported_band *sband;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct device_node *np, *band_np;
-	struct ieee80211_channel *ch;
-	int i, cfreq;
-
-	np = mt76_find_power_limits_node(mdev);
-
-	sband = wiphy->bands[NL80211_BAND_5GHZ];
-	band_np = np ? of_get_child_by_name(np, "txpower-5g") : NULL;
-	for (i = 0; i < sband->n_channels; i++) {
-		ch = &sband->channels[i];
-		cfreq = ch->center_freq;
-
-		if (np && (!band_np || !mt76_find_channel_node(band_np, ch))) {
-			ch->flags |= IEEE80211_CHAN_DISABLED;
-			continue;
-		}
-
-		/* UNII-4 */
-		if (IS_UNII_INVALID(0, 5845, 5925))
-			ch->flags |= IEEE80211_CHAN_DISABLED;
-	}
-
-	sband = wiphy->bands[NL80211_BAND_6GHZ];
-	if (!sband)
-		return;
-
-	band_np = np ? of_get_child_by_name(np, "txpower-6g") : NULL;
-	for (i = 0; i < sband->n_channels; i++) {
-		ch = &sband->channels[i];
-		cfreq = ch->center_freq;
-
-		if (np && (!band_np || !mt76_find_channel_node(band_np, ch))) {
-			ch->flags |= IEEE80211_CHAN_DISABLED;
-			continue;
-		}
-
-		/* UNII-5/6/7/8 */
-		if (IS_UNII_INVALID(1, 5925, 6425) ||
-		    IS_UNII_INVALID(2, 6425, 6525) ||
-		    IS_UNII_INVALID(3, 6525, 6875) ||
-		    IS_UNII_INVALID(4, 6875, 7125))
-			ch->flags |= IEEE80211_CHAN_DISABLED;
-	}
-}
-
-void mt7921_regd_update(struct mt792x_dev *dev)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_hw *hw = mdev->hw;
-	struct wiphy *wiphy = hw->wiphy;
-
-	mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
-	mt7921_regd_channel_update(wiphy, dev);
-	mt76_connac_mcu_set_channel_domain(hw->priv);
-	mt7921_set_tx_sar_pwr(hw, NULL);
-}
-EXPORT_SYMBOL_GPL(mt7921_regd_update);
-
-static void
-mt7921_regd_notifier(struct wiphy *wiphy,
-		     struct regulatory_request *request)
-{
-	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
-	dev->mt76.region = request->dfs_region;
-	dev->country_ie_env = request->country_ie_env;
-
-	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
-		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
-			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
-		else
-			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
-	}
-
-	if (pm->suspended)
-		return;
-
-	dev->regd_in_progress = true;
-
-	mt792x_mutex_acquire(dev);
-	mt7921_regd_update(dev);
-	mt792x_mutex_release(dev);
-
-	dev->regd_in_progress = false;
-	wake_up(&dev->wait);
-}
-
 int mt7921_mac_init(struct mt792x_dev *dev)
 {
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3d74fabe7408..d9925a528294 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <net/ipv6.h>
 #include "mt7921.h"
+#include "regd.h"
 #include "mcu.h"
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 64f60c4fc60c..fb8654b7c5e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -260,7 +260,6 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
-void mt7921_regd_update(struct mt792x_dev *dev);
 int mt7921_mac_init(struct mt792x_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 7a790ddf43bb..64340f9b7fa4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -12,6 +12,7 @@
 #include "../mt76_connac2_mac.h"
 #include "../dma.h"
 #include "mcu.h"
+#include "regd.h"
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
new file mode 100644
index 000000000000..51dbbadbc63a
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/* Copyright (C) 2025 MediaTek Inc. */
+
+#include <linux/of.h>
+#include "mt7921.h"
+#include "regd.h"
+#include "mcu.h"
+
+static void
+mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
+{
+#define IS_UNII_INVALID(idx, sfreq, efreq) \
+	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct device_node *np, *band_np;
+	struct ieee80211_channel *ch;
+	int i, cfreq;
+
+	np = mt76_find_power_limits_node(mdev);
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	band_np = np ? of_get_child_by_name(np, "txpower-5g") : NULL;
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+		cfreq = ch->center_freq;
+
+		if (np && (!band_np || !mt76_find_channel_node(band_np, ch))) {
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+			continue;
+		}
+
+		/* UNII-4 */
+		if (IS_UNII_INVALID(0, 5845, 5925))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	band_np = np ? of_get_child_by_name(np, "txpower-6g") : NULL;
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+		cfreq = ch->center_freq;
+
+		if (np && (!band_np || !mt76_find_channel_node(band_np, ch))) {
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+			continue;
+		}
+
+		/* UNII-5/6/7/8 */
+		if (IS_UNII_INVALID(1, 5925, 6425) ||
+		    IS_UNII_INVALID(2, 6425, 6525) ||
+		    IS_UNII_INVALID(3, 6525, 6875) ||
+		    IS_UNII_INVALID(4, 6875, 7125))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+}
+
+void mt7921_regd_update(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_hw *hw = mdev->hw;
+	struct wiphy *wiphy = hw->wiphy;
+
+	mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	mt7921_regd_channel_update(wiphy, dev);
+	mt76_connac_mcu_set_channel_domain(hw->priv);
+	mt7921_set_tx_sar_pwr(hw, NULL);
+}
+EXPORT_SYMBOL_GPL(mt7921_regd_update);
+
+void mt7921_regd_notifier(struct wiphy *wiphy,
+			  struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
+	dev->mt76.region = request->dfs_region;
+	dev->country_ie_env = request->country_ie_env;
+
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
+		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
+			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+		else
+			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
+	if (pm->suspended)
+		return;
+
+	dev->regd_in_progress = true;
+
+	mt792x_mutex_acquire(dev);
+	mt7921_regd_update(dev);
+	mt792x_mutex_release(dev);
+
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
new file mode 100644
index 000000000000..2907b78d375b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/* Copyright (C) 2025 MediaTek Inc. */
+
+#ifndef __MT7921_REGD_H
+#define __MT7921_REGD_H
+
+struct mt792x_dev;
+struct wiphy;
+struct regulatory_request;
+
+void mt7921_regd_update(struct mt792x_dev *dev);
+void mt7921_regd_notifier(struct wiphy *wiphy,
+			  struct regulatory_request *request);
+
+#endif
-- 
2.43.0


