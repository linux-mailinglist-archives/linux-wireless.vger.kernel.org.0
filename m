Return-Path: <linux-wireless+bounces-35309-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNptA0cb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35309-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A01FB467928
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 114B430039B4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE553309EFC;
	Sat, 25 Apr 2026 19:51:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9A303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146692; cv=none; b=F3PcW3n1AIZYdfKMqo68i9rlhuj5pTo1uiD/aNh8nx8TUT67cB2jdB4m9FTrw3Pzb7Z8hnrJJSvQpZ8yxAuZvoT+/bnEjsmaP+oZ3ZPeP6qi4esb3PIJf1lQ1nY9G1MRbBDh32gUsc9XlHSkGtvTSxfVd28DyfHy74pIbtPDhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146692; c=relaxed/simple;
	bh=1MK8OG3UlN8jP/gWZnmcVyk6XiGojZxoZf/ycKreK5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6Y0CvwwNd+wFzp6vX8eMo0eiiNzxqnl5YFJJxiaWtHnRZHCBavk2Aw6tItoTxJ/mlDqVleYNMLncUG6U2qWDSGCOe5zqoNIe3L/PzQhLmC5zl1zBzj4oS7c3RvsVejwFguMPpTM+kQASR9efgywfRVwHhlvDKoLAfbEiWSZI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de4e6c5a30so2048867a34.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146690; x=1777751490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nn0IDzT+W9CDGbojhoLfTqkBiBGELCUWb519tH5lz+U=;
        b=UKeYdg/vfPkAps1uetzyGUw43FPgVKD974p63OARFxO7OGiu6qBO/IVJjj4JCXDrKw
         /q5s8aFIwqu0DXMF9gSG/qIbrQnic6vEVM2CP8P6cmqQEzxeBnSw1zQeV9T2IahX8uI3
         uFFBDNXXTjrZt/81KWzZNC7z86Mzk+8U/VpOiyeCRkvMxSzpCiDU1mIkeTs9KivTa6w/
         6P0NFRit+7ts8IqB2aB7QHqJI2IlXj+ZzYyWbZYpvJFaBy7EtHmr0YovNBcYU6Q8IF2r
         RsWE8J6I5vFxIbC72anslR7ZQIrC4C9UJPLoWSlcuRgE/vAlj9CYYFcNNyZEYCnxvt4o
         VZiw==
X-Gm-Message-State: AOJu0YxdPAQCeocO08AtkuqMiuqnnaI0pPvqWvPHsYfab63QfV5pijex
	gcYeOAmpJC1IV+ehMPWYGdTLx3e8d0G4CUDe12d7Ik61BLY/N+408fGI
X-Gm-Gg: AeBDiesVH5bhn/REFab+8H92m8q505gjYV7yEH03lAVsn+UBGNX7Q6+ZoNkusegCx3X
	k/ja2zH5B5PXG6jNtBOoDEvRAHTv5r3mGdD0ROzkzNVA7jFkUsYza+7U+eGstaUHIDO2Ssox6VG
	IewIpry3X+/J0zja0cQxLVadNoPM+HqOxFopZB2MG19Hq6Ewf0cLpXNPPMX8LbRmdmsxk6f9qrn
	xoL8fsRPAi+C/Eo+Be9gC0AYbS/fjwObfvPepfbMIe4u2jULrR5LUlvhw1CinYX6lAHwU01LK6S
	LGpRGWUlRdXA61QuBqSP0ubt9Yg9Gq8GzY/i3/kIPPE9DPrln2K1r3gdzTl5KlS+2/NxMgBC9gu
	QCqfFA1MQwnOAEL9QR92oJSljrdvU1Ix6ExOJyfqka1CSWqSuGtSRqlrLWJy19vQk5c1mWworsI
	QtOea688jN1ql2zJzpapoiYvnA18WdjkHkYstkEnjxDBWWWvyotHpGf3JjkX8aoe37LjdQS0Fp0
	w==
X-Received: by 2002:a05:6830:4c12:b0:7dc:cefa:1c37 with SMTP id 46e09a7af769-7dccefa1e5dmr11880631a34.23.1777146690330;
        Sat, 25 Apr 2026 12:51:30 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:28 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 12/21] wifi: mt76: connac: tolerate inactive BSS deactivation
Date: Sat, 25 Apr 2026 14:50:02 -0500
Message-ID: <20260425195011.790265-13-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: A01FB467928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35309-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Firmware may return wlan_failure when deactivating a BSS that is already
inactive. This is a valid teardown case and should not fail the remove
path.

Keep activation failures unchanged since they still indicate that firmware
failed to create or activate the BSS state.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  9 +++++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 23 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  6 +++--
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 2b1c887d6709..0f2d580c7b4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1227,6 +1227,9 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	len = enable ? sizeof(dev_req) : sizeof(basic_req);
 
 	err = mt76_mcu_send_msg(dev, cmd, data, len, true);
+	if (err && cmd == MCU_UNI_CMD(BSS_INFO_UPDATE))
+		err = mt76_connac_mcu_bss_deact_err(dev, err, enable);
+
 	if (err < 0)
 		return err;
 
@@ -1234,7 +1237,11 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	data = enable ? (void *)&basic_req : (void *)&dev_req;
 	len = enable ? sizeof(basic_req) : sizeof(dev_req);
 
-	return mt76_mcu_send_msg(dev, cmd, data, len, true);
+	err = mt76_mcu_send_msg(dev, cmd, data, len, true);
+	if (err && cmd == MCU_UNI_CMD(BSS_INFO_UPDATE))
+		err = mt76_connac_mcu_bss_deact_err(dev, err, enable);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 552cb94edaa0..4691b9b5e2be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1906,6 +1906,29 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	}
 }
 
+#define MT76_CONNAC_MCU_STATUS_WLAN_FAILURE	0xc0000001
+
+static inline int
+mt76_connac_mcu_bss_deact_err(struct mt76_dev *mdev, int err, bool enable)
+{
+	if (err != (int)MT76_CONNAC_MCU_STATUS_WLAN_FAILURE)
+		return err;
+
+	/* Ignore wlan_failure state false alarm when deactivating an
+	 * inactive network. It does not harm the firmware state.
+	 */
+	if (!enable) {
+		dev_dbg(mdev->dev,
+			"ignore wlan_failure when bss is deactivated\n");
+		return 0;
+	}
+
+	dev_warn(mdev->dev,
+		 "wlan_failure when bss is activated\n");
+
+	return err;
+}
+
 struct sk_buff *
 __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 				struct mt76_wcid *wcid, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index f403d9d925e3..b338d6bf02f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2832,6 +2832,7 @@ int mt7925_mcu_add_bss_info_sta(struct mt792x_phy *phy,
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
+	int err;
 
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
@@ -2857,8 +2858,9 @@ int mt7925_mcu_add_bss_info_sta(struct mt792x_phy *phy,
 		mt7925_mcu_bss_mbssid_tlv(skb, link_conf, enable);
 	}
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+	return mt76_connac_mcu_bss_deact_err(&dev->mt76, err, enable);
 }
 
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
-- 
2.43.0


