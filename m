Return-Path: <linux-wireless+bounces-36757-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DioGRDJDmoHCQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36757-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 10:57:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4C5A1A7B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BC41303673C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022336405C;
	Thu, 21 May 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekKTaFLd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB70363095
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353819; cv=none; b=K9pTJASkJnlwR9p574dN4Viv5kJeKvmw5nQWMVjEXymeP24uYeTd3H0lliub2JRjdj7x5XSJHKAtQk4aSmWCdrGR90fxmr7D/laGYdFCeLcff03jLAG/E30oU53yGP05C3LXaVMyVDpEBJkl80LDq0asxTYW2MEAeFjwKAeqW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353819; c=relaxed/simple;
	bh=+XVrVpNDG1b7Wr6mPVmO1tnIgLNBjOznXXbLSgZXdTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtdTHN8FK8JO1NkZAHSJRWFa2SvroeaIj8LCzscFUWBixKfN0qDyrMXFCJkm/am+rZ+0fi7BmiAQOz6qZNH/ATQiQL1gPrz/hCqM50H0oWmS74t7GsRhhMiLG4Q6VFCh+lz9llhv3Bd7sddUlwIJYV5Wvi68eSCWlIeRf0Jmuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekKTaFLd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso4976203a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353818; x=1779958618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbDDSgM8ETyX88yLKx6bwUGr6kBWTn1wlBurHmQFrz4=;
        b=ekKTaFLd7X3F3XXlCxjkbkd3EiWy012lGWmARjnYuuaF4QQVH5pfvcXPB7amoS3Jre
         PUySExPAJQFHVBH80fVDAWA9NsOvWU3HP6tV1tBtHEjFVJ3g7K5+x0HXxjlLKIFGVctc
         LPq7FM6oNRuelAgmKjGJvtpldzA5n7cWDRh7da8W9fs935jt/F7QOE8bRodSnHR67CGK
         z+byrnOMBLbz2nvKJ0STGOKDaxAU0eGayoTHXpBb2LvsRnBfy7cr6aUO0zArFmlgDrkb
         3HcQb3Naq+E8o8lWL6UrEL5BpAE0hzz/7/AiGrGgyJlbooRHzU1LXENf6FuPsnRZ9ukO
         na5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353818; x=1779958618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbDDSgM8ETyX88yLKx6bwUGr6kBWTn1wlBurHmQFrz4=;
        b=fFUsXRam+71MqalrcIEBs9b93/Zx0QqAs/zwZ8BuUJkbZ7bnOsw2T/8WytXCTEoZOp
         ONh+D3P5Rt/5rnB8hNjGLIIu+iMd0vxR7xmz4o9GaP4XAwGpS7I0wUnU80/21PB74Cno
         G70ee7qyQ0u2J/IiaoPYatvY12zKVZ4JsYsRIGh0X9wz/CKjOEILVWI//oteZxol5JNY
         fQoEPrVPL+ap4dHm4Ad2Y2+w+7KKqPB1Q+HzI8KqKxytd17hO08ixM25bsS4z31nrrym
         1IjJ8Z8j8fDxCNdFUjw3FGD4XGkNEcxIHHRs9eviRM5t0kF6xpwBASRVvIqMDsj+9fYA
         vT6g==
X-Gm-Message-State: AOJu0Ywspvl2E8jNQ/xvgjtdVzZs2qZe8DLbI4KOZkBHMoATU8+D+sA0
	Xb2PKJ0DbFyQYVZtRUoJbkR//GStsA8ADW0FbXbVOPTf4ShkHUl9bllVj8v5DQ==
X-Gm-Gg: Acq92OGCRN1ytH/z7PdvL9lU31CET7D85vzuiU67NWECxyFCjL4nyssxbVIOiYVHrHd
	dellKU5YnoRM6TCPttZ7jgla+OE3Zr7HrTo7ecSbgrAL2BblVMU3zx0LXDvY5bRKfKSEIZCdx+J
	bYanzhmY1UaJJxc2CfAIg10GQN8BliOmgWyUMuLHRibru7F0F1ab3qXCf7ebHS+BJWA6RrnnVYq
	xNSJ0Yl2EUxu6wkilIcxdXtqukcfTI40/6CbU5Yc0lcT/YOlFqxPvskWvYxSW13zutbQuRySZxx
	lUbLswqwwDSzwInZMW55iQ8OWyDXfDvbu20dyDxww1E2C76Rpgq4vd1Q2Bo8JLcq95gCnSU/BRn
	ve7ycRfp+oKg9EbHyhgVEV5V9qWpVrhz2hTVocQsQ+KaSOLtmSHUW59aFaq8kW/GPvSuisRfafc
	noYjfgqGkwudIRJx5UxCLBaS1GPuWcJpMq16ivtPzgz3l/1J9DFwrH4cmh2B97T5TxDAg5
X-Received: by 2002:a05:6a21:32a4:b0:3aa:c95f:f67 with SMTP id adf61e73a8af0-3b3087e56f8mr2637988637.35.1779353817896;
        Thu, 21 May 2026 01:56:57 -0700 (PDT)
Received: from ryzen9.. (11.9.30.125.dy.iij4u.or.jp. [125.30.9.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm21463091a12.4.2026.05.21.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:56:57 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v7 6/6] wifi: mac80211: Fix PERR frame processing
Date: Thu, 21 May 2026 17:56:47 +0900
Message-ID: <20260521085647.394151-6-masashi.honma@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36757-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11F4C5A1A7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are no issues with the PERR processing itself; however, to maintain
consistency with the previous PREQ/PREP code modifications, I will create a new
mesh_path_parse_error_frame() function to separately implement the frame format
validation and the "not supported" check.

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


