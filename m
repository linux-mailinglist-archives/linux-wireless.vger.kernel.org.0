Return-Path: <linux-wireless+bounces-35307-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFi9L0Ib7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35307-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B1467921
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8305130138BD
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F630595B;
	Sat, 25 Apr 2026 19:51:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF98303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146685; cv=none; b=YRqjy3hXQ6fwPBbq68x/M4x5Poi4XKjBhz0raTev0gaRcI8xJPkQRgvbOvcfuT6jhGF4voLsYDjPwaqzGXAQoVzxGkVTZFqCZ6RG+j31I49SvbLbW24O52KlJSxyFh7r/q422YmOTDKj+Ur/4vjB/IV5m1jpSnAW89GiB95+ZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146685; c=relaxed/simple;
	bh=b621fLrUqZ2uj/lyONIbQlqh1T7CJknCwIMmXS8evfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfctWKvcTYkWaihFU1S0dAXA1Hsg5Zj9R7AzAhSXLMsEDjFA1QswRtAKbN2jxVizRUs4W/131OvMjTVX8KeOkU5Tz2NbKHyliwVNhhpBhBNbciVn5wifFxDSjXsFSsEX3h5xefXqOpVrtvNlshzKoF8Okv4/UwHX0VWTLAfI1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbd23bc684so5013245a34.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146683; x=1777751483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUG8ggOsQ0rrnBThrPNo+HKNnFOqSCMI0C+rNZSf4UI=;
        b=VQp69meHwGMEM8F6f/4PncDDZvdZ02CbqYAMnifSZDjbCalfdrweU4owprCynOD62I
         qHGt+kOMXnH+tLDR9DPJjsxfagBfxZwFpHK1Hwe2SDFa41lcQr37VcHXiIzBkQlFQBH4
         mttKBogOZqTudMS40VWAK6c1uOmpg6feF23ZIDuEXjjh/YvxixHDlmRs5aa2aujCV0Hj
         4nnRyHPm/NvacM8M6A/zgigpKNauf3B5PCiGGYLurmp/+zABzBsEjF2MHPQsAdZvdlHa
         /0wPlCBJzrC00R2XAsE3XxuP+4kO3HFA0Jc/9hBXSWdmoNKC/wZ8HSVMVxJtGw8YJ8FD
         3u2g==
X-Gm-Message-State: AOJu0YzwJJi72qNt9kDFoNpqwkPbd99cPTMAvI9ZamqdePxRDUsc6rBi
	Jjgvz9Mdcksx3UCjPhQra9Ao6jcA+Ljzk9KpcxKfJsgGCkSLrzUeHiR7kOPYAw==
X-Gm-Gg: AeBDiesCweCA/m8pfd6KxXKsVYq8pFZ+D0kITxFvb01i3Ojwd4H9DNJL6IHTtO5A5OB
	bjqW21s+0HGWHAJlHug1oaw7XJwcwfzYBWlJnsHs3avPpdIJIw/JrPlaWxfb39q1bxcNXaJ9WAr
	g/yrMZ5UYRONsY/FwZlEUxP6Y0IOZDv191iPCzrsCY+KkJmWCA3OdN9QS11k5VF4AdBauh+AsJ3
	9BiR1PDhp0sfe/KbH6tEmzn8Ve1cu19YrjDbRdHa3UyvrvW6D7qaOMXFwXFd3gDhc9nToFhOQKa
	T5Bg/E7QTJwxt1N+yjhTtVhw9xpX0mr7rKBHaIe5xCimPXKpa9y9WjOABktk/MqcNnxotHgO0wW
	xUP03JI/xcwNIcB1o+1Ge/lV7Cmhga05Rk5HcvZRetaNfShB4+gYp5KoVseskmj2Qo9FtOAHhw5
	htTlro3yHcm3E0sFJIHTyeAYEJPIpNI8bmVYaqnXzNo/9vtInhkudjDBjCWmcs3dPP8angaZQhI
	m4iwkpdMRWn
X-Received: by 2002:a05:6830:6acc:b0:7d7:4a7d:fd40 with SMTP id 46e09a7af769-7dc9525302amr21505453a34.22.1777146682918;
        Sat, 25 Apr 2026 12:51:22 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:22 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 10/21] wifi: mt76: connac: replace is_mt7925() with is_connac3()
Date: Sat, 25 Apr 2026 14:50:00 -0500
Message-ID: <20260425195011.790265-11-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 831B1467921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35307-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Use is_connac3() instead of is_mt7925() to avoid confusion
when more chips join.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c      | 2 +-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 45479cc29134..1994863dc59d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -172,11 +172,16 @@ struct mt76_connac_tx_free {
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
-static inline bool is_mt7925(struct mt76_dev *dev)
+static inline bool is_connac3(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7925 || mt76_chip(dev) == 0x7927;
 }
 
+static inline bool is_mt7925(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7925;
+}
+
 static inline bool is_mt7927(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7927;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0339e2e7ab60..c341595e9138 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -173,7 +173,7 @@ void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 
 	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
 
-	if (is_mt7663(dev) || is_connac2(dev) || is_mt7925(dev))
+	if (is_mt7663(dev) || is_connac2(dev) || is_connac3(dev))
 		last_mask = MT_TXD_LEN_LAST;
 	else
 		last_mask = MT_TXD_LEN_AMSDU_LAST |
@@ -217,7 +217,7 @@ mt76_connac_txp_skb_unmap_hw(struct mt76_dev *dev,
 	u32 last_mask;
 	int i;
 
-	if (is_mt7663(dev) || is_connac2(dev) || is_mt7925(dev))
+	if (is_mt7663(dev) || is_connac2(dev) || is_connac3(dev))
 		last_mask = MT_TXD_LEN_LAST;
 	else
 		last_mask = MT_TXD_LEN_MSDU_LAST;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 89bd52ea8bf7..2b1c887d6709 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -67,7 +67,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
 	    (is_connac2(dev) && addr == 0x900000) ||
-	    (is_mt7925(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
+	    (is_connac3(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
 	    (is_mt799x(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
 	else
@@ -3084,7 +3084,7 @@ static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
 {
 	u32 mode = DL_MODE_NEED_RSP;
 
-	if ((!is_connac2(dev) && !is_mt7925(dev)) || info == PATCH_SEC_NOT_SUPPORT)
+	if ((!is_connac2(dev) && !is_connac3(dev)) || info == PATCH_SEC_NOT_SUPPORT)
 		return mode;
 
 	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ac5126ab68ff..552cb94edaa0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1878,7 +1878,7 @@ mt76_connac_mcu_gen_dl_mode(struct mt76_dev *dev, u8 feature_set, bool is_wa)
 
 	ret |= feature_set & FW_FEATURE_SET_ENCRYPT ?
 	       DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV : 0;
-	if (is_connac2(dev) || is_mt7925(dev))
+	if (is_connac2(dev) || is_connac3(dev))
 		ret |= feature_set & FW_FEATURE_ENCRY_MODE ?
 		       DL_CONFIG_ENCRY_MODE_SEL : 0;
 	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 47827d1c5ccb..7bb9840112ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -263,7 +263,7 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
-	const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
+	const struct mt792xu_wfsys_desc *desc = is_connac3(&dev->mt76) ?
 						&mt7925_wfsys_desc :
 						&mt7921_wfsys_desc;
 	u32 val;
-- 
2.43.0


