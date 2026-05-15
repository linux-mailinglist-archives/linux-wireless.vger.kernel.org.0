Return-Path: <linux-wireless+bounces-36505-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A5GA6KuB2pHCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36505-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:39:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE8559608
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7EF83020FD7
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 23:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCA374721;
	Fri, 15 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfW+ZAi2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AD3F65EB
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888336; cv=none; b=Vn5O8tllqvQSkcq0WC2zXmQ/JfT3CAdhoY+sVvwWSYsPT5Cwss3/8I3oNAkO+qKEKvqNOCDCe+ng253Eo163ynob1GRs5ModtAhbG2ScJzawwOLFPtzea3AU4Asy4HgUimv9Xlk7f7qFZYHbjUC+oEJHJpIzuXoHn5+RgM2K1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888336; c=relaxed/simple;
	bh=GMFpSbGafPQwVudE4oy9yQnGlHqgCiVYlZmWDEb+R/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFKS7xPaVE74QFG/OWH+7QKjm3ohiOnpGe13mdhF0QSEW3EmmltnZInW6r/jxOOrc6bwRvXnaAn/HbPPfaMa0tLBiKW4kZoyw8L4GEnhqzNZdpoaaZt3vGVTmb3QSvI3dpr5OHTyxO/YnVMhy8fvpS06kk0Zf5DWrkS16bphyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfW+ZAi2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba4a1a0325so3150705ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778888335; x=1779493135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6v982cTyav2Zx/lbMjR0398Olg5hrqpTj1WmV2T4To=;
        b=jfW+ZAi2TvzJ9bCWMLtwZmyazP4NqE5lLJRwilq6TYlz9ZxIuh7YK0GtBK203vEcub
         FGFy3hZyhXXrrpLUfqH2OV8inVVijRNJmLSxC67cR5mw/L6lB+3BjXjXb/palPhI0any
         54wAlFZHiQFlF3CCfMIulsx1jWPKYgriNRNpQV8XNUxoH7h/F04HzpkZOSH2yyExre0l
         9o4jFVrY/lbLgyj6ciS48sT53EO5zdABQuQM2/4wRst2viwD0lQ9HnjcqzxWCR6Zfu4l
         BHWMBDZ5g1Zx6WjLWAKhO2ZqlYe6aen1IYP8MZRQZSk99GuR1uSEQ1/T2ikTMrv/8IbZ
         fazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888335; x=1779493135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6v982cTyav2Zx/lbMjR0398Olg5hrqpTj1WmV2T4To=;
        b=qzWW53Kn0jEsFMY2AYgRY1wlztX8V/Ku+lhSm3V7uY1JdY0Wuu9RzvS/pghBw5boBD
         rumYzbEDkqJuVsTFz6O7XmiXPz4kFjba5KMYBZvcKWiICtYwy/OC4zQoQhB16+F8J4Es
         uBjzEtqOLostMHSkixdHmLy48clcWYxnGV7B9H+QrGuxfhTA7TRRrfiodIFY9ZV26Lye
         mF/MHs162JrdHcijxHMvaBF+fz17StsIMYN2Ta5Ob+H2JiStSqjIwlzU9GAYOhYYtyn6
         e1Bhb4SwalUyDPlU2zAv0rGmgFLKaGrlqWqnhHhwtqHlv8i4hLKoNraU7WltkMYPdhGk
         miFg==
X-Gm-Message-State: AOJu0Yzn86uWNmUNwag6VIEAgG6W+jNLIvsjxkeZSLdO1wYKKzcdro0o
	HcE9bRa9ra7jf4Vbz47lvWVBEvkqm0Cd5uBwUGOaJxcKeaOaZDqAQNVtqmNH+Q==
X-Gm-Gg: Acq92OGoiJFyXS01yxMfBgvshEvkCTo1JEKlwHZGGCVS/4Aa/V4ufKdtqX+BmIztNH5
	Agt1lnd9JzkyjU/keR7dLXAEjvhNoR6RPmN9PE5GdVbmc3Y0njVxCVXj3DNkaUIW9NtAQojshVs
	SrsRdbuLNT1dOmdmamMjRyWXon662JI2TjGsLxqEamH1DCvKYdCHOat997XxkkxaxdBgWcM48BW
	Yk6gn3Eh28XehNCl4pApzWFMW74DKG+cQ+4EZptN55rgxu8CjXox2OgxJYNy5DAluoPLz0sZL8w
	R2CvuHuYir10OY80UxvNEZIeBtXABhbuRs5KLe8HLy6MWLbt74o1hhTD9qzMxg3rn+/GK2DvarR
	qwKRHGVKyJaDbsNcztK4anZw1/ABedfysGF+8invViTPDTLNUwZs70kb4jXrxelO425HCaPXU4M
	UTj4Cqt2oywg==
X-Received: by 2002:a05:6a20:7f9a:b0:366:19e9:f43 with SMTP id adf61e73a8af0-3b22e7aa119mr7096515637.6.1778888334813;
        Fri, 15 May 2026 16:38:54 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm6391265a12.14.2026.05.15.16.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:38:54 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v6 5/6] wifi: mac80211: Fix overread in PREP frame processing
Date: Sat, 16 May 2026 08:38:38 +0900
Message-ID: <20260515233839.86829-5-masashi.honma@gmail.com>
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
X-Rspamd-Queue-Id: 79BE8559608
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36505-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
 include/linux/ieee80211-mesh.h | 19 +++++++++++++++++++
 net/mac80211/mesh_hwmp.c       |  4 ++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 2ff94da770b1..8c32a52dbd6a 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -355,4 +355,23 @@ static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
 	return true;
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
+	if (elen != needed)
+		return false;
+
+	return true;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 70973d53605d..fdde827bc1b0 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -950,8 +950,8 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
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


