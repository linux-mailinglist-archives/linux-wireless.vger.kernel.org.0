Return-Path: <linux-wireless+bounces-36139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLF1LkfG/2kA+gAAu9opvQ
	(envelope-from <linux-wireless+bounces-36139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 01:41:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18410502038
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AA1303AF1B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DE78F2B;
	Sat,  9 May 2026 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwyFStvn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C8393DFB
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778370111; cv=none; b=MofFzRq7n4PVFfFYeHZpHIoNUZpPI6dZgzNt084SuJQbDGTg+G6LaB6w8Lf+CHso+s4SiCMFbLjhIctYGgu9DdAYGg8l95Kw2gsXES8lryvMNCO1t0hS3QGNi40aNU9HFM025IXHVKDxogsdfKemQ2j/mPo8SPxdCoNXqteYTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778370111; c=relaxed/simple;
	bh=KkDDlC5a7szOxLHqfVqcRbMtA8rSPD+0hKcivGmlcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V79BhmeQKZnwZhi+tAxNiZx13HhYY9XC8cu7AVKqw9HSHPl5pqAf4Iry1AsDkxPxzZ0AGzuHsZsOT7Hka67HzpJTjss5euQZJkz4BJxfOlA0eD7L4XOJucCr6fSQOJHE3VvHsR0dgVVsH9zB+Ms94pvjIJ7JwMrI39VEk0tfYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwyFStvn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso30796365ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778370109; x=1778974909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHcG6yB9CqQ7oMOhQZ9yqSHrLMra509MO4r9JlQna/I=;
        b=qwyFStvnOqbx1S+e59Tuxl7cCa0fCHFTtMWZ32EhFpUSUBhKk8DG0Puqqw6hCapfLb
         rbQ9bO2UALJrzI0dD6T+Svso2Q5tOmBA/w9wZLJMLkne0Wu3F0hIllzvU8hr2yue9XYX
         /V5919VJ+YqjdtSXIYTrbPKhtoSk23/NCx56vKQWm6Bj+xlKrcdRjoP7JGozmsbXditj
         Jdfpl7Z+54VY6eBs9TD4b+UIDB+th+IvWgFauEwXHWOQdahePJ2M5uYPKOZ6rB2VwhUS
         7uQqx/rWkr/gAQ4tm1Ld5I/SOH6SR0YembVhvBtv5BMxLTSnFrhCedEdFrItuGxXU+Z2
         Hf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778370109; x=1778974909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GHcG6yB9CqQ7oMOhQZ9yqSHrLMra509MO4r9JlQna/I=;
        b=oj+GurxOfoSVhLui2mzJ80IXWoTjQLwu4oqnGy5lYcaX2ZOOiymTBNkSVPE+D0xFgF
         N+tkTuTdSwrz2tcMvJJULV4P4Up1EPlq1PmMN42WvsAnluJ1Bb6IMAHodZmSqnkBOwQr
         hb5TMO/oZFqkRYh6Ynf/SIp93vP9xsKKdjVeJzaD6J4cODtr1PdIy7EKW8tIMW5jk61i
         QAtOWIpSt3JmJw5hVV9MAaG52iSMM8uvAquS/ytuCOwclzJKc18CAGIT0blodANCxClu
         jKh2Jfb30TyC+mmtOjEGetFvXjDnooXgxOUD28rbBuuV0bCrUeGBcOwubcKBGgJUR/49
         n/ug==
X-Gm-Message-State: AOJu0Yx4A3CAQYtWtcRbO9vbZVa3C8+8penhiO1R1maV0pSFOb9dx8rh
	JyfxqnyNybbMWU7cuDvZkuTlYtMYD9tofC/LLLY52pDTUFIRu8obpfDUktzWSQ==
X-Gm-Gg: Acq92OGMuXOoxPxizWaS+VTi+a/x1/rm0gHpmfIZxSy9wgVGVo2sw38RoAReVg+lVG4
	z5gnvQQ2oN6P9uGWYRbgky0eEsXbuOmBCHNsq72lKYzRONHUfgKBYbYrc7Jde0BoYRWO3OUHsUg
	1fHmSBMwcJMOpFXxzQ4cpJPO8m2MIKn42tIEKV+w+FrPYhR8vMAoQrCK/8PM66jhdtNkl4/i4+S
	IrfPJWjVFcJwAUTAJNMQqqV2lrNJ+izq48YM/09w4xc3hqyB4yQ8bRwav3FZBs6uq0dLpYgKdvn
	JFOwrdayrjD9kw3/popOgVTkiCxMo5eIJYZh6Rxk5P1BaJ1+P4TFUjiLKuSBWYMXgtYG7svXugm
	bhnk+omfl6fqr8sQYVd2f4SeG224kNcCetUiVzd8A/HgoMr+jxrReGtp1f3PQFw2TQOwao9BFp0
	5172g3Y3gaVH5gm8/2mumoSpQQrA==
X-Received: by 2002:a17:903:283:b0:2b9:8d39:5e87 with SMTP id d9443c01a7336-2bc7a997974mr37371455ad.10.1778370109386;
        Sat, 09 May 2026 16:41:49 -0700 (PDT)
Received: from ryzen9.. ([2409:11:4b40:1900:7ef3:a74c:6b41:8c9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm61078635ad.1.2026.05.09.16.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:41:48 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 2/3] Fix overread in PREP frame processing
Date: Sun, 10 May 2026 08:41:42 +0900
Message-ID: <20260509234143.101237-2-masashi.honma@gmail.com>
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
X-Rspamd-Queue-Id: 18410502038
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36139-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the AF flag is enabled, hwmp_prep_frame_process() overreads orig_addr
by 2 bytes. Since this occurs within the socket buffer, it does not read across
memory boundaries and therefore poses no security risk; however, we will fix it
as a precaution.

In this fix, a new function mesh_path_parse_reply_frame() is established to
separate the implementation of frame format validation and the check for
unsupported features. This is intended to facilitate future work when
implementing the currently unsupported parts.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 18 ++++++++++++++++++
 net/mac80211/mesh_hwmp.c       |  5 +++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 8ff68cf539ff..ddbf475c1cc8 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -283,4 +283,22 @@ static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
 	return true;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.114 PREP element */
+static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
+{
+	u8 needed;
+
+	needed = 1 /* Flags */ + 1 /* Hop Count */ + 1 /* Element TTL */ +
+		 6 /* Target Mesh STA Address */ +
+		 4 /* Target HWMP Sequence Number */ +
+		 (AE_F_SET(pos) ? 6 : 0) /* Target External Address */ +
+		 4 /* Lifetime */ + 4 /* Metric */ +
+		 6 /* Originator Mesh STA Address */ +
+		 4 /* Originator HWMP Sequence Number */;
+	if (elen != needed)
+		return false;
+
+	return true;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index a4984b015995..c70cfc2d6299 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -941,9 +941,10 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 						path_metric);
 	}
 	if (elems->prep) {
-		if (elems->prep_len != 31)
-			/* Right now we support no AE */
+		/* Right now we do not support AE (Address Extension) */
+		if (AE_F_SET(elems->prep))
 			goto free;
+
 		path_metric = hwmp_route_info_get(sdata, mgmt, elems->prep,
 						  MPATH_PREP);
 		if (path_metric)
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


