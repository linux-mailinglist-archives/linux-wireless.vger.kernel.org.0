Return-Path: <linux-wireless+bounces-36506-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OQhYAKiuB2pkCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36506-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:39:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A016A559618
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 01:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6099930233F8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3901374721;
	Fri, 15 May 2026 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwI95G2H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8053F7885
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888338; cv=none; b=aLL9mXL9CNvr5NEpOF4rqsn1/i9fZKnlvgZbbAtknfK8bf55b5UC3Va/PsMaymbWuaPUrLiLXcCYOR9bx8uIGbjaJPUdal8922cJPEz8PyY7kfsqiGYSGI5x+y1FoiSKG4Ks+Qkr5Ajz8bwMYyQn8PEjNEgUNkPJXKMIb3rbhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888338; c=relaxed/simple;
	bh=fsJuJckq15cDPqdj5NllFlJplmqHoDb5tDZe7/folAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9J0cOi3M2kjSFO5aYLS2FZU0mq24EXJILvVXwtOoEoi4cd1Ehd1ks8WMqZ9EseW95sEeMEM5gSlQY7Sg3lW1c7bv+zxGjP3HJ61Otw5OSGboivFefThbLiOBBJ2Q0SALANFSrvZafPSxAktts/1mzErhDpW8WoRkhD6obPgHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwI95G2H; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8028fa6039so234956a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778888337; x=1779493137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhNWFlL6ydzFVlVIZfe1+ndkLls+b674nuCaVYZFnu4=;
        b=rwI95G2HsmfuovqUtHBey5LIYZEMOzeNDXFhQ75j00NgDwQ7Y6r26j1NCo3aGOE9hC
         XsmzdKIHOO/aUoDkP8mTAOrKtuvPQgPLL/2QjtXRBDFCoMkjH3b7dcUH0KOAdgX+tCZ1
         +tDROW7NPB4BtY65Vih5JDeAVCClenWTX9EsuSoI46ERHc7VbOtS+heuMqOQYGCZTIa2
         eVTAsbCIEtOuEluSRvY8fz0gax5tAOfJITkAdq2sK+Pp/+YVmG19Z5eMQaPoN8jBED9Z
         FjijAra1AvfStgAeGPeV0c0YrVu9sytjiBrQs5O7Px66rtwbEbq+L06mSOpgYvYUaITX
         Ceug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888337; x=1779493137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhNWFlL6ydzFVlVIZfe1+ndkLls+b674nuCaVYZFnu4=;
        b=fXj8+yL90oMcODFzPPSFrQrT4p/6FJ6uFaZRRxHb5yyG8CPSrkpg4EJaRgJsUPUZNF
         krJWc2rFtzwmPB5lc/ljXu2UUJSOdvDoRRV2iUwXHGLUrwMhC9BjUC1wu+dPIn/dO+5z
         /Myw/G7kjLefaZ5hJjTk5IDA6a/eVX58lCDF/04GUtN72pxRUugMpMPCT6wKRrzTdlpl
         tpAQuKgHbXAoMkHfr3Znf+IcKjgZfcEevyAVq70snp16BDA7EjmUKtWbot1bYYCQFRnO
         rLabAuCNJhyw09zmCOQxRDppy0MiVP2K9J/ff+n1DLfOmpOzIhJ6QVW9D0wvg8+mMsaS
         m1aA==
X-Gm-Message-State: AOJu0YwrP9ON2wL2cUycAS79i1/Kngek4g51uc2NZCDdEcARCEMOBTEz
	uQzcZ1B/vbWL13cPpoV4BzZ2SKYRMCB1aONw7fKMYy1mKEcWfvHUifs1kaemjQ==
X-Gm-Gg: Acq92OGDniUjnhNZcYqo7Cl5Psb4NSmZ8YH/p0MUiAokOwDWUhyyl0LJSNOdkjxRNKj
	VaXKQ5+rCXY87D76ty57aMXKvquG6ozpcHUNUrhTAFGC9y+Ru3aS7KlZbM47XV6SuahS5yBDLzo
	NNco0VbiaO/NxukIqDhRBF8Ot9TgXx6HsA75IJV50HeI3itn71yFI0lf13uopv9A+endEh6pwte
	+2DNhIiyiGmIP6hOkJQ0z4/BMKGBA/fJsmtpbtUkCS6vfowc2d2yxFdL6I5DCWEgTl8sWhUKOUg
	KxIzXm9WlQUWOwnM+o8TWsDC4GEBOA2zINxflYAPG0JlGpkz1KEzJuQEWRUy22Y5wtNNQafVLnt
	5eL6N8ZUj/CqpIJbMjuauD2609vrjoyS9jlDj4sryKAcKnP2gG+34QOTKYP0BV1C2a9RRSmTl3Q
	+WMLgK8xJEXw==
X-Received: by 2002:a05:6a20:7492:b0:3a2:bd1d:d679 with SMTP id adf61e73a8af0-3b22ee02ee4mr6895309637.48.1778888336776;
        Fri, 15 May 2026 16:38:56 -0700 (PDT)
Received: from ryzen9.. ([2001:ac8:40:25::15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm6391265a12.14.2026.05.15.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:38:56 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v6 6/6] wifi: mac80211: Fix PERR frame processing
Date: Sat, 16 May 2026 08:38:39 +0900
Message-ID: <20260515233839.86829-6-masashi.honma@gmail.com>
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
X-Rspamd-Queue-Id: A016A559618
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
	TAGGED_FROM(0.00)[bounces-36506-lists,linux-wireless=lfdr.de];
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

There are no issues with the PERR processing itself; however, to maintain
consistency with the previous PREQ/PREP code modifications, I will create a new
mesh_path_parse_error_frame() function to separately implement the frame format
validation and the "not supported" check.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 45 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 14 +++++++++--
 net/mac80211/parse.c           |  9 +++++--
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 8c32a52dbd6a..2bcd3704ad3b 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -374,4 +374,49 @@ static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
 	return true;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
+static inline bool ieee80211_mesh_perr_size_ok(const u8 *pos, u8 elen)
+{
+	struct ieee80211_mesh_hwmp_perr *perr_elem =
+		(struct ieee80211_mesh_hwmp_perr *)pos;
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
+	if (elen != needed)
+		return false;
+
+	return true;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index fdde827bc1b0..45ee9ea1ff56 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -960,9 +960,19 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
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


