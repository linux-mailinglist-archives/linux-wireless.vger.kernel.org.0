Return-Path: <linux-wireless+bounces-36504-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL6pFpeuB2pHCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36504-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:39:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECE559601
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D7DF30095FC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13473374721;
	Fri, 15 May 2026 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU+7j6rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0B3F6C5F
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888335; cv=none; b=GKNNILshp4GWnmSRWXLuwy2/pMS35Nv9a+chNtWnvel4uUGfs/fXxFZ0613jxjNp2if1JhLa1nyFqrbHiRYWOLEny69qEkr3pK0tI9Y6aYLvS7HZQtXs+sfv6YuZbwHVg2ltCm5nHJEBbhgNBh9P9DVlKN/ZAwprL3hd+mZGKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888335; c=relaxed/simple;
	bh=whjROk2Rgw9iBDe962oqBJ3gwW+eA5E62nAd/WEEpZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edEncVgXj/BXGKGVjiEPO5EtLD1V6ALziR7OHygvzXE3jEoBR0M/nLKtZN94iFJv8e4MflHYJ9ibLDGMNpjHhIhbf1hDDCsvRrX8/KHuClzMAboDlwnDBRWEk5rKQQ+exgPv6rtpGPoDxMsYbY8iOcG7b1OkPSyTEQnoHoqwzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU+7j6rc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c828daf83e2so142384a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778888333; x=1779493133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEZVTK+lYuw3IKxLKeVLdoU1/vwhvSIV1aopOOwc/Ww=;
        b=dU+7j6rchQGdRO3DgLdFLs+0XeJJP3pVmrYHTDpLl5PjLg1YdnG/GPGOcriICMaA/b
         GvKYzwzyUWvBcqJeST+YLhm3cNSWugCnbrsbXfsNbUHZCNVWNwaMXI9KzW5WMD3JyBjx
         O0JEt5J9UGn++5WcgSfdsK3HobRSS7l/K0gOMLZVwQkSnJuOsj0Hkfq4+dT6NVlgs5r8
         7Ye+/vfifbsRx8E/80z9XSGmnx/+BWDRq60MJtl2JRm4/cm6YO2wcqS/K8/ywOyKBlMt
         F+k4vsV05LWa27QNq+bVrwbx34+4xZvnecPYhQDveK8bn65hMX5vUkNgG7GAj2hYviup
         nz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888333; x=1779493133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEZVTK+lYuw3IKxLKeVLdoU1/vwhvSIV1aopOOwc/Ww=;
        b=MJP25WXWcg3yPedrZkN95XNScfMHSc3btdfU80TUbDSmiQU4JlwBydEwcXdvZvsd/9
         qg4EiKN4Q0j66HKsnS4+5d+/tUzfYPuuNto2fyiRW7BaJHiv2g4JOhU2KgFOLU36P0VT
         CRtlioRLQLNRSoCliWdTT1P+jH48kzcla42iPMGvtrB0W6lP1glYBGGeNptq3JzXH0ek
         sJmqfqSBWCHtRQV73a1ltOr97+n1Y8/0xlM1x7WNoTkrZm9g8kDwonV0lBp1Ij7JDRpi
         whMmZnyCDXkp+r8vLoQj7lD67mLlT+kYro3Ev/jJXRpBGuYMrTgv9R2HL3SOwqykiZu3
         uudA==
X-Gm-Message-State: AOJu0Yze8zzfnHWaydltEPnt404Yb+j7+VZLyCw5caY8aQiFy/9lcJie
	2JXRgKkd47IUVyjwtQfZXNjcRwJ6bQ7OduO6526Dz6Zr9EkFaRG+q6fZ+QAL7Q==
X-Gm-Gg: Acq92OHgWSww2Oys4VrRNvUlr0OGhox0LKnGzqvYV9Gl3/tqexu8nXT9GnYrqj/N8tR
	yvSmA7DmuICNWVrnvZsGjGeSTXWA0yU5v0PMq820STFmI+2vVMzLmmzY6gG4QTAsCyUNynzI1BU
	9b6a5J3sRgVpki/Kcx5gkftaLX5UV6Oeb4j9PluJWj3+e/d3ZnOEYvR6ajsWKOHFDi+1LQdzZuX
	jRkA909ypgNQjhUk2u0XFP1DFzHvLKuwptkXPiAaotWiWc1NiLphDje6H5jED+QIbtTabU2pZE8
	D5mPCrFY484HK4RchddchOioA5GVBxJViWU3XTfiVibUQqJNOlJpE7Q3UUI1ZCYe0TucyEHNmv2
	lUHi2KZ9JILrHpSifxGRjE9v6udINO5oYSSyL4gdtBQ/VkfwUciDcJ5YITJEqr5sV1e7dv14lco
	0=
X-Received: by 2002:a05:6a20:e212:b0:3ae:c3c9:29c3 with SMTP id adf61e73a8af0-3b22ece9489mr6960963637.49.1778888332891;
        Fri, 15 May 2026 16:38:52 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm6391265a12.14.2026.05.15.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:38:52 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v6 4/6] wifi: mac80211: Fix overread in PREQ frame processing
Date: Sat, 16 May 2026 08:38:37 +0900
Message-ID: <20260515233839.86829-4-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515233839.86829-1-masashi.honma@gmail.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53ECE559601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36504-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
 include/linux/ieee80211-mesh.h | 31 +++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 12 ++++++++++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 6b56f462fc21..2ff94da770b1 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -324,4 +324,35 @@ static inline __le16 ieee80211_mesh_hwmp_perr_get_rcode(
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
+	if (elen != needed)
+		return false;
+
+	return true;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 044555c42a86..70973d53605d 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -932,9 +932,17 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
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
+		/* Right now we only supports 1 target */
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


