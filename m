Return-Path: <linux-wireless+bounces-36775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MM7ATSOD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CACE5AC810
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95DA8302A7E5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF8228CB0;
	Thu, 21 May 2026 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyYL97hH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9C367B64
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404336; cv=none; b=ERhQVRXzrrDT+oKR7L0yQ6jE3zwjfLjQS2YdiGkCUcjXiBbqNJJ3p4dAOUOgrn6YKvNROJksdmO11NOkSUrm4jEnyrT1MepU3HhLFqTtedlGw6pvrNB6u1XJT8Jya1F8pjV4qvxwJ6Wrn05bntdtH5XrYAwWq6xA7BHBfSU5cWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404336; c=relaxed/simple;
	bh=Q0QQE6uZm/okTI/NFG2y22e1MkwWlq5WuwtXizYS+e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBKaTxGYRIYpzcFdBDSVbcLlZl5EvEtEHYyuNpSCffiv06vnTCLIWLaHj2rxIFKzPnXZbZt69hBNgq2biOhjG6J+ZDxJhrw75dvwnnizNplB8SWKJH0JlwoL/Wq+QGyfoz5ieRJuxYWc87HrSXHgof7mSpCd7ItuVtAjqTaUbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyYL97hH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bd2c147abaso40449745ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404335; x=1780009135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duutdyo4b9hbq/Pe+KJ/8aTd1+oGranmN6MPnC6F+zQ=;
        b=HyYL97hHSbtxut2LO5TJFNUqpOqybLuKrV3HAm92aSShyM8pHJUrz5BYDYCteC0S+t
         nEzqBJ8sI0/aw29VIqra/zE5u4mLQnF4W0jl78dy0J565CynGrRwGnbDXPB7v3JgrjfJ
         AqIz16l86MHgwBSUQ9OrgObA7O39F0QZjEMNTNjSbgsSQ732OH47yszx9i50EbEeWSGE
         Mhd6HmadI5BDQ3x+HzXuIQWTGU9TlDpKT8MmAEjdULJ+KlzLCjXqp22kT7ZZfI0YIoFZ
         x9CUSSzvRx9gokdSsOgFc5wMluHG1OpzHCkisMWKCg7mE2Fl92r3Efct8LQ/ESOY2O8p
         8LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404335; x=1780009135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=duutdyo4b9hbq/Pe+KJ/8aTd1+oGranmN6MPnC6F+zQ=;
        b=ScL83osj4rmCl8v7xy/NolEL6gc0JmFbOO4w1QPsghCmZ5k0/4OG+0Dp30ROqNkxOb
         abzD6/fKfanlBq/mXjtvyFFeU+ALBJWc4oV3wSzxEGPOH2m0xnM+DAaPwTOdEmkNFLVs
         A6AbiAxU+Nx3qEPncKmIlgcbDXYC9eiSzVe56BNRGVeabx7+GNrUitNHTgG4qhFWm/ya
         FHAM31HyxCMdbJrXG3aflDKnnYK87CpT6zr12kLxIlV0Up9BWLzJBTRtoroRs046N1eX
         6lMvmv4h2eJrD9mt0AGpUbillG6h1zl0UvnLEYgR7f+e+66Pzjl3yuu+7eQ08VpIg7gV
         iiAA==
X-Gm-Message-State: AOJu0Yw+erH9Yng7wmNdpJM3IgNGof9k/cnglWaXqdXQdj2DsEUz/1hQ
	HciAbj1aOgDBZuHc+pkR9uMhI/QsIvbsab942zcWiXICG08xAU3QV8pbwR2gaw==
X-Gm-Gg: Acq92OF+75fYUFyOyAaXR9rlG/JjdP++enjICCEP9PEQWW1gKTsJrYuakyXb/QuGpj5
	aoRlhf6K/IHFtcd4X3ZWxGFm8UOOIgsPoUb0GvTxFWB0HRGEVM91clhknMbkk07MenEA6QT2cfI
	BomZ5cRMjcTE+dzfbjKxOBhqEgzXMjc+qd6qPZ7iNh7EV//j8XB4gWQAxSkDoAiaKdXlBhUb9cD
	tTzAlmMmFVnAmWJPqjCDYm3gCM4rgiUDSnbvrv/0ypiADvYqylSClw3IQ7aHbZpoC0wgG7kaCEF
	5twoKTcSX1WBh+/4u7hDMOq03XxqvZFRk5NwT7ltAOoFfYLAe+IMsFR9PokdZa4NRwvVXKzBDlK
	vl17pZf+JaQPTVa4eRvFow76eXIN0AKy90pPJKMh/kAWRK6Ln+oAurTRuqvD20f/3kMh2I4s4r+
	o=
X-Received: by 2002:a17:903:3c2d:b0:2b2:42b1:adac with SMTP id d9443c01a7336-2beb031af0bmr8381215ad.3.1779404334732;
        Thu, 21 May 2026 15:58:54 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13d4c55sm2857855ad.70.2026.05.21.15.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:58:54 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v8 4/6] wifi: mac80211: Fix overread in PREQ frame processing
Date: Fri, 22 May 2026 07:58:40 +0900
Message-ID: <20260521225842.31815-4-masashi.honma@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-36775-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 8CACE5AC810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AF flag is enabled, hwmp_preq_frame_process() overreads
target_addr by 2 bytes. Since this occurs within the socket buffer, it does
not read across memory boundaries and therefore poses no security risk;
however, we will fix it as a precaution.

In this fix, a new function mesh_path_parse_request_frame() is established
to separate the implementation of frame format validation and the check for
unsupported features. This is intended to facilitate future work when
implementing the currently unsupported parts.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 28 ++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 12 ++++++++++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 0e9bd56b54f2..42a5bd73838c 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -321,4 +321,32 @@ ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
 		(dst->flags & AE_F) ? ETH_ALEN : 0]);
 }
 
+/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
+static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
+{
+	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+		ieee80211_mesh_hwmp_preq_get_bottom(pos);
+	u8 target_count;
+	u8 needed;
+
+	/* Check if the element contains flags */
+	if (elen < 1)
+		return false;
+
+	/* Check if the element contains target_count */
+	needed = sizeof(struct ieee80211_mesh_hwmp_preq_top) +
+		 (ieee80211_mesh_preq_prep_ae_enabled(pos) ? ETH_ALEN : 0)
+		 /* Originator External Address */ +
+		 sizeof(struct ieee80211_mesh_hwmp_preq_bottom);
+	if (elen < needed)
+		return false;
+
+	target_count = preq_elem_bottom->target_count;
+	if (target_count < 1 || target_count > 20)
+		return false;
+
+	needed += target_count * sizeof(struct ieee80211_mesh_hwmp_preq_target);
+	return elen == needed;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index fa144a187fe2..ad3e575a0a94 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -929,9 +929,17 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (elems->preq) {
-		if (elems->preq_len != 37)
-			/* Right now we support just 1 destination and no AE */
+		struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+			ieee80211_mesh_hwmp_preq_get_bottom(elems->preq);
+
+		/* Right now we do not support AE (Address Extension) */
+		if (ieee80211_mesh_preq_prep_ae_enabled(elems->preq))
 			goto free;
+
+		/* Right now we only support 1 target */
+		if (preq_elem_bottom->target_count != 1)
+			goto free;
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


