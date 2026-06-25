Return-Path: <linux-wireless+bounces-38062-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g+WCEEx0PGrNoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38062-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:20:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B96C1F6B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:20:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38062-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38062-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14A74303FFBF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCEB757EA;
	Thu, 25 Jun 2026 00:19:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CF256D
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:19:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346779; cv=none; b=pFuwYJW4wocWzEsGwJHdZoYEFAdhvVNtw5iMEY6ZczLgKjfpZT/n/vZMQqxf+2p+RYM0LhqFhIEOU0a5MK4Kc9eo+guUkJrsmRiX7RLRGBhkHKBgBDHlQTl3nEIJtQpjjj5jCRuONCyIY76CHD1mtjsePJeaBSV2D0CEopiO6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346779; c=relaxed/simple;
	bh=rv3yzMfrVxbEV7yiXB0VsmI14dX9tlEODJ3CCJi+cIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er7RBQ2fPYCua2wDFVS4zQgmXtYYzaptWmpKaJxlHDFNpWRgGqTW2xAUuswZPz73+9z/m+D+5cDQhZHrp86zvq58ptOSa0WUL6Sajy94+a5YYBxMR5+yxQZbF46Y1JntXue44CF+dy4bGvnxaHPZMfgp5kz/FVbN0mR5XhtagdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c858014845aso150485a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346778; x=1782951578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kv79dqtnd7K7KyZqWwESbiQtv3Ep1j7XGjVimvSOdhE=;
        b=jkgtdqd29GTjkogrA/1q7oPPV4zJllrCDqdV9Z4e063zWSnMRr87b9IM1pVN2mhyGa
         rt/4l+oqQx+5/SuM69COTGK4xpqpawkAKzxRCHUj1cptannwpyJN8Xc6DfmhSPu5D6eH
         psT5z6UJlHMQP+0U9iiEFhMKQPpWXZBG58KuKwKZZEMwWWdqWQ3608hmJ/cPS+My9VYF
         wD6xHvEtQG1vHzuHLAwMn1yTJuKV6ZP8OuQ1KrtVu2GgVr8ykG4m5+2uhvChlXZAI+px
         T8JaFDHK3g4qMT+tGOFCMhWI3ZmONheGNV9yv3IAdC6aNWAyjHYLE9oZrrQZDwRQrixz
         m3Cw==
X-Forwarded-Encrypted: i=1; AFNElJ87HgWh+kBAPauGJ/yJy4P4N1+kFjpk8twvHl9OkRIjEJ8J5zW7IMdTzGLq7nUZvBToPUrJCLP1gNFn3GWarQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtUvd9R9gmAIERldnGuY6ocU9QtpZ5shjSS0MbJK+XuOREgIQ
	JZ5myihkVF7dLgyDLRPRycMOHWJTYoWadi32wozZ5FI1/3pL7/5Sn5H8
X-Gm-Gg: AfdE7clcddIHk3oyKCS4S8vsFwVJdB49H3XkliAh+ty0NVlRDMZiOJFE4B6BE5jMM1V
	crZfWWdNGB+VTtoxDKrlHuVN3aBuHpO3TGSThY1B0nYlCeVr7M3C5ukgqMUjAuFJ9Riu1Xd3BOD
	hZV4cVLqrGFHee2TaMT01DDsySnkV3t5VMjjT00sg+rWZHJGoc0PeJd/IoJkEvnz7VAU0MKIPMV
	FwMl3tnf+ke36V3ecTJAC8YImmoiyQsEqKKR/FFjPMcjKBDuHHrMr5565QvDFzkiOKY6V6L6Hq0
	HEeft0/xVj8r9MSX9tWE979LF9Wat0usJuMCpByQ7U6vZ230C+umtYT8s5XFRodjYZswIin8fTS
	E88mXLsl49Vx21nAmaqGpX64XjrvvHEjhorkjrqKSmYQBRexprU21ODdKkXaCJS4dxkHAglmmRt
	phBz5y7zH1l1h+Vj4kz64NAuCGL579rk7IJuwXzSqPkC/DOmAoqqbCJ3tHZZ7Fd2+DKC1z0iOrB
	YHdDouEJ68OSOVwXuFkb1W9wOl/Hg==
X-Received: by 2002:a05:6a20:e615:b0:3a3:adea:83bc with SMTP id adf61e73a8af0-3bd4aba5255mr248086637.15.1782346777654;
        Wed, 24 Jun 2026 17:19:37 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:19:37 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 3/9] wifi: mt76: connac: add NAN connection type
Date: Wed, 24 Jun 2026 19:18:28 -0500
Message-ID: <20260625001834.475094-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625001834.475094-1-sean.wang@kernel.org>
References: <20260625001834.475094-1-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38062-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D2B96C1F6B

From: Sean Wang <sean.wang@mediatek.com>

Introduce a dedicated NAN connection type for connac firmware and use it
for NAN interface device, BSS and station records.

Add the common NAN MCU command and event IDs used by mt7925.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Co-developed-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   | 14 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6596c9e198f4..67eba4dd9615 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -422,6 +422,10 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		basic->aid = cpu_to_le16(link_sta->sta->aid);
 		break;
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
+		basic->conn_type = cpu_to_le32(CONNECTION_NAN);
+		break;
 	default:
 		WARN_ON(1);
 		break;
@@ -1217,6 +1221,11 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	case NL80211_IFTYPE_ADHOC:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		break;
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_NAN);
+		basic_req.basic.conn_state = !enable;
+		break;
 	default:
 		WARN_ON(1);
 		break;
@@ -1625,6 +1634,11 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	case NL80211_IFTYPE_ADHOC:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		break;
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_NAN);
+		basic_req.basic.active = enable;
+		break;
 	default:
 		WARN_ON(1);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 78f633ad81a0..a9a4a87ae0a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -876,6 +876,7 @@ enum {
 #define NETWORK_P2P			BIT(17)
 #define NETWORK_IBSS			BIT(18)
 #define NETWORK_WDS			BIT(21)
+#define NETWORK_NAN			BIT(22)
 
 #define SCAN_FUNC_RANDOM_MAC		BIT(0)
 #define SCAN_FUNC_RNR_SCAN		BIT(3)
@@ -888,6 +889,7 @@ enum {
 #define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
 #define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
 #define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
+#define CONNECTION_NAN			(NETWORK_NAN)
 
 #define CONN_STATE_DISCONNECT		0
 #define CONN_STATE_CONNECT		1
@@ -1074,6 +1076,7 @@ enum {
 	MCU_UNI_EVENT_THERMAL = 0x35,
 	MCU_UNI_EVENT_RSSI_MONITOR = 0x41,
 	MCU_UNI_EVENT_NIC_CAPAB = 0x43,
+	MCU_UNI_EVENT_NAN = 0x56,
 	MCU_UNI_EVENT_WED_RRO = 0x57,
 	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
 	MCU_UNI_EVENT_ALL_STA_INFO = 0x6e,
@@ -1313,6 +1316,7 @@ enum {
 	MCU_UNI_CMD_FIXED_RATE_TABLE = 0x40,
 	MCU_UNI_CMD_RSSI_MONITOR = 0x41,
 	MCU_UNI_CMD_TESTMODE_CTRL = 0x46,
+	MCU_UNI_CMD_NAN	= 0x56,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
 	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
-- 
2.43.0


