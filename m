Return-Path: <linux-wireless+bounces-33803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJhrEetlw2nFqgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:34:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C131FB0D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24273019041
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249E301486;
	Wed, 25 Mar 2026 04:33:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0B26A0C7
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413211; cv=none; b=alKRjEQdizda3oto5aJbapl/1nmFQrR/llvZJ7ciozT0vHGrF/Fp94iWiU68gG+KQ6KadPCYsf7307yf6SefcofrmXAB/zwV+nJk9tZCQHVEeQHc4FiGchpOUwy1e6fInyY2yQAfCGoK/4Ju/qYI7agsWduw0FapZIeEbo4Z87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413211; c=relaxed/simple;
	bh=epvWZ/qzAOYk4YtcSYYc1lChJNS4yAVg0WY4crReVJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qr87LEgVjOuCFzDeb3VVaQJvR6ZQIKvO9l0FQIFwI4DyFOa8lPMIEGZHNbMcsclNM69GVeT7e+rhgfJ+80CPpiEinB/uKWG5QVA+W1LtJWMF0LhiWIIh8T6wOZVvkTcWlHMmL2mayQHmPw/6g2OpBgOo2MBQfDoQ55VvBMGUqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a3e2e64f4so15871857b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774413209; x=1775018009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2obK+0//qjZWU2JZcp5VyDPc6Q6QS5+BiBkfTjrf2jM=;
        b=SDqPs0eolYPhM0CxtQlOsVYT1j7fpo0aPN5i3H1SFF7o4pcMpN+NAyEvmqJjQajMU8
         f5yYr+RgAi74MajmcyYj32zYzSl0014EZq7aLk+plDCPmZP+EA+9v437gni6kDYit7D8
         Ryyz5KsBHU3uvrfEELZEmpjyAizgEO8bz5AeujrdfMS1kR+IDrXSYJJ9IjAo6n2AZAeb
         DVgSpoBtj5BbCfK1APAlyAr90acLDRcntoZH8GbPElAomZpM0oziZUU08xatiuUFno4y
         P0/LaihJzjh9mE9fgBQuDxVrfaaXsGEo7PirOG/gQ/wjBBkJwtwFIJ7kAZHp5GCUgqIg
         c4VA==
X-Gm-Message-State: AOJu0Yy2hs+OayITuPd8x0uN02/GpxQKbGgJr4ZNk+kfiWI5ntDBOt5g
	Vz2JEMcYj4Q38PZgBtS9G2XgBhEtgVt4z2B54qiE3qpYra+yWza+s+ag
X-Gm-Gg: ATEYQzwfJEIuJ7C4DInjTAnyfp+RoLg90BjR2eoiuKrfiZbhAlJ8NB8cBI79Gnq/HeF
	3eiRWnJmLxcs3jkjIb4TWSnbkrCG64xHIXZoYbLRsCDf0Ck0j81hTaLHuZN8JwfpR8PD+ceRcSr
	lNmG5UPS5W7J/OSCJPb8lzgtQ4LPJSP1ZIAGqsdsK3Th3VzlGHL4dIxfy0E5LjaDIfMVlhJhUeQ
	F8OFNuZ5oVJjItgixeIKBpV6PTeS7CC6F10Sc1/SRA5/KcnliY2bhGMu1GLUlANZpXUZ/67m7JM
	CwvpvpBs5kcFp6j9ilV/3o4aCn4v3lZRfVtEvwfn6O49kXFQgrgPM+u8ktQJhapwu1V1C29DdLo
	xucUO0ueRaYj117e2byN+wRci1E7uI/H+pYyj1ylNZWi3v5rR6tAgZjVlISEwgQfwEyWh/7oGCk
	9p20xdnWQbtqloT6DyZZdJ6N5gFyK985DpQL9fjXR5cPA03NKr6C/4MAqdq53vJwSCSPZfiPpYy
	A==
X-Received: by 2002:a05:690c:4a10:b0:79a:b118:4386 with SMTP id 00721157ae682-79acf728b0dmr20936267b3.48.1774413204969;
        Tue, 24 Mar 2026 21:33:24 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:3916:ec63:baa5:b5f0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903e0b8csm82707977b3.12.2026.03.24.21.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:33:23 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
Date: Tue, 24 Mar 2026 23:33:16 -0500
Message-ID: <20260325043318.13298-1-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33803-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sku_tlbv.channel:url,mediatek.com:email]
X-Rspamd-Queue-Id: 986C131FB0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

The cached txpower value is derived from the bounded channel power after
applying the chainmask path delta.

Use a helper for that conversion so callers do not open-code it.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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


