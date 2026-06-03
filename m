Return-Path: <linux-wireless+bounces-37331-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4FbYDondH2qVrQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37331-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:53:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBBA63567E
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:53:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=VakXXYcQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37331-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37331-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690EB3009166
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72AE3FE362;
	Wed,  3 Jun 2026 07:53:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB23A75B1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 07:53:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473220; cv=none; b=CWW6hAbUL13lM3qPHEoeEpAL9MWws7gL+lx102/atbOUsFlFQLMIR7ObNcW1eGnvE+4ljfhhzqjKdMcQjULE3LM2SwAIGQZF6YpgoFJuOapZfsaQTByra7nGUoesp4i/vEW9x1LBskojAuqpf0a2xIWxVGdSfjrfomfOfynYPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473220; c=relaxed/simple;
	bh=e+kYUe4EQ4GlWdPomGPdk8LKaZ0IEbu3cfCG0PH+HjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qlQtGLIahTRDYFgq7nx1ZJjG0gyQtPOoV83M9wrSQjUobmBz8yoQrRKrPWzWFTYoP+72No7dH1zjcjHyjk0K3sOpW4NMIU9/HKwni7x9SC8AXvF+cvuENoPI0ISAGFT6r6FN3GRuQHeirpKIZa4Hpj22TPe6BQP8t4NMXVO9J9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VakXXYcQ; arc=none smtp.client-ip=210.61.82.184
X-UUID: 51e24d9c5f2111f18dc8c9802ae25ab1-20260603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IIZ+7txbNSob6DotSA+sAEN6o5q0z/u7U+ycLhTSNIc=;
	b=VakXXYcQCi6lrqxqioz7Itf7YTxHpezEjI8kqKKE09P+uwLsu2k5kzy/yp4a79yO5Adm3NNI5lbn+cEZdKB71NqYkAs2eSyNViUS0subAP9UHCQjCrwel8CEmg5SvWiOihtmFtIwmdyFrctjyOGSTxbHVbmMXMEa1dSwr/EfnGo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:97cb2dc2-f892-459b-96e1-115d71f13080,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:9756db4a-0fc9-42b9-813e-4bf0d3f02fad,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|136|836|865|888|898,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 51e24d9c5f2111f18dc8c9802ae25ab1-20260603
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1676255081; Wed, 03 Jun 2026 15:53:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Jun 2026 15:53:32 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 3 Jun 2026 15:53:32 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <Charlie-cy.Wu@mediatek.com>,
	<jb.tsai@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: add regulatory wiphy self manager support
Date: Wed, 3 Jun 2026 15:53:31 +0800
Message-ID: <20260603075331.1234691-1-jb.tsai@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-37331-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BBBA63567E

From: Charlie-cy Wu <Charlie-cy.Wu@mediatek.com>

Introduce regulatory wiphy self-managed mode support for MT7925,
allowing the driver to manage its own regulatory domain independently
from the kernel's regulatory framework.

Signed-off-by: Charlie-cy Wu <Charlie-cy.Wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7925/regd.c  | 204 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |  54 +++++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +
 4 files changed, 244 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 37cdf3e8a067..56b265602faa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3457,7 +3457,8 @@ int mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 
 	/* submit all clc config */
 	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
-		if (i == MT792x_CLC_BE_CTRL)
+		if (i == MT792x_CLC_BE_CTRL ||
+		    i == MT792x_CLC_REGD)
 			continue;
 
 		ret = __mt7925_mcu_set_clc(dev, alpha2, env_cap,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index 16f56ee879d4..bbd8f2d008c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -9,6 +9,15 @@ static bool mt7925_disable_clc;
 module_param_named(disable_clc, mt7925_disable_clc, bool, 0644);
 MODULE_PARM_DESC(disable_clc, "disable CLC support");
 
+static const struct ieee80211_regdomain mt7925_regd_ww = {
+	.n_reg_rules = 1,
+	.alpha2 =  "00",
+	.reg_rules = {
+		/* IEEE 802.11b/g, channels 1..11 */
+		REG_RULE(2412 - 10, 2462 + 10, 40, 6, 20, 0),
+	}
+};
+
 bool mt7925_regd_clc_supported(struct mt792x_dev *dev)
 {
 	if (mt7925_disable_clc ||
@@ -128,35 +137,37 @@ mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	}
 }
 
-int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
-			   enum environment_cap country_ie_env)
+static int mt7925_mcu_apply_regd(struct mt792x_dev *dev, u8 *alpha2,
+				  enum environment_cap env)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
-	int ret = 0;
-
-	dev->regd_in_progress = true;
-
-	mt792x_mutex_acquire(dev);
-	if (!dev->regd_change)
-		goto err;
+	int ret;
 
-	ret = mt7925_mcu_set_clc(dev, alpha2, country_ie_env);
+	ret = mt7925_mcu_set_clc(dev, alpha2, env);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	mt7925_regd_be_ctrl(dev, alpha2);
 	mt7925_regd_channel_update(wiphy, dev);
 
 	ret = mt7925_mcu_set_channel_domain(hw->priv);
 	if (ret < 0)
-		goto err;
+		return ret;
 
-	ret = mt7925_set_tx_sar_pwr(hw, NULL);
-	if (ret < 0)
-		goto err;
+	return mt7925_set_tx_sar_pwr(hw, NULL);
+}
 
-err:
+int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
+			   enum environment_cap country_ie_env)
+{
+	int ret = 0;
+
+	dev->regd_in_progress = true;
+
+	mt792x_mutex_acquire(dev);
+	if (dev->regd_change)
+		ret = mt7925_mcu_apply_regd(dev, alpha2, country_ie_env);
 	mt792x_mutex_release(dev);
 	dev->regd_change = false;
 	dev->regd_in_progress = false;
@@ -197,11 +208,162 @@ void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req)
 		/* postpone the mcu update to resume */
 		return;
 
+	if (MT7925_REGD_SUPPORTED(&dev->phy)) {
+		mt7925_regd_update(&dev->phy, req->alpha2);
+
+		return;
+	}
+
 	mt7925_mcu_regd_update(dev, req->alpha2,
 			       req->country_ie_env);
 	return;
 }
 
+static struct sk_buff *
+mt7925_regd_query_regdb(struct mt792x_phy *phy, char *alpha2)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt7925_clc *clc = phy->clc[MT792x_CLC_REGD];
+	struct mt7925_regd_query_req *req;
+	struct mt7925_regd_cc *regd_cc;
+	struct sk_buff *ret_skb = NULL;
+	u8 *pos, *last_pos;
+	int ret = 0;
+
+	if (!clc)
+		return NULL;
+
+	pos = clc->data;
+	last_pos = pos + le32_to_cpu(clc->len) - sizeof(struct mt7925_clc);
+	while (pos < last_pos) {
+		u32 req_len = 0;
+		u32 rules_len = 0;
+		u32 sign_len = 4;
+
+		if (pos + sizeof(*regd_cc) > last_pos)
+			break;
+
+		regd_cc = (struct mt7925_regd_cc *)pos;
+		rules_len = sizeof(struct mt7925_regd_rule_header) +
+			    sizeof(struct mt7925_regd_rule) *
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
+		req->tag = cpu_to_le16(0x6);
+		req->len = cpu_to_le16(req_len - 4);
+		req->ver = regd_cc->ver;
+		req->sign_type = regd_cc->sign_type;
+		req->size = cpu_to_le32(rules_len + sign_len);
+		req->n_reg_rules = regd_cc->n_reg_rules;
+
+		memcpy(req->alpha2, regd_cc->alpha2, 2);
+		memcpy(req->data, regd_cc->data, rules_len + sign_len);
+
+		ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+						MCU_UNI_CMD(SET_POWER_LIMIT),
+						req, req_len, true, &ret_skb);
+		devm_kfree(dev->mt76.dev, req);
+
+		return ret < 0 ? NULL : ret_skb;
+	}
+
+	return NULL;
+}
+
+int mt7925_regd_update(struct mt792x_phy *phy, char *alpha2)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt7925_regd_rule *mt7925_rule;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_regdomain *regd;
+	struct ieee80211_reg_rule *rule;
+	struct mt7925_regd_rule_ev *ev;
+	int i, num_of_rules = 0;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	if (dev->hw_full_reset)
+		return 0;
+
+	if (!MT7925_REGD_SUPPORTED(phy))
+		return -EOPNOTSUPP;
+
+	mt792x_mutex_acquire(dev);
+	skb = mt7925_regd_query_regdb(phy, alpha2);
+	mt792x_mutex_release(dev);
+
+	if (!skb)
+		return -EINVAL;
+
+	ev = (struct mt7925_regd_rule_ev *)(skb->data + 4);
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
+		mt7925_rule = &ev->reg_rule[i];
+		rule = &regd->reg_rules[i];
+
+		rule->freq_range.start_freq_khz =
+					MHZ_TO_KHZ(mt7925_rule->start_freq);
+		rule->freq_range.end_freq_khz =
+					MHZ_TO_KHZ(mt7925_rule->end_freq);
+		rule->freq_range.max_bandwidth_khz =
+					MHZ_TO_KHZ(mt7925_rule->max_bw);
+		/* not used by fw */
+		rule->power_rule.max_antenna_gain = DBI_TO_MBI(6);
+		rule->power_rule.max_eirp = DBM_TO_MBM(22);
+		rule->flags = mt7925_rule->flags;
+	}
+
+	regd->n_reg_rules = num_of_rules;
+	regd->dfs_region = ev->dfs_region;
+
+	memcpy(regd->alpha2, alpha2, 2);
+	memcpy(mdev->alpha2, alpha2, 2);
+
+	dev->regd_change = true;
+	mt7925_mcu_regd_update(dev, alpha2, ENVIRON_ANY);
+
+	ret = regulatory_set_wiphy_regd(wiphy, regd);
+
+	kfree(regd);
+err:
+	dev_kfree_skb(skb);
+
+	if (ret < 0)
+		return regulatory_set_wiphy_regd(wiphy, &mt7925_regd_ww);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7925_regd_update);
+
 static bool
 mt7925_regd_is_valid_alpha2(const char *alpha2)
 {
@@ -240,7 +402,9 @@ int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2)
 	if (!memcmp(alpha2, mdev->alpha2, 2))
 		return 0;
 
-	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN) {
+	if (MT7925_REGD_SUPPORTED(phy)) {
+		return mt7925_regd_update(phy, alpha2);
+	} else if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN) {
 		return regulatory_hint(wiphy, alpha2);
 	} else {
 		return mt7925_mcu_set_clc(dev, alpha2, ENVIRON_INDOOR);
@@ -255,7 +419,11 @@ int mt7925_regd_init(struct mt792x_phy *phy)
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
 
-	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN) {
+	if (MT7925_REGD_SUPPORTED(phy)) {
+		wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED |
+					   REGULATORY_DISABLE_BEACON_HINTS;
+		return mt7925_regd_update(phy, "00");
+	} else if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN) {
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE |
 					   REGULATORY_DISABLE_BEACON_HINTS;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
index 0767f078862e..2feacf42dc22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
@@ -6,12 +6,66 @@
 
 #include "mt7925.h"
 
+struct mt7925_regd_rule_header {
+	u8 alpha2[2];
+	u8 dfs_region;
+	u8 rsv[13];
+};
+
+struct mt7925_regd_rule {
+	u32 start_freq;
+	u32 end_freq;
+	u32 max_bw;
+	u32 eirp;
+	u32 flags;
+	u8 rsv[12];
+};
+
+struct mt7925_regd_cc {
+	u8 alpha2[2];
+	u8 ver;
+	u8 rsv;
+	__le32 n_reg_rules;
+	u8 sign_type;
+	u8 rsv1[7];
+	u8 data[];
+};
+
+struct mt7925_regd_rule_ev {
+	__le16 tag;
+	__le16 len;
+	__le32 n_reg_rules;
+	u8 dfs_region;
+	u8 rsv[15];
+	struct mt7925_regd_rule reg_rule[];
+};
+
+struct mt7925_regd_query_req {
+	u8 rsv[4];
+	__le16 tag;
+	__le16 len;
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
+#define MT7925_REGD_SUPPORTED(phy) \
+	(((phy)->chip_cap & MT792x_CHIP_CAP_REGD_EN) && \
+	(phy)->clc[MT792x_CLC_REGD])
+
 int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
 			   enum environment_cap country_ie_env);
 
 void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
 void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req);
 bool mt7925_regd_clc_supported(struct mt792x_dev *dev);
+int mt7925_regd_update(struct mt792x_phy *phy, char *alpha2);
 int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2);
 int mt7925_regd_init(struct mt792x_phy *phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4ff93f2cd624..cd81cc519ef4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -29,6 +29,7 @@
 #define MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN BIT(1)
 #define MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN BIT(3)
 #define MT792x_CHIP_CAP_11D_EN BIT(4)
+#define MT792x_CHIP_CAP_REGD_EN BIT(5)
 #define MT792x_CHIP_CAP_MLO_EN BIT(8)
 #define MT792x_CHIP_CAP_MLO_EML_EN BIT(9)
 
@@ -75,6 +76,7 @@ enum {
 	MT792x_CLC_POWER,
 	MT792x_CLC_POWER_EXT,
 	MT792x_CLC_BE_CTRL,
+	MT792x_CLC_REGD,
 	MT792x_CLC_MAX_NUM,
 };
 
-- 
2.18.0


