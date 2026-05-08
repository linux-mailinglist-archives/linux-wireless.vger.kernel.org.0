Return-Path: <linux-wireless+bounces-36123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJSxCtJq/mn3qQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 00:59:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 689074FC8B3
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC3713015084
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 22:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829B3A7F6D;
	Fri,  8 May 2026 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnirUnvy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD013A8746
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281158; cv=none; b=HHu/8bk1Kqh0NrHsdFUyvk9Ogn24rJF4w3KdIcEaMQriayHGlWeHnZdl1KDkRzI7ZsTW6088kElW7vuWQqMGm7HFEou3ruTbeDJGBh42HHV8cUO97UFDDx7WO9r8AihrZyZhuOIa1gNXHy4gkWNXntni722O20W5kU06DoSB/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281158; c=relaxed/simple;
	bh=MuxhZ7/DcAJBSb+eXHtB/Efz3FRU+Hzh+RP73R96AAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnJ9bd8WEipb0EAJdaJ9aWNl455yvwWO0b0sUN8jYL8iOlru7Puyd08WdHoc7SRswqW4x8flL0CQ623jKBLZSstONk/I1l8J8vViW7FqxEsHKJoG8uAVHttJF8aBKVQ+ylGprOPVre6qOus1QbXdrfAvj1+V+/ji1UuHO4TIb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnirUnvy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36535998b71so1325469a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281156; x=1778885956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHQJ20atnCC4y+56eM5GouyWRqWW4vCgBEmnFC6aYyI=;
        b=hnirUnvyAILsyjFUHe6WWJk0RDFeV8OhbXx3D/IIs/Rt+X5JnL1xvXy+ltc56NFQZ/
         W1afPr5oNniVtHDGQVr76lhvhLLoRUBfraNLFTSDuJjLQX5tsVLp4JYaEqPtGSQswMnJ
         ADfsaP8pdLxltFDsEDT6hH/85Pr0kP7wHN9mPbe6KW1rli5/KjBAyC6gx5dY1z/q9qjV
         kJGhkT7WY1wWDJD6Gc6655CZiOTj71DeaZeHBYL1e85BzVFSK5IC2wZGhWUU1tlOsZZR
         6mNrpKaP1VzQndsAAsaMWVNDcgdxopkl37Shamu8wVE+/jIhB7P70zOQ/YqRFzJavg8u
         6Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281156; x=1778885956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sHQJ20atnCC4y+56eM5GouyWRqWW4vCgBEmnFC6aYyI=;
        b=C22sPduVgaRUgAmOM0qt2XojXk/HWFuhade6WQJTZj8bFvzvYNyiUteeel0cVJatIg
         +Z/TAw0bO1RTGApCyaT5pbozEo7fCzTcs3Y6gG4zXSIBI8TbAQjpyddK7eAhnnqurmf8
         icvSJtOkTOA/Kvwfjbs7sPkx3urwDRTcxb/+WRf2hOqK5qfxAJ7D7zNjIfgCbKW3/ipl
         t7f63JngalQZ0FSNmJoRmSjSuaqlN1AF4y/2mUvZ9ioT/a1awOJoSNxeFLicHmn9cYe5
         au/awqug9ZnN07OxP4bbdh7cGHi6l5WNQ/HEYwMLeDxSNdBFbkM0z9T3//MB2vqKIr++
         sKRA==
X-Gm-Message-State: AOJu0YxRBxW9AZIHo/E4d3ReMwSwaeWNNudWD9BIkdDn6aBRGZ4RBEfh
	dIYE+Yf+iJleieDX0gD+M+JUMyusKs3jkWQkOWM/RPTy57IrumUB5FNGJg3nBg==
X-Gm-Gg: Acq92OF9ues1xsJp2wxmlwucIPtx0irEKorGmVkFXZepnQgjPuYWdcfybexmkVtG1tR
	GUA1k3uxGYyC8OvAcWZWfb6VcN1sJgyRcbxcShFJmC8ZthmZKdzIkt2zBcZIxCsyvxwrutWjl3M
	x+FN3FMKLhicZqnDBroovlX+q6egbmARej0tsc0jU4x4g1VkrsuxYT8vT4YMCHFp+1oe5fYPnn6
	4OlVwQVuRfh4xTxJ1mvjsnoBii6A6a24UHdSApu+eJNkNjz984VNd7AFG03ZAkLH5//wHuI5MqR
	bwnbHGrxtBNyN2EoixOibVhLRBnj8HIAkdK8BsW6SUEEIdtNRfE2ed6DKY4iQ7dt1f0u3eYjTjY
	7bw9cchKneSdP6FNGPW7SJDruoxM8Jj9A77uNY1XiBqBsDLCRjArK6MCyMRudcdCMtWN0UoOr5K
	QpSDAniw==
X-Received: by 2002:a17:90b:3c8e:b0:364:52d1:32b6 with SMTP id 98e67ed59e1d1-366055e2b88mr7602644a91.10.1778281156103;
        Fri, 08 May 2026 15:59:16 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6276::23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d683fb92sm74472a91.12.2026.05.08.15.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:59:15 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 3/3] Fix PERR frame processing
Date: Sat,  9 May 2026 07:59:05 +0900
Message-ID: <20260508225905.29998-3-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508225905.29998-1-masashi.honma@gmail.com>
References: <8f0a2488540f4a65ea4d837a06225a27a10cc305.camel@sipsolutions.net>
 <20260508225905.29998-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 689074FC8B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36123-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

There are no issues with the PERR processing itself; however, to maintain
consistency with the previous PREQ/PREP code modifications, I will create a new
mesh_path_parse_error_frame() function to separately implement the frame format
validation and the "not supported" check.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/mac80211/mesh.h      |  1 +
 net/mac80211/mesh_hwmp.c | 48 ++++++++++++++++++++++++++++++++++++++--
 net/mac80211/parse.c     |  7 ++++--
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index aba7ef59195a..610c34e35e64 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -319,6 +319,7 @@ void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop);
 void mesh_path_expire(struct ieee80211_sub_if_data *sdata);
 u8 mesh_path_parse_request_frame(const u8 *pos, u8 elen);
 u8 mesh_path_parse_reply_frame(const u8 *pos, u8 elen);
+u8 mesh_path_parse_error_frame(const u8 *pos, u8 elen);
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len);
 struct mesh_path *
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9f903a2408f7..2a293b771f79 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -62,6 +62,7 @@ static inline u16 u16_field_get(const u8 *preq_elem, int offset, bool ae)
 #define PREP_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
 
 #define PERR_IE_TTL(x)		(*(x))
+#define PERR_IE_NUMBER_OF_DST(x)	(*(x + 1))
 #define PERR_IE_TARGET_FLAGS(x)	(*(x + 2))
 #define PERR_IE_TARGET_ADDR(x)	(x + 3)
 #define PERR_IE_TARGET_SN(x)	u32_field_get(x, 9, 0)
@@ -968,6 +969,42 @@ u8 mesh_path_parse_reply_frame(const u8 *pos, u8 elen)
 	return 0;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
+u8 mesh_path_parse_error_frame(const u8 *pos, u8 elen)
+{
+	u8 number_of_dst;
+	u8 expected_len;
+	const u8 *start;
+	int i;
+
+	number_of_dst = PERR_IE_NUMBER_OF_DST(pos);
+	if (unlikely(number_of_dst < 1 || number_of_dst > 19))
+		return IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;
+
+	start = pos;
+	expected_len = 1 /* Element TTL */ + 1 /* Number of Destinations */;
+	pos += 2;
+
+	for (i = 0; i < number_of_dst; i++) {
+		u8 dst_len;
+
+		if (unlikely(pos - start >= elen))
+			return IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+
+		dst_len = 1 /* Flags */ + 6 /* Destination Address */ +
+			  4 /* HWMP Sequence Number */ +
+			  (AE_F_SET(pos) ? 6 : 0) /* Destination External Address */ +
+			  2 /* Reason Code */;
+		expected_len += dst_len;
+		pos += dst_len;
+	}
+
+	if (unlikely(elen != expected_len))
+		return IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+
+	return 0;
+}
+
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len)
 {
@@ -976,6 +1013,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	u32 path_metric;
 	struct sta_info *sta;
 	u8 target_count;
+	u8 number_of_dst;
 
 	/* need action_code */
 	if (len < IEEE80211_MIN_ACTION_SIZE(mesh_action))
@@ -1026,9 +1064,15 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
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
index cdc549055242..dfc326db0471 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -561,8 +561,11 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			}
 			break;
 		case WLAN_EID_PERR:
-			elems->perr = pos;
-			elems->perr_len = elen;
+			elem_parse_failed = mesh_path_parse_error_frame(pos, elen);
+			if (likely(!elem_parse_failed)) {
+				elems->perr = pos;
+				elems->perr_len = elen;
+			}
 			break;
 		case WLAN_EID_RANN:
 			if (elen >= sizeof(struct ieee80211_rann_ie))
-- 
2.43.0


