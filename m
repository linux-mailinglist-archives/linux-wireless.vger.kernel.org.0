Return-Path: <linux-wireless+bounces-36776-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLM3OjeOD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36776-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6495AC81E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1441F3030D2F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66F1228CB0;
	Thu, 21 May 2026 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2TgKjCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272B369207
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404338; cv=none; b=NGgTJDWR8VMnrWPNC0RRg0jvjDWoUknYpcYN5l4Vricexu2i0TltfGrzTVpJRgLPo34RXVQ/K1fMBB/BXz9Y36gQ66KEC5fMwr27QCuu+/esPKjEcHX1QuWx9mkkZjX3/ZgVB6sIepe1gutSrmg1JqGdVoRZjcjybv4LxfcI4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404338; c=relaxed/simple;
	bh=xSS15mdOfljw9Do96o+Jk6DFsZRzYEx2F+xDq2RN93U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBLhldlGPO8FjsPVNt4yNbK16fjjw7TPnUPuuoLpWyK26LGV4LGoniukJsRQhA++PoJ2o/ptPcAnfOu4jN9pevyAvhsAWP8RepR3hDmxy5M/bgz12kb3jfSG2TI+FPl7fsdpvGFsK/NXys4DxS0hfta4BhpMffvoMd9E9cEZE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2TgKjCI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2babfd18435so29426945ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404337; x=1780009137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEZURrmhgw9sdfLDjlz4XkS/y4LmtlEirgYdpyo5pUI=;
        b=m2TgKjCIBFxoJ3GMszLxzgkOwSRCq5DMb7HHJvKLf7L/rtjuubiPdP0E0YuQFqaxhk
         8q1SmZCL8XZhs3FjBBffrgfgi4Yo9ge08KaJGGaviwl8GSvZE/P+GfCtm+LOrS+XIvmm
         TId97ZHVs7dws38nWdEeUXI5hWDD+a8yepgYu2g9/scAnbjYPWdpm5NoTpLpp23C5AZb
         x9lTN1Pl4iOQ7g4jYXS4HPKqiNS87CQMmxzVkgsQaRszErIm3rBjr+l2k3M1wSFOR/oY
         NCj5PFdKETFY5vEz0RMEQsyHun79k3whjTMdW3AzuK8410uS+UUVawbMTuy2PkIGhsk1
         Cb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404337; x=1780009137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEZURrmhgw9sdfLDjlz4XkS/y4LmtlEirgYdpyo5pUI=;
        b=CKXcd8ydOydYQSsm+sXqSVxR6xryGfFd88oGKDli818kZrwa0lpfZGTLVYIyKCPPFL
         nZ/zAGSpyeZsmIndCLTlLnpxBQ2OZ5SKF5tiquQ2sRgIsVTz0BLWtzob7uRvx07Gt7uh
         P4khXUEkR8Fp7JOjyZRr+TkSNmsitTR+k7jKCk43vk7/Y8RGwE/qf6mjo2yZeL4dYwfG
         gZuKi0paOa5mFS853vnEWJ7b4pHFmEGaPqGat6XI7iNyaQ2OmEkMQI9qTtZURY982GcP
         Uf9USrq3Ucev0j60TS74P+agI1EAAu0rgYbob57N/0mugRludRK6dqukT8oep1F3XuDp
         X3zQ==
X-Gm-Message-State: AOJu0Ywo5NzEU/Gx6uUJjvbMBScLp9+MDu5dWrJ7Wbb5jsluOok8wbjY
	nE6/7c8pFeAzbVqnmnrbevnoF4GnPjDsTHwYtZbwKOUJWWDpWe56F5MfMxrgLg==
X-Gm-Gg: Acq92OHUXbCF1pZtpfUmUWRAtLj0WlvpoDYaU1zHm0gz4JJaPgBt9kcTE5/6wORrsvR
	HPaHaaMHJfunSTLT0tU4F1PirpTALcYBaNtvS0ozPQSJpw8EcxJfHjMbQUwovtYDI6E2Xq7XIDL
	qAx7Qq7beMbzGc7PCXtUUbdOI946ZuYX+ofIUBZcD6RPCxWUzL8BGsVsCSA/xVCoxTLzDzCZEs4
	MOzTu47jI/hqbq5w38fex68ITx/ZmZLvAECSbnOF2MRCpdgU1B/h7n+mcdjGvrrr7UXWe3fOwDs
	6PUHzAb1y2jCQFwqshuK6h5u4gsIKezwTuZY6M81gjCGLDHfLjvwCag1NV/phcLiPmX2DkQXieo
	0dwAks5NoqqFNPfMIBoWJ3goTsSlw4KFFsfYqI7YT5qXyfiiDr8qL6gw1X/KuIh9aIN5VHnZHDl
	I=
X-Received: by 2002:a17:902:e78e:b0:2bd:657f:3a1b with SMTP id d9443c01a7336-2beb065d2b3mr7724825ad.40.1779404336631;
        Thu, 21 May 2026 15:58:56 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13d4c55sm2857855ad.70.2026.05.21.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:58:56 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v8 5/6] wifi: mac80211: Fix overread in PREP frame processing
Date: Fri, 22 May 2026 07:58:41 +0900
Message-ID: <20260521225842.31815-5-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36776-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C6495AC81E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AF flag is enabled, hwmp_prep_frame_process() overreads orig_addr
by 2 bytes. Since this occurs within the socket buffer, it does not read
across memory boundaries and therefore poses no security risk; however, we
will fix it as a precaution.

In this fix, a new function mesh_path_parse_reply_frame() is established to
separate the implementation of frame format validation and the check for
unsupported features. This is intended to facilitate future work when
implementing the currently unsupported parts.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 16 ++++++++++++++++
 net/mac80211/mesh_hwmp.c       |  4 ++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 42a5bd73838c..b4fca2937de0 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -349,4 +349,20 @@ static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
 	return elen == needed;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.114 PREP element */
+static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
+{
+	u8 needed;
+
+	/* Check if the element contains flags */
+	if (elen < 1)
+		return false;
+
+	needed = sizeof(struct ieee80211_mesh_hwmp_prep_top) +
+		 (ieee80211_mesh_preq_prep_ae_enabled(pos) ? ETH_ALEN : 0)
+		 /* Target External Address */ +
+		 sizeof(struct ieee80211_mesh_hwmp_prep_bottom);
+	return elen == needed;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index ad3e575a0a94..391d37721b23 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -947,8 +947,8 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 						path_metric);
 	}
 	if (elems->prep) {
-		if (elems->prep_len != 31)
-			/* Right now we support no AE */
+		/* Right now we do not support AE (Address Extension) */
+		if (ieee80211_mesh_preq_prep_ae_enabled(elems->prep))
 			goto free;
 		path_metric = hwmp_route_info_get(sdata, mgmt, elems->prep,
 						  MPATH_PREP);
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 9e52cc48fc18..bbd1e1bc77b4 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -556,8 +556,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			}
 			break;
 		case WLAN_EID_PREP:
-			elems->prep = pos;
-			elems->prep_len = elen;
+			if (ieee80211_mesh_prep_size_ok(pos, elen)) {
+				elems->prep = pos;
+				elems->prep_len = elen;
+			} else {
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+			}
 			break;
 		case WLAN_EID_PERR:
 			elems->perr = pos;
-- 
2.43.0


