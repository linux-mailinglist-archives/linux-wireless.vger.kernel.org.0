Return-Path: <linux-wireless+bounces-32486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLgTI77FqGlaxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3CD20928A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C34130C733A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128DC3321D8;
	Wed,  4 Mar 2026 23:50:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424B3612E0
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668259; cv=none; b=npigdGQJaDs1umBa+ifBuhGZWKW+eOrs5liZMwr+BBYSCXOcCh87cRRrW8g8CeP01aTWeVPwvHCyKdDcRPetrrxNEnYb/8BuRhBbh3j47ytkcYRgiTmjWk7Bn7glRs4mVLsRAjYEZhVpbexp+hRaavs6d9t7ZH5TkOMtfM0WtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668259; c=relaxed/simple;
	bh=ekGN4i76uZg1n8t3iw9b2orA9tXNcPeElESAloI57Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWmv0DfALnvSFa7vMd0llPs9qZ1hgWiGqse0+SMB/gMIjEcT1zoqXnCc5xg+GJb95o1NPsH7pPjAVxeF94dNUGTku/P+rJmkWiMTAPMJedq7ITYxFAsxm2mdviUhrFbm5IhJMrwAZBX2Krp9w7TVFkg0nuBqzF3ME7jEyJwsHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-413d8b8e98aso1274511fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668257; x=1773273057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXvnDKqcGmwB0NG7zczjsoKBWgPELsqRrCKeMO4tmuo=;
        b=liedYu1Y3wLZOmirJ8j0/dfZWAumzeCSh+zFk/7O02VsSfPoC8JaOMDhrO0do4SKog
         nJUHhirfVYiqZ5xveCZJkXAUJpzISXLII2vbjpn5KGMrnURo4wTbQpLef3RWjau4c+9r
         i6RSMbCvWt5N82hAOL3nvJIz2sIDBlybDd8PB5qx02KJ9MTMjTcZ8Ro0rpjXhIJB123T
         y/cpgzDHjipfIqvqQatvEIVe3g518Z21L+RkmyQ3mmmMZOZMzic9izA9XErLVQsjG7Vc
         GCUqoZV7/EOrhdM/xfxAMVokxq7HnCQFK/49cvj9DxB9uYMnTWmvomT4B/IK0ZrHFfg/
         P41w==
X-Gm-Message-State: AOJu0YzRWkWLN9k5Voroamnf0PrLi3/y6H3MkdS7WSesejZbMxVEye59
	qwRBc/gAL4kaZzrGrXkzQEdOTxq7PX7w7IxKqVJYQ8b56Z0v65yBdshK
X-Gm-Gg: ATEYQzyyFhx6JU/p7zLGuWcISZGrpeMpvM/ANplXmo7xAVh1TFXGEnCFPE5+Uti/vLE
	2v9f9jbffmbRlxMLlMXX9KPqCJNy66dVQerpDiA1c4+D0+lBX/115UPNqZInoRXxxSv6uaXGPpl
	3kB0cNFhMXo+0DNTm64taYS5y8JB3TSW+4scb+jAr4LExONtxgPvyilJsqsDMWV7IBfR/8bEc86
	hCxjcixDKDhkBUnecC3RWW0DHk6oIxnTAPd4Hc6jMkA8u0TGpX+ryh5Mh017AVw0VCLR2GT1UHC
	IfMnrpeAoF5A4ihkTd+y0Z+76Ka5VUlh34mTYL2CzGa3uOtzLGhCJm7hAQ20o6FCS6ZIhNLaEe+
	sxQOeq/NH81DXnlWG/s4Iv2HCouqP3Sp7aji6GZSp03DNaU9zzvo/r+CJSUD0OuCbiLwJRnUESp
	4I3XCBd5hC82dFahuUAUH/e1+eTMZozvfE6hBQP2rzea1w8rZc8cVk2eaQ2Q==
X-Received: by 2002:a05:6820:f024:b0:676:f8f6:3f67 with SMTP id 006d021491bc7-67b1e902872mr1929735eaf.59.1772668256728;
        Wed, 04 Mar 2026 15:50:56 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm14410687eaf.7.2026.03.04.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:50:56 -0800 (PST)
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
Subject: [PATCH 4/7] wifi: mt76: connac: add NAN connection type
Date: Wed,  4 Mar 2026 17:50:17 -0600
Message-ID: <20260304235020.40451-4-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 0F3CD20928A
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
	TAGGED_FROM(0.00)[bounces-32486-lists,linux-wireless=lfdr.de];
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

Introduce a dedicated NAN connection type for connac-based firmware.

This prepares driver support for NAN interfaces by allowing MCU
device/BSS configuration to represent NAN roles using a distinct
connection type.

No functional behaviour change yet as NAN is not exposed to userspace.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 89bd52ea8bf7..09efcab7d783 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -422,6 +422,9 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		basic->aid = cpu_to_le16(link_sta->sta->aid);
 		break;
+	case NL80211_IFTYPE_NAN:
+		basic->conn_type = cpu_to_le32(CONNECTION_NAN);
+		break;
 	default:
 		WARN_ON(1);
 		break;
@@ -1212,6 +1215,10 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	case NL80211_IFTYPE_ADHOC:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		break;
+	case NL80211_IFTYPE_NAN:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_NAN);
+		basic_req.basic.conn_state = !enable;
+		break;
 	default:
 		WARN_ON(1);
 		break;
@@ -1613,6 +1620,10 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	case NL80211_IFTYPE_ADHOC:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		break;
+	case NL80211_IFTYPE_NAN:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_NAN);
+		basic_req.basic.active = enable;
+		break;
 	default:
 		WARN_ON(1);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index fd9cf9c0c32f..11986e164a38 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 261ed6528808..a41e0d2fb3f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2563,6 +2563,10 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 		basic_req->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		basic_req->active = true;
 		break;
+	case NL80211_IFTYPE_NAN:
+		basic_req->conn_type = cpu_to_le32(CONNECTION_NAN);
+		basic_req->active = enable;
+		break;
 	default:
 		WARN_ON(1);
 		break;
-- 
2.43.0


