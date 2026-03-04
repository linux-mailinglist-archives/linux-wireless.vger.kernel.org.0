Return-Path: <linux-wireless+bounces-32487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FJrAsPFqGmAxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4605209293
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5C430CE461
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE83612E0;
	Wed,  4 Mar 2026 23:51:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CF374745
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668261; cv=none; b=h+UPCe2z+m0ftky2H+b0QygJUocPu55enJAISRwyJbxCwn6gyNSUcUkLPmJGcsH1Ibf5jojwusfXj8AOQvNNqb9WPm397X9i1cMtxOrW+8VodALhsv21XORhoffakYP920Ax0gFC8iZUd6CBw6vAJCaOSUiJSesoszyy66I/gfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668261; c=relaxed/simple;
	bh=a2YKceFmBsieorgb2iv6ZsHxN9gYP0z8L1je6DSRHlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZq/lGvqqNWS0OuNjiwmip2OiDPVGUEAEv9Q6Qe4u8Foytheh9xKwHutBQRlwijQkaqso98UwcKSWmyBQqxJ2Qhh+HWm2LkyH+oIfDrTxypQ9gfxImZwy7yVzsTm/za9kq5+kbuA3DxEXnI6jVyv/HnP8qRatitj1whoMj1ocUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1959ba05cso3779066a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668258; x=1773273058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQslxQXmAlCziq3+imt8MhYq9WKREslJJ0QGMmcvOt0=;
        b=KImRjhgm2e19qcJVNTK5J8oUQbQ5KXFAjQWTYw4AaNiSvn6896Edb1wpFld7NrEiYD
         UYz1ibobo/XiJrMlb51eIk61ErHuzJLCSrp0ypGJxrCWrPcAlSKK7DUzSp7XI5kwEs+Q
         0GdowGCypuDmH+QjKGW5dDVjdMynD+DVHsDUAGPs4ErIye9RntSkl+tfzQ7PfB+u4tlX
         kxDVpwLmJ8niLDwTcLQRzOenkhF31K/S7lR7V8wDQxNHarbgn0xTZ3DPq6xgCno2NARx
         3Hkq5NXCn79JeiTcEKxSZRNTNGuypjoZ473QOvxxmNnjBQCVSvrRJH7Wqjte/NPjySN2
         o1Xg==
X-Gm-Message-State: AOJu0YzcY4rV3pgGzfQslwloMiFztCQddUjgyLhx9VP8blyKepACCdQI
	iYXNf7VCqRXlBgupwgnAaznNAjfmvZoSj/kmyDA64T9ia3uSMS5mLRU2
X-Gm-Gg: ATEYQzyEQkd45e3Yv+2nJMjXRqqxqlMMATANDTdzdpCH8igve8ppBJ0y6pLs1i2CTsd
	x/qY8pNECDxG+gPHJYb5HvpBAUMR8ltzqA+h7gHD66zMThQ9TZ/IqywoQwVnXBcVyt64eFvZnmH
	W968qUgQZqkWmlA5RCY0Vt3bPj0gOVYFRwJdfqXOloB5SItdB3bBQqHhprcFC8qU4+12TNmMoNB
	TC+O8YCGaWvTknlthtIMW6VNMqePHC1sVL+O/+T/1hPuvEWm2mxukdqw2reeOYXtAKv2omkSmpl
	HK2tHlYlkARuoFPk84n9xPFeX5FumfcwGwqmfqSB9jprqxIUmZ0Amzij1k1uJIE4z1EH7FQMpdh
	1b+XkwlUSwzUa5E4Iad8RUYMaj7CcwkNog7M7kezkl9ADVJsAklF9AryUiEdbnA/m4IUOMBdWg/
	NoSiaqdcVbyKv4bf+n9BT1kLkoHPdTYRqR/guUc1czs0m67QM=
X-Received: by 2002:a05:6820:6ac5:b0:679:c3b5:73e5 with SMTP id 006d021491bc7-67b17703d70mr2070089eaf.30.1772668258374;
        Wed, 04 Mar 2026 15:50:58 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm14410687eaf.7.2026.03.04.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:50:57 -0800 (PST)
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
Subject: [PATCH 5/7] wifi: mt76: mt7925: add NAN MCU ABI and basic cmd/event support
Date: Wed,  4 Mar 2026 17:50:18 -0600
Message-ID: <20260304235020.40451-5-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: A4605209293
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32487-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Add initial Neighbor Awareness Networking (NAN) MCU ABI definitions for
mt7925 and implement basic NAN control commands.

This introduces NAN command TLVs for enable/disable/configure, plus
event parsing for NAN discovery engine indications. The new code also
adds helper logic for configuring DW interval, cluster ID, RSSI
thresholds and social channel scan parameters.

This change only adds the firmware-facing ABI and command/event
plumbing; it does not yet adapt or expose NAN functionality to upper
layers (cfg80211/mac80211) in mt76. Upper-layer integration will follow
in subsequent patches.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   2 +
 .../wireless/mediatek/mt76/mt7925/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7925/nan.c   | 386 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/nan.h   | 200 +++++++++
 .../net/wireless/mediatek/mt76/mt7925/regd.c  |  30 ++
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |   3 +
 7 files changed, 627 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/nan.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/nan.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 11986e164a38..ca29e015d1ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1075,6 +1075,7 @@ enum {
 	MCU_UNI_EVENT_THERMAL = 0x35,
 	MCU_UNI_EVENT_RSSI_MONITOR = 0x41,
 	MCU_UNI_EVENT_NIC_CAPAB = 0x43,
+	MCU_UNI_EVENT_NAN = 0x56,
 	MCU_UNI_EVENT_WED_RRO = 0x57,
 	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
 	MCU_UNI_EVENT_ALL_STA_INFO = 0x6e,
@@ -1314,6 +1315,7 @@ enum {
 	MCU_UNI_CMD_FIXED_RATE_TABLE = 0x40,
 	MCU_UNI_CMD_RSSI_MONITOR = 0x41,
 	MCU_UNI_CMD_TESTMODE_CTRL = 0x46,
+	MCU_UNI_CMD_NAN	= 0x56,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
 	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
index 8f1078ce3231..f9dcc0bba393 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_MT7925_COMMON) += mt7925-common.o
 obj-$(CONFIG_MT7925E) += mt7925e.o
 obj-$(CONFIG_MT7925U) += mt7925u.o
 
-mt7925-common-y := mac.o mcu.o regd.o main.o init.o debugfs.o
+mt7925-common-y := mac.o mcu.o regd.o main.o init.o debugfs.o nan.o
 mt7925-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7925e-y := pci.o pci_mac.o pci_mcu.o
 mt7925u-y := usb.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a41e0d2fb3f9..ecf086aee930 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -7,6 +7,7 @@
 #include "regd.h"
 #include "mcu.h"
 #include "mac.h"
+#include "nan.h"
 
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
@@ -37,7 +38,8 @@ int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
 		   cmd == MCU_UNI_CMD(OFFLOAD) ||
-		   cmd == MCU_UNI_CMD(SUSPEND)) {
+		   cmd == MCU_UNI_CMD(SUSPEND) ||
+		   cmd == MCU_UNI_CMD(NAN)) {
 		struct mt7925_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -600,6 +602,8 @@ mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 		dev->fw_assert = true;
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb, &dev->coredump);
 		return;
+	case MCU_UNI_EVENT_NAN:
+		mt7925_nan_mcu_event(dev, skb);
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/nan.c b/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
new file mode 100644
index 000000000000..9483ee94c05e
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/* Copyright (C) 2025-2026 MediaTek Inc. */
+
+#include <asm/byteorder.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/ieee80211.h>
+#include <net/cfg80211.h>
+#include <net/mac80211.h>
+
+#include "mt7925.h"
+#include "mcu.h"
+#include "nan.h"
+#include "regd.h"
+
+static void mt7925_nan_set_5g_channel(struct mt792x_dev *dev,
+				      struct mt7925_nan_enable_req_tlv *req,
+				      struct cfg80211_nan_conf *conf)
+{
+	struct ieee80211_channel *chan;
+	u32 ch5g = 0;
+
+	chan = conf->band_cfgs[NL80211_BAND_5GHZ].chan;
+
+	if (chan)
+		dev_info(dev->mt76.dev, "MP = %u, 5g ch: %u\n",
+			 conf->master_pref, chan->hw_value);
+	else
+		dev_info(dev->mt76.dev, "MP = %u, 5g ch is null\n",
+			 conf->master_pref);
+
+	if (!chan)
+		return;
+
+	if (!mt7925_regd_is_valid_channel(dev, NL80211_BAND_5GHZ, chan))
+		return;
+
+	req->config_5g_channel = 1;
+
+	if (chan->hw_value == NAN_5G_LOW_DISC_CHANNEL)
+		ch5g |= BIT(0);
+	else if (chan->hw_value == NAN_5G_HIGH_DISC_CHANNEL)
+		ch5g |= BIT(1);
+
+	req->channel_5g_val = cpu_to_le32(ch5g);
+}
+
+static void mt7925_nan_set_cluster_id(struct mt7925_nan_enable_req_tlv *req,
+				      const u8 *cluster_id)
+{
+	if (!cluster_id)
+		return;
+
+	req->cluster_high = cpu_to_le16(*(const u16 *)(cluster_id + 4));
+	req->cluster_low = cpu_to_le16((u16)cluster_id[3]);
+}
+
+static void mt7925_nan_set_dw_interval(struct mt7925_nan_enable_req_tlv *req,
+				       struct cfg80211_nan_conf *conf)
+{
+	if (conf->band_cfgs[NL80211_BAND_2GHZ].awake_dw_interval > 0) {
+		req->config_dw.config_2dot4g_dw_band = 1;
+		req->config_dw.dw_2dot4g_interval_val =
+			cpu_to_le32(conf->band_cfgs[NL80211_BAND_2GHZ].awake_dw_interval);
+	}
+
+	if (conf->band_cfgs[NL80211_BAND_5GHZ].awake_dw_interval > 0) {
+		req->config_dw.config_5g_dw_band = 1;
+		req->config_dw.dw_5g_interval_val =
+			cpu_to_le32(conf->band_cfgs[NL80211_BAND_5GHZ].awake_dw_interval);
+	}
+}
+
+static void mt7925_nan_set_disc_beacon(struct mt7925_nan_enable_req_tlv *req,
+				       struct cfg80211_nan_conf *conf)
+{
+	if (conf->discovery_beacon_interval > 0) {
+		req->config_2dot4g_beacons = true;
+		req->beacon_2dot4g_val = conf->discovery_beacon_interval;
+	}
+}
+
+static void mt7925_nan_set_rssi_thresholds(struct mt7925_nan_enable_req_tlv *req,
+					   struct cfg80211_nan_conf *conf)
+{
+	if (conf->band_cfgs[NL80211_BAND_2GHZ].chan) {
+		req->config_2dot4g_rssi_close = 1;
+		req->rssi_close_2dot4g_val =
+			abs(conf->band_cfgs[NL80211_BAND_2GHZ].rssi_close);
+		req->config_2dot4g_rssi_middle = 1;
+		req->rssi_middle_2dot4g_val =
+			abs(conf->band_cfgs[NL80211_BAND_2GHZ].rssi_middle);
+	}
+
+	if (conf->band_cfgs[NL80211_BAND_5GHZ].chan) {
+		req->config_5g_rssi_close = 1;
+		req->rssi_close_5g_val =
+			abs(conf->band_cfgs[NL80211_BAND_5GHZ].rssi_close);
+		req->config_5g_rssi_middle = 1;
+		req->rssi_middle_5g_val =
+			abs(conf->band_cfgs[NL80211_BAND_5GHZ].rssi_middle);
+	}
+}
+
+static void mt7925_nan_set_scan_params(struct mt7925_nan_enable_req_tlv *req,
+				       struct cfg80211_nan_conf *conf)
+{
+	req->scan_params_val.scan_period[0] =
+		conf->scan_period < 255 ? conf->scan_period : 255;
+	req->scan_params_val.dwell_time[0] =
+		conf->scan_dwell_time < 255 ? conf->scan_dwell_time : 255;
+}
+
+int mt7925_nan_enable(struct ieee80211_vif *vif,
+		      struct mt792x_dev *dev,
+		      struct cfg80211_nan_conf *conf)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct {
+		u8 rsv[4];
+		struct mt7925_nan_enable_req_tlv nan_req_tlv;
+	} nan_cmd = {
+		.rsv = { 0 },
+		.nan_req_tlv = {
+			.tag = cpu_to_le16(NAN_UNI_CMD_ENABLE_REQUEST),
+			.len = cpu_to_le16(sizeof(struct mt7925_nan_enable_req_tlv)),
+			.config_random_factor_force = 0,
+			.random_factor_force_val = 0,
+			.config_hop_count_force = 0,
+			.hop_count_force_val = 0,
+		},
+	};
+	struct mt7925_nan_enable_req_tlv *p_nan_req_tlv = &nan_cmd.nan_req_tlv;
+
+	if (!dev || !conf)
+		return -EINVAL;
+
+	p_nan_req_tlv->master_pref = conf->master_pref;
+
+	mt7925_nan_set_5g_channel(dev, p_nan_req_tlv, conf);
+	mt7925_nan_set_cluster_id(p_nan_req_tlv, conf->cluster_id);
+	mt7925_nan_set_dw_interval(p_nan_req_tlv, conf);
+	mt7925_nan_set_disc_beacon(p_nan_req_tlv, conf);
+	mt7925_nan_set_rssi_thresholds(p_nan_req_tlv, conf);
+	mt7925_nan_set_scan_params(p_nan_req_tlv, conf);
+
+	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(NAN), &nan_cmd, sizeof(nan_cmd), true);
+}
+
+int mt7925_nan_disable(struct ieee80211_vif *vif, struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct {
+		u8 rsv[4];
+		struct tlv nan_dis_tlv;
+	} nan_cmd = {
+		.rsv = { 0 },
+		.nan_dis_tlv = {
+			.tag = cpu_to_le16(NAN_UNI_CMD_DISABLE_REQUEST),
+			.len = cpu_to_le16(sizeof(struct tlv)),
+		},
+	};
+
+	if (!dev)
+		return -EINVAL;
+
+	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(NAN), &nan_cmd, sizeof(nan_cmd), true);
+}
+
+static void
+mt7925_nan_mp_tlv(struct sk_buff *skb, u8 master_pref)
+{
+	struct mt7925_nan_master_preference_tlv *mp_tlv = NULL;
+	struct tlv *tlv = NULL;
+
+	if (!skb)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, NAN_UNI_CMD_SET_MASTER_PREFERENCE,
+				      sizeof(struct mt7925_nan_master_preference_tlv));
+	if (!tlv)
+		return;
+
+	mp_tlv = (struct mt7925_nan_master_preference_tlv *)tlv;
+
+	if (master_pref > NAN_MAX_MASTER_PREFERENCE)
+		return;
+
+	mp_tlv->master_preference = master_pref;
+}
+
+static void
+mt7925_nan_dw_tlv(struct sk_buff *skb, struct cfg80211_nan_conf *conf)
+{
+	struct mt7925_nan_dw_interval_tlv *dw_tlv = NULL;
+	struct tlv *tlv = NULL;
+	u16 interval;
+
+	if (!skb || !conf)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, NAN_UNI_CMD_SET_DW_INTERVAL,
+				      sizeof(struct mt7925_nan_dw_interval_tlv));
+
+	if (!tlv)
+		return;
+
+	dw_tlv = (struct mt7925_nan_dw_interval_tlv *)tlv;
+
+	/* Set DW interval for 2.4GHz and 5GHz bands if available */
+	if (conf->band_cfgs[NL80211_BAND_2GHZ].awake_dw_interval > 0) {
+		dw_tlv->dw_interval = conf->band_cfgs[NL80211_BAND_2GHZ].awake_dw_interval;
+	} else if (conf->band_cfgs[NL80211_BAND_5GHZ].awake_dw_interval > 0) {
+		dw_tlv->dw_interval = conf->band_cfgs[NL80211_BAND_5GHZ].awake_dw_interval;
+	} else {
+		/* Fallback to a default value or log a warning */
+		dw_tlv->dw_interval = NAN_DEFAULT_DW_INTERVAL;
+	}
+
+	/* Validate and set NAN Discovery Beacon Interval */
+	interval = conf->discovery_beacon_interval > 0 ?
+		   conf->discovery_beacon_interval :
+		   NAN_DEFAULT_DISC_BCN_INTERVAL;
+
+	dw_tlv->disc_bcn_interval = cpu_to_le16(interval);
+}
+
+static void
+mt7925_nan_cluster_id_tlv(struct sk_buff *skb, const u8 *cluster_id)
+{
+	struct mt7925_nan_cluster_id_tlv *cluster_tlv = NULL;
+	struct tlv *tlv = NULL;
+
+	if (!skb || !cluster_id)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, NAN_UNI_CMD_SET_CLUSTER_ID,
+				      sizeof(struct mt7925_nan_cluster_id_tlv));
+
+	if (!tlv)
+		return;
+
+	cluster_tlv = (struct mt7925_nan_cluster_id_tlv *)tlv;
+
+	memcpy(cluster_tlv->cluster_id, cluster_id, ETH_ALEN);
+}
+
+static void
+mt7925_nan_sync_rssi_tlv(struct sk_buff *skb, struct cfg80211_nan_conf *conf)
+{
+	struct mt7925_nan_sync_rssi_tlv *rssi_tlv = NULL;
+	struct tlv *tlv = NULL;
+
+	if (!skb || !conf)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, NAN_UNI_CMD_SET_SYNC_RSSI,
+				      sizeof(struct mt7925_nan_sync_rssi_tlv));
+
+	if (!tlv)
+		return;
+
+	rssi_tlv = (struct mt7925_nan_sync_rssi_tlv *)tlv;
+
+	if (conf->band_cfgs[NL80211_BAND_2GHZ].chan) {
+		rssi_tlv->rssi_close_2g =
+			conf->band_cfgs[NL80211_BAND_2GHZ].rssi_close;
+		rssi_tlv->rssi_middle_2g =
+			conf->band_cfgs[NL80211_BAND_2GHZ].rssi_middle;
+	}
+
+	if (conf->band_cfgs[NL80211_BAND_5GHZ].chan) {
+		rssi_tlv->rssi_close_5g =
+			conf->band_cfgs[NL80211_BAND_5GHZ].rssi_close;
+		rssi_tlv->rssi_middle_5g =
+			conf->band_cfgs[NL80211_BAND_5GHZ].rssi_middle;
+	}
+}
+
+int mt7925_nan_change_configure(struct ieee80211_vif *vif,
+				struct mt792x_dev *dev,
+				struct cfg80211_nan_conf *conf)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt7925_nan_common_hdr *hdr = NULL;
+	struct sk_buff *skb = NULL;
+
+	if (!dev || !conf)
+		return -EINVAL;
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, MT7925_NAN_CONF_MAX_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (struct mt7925_nan_common_hdr *)skb_put(skb, sizeof(*hdr));
+	memset(hdr, 0, sizeof(*hdr));
+
+	mt7925_nan_mp_tlv(skb, conf->master_pref);
+	mt7925_nan_dw_tlv(skb, conf);
+	mt7925_nan_cluster_id_tlv(skb, conf->cluster_id);
+	mt7925_nan_sync_rssi_tlv(skb, conf);
+
+	return mt76_mcu_skb_send_msg(mdev, skb,
+				     MCU_UNI_CMD(NAN), true);
+}
+
+static void
+mt7925_nan_mcu_handle_de_event(struct mt792x_dev *dev, struct tlv *tlv)
+{
+	struct mt7925_nan_de_event *de_evt = NULL;
+	u8 cluster_id[ETH_ALEN] __aligned(2) = {0x50, 0x6f, 0x9a, 0x01, 0x00, 0x00};
+	u16 len;
+
+	if (!dev || !tlv) {
+		if (dev)
+			dev_warn(dev->mt76.dev, "nan: failed to parse TLV\n");
+		return;
+	}
+
+	len = le16_to_cpu(tlv->len);
+	if (len < sizeof(*tlv) + sizeof(*de_evt)) {
+		dev_warn(dev->mt76.dev,
+			 "nan: short de_event tlv len=%u\n", len);
+		return;
+	}
+
+	de_evt = (struct mt7925_nan_de_event *)tlv->data;
+	if (!de_evt) {
+		dev_warn(dev->mt76.dev, "nan: missing DE event payload\n");
+		return;
+	}
+
+	if (de_evt->event_type == NAN_EVENT_ID_DISC_MAC_ADDR)
+		return;
+
+	memcpy(cluster_id, de_evt->cluster_id, ETH_ALEN);
+
+	dev_dbg(dev->mt76.dev, "nan: evt=%u cluster=%pM\n",
+		de_evt->event_type, de_evt->cluster_id);
+
+	if (de_evt->event_type != NAN_EVENT_ID_JOINED_CLUSTER)
+		return;
+
+	dev_dbg(dev->mt76.dev, "nan: anchor_master_rank=%*phN\n",
+		NAN_ANCHOR_MASTER_RANK_NUM, de_evt->anchor_master_rank);
+
+	dev_dbg(dev->mt76.dev, "nan: own_nmi=%pM master_nmi=%pM\n",
+		de_evt->own_nmi, de_evt->master_nmi);
+}
+
+void mt7925_nan_mcu_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct tlv *tlv;
+	u32 tlv_len;
+
+	if (!dev || !skb)
+		return;
+
+	if (skb->len < sizeof(struct mt7925_mcu_rxd) + 4)
+		return;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	tlv = (struct tlv *)skb->data;
+	tlv_len = skb->len;
+
+	while (tlv_len >= sizeof(*tlv)) {
+		u16 len = le16_to_cpu(tlv->len);
+
+		if (len < sizeof(*tlv) || len > tlv_len)
+			break;
+
+		switch (le16_to_cpu(tlv->tag)) {
+		case NAN_UNI_EVENT_ID_DE_EVENT_IND:
+			mt7925_nan_mcu_handle_de_event(dev, tlv);
+			break;
+		default:
+			break;
+		}
+
+		tlv_len -= len;
+		tlv = (struct tlv *)((u8 *)tlv + len);
+	}
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/nan.h b/drivers/net/wireless/mediatek/mt76/mt7925/nan.h
new file mode 100644
index 000000000000..8c145e4b0b6f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/nan.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/* Copyright (C) 2025-2026 MediaTek Inc. */
+
+#ifndef __MT7925_NAN_H
+#define __MT7925_NAN_H
+
+#include <linux/if_ether.h>
+#include <linux/types.h>
+
+#include "../mt76_connac_mcu.h"
+
+#define NAN_MAX_SOCIAL_CHANNELS		3
+#define NAN_ANCHOR_MASTER_RANK_NUM	8
+#define NAN_5G_LOW_DISC_CHANNEL		44
+#define NAN_5G_HIGH_DISC_CHANNEL	149
+#define NAN_MAX_MASTER_PREFERENCE	255
+#define NAN_DEFAULT_DW_INTERVAL		1
+#define NAN_DEFAULT_DISC_BCN_INTERVAL	100
+
+#define MT7925_NAN_CONF_MAX_SIZE					\
+	(sizeof(struct mt7925_nan_common_hdr) +				\
+	 sizeof(struct mt7925_nan_master_preference_tlv) +		\
+	 sizeof(struct mt7925_nan_dw_interval_tlv) +			\
+	 sizeof(struct mt7925_nan_cluster_id_tlv) +			\
+	 sizeof(struct mt7925_nan_sync_rssi_tlv))
+
+enum nan_uni_cmd_tag {
+	NAN_UNI_CMD_SET_MASTER_PREFERENCE	= 0,
+	NAN_UNI_CMD_ENABLE_REQUEST		= 7,
+	NAN_UNI_CMD_DISABLE_REQUEST		= 8,
+	NAN_UNI_CMD_SET_DW_INTERVAL		= 26,
+	NAN_UNI_CMD_SET_SYNC_RSSI		= 39,
+	NAN_UNI_CMD_SET_CLUSTER_ID		= 40,
+};
+
+enum nan_uni_event_tag {
+	NAN_UNI_EVENT_ID_DE_EVENT_IND		= 19,
+};
+
+enum nan_disc_event_type {
+	NAN_EVENT_ID_DISC_MAC_ADDR		= 0,
+	NAN_EVENT_ID_JOINED_CLUSTER		= 2,
+};
+
+struct mt7925_nan_social_ch_scan_params {
+	u8 dwell_time[NAN_MAX_SOCIAL_CHANNELS];
+	__le16 scan_period[NAN_MAX_SOCIAL_CHANNELS];
+} __packed;
+
+struct mt7925_nan_conf_dw {
+	u8 config_2dot4g_dw_band;
+	__le32 dw_2dot4g_interval_val;
+
+	u8 config_5g_dw_band;
+	__le32 dw_5g_interval_val;
+} __packed;
+
+struct mt7925_nan_enable_req_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 master_pref;
+	__le16 cluster_low;
+	__le16 cluster_high;
+
+	u8 config_support_5g;
+	u8 support_5g_val;
+
+	u8 config_sid_beacon;
+	u8 sid_beacon_val;
+
+	u8 config_2dot4g_rssi_close;
+	u8 rssi_close_2dot4g_val;
+	u8 config_2dot4g_rssi_middle;
+	u8 rssi_middle_2dot4g_val;
+
+	u8 config_2dot4g_rssi_proximity;
+	u8 rssi_proximity_2dot4g_val;
+	u8 config_hop_count_limit;
+	u8 hop_count_limit_val;
+
+	u8 config_2dot4g_support;
+	u8 support_2dot4g_val;
+
+	u8 config_2dot4g_beacons;
+	u8 beacon_2dot4g_val;
+
+	u8 config_2dot4g_sdf;
+	u8 sdf_2dot4g_val;
+
+	u8 config_5g_beacons;
+	u8 beacon_5g_val;
+
+	u8 config_5g_sdf;
+	u8 sdf_5g_val;
+
+	u8 config_5g_rssi_close;
+	u8 rssi_close_5g_val;
+
+	u8 config_5g_rssi_middle;
+	u8 rssi_middle_5g_val;
+
+	u8 config_5g_rssi_close_proximity;
+	u8 rssi_close_proximity_5g_val;
+
+	u8 config_rssi_window_size;
+	u8 rssi_window_size_val;
+
+	u8 config_oui;
+	__le32 oui_val;
+
+	u8 config_intf_addr;
+	u8 intf_addr_val[ETH_ALEN];
+
+	u8 config_cluster_attribute_val;
+
+	u8 config_scan_params;
+	struct mt7925_nan_social_ch_scan_params scan_params_val;
+
+	u8 config_random_factor_force;
+	u8 random_factor_force_val;
+
+	u8 config_hop_count_force;
+	u8 hop_count_force_val;
+
+	u8 config_24g_channel;
+	__le32 channel_24g_val;
+
+	u8 config_5g_channel;
+	__le32 channel_5g_val;
+
+	struct mt7925_nan_conf_dw config_dw;
+
+	u8 config_disc_mac_addr_randomization;
+	__le32 disc_mac_addr_rand_interval_sec;
+
+	u8 discovery_indication_cfg;
+
+	u8 config_subscribe_sid_beacon;
+	__le32 subscribe_sid_beacon_val;
+
+	u8 enable_log_slot_statistics;
+} __packed __aligned(4);
+
+struct mt7925_nan_common_hdr {
+	u8 reserved[4];
+};
+
+struct mt7925_nan_master_preference_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 master_preference;
+	u8 reserved[3];
+} __packed __aligned(4);
+
+struct mt7925_nan_dw_interval_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 dw_interval;
+	u8 vendor_ioctl;
+	__le16 disc_bcn_interval;
+} __packed __aligned(4);
+
+struct mt7925_nan_cluster_id_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 cluster_id[ETH_ALEN];
+	u8 reserved[2];
+} __packed __aligned(4);
+
+struct mt7925_nan_sync_rssi_tlv {
+	__le16 tag;
+	__le16 len;
+	s8 rssi_close_2g;
+	s8 rssi_middle_2g;
+	s8 rssi_close_5g;
+	s8 rssi_middle_5g;
+} __packed __aligned(4);
+
+struct mt7925_nan_de_event {
+	u8 event_type;
+	u8 cluster_id[ETH_ALEN];
+	u8 anchor_master_rank[NAN_ANCHOR_MASTER_RANK_NUM];
+	u8 own_nmi[ETH_ALEN];
+	u8 master_nmi[ETH_ALEN];
+};
+
+int mt7925_nan_enable(struct ieee80211_vif *vif,
+		      struct mt792x_dev *dev,
+		      struct cfg80211_nan_conf *conf);
+
+int mt7925_nan_disable(struct ieee80211_vif *vif,
+		       struct mt792x_dev *dev);
+
+int mt7925_nan_change_configure(struct ieee80211_vif *vif,
+				struct mt792x_dev *dev,
+				struct cfg80211_nan_conf *conf);
+
+void mt7925_nan_mcu_event(struct mt792x_dev *dev, struct sk_buff *skb);
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index 16f56ee879d4..0235437d11d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -217,6 +217,36 @@ mt7925_regd_is_valid_alpha2(const char *alpha2)
 	return false;
 }
 
+bool
+mt7925_regd_is_valid_channel(struct mt792x_dev *dev,
+			     enum nl80211_band band,
+			     struct ieee80211_channel *chan)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct wiphy *wiphy = hw->wiphy;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch;
+	int i;
+
+	if (!chan)
+		return false;
+
+	sband = wiphy->bands[band];
+	if (!sband)
+		return false;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->hw_value == chan->hw_value &&
+		    ((ch->flags & IEEE80211_CHAN_DISABLED) == 0))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mt7925_regd_is_valid_channel);
+
 int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
index 0767f078862e..0b0754cf8ae7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
@@ -13,6 +13,9 @@ void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
 void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req);
 bool mt7925_regd_clc_supported(struct mt792x_dev *dev);
 int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2);
+bool mt7925_regd_is_valid_channel(struct mt792x_dev *dev,
+				  enum nl80211_band band,
+				  struct ieee80211_channel *chan);
 int mt7925_regd_init(struct mt792x_phy *phy);
 
 #endif
-- 
2.43.0


