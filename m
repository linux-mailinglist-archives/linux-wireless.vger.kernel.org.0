Return-Path: <linux-wireless+bounces-37162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D+WNNEcGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E0609A1E
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBB7D3050240
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A1368D42;
	Fri, 29 May 2026 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN8cLDzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7436C5BB
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096205; cv=none; b=HpSxqdZiWx6EJhNC5CfuF/XXp0XWVxzUqzJ0E36VJ3d1sLcwtz78dC6BVknAG2l9qAM7DaaSikNajRRpPktPArGCuhbfX8aBl9wRxRjDNB0YAk2UTtF6hhaCxTG7xYuxYh/PjMqTlMizw6beokotKLf4vFUUi1qXmwS4ttVFsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096205; c=relaxed/simple;
	bh=CZ8j5G+Lm2wc644R5v3X/TweDqdClEIxCBWRBODpxNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scZnMH6VqlCLBV7tAU6zE6wIKphRY8ffkMD+rlSPMIKF4AUbV0LbBgBRxxIUgy08X1xMDmMr9eBLtnL1U4hvrMFwMvusGyumu3AKF87K8o77P9LFq1H4E1hOUW1MJFEzQ18vQdMLjC9P2s3gzg5vPVbxt3Vzwqbhwnw/mYcYvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN8cLDzv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36af4b7840aso4346273a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096204; x=1780701004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVlCAvNRCB8R3KYNB5dk80MsgOL/5VJZXp9oLldhY+E=;
        b=KN8cLDzvMKmIdADGMzvY469zwQUJ6N9V/nbvLukQ+KEYw9+dZ9scdvswVpKvqzJL9l
         N8jHyIrhTGCwq1JXuA9o3gbA/xYK7XSzJPB9OGj7GQ9maxmGRg3xyALWvEk2NTM64pDv
         aTnjza35xxMMtW9GAu2ovgbAelsEo2naU9K7ayYyn3Ho9nVzMMEqDSkYq47PPWhcJya/
         LXMI2wwFnq/h4lI2QXycLiB/1C3jz3DUWTSEpkxFvbAZ0MhoVentjjlst+yvfxdPKCho
         Z8WBNIr0fukvw7YXZhsNgZvhnoLTzX0HOc87sV6YmrhpIalIGAjs/giJwQSlHy64gMGA
         wyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096204; x=1780701004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RVlCAvNRCB8R3KYNB5dk80MsgOL/5VJZXp9oLldhY+E=;
        b=rnMY8DSqsm6U3872WVY53ViJnyB9dZqlu3lez01qUSKa437HX1WHo1ppSBRrvdEyvM
         b0if/FjUT5bIp/GSTj8tSYi/AJibsxF3iVPOw3iIZetyGsqYhC5J3CCkvKrAqIjBlwJK
         MffF4VsfGnyc7Yyp5pyL3Z3YnWwwwhgcjxYCK6xaOuwlusJcm0Ob68OPHk+6w4E9R2rx
         9zr95ZsUUn/In3ckZK5ONw8Jf9aU9rZk3PZbfZrYqBNqe28+YOtOvsunVBYdsmbf65JC
         VJ6iqeen75jP2VOP4+q5qDqoI+B+tzqjJp4N8l5cR2ucmtXdeHO8Gb+gPDpxpMgvvMzP
         WtCQ==
X-Gm-Message-State: AOJu0Yww24fB4BgfsP+mlTKVjmQD4giij+2lVJidbi7McRuMML2PCls+
	Dirqpzlr9SCW4PYR2XOPFQnwF42uBuEH+pQ4qJuTxCZZ7pvomauSxtli22wJiA==
X-Gm-Gg: Acq92OGzsR1KykXcL1IP0Sgj30e0oS2YlaLRDHA5dRz3jMbzdUsLGW7tX6USYpB0rsu
	HNVaDXN04B9fWW3B6fz1jV7d5OTVImP3IM1HpP4Dd5fz1d65YrXiVnCIpbekqRXmlf5va4H6iR2
	KrlJyXnSFxqn/y6BP6TMr+6eUXs5qMRcO+7PTT1qwOTH09JoF8dv92tUBLGKQxcx5FJmqq+5ofN
	Ytca1EaSa0dMcsWjCOanf2UQ6CP4+C5Sj+t1vfwL46iRRWy/4nD0K2d1eQnyjvPAtkN2X+Yj6l/
	5LpooA5HQf+BHlq2/eFJeGXtObsMgdqjqjmJrJOT/u2oDIi+cSsgQ5cnmGKcBCz9qWJS1OriAUS
	D5sV9OivbsMoBQh3BvAaiuIXQVy738g212fb1DyqSHEtr7/Jr5h/ndwmkgGb85Ww/pwWEqRoQXj
	ueegERzw796uk+9xpmdCyTSeHs4Zk=
X-Received: by 2002:a17:90b:3c42:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36c2eb88bccmr1291345a91.0.1780096203651;
        Fri, 29 May 2026 16:10:03 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:10:03 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 5/9] wifi: mac80211: Fix overread in PREP frame processing
Date: Sat, 30 May 2026 08:09:47 +0900
Message-ID: <20260529230952.124754-5-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529230952.124754-1-masashi.honma@gmail.com>
References: <20260529230952.124754-1-masashi.honma@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37162-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 471E0609A1E
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
index 8fbd31d9538d..482ac0c6d759 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -387,4 +387,20 @@ static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
 	return elen == needed;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.114 PREP element */
+static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
+{
+	u8 needed;
+
+	/* Check if the element contains flags */
+	needed = sizeof(struct ieee80211_mesh_hwmp_prep_top);
+	if (elen < needed)
+		return false;
+
+	needed += (ieee80211_mesh_preq_prep_ae_enabled(pos) ? ETH_ALEN : 0)
+		 /* Target External Address */ +
+		 sizeof(struct ieee80211_mesh_hwmp_prep_bottom);
+	return elen == needed;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index ef6eff52f32a..f07e57d5568a 100644
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
index 3d441ff9593d..97508b141b8c 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -572,8 +572,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
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


