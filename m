Return-Path: <linux-wireless+bounces-37332-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g5nwK4jeH2rurQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37332-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:58:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1B6356E2
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:58:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=I4XuNO5h;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37332-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37332-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7E1130C928B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF0C3A75B1;
	Wed,  3 Jun 2026 07:53:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9983FFAB4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 07:53:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473234; cv=none; b=ne5iRi0sr6vW7j01h1aqPTH+Q4lUbP1T/zXv8XbZm5ZhXzEa6Xk5ki/uIsvH/ez+C216hV/gHTDTBl0yERsQfNH1cmwh+dSUB4HvYvZj8wrRl6dqeh7uRtY+O9amrOBG2ZlS7wmA9mvFriwVlqjnEgD+uIq4E0BWdUoGeQfSp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473234; c=relaxed/simple;
	bh=NWCleSnlG/sXyuCwcqhHHxOwpQAutQu7q+h7N2uRueo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJzJ2PE9eyDMpkziLJx9E50d/qXObQEHZfpD1zncXPPnF2usmlqtBYadHFnsFwlCNgokiIo9mVEOwd/kNg1zs9xkuFjvuBGNGOZpLyBOPki1zPy2hPCh45L1TQADyIhtkMnnPm2ROHXQBURSLu5IvbDlKZwirr9PLDFpiBSIz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I4XuNO5h; arc=none smtp.client-ip=210.61.82.184
X-UUID: 594579065f2111f18dc8c9802ae25ab1-20260603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uGMLmPpP2iSB22VCiOIPy4nqBG/Gu4r6HhPmuX9C4tU=;
	b=I4XuNO5hAkMySVEHLGMd9eiSZWPTWBonGJhnPT/M9fDsmVgKlKjYHKSVSKZkx5oQfXrg9Mxs4pHwrEvUDG0Z1QNVgNHH+SBodZuBAbXPDfFZJCPLBtOf7xUSZZP8PyEWjvR8RQmgYBOco7RFZmMZL4R/t+vkt3M+zJ2jQdv4wik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:f0a100d2-4a13-4008-8cfa-291d0dbd3596,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:59402e8f-2d9b-4560-8147-1122f58e041c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|136|836|865|888|898,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 594579065f2111f18dc8c9802ae25ab1-20260603
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1820587882; Wed, 03 Jun 2026 15:53:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Jun 2026 15:53:44 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 3 Jun 2026 15:53:44 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <Charlie-cy.Wu@mediatek.com>,
	<jb.tsai@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: add regulatory wiphy self manager support
Date: Wed, 3 Jun 2026 15:53:43 +0800
Message-ID: <20260603075343.1234786-1-jb.tsai@mediatek.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-37332-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:Charlie-cy.Wu@mediatek.com,m:jb.tsai@mediatek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:from_mime,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07A1B6356E2

From: Charlie-cy Wu <Charlie-cy.Wu@mediatek.com>

Introduce regulatory wiphy self-managed mode support for MT7921,
allowing the driver to manage its own regulatory domain independently
from the kernel's regulatory framework.

Signed-off-by: Charlie-cy Wu <Charlie-cy.Wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7921/regd.c  | 209 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/regd.h  |  55 ++++-
 4 files changed, 245 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ed5c441748d8..c10a2c4e7ee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1363,6 +1363,7 @@ enum {
 	MCU_CE_CMD_FWLOG_2_HOST = 0xc5,
 	MCU_CE_CMD_GET_WTBL = 0xcd,
 	MCU_CE_CMD_GET_TXPWR = 0xd0,
+	MCU_CE_CMD_SET_REGD_CH = 0xd1,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 25b9437250f7..2e0769d18f87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1403,6 +1403,9 @@ int mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 
 	/* submit all clc config */
 	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
+		if (i == MT792x_CLC_REGD)
+			continue;
+
 		ret = __mt7921_mcu_set_clc(dev, alpha2, env_cap,
 					   phy->clc[i], i);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
index f122e418d825..e52191776f97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -10,6 +10,15 @@ static bool mt7921_disable_clc;
 module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
 MODULE_PARM_DESC(disable_clc, "disable CLC support");
 
+static const struct ieee80211_regdomain mt7921_regd_ww = {
+	.n_reg_rules = 1,
+	.alpha2 =  "00",
+	.reg_rules = {
+		/* IEEE 802.11b/g, channels 1..11 */
+		REG_RULE(2412 - 10, 2462 + 10, 40, 6, 20, 0),
+	}
+};
+
 bool mt7921_regd_clc_supported(struct mt792x_dev *dev)
 {
 	if (mt7921_disable_clc ||
@@ -33,6 +42,9 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	np = mt76_find_power_limits_node(mdev);
 
 	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
+
 	band_np = np ? of_get_child_by_name(np, "txpower-5g") : NULL;
 	for (i = 0; i < sband->n_channels; i++) {
 		ch = &sband->channels[i];
@@ -71,35 +83,36 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	}
 }
 
-int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
-			   enum environment_cap country_ie_env)
+static int mt7921_mcu_apply_regd(struct mt792x_dev *dev, u8 *alpha2,
+				  enum environment_cap env)
 {
-	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_hw *hw = mdev->hw;
+	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
-	int ret = 0;
-
-	dev->regd_in_progress = true;
-
-	mt792x_mutex_acquire(dev);
-	if (!dev->regd_change)
-		goto err;
+	int ret;
 
-	ret = mt7921_mcu_set_clc(dev, alpha2, country_ie_env);
+	ret = mt7921_mcu_set_clc(dev, alpha2, env);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	mt7921_regd_channel_update(wiphy, dev);
 
 	ret = mt76_connac_mcu_set_channel_domain(hw->priv);
 	if (ret < 0)
-		goto err;
+		return ret;
 
-	ret = mt7921_set_tx_sar_pwr(hw, NULL);
-	if (ret < 0)
-		goto err;
+	return mt7921_set_tx_sar_pwr(hw, NULL);
+}
 
-err:
+int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
+			   enum environment_cap country_ie_env)
+{
+	int ret = 0;
+
+	dev->regd_in_progress = true;
+
+	mt792x_mutex_acquire(dev);
+	if (dev->regd_change)
+		ret = mt7921_mcu_apply_regd(dev, alpha2, country_ie_env);
 	mt792x_mutex_release(dev);
 	dev->regd_change = false;
 	dev->regd_in_progress = false;
@@ -142,10 +155,160 @@ void mt7921_regd_notifier(struct wiphy *wiphy,
 	if (pm->suspended)
 		return;
 
+	if (MT7921_REGD_SUPPORTED(&dev->phy)) {
+		mt7921_regd_update(&dev->phy, req->alpha2);
+
+		return;
+	}
+
 	mt7921_mcu_regd_update(dev, req->alpha2,
 			       req->country_ie_env);
 }
 
+static struct sk_buff *
+mt7921_regd_query_regdb(struct mt792x_phy *phy, char *alpha2)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt7921_clc *clc = phy->clc[MT792x_CLC_REGD];
+	struct mt7921_regd_query_req *req;
+	struct mt7921_regd_cc *regd_cc;
+	struct sk_buff *ret_skb = NULL;
+	u8 *pos, *last_pos;
+	int ret = 0;
+
+	if (!clc)
+		return NULL;
+
+	pos = clc->data;
+	last_pos = pos + le32_to_cpu(clc->len) - sizeof(struct mt7921_clc);
+	while (pos < last_pos) {
+		u32 req_len = 0;
+		u32 rules_len = 0;
+		u32 sign_len = 4;
+
+		if (pos + sizeof(*regd_cc) > last_pos)
+			break;
+
+		regd_cc = (struct mt7921_regd_cc *)pos;
+		rules_len = sizeof(struct mt7921_regd_rule_header) +
+			    sizeof(struct mt7921_regd_rule) *
+			    le32_to_cpu(regd_cc->n_reg_rules);
+
+		if (pos + sizeof(*regd_cc) + rules_len + sign_len > last_pos)
+			break;
+
+		pos += sizeof(*regd_cc) + rules_len + sign_len;
+		if (memcmp(regd_cc->alpha2, alpha2, 2))
+			continue;
+
+		req_len = sizeof(*req) + rules_len + sign_len;
+		req = devm_kmalloc(dev->mt76.dev, req_len, GFP_KERNEL);
+
+		if (!req)
+			return NULL;
+
+		req->ver = regd_cc->ver;
+		req->sign_type = regd_cc->sign_type;
+		req->size = cpu_to_le32(rules_len + sign_len);
+		req->n_reg_rules = regd_cc->n_reg_rules;
+
+		memcpy(req->alpha2, regd_cc->alpha2, 2);
+		memcpy(req->data, regd_cc->data, rules_len + sign_len);
+
+		ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+						MCU_CE_CMD(SET_REGD_CH),
+						req, req_len, true, &ret_skb);
+
+		devm_kfree(dev->mt76.dev, req);
+
+		return ret < 0 ? NULL : ret_skb;
+	}
+
+	return NULL;
+}
+
+int mt7921_regd_update(struct mt792x_phy *phy, char *alpha2)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt7921_regd_rule *mt7921_rule;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_regdomain *regd;
+	struct ieee80211_reg_rule *rule;
+	struct mt7921_regd_rule_ev *ev;
+	int i, num_of_rules = 0;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	if (dev->hw_full_reset)
+		return 0;
+
+	if (!MT7921_REGD_SUPPORTED(phy))
+		return -EOPNOTSUPP;
+
+	mt792x_mutex_acquire(dev);
+	skb = mt7921_regd_query_regdb(phy, alpha2);
+	mt792x_mutex_release(dev);
+
+	if (!skb)
+		return -EINVAL;
+
+	ev = (struct mt7921_regd_rule_ev *)(skb->data + 4);
+	num_of_rules = le32_to_cpu(ev->n_reg_rules);
+
+	if (!num_of_rules ||
+		WARN_ON_ONCE(num_of_rules > NL80211_MAX_SUPP_REG_RULES)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	regd = kzalloc(struct_size(regd, reg_rules, num_of_rules), GFP_KERNEL);
+	if (!regd) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < num_of_rules; i++) {
+		mt7921_rule = &ev->reg_rule[i];
+		rule = &regd->reg_rules[i];
+
+		rule->freq_range.start_freq_khz =
+					MHZ_TO_KHZ(mt7921_rule->start_freq);
+		rule->freq_range.end_freq_khz =
+					MHZ_TO_KHZ(mt7921_rule->end_freq);
+		rule->freq_range.max_bandwidth_khz =
+					MHZ_TO_KHZ(mt7921_rule->max_bw);
+		/* not used by fw */
+		rule->power_rule.max_antenna_gain = DBI_TO_MBI(6);
+		rule->power_rule.max_eirp = DBM_TO_MBM(22);
+		rule->flags = mt7921_rule->flags;
+	}
+
+	regd->n_reg_rules = num_of_rules;
+	regd->dfs_region = ev->dfs_region;
+
+	memcpy(regd->alpha2, alpha2, 2);
+	memcpy(mdev->alpha2, alpha2, 2);
+
+	dev->regd_change = true;
+	mt7921_mcu_regd_update(dev, alpha2, ENVIRON_ANY);
+
+	ret = regulatory_set_wiphy_regd(wiphy, regd);
+
+	kfree(regd);
+err:
+	dev_kfree_skb(skb);
+
+	if (ret < 0)
+		return regulatory_set_wiphy_regd(wiphy, &mt7921_regd_ww);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7921_regd_update);
+
 static bool
 mt7921_regd_is_valid_alpha2(const char *alpha2)
 {
@@ -183,7 +346,9 @@ int mt7921_regd_change(struct mt792x_phy *phy, char *alpha2)
 	if (!memcmp(alpha2, mdev->alpha2, 2))
 		return 0;
 
-	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
+	if (MT7921_REGD_SUPPORTED(phy))
+		return mt7921_regd_update(phy, alpha2);
+	else if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
 		return regulatory_hint(wiphy, alpha2);
 	else
 		return mt7921_mcu_set_clc(dev, alpha2, ENVIRON_INDOOR);
@@ -197,7 +362,11 @@ int mt7921_regd_init(struct mt792x_phy *phy)
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
 
-	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
+	if (MT7921_REGD_SUPPORTED(phy)) {
+		wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED |
+					   REGULATORY_DISABLE_BEACON_HINTS;
+		return mt7921_regd_update(phy, "00");
+	} else if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE |
 					   REGULATORY_DISABLE_BEACON_HINTS;
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
index 571f31629e9e..c1e94cd4c958 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -4,9 +4,57 @@
 #ifndef __MT7921_REGD_H
 #define __MT7921_REGD_H
 
-struct mt792x_dev;
-struct wiphy;
-struct regulatory_request;
+#include "mt7921.h"
+
+struct mt7921_regd_rule_header {
+	u8 alpha2[2];
+	u8 dfs_region;
+	u8 rsv[13];
+};
+
+struct mt7921_regd_rule {
+	u32 start_freq;
+	u32 end_freq;
+	u32 max_bw;
+	u32 eirp;
+	u32 flags;
+	u8 rsv[12];
+};
+
+struct mt7921_regd_cc {
+	u8 alpha2[2];
+	u8 ver;
+	u8 rsv;
+	__le32 n_reg_rules;
+	u8 sign_type;
+	u8 rsv1[7];
+	u8 data[];
+};
+
+struct mt7921_regd_rule_ev {
+	__le16 tag;
+	__le16 len;
+	__le32 n_reg_rules;
+	u8 dfs_region;
+	u8 rsv[15];
+	struct mt7921_regd_rule reg_rule[];
+};
+
+struct mt7921_regd_query_req {
+	u8 ver;
+	u8 sign_type;
+	u8 rsv1[2];
+	__le32 size;
+	u8 alpha2[2];
+	u8 rsv2[2];
+	__le32 n_reg_rules;
+	u8 rsv3[64];
+	u8 data[];
+};
+
+#define MT7921_REGD_SUPPORTED(phy) \
+	(((phy)->chip_cap & MT792x_CHIP_CAP_REGD_EN) && \
+	(phy)->clc[MT792x_CLC_REGD])
 
 int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
 			   enum environment_cap country_ie_env);
@@ -15,5 +63,6 @@ void mt7921_regd_notifier(struct wiphy *wiphy,
 bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
 int mt7921_regd_change(struct mt792x_phy *phy, char *alpha2);
 int mt7921_regd_init(struct mt792x_phy *phy);
+int mt7921_regd_update(struct mt792x_phy *phy, char *alpha2);
 
 #endif
-- 
2.18.0


