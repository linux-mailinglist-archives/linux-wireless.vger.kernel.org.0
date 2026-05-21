Return-Path: <linux-wireless+bounces-36756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJG1LUDNDmpoCQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:15:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EF5A2121
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94FE43069C37
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC2363C55;
	Thu, 21 May 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM+WeAGR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52833367B9E
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353818; cv=none; b=TSBdph/Zq64rYKWWRm4s0eQmO/VYanuM1/a5Ytt3XQ5cJLefy1Fx0WWOYlF4tQBvLlT5Cj/2dgIv0e8tlsyda0odmjDUfryCgKNlkWlM/+cjM7TDDo5IEZKyWPuzLdlq/Z/Y8W/xKexa4ONNhYKSDY//fBlcNCU2iZGylIAHaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353818; c=relaxed/simple;
	bh=AjNkfvWgpSKC7r+ho7H8ZoNUk1O6PiZfeeF7W3qtDls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDRY3BzGteEon//zfm2JijI9iJeL3hdlqLy4vKhsLmJ6Ixhnkv9+NwZshpTzK6WqKgfvX2zJxyF+iPvQXD/OzCVICgwgv8eap01B0knVIDfzs5rmaARed6Z1kZmVLhpqNlzcBKTvEX/5nquJ3+3wqg/DXOzyi2K7KA/TVfbReX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM+WeAGR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso2327844a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353817; x=1779958617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7h8sxtiNeFHDF7gxR/GA0OAOjD1JR/5dvNazIK0mLQ=;
        b=MM+WeAGRKyyaPYi7JrBDXtoar6WdyvE2LmcUdG2mQyDzIki5oO3SldMkZ+UliaIA6q
         cQ60LFdWhTMq387JLeviCxwaCKf/m8qBXPyRufgVdapF0hVmrT8ZZ0Z9iScjvK+ZCx+4
         GheIRG4pmiifQ0HDqvb0FMZvL+LS4OX2AOVYpjVrGuEqRjwXFImEnKMbvTLML36DonjW
         VN1dww9eMOFt0D9Ug96MN48gPn2jCRPBW4RCLpe1vX8CowVVgyVNOABTdmzyzthF5wr7
         9hfI8hJBYMrU70gQ4gbiUD9PfENdkGz0lGtuUCw+mntY9g4+KF0ZQKLHNsAJGcvI/y0G
         ItvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353817; x=1779958617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7h8sxtiNeFHDF7gxR/GA0OAOjD1JR/5dvNazIK0mLQ=;
        b=bTrCpT7Jr6tEkVkmqi1mt6pQxWH+pShe2ecWOvqEMyoarsAi3ayk8HIihvF4rwaQT+
         eG4FrxaRCi3tv6rNE51vv2YTH83GUseeAnhid49WAZWSoa3YcvGqxWWQbA5L+60wTG6e
         jEPwIISW+5GZLPsVNM+pgv9UPZJ9usqbv6xdWw1id3Se/K6X0qL4mnyewjfIrGlgk6Xh
         mFBC8R2IwFTOXKryr83ZxDFWdTBJaGeFNKZZ/uU+XLmMuZ9NYDuzbm/d88h4R4zTQidu
         prQaLVqoqxIAGr3Xn7tJj+sfyycIAhLViVBUkwDgmHIVDCs386SUWvyAbbRyDNCRW09G
         YZ/A==
X-Gm-Message-State: AOJu0YxcfnkCUM2/2r6+hKP0iCZcVv7Dknyb+tuFBJmLnt04ds0o978e
	v+f1BODftkUKuylnfRWA64Ru35onEE4u0b5A7Vovmk4o/G6VaTx5gXz5VSw9jQ==
X-Gm-Gg: Acq92OG8D7iRIDgbVkUshBZk49wV5WqiQlJIwQFk+Y8j2oKSux/222yCCSLmn9qEWGm
	pxYjny6GlWlsI8QOSLP2SocDT0ynQDbTjNZ1VYmj6IX46UCGHINAg73RkLYU6csS7KdauExJXIT
	LuLqgF2CAWnPmxuiVTCZgqUcoCvFUDm7EiKTb8XT3+d6DXIakcjgU5sFWO2Y04mFPmjMAOEHRtP
	c27kXfMxY78WGrEAN36FYCePqYpM+mAPv2IFdnfe3GfN6S9PaTcgSSP5M2TitXIS03fgFW/oG6L
	kkAqfvqCIiKeQdxWGj/jWzISg8YqTOJxWVySvak1+Y0YeUVw7nX7GpQxCBpXl91rCMbSE4pqIld
	dQGpYzXyI/o+4Lg1IbVdxCNU/LQp4OYD/UgUv3g2oCXp/g+IAWp6vftzOsgjYuMCKMCmbWY5FdV
	pw7COWHWD8VZzg4MwM5Ihs9gMsAYfhB1/Wkb6mBnJp062Za0VyIlV1K1HNKg==
X-Received: by 2002:a05:6a20:4327:b0:3a3:33bd:319b with SMTP id adf61e73a8af0-3b3087cd933mr2616889637.39.1779353816681;
        Thu, 21 May 2026 01:56:56 -0700 (PDT)
Received: from ryzen9.. (11.9.30.125.dy.iij4u.or.jp. [125.30.9.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm21463091a12.4.2026.05.21.01.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:56:56 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v7 5/6] wifi: mac80211: Fix overread in PREP frame processing
Date: Thu, 21 May 2026 17:56:46 +0900
Message-ID: <20260521085647.394151-5-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521085647.394151-1-masashi.honma@gmail.com>
References: <20260521085647.394151-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36756-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 372EF5A2121
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


