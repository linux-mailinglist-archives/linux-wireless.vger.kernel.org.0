Return-Path: <linux-wireless+bounces-37163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MEwA9McGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1F609A2C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C6D13053BB3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0F36E498;
	Fri, 29 May 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngEmIQA7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACC36C580
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096206; cv=none; b=fR1KZSrIRzVkglhSNn4Y3GbfhgTMaYrQXltTD5/Fdz/WetjJWYHslnymQVkaUagFCKgpgMgyFHLDEzgU9+S1WPNxEhWFbKpwP8q260jXEYHPme6NRkE1GPpd+Syqscb/22yj3tbUUCLfeVUDJM5N68nxOx/7p8oOeYBc1kmLB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096206; c=relaxed/simple;
	bh=JarTQlnIbu/9Am0QjXT+xjBP39mggMe60ojxxQyYHHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViBhn8Qr3kqhMCCG+UR7vwf87W4CvYma2yq0kU9US8uO68rWjY9cOV68piWLo+pUlErHMAfv8tw2+plAW24TtENNrrMa2JELMIq7G7aCd0bPGzlrpCTsWdA81f3V1e7GxvrEWzgo5mMrxYQm2wkJA3NoEZbOCNXymlp/lKR+g+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngEmIQA7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so1238328a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096205; x=1780701005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGt9CDCQhvrc554zC5zHa1xlVGIJZOefOO7uKdX/98c=;
        b=ngEmIQA7xQE9mZ7a0/cFjRkJNvvL8xAMwQwT6eXKsaZnlbUxDkrLACGytGZI0VC3vw
         SLFEqznOFvFraN5V+/D7x682y/gHr7ao1R5ku8193RbL4d6AvodUCk46/mWnSbNgrE/0
         ddy4eErifOsKJhKjaRICeMOXVwTwjnN4C4MaUO0hBeUWktMZH20dv6zKvCf+6mCP8cZ0
         3TYPkihnN1Pr12T8WYRbn21LxYyryXqwDlboKW7DXQy+iWHD1iL4DiYZgkBEj6cfb47A
         ry7LNK9XG7I6pNkt3IKu/MLzFqyGFuphCNhnch0KV0tlrm8NST4lOF+OwW6mSb+3iN1c
         oaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096205; x=1780701005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGt9CDCQhvrc554zC5zHa1xlVGIJZOefOO7uKdX/98c=;
        b=q6bNcDXrmU/HIXwIlopbigE8i4YUCgHu8JRj3GNZOdCA1D9IkAlyZ1xVfLtdhpR4ma
         C382456f5oanNbViOObNhxVoos8ZHhNyYmkagMG+PceL9foDRHBjgbRoRbnTzTJWSAQW
         93QCJ2c15f9ZsCBpU0E1l0OxCmgBdCJvtD8E3BtDWjRS+0XbFRDwvrLq0RJ9SR1KiW9T
         foeBNPrXrpiHaVGra9xSDMJusEVroG/vG7Cd2OpFPYobheVWuptApZ0zNEJaxt24fBgc
         XI24yXorHZel9ex+vs/ADzd45ignYsruQMnaO/4Cg+kvAiMGehfj1bY4g6xrb/3MmLTa
         d31w==
X-Gm-Message-State: AOJu0YxgkapH/Pp/e9qKzW9Lfa4bg0TRk/7FKe7JRh4BFpWOc08ElwL6
	DLaWS1fJdz6UbZRgEA173fXeZRIUejMFP2beGlgew54xIUizPJysL0rVA+E3Xw==
X-Gm-Gg: Acq92OGwNQZPfeK/82DHpt6tdd/1VAu2aNH5Y+iMhusG0qK1fxEfxii7Im7uf4J+gY/
	F/V8SyS+tU91Vv0Bpt8V0Z79j6KYoy5HWSYNSEVZDPzLHbyULL4vOkAKd4k+ZYc6s7aVqF5BaJj
	4dLn+xvuIsJHDg4a0CERZ96E1Zqdkyip9/RenV5CdQmIWuaXKM+CgSKXS/rAnUglExUS2gbx32M
	p1X/JVA7g3if/UU2e9KpqPXL2+bFUSQFW64QaszbtoaUZ8C8grM3mFpe0QEBS3tEnD/LPZvZ2R1
	SW/2eD33fosSnFoc8eN9FjiSlSvk6cE1kVdWPbvYNAH7agrIjCtSTH9u1LPYNr1tRaZoFn6bbtt
	Ziq/u+TRtKnjvkCCNkxpbt6myvOWG3f9Q/tKxUN2FKao2bSwrLaMHNBV/pjCNwj+F9TwmCt7Tlf
	4QGobN0WNYIIyRmJbN
X-Received: by 2002:a17:90b:1845:b0:36a:d6dd:9fee with SMTP id 98e67ed59e1d1-36c4ff6558bmr1123565a91.12.1780096204892;
        Fri, 29 May 2026 16:10:04 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:10:04 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 6/9] wifi: mac80211: Fix PERR frame processing
Date: Sat, 30 May 2026 08:09:48 +0900
Message-ID: <20260529230952.124754-6-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37163-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: B7E1F609A2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are no issues with the PERR processing itself; however, to maintain
consistency with the previous PREQ/PREP code modifications, I will create a
new mesh_path_parse_error_frame() function to separately implement the
frame format validation and the "not supported" check.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 36 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 18 +++++++++++++++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 482ac0c6d759..7eb15834531c 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -403,4 +403,40 @@ static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
 	return elen == needed;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
+static inline bool ieee80211_mesh_perr_size_ok(const u8 *pos, u8 elen)
+{
+	struct ieee80211_mesh_hwmp_perr *perr_elem = (void *)pos;
+	const u8 *start = pos;
+	u8 number_of_dst;
+	int needed;
+	int i;
+
+	needed = sizeof(struct ieee80211_mesh_hwmp_perr);
+
+	/* Check if the element contains number of dst */
+	if (elen < needed)
+		return false;
+
+	pos += sizeof(struct ieee80211_mesh_hwmp_perr);
+	number_of_dst = perr_elem->number_of_dst;
+
+	for (i = 0; i < number_of_dst; i++) {
+		struct ieee80211_mesh_hwmp_perr_dst *dst = (void *)pos;
+		u8 dst_len = sizeof(struct ieee80211_mesh_hwmp_perr_dst);
+
+		/* Check if the element contains flags */
+		if (elen < pos - start + dst_len)
+			return false;
+
+		dst_len += ((dst->flags & AE_F) ? ETH_ALEN : 0)
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
index f07e57d5568a..84903737271d 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -957,9 +957,23 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
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
+		for (i = 0; i < perr_elem->number_of_dst; i++) {
+			struct ieee80211_mesh_hwmp_perr_dst *dst =
+				ieee80211_mesh_hwmp_perr_get_dst(elems->perr, i);
+
+			if (dst->flags & AE_F)
+				goto free;
+		}
+
 		hwmp_perr_frame_process(sdata, mgmt, elems->perr);
 	}
 	if (elems->rann)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 97508b141b8c..c44e81a2f80d 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -581,8 +581,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
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


