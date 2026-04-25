Return-Path: <linux-wireless+bounces-35315-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNe5JGMb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35315-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7F467953
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCF8A300373F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D7303C83;
	Sat, 25 Apr 2026 19:51:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7D3043DB
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146717; cv=none; b=XGlvKjyzS0N33iFjaU8Gt+5QmiaKzhTqzDVtZT2fGxYN/d63VID21J8DC6XnueqXsPXQZGsuByjKpV0+TKVJnpYURus/WvBbTfgmVCoHBSBPTrxYtxsys9h7uCVzJsD7wRU4wKsPe8gsSlujgoxvm6cGfNNbJJFdKBWJFf6EaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146717; c=relaxed/simple;
	bh=Tigvbo3LdCz4cnOlhT5dEP8dPxQY3Kp/RqlLP8ldrOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GegrRK48U2+eXHMxVVu9loXBx4IY8JodEQ/dDD8AuKMmcW+cLcGwSdtfJiXG3F+uAcyVYyPGz7Z2vxF6vcOy6gc3/dpZiq9RMBdE1ziyp7jiuKVAn84gNbZcCccpWRwtuAzdFZ7iYQ6LRK4GoAO+HwtvpbOtSbZsksI44pACxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbd23bc684so5013389a34.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146715; x=1777751515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+f7hrp6zawtRyS6qyle7M+HDDLHBwXS9lZz+C1x6Y0=;
        b=dqbl18W/fqxjD1+zf8DBaeWjeOsBpCfcesnqLiztG2tAKMKMllDtiIBoSGKzdg9mTU
         2YZ6zq09qkNlG5lyoh5h0dwrHddgGk9OHmZogaQNYa3lzLJF0vOu7zSYFUgYzS4opYdH
         OFJV/0s7FSvAzjhn+PmTozFsD6LA3U7jw66EkFAcC5aJekx+zimg4TKVZ3WnOcwgl72Y
         Zfj+W27K5OQM98Pp8QtTVYhLQxFgRqysUS5CbmiPj17R/ZHigdVA0VBbspr1t2Wq4hgh
         x2B32VFELleI+Xi54+72PqvnaLaphhNUhl5XmETHxB9x6kHIYiPI6Oju5H/XZNf0z4bg
         6ekw==
X-Gm-Message-State: AOJu0YwILbwe5CXh+ncNsEm9AzO0aC/Zis3l3WlQcXDETXtFHP8EuRTs
	BwtihmD1Ua83Mu7HxnoD0N7HSDJKsa2xrzlzapiODKplSBEh03YnMLdm
X-Gm-Gg: AeBDieth7AemtndTeF84gnmqPrvKKAa8/7NVcjrzeRuQY47KGfelLMTVCKmRq4ONM2k
	aneY32jBozuu74RiEOH+wlOkmvKF76q4quuuKhzYl1oFizg7WzxxqsXCfY2k3r0NXc+9w1+uIBA
	+aF6RZDaeMOT/gAWYUPI8028h+2sayDvPhiRZqS/cDx4l5olFBCoESk/BqoW7KGhqBKWBsu5m88
	TXo9JtMoaAozmuKWQcSd6JPDOhFfJ5SmAOVqPHQNA5RBo6h/lH86k5/n7Zdy517ipxvkm1+7oyr
	TjtF+3pI/duP44mDWK3U4wO8gBj8y2w27xA9EossefWAfsa2hptiLtlwmJr4p80dPs4KZcYdnK4
	euBL8I5yEytK/UrYjUHuh5HkmrE+js/eTDiD4tO/n2qRqUGFKBv5bvrtahH40bCZYF8Fm/a1CXN
	I5uwMjMt618PVxZQq2oUW8ILqdqIE81974CdPtcDzPDtNsZV0CvvWkoRIpxcB0P1uMraSgFYbC9
	g==
X-Received: by 2002:a05:6830:67ec:b0:7dd:e032:3cdf with SMTP id 46e09a7af769-7dde03240f4mr10407359a34.19.1777146714794;
        Sat, 25 Apr 2026 12:51:54 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:54 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 18/21] wifi: mt76: mt7925: add MBMC event handling
Date: Sat, 25 Apr 2026 14:50:08 -0500
Message-ID: <20260425195011.790265-19-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: CFB7F467953
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35315-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Handle MBMC unsolicited events from firmware to report the current MBMC
state. This helps validate MT7927 band setup.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 31 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  3 +-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4691b9b5e2be..6d0429f40b0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1069,6 +1069,7 @@ enum {
 	MCU_UNI_EVENT_SCAN_DONE = 0x0e,
 	MCU_UNI_EVENT_RDD_REPORT = 0x11,
 	MCU_UNI_EVENT_ROC = 0x27,
+	MCU_UNI_EVENT_MBMC = 0x28,
 	MCU_UNI_EVENT_TX_DONE = 0x2d,
 	MCU_UNI_EVENT_THERMAL = 0x35,
 	MCU_UNI_EVENT_RSSI_MONITOR = 0x41,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index f7e14cc53dac..4a06f0a1ce03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -566,6 +566,34 @@ mt7925_mcu_uni_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7925_mcu_handle_mbmc_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mbmc_conf_tlv *tlv;
+	u32 tlv_len;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	tlv_len = skb->len;
+	tlv = (struct mbmc_conf_tlv *)skb->data;
+
+	while (tlv_len >= sizeof(*tlv) &&
+	       le16_to_cpu(tlv->len) >= sizeof(*tlv) &&
+	       le16_to_cpu(tlv->len) <= tlv_len) {
+		u16 tag = le16_to_cpu(tlv->tag);
+
+		if (tag == UNI_MBMC_SETTING || tag == UNI_MBMC_NO_RESP_SETTING) {
+			dev_dbg(dev->mt76.dev,
+				"MBMC event: tag=%u mbmc_en=%u\n",
+				tag, tlv->mbmc_en);
+			break;
+		}
+
+		tlv_len -= le16_to_cpu(tlv->len);
+		tlv = (struct mbmc_conf_tlv *)
+			((u8 *)tlv + le16_to_cpu(tlv->len));
+	}
+}
+
 static void
 mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 				    struct sk_buff *skb)
@@ -584,6 +612,9 @@ mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 	case MCU_UNI_EVENT_ROC:
 		mt7925_mcu_uni_roc_event(dev, skb);
 		break;
+	case MCU_UNI_EVENT_MBMC:
+		mt7925_mcu_handle_mbmc_event(dev, skb);
+		break;
 	case MCU_UNI_EVENT_SCAN_DONE:
 		mt7925_mcu_scan_event(dev, skb);
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 56e2772f3ffe..293f173b23dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -143,7 +143,8 @@ enum {
 };
 
 enum {
-	UNI_MBMC_SETTING,
+	UNI_MBMC_SETTING = 0,
+	UNI_MBMC_NO_RESP_SETTING = 1,
 };
 
 enum {
-- 
2.43.0


