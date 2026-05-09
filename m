Return-Path: <linux-wireless+bounces-36138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aRyJDEHG/2kA+gAAu9opvQ
	(envelope-from <linux-wireless+bounces-36138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 01:41:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9148C502030
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 01:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CFBE3018C0B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 23:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A13D5662;
	Sat,  9 May 2026 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcl0+WLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52EE78F2B
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778370110; cv=none; b=SbGGPJJjwcrVcnEV/TLoWrEZJXmlRaNNExQy/megp/0ZUVyOa/ZxC4Xi/Cu97ji9hyb1HH3i8o9cdsJB2J91GOi8qvuO9IUaWrUzsmARtF3o2yAuqylUCGimoVRg5urtSZNkXhANcllMA+jcArGmjiY1kP+6/QIeII/NbSPHAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778370110; c=relaxed/simple;
	bh=oNtEwBxsMq0vLxKKN3nKGx+7660608AsOZOLwj2Iue4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZMV/7LcCYYNRh8KeRGoYjTMk8PdVTmn3CHPM+0T/QUzlTKu8G7gDIOOgEgWUQtKg6aHzrivrZE4ratkv0KZ1NVwIdyZRA1mREDjLvBxe7QkdG+pKzTYdjyVBHdm4ODK4BRbTIAtzlqQxUAuUlUBZsWemxDb1AvPbVsV9sV6tQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcl0+WLW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b788a98557so23502885ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778370108; x=1778974908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tXCIxyh2WIRhaTJRyNlw53Gk/Y7Ow55sVrpcQLe5rw=;
        b=lcl0+WLWFNjA7eRjpk2TUSFJayOcEoawovn/L3PkYSKVyqdwEizamY1YCSz/ciN0ij
         BIsWXMgW5xj9J+yUCYKYgqienvBEUq8SG7W4pEKC/B/uaCxQcI8xCu4trRzza9K62fvF
         qH5BGkKKRHoCX1GSJ9LOL329CkpmoM05tGl31L3ZSixCM0d6b9uvp6TrWWyHQNUaFi3d
         mmsNFHTgGMU/mCLXjNq/QAuKVL8HraB6gxt4H2PskjuU5Bj56uoBfjQnHSRmVF0gu+hV
         2GWbkMS/yaeCYZdIm7kOR8rNuoMglmTCp6MuOHegxDnoa385n+xhGZbcqSTGhx+7nB0H
         26WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778370108; x=1778974908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tXCIxyh2WIRhaTJRyNlw53Gk/Y7Ow55sVrpcQLe5rw=;
        b=YOeaZLu5BuYZK+lqOyxRJ9tCpjq/fcXo8cYr8XNrXSg5LtiSHoSnp+LQDMNwftUdta
         uNeig/pOzBT7ByZw3iNxkuAvfGEOnqsFeKI2jO/5hFV6dxryGDKDtjMgyOjQiJifVp2Q
         lEbtB/dWEIlvzl8nXuwP3dmmri7J/fzQhxrSb8lGliPEcShgKHwGIxXkqxGA6u6fvWKU
         +dVM7dqYPAzPeEQhW+4FJlJ7AliJq1GOQ+Teskejjs+/GKPeA+hO/w1q1XaX9JldwKnT
         taElhduXbTGL/nwHazc8vQZpxg7DHqsfg5IDpjbg/5WZL2sozpoo35eveElAyztAyTix
         qXNA==
X-Gm-Message-State: AOJu0YyDKWcSO3a40yxD5Z7bEgTpI3LfmEHDj8cvqNf6JH4GktEdH5BA
	/16BLklhR/LI84TuDYFo7eTXWJjGtFpszMrm8Gb+yQOFt+CCKlkzMa1bJrv7lQ==
X-Gm-Gg: Acq92OHSy0AbETkb415h7zHrJ9N78h4dsOd6EX1tSfudabQOByYWPxd9S4Z1Z3hOEQC
	8ikO3Z3ec5WAv1QaIAO8PWYg/BRE00GLTSDgh8oh2Ni9tMxRAieb4JjLAsbCS/qCL7LcMIKFDyw
	70mojUmSsbaf+uhpeWA/f4A48f75E/1dznHRwIdwltXv+WpOxUrkwl7Y1xI3wZrGrbp5y/+4o8+
	QUFSIR3bTC2nCOW7NZHS7NRWFCkXOblYkQLmGDzXI/alKB5Exm3Q5vuXkCa+YQOwGpcoqlVR7tV
	2mT9m5gffPumwVkYe0pEoa9hVWnGuWgbiiweyWp6+d2HHcw88lA8qXxkHkz1M1CZ4hc+OOeSnLK
	t6TIFHls05dzeCt6s6ug/dCzNgJxn4X24siVmpbTGEzH6Hnf4q110KjEtiZ+ZN1jhtcY2Zi9Vxa
	JuS2pJnGaKUnLN0952720CRsrSsw==
X-Received: by 2002:a17:903:186:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2baf0cf4251mr93000295ad.1.1778370108072;
        Sat, 09 May 2026 16:41:48 -0700 (PDT)
Received: from ryzen9.. ([2409:11:4b40:1900:7ef3:a74c:6b41:8c9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm61078635ad.1.2026.05.09.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:41:47 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 1/3] Fix overread in PREQ frame processing
Date: Sun, 10 May 2026 08:41:41 +0900
Message-ID: <20260509234143.101237-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
References: <db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9148C502030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36138-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the AF flag is enabled, hwmp_preq_frame_process() overreads target_addr
by 2 bytes. Since this occurs within the socket buffer, it does not read across
memory boundaries and therefore poses no security risk; however, we will fix it
as a precaution.

In this fix, a new function mesh_path_parse_request_frame() is established to
separate the implementation of frame format validation and the check for
unsupported features. This is intended to facilitate future work when
implementing the currently unsupported parts.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 56 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 42 ++++++-------------------
 net/mac80211/parse.c           |  9 ++++--
 3 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 4b829bcb38b6..8ff68cf539ff 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -34,6 +34,38 @@ struct ieee80211s_hdr {
 #define MESH_FLAGS_AE		0x3
 #define MESH_FLAGS_PS_DEEP	0x4
 
+/* HWMP IE processing macros */
+#define AE_F			(1<<6)
+#define AE_F_SET(x)		(*x & AE_F)
+#define PREQ_IE_FLAGS(x)	(*(x))
+#define PREQ_IE_HOPCOUNT(x)	(*(x + 1))
+#define PREQ_IE_TTL(x)		(*(x + 2))
+#define PREQ_IE_PREQ_ID(x)	u32_field_get(x, 3, 0)
+#define PREQ_IE_ORIG_ADDR(x)	(x + 7)
+#define PREQ_IE_ORIG_SN(x)	u32_field_get(x, 13, 0)
+#define PREQ_IE_LIFETIME(x)	u32_field_get(x, 17, AE_F_SET(x))
+#define PREQ_IE_METRIC(x) 	u32_field_get(x, 21, AE_F_SET(x))
+#define PREQ_IE_TARGET_COUNT(x)	(*(AE_F_SET(x) ? x + 31 : x + 25))
+#define PREQ_IE_TARGET_F(x)	(*(AE_F_SET(x) ? x + 32 : x + 26))
+#define PREQ_IE_TARGET_ADDR(x) 	(AE_F_SET(x) ? x + 33 : x + 27)
+#define PREQ_IE_TARGET_SN(x) 	u32_field_get(x, 33, AE_F_SET(x))
+
+#define PREP_IE_FLAGS(x)	PREQ_IE_FLAGS(x)
+#define PREP_IE_HOPCOUNT(x)	PREQ_IE_HOPCOUNT(x)
+#define PREP_IE_TTL(x)		PREQ_IE_TTL(x)
+#define PREP_IE_ORIG_ADDR(x)	(AE_F_SET(x) ? x + 27 : x + 21)
+#define PREP_IE_ORIG_SN(x)	u32_field_get(x, 27, AE_F_SET(x))
+#define PREP_IE_LIFETIME(x)	u32_field_get(x, 13, AE_F_SET(x))
+#define PREP_IE_METRIC(x)	u32_field_get(x, 17, AE_F_SET(x))
+#define PREP_IE_TARGET_ADDR(x)	(x + 3)
+#define PREP_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
+
+#define PERR_IE_TTL(x)			(*(x))
+#define PERR_IE_TARGET_FLAGS(x)		(*(x + 2))
+#define PERR_IE_TARGET_ADDR(x)		(x + 3)
+#define PERR_IE_TARGET_SN(x)		u32_field_get(x, 9, 0)
+#define PERR_IE_TARGET_RCODE(x)		u16_field_get(x, 13, 0)
+
 /**
  * enum ieee80211_preq_flags - mesh PREQ element flags
  *
@@ -227,4 +259,28 @@ enum ieee80211_root_mode_identifier {
 	IEEE80211_PROACTIVE_RANN = 4,
 };
 
+/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
+static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
+{
+	u8 target_count;
+	u8 needed;
+
+	target_count = PREQ_IE_TARGET_COUNT(pos);
+	if (target_count < 1 || target_count > 20)
+		return false;
+
+	needed = 1 /* Flags */ + 1 /* Hop Count */ + 1 /* Element TTL */ +
+		 4 /* Path Discovery ID */ +
+		 6 /* Originator Mesh STA Address */ +
+		 4 /* Originator HWMP Sequence Number */ +
+		 (AE_F_SET(pos) ? 6 : 0) /* Originator External Address */ +
+		 4 /* Lifetime */ + 4 /* Metric */ + 1 + /* Target Count */ +
+		 target_count * (1 /* Per Target Flags */ +
+		 6 /* Target Address */ + 4 /* Target HWMP Sequence Number */);
+	if (elen != needed)
+		return false;
+
+	return true;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9d89ebcce1c1..a4984b015995 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -35,37 +35,6 @@ static inline u16 u16_field_get(const u8 *preq_elem, int offset, bool ae)
 }
 
 /* HWMP IE processing macros */
-#define AE_F			(1<<6)
-#define AE_F_SET(x)		(*x & AE_F)
-#define PREQ_IE_FLAGS(x)	(*(x))
-#define PREQ_IE_HOPCOUNT(x)	(*(x + 1))
-#define PREQ_IE_TTL(x)		(*(x + 2))
-#define PREQ_IE_PREQ_ID(x)	u32_field_get(x, 3, 0)
-#define PREQ_IE_ORIG_ADDR(x)	(x + 7)
-#define PREQ_IE_ORIG_SN(x)	u32_field_get(x, 13, 0)
-#define PREQ_IE_LIFETIME(x)	u32_field_get(x, 17, AE_F_SET(x))
-#define PREQ_IE_METRIC(x) 	u32_field_get(x, 21, AE_F_SET(x))
-#define PREQ_IE_TARGET_F(x)	(*(AE_F_SET(x) ? x + 32 : x + 26))
-#define PREQ_IE_TARGET_ADDR(x) 	(AE_F_SET(x) ? x + 33 : x + 27)
-#define PREQ_IE_TARGET_SN(x) 	u32_field_get(x, 33, AE_F_SET(x))
-
-
-#define PREP_IE_FLAGS(x)	PREQ_IE_FLAGS(x)
-#define PREP_IE_HOPCOUNT(x)	PREQ_IE_HOPCOUNT(x)
-#define PREP_IE_TTL(x)		PREQ_IE_TTL(x)
-#define PREP_IE_ORIG_ADDR(x)	(AE_F_SET(x) ? x + 27 : x + 21)
-#define PREP_IE_ORIG_SN(x)	u32_field_get(x, 27, AE_F_SET(x))
-#define PREP_IE_LIFETIME(x)	u32_field_get(x, 13, AE_F_SET(x))
-#define PREP_IE_METRIC(x)	u32_field_get(x, 17, AE_F_SET(x))
-#define PREP_IE_TARGET_ADDR(x)	(x + 3)
-#define PREP_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
-
-#define PERR_IE_TTL(x)		(*(x))
-#define PERR_IE_TARGET_FLAGS(x)	(*(x + 2))
-#define PERR_IE_TARGET_ADDR(x)	(x + 3)
-#define PERR_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
-#define PERR_IE_TARGET_RCODE(x)	u16_field_get(x, 13, 0)
-
 #define MSEC_TO_TU(x) (x*1000/1024)
 #define SN_GT(x, y) ((s32)(y - x) < 0)
 #define SN_LT(x, y) ((s32)(x - y) < 0)
@@ -932,6 +901,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	size_t baselen;
 	u32 path_metric;
 	struct sta_info *sta;
+	u8 target_count;
 
 	/* need action_code */
 	if (len < IEEE80211_MIN_ACTION_SIZE(mesh_action))
@@ -955,9 +925,15 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (elems->preq) {
-		if (elems->preq_len != 37)
-			/* Right now we support just 1 destination and no AE */
+		/* Right now we do not support AE (Address Extension) */
+		if (AE_F_SET(elems->preq))
+			goto free;
+
+		/* Right now we only supports 1 target */
+		target_count = PREQ_IE_TARGET_COUNT(elems->preq);
+		if (target_count != 1)
 			goto free;
+
 		path_metric = hwmp_route_info_get(sdata, mgmt, elems->preq,
 						  MPATH_PREQ);
 		if (path_metric)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 5e61457be0f3..9e52cc48fc18 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -547,8 +547,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 				elems->awake_window = (void *)pos;
 			break;
 		case WLAN_EID_PREQ:
-			elems->preq = pos;
-			elems->preq_len = elen;
+			if (ieee80211_mesh_preq_size_ok(pos, elen)) {
+				elems->preq = pos;
+				elems->preq_len = elen;
+			} else {
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+			}
 			break;
 		case WLAN_EID_PREP:
 			elems->prep = pos;
-- 
2.43.0


