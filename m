Return-Path: <linux-wireless+bounces-36777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHfTCzyOD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD55AC82C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5CF5302E7C6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E8228CB0;
	Thu, 21 May 2026 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjPnc8cT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A0369219
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404340; cv=none; b=S0uGbX0tq6E6MfI3PR2rA41P6uUI0rb6BGww8ttj8QBMToZEt44/Wa2UJKhKiHeppmo91p0+nBMIHME2xSfSVfFX4SNK6xDiiv67K71KS9MRorKaRKSa07uUCtFG3mLaOrnX4Kq48Xtuv+Md3clkVW4VtLrwom9gM04U5l7pq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404340; c=relaxed/simple;
	bh=/gVaeaaR/Nul+7yI6e8KWRiT4BTAAc20vWyGG8Ny608=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxS71s4BXXXuX8+uh48mSU5NKTd/vrPOqiJwaOZ4WIavERu8uqr+7Jq0wiIhp/e2e9XQrtz7v9FE+v3fT1RShYPsFXtv2ykXA40QSTvDna+KW26zMKVLjIHh3Gye/bGnlzHxITdZMCnzTv0P+gG5Ga1ivpEIDmPfHhuprSCSlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjPnc8cT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba6485d219so50410005ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404338; x=1780009138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOq+YRJWx9TB0Y7bO+ZdcGgx8/pQckWDl5ZKeK9lCvA=;
        b=WjPnc8cTPittsDe8PxVWroNYjYYC+MO45Vum+iiPd4kN5h9bmpGuZRFQDs5be+761b
         PHFOWZTdWTksndDv6rnINolY4xKMMzYWv828P6HObEJWKCpUUGAp/py7CMMAXcAZc4HN
         GFaGIzNquHf+BcITEfpOCQZp9Vfsd3N56bVQiubfNfImEuoXwbHF6nh4OOZnFZULj+pU
         M9+1RlVW1YWXAvGjJUkBWcjt0qSuvUw9Vl5mzzbVcKCvIIhPz6Zr4rJCCbTBONjhvRkp
         DgcqHimThNSaeLmFAwE98evi0SN85P9lgQVzYUlSkfbM0LJPHBwweQIDLOUDUvpNk06D
         khMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404338; x=1780009138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOq+YRJWx9TB0Y7bO+ZdcGgx8/pQckWDl5ZKeK9lCvA=;
        b=X4YQiMz3FDSbNnZdyO7QFD5LThN9sQP37dKyqEBfjiClp8swi9+f5uxu1Amu+YOXUY
         592zYf8hemsQ6TYAK8aZ05MgR07WD5OBlPB8l2Ld/3/vObSQ6RCcvfQZNr5O/a8Ml+0J
         vij6lfd6/qC4TBRT2MYUFLz9UNY0iZ4rVTkH4aYoiw7krdf2MpcDpCGFZMqZ8teUmCub
         6y51Vl+/YJRMCDfMOQCofs//osCFzsn8rgGKExBDxYk82GDkOPlmFuLMKdns3En51Vt/
         ratPJVpjp13OteIm0aTGUOFAycnjaIFmgs+t/GItlh3jRnuGDFm4+MpJkDj5TgemODNF
         wjHg==
X-Gm-Message-State: AOJu0YxaJSv1uUMhdICgJAdyi5+cC6+tKGP3A1MeGOqSwTOgeDbfOx2Z
	L0sEPN5Vz1sB7n+6XbgPSQgAb6fqjq+saFAoezpmWPP8EqNkjpj3D1q05R3QfQ==
X-Gm-Gg: Acq92OHOhm0cA/9AuQc1VSxbxq46LhqgDJ4h3+8yBIuCt0DlwiHN2DKjgsoat03OuZv
	B7Gsy0kki1JJqaqHdk/dnLMC/a2qB3WvSeyCu3q5zJ2nkvpG2qxxET5yxU0irZcFZQr+XhnlnWN
	BgLXRHsJXIjTpZmkfxaIcMAEB6PyP2frLLlC4E26KXeb+jzwFZxfKrbHCPthzcMGJf/qAkV5482
	P5RKJuxBBu/1+yA3q5+Xu6iSlt50WUjm90HW8ilbrtXdjrWtekW3cV7RbPDPLnMFqlLBD05wRBs
	kKA4XNyehG5n6OG4Za70L/VKnAdSlA8Nt2K8OlkG8O1dL4yxHmyDVQMxvt/Oc1iASoqNeOhHtmn
	dIQADiwGcDggJiPe04f5m2ShU9It+CMijfu3T4anWmdynMJPwVBFApPuWbIUo1V7wVupqCRloHL
	M=
X-Received: by 2002:a17:903:1ae3:b0:2ba:bfc:76a8 with SMTP id d9443c01a7336-2beb057f8c9mr9444045ad.16.1779404338530;
        Thu, 21 May 2026 15:58:58 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13d4c55sm2857855ad.70.2026.05.21.15.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:58:58 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v8 6/6] wifi: mac80211: Fix PERR frame processing
Date: Fri, 22 May 2026 07:58:42 +0900
Message-ID: <20260521225842.31815-6-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521225842.31815-1-masashi.honma@gmail.com>
References: <20260521225842.31815-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36777-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9BD55AC82C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are no issues with the PERR processing itself; however, to maintain
consistency with the previous PREQ/PREP code modifications, I will create a
new mesh_path_parse_error_frame() function to separately implement the
frame format validation and the "not supported" check.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 41 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 14 ++++++++++--
 net/mac80211/parse.c           |  9 ++++++--
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index b4fca2937de0..bd83c647a578 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -365,4 +365,45 @@ static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
 	return elen == needed;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
+static inline bool ieee80211_mesh_perr_size_ok(const u8 *pos, u8 elen)
+{
+	struct ieee80211_mesh_hwmp_perr *perr_elem = (void *)pos;
+	u8 number_of_dst;
+	u8 needed;
+	const u8 *start;
+	int i;
+
+	start = pos;
+	needed = sizeof(struct ieee80211_mesh_hwmp_perr);
+	pos += sizeof(struct ieee80211_mesh_hwmp_perr);
+
+	/* Check if the element contains number of dst */
+	if (elen < needed)
+		return false;
+
+	number_of_dst = perr_elem->number_of_dst;
+	if (number_of_dst < 1 || number_of_dst > 19)
+		return false;
+
+	for (i = 0; i < number_of_dst; i++) {
+		struct ieee80211_mesh_hwmp_perr_dst *perr_dst =
+			&perr_elem->dsts[i];
+		u8 dst_len;
+
+		/* Check if the element contains flags */
+		if (elen < pos - start + 1)
+			return false;
+
+		dst_len = sizeof(struct ieee80211_mesh_hwmp_perr_dst) +
+			  ((perr_dst->flags & AE_F) ? ETH_ALEN : 0)
+			  /* Destination External Address */ +
+			  2 /* Reason Code */;
+		needed += dst_len;
+		pos += dst_len;
+	}
+
+	return elen == needed;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 391d37721b23..a74d7b28a35d 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -957,9 +957,19 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 						path_metric);
 	}
 	if (elems->perr) {
-		if (elems->perr_len != 15)
-			/* Right now we support only one destination per PERR */
+		struct ieee80211_mesh_hwmp_perr *perr_elem =
+			(struct ieee80211_mesh_hwmp_perr *)elems->perr;
+		int i;
+
+		/* Right now we support only one destination per PERR */
+		if (perr_elem->number_of_dst != 1)
 			goto free;
+
+		/* Right now we do not support AE (Address Extension) */
+		for (i = 0; i < perr_elem->number_of_dst; i++)
+			if (perr_elem->dsts[i].flags & AE_F)
+				goto free;
+
 		hwmp_perr_frame_process(sdata, mgmt, elems->perr);
 	}
 	if (elems->rann)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index bbd1e1bc77b4..d84e5e12ad24 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -565,8 +565,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			}
 			break;
 		case WLAN_EID_PERR:
-			elems->perr = pos;
-			elems->perr_len = elen;
+			if (ieee80211_mesh_perr_size_ok(pos, elen)) {
+				elems->perr = pos;
+				elems->perr_len = elen;
+			} else {
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+			}
 			break;
 		case WLAN_EID_RANN:
 			if (elen >= sizeof(struct ieee80211_rann_ie))
-- 
2.43.0


