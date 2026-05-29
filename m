Return-Path: <linux-wireless+bounces-37161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGvsBUcdGmqx1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:12:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAA609A84
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04413055093
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC636C580;
	Fri, 29 May 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFgHc3aD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072A368D42
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096204; cv=none; b=SmUGZk89OzJpsHDDrdY5PFEDDAJ6e7XalPrDHmFbqVTmTopv1NgxluYhegNPqx26z0W8p/KAp0tTeo6HvUWXoGRH3/HHlbbzDSqQ8bwMwJ8n+9eLWmHmXfZuvBi3dzAwO+ASo8MVWmhblAKllFX3PANo4IQmpVn5CBGU4IIW3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096204; c=relaxed/simple;
	bh=JWf565BMzPIHbqVoFPgAo0hnSG6M7CHWIT0HA0xXJ0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khCrnMAIchuq5oORFnPfyxQMdWJxmGaNq7mjosjdIiGtfzLIWpM7pcUWfmy+n4wN60JzTH7aAz52MO00bvDGsAsz5yDIRv//D9G1w2ktSrMWL1mLscHZapsjKuB7Rg5kXlDQHv+uHCnEzvwcFA4B81ExDS9NC9lC3hVT2tP0lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFgHc3aD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so1238314a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096202; x=1780701002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ3aEpQbZ4t+lSvscuTNm9Jw9q7lHMPuckxFInUdA5w=;
        b=CFgHc3aDjFiCs1LFOVGpQfYCwCkl+Zai5YcahdhW+k3Ou9BtPyEpvV8xafmTn9Lc7M
         Z2ZLgDYMSZ2g/qli9LAkxhE1REB2lAC8KCUC/6WSZXtmPm/KuHpTsdbf8VkAMZM3QnXS
         VwwmSL8d7PLOxhDrSo0TtR8TEYlGwY3ojrDt5Yb4YV22ERxyHFXFB1Tg4BT72RYew1lE
         8Ve/k+K8q2qYU4lSvwyggEl81pNYiIHWcNYelRl2OrdPSsqM/RmIp7H6n7fSLjfI9nUE
         BsPUQebytEFbgZBqWDpGhjr+eHgGoQWVynjHPPXA6gCPncRT/f/0+mF8LUN9C8ibfpPy
         ewDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096202; x=1780701002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQ3aEpQbZ4t+lSvscuTNm9Jw9q7lHMPuckxFInUdA5w=;
        b=lbFnyP0Lmw1FEfHpb0oDsJIz8O6byoKbotJKKPij3+i1nHK0iHtLMR8/lqX3lh63Y3
         GmYZG8b2uLYmtP46J24mjwFbFVK0aAlp10cdvwmfDUW++GzR/WlbVK/L5F9ghMJ4aEa/
         bK7ssnOcvGrLLw/joDNL2IoJHDK2/RtuJbFFx6zA6donAS5ow3lrvSfJ2NT2pgALYaKS
         HdRTugcdgDiTpEuuCanESQ6hQF0LzRuroAnWqNoQoJUgoKvS/trlY7L+ZFtkfadsmZda
         OTxcmVDe3r7TOoAAOtZcvaJVhs1tzT/JrLfQnr5o6Pe8UmN9BzvXPz+yXT+DL1JSK2mW
         /jQw==
X-Gm-Message-State: AOJu0YwiWNk1oUInzWui4x/xv3jZHbmyI7I5dKvLcsunAQPX+d0vHHM5
	dHBfXhXdg7/NhXgnYTrE/TTqOgp3hyZoHTY8Kqxhe35J/vO1eQZnpzCZd4d+mA==
X-Gm-Gg: Acq92OGkL4GYMXTRRc7qhuHJqD4j5XVQhJxlsiMSrojrCsE1uq7KG4dbps8sijmQB6I
	EBR/ryfziChWUf9UkXoYkKXeQTsiefnCVVQFS8HEn5Vei/4h0kJ478mXU3X/wS3XgiXlEk1n9Da
	UpOqWxbaZnp/zQSOyf85IBigZk287Ld7PKFxedQPLIfTc7kx+z09D1eOwZTmylcq6G7d+WZctjx
	RSie/a8+Hx352R0ohTtsT/5vTVn/qzt/+HIejK0z8PUXNuUObX/bMFIH+vXf85+7iuVxK8hsyT6
	7uIJY23Osdj77/KJeblaVolv3qpiYNQlN6lltBLqwsklpHIw6BnQAEpCcTkpn+tDTnpQcukKiFz
	xeCmXR1g7bQ6rRtuupY8Es/mBEY5io+F7oxw7EDmSj56magXy0H65D6f5CwPHy2LZsPcNlsIqAV
	vL0QzCchErYXg2zkZQ
X-Received: by 2002:a17:90b:5704:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-36c501dd3eamr1229488a91.16.1780096202128;
        Fri, 29 May 2026 16:10:02 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:10:01 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 4/9] wifi: mac80211: Fix overread in PREQ frame processing
Date: Sat, 30 May 2026 08:09:46 +0900
Message-ID: <20260529230952.124754-4-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37161-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 71FAA609A84
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
 include/linux/ieee80211-mesh.h | 29 +++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 12 ++++++++++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index f709263c310b..8fbd31d9538d 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -358,4 +358,33 @@ ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
 		(dst->flags & AE_F) ? ETH_ALEN : 0]);
 }
 
+/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
+static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
+{
+	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+		ieee80211_mesh_hwmp_preq_get_bottom(pos);
+	u8 target_count;
+	int needed;
+
+	/* Check if the element contains flags */
+	needed = sizeof(struct ieee80211_mesh_hwmp_preq_top);
+	if (elen < needed)
+		return false;
+
+	/* Check if the element contains target_count */
+	needed += (ieee80211_mesh_preq_prep_ae_enabled(pos) ? ETH_ALEN : 0)
+		 /* Originator External Address */ +
+		 sizeof(struct ieee80211_mesh_hwmp_preq_bottom);
+	if (elen < needed)
+		return false;
+
+	target_count = preq_elem_bottom->target_count;
+	/* IEEE Std 802.11-2016 Table 14-10 to 14-16 */
+	if (target_count < 1)
+		return false;
+
+	needed += target_count * sizeof(struct ieee80211_mesh_hwmp_preq_target);
+	return elen == needed;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 378338778a23..ef6eff52f32a 100644
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
index 8b30e361b622..3d441ff9593d 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -563,8 +563,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
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


