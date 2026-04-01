Return-Path: <linux-wireless+bounces-34283-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BpSL69izWmMcwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34283-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 20:23:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869637F3B6
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 20:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0157D302D096
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EB3264CE;
	Wed,  1 Apr 2026 18:23:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED72E0413
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067821; cv=none; b=kjvwAa2Xszi9OcfwF5pq+W/LtIQAiOIsUWosOa1yzLDM8ja9ahxBLfZ62onwaWsaSN+UNDQfJUXQQmc5GVWy8HeN3sWvJUc5nDb/HssU0LIGc8My5ZjiDdVlb3YRSp0fxfM9JIOGSgL4qaWDYTZ9C6LVeup4JXUXRcJXlxd5W4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067821; c=relaxed/simple;
	bh=AGNEhDAOdO1/MKvSBYbhcMbSmHF2DqwykbcTVHldLDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcE6zEi4pAWJQpaXcDrpXzhFaKBvSA2ga0m0y8SkCoVhrSjIiJtW8UXKtENhPhgfJ046KU2raKFRNhqwWTYniE17OX3medgW+fKvHdlAf/JEvMCTv9J9ODT8gDmlBy9lpo/r5aYsVpX39JR13otuPSvOWIoqnAvYicIn77MgNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40efc77933fso43037fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 11:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067818; x=1775672618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fFwAsGzOmBHffBxJWkSRpHG2Hwbi2J13ykcPgyMD9uk=;
        b=UJ1SDdSkDxvwy7oZcNcSEzvCmTm0Z2xztXz9w+Rv9wfZbYZuJwO5JfQXj5FRZrRkag
         PCaDjtM+MeUv08ZUevoX6AfZYtsbZ6DphY5uOP15bYNUp9T1HOo8K7C109sdv7MpFpHF
         bwaVVDSMgNxDIma2ayLPDtXYUiaBU/2dXIdBlTabH4+FPtuR0yHkGmyEM+qBw0p1mM07
         +Uv3/beNQi4PDWTvG0W+mC9YoU2oitHzLgoi+aOKu8pYwe3VRm7WrCuuCa3ajoo1HTJO
         eZ/keIn9MeRZ/NhTk/rUPB+UP7LTAF29mnq1Mns0Zp7d6qYYdD5ysEVgk/dc/y3r1p3B
         h6ng==
X-Gm-Message-State: AOJu0Ywajh667f05MDoFKPZZ86QUb7/2G6PhlKIgFTxj+IV+jZWm1p5l
	ji51lRkoI3QRRllvpLnkiw3kcsO1q6s7HngpKNnZQZ0/gu/Sayz2l2Y5
X-Gm-Gg: ATEYQzx+AT7+hDQqAMyKuKsdgPHmoubPcNmdVZwO0MP03uif53n7HMCIPMEhdpMTCP4
	ubH9n2HwjEsW2CHbYRLTRjihIv6F7gIXWiZDcvZdq+aMmj5XFby8+g1rx7MQIxgCj0n/WzqveXr
	ajdcQSvegvZ05TQSEV3DPtmA8ifCwNqcteMtNSbAKZtVjMkeX6TNY5bXJHqHW3PnFctrr3YQYDd
	RwobfUH9HHK4T8zbEhAY3bb1nJWQ8SroPpgHGny/BeZs4ph0hCbFZWQqyuLEe92R+tIrj9+bY7M
	TKeRqbc5ZdnlIvNMVEuRCUMw6Ef4QzO4KEI2ZyKNK9BriUftenlVmk8CK7yZgtxJRzeoy7y/nt/
	K0stnAvK4kWbEgSF1JzBnhH2NKGwGra2Vgzd9yfjIrXswZygYGThL4pDyf+Uy1wg/hUpVtv3AlG
	f34MiASR9fPGU6W6g1bMIRNF3vOCD2N5DKlw0HFZ5PEFJ0p+QryQ0Cv96FXg==
X-Received: by 2002:a05:6870:2012:b0:417:5b7a:704b with SMTP id 586e51a60fabf-422cfec06abmr2923345fac.31.1775067818559;
        Wed, 01 Apr 2026 11:23:38 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c9e06sm386778fac.15.2026.04.01.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:23:38 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Devin Wittmayer <lucid_duck@justthetip.ca>,
	Satadru Pramanik <satadru@gmail.com>
Subject: [PATCH v2 2/3] wifi: mt76: connac: factor out rate power limit calculation
Date: Wed,  1 Apr 2026 13:23:21 -0500
Message-ID: <20260401182322.64355-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401182322.64355-1-sean.wang@kernel.org>
References: <20260401182322.64355-1-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mediatek.com,justthetip.ca,gmail.com];
	TAGGED_FROM(0.00)[bounces-34283-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.647];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3869637F3B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

Factor out the per-channel rate power limit calculation into a shared
helper.

This avoids duplicating the same regulatory, SAR and rate-limit logic in
multiple paths.

Reported-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Closes: https://lore.kernel.org/linux-wireless/20260130215839.53270-1-lucid_duck@justthetip.ca/
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Tested-by: Satadru Pramanik <satadru@gmail.com>
Co-developed-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
- Rebased onto the latest mt76 tree
- Added Reported-by, Tested-by, Co-developed-by and Signed-off-by tags
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 28 +++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index d0953e02810b..1549a97873ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -421,6 +421,9 @@ void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss, enum nl80211_band band);
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 			       int ring_base, void *wed, u32 flags);
 void mt76_connac_set_txpower_cur(struct mt76_phy *phy, s8 max_power);
+s8 mt76_connac_get_rate_power_limit(struct mt76_phy *phy,
+				    struct ieee80211_channel *chan,
+				    struct mt76_power_limits *limits);
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 			      struct mt76_tx_info *tx_info,
 			      void *txp_ptr, u32 id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 897b065a2be6..1117a22c70ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2223,15 +2223,10 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
-			s8 reg_power, sar_power, max_power;
-
-			reg_power = mt76_connac_get_ch_power(phy, &chan,
-							     tx_power);
-			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
-
-			max_power = mt76_get_rate_power_limits(phy, &chan, limits,
-							       sar_power);
+			s8 max_power;
 
+			max_power = mt76_connac_get_rate_power_limit(phy, &chan,
+								     limits);
 			if (phy->chandef.chan &&
 			    phy->chandef.chan->hw_value == ch_list[idx] &&
 			    phy->chandef.chan->band == band)
@@ -2967,6 +2962,23 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_rdd_cmd);
 
+s8 mt76_connac_get_rate_power_limit(struct mt76_phy *phy,
+				    struct ieee80211_channel *chan,
+				    struct mt76_power_limits *limits)
+{
+	s8 reg_power, sar_power;
+	int tx_power;
+
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
+
+	reg_power = mt76_connac_get_ch_power(phy, chan, tx_power);
+	sar_power = mt76_get_sar_power(phy, chan, reg_power);
+	return mt76_get_rate_power_limits(phy, chan, limits, sar_power);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_rate_power_limit);
+
 static int
 mt76_connac_mcu_send_ram_firmware(struct mt76_dev *dev,
 				  const struct mt76_connac2_fw_trailer *hdr,
-- 
2.43.0


