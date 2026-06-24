Return-Path: <linux-wireless+bounces-38057-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiKeOiLvO2qKfggAu9opvQ
	(envelope-from <linux-wireless+bounces-38057-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 16:52:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9E6BF523
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 16:52:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=atN5qtbL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38057-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38057-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25133031E92
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458C38B7A1;
	Wed, 24 Jun 2026 14:45:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0B38A714
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 14:45:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312358; cv=none; b=jSzLYXRcyX1NkquUni68ZFAd1QI599qAHQ8MOFll2azMteRk6pECpLEsoutTwDsJ8YkcZcKCna/l0BTZ9enoaNFAVlKLRzoDYGamFawxAWO9k6J8k1QQbi72gFC+R8NQZHz05Mn7UcOhuNMn+LRJiLuIw7NoUmMNClCSLb82rPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312358; c=relaxed/simple;
	bh=0hSKaRbJnqoauPScozESh+H1iRZcot6IGUFd3wuXfHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alAdTnJ+1LSdJmG9MsF+3AGgmIZKLzE4WDdOUoHVBHfw4UvInhoY6B61YEZzNmdi+Oe+eWiZenvMmI/uMVDcd3K/eoaGd0AWAPI2ApSUhkBQaUb+az8vcjiLSxrY+CfkXhH2QuTwjl/yG0MSP4pNF6vCuzbvm+AmFA+041lXMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atN5qtbL; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1397e093f90so3107661c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782312353; x=1782917153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eb0BarLYTb9WuaZW5bhQM+SSzkfFweHaZZjaj1HbXk=;
        b=atN5qtbL+Zoht6lgaV3DOBURoE+V6eQnFQeDTs1eX7r8P4ZVSgMGa9OWnSaw8JIc7k
         aG+Mk3Xo5extIDo2XQ+FPCSwKCBi5qhqAVyCKXgi2im8pYE3CX47bY8dDFsv37d2LyQj
         MyPyAY61HAVyhSYiINGEjYl1OuH53IVN3Jnn1g0ssDlLAPrVt48l43nBf/SLLElbdNWV
         48oCWubXQJvn4IMiDQpALy0Ju4UQZz0ypaieEP0RaOjiD+O3GeA2Jif8tzSMPFT3YuJb
         BtxUcJf7nMi65UNJ0Rn4z6a5a4EgqzOS2UutwTKuHzfjc/dlbVpqCEMbo7R0VKvji40/
         E1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782312353; x=1782917153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3eb0BarLYTb9WuaZW5bhQM+SSzkfFweHaZZjaj1HbXk=;
        b=Ci2JcK6oyewLQ0xrAj1K3eL3BL765BTunRjDVV0gbjj9oedBFmHf8FycxGk7ozMXPm
         ELTCq63W4jHw+5bLBphOY55KbXg+MAkbLseYUj+av5A9+JYRksfXcLkXUViLF8j51hD+
         j4bneTQ2tqlwr/2wu+hrJF/Co1zV13M4UYg7RarXwsnvzqWIr5At8d9AG4INpmtOWoft
         Rl+C/X2qAw66CgSl8cd6hoaR+FYxq6ytIiPdfyckhZmKFgSDJ85VSmxoszRie3vNgtt4
         Pghbh2OcRDNGePeJzAXFLDj4fF+YgvHxgU5q/is+fB+Rn6D2zTGPGLQf1iQIT+FeKPmZ
         cGuA==
X-Forwarded-Encrypted: i=1; AHgh+RrAz1DwAi8oyToyK4eWRB3wlt5yUGYZ4GIsuK0XbFy3lb2zkcJ7kkh7pZZrVNELK9Uj5Ly6IJgfgJzkVSPaEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmeSkgTEpmsoIGC7SW6o/+y8LtcOXyYuKkHwBpw/tqXGrABZlH
	XIBpiaHby3plW6ft/anV6yyjPsYfbwaIBVCv8odlDaZQY+Gj0V35v57T
X-Gm-Gg: AfdE7cljd4SmIZOXLsqy2oqrVI3gIOet1w5AWuWYuROjGaWVdCSLDkaSkZEfkoQ8Mfi
	0wb8byl7plV/Uq7/GTyZe/CRV86r78LZskS2BOStfB0Amd2d/7JB9RUhVkdKoI1teJ0/YEKvH47
	/dV/FmT4kVe1WGxB8Nv/rrBM2Bm53n6FwYf/qra1etK0mAurfWNPNmbthHyIZYTJEarszdljo5D
	cnJKm6c88Vas4BjTByWsu7bNVsQGZwm7N4dPcgwmoBO3m14FRVWsN47ncD7X/56rBGHfRVtewtI
	2j21kxCrOOQkeFyB3sgzmCUr8hkOo6dU7eg0X+BlHp1WDfZ8UcdFczOiJQD7XJaHC5C03AiECBR
	Qklz4KZGkkBx9mRV6Ykg9Gjuvd9h3n0iCbhyUuWywe5iGMBFglb0djFr27FE82ixyUjR71DIxL/
	wXyo3bPVwi0+9JBkG4AelIv0C8ZCX/qKuZrIi3
X-Received: by 2002:a05:7300:30d2:b0:30c:43fb:3a69 with SMTP id 5a478bee46e88-30c691290c3mr3758704eec.6.1782312352354;
        Wed, 24 Jun 2026 07:45:52 -0700 (PDT)
Received: from yyh-VMware-Virtual-Platform.lan ([45.32.131.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba5c25csm24899292eec.8.2026.06.24.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:45:51 -0700 (PDT)
From: Yanghan Ye <yyh94306@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>
Cc: linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Yanghan Ye <yyh94306@gmail.com>
Subject: [PATCH v1 2/2] wifi: mt76: mt7996: enable firmware txpower limit controls
Date: Wed, 24 Jun 2026 22:45:16 +0800
Message-ID: <20260624144516.1841063-3-yyh94306@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624144516.1841063-1-yyh94306@gmail.com>
References: <20260624144516.1841063-1-yyh94306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38057-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:deren.wu@mediatek.com,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yyh94306@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yyh94306@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyh94306@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,la.ru:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59F9E6BF523

mt7996 firmware does not apply uploaded SKU and backoff power tables unless
the corresponding UNI_CMD(TXPOWER) controls are enabled. Enable the SKU and
backoff controls in the normal run path and upload the mt7996 backoff table
using the firmware table layout used by the MediaTek SDK.

Keep the mt7996 backoff layout private instead of resizing the shared mt76
power-limit structure used by older connac chipsets. Continue to respect
chan->max_reg_power when initializing channel power.

Signed-off-by: Yanghan Ye <yyh94306@gmail.com>
---
 eeprom.c        |   9 ++
 mt7996/init.c   |  16 ++-
 mt7996/main.c   |  10 ++
 mt7996/mcu.c    | 365 +++++++++++++++++++++++++++++++++++++++++++++---
 mt7996/mcu.h    |  25 ++++
 mt7996/mt7996.h |   6 +
 6 files changed, 411 insertions(+), 20 deletions(-)

diff --git a/eeprom.c b/eeprom.c
index 28dbda6f..440a89dc 100644
--- a/eeprom.c
+++ b/eeprom.c
@@ -511,6 +511,15 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 				     ARRAY_SIZE(dest->ru), val, len, target_power,
 				     txs_delta, &max_power, n_chains, MT76_SKU_RATE);
 
+	val = mt76_get_of_array_s8(np, "rates-eht", &len,
+				   ARRAY_SIZE(dest->eht[0]) + 1);
+	mt76_apply_multi_array_limit(dev, dest->eht[0], ARRAY_SIZE(dest->eht[0]),
+				     ARRAY_SIZE(dest->eht), val, len, target_power,
+				     txs_delta, &max_power, n_chains, MT76_SKU_RATE);
+
+	if (is_mt799x(dev))
+		return max_power == -127 ? target_power : max_power;
+
 	val = mt76_get_of_array_s8(np, "paths-cck", &len, ARRAY_SIZE(dest->path.cck));
 	mt76_apply_array_limit(dev, dest->path.cck, ARRAY_SIZE(dest->path.cck), val,
 			       target_power, txs_delta, &max_power, n_chains, MT76_SKU_BACKOFF);
diff --git a/mt7996/init.c b/mt7996/init.c
index 2bf3ddd8..21c359f5 100644
--- a/mt7996/init.c
+++ b/mt7996/init.c
@@ -362,15 +362,23 @@ static void __mt7996_init_txpower(struct mt7996_phy *phy,
 	int i, n_chains = hweight16(phy->mt76->chainmask);
 	int path_delta = mt76_tx_power_path_delta(n_chains);
 	int pwr_delta = mt7996_eeprom_get_power_delta(dev, sband->band);
-	struct mt76_power_limits limits;
+	struct mt76_power_limits *limits;
+
+	limits = kzalloc(sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return;
+
+	phy->sku_limit_en = true;
 
 	for (i = 0; i < sband->n_channels; i++) {
 		struct ieee80211_channel *chan = &sband->channels[i];
 		int target_power = mt7996_eeprom_get_target_power(dev, chan);
 
+		phy->sku_path_en |= mt7996_has_power_path_limits(phy->mt76, chan);
+
 		target_power += pwr_delta;
 		target_power = mt76_get_rate_power_limits(phy->mt76, chan,
-							  &limits,
+							  limits,
 							  target_power);
 		target_power += path_delta;
 		target_power = DIV_ROUND_UP(target_power, 2);
@@ -379,6 +387,8 @@ static void __mt7996_init_txpower(struct mt7996_phy *phy,
 		phy->txpower = max(phy->txpower, chan->max_power);
 		chan->orig_mpwr = target_power;
 	}
+
+	kfree(limits);
 }
 
 void mt7996_init_txpower(struct mt7996_phy *phy)
@@ -386,6 +396,8 @@ void mt7996_init_txpower(struct mt7996_phy *phy)
 	if (!phy)
 		return;
 
+	phy->sku_path_en = false;
+
 	if (phy->mt76->cap.has_2ghz)
 		__mt7996_init_txpower(phy, &phy->mt76->sband_2g.sband);
 	if (phy->mt76->cap.has_5ghz)
diff --git a/mt7996/main.c b/mt7996/main.c
index c32e7819..f3fec548 100644
--- a/mt7996/main.c
+++ b/mt7996/main.c
@@ -34,6 +34,16 @@ int mt7996_run(struct mt7996_phy *phy)
 	if (ret)
 		return ret;
 
+	ret = mt7996_mcu_set_tx_power_ctrl(phy, UNI_TXPOWER_SKU_POWER_LIMIT_CTRL,
+					   phy->sku_limit_en);
+	if (ret)
+		return ret;
+
+	ret = mt7996_mcu_set_tx_power_ctrl(phy, UNI_TXPOWER_BACKOFF_POWER_LIMIT_CTRL,
+					   phy->sku_path_en);
+	if (ret)
+		return ret;
+
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	ieee80211_queue_delayed_work(dev->mphy.hw, &phy->mt76->mac_work,
diff --git a/mt7996/mcu.c b/mt7996/mcu.c
index c0b9b1bf..bf66f6d2 100644
--- a/mt7996/mcu.c
+++ b/mt7996/mcu.c
@@ -5,6 +5,7 @@
 
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/of.h>
 #include "mt7996.h"
 #include "mcu.h"
 #include "mac.h"
@@ -108,6 +109,242 @@ static bool sr_scene_detect = true;
 module_param(sr_scene_detect, bool, 0644);
 MODULE_PARM_DESC(sr_scene_detect, "Enable firmware scene detection algorithm");
 
+#define MT7996_SKU_PATH_CCK_LEN		5
+#define MT7996_SKU_PATH_OFDM_LEN	5
+#define MT7996_SKU_PATH_OFDM_BF_LEN	4
+#define MT7996_SKU_PATH_RU_NUM		16
+#define MT7996_SKU_PATH_RU_LEN		15
+#define MT7996_SKU_PATH_RU_GROUPS	(MT7996_SKU_PATH_RU_NUM * 2)
+
+#define MT7996_SKU_RATE_CCK_OFDM_LEN	12
+#define MT7996_SKU_RATE_HT20_LEN	8
+#define MT7996_SKU_RATE_HT40_LEN	9
+#define MT7996_SKU_RATE_VHT_NUM		4
+#define MT7996_SKU_RATE_VHT_LEN		10
+#define MT7996_SKU_RATE_VHT_PAD_LEN	2
+#define MT7996_SKU_RATE_HE_LEN		84
+#define MT7996_SKU_RATE_EHT_LEN		256
+
+/*
+ * MTK SDK / UNI_CMD(TXPOWER) POWER_LIMIT_TABLE rate/backoff layout for mt7996.
+ * Keep the backoff table private because older mt76 chipsets use a smaller
+ * connac2 path ABI.
+ */
+struct mt7996_power_path_limits {
+	s8 cck[MT7996_SKU_PATH_CCK_LEN];
+	s8 ofdm[MT7996_SKU_PATH_OFDM_LEN];
+	s8 ofdm_bf[MT7996_SKU_PATH_OFDM_BF_LEN];
+	s8 ru[MT7996_SKU_PATH_RU_NUM][MT7996_SKU_PATH_RU_LEN];
+	s8 ru_bf[MT7996_SKU_PATH_RU_NUM][MT7996_SKU_PATH_RU_LEN];
+};
+
+static const s8 *
+mt7996_of_get_array_s8(struct device_node *np, const char *name,
+		       size_t *len, int min)
+{
+	struct property *prop = of_find_property(np, name, NULL);
+
+	if (!prop || !prop->value || prop->length < min)
+		return NULL;
+
+	*len = prop->length;
+
+	return prop->value;
+}
+
+static const __be32 *
+mt7996_of_get_array(struct device_node *np, const char *name,
+		    size_t *len, int min)
+{
+	struct property *prop = of_find_property(np, name, NULL);
+
+	if (!prop || !prop->value || prop->length < min * 4)
+		return NULL;
+
+	*len = prop->length;
+
+	return prop->value;
+}
+
+static s8 mt7996_get_txs_delta(struct device_node *np, u8 nss)
+{
+	const __be32 *val;
+	size_t len;
+
+	val = mt7996_of_get_array(np, "txs-delta", &len, nss);
+	if (!val)
+		return 0;
+
+	return be32_to_cpu(val[nss - 1]);
+}
+
+static u8 mt7996_backoff_n_chains(u8 idx)
+{
+	/* 0:1T1ss, 1:2T1ss, ..., 14:5T5ss */
+	static const u8 connac3_table[] = {
+		1, 2, 3, 4, 5, 2, 3, 4, 5, 3, 4, 5, 4, 5, 5};
+
+	if (idx >= ARRAY_SIZE(connac3_table))
+		return 0;
+
+	return connac3_table[idx];
+}
+
+static void
+mt7996_apply_path_limit(s8 *pwr, size_t pwr_len, const s8 *data,
+			s8 target_power, s8 nss_delta, int n_chains,
+			bool bf)
+{
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = 0; i < pwr_len; i++) {
+		u8 backoff_chain_idx = i + bf;
+		int backoff_n_chains = mt7996_backoff_n_chains(backoff_chain_idx);
+		s8 backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
+		s8 delta = mt76_tx_power_path_delta(n_chains);
+
+		pwr[i] = min_t(s8, target_power + delta - backoff_delta,
+			       data[i] + nss_delta);
+	}
+}
+
+static void
+mt7996_apply_multi_path_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
+			      const s8 *data, size_t len, s8 target_power,
+			      s8 nss_delta, int n_chains, bool bf)
+{
+	int i, cur;
+
+	if (!data)
+		return;
+
+	cur = data[0];
+	for (i = 0; i < pwr_num; i++) {
+		if (len < pwr_len + 1)
+			break;
+
+		mt7996_apply_path_limit(pwr + pwr_len * i, pwr_len, data + 1,
+					target_power, nss_delta, n_chains, bf);
+		if (--cur > 0)
+			continue;
+
+		data += pwr_len + 1;
+		len -= pwr_len + 1;
+		if (!len)
+			break;
+
+		cur = data[0];
+	}
+}
+
+static struct device_node *
+mt7996_find_power_limit_channel(struct mt76_phy *mphy,
+				struct ieee80211_channel *chan)
+{
+	struct device_node *np;
+	char name[16];
+	char band;
+
+	np = mt76_find_power_limits_node(mphy->dev);
+	if (!np)
+		return NULL;
+
+	switch (chan->band) {
+	case NL80211_BAND_2GHZ:
+		band = '2';
+		break;
+	case NL80211_BAND_5GHZ:
+		band = '5';
+		break;
+	case NL80211_BAND_6GHZ:
+		band = '6';
+		break;
+	default:
+		return NULL;
+	}
+
+	snprintf(name, sizeof(name), "txpower-%cg", band);
+	np = of_get_child_by_name(np, name);
+	if (!np)
+		return NULL;
+
+	return mt76_find_channel_node(np, chan);
+}
+
+bool mt7996_has_power_path_limits(struct mt76_phy *mphy,
+				  struct ieee80211_channel *chan)
+{
+	struct device_node *np;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return false;
+
+	np = mt7996_find_power_limit_channel(mphy, chan);
+	if (!np)
+		return false;
+
+	return of_find_property(np, "paths-cck", NULL) ||
+	       of_find_property(np, "paths-ofdm", NULL) ||
+	       of_find_property(np, "paths-ofdm-bf", NULL) ||
+	       of_find_property(np, "paths-ru", NULL) ||
+	       of_find_property(np, "paths-ru-bf", NULL);
+}
+
+static void
+mt7996_get_power_path_limits(struct mt76_phy *mphy,
+			     struct ieee80211_channel *chan,
+			     struct mt7996_power_path_limits *dest,
+			     s8 target_power)
+{
+	struct device_node *np;
+	const s8 *val;
+	size_t len;
+	s8 txs_delta;
+	int n_chains = hweight16(mphy->chainmask);
+
+	memset(dest, 0, sizeof(*dest));
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return;
+
+	np = mt7996_find_power_limit_channel(mphy, chan);
+	if (!np)
+		return;
+
+	txs_delta = mt7996_get_txs_delta(np, n_chains);
+
+	val = mt7996_of_get_array_s8(np, "paths-cck", &len,
+				     ARRAY_SIZE(dest->cck));
+	mt7996_apply_path_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
+				target_power, txs_delta, n_chains, false);
+
+	val = mt7996_of_get_array_s8(np, "paths-ofdm", &len,
+				     ARRAY_SIZE(dest->ofdm));
+	mt7996_apply_path_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
+				target_power, txs_delta, n_chains, false);
+
+	val = mt7996_of_get_array_s8(np, "paths-ofdm-bf", &len,
+				     ARRAY_SIZE(dest->ofdm_bf));
+	mt7996_apply_path_limit(dest->ofdm_bf, ARRAY_SIZE(dest->ofdm_bf), val,
+				target_power, txs_delta, n_chains, true);
+
+	val = mt7996_of_get_array_s8(np, "paths-ru", &len,
+				     ARRAY_SIZE(dest->ru[0]) + 1);
+	mt7996_apply_multi_path_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
+				      ARRAY_SIZE(dest->ru), val, len,
+				      target_power, txs_delta, n_chains, false);
+
+	val = mt7996_of_get_array_s8(np, "paths-ru-bf", &len,
+				     ARRAY_SIZE(dest->ru_bf[0]) + 1);
+	mt7996_apply_multi_path_limit(dest->ru_bf[0],
+				      ARRAY_SIZE(dest->ru_bf[0]),
+				      ARRAY_SIZE(dest->ru_bf), val, len,
+				      target_power, txs_delta, n_chains, false);
+}
+
 static u8
 mt7996_mcu_get_sta_nss(u16 mcs_map)
 {
@@ -5404,9 +5641,46 @@ int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled)
 				 sizeof(req), true);
 }
 
+int mt7996_mcu_set_tx_power_ctrl(struct mt7996_phy *phy, u8 power_ctrl_id,
+				 u8 data)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct tx_power_ctrl req = {
+		.tag = cpu_to_le16(power_ctrl_id),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.power_ctrl_id = power_ctrl_id,
+		.band_idx = phy->mt76->band_idx,
+	};
+
+	switch (power_ctrl_id) {
+	case UNI_TXPOWER_SKU_POWER_LIMIT_CTRL:
+		req.sku_enable = !!data;
+		break;
+	case UNI_TXPOWER_PERCENTAGE_CTRL:
+		req.percentage_ctrl_enable = !!data;
+		break;
+	case UNI_TXPOWER_PERCENTAGE_DROP_CTRL:
+		req.power_drop_level = data;
+		break;
+	case UNI_TXPOWER_BACKOFF_POWER_LIMIT_CTRL:
+		req.bf_backoff_enable = !!data;
+		break;
+	case UNI_TXPOWER_ATE_MODE_CTRL:
+		req.ate_mode_enable = !!data;
+		break;
+	default:
+		req.sku_enable = !!data;
+		break;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(TXPOWER),
+				 &req, sizeof(req), false);
+}
+
 int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 {
 #define TX_POWER_LIMIT_TABLE_RATE	0
+#define TX_POWER_LIMIT_TABLE_PATH	1
 	struct mt7996_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
 	struct tx_power_limit_table_ctrl {
@@ -5424,45 +5698,100 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 		.power_limit_type = TX_POWER_LIMIT_TABLE_RATE,
 		.band_idx = phy->mt76->band_idx,
 	};
-	struct mt76_power_limits la = {};
+	struct mt7996_power_path_limits *path;
+	struct mt76_power_limits *la;
 	struct sk_buff *skb;
-	int i, tx_power;
+	int i, ret, target_power, tx_power;
 
-	tx_power = mt76_get_power_bound(mphy, phy->txpower);
-	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
-					      &la, tx_power);
-	mphy->txpower_cur = tx_power;
+	target_power = mt76_get_power_bound(mphy, phy->txpower);
+	tx_power = target_power;
+	if (phy->sku_limit_en) {
+		la = kzalloc(sizeof(*la), GFP_KERNEL);
+		if (!la)
+			return -ENOMEM;
+
+		tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+						      la, tx_power);
+		mphy->txpower_cur = tx_power;
+	} else {
+		mphy->txpower_cur = tx_power;
+		return 0;
+	}
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
 				 sizeof(req) + MT7996_SKU_PATH_NUM);
 	if (!skb)
-		return -ENOMEM;
+		goto err_nomem;
 
 	skb_put_data(skb, &req, sizeof(req));
 	/* cck and ofdm */
-	skb_put_data(skb, &la.cck, sizeof(la.cck));
-	skb_put_data(skb, &la.ofdm, sizeof(la.ofdm));
+	skb_put_data(skb, &la->cck, MT7996_SKU_RATE_CCK_OFDM_LEN);
 	/* ht20 */
-	skb_put_data(skb, &la.mcs[0], 8);
+	skb_put_data(skb, &la->mcs[0], MT7996_SKU_RATE_HT20_LEN);
 	/* ht40 */
-	skb_put_data(skb, &la.mcs[1], 9);
+	skb_put_data(skb, &la->mcs[1], MT7996_SKU_RATE_HT40_LEN);
 
 	/* vht */
-	for (i = 0; i < 4; i++) {
-		skb_put_data(skb, &la.mcs[i], sizeof(la.mcs[i]));
-		skb_put_zero(skb, 2);  /* padding */
+	for (i = 0; i < MT7996_SKU_RATE_VHT_NUM; i++) {
+		skb_put_data(skb, &la->mcs[i], MT7996_SKU_RATE_VHT_LEN);
+		skb_put_zero(skb, MT7996_SKU_RATE_VHT_PAD_LEN);
 	}
 
 	/* he */
-	skb_put_data(skb, &la.ru[0], sizeof(la.ru));
+	skb_put_data(skb, &la->ru[0], MT7996_SKU_RATE_HE_LEN);
 	/* eht */
-	skb_put_data(skb, &la.eht[0], sizeof(la.eht));
+	skb_put_data(skb, &la->eht[0], MT7996_SKU_RATE_EHT_LEN);
 
 	/* padding */
 	skb_put_zero(skb, MT7996_SKU_PATH_NUM - MT7996_SKU_RATE_NUM);
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_WM_UNI_CMD(TXPOWER), true);
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_WM_UNI_CMD(TXPOWER), true);
+	if (ret)
+		goto out;
+
+	if (!phy->sku_path_en)
+		goto out;
+
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
+	if (!path)
+		goto err_nomem;
+
+	mt7996_get_power_path_limits(mphy, mphy->chandef.chan, path,
+				     target_power);
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(req) + MT7996_SKU_PATH_NUM);
+	if (!skb)
+		goto err_nomem_path;
+
+	req.power_limit_type = TX_POWER_LIMIT_TABLE_PATH;
+
+	skb_put_data(skb, &req, sizeof(req));
+	skb_put_data(skb, &path->cck, MT7996_SKU_PATH_CCK_LEN);
+	skb_put_data(skb, &path->ofdm, MT7996_SKU_PATH_OFDM_LEN);
+	skb_put_data(skb, &path->ofdm_bf, MT7996_SKU_PATH_OFDM_BF_LEN);
+
+	for (i = 0; i < MT7996_SKU_PATH_RU_GROUPS; i++) {
+		bool bf = i % 2;
+		u8 idx = i / 2;
+		s8 *buf = bf ? path->ru_bf[idx] : path->ru[idx];
+
+		skb_put_data(skb, buf, MT7996_SKU_PATH_RU_LEN);
+	}
+
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_WM_UNI_CMD(TXPOWER), true);
+	kfree(path);
+	goto out;
+
+err_nomem_path:
+	kfree(path);
+err_nomem:
+	ret = -ENOMEM;
+out:
+	kfree(la);
+	return ret;
 }
 
 int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode)
diff --git a/mt7996/mcu.h b/mt7996/mcu.h
index 55d42c9e..fe7b7d9d 100644
--- a/mt7996/mcu.h
+++ b/mt7996/mcu.h
@@ -1030,9 +1030,34 @@ enum {
 };
 
 enum {
+	UNI_TXPOWER_SKU_POWER_LIMIT_CTRL = 0,
+	UNI_TXPOWER_PERCENTAGE_CTRL = 1,
+	UNI_TXPOWER_PERCENTAGE_DROP_CTRL = 2,
+	UNI_TXPOWER_BACKOFF_POWER_LIMIT_CTRL = 3,
 	UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL = 4,
+	UNI_TXPOWER_ATE_MODE_CTRL = 6,
+	UNI_TXPOWER_SHOW_INFO = 7,
 };
 
+struct tx_power_ctrl {
+	u8 _rsv[4];
+
+	__le16 tag;
+	__le16 len;
+
+	u8 power_ctrl_id;
+	union {
+		bool sku_enable;
+		bool ate_mode_enable;
+		bool percentage_ctrl_enable;
+		bool bf_backoff_enable;
+		u8 show_info_category;
+		u8 power_drop_level;
+	};
+	u8 band_idx;
+	u8 rsv[1];
+} __packed;
+
 enum {
 	UNI_CMD_ACCESS_REG_BASIC = 0x0,
 	UNI_CMD_ACCESS_RF_REG_BASIC,
diff --git a/mt7996/mt7996.h b/mt7996/mt7996.h
index 0d648852..7e9e106f 100644
--- a/mt7996/mt7996.h
+++ b/mt7996/mt7996.h
@@ -400,6 +400,8 @@ struct mt7996_phy {
 	bool has_aux_rx;
 	bool counter_reset;
 	bool rdd_tx_paused;
+	bool sku_limit_en;
+	bool sku_path_en;
 };
 
 struct mt7996_dev {
@@ -775,6 +777,10 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
 int mt7996_mcu_get_temperature(struct mt7996_phy *phy);
 int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
 int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable);
+bool mt7996_has_power_path_limits(struct mt76_phy *mphy,
+				  struct ieee80211_channel *chan);
+int mt7996_mcu_set_tx_power_ctrl(struct mt7996_phy *phy, u8 power_ctrl_id,
+				 u8 data);
 int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy);
 int mt7996_mcu_rdd_resume_tx(struct mt7996_phy *phy);
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 rdd_idx, u8 val);
-- 
2.43.0


