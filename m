Return-Path: <linux-wireless+bounces-32094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ3+NloEnGlG/AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:40:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA27172C4A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74CF2303B7E8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B70334B186;
	Mon, 23 Feb 2026 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e6xcxZdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABE34BA42
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832349; cv=none; b=Lew7JIh01U2z0Pl1wgBc7zAippU4yQIp4uEPTHTSzD/ZvI6wTtkaDxc5NbIHl5L8Fy7z1VXlKgAApXC9mK+Kaky5tg9m/qMHuqIgpoDHiN2Y8w/TqD9uXL6KgkHsK+9J6nUrNKKldVi4dZ4CeG0s8AlE7G4o+SxmqKpqiEwf6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832349; c=relaxed/simple;
	bh=XNzxgcanelKaNqpHwO8N3WmSMIOD6KhCeD7X9iyw7pM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PbhOOybZQVPCEEUJ5upeG6tpQNal5pRqeGClCz9GdyPFnhXFKLrgdNQxCu/+7tn5cHSl0eX2Yw9plTdzndTtHKamMB0qqXpIKZvkzNlLp3Vuzo8CK0tZWHj0lCZwv6cl2IAYJ3aIchVwjyWUPCx4e1bmdt6Sm55dHTVd2pZmoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e6xcxZdm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b6ff3bbc108a11f1bcd7499a721e883d-20260223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=I3x67XUCbPJu0WB69Kt63OSsCHHRMocHjCpJWMBc0Ho=;
	b=e6xcxZdmWWwgNjBjGB1N3qAyZNXPDDjbMGfK00RIwRoh+dgzpJOfKQ4CxxHJZoN36p0msER6c8QCpb5CW+jtarE0kloW7Uc7ECIHK4h2m01+fBwrtsgTd2KICoSISc5NMZgZzZetrR3GBFXCWIWWx5wLwg9S+Y/LSLPZPWKBSNA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:eb7ff230-651b-4f79-bdac-158ee9ca9dc0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:a1f9805b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6ff3bbc108a11f1bcd7499a721e883d-20260223
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 112013131; Mon, 23 Feb 2026 15:38:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Feb 2026 15:38:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 23 Feb 2026 15:38:57 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>
Subject: [PATCH 1/5] wifi: mt76: mt7921: refactor regulatory domain handling to regd.[ch]
Date: Mon, 23 Feb 2026 15:38:50 +0800
Message-ID: <20260223073854.2464232-1-jb.tsai@mediatek.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32094-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:mid,mediatek.com:dkim,mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FA27172C4A
X-Rspamd-Action: no action

Move regd logic to regd.c and regd.h files

Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  98 +----------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   1 +
 .../net/wireless/mediatek/mt76/mt7921/regd.c  | 104 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/regd.h  |  13 +++
 7 files changed, 121 insertions(+), 99 deletions(-)
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
index 29732315af1c..1fe2f2bc3881 100644
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
index 42b9514e04e7..00ca3d3f3ef0 100644
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
index ad92af98e314..5239ea970d24 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -246,7 +246,6 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
-void mt7921_regd_update(struct mt792x_dev *dev);
 int mt7921_mac_init(struct mt792x_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 65c7fe671137..a173a61f2b49 100644
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
index 000000000000..6e6c81189222
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2025 MediaTek Inc. */
+
+#include <linux/of_net.h>
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
index 000000000000..0ba6161e1919
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2025 MediaTek Inc. */
+
+#ifndef __MT7921_REGD_H
+#define __MT7921_REGD_H
+
+#include "mt7921.h"
+
+void mt7921_regd_update(struct mt792x_dev *dev);
+void mt7921_regd_notifier(struct wiphy *wiphy,
+			  struct regulatory_request *request);
+
+#endif
-- 
2.45.2


