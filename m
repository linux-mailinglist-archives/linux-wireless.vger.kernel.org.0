Return-Path: <linux-wireless+bounces-34282-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHh0AMNjzWkHdAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34282-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 20:28:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725537F430
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD133002FAB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D2285CBA;
	Wed,  1 Apr 2026 18:23:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E41096F
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067815; cv=none; b=ZhyHkr57/lvGUuMnAkiHWqtOGeTZwiXpBGjE40ZAKUiKk96Z41sAEhkXYjaEmGDDNxAUGhxiqKE6ZKox8nkk3F5UIuVfHx4OmceKlbCtT+QfWO3mvq9BVKC1eArkeUEsCy+OJ680r/DvNSbg2F7mYyx9Y0eTOtHRObxbZ17SrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067815; c=relaxed/simple;
	bh=M3dtOgsDJGmNc5xdHP8gX5HurAKIP3hQCkrAObkxXkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEsj/GqJ+10o0WLJG33ViLNCM4/l5DnKOAVg5ahqH3QOqBP8fFyHX7HCfomPAAuY81nRahhViMBe9XL1fwRP8OBMn1CWeT19miDTw09yy4ZD353pzHG6P8hrUe8wCU/xEaAn2QD8AY19sTyqZxcGM8l7MzJr4zO3AkUZIIZgqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46708149af2so33527b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 11:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067813; x=1775672613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aauRVUQQqkGVpGY51g7LHYShg9XLgVwRWtM8bAaqPig=;
        b=qBVZSzCD7G7hk0DNUeJ/rpQClVmVDFOh4S9QtLi3xKM3qrWv0jAICwTLNTUwRdr5HR
         yI95QFnBUe/nha6cGR/HtQg9obaBZ4GtANxgdt6dqQ4D+1rlbzumrGENl8A5JwAHFRXn
         RuABmBcwk9r4Y1keXvZS1chY9HsxeV+rqK+Yw9IDtxwHDOcW5ygltrY7bM1Z3NAqAwmn
         SD+oaLooGIEYLqvennd0dDCJzy/MqC7yR3jEhJ79CiV1IxxlxNiz7oRbnhPSz5QzpC6T
         GmuILsIcXl9ObLLHLIXdx9pAkfgp487QTGK1mvc9pCkzIig6jIw3fCNvQR8XrR7xFGtn
         3P3w==
X-Gm-Message-State: AOJu0YxdBfxlmRQwdAlsGL182fQQ5qpzY5WE2L2ODZgfotfed7j1bICc
	rNp13htCm2pFYsSifz23tMKDwYueYWDO7yp0O+hmVNrWlxihPBgiDRVE
X-Gm-Gg: ATEYQzzKkI+mj2I8HVA2a+EFcjoSClc03Ssq14JNjgLLjV3r4NDvoOLlzQtz9YFy0AS
	XFGygPBX2KnVedvDi1gQ2cMRoVB3B4k8ACxzNSOot/GjspMTpcqexxtnwLCVRQOgdvrWUodVil6
	NBWHSOgFTxQesWmTCRLB22XK31c625T4nyC3OkzoGHxFenkpNzcRoh8y3vxC+jKFL8CfEwFOoHb
	9oeQKQ6vqhiti8ieA2rRHIU7gBnETCnJzed9SY2gp9LJM+ZxYohrBZrJqgp6NmBBSAjaFwbaU/q
	GzU3YOZ4kOToczGKVwqKu7ryLpURCSjWQuQksMdzNubcY0QkErKomvEhjPLoyrgxt03wkeoVBzy
	QVSqstnkkyd/QVtxL5GeuuIcr1bcUP6ZZYWPqpmX6flcNRa846CAG8QdfXqJpsOPBNKuTXaW297
	asG6xvrCo+QdJ0kmHU6c9IpChsx/sOubJbfROtMzRc8wpmMVY=
X-Received: by 2002:a05:6808:308d:b0:45e:dbf9:61c7 with SMTP id 5614622812f47-46ae01e3780mr2409342b6e.46.1775067812855;
        Wed, 01 Apr 2026 11:23:32 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c9e06sm386778fac.15.2026.04.01.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:23:32 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Devin Wittmayer <lucid_duck@justthetip.ca>,
	Satadru Pramanik <satadru@gmail.com>
Subject: [PATCH v2 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
Date: Wed,  1 Apr 2026 13:23:20 -0500
Message-ID: <20260401182322.64355-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mediatek.com,justthetip.ca,gmail.com];
	TAGGED_FROM(0.00)[bounces-34282-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.922];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 5725537F430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

The cached txpower value is derived from the bounded channel power after
applying the chainmask path delta.

Use a helper for that conversion so callers do not open-code it.

Reported-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Closes: https://lore.kernel.org/linux-wireless/20260130215839.53270-1-lucid_duck@justthetip.ca/
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Tested-by: Satadru Pramanik <satadru@gmail.com>
Co-developed-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
--
v2:
- Rebased onto the latest mt76 tree
- Added Reported-by, Tested-by, Co-developed-by and Signed-off-by tags
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 ++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 51423c7740bd..d0953e02810b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -420,7 +420,7 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss, enum nl80211_band band);
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 			       int ring_base, void *wed, u32 flags);
-
+void mt76_connac_set_txpower_cur(struct mt76_phy *phy, s8 max_power);
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 			      struct mt76_tx_info *tx_info,
 			      void *txp_ptr, u32 id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0339e2e7ab60..b2daa6c7d061 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -275,6 +275,15 @@ int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_init_tx_queues);
 
+void mt76_connac_set_txpower_cur(struct mt76_phy *phy, s8 max_power)
+{
+	int delta;
+
+	delta = mt76_tx_power_path_delta(hweight16(phy->chainmask));
+	phy->txpower_cur = max_power - delta;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_set_txpower_cur);
+
 #define __bitrate_mask_check(_mcs, _mode)				\
 ({									\
 	u8 i = 0;							\
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 89bd52ea8bf7..897b065a2be6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2223,14 +2223,19 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
-			s8 reg_power, sar_power;
+			s8 reg_power, sar_power, max_power;
 
 			reg_power = mt76_connac_get_ch_power(phy, &chan,
 							     tx_power);
 			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
 
-			mt76_get_rate_power_limits(phy, &chan, limits,
-						   sar_power);
+			max_power = mt76_get_rate_power_limits(phy, &chan, limits,
+							       sar_power);
+
+			if (phy->chandef.chan &&
+			    phy->chandef.chan->hw_value == ch_list[idx] &&
+			    phy->chandef.chan->band == band)
+				mt76_connac_set_txpower_cur(phy, max_power);
 
 			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
 			sku_tlbv.channel = ch_list[idx];
-- 
2.43.0


