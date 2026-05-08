Return-Path: <linux-wireless+bounces-36121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP4XNclq/mn3qQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 00:59:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF24FC8A5
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 00:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D293A300B50A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E83A6EEF;
	Fri,  8 May 2026 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaUEtvBg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A617A376467
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281154; cv=none; b=gPlj9YgSMSnS0BW93D8snJfdgtdc3xRHqBYwwEDbGLA/v9nw7Xa2SCPaMWozyWP+wUyx7LaOO5SfpALFmrN6QzaLtoo0/3OOQoz9+KCOmb4v2EfnjQrQZcSvrTPa0e1FycgP5B75WUWrOtZuQpiGl1R8IUn9wnS9cPEBdNFC6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281154; c=relaxed/simple;
	bh=gzmxwJLagtDcgwAkKrLHoqzrx2K/lSk7Rrpfalv3XN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgU9Rd925Y3vjZIFc0quvmRBykTdZUWVLx8JZkDFiOlZVyZsUWzkwHdcJQqoduaRaTsWag7YfiENOpPUWAvabSKM5veJ/2aarENEOArjaLl5TCDY/HrgI5Ivt6v/VzgIdINl+ar8tMTq4dpgRQ4RENp3/6aMljzvIx2eQtzBMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaUEtvBg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366375c4076so1010613a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281153; x=1778885953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak40ZGRW7kVdY/B5y7nbu0Gu6XypXbGhOa+my3ST+IA=;
        b=UaUEtvBgjIaOadEF67cutcqwTnY6cgk3FjMePzMWSQNqO9dZ1BqWQ0I29FoEI3zVLn
         BxdmHrSOPDZfBnAm2wWg3CznHqbnYVROaC/UKMrLRN8N9fMZxnLuvvz/Ei3xY2vI7STS
         rp1SJcfmFBa3Au9VgqmW8bTmyhoILRsFSQk9DVyf0ImRxmF4IIjtjRacvp06dhJw5kiL
         dw0vMaSUw1UFyhOLg2rYLixWdthpDB0RGgoENAFyw9MScrVRSjDzE2ipOXsNE/Wok0a3
         ZMjfBc56CPA4d0dVolusKSX2g1tQiBB+i1W3wylAbEna3cV3n+Z2jcaFNAQqzJRstOKs
         KDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281153; x=1778885953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ak40ZGRW7kVdY/B5y7nbu0Gu6XypXbGhOa+my3ST+IA=;
        b=LdPj/O9YoydVZbr6mWudW5ejrMLOV6bRVaNnmEK4ME994bLJD90t0v363KtNVPqYTo
         U4pazppNpxGsq150EvTwD+Mseflz1KWbv6P6KEqsHjOMorRmPfDZD3sMtyqgcU7/n4oT
         XrON7cfDEYzrnhFg3A6CbPdgWXQ9wpVPtoDFpwQcOiX1CxEjJPJESm1C6OdM1M3Z8zof
         GNeJQr/tDkiFZxmz3yug+fT7jV/DQBCYy0vnHHe4QtT8gVUXrzpqMvMmd+sqTliKlQoO
         Yix4G6iHVuCLZ45zbWjflctlaZIjEfWCA1j8Q9uCst0lN2zGGdFZDFqe0cKncC1Ddflx
         Ya7Q==
X-Gm-Message-State: AOJu0YyWTkLwIogneq9Y+EyDwAapCzoXuwPhWR4JKgTFqUuENVskWYLu
	Gd23OsoFeLxhj9a65VNYGwRqzEeOkIvLLR2Uq9I0jixdsrbecuww03sdZgumSA==
X-Gm-Gg: Acq92OH6a0ao0O5MT+u924/tJs07gOMO6h9IW7ik9gBbhEB2Vy/PjojBWJOmm2/FuB8
	ptceUrPdwde/IkE6kJP35lO+sn3X6wjt3evgFtvYo6Zhlv+xnWMnEwZ1Bmh/nze+kVm05CpBdrU
	3BVKi5CLPrRTiO07T2LxY/os6ulkIenf9iYzfxS93Uxdi98wJtKnWW41QZ3Kv6d38XYYX0qupAE
	qUoWY/Iyf5hY5slGqOEJg8zqKN5coOACpB+N0DDlxDch8MkcDCiBA5UORJwh6EoX2s8ssTi/hmW
	BHuhxDl4yf5DwJSoZaRGm/tV7Ff0q2xRzyKimover5frihkLRjk8DtJpoIVax28+KhIbmy3k+fD
	nX4Na1F1qbX4z1vnFMd0et0cclY31nXy8ST16HOxzfknWx3X2ksrrodhuvVYa7NUd6fA8HeSmh9
	qroqUWcQ==
X-Received: by 2002:a17:90b:4a84:b0:35f:bd51:cf60 with SMTP id 98e67ed59e1d1-367d46c7c28mr409540a91.1.1778281152899;
        Fri, 08 May 2026 15:59:12 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6276::23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d683fb92sm74472a91.12.2026.05.08.15.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:59:12 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 1/3] Fix overread in PREQ frame processing
Date: Sat,  9 May 2026 07:59:03 +0900
Message-ID: <20260508225905.29998-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8f0a2488540f4a65ea4d837a06225a27a10cc305.camel@sipsolutions.net>
References: <8f0a2488540f4a65ea4d837a06225a27a10cc305.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9CF24FC8A5
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
	TAGGED_FROM(0.00)[bounces-36121-lists,linux-wireless=lfdr.de];
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
 net/mac80211/mesh.h      |  1 +
 net/mac80211/mesh_hwmp.c | 35 +++++++++++++++++++++++++++++++++--
 net/mac80211/parse.c     |  7 +++++--
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 3f9664e4e00c..331d2d774196 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -317,6 +317,7 @@ struct mesh_path *
 mpp_path_lookup_by_idx(struct ieee80211_sub_if_data *sdata, int idx);
 void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop);
 void mesh_path_expire(struct ieee80211_sub_if_data *sdata);
+u8 mesh_path_parse_request_frame(const u8 *pos, u8 elen);
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len);
 struct mesh_path *
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9d89ebcce1c1..4239412d12c7 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -45,6 +45,7 @@ static inline u16 u16_field_get(const u8 *preq_elem, int offset, bool ae)
 #define PREQ_IE_ORIG_SN(x)	u32_field_get(x, 13, 0)
 #define PREQ_IE_LIFETIME(x)	u32_field_get(x, 17, AE_F_SET(x))
 #define PREQ_IE_METRIC(x) 	u32_field_get(x, 21, AE_F_SET(x))
+#define PREQ_IE_TARGET_COUNT(x)	(*(AE_F_SET(x) ? x + 31 : x + 25))
 #define PREQ_IE_TARGET_F(x)	(*(AE_F_SET(x) ? x + 32 : x + 26))
 #define PREQ_IE_TARGET_ADDR(x) 	(AE_F_SET(x) ? x + 33 : x + 27)
 #define PREQ_IE_TARGET_SN(x) 	u32_field_get(x, 33, AE_F_SET(x))
@@ -924,6 +925,29 @@ static void hwmp_rann_frame_process(struct ieee80211_sub_if_data *sdata,
 	rcu_read_unlock();
 }
 
+/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
+u8 mesh_path_parse_request_frame(const u8 *pos, u8 elen)
+{
+	u8 target_count;
+	u8 expected_len;
+
+	target_count = PREQ_IE_TARGET_COUNT(pos);
+	if (unlikely(target_count < 1 || target_count > 20))
+		return IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;
+
+	expected_len = 1 /* Flags */ + 1 /* Hop Count */ + 1 /* Element TTL */ +
+		       4 /* Path Discovery ID */ +
+		       6 /* Originator Mesh STA Address */ +
+		       4 /* Originator HWMP Sequence Number */ +
+		       (AE_F_SET(pos) ? 6 : 0) /* Originator External Address */ +
+		       4 /* Lifetime */ + 4 /* Metric */ + 1 + /* Target Count */ +
+		       target_count * (1 /* Per Target Flags */ +
+		       6 /* Target Address */ + 4 /* Target HWMP Sequence Number */);
+	if (unlikely(elen != expected_len))
+		return IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+
+	return 0;
+}
 
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len)
@@ -932,6 +956,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 	size_t baselen;
 	u32 path_metric;
 	struct sta_info *sta;
+	u8 target_count;
 
 	/* need action_code */
 	if (len < IEEE80211_MIN_ACTION_SIZE(mesh_action))
@@ -955,9 +980,15 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (elems->preq) {
-		if (elems->preq_len != 37)
-			/* Right now we support just 1 destination and no AE */
+		/* Right now we do not support AE (Address Extension) */
+		if (AE_F_SET(elems->preq))
 			goto free;
+
+		/* Right now we only supports 1 target */
+		target_count = PREQ_IE_TARGET_COUNT(elems->preq);
+		if (target_count != 1)
+			goto free;
+
 		path_metric = hwmp_route_info_get(sdata, mgmt, elems->preq,
 						  MPATH_PREQ);
 		if (path_metric)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 5e61457be0f3..7a2abe676361 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -547,8 +547,11 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 				elems->awake_window = (void *)pos;
 			break;
 		case WLAN_EID_PREQ:
-			elems->preq = pos;
-			elems->preq_len = elen;
+			elem_parse_failed = mesh_path_parse_request_frame(pos, elen);
+			if (likely(!elem_parse_failed)) {
+				elems->preq = pos;
+				elems->preq_len = elen;
+			}
 			break;
 		case WLAN_EID_PREP:
 			elems->prep = pos;
-- 
2.43.0


