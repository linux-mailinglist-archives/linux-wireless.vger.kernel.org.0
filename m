Return-Path: <linux-wireless+bounces-37826-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPFmNz9tMGq+SwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37826-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 23:23:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD168A287
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 23:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37826-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37826-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAC6303FFBF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 21:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612D30DED1;
	Mon, 15 Jun 2026 21:23:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7930C371
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 21:23:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558589; cv=none; b=XXygYnIQ83Sjp5onYdsN89JJA2kaOlvWT5zq7crpwfjyA+ypOY3UPabCuWg1Cv+h86xgmDEqSQZiSGAn+8sXLWJORRDdpM0/MwkvU6/ZCBKwihXasrzJHWwEUdmpime1diFptxCytBlme1CohabW2aMrbjuoJ5sW25tUiVrKMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558589; c=relaxed/simple;
	bh=9pMO4GtdgNGDmqs9Cb5uL7+i9+5SXR4DhWQn/w+/3Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rj5gdrzpPrTfeeEIA/MPXF01Ex3Jr4HYfa0iQvbd3db4CHQ8EIx+j7sQKUiSTbZhOcBd02gDS8zT1MA3atB7uU8zN9DAU+r01gNt3xecJrNmP/GY8eENRtc0VhsYMUuLe+h22X0oibD55daF4SRDWffrbXjmDKQyhvbkcFAcl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1384eb94d20so6658367c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 14:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781558587; x=1782163387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl07pJdd/VP/07cwVNdl98nwOZmJlI+5GvXpYGmCuNw=;
        b=R3yiZPKgLCDhm8dGgdWKxnwHcpiVmgVtPRnW3GOTOI7P/QX8ytGw2rWcxskHdmeyGU
         q36y5neeRJutsp1x9wZxo9ROCrB/Q7HX92mE4XfznizYNrREpdWclT3AOdqpC+JSgsie
         7Ad8u5mAfpQHxTYya2yoR1N5GFkOt0QEagAR0c2abd/VG52yHMVtiZ/+RX2HHRbu5oYI
         CM0SC1gzuZpXfh3g1t2EF2eU5qc/g8FiJGh1j8V45nzV7Q83drmzdnMG4/vzdAZz+0TD
         tHHDL4unON4pU7i+4PtNPUWQTxAWUAUiQkkQjRVqgwnyecRzQW+v1AbQeePaCCwQ3v8c
         Z5Dw==
X-Gm-Message-State: AOJu0YwIpWV21CF3ubQC+pJx9v0TTdK1fPYcpt402hP632Ln1tvpqe2h
	BRvy53rcozi3I5qOaY36iSD3a345vndYnv76b00GbyWXpMWSrTbOJPtu
X-Gm-Gg: Acq92OH5uHGx+jJmXJHuYEVHl2nfw223jyQ6zFphqM39fiZ+wjTtVL+Oeb75S4FUKFg
	73i4Lsb4OvCKV7+lmZvcMeulsASMKRVewmH6dmjpz06JVQuAeZyKOZ64osClpeGdBvpTqDA6YCt
	vRaArCRpPe3X4RZk+hOgu2NYIsR1dkNWTiQVt9jdsoabs0Y2egyBGB922YhjwPkF1PnWTyQD2zq
	RGtwmcRmn2Sjfs61gINqXoDu6xr3vHSFoHdi6zOd/ia4Nazy1vpLD4chWfnNk3uTpBSoXLsjtPk
	3Dlv1eiwX8TNEAOJkGyP9b/Knq89kUjxkcVhBRHpvd1/oX5ZgNmQ0L5t32qylKl+YbgucqJW5c6
	PphV1xYi5o5WD5o+FfI/peR5MVyISDIOUrAofYm1luMpzf3F3c7RM5YQYiR3tKcfn36sj4yJLGW
	37ntDgqV9cTyh8Rixe+ncHPboiKdsm7O9GvghvCNXdS7wK2Y/tQAqfv6H1uTOeu341wInyz/gGi
	xBS+h5JIDGE8VnG/gTm49bVK2X5AjcBNPwJPpKG
X-Received: by 2002:a05:7301:5f81:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-3092dce2af1mr6771639eec.0.1781558586859;
        Mon, 15 Jun 2026 14:23:06 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e489621sm16220982eec.6.2026.06.15.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 14:23:06 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Stella Liu <yu-ching.liu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: support new WoW pattern TLV
Date: Mon, 15 Jun 2026 16:21:37 -0500
Message-ID: <20260615212137.477893-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,m:yu-ching.liu@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37826-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31AD168A287

From: Sean Wang <sean.wang@mediatek.com>

Newer mt7925 firmware uses a shorter WoW pattern TLV with rsv[3]. Select
the v2 layout based on the firmware build date, while keeping the old
layout for older firmware.

This also makes the WoW pattern handling compatible with newer devices
such as MT7928.

Tested-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 30 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  3 ++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 17bc7204f02a..32297f4a5e0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -10,6 +10,24 @@
 
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
+#define MT7925_WOW_PATTERN_NEW_FW_DATE	"20260414153105"
+
+static bool mt7925_mcu_wow_pattern_old_tlv(struct mt76_dev *dev)
+{
+	const char *fw_version = dev->hw->wiphy->fw_version;
+	const char *build_date = strrchr(fw_version, '-');
+
+	if (!is_mt7925(dev))
+		return false;
+
+	if (!build_date)
+		return false;
+
+	build_date++;
+
+	return strncmp(build_date, MT7925_WOW_PATTERN_NEW_FW_DATE,
+		       strlen(MT7925_WOW_PATTERN_NEW_FW_DATE)) < 0;
+}
 
 int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
@@ -219,6 +237,8 @@ mt7925_mcu_set_wow_pattern(struct mt76_dev *dev,
 	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7925_wow_pattern_tlv *tlv;
 	struct sk_buff *skb;
+	int tlv_len;
+	bool old_tlv;
 	struct {
 		u8 bss_idx;
 		u8 pad[3];
@@ -226,14 +246,18 @@ mt7925_mcu_set_wow_pattern(struct mt76_dev *dev,
 		.bss_idx = mvif->idx,
 	};
 
-	skb = mt76_mcu_msg_alloc(dev, NULL, sizeof(hdr) + sizeof(*tlv));
+	old_tlv = mt7925_mcu_wow_pattern_old_tlv(dev);
+	tlv_len = old_tlv ? sizeof(struct mt7925_wow_pattern_tlv) :
+			    MT7925_WOW_PATTERN_TLV_V2_SIZE;
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, sizeof(hdr) + tlv_len);
 	if (!skb)
 		return -ENOMEM;
 
 	skb_put_data(skb, &hdr, sizeof(hdr));
-	tlv = (struct mt7925_wow_pattern_tlv *)skb_put(skb, sizeof(*tlv));
+	tlv = (struct mt7925_wow_pattern_tlv *)skb_put_zero(skb, tlv_len);
 	tlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
-	tlv->len = cpu_to_le16(sizeof(*tlv));
+	tlv->len = cpu_to_le16(tlv_len);
 	tlv->bss_idx = 0xF;
 	tlv->data_len = pattern->pattern_len;
 	tlv->enable = enable;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 293f173b23dd..26e9d90ad503 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -587,6 +587,9 @@ struct mt7925_wow_pattern_tlv {
 	u8 rsv[4];
 };
 
+#define MT7925_WOW_PATTERN_TLV_V2_SIZE	\
+	(offsetof(struct mt7925_wow_pattern_tlv, rsv) + 3)
+
 struct roc_acquire_tlv {
 	__le16 tag;
 	__le16 len;
-- 
2.43.0


