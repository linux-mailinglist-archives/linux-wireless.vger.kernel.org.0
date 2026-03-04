Return-Path: <linux-wireless+bounces-32488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULS3FsnFqGmAxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFC2092A8
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6ABD30D6D30
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E827374745;
	Wed,  4 Mar 2026 23:51:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB73321D8
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668262; cv=none; b=UtJjZJq+EWMGvpdzbbMOB4otWlPgG3ukh2hXP0aZoM8AuxGyGMnccJmjeneYIpFf/HCZDWMy3cOWJ5rREUjA9lv6/U/NIBhOpi3KBu6M/L5cj9HoMYcLLKUxFKh1LtqP3WQOZfgeUmJ8Z/eGGwcX3q6Xn4JTXg/4lQ7DV9omrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668262; c=relaxed/simple;
	bh=yA+0UKGSwmx5NgMSM6Mhycv2zGkTHoNbBM4ge1/XXig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSbespfNCdVJJYaoXF4TQVDJKGWsSmXR1VUJBo49Rk4lT/WNXbrQEfZWzKKSwZIsCxucvMPyfdSwNrkBmPoItN891vRL0PnNDG6zjqfhewcg5vT47jXzm5r1+LzNasDWmXansk++iI6M/Oi2idBkufVQI2ABoBWH1SjBSXmmABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so7537887a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668260; x=1773273060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITGj90b4rmhj9ra+omckXD+F4UkNt/EJau7xKxZK9QM=;
        b=akGwgw6VGtbOtfoJh9fs7FX6z6xOm/T1k+R+6xd6UDHqrVI71bRDyZXHlq9FqGczW1
         vph5FQFBua16WD1Nvu03skRSU2r/PQG6bNQBd4LXKWDVSDhqeFRtVB0I5s+GRRzxlUEK
         2ywjiL00OpxYrGmCJ+/0N0nPqHhXFYUCMkl7XMauQV9u2gIQJBvtOImB0omwrP3YCO1O
         lOn/cNy/tiz8qeSEeuhlcrM/D3abgIH0WHl8ulrwoLKbRf6yd8713Rg3vhiiiQ4gy9ou
         nySdYvE37wrSXr0SfzEjsT1F1D/GAjG3LeOgbrpHyjredbYbsYEk3CZHXpPG1Rc5hp+/
         i9pA==
X-Gm-Message-State: AOJu0YyZVNQbotjpFDhwYQ+LKpq1DaCqTA4yHAJR7s6vIZTWH8Rgo1Fu
	1P/v8T5WD2d0MHmBW/E3rHYZ/GRD6cioIbC/dx7BLooSLedi4jGj1n1A
X-Gm-Gg: ATEYQzxQVKecxBD3H5Q+uZxY5w8eFdRlWOkm+q1cDylFdSKN5oYe+el43RCVKTqBoK9
	OJEYSKjkd/Ts+ZrzKCmwQUmjwEjIzW4GbSR5OirrJxfMTU1SFs9Gx0zqu+uYb7lD7QfmhNGbJBf
	xSH2ESykjxptKnfN83gj6mqO3AppLRvVN1ZIcQwDL3Nh69GVZoqlop8KCe5g7wDSF0xaDOPTAPr
	jeimStcYXooi5kBOnapBzybzmTkYqs/mtg+v0nbKn+pkMmBQeCNdCXpfz983KxWM+D4nislApHZ
	8ABjh0VOtvV5rzckwW6Zk8w3C3Fz4vl4D7bhF3LvsA/YQ1XzCk2T0jafveJYBm4XCnjrRYRC094
	R21Dkza7CBMw/NaMaWNQKxbDbZa1/qHxge3r4my1g+4t+hvQvoNz1/3n6VtDRcdoo/ixO2hUr9D
	WJWaKv/RlbhXqC7yz3e2sjEzMpfOG49r/mi8wVThgMu/0qWws=
X-Received: by 2002:a05:6820:1786:b0:679:a41d:2d2f with SMTP id 006d021491bc7-67b1770a269mr2380231eaf.30.1772668260004;
        Wed, 04 Mar 2026 15:51:00 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm14410687eaf.7.2026.03.04.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:50:59 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	yu-ching.liu@mediatek.com,
	yuchi.wang@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 6/7] wifi: mt76: mt7925: add mac80211 NAN start/stop/change_conf ops
Date: Wed,  4 Mar 2026 17:50:19 -0600
Message-ID: <20260304235020.40451-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304235020.40451-1-sean.wang@kernel.org>
References: <20260304235020.40451-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2BFC2092A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32488-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Wire mac80211 NAN start/stop/change_conf callbacks to mt7925 NAN MCU
enable/disable/config. Track the active NAN vif and notify mac80211 on
cluster join events.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 69 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/nan.c   |  7 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +
 3 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index afcc0fa4aa35..f215984495c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -11,6 +11,7 @@
 #include "regd.h"
 #include "mcu.h"
 #include "mac.h"
+#include "nan.h"
 
 static void
 mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
@@ -442,6 +443,8 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	INIT_WORK(&mvif->csa_work, mt7925_csa_work);
 	timer_setup(&mvif->csa_timer, mt792x_csa_timer, 0);
 
+	if (vif->type == NL80211_IFTYPE_NAN)
+		dev->nan_vif = vif;
 out:
 	mt792x_mutex_release(dev);
 
@@ -2297,6 +2300,69 @@ static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	}
 }
 
+static int mt7925_start_nan(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct cfg80211_nan_conf *conf)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_bss_conf *link_conf = &vif->bss_conf;
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	link_conf->chanreq.oper.chan = conf->band_cfgs[NL80211_BAND_2GHZ].chan;
+
+	err = mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
+				      NULL, true);
+	if (err < 0)
+		goto out;
+
+	err = mt7925_nan_enable(vif, dev, conf);
+
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int mt7925_stop_nan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif)
+{
+	struct ieee80211_bss_conf *link_conf = &vif->bss_conf;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_nan_disable(vif, dev);
+	if (err < 0)
+		goto out;
+
+	err = mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
+				      NULL, false);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int mt7925_nan_change_conf(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_nan_conf *conf,
+				  u32 changes)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_nan_change_configure(vif, dev, conf);
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -2366,6 +2432,9 @@ const struct ieee80211_ops mt7925_ops = {
 	.channel_switch = mt7925_channel_switch,
 	.abort_channel_switch = mt7925_abort_channel_switch,
 	.channel_switch_rx_beacon = mt7925_channel_switch_rx_beacon,
+	.start_nan = mt7925_start_nan,
+	.stop_nan = mt7925_stop_nan,
+	.nan_change_conf = mt7925_nan_change_conf,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/nan.c b/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
index 9483ee94c05e..bb67374c9764 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
@@ -344,11 +344,18 @@ mt7925_nan_mcu_handle_de_event(struct mt792x_dev *dev, struct tlv *tlv)
 	if (de_evt->event_type != NAN_EVENT_ID_JOINED_CLUSTER)
 		return;
 
+	if (!ieee80211_vif_nan_started(dev->nan_vif)) {
+		dev_warn(dev->mt76.dev, "nan: joined-cluster event but NAN not started\n");
+		return;
+	}
+
 	dev_dbg(dev->mt76.dev, "nan: anchor_master_rank=%*phN\n",
 		NAN_ANCHOR_MASTER_RANK_NUM, de_evt->anchor_master_rank);
 
 	dev_dbg(dev->mt76.dev, "nan: own_nmi=%pM master_nmi=%pM\n",
 		de_evt->own_nmi, de_evt->master_nmi);
+
+	ieee80211_nan_cluster_joined(dev->nan_vif, cluster_id, true, GFP_KERNEL);
 }
 
 void mt7925_nan_mcu_event(struct mt792x_dev *dev, struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 1f381ab356bc..d3988e5b38c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -261,6 +261,8 @@ struct mt792x_dev {
 	u32 backup_l2;
 
 	struct ieee80211_chanctx_conf *new_ctx;
+
+	struct ieee80211_vif *nan_vif;
 };
 
 static inline struct mt792x_bss_conf *
-- 
2.43.0


