Return-Path: <linux-wireless+bounces-28441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91809C2402E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D42C1A60411
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A025F32D0C8;
	Fri, 31 Oct 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Pbopf2ly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721032E6AD
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901458; cv=none; b=YVbhWwvrbwctuw2mnzdTljDRtpjlaAZDSMxovRBjGnKrMlGeO+odJ49Vq6/H2wTjnra2Rq3qjelnSQtteKCWh8B+hM5yoolHHmIYiINThjKYzNDn7ULzE9ZmAVaqDaZCzchuTnHQZ4YwmmPYfDPc3UNzNyaJ6z8JevdrLhv3yzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901458; c=relaxed/simple;
	bh=h4eFVa8MEXNhkj/yCrXwNyHWHO5ijhci1I/ZTflR/0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ov4w1IFubhApppM9ltgHl1gIZ8VY93R2mg7rCdEx12iM6qxmUW5pEU2VV6Hj0rj1OrSx8jdTutShFToTu3Wp81zshFFBRJ5VGqr2m1bvH5T31agDTeIdj2W024hhvkY8V44ZrtGIJrh5vppc/fMX7UmbHQLPKq0qYpWy+8feROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Pbopf2ly; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e2d5270b63811f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6ni5muYYom/Ex94vMzsMK+s1cAYBnZc+rA4GWiWaY1A=;
	b=Pbopf2lys+5cRHWFgnVIHRn3mvxQQK+HvCQq2fnxxGeax3rXa+TOt2X4ae1MiJb8Ek5a8mqmB+dlG2OAsEQC3HMcUpn35Xt/WmRKKy1W1Sa81fIcaKPM/xE8iMjDp/yyRot8GGvTHJ4Vu66n4AV//tySrC7EAmR8Uv22Z31LgZg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3583c5c3-8265-43dd-9073-7b7dabaaa5e9,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:455e7726-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e2d5270b63811f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 561016760; Fri, 31 Oct 2025 17:04:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 17:04:05 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 17:04:05 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 1/6] wifi: mt76: mt7925: refactor regulatory domain handling to regd.[ch]
Date: Fri, 31 Oct 2025 17:03:47 +0800
Message-ID: <20251031090352.1400079-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
References: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Move regd logic to regd.c and regd.h files

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 146 +----------------
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   1 +
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   2 -
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   1 +
 .../net/wireless/mediatek/mt76/mt7925/regd.c  | 149 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |  14 ++
 7 files changed, 167 insertions(+), 148 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
index 5d769de979c0..8f1078ce3231 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_MT7925_COMMON) += mt7925-common.o
 obj-$(CONFIG_MT7925E) += mt7925e.o
 obj-$(CONFIG_MT7925U) += mt7925u.o
 
-mt7925-common-y := mac.o mcu.o main.o init.o debugfs.o
+mt7925-common-y := mac.o mcu.o regd.o main.o init.o debugfs.o
 mt7925-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7925e-y := pci.o pci_mac.o pci_mcu.o
 mt7925u-y := usb.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index ea397ad48c30..741e38b29b77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -7,6 +7,7 @@
 #include <linux/thermal.h>
 #include <linux/firmware.h>
 #include "mt7925.h"
+#include "regd.h"
 #include "mac.h"
 #include "mcu.h"
 
@@ -60,151 +61,6 @@ static int mt7925_thermal_init(struct mt792x_phy *phy)
 	return PTR_ERR_OR_ZERO(hwmon);
 }
 
-void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
-{
-	struct mt792x_phy *phy = &dev->phy;
-	struct mt7925_clc_rule_v2 *rule;
-	struct mt7925_clc *clc;
-	bool old = dev->has_eht, new = true;
-	u32 mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2);
-	u8 *pos;
-
-	if (mtcl_conf != MT792X_ACPI_MTCL_INVALID &&
-	    (((mtcl_conf >> 4) & 0x3) == 0)) {
-		new = false;
-		goto out;
-	}
-
-	if (!phy->clc[MT792x_CLC_BE_CTRL])
-		goto out;
-
-	clc = (struct mt7925_clc *)phy->clc[MT792x_CLC_BE_CTRL];
-	pos = clc->data;
-
-	while (1) {
-		rule = (struct mt7925_clc_rule_v2 *)pos;
-
-		if (rule->alpha2[0] == alpha2[0] &&
-		    rule->alpha2[1] == alpha2[1]) {
-			new = false;
-			break;
-		}
-
-		/* Check the last one */
-		if (rule->flag & BIT(0))
-			break;
-
-		pos += sizeof(*rule);
-	}
-
-out:
-	if (old == new)
-		return;
-
-	dev->has_eht = new;
-	mt7925_set_stream_he_eht_caps(phy);
-}
-
-static void
-mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
-{
-#define IS_UNII_INVALID(idx, sfreq, efreq, cfreq) \
-	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
-#define MT7925_UNII_59G_IS_VALID	0x1
-#define MT7925_UNII_6G_IS_VALID	0x1e
-	struct ieee80211_supported_band *sband;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_channel *ch;
-	u32 mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, mdev->alpha2);
-	int i;
-
-	if (mtcl_conf != MT792X_ACPI_MTCL_INVALID) {
-		if ((mtcl_conf & 0x3) == 0)
-			dev->phy.clc_chan_conf &= ~MT7925_UNII_59G_IS_VALID;
-		if (((mtcl_conf >> 2) & 0x3) == 0)
-			dev->phy.clc_chan_conf &= ~MT7925_UNII_6G_IS_VALID;
-	}
-
-	sband = wiphy->bands[NL80211_BAND_5GHZ];
-	if (!sband)
-		return;
-
-	for (i = 0; i < sband->n_channels; i++) {
-		ch = &sband->channels[i];
-
-		/* UNII-4 */
-		if (IS_UNII_INVALID(0, 5845, 5925, ch->center_freq))
-			ch->flags |= IEEE80211_CHAN_DISABLED;
-	}
-
-	sband = wiphy->bands[NL80211_BAND_6GHZ];
-	if (!sband)
-		return;
-
-	for (i = 0; i < sband->n_channels; i++) {
-		ch = &sband->channels[i];
-
-		/* UNII-5/6/7/8 */
-		if (IS_UNII_INVALID(1, 5925, 6425, ch->center_freq) ||
-		    IS_UNII_INVALID(2, 6425, 6525, ch->center_freq) ||
-		    IS_UNII_INVALID(3, 6525, 6875, ch->center_freq) ||
-		    IS_UNII_INVALID(4, 6875, 7125, ch->center_freq))
-			ch->flags |= IEEE80211_CHAN_DISABLED;
-	}
-}
-
-void mt7925_regd_update(struct mt792x_dev *dev)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_hw *hw = mdev->hw;
-	struct wiphy *wiphy = hw->wiphy;
-
-	if (!dev->regd_change)
-		return;
-
-	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
-	mt7925_regd_channel_update(wiphy, dev);
-	mt7925_mcu_set_channel_domain(hw->priv);
-	mt7925_set_tx_sar_pwr(hw, NULL);
-	dev->regd_change = false;
-}
-EXPORT_SYMBOL_GPL(mt7925_regd_update);
-
-static void
-mt7925_regd_notifier(struct wiphy *wiphy,
-		     struct regulatory_request *req)
-{
-	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	/* allow world regdom at the first boot only */
-	if (!memcmp(req->alpha2, "00", 2) &&
-	    mdev->alpha2[0] && mdev->alpha2[1])
-		return;
-
-	/* do not need to update the same country twice */
-	if (!memcmp(req->alpha2, mdev->alpha2, 2) &&
-	    dev->country_ie_env == req->country_ie_env)
-		return;
-
-	memcpy(mdev->alpha2, req->alpha2, 2);
-	mdev->region = req->dfs_region;
-	dev->country_ie_env = req->country_ie_env;
-	dev->regd_change = true;
-
-	if (pm->suspended)
-		return;
-
-	dev->regd_in_progress = true;
-	mt792x_mutex_acquire(dev);
-	mt7925_regd_update(dev);
-	mt792x_mutex_release(dev);
-	dev->regd_in_progress = false;
-	wake_up(&dev->wait);
-}
-
 static void mt7925_mac_init_basic_rates(struct mt792x_dev *dev)
 {
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 23746627f68f..f9993f191448 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -8,6 +8,7 @@
 #include <linux/ctype.h>
 #include <net/ipv6.h>
 #include "mt7925.h"
+#include "regd.h"
 #include "mcu.h"
 #include "mac.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 6df39ce6eb4a..5030d7714bcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -263,8 +263,6 @@ int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd);
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
-void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
-void mt7925_regd_update(struct mt792x_dev *dev);
 int mt7925_mac_init(struct mt792x_dev *dev);
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 1de5e41a4061..c10f14386571 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -8,6 +8,7 @@
 #include "mt7925.h"
 #include "mac.h"
 #include "mcu.h"
+#include "regd.h"
 #include "../dma.h"
 
 static const struct pci_device_id mt7925_pci_device_table[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
new file mode 100644
index 000000000000..8d7ce274adcd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/* Copyright (C) 2025 MediaTek Inc. */
+
+#include "mt7925.h"
+#include "regd.h"
+#include "mcu.h"
+
+void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
+{
+	struct mt792x_phy *phy = &dev->phy;
+	struct mt7925_clc_rule_v2 *rule;
+	struct mt7925_clc *clc;
+	bool old = dev->has_eht, new = true;
+	u32 mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2);
+	u8 *pos;
+
+	if (mtcl_conf != MT792X_ACPI_MTCL_INVALID &&
+	    (((mtcl_conf >> 4) & 0x3) == 0)) {
+		new = false;
+		goto out;
+	}
+
+	if (!phy->clc[MT792x_CLC_BE_CTRL])
+		goto out;
+
+	clc = (struct mt7925_clc *)phy->clc[MT792x_CLC_BE_CTRL];
+	pos = clc->data;
+
+	while (1) {
+		rule = (struct mt7925_clc_rule_v2 *)pos;
+
+		if (rule->alpha2[0] == alpha2[0] &&
+		    rule->alpha2[1] == alpha2[1]) {
+			new = false;
+			break;
+		}
+
+		/* Check the last one */
+		if (rule->flag & BIT(0))
+			break;
+
+		pos += sizeof(*rule);
+	}
+
+out:
+	if (old == new)
+		return;
+
+	dev->has_eht = new;
+	mt7925_set_stream_he_eht_caps(phy);
+}
+
+static void
+mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
+{
+#define IS_UNII_INVALID(idx, sfreq, efreq, cfreq) \
+	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
+#define MT7925_UNII_59G_IS_VALID	0x1
+#define MT7925_UNII_6G_IS_VALID	0x1e
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_channel *ch;
+	u32 mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, mdev->alpha2);
+	int i;
+
+	if (mtcl_conf != MT792X_ACPI_MTCL_INVALID) {
+		if ((mtcl_conf & 0x3) == 0)
+			dev->phy.clc_chan_conf &= ~MT7925_UNII_59G_IS_VALID;
+		if (((mtcl_conf >> 2) & 0x3) == 0)
+			dev->phy.clc_chan_conf &= ~MT7925_UNII_6G_IS_VALID;
+	}
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		/* UNII-4 */
+		if (IS_UNII_INVALID(0, 5845, 5925, ch->center_freq))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		/* UNII-5/6/7/8 */
+		if (IS_UNII_INVALID(1, 5925, 6425, ch->center_freq) ||
+		    IS_UNII_INVALID(2, 6425, 6525, ch->center_freq) ||
+		    IS_UNII_INVALID(3, 6525, 6875, ch->center_freq) ||
+		    IS_UNII_INVALID(4, 6875, 7125, ch->center_freq))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+}
+
+void mt7925_regd_update(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_hw *hw = mdev->hw;
+	struct wiphy *wiphy = hw->wiphy;
+
+	if (!dev->regd_change)
+		return;
+
+	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	mt7925_regd_channel_update(wiphy, dev);
+	mt7925_mcu_set_channel_domain(hw->priv);
+	mt7925_set_tx_sar_pwr(hw, NULL);
+	dev->regd_change = false;
+}
+EXPORT_SYMBOL_GPL(mt7925_regd_update);
+
+void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	/* allow world regdom at the first boot only */
+	if (!memcmp(req->alpha2, "00", 2) &&
+	    mdev->alpha2[0] && mdev->alpha2[1])
+		return;
+
+	/* do not need to update the same country twice */
+	if (!memcmp(req->alpha2, mdev->alpha2, 2) &&
+	    dev->country_ie_env == req->country_ie_env)
+		return;
+
+	memcpy(mdev->alpha2, req->alpha2, 2);
+	mdev->region = req->dfs_region;
+	dev->country_ie_env = req->country_ie_env;
+	dev->regd_change = true;
+
+	if (pm->suspended)
+		return;
+
+	dev->regd_in_progress = true;
+	mt792x_mutex_acquire(dev);
+	mt7925_regd_update(dev);
+	mt792x_mutex_release(dev);
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
new file mode 100644
index 000000000000..a504e71472fd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/* Copyright (C) 2025 MediaTek Inc. */
+
+#ifndef __MT7925_REGD_H
+#define __MT7925_REGD_H
+
+#include "mt7925.h"
+
+void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
+void mt7925_regd_update(struct mt792x_dev *dev);
+void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req);
+
+#endif
+
-- 
2.34.1


