Return-Path: <linux-wireless+bounces-27675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02836BA34AC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 12:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F31C04606
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A02BE7A6;
	Fri, 26 Sep 2025 10:06:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4B2C033C;
	Fri, 26 Sep 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881161; cv=none; b=Mp24v4MruGyHQHTukC30GmYcoOZkZ/0/LL6Gid4JHHO6mwJfWrPL+c55/NUgxLKchdPtTVd2tgw3b5MradTXj7Zmr0/tRZ1cxoTbZzQojFt4O4MdfP+a4yIplBsahcwtsOHkyQAq2+gA/Jseoz/rmo6yBCjmyrdR/r7DubKXLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881161; c=relaxed/simple;
	bh=lsWkIc9G+VcRAJeYEpxxI8uJ4xCk02Vmb1N46e4BngI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbNyxPv1mw3DCq3PXQowlFqOkjRkgS+ji2+9WXuXm9Mr1CnhS55xfp38eqSnfkwAEcGLNsSDXzSxerLumtNnCygNUJ5jUI5J69VQaBGIDOGLR1X4rUjQdiIXUI9q/Vn1CPy/b4fu2Khre0EGlQ0lAWGyr4LmVB7EHb2Oi6IfV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300C597166BE00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:9716:6be0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id EBA41FA12C;
	Fri, 26 Sep 2025 12:05:54 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Fri, 26 Sep 2025 12:04:54 +0200
Subject: [PATCH mt76 v2 3/3] wifi: mt76: mt7915: add bf backoff limit table
 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-backoff-table-support-v2-3-16d3726646c4@simonwunderlich.de>
References: <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
In-Reply-To: <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org, 
 "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22026;
 i=se@simonwunderlich.de; h=from:subject:message-id;
 bh=llxq0tQxVJCcXzp2DtT7cDJvAXox0Qy6OwbSEFDBH3o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBnXUis0gwKjlruvNNLqF0mZpdThx5qYsUdUfXP6HYsFF
 7vKks53lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbyyZ7hr1R83OnCuUu6v+S1
 /95cZ3l7/lmX9zsPe6pFHjDh8UtramD4ZyYVuTUkdkbOjFuc4p6BX5VmJy5u/i0oJcMSLDHV8vh
 eBgA=
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

From: Shayne Chen <shayne.chen@mediatek.com>

The commit 22b980badc0f ("mt76: add functions for parsing rate power limits
from DT") introduced generic support for rates limits in the devicetree.
But the mt7915 supports beamforming and has another table for configuring
the backoff limits. These can be configured in the DT with the paths-*
properties. The path-*-bf are the ones relevant for beamforming and the
ones without -bf suffix for "traditional" path backoff.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c       |   4 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |  38 ++++-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   8 +
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |  74 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   7 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 182 ++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   6 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   9 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |   2 +-
 10 files changed, 277 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index b6a2746c187d0272d7e97f7647e8bd0f2ff5db30..bee1177594d325f1da3d109444c91d11265f4e75 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -93,9 +93,9 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 {
 	int i;
 
-	seq_printf(file, "%10s:", str);
+	seq_printf(file, "%16s:", str);
 	for (i = 0; i < len; i++)
-		seq_printf(file, " %2d", val[i]);
+		seq_printf(file, " %4d", val[i]);
 	seq_puts(file, "\n");
 }
 EXPORT_SYMBOL_GPL(mt76_seq_puts_array);
diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 6ce8e4af18fe53c10a0cb7290bf65962ce9cdde4..cbda19a868826bf92cf4afb0504bd6636e9bd7fb 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -324,9 +324,10 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
 static void
 mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 			     const s8 *data, size_t len, s8 target_power,
-			     s8 nss_delta, s8 *max_power)
+			     s8 nss_delta)
 {
 	int i, cur;
+	s8 max_power = -128;
 
 	if (!data)
 		return;
@@ -337,7 +338,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 			break;
 
 		mt76_apply_array_limit(pwr + pwr_len * i, pwr_len, data + 1,
-				       target_power, nss_delta, max_power);
+				       target_power, nss_delta, &max_power);
 		if (--cur > 0)
 			continue;
 
@@ -364,12 +365,16 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	char band;
 	size_t len;
 	s8 max_power = 0;
+	s8 max_power_backoff = -127;
 	s8 txs_delta;
+	int n_chains = hweight16(phy->chainmask);
+	s8 target_power_combine = target_power + mt76_tx_power_path_delta(n_chains);
 
 	if (!mcs_rates)
 		mcs_rates = 10;
 
-	memset(dest, target_power, sizeof(*dest));
+	memset(dest, target_power, sizeof(*dest) - sizeof(dest->path));
+	memset(&dest->path, 0, sizeof(dest->path));
 
 	if (!IS_ENABLED(CONFIG_OF))
 		return target_power;
@@ -415,12 +420,35 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	val = mt76_get_of_array_s8(np, "rates-mcs", &len, mcs_rates + 1);
 	mt76_apply_multi_array_limit(dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
 				     ARRAY_SIZE(dest->mcs), val, len,
-				     target_power, txs_delta, &max_power);
+				     target_power, txs_delta);
 
 	val = mt76_get_of_array_s8(np, "rates-ru", &len, ru_rates + 1);
 	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
 				     ARRAY_SIZE(dest->ru), val, len,
-				     target_power, txs_delta, &max_power);
+				     target_power, txs_delta);
+
+	max_power_backoff = max_power;
+	val = mt76_get_of_array_s8(np, "paths-cck", &len, ARRAY_SIZE(dest->path.cck));
+	mt76_apply_array_limit(dest->path.cck, ARRAY_SIZE(dest->path.cck), val,
+			       target_power_combine, txs_delta, &max_power_backoff);
+
+	val = mt76_get_of_array_s8(np, "paths-ofdm", &len, ARRAY_SIZE(dest->path.ofdm));
+	mt76_apply_array_limit(dest->path.ofdm, ARRAY_SIZE(dest->path.ofdm), val,
+			       target_power_combine, txs_delta, &max_power_backoff);
+
+	val = mt76_get_of_array_s8(np, "paths-ofdm-bf", &len, ARRAY_SIZE(dest->path.ofdm_bf));
+	mt76_apply_array_limit(dest->path.ofdm_bf, ARRAY_SIZE(dest->path.ofdm_bf), val,
+			       target_power_combine, txs_delta, &max_power_backoff);
+
+	val = mt76_get_of_array_s8(np, "paths-ru", &len, ARRAY_SIZE(dest->path.ru[0]) + 1);
+	mt76_apply_multi_array_limit(dest->path.ru[0], ARRAY_SIZE(dest->path.ru[0]),
+				     ARRAY_SIZE(dest->path.ru), val, len,
+				     target_power_combine, txs_delta);
+
+	val = mt76_get_of_array_s8(np, "paths-ru-bf", &len, ARRAY_SIZE(dest->path.ru_bf[0]) + 1);
+	mt76_apply_multi_array_limit(dest->path.ru_bf[0], ARRAY_SIZE(dest->path.ru_bf[0]),
+				     ARRAY_SIZE(dest->path.ru_bf), val, len,
+				     target_power_combine, txs_delta);
 
 	return max_power;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e0d50b58cd012910b697102bd50bb855966876f9..86b812f68c970c453cd7b31d690f1761ebbea5f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1113,6 +1113,14 @@ struct mt76_power_limits {
 	s8 mcs[4][10];
 	s8 ru[7][12];
 	s8 eht[16][16];
+
+	struct {
+		s8 cck[4];
+		s8 ofdm[4];
+		s8 ofdm_bf[4];
+		s8 ru[7][10];
+		s8 ru_bf[7][10];
+	} path;
 };
 
 struct mt76_ethtool_worker_info {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index b287b7d9394e20496d7e5628c5984776100dc9d7..6ff0d262c28ac691992585cff1bbc4038e900b36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1008,7 +1008,7 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr));
+	ret = mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr), TX_POWER_INFO_RATE);
 	if (ret)
 		goto out;
 
@@ -1118,7 +1118,7 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 
 	mutex_lock(&dev->mt76.mutex);
 	ret = mt7915_mcu_get_txpower_sku(phy, req.txpower_sku,
-					 sizeof(req.txpower_sku));
+					 sizeof(req.txpower_sku), TX_POWER_INFO_RATE);
 	if (ret)
 		goto out;
 
@@ -1160,7 +1160,7 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 	return ret ? ret : count;
 }
 
-static const struct file_operations mt7915_rate_txpower_fops = {
+static const struct file_operations mt7915_txpower_fops = {
 	.write = mt7915_rate_txpower_set,
 	.read = mt7915_rate_txpower_get,
 	.open = simple_open,
@@ -1168,6 +1168,70 @@ static const struct file_operations mt7915_rate_txpower_fops = {
 	.llseek = default_llseek,
 };
 
+static int
+mt7915_path_txpower_show(struct seq_file *file)
+{
+	struct mt7915_phy *phy = file->private;
+	s8 txpower[MT7915_SKU_PATH_NUM], *buf = txpower;
+	int ret;
+
+#define PATH_POWER_SHOW(_name, _len, _skip) do {			\
+		size_t __len = (_len);					\
+		if (_skip) {						\
+			buf -= 1;					\
+			*buf = 0;					\
+		}							\
+		mt76_seq_puts_array(file, _name, buf, __len);		\
+		buf += __len;						\
+	} while (0)
+
+	seq_printf(file, "\n%*c", 18, ' ');
+	seq_puts(file, "1T1S/2T1S/3T1S/4T1S/2T2S/3T2S/4T2S/3T3S/4T3S/4T4S\n");
+	ret = mt7915_mcu_get_txpower_sku(phy, txpower, sizeof(txpower),
+					 TX_POWER_INFO_PATH);
+	if (ret)
+		return ret;
+
+	PATH_POWER_SHOW("CCK", 4, 0);
+	PATH_POWER_SHOW("OFDM", 4, 0);
+	PATH_POWER_SHOW("BF-OFDM", 4, 1);
+
+	PATH_POWER_SHOW("HT/VHT20", 10, 0);
+	PATH_POWER_SHOW("BF-HT/VHT20", 10, 1);
+	PATH_POWER_SHOW("HT/VHT40", 10, 0);
+	PATH_POWER_SHOW("BF-HT/VHT40", 10, 1);
+
+	PATH_POWER_SHOW("BW20/RU242", 10, 0);
+	PATH_POWER_SHOW("BF-BW20/RU242", 10, 1);
+	PATH_POWER_SHOW("BW40/RU484", 10, 0);
+	PATH_POWER_SHOW("BF-BW40/RU484", 10, 1);
+	PATH_POWER_SHOW("BW80/RU996", 10, 0);
+	PATH_POWER_SHOW("BF-BW80/RU996", 10, 1);
+	PATH_POWER_SHOW("BW160/RU2x996", 10, 0);
+	PATH_POWER_SHOW("BF-BW160/RU2x996", 10, 1);
+	PATH_POWER_SHOW("RU26", 10, 0);
+	PATH_POWER_SHOW("BF-RU26", 10, 0);
+	PATH_POWER_SHOW("RU52", 10, 0);
+	PATH_POWER_SHOW("BF-RU52", 10, 0);
+	PATH_POWER_SHOW("RU106", 10, 0);
+	PATH_POWER_SHOW("BF-RU106", 10, 0);
+#undef PATH_POWER_SHOW
+
+	return 0;
+}
+
+static int
+mt7915_txpower_path_show(struct seq_file *file, void *data)
+{
+	struct mt7915_phy *phy = file->private;
+
+	seq_printf(file, "\nBand %d\n", phy != &phy->dev->phy);
+
+	return mt7915_path_txpower_show(file);
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7915_txpower_path);
+
 static int
 mt7915_twt_stats(struct seq_file *s, void *data)
 {
@@ -1254,7 +1318,9 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_file("txpower_sku", 0400, dir, phy,
-			    &mt7915_rate_txpower_fops);
+			    &mt7915_txpower_fops);
+	debugfs_create_file("txpower_path", 0400, dir, phy,
+			    &mt7915_txpower_path_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7915_twt_stats);
 	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5ea8b46e092ef38bd23d0cbbd1cc579ea8089682..1ac7ee2922b0d8656137724185af572997b9ffec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -289,6 +289,8 @@ static void __mt7915_init_txpower(struct mt7915_phy *phy,
 	int pwr_delta = mt7915_eeprom_get_power_delta(dev, sband->band);
 	struct mt76_power_limits limits;
 
+	phy->sku_limit_en = true;
+	phy->sku_path_en = true;
 	for (i = 0; i < sband->n_channels; i++) {
 		struct ieee80211_channel *chan = &sband->channels[i];
 		u32 target_power = 0;
@@ -305,6 +307,11 @@ static void __mt7915_init_txpower(struct mt7915_phy *phy,
 		target_power = mt76_get_rate_power_limits(phy->mt76, chan,
 							  &limits,
 							  target_power);
+
+		/* MT7915N can not enable Backoff table without setting value in dts */
+		if (!limits.path.ofdm[0])
+			phy->sku_path_en = false;
+
 		target_power += path_delta;
 		target_power = DIV_ROUND_UP(target_power, 2);
 		chan->max_power = min_t(int, chan->max_reg_power,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fe0639c14bf9bc6ec934325bd4afa263eb106dcb..fa135447a2632305cf9e3c38c5a3c2bb14efc4ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -73,7 +73,7 @@ int mt7915_run(struct ieee80211_hw *hw)
 	if (ret)
 		goto out;
 
-	ret = mt7915_mcu_set_sku_en(phy, true);
+	ret = mt7915_mcu_set_sku_en(phy);
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c1fdd3c4f1ba6eb51c2be1794a2628d38f5a44ad..673338d508a88d542539128d72a155326af1e56a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3336,7 +3336,8 @@ int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
 	int ret;
 	s8 txpower_sku[MT7915_SKU_RATE_NUM];
 
-	ret = mt7915_mcu_get_txpower_sku(phy, txpower_sku, sizeof(txpower_sku));
+	ret = mt7915_mcu_get_txpower_sku(phy, txpower_sku, sizeof(txpower_sku),
+					 TX_POWER_INFO_RATE);
 	if (ret)
 		return ret;
 
@@ -3376,51 +3377,136 @@ int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
 				 sizeof(req), true);
 }
 
+static void
+mt7915_update_txpower(struct mt7915_phy *phy, int tx_power)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_channel *chan = mphy->main_chandef.chan;
+	int chain_idx, val, e2p_power_limit = 0;
+
+	if (!chan) {
+		mphy->txpower_cur = tx_power;
+		return;
+	}
+
+	for (chain_idx = 0; chain_idx < hweight16(mphy->chainmask); chain_idx++) {
+		val = mt7915_eeprom_get_target_power(phy->dev, chan, chain_idx);
+		val += mt7915_eeprom_get_power_delta(phy->dev, chan->band);
+
+		e2p_power_limit = max_t(int, e2p_power_limit, val);
+	}
+
+	if (phy->sku_limit_en)
+		mphy->txpower_cur = min_t(int, e2p_power_limit, tx_power);
+	else
+		mphy->txpower_cur = e2p_power_limit;
+}
+
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 {
+#define TX_POWER_LIMIT_TABLE_RATE	0
+#define TX_POWER_LIMIT_TABLE_PATH	1
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
-	struct mt7915_mcu_txpower_sku req = {
+	struct mt7915_sku_val {
+		u8 format_id;
+		u8 limit_type;
+		u8 band_idx;
+	} __packed hdr = {
 		.format_id = TX_POWER_LIMIT_TABLE,
+		.limit_type = TX_POWER_LIMIT_TABLE_RATE,
 		.band_idx = phy->mt76->band_idx,
 	};
-	struct mt76_power_limits limits_array;
-	s8 *la = (s8 *)&limits_array;
-	int i, idx;
-	int tx_power;
+	int i, ret, tx_power;
+	const u8 *len = mt7915_sku_group_len;
+	struct mt76_power_limits la = {};
+	struct sk_buff *skb;
 
 	tx_power = mt76_get_power_bound(mphy, hw->conf.power_level);
-	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
-					      &limits_array, tx_power);
-	mphy->txpower_cur = tx_power;
-
-	for (i = 0, idx = 0; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
-		u8 mcs_num, len = mt7915_sku_group_len[i];
-		int j;
-
-		if (i >= SKU_HT_BW20 && i <= SKU_VHT_BW160) {
-			mcs_num = 10;
-
-			if (i == SKU_HT_BW20 || i == SKU_VHT_BW20)
-				la = (s8 *)&limits_array + 12;
-		} else {
-			mcs_num = len;
-		}
-
-		for (j = 0; j < min_t(u8, mcs_num, len); j++)
-			req.txpower_sku[idx + j] = la[j];
-
-		la += mcs_num;
-		idx += len;
+	if (phy->sku_limit_en) {
+		tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+						      &la, tx_power);
+		mt7915_update_txpower(phy, tx_power);
+	} else {
+		mt7915_update_txpower(phy, tx_power);
+		return 0;
 	}
 
-	return mt76_mcu_send_msg(&dev->mt76,
-				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
-				 sizeof(req), true);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(hdr) + MT7915_SKU_RATE_NUM);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	skb_put_data(skb, &la.cck, len[SKU_CCK] + len[SKU_OFDM]);
+	skb_put_data(skb, &la.mcs[0], len[SKU_HT_BW20]);
+	skb_put_data(skb, &la.mcs[1], len[SKU_HT_BW40]);
+
+	/* vht */
+	for (i = 0; i < 4; i++) {
+		skb_put_data(skb, &la.mcs[i], sizeof(la.mcs[i]));
+		skb_put_zero(skb, 2);  /* padding */
+	}
+
+	/* he */
+	skb_put_data(skb, &la.ru[0], sizeof(la.ru));
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), true);
+	if (ret)
+		return ret;
+
+	/* only set per-path power table when it's configured */
+	if (!phy->sku_path_en)
+		return 0;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(hdr) + MT7915_SKU_PATH_NUM);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr.limit_type = TX_POWER_LIMIT_TABLE_PATH;
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	skb_put_data(skb, &la.path.cck, sizeof(la.path.cck));
+	skb_put_data(skb, &la.path.ofdm, sizeof(la.path.ofdm));
+	skb_put_data(skb, &la.path.ofdm_bf[1], sizeof(la.path.ofdm_bf) - 1);
+
+	/* HT20 and HT40 */
+	skb_put_data(skb, &la.path.ru[3], sizeof(la.path.ru[3]));
+	skb_put_data(skb, &la.path.ru_bf[3][1], sizeof(la.path.ru_bf[3]) - 1);
+	skb_put_data(skb, &la.path.ru[4], sizeof(la.path.ru[4]));
+	skb_put_data(skb, &la.path.ru_bf[4][1], sizeof(la.path.ru_bf[4]) - 1);
+
+	/* start from non-bf and bf fields of
+	 * BW20/RU242, BW40/RU484, BW80/RU996, BW160/RU2x996,
+	 * RU26, RU52, and RU106
+	 */
+
+	for (i = 0; i < 8; i++) {
+		bool bf = i % 2;
+		u8 idx = (i + 6) / 2;
+		s8 *buf = bf ? la.path.ru_bf[idx] : la.path.ru[idx];
+		/* The non-bf fields of RU26 to RU106 are special cases */
+		if (bf)
+			skb_put_data(skb, buf + 1, 9);
+		else
+			skb_put_data(skb, buf, 10);
+	}
+
+	for (i = 0; i < 6; i++) {
+		bool bf = i % 2;
+		u8 idx = i / 2;
+		s8 *buf = bf ? la.path.ru_bf[idx] : la.path.ru[idx];
+
+		skb_put_data(skb, buf, 10);
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), true);
 }
 
-int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
+int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len,
+			       u8 category)
 {
 #define RATE_POWER_INFO	2
 	struct mt7915_dev *dev = phy->dev;
@@ -3431,10 +3517,9 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
 		u8 _rsv;
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_INFO,
-		.category = RATE_POWER_INFO,
+		.category = category,
 		.band_idx = phy->mt76->band_idx,
 	};
-	s8 txpower_sku[MT7915_SKU_RATE_NUM][2];
 	struct sk_buff *skb;
 	int ret, i;
 
@@ -3444,9 +3529,15 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
 	if (ret)
 		return ret;
 
-	memcpy(txpower_sku, skb->data + 4, sizeof(txpower_sku));
-	for (i = 0; i < len; i++)
-		txpower[i] = txpower_sku[i][req.band_idx];
+	if (category == TX_POWER_INFO_RATE) {
+		s8 res[MT7915_SKU_RATE_NUM][2];
+
+		memcpy(res, skb->data + 4, sizeof(res));
+		for (i = 0; i < len; i++)
+			txpower[i] = res[i][req.band_idx];
+	} else if (category == TX_POWER_INFO_PATH) {
+		memcpy(txpower, skb->data + 4, len);
+	}
 
 	dev_kfree_skb(skb);
 
@@ -3475,7 +3566,7 @@ int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 				 sizeof(req), false);
 }
 
-int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
+int mt7915_mcu_set_sku_en(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_sku {
@@ -3484,10 +3575,21 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
 		u8 band_idx;
 		u8 rsv;
 	} __packed req = {
-		.format_id = TX_POWER_LIMIT_ENABLE,
 		.band_idx = phy->mt76->band_idx,
-		.sku_enable = enable,
 	};
+	int ret;
+
+	req.sku_enable = phy->sku_limit_en;
+	req.format_id = TX_POWER_LIMIT_ENABLE;
+
+	ret = mt76_mcu_send_msg(&dev->mt76,
+				MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
+				sizeof(req), true);
+	if (ret)
+		return ret;
+
+	req.sku_enable = phy->sku_path_en;
+	req.format_id = TX_POWER_LIMIT_PATH_ENABLE;
 
 	return mt76_mcu_send_msg(&dev->mt76,
 				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 086ad89ecd9144b4bc566e2a958c99153b3d1dd4..b72535efc6d7d411bf2f03899ac10a81d4d0545b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -429,12 +429,18 @@ enum {
 
 enum {
 	TX_POWER_LIMIT_ENABLE,
+	TX_POWER_LIMIT_PATH_ENABLE = 0x3,
 	TX_POWER_LIMIT_TABLE = 0x4,
 	TX_POWER_LIMIT_INFO = 0x7,
 	TX_POWER_LIMIT_FRAME = 0x11,
 	TX_POWER_LIMIT_FRAME_MIN = 0x12,
 };
 
+enum {
+	TX_POWER_INFO_PATH = 1,
+	TX_POWER_INFO_RATE,
+};
+
 enum {
 	SPR_ENABLE = 0x1,
 	SPR_ENABLE_SD = 0x3,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 2e94347c46d624394a68cf5095c11cafb8264f85..b15d31d36a8725d3d914dda205a13322ea875bfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -70,6 +70,7 @@
 #define MT7915_CDEV_THROTTLE_MAX	99
 
 #define MT7915_SKU_RATE_NUM		161
+#define MT7915_SKU_PATH_NUM		185
 
 #define MT7915_MAX_TWT_AGRT		16
 #define MT7915_MAX_STA_TWT_AGRT		8
@@ -223,6 +224,9 @@ struct mt7915_phy {
 	struct mt76_mib_stats mib;
 	struct mt76_channel_state state_ts;
 
+	bool sku_limit_en:1;
+	bool sku_path_en:1;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 *reg_backup;
@@ -491,9 +495,10 @@ int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 			      u8 en);
 int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
-int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
+int mt7915_mcu_set_sku_en(struct mt7915_phy *phy);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
-int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
+int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len,
+			       u8 category);
 int mt7915_mcu_set_txpower_frame_min(struct mt7915_phy *phy, s8 txpower);
 int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
 				 struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index d534fff5c952bdbf03f3ddafb194220ac882676a..5836b9733f276ffa3dcda2b7a40a0c0e2e987b8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -409,7 +409,7 @@ mt7915_tm_init(struct mt7915_phy *phy, bool en)
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
-	mt7915_mcu_set_sku_en(phy, !en);
+	mt7915_mcu_set_sku_en(phy);
 
 	mt7915_tm_mode_ctrl(dev, en);
 	mt7915_tm_reg_backup_restore(phy);

-- 
2.47.3


