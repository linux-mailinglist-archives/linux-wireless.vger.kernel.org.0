Return-Path: <linux-wireless+bounces-36140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABzLDk3G/2kA+gAAu9opvQ
	(envelope-from <linux-wireless+bounces-36140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 01:42:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF42502040
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 01:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADCA63044214
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F0393DFB;
	Sat,  9 May 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjdQgWZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2293D6CB6
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778370112; cv=none; b=Wc+zFZ8if11eT6vrfQzNKrjdbbKqsayZ24ubVm6nePQACo/WEZ5l1lkvo5mGo6tQBNpGsjnwpV9cKl7v2HvfJQjCUEKYUGUjaXAEsogfcQ3HB24jWhN1I7/0d+guXOZfy5J5rxzg3X2oioQws95kXjTKpCEBBzF0T+3UGV1z37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778370112; c=relaxed/simple;
	bh=RU1DSS6fWX9DNra06u05IiplcP5DZhi5BkwJg9SIIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHshHU6WWDwFtUicGXyW8f1Xval6uNjI0GI6YdM0QVaLSb5DwFUbOjaRADiif2LCjERIBG2IX/OpEdUBfwSVCiu1wVEivYD8zzWPvnXDIprSccIQ1eViGVkU9Jvp36RTE9kyJwZnkECkf8wawOsUmcaXoSoaaP0jRmEsdcHigDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjdQgWZf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b4583f0a1aso19934195ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778370111; x=1778974911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RTH2n85dPVO8zg9pFqBGeJkGTlZZNxB5AQ23sJxpPA=;
        b=CjdQgWZfVlvdrkBpEZXS+j2t+jQrfKhniH+lNWo967HMgRcAaSKFr7V1tI+XUSjzYH
         rLcI7662kRExDCY9nPEqjdfXi10rXjYwINyi6y69+T8lVbd6xeby9LMI3mWgc/I5rkHU
         vp80akqurR70XT9BOJBBQnV7Oyr0W+oLxaPkNEMtU808RtAVe0UB8Fh7oZU82i1pBzGO
         KxJGl0tWXlqLzp/t+Ht/Ys90kATAOrgDRnWaFRysK5inLLYcfQ4MSK6dfRKLWLkE+Kyz
         PV/bkGHMVdNoxH8UgxcrNAXl0euuR7Q/B6SELymsBYEG7BwkNtfc1Oldk7V4TIEIiTj3
         DX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778370111; x=1778974911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RTH2n85dPVO8zg9pFqBGeJkGTlZZNxB5AQ23sJxpPA=;
        b=EfXcBRj4D4yfTheHFYS1ei5M+2pcVYbwpPExdf7IM0fqjMd14gmwg33UZYMeuBPuje
         LmdwS9GI/LeGSMByPTt4UMNlIWBK/hAtBFuIvslKIZ2OBzy+M9MsrfFhOCb7MVG8w++l
         ZJVhJDXyVkyZYxjWexLaNS+1GMx5/+n2aljAC2adlbbxgaj5mfVG01q4YLtTBIhx6LFX
         877ghL2KKZeLKDhMCYZqISmfCcuL+euiAWvMgLLo46RjCCExm9uWmFyB/nhrSeZFxGmj
         hNSNkVYf1tU+N3W5ajUBLpfN4wENn1c0lPU0l0tD7wyZ/jTF8JbuZoQHdT5DzBoxCBup
         7H+w==
X-Gm-Message-State: AOJu0Yzftzvk+qXU5bkGNvwN/MWy/ppzhKcl1ISGuNkfRl9B8Ofevb8Y
	/3tZohxI5jP5Z42d/WITDCdd3W4+Bph5GhQ95lAQlxcatykm5MzfNeBYutmzEA==
X-Gm-Gg: Acq92OEgeGdAoFYCKV4UwpjmhXgG/1mcC2eQ05NtPCiiasmAOEqUyashf1w0K4fMlaB
	pNevxszaAUxV3IJCvnzndqxD8bvZKU0p9Zan1+kJK5/l1N94adfVv6frVj26rs5+QU7U3gX2doC
	2KqKu7d8ZVKj7e3hca6OTg22yF6NmQ72JHOjig84qEbR+pXASxFA8eImehlFKhC1VqYJsmJwyTA
	TEU/asJya2zdAtp2WbAJMFPl5ZAjGq1PltfTweseZYT/2wDAQY4kfiYcQQvSD9SEr5be3EdIB20
	oOzn5ikcEQSgkh9DmmjS7bsr7dn+oFrPUI5/6pgWHHDRlhiox2fhmcWu4LO4xdBrUXJOJQ8bH4N
	NFfBMAkENYV9ODKNbc91vuN1wlI1dOIEswxiixLCwkKfvAJhNvcYOgWhBZkA0vW9jNHfBrzbDaL
	3hrZ10EgcjwkWkt3E2Cq7a+XCkeQ==
X-Received: by 2002:a17:903:1984:b0:2b9:59ea:7eba with SMTP id d9443c01a7336-2bc7a9b74fcmr38265415ad.13.1778370110647;
        Sat, 09 May 2026 16:41:50 -0700 (PDT)
Received: from ryzen9.. ([2409:11:4b40:1900:7ef3:a74c:6b41:8c9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm61078635ad.1.2026.05.09.16.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:41:50 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 3/3] Fix PERR frame processing
Date: Sun, 10 May 2026 08:41:43 +0900
Message-ID: <20260509234143.101237-3-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509234143.101237-1-masashi.honma@gmail.com>
References: <db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
 <20260509234143.101237-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDF42502040
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36140-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

There are no issues with the PERR processing itself; however, to maintain
consistency with the previous PREQ/PREP code modifications, I will create a new
mesh_path_parse_error_frame() function to separately implement the frame format
validation and the "not supported" check.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 38 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 11 ++++++++--
 net/mac80211/parse.c           |  9 ++++++--
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index ddbf475c1cc8..1bca65e49309 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -61,6 +61,7 @@ struct ieee80211s_hdr {
 #define PREP_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
 
 #define PERR_IE_TTL(x)			(*(x))
+#define PERR_IE_NUMBER_OF_DST(x)	(*(x + 1))
 #define PERR_IE_TARGET_FLAGS(x)		(*(x + 2))
 #define PERR_IE_TARGET_ADDR(x)		(x + 3)
 #define PERR_IE_TARGET_SN(x)		u32_field_get(x, 9, 0)
@@ -301,4 +302,41 @@ static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
 	return true;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
+static inline bool ieee80211_mesh_perr_size_ok(const u8 *pos, u8 elen)
+{
+	u8 number_of_dst;
+	u8 needed;
+	const u8 *start;
+	int i;
+
+	number_of_dst = PERR_IE_NUMBER_OF_DST(pos);
+	if (number_of_dst < 1 || number_of_dst > 19)
+		return false;
+
+	start = pos;
+	needed = 1 /* Element TTL */ + 1 /* Number of Destinations */;
+	pos += 2;
+
+	for (i = 0; i < number_of_dst; i++) {
+		u8 dst_len;
+
+		if (pos - start >= elen)
+			return false;
+
+		dst_len = 1 /* Flags */ + 6 /* Destination Address */ +
+			  4 /* HWMP Sequence Number */ +
+			  (AE_F_SET(pos) ? 6 : 0)
+			  /* Destination External Address */ +
+			  2 /* Reason Code */;
+		needed += dst_len;
+		pos += dst_len;
+	}
+
+	if (elen != needed)
+		return false;
+
+	return true;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index c70cfc2d6299..d2295aa54bb4 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -902,6 +902,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	u32 path_metric;
 	struct sta_info *sta;
 	u8 target_count;
+	u8 number_of_dst;
 
 	/* need action_code */
 	if (len < IEEE80211_MIN_ACTION_SIZE(mesh_action))
@@ -952,9 +953,15 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 						path_metric);
 	}
 	if (elems->perr) {
-		if (elems->perr_len != 15)
-			/* Right now we support only one destination per PERR */
+		/* Right now we support only one destination per PERR */
+		number_of_dst = PERR_IE_NUMBER_OF_DST(elems->perr);
+		if (number_of_dst != 1)
 			goto free;
+
+		/* Right now we do not support AE (Address Extension) */
+		if (PERR_IE_TARGET_FLAGS(elems->perr) & AE_F)
+			goto free;
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


