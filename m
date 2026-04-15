Return-Path: <linux-wireless+bounces-34859-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODofHv4R4GllcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34859-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:32:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D4408B11
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942CE31E9770
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644239EF01;
	Wed, 15 Apr 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPhqKRmb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E15395250
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291892; cv=none; b=nmnNQovVv9IXhrTqyPt0sTr6vWpT+e3QhImj7oMNhZJJL8hmA39m8M8iUS2mCyqsaEdHOGaQQOgoKGBcNEEuiuZZG5rehohhgQz+KhaigEacuptGElTCQkm+1hp9v4IFt+7rIyVhR/VyvY/0FsbmTIbJYn0aeRu+lYNZJQwF2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291892; c=relaxed/simple;
	bh=BSuO+qOlS3F7atOHG79L1E1+tMMUdIkTkmk3dkBnW3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYHHD0BNbWJ2yWJgDrl9ddovOi6+nAYAsvrHvRRI/M9lDD0EDuxZDjw96p9MGmYT2MoN7Fs5sOHvApnZE8eO33TgUJlUrbdehCw1Dy0DDfGFYQUM+zwEnMUU5EsXYFEDsWeNrBCWgXxqLm3N0R6z+pRdfIcGk72YJ7WG9Jqa8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPhqKRmb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso88717965e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291889; x=1776896689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hluYQGcB+W8nxPaX9EzEWVpdVG2+I0dxvmwwIX6jdQ=;
        b=oPhqKRmblQxwsAOnLRYIQLDN45OUEsHvL6/tZOC++fWxK84oAfn9LMQyM52n6volVd
         ha/qzaksWtf7Osh8mV2YjZoPJNddaZOgKdmpQSBaSmsNKhYDdZa1mLVaqkQai4TnujnE
         A0I6mx3fGbIzQtGzdX+dDLPwVsHEGbrVbTNcjSbUOOr5Cq0z0B16l21zZCuuEd8cJ/pq
         tlz9Gos3dioEv4KGQLa/Mqn5QrEGHfj3kqzt8x3K9kJlfwErDSM2RhV2fPXc7MEgRcUq
         MkO2P4A+0gf4LCahu5L0ByQXgjsTdc4ImMWFBzcUJL8ggJY6q7+5aNk63K4FH3T7mNa9
         4Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291889; x=1776896689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3hluYQGcB+W8nxPaX9EzEWVpdVG2+I0dxvmwwIX6jdQ=;
        b=fjcYcfhj5KrCT862bDOgstAkoqcBAb8RBJuRIZhVIPQ+0CksOf03/SKL/0kNX5p0Hs
         qE+Ey6FDMEMiZYqlHQbnX7vISxUDODJpSBxvn/VckgFfLHtkKx4k1+iR0nX+/X3RMnvX
         kSQLp/WkaDmwXoTBx0bMw9hvN6vHuDbJE+hKIx4zUc0iB9aMEj3MAeCF77qMe7F+KWJM
         sjP7vf9B1Yw1jFdVzO0sJiGxIt4HH9Pz4bdw74uBYIY1eYQ/h4j2wpoPS4LZrsKy52U9
         yTND/N2gPh/btTZvVeDJG6wK3IZB0+4QpWFZEYhZlxvfBSEORttqbA8Wz7v6LPsVFHH2
         RBYg==
X-Forwarded-Encrypted: i=1; AFNElJ+Tj4WfVpNqaXrLPSTrI0txCdSM4txpF4uS+qVZXmvKXnSKMds54Q9WHypwqZoPKi2/GutJTCgp7eraUp4uyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjH+/NlOS27hEjb6J3dQnU7N/v+uNRoy37wBZRDUVBRb0Bj7P
	Y+dTDoD0Tfm0Mj6hZ3D+JWS25DnFlAkjW2Ve1hbortScu7+354r+Rpw=
X-Gm-Gg: AeBDiesFHxhJFJEHSVfh2DO3yKDhllhfg2cKOTiB0rdqUWXCRoANURHMk8+NG+NXADF
	68Bze9syeSQBl5CLk941lU8gXRDAWcxk5d1C1+jzBy++CbKxHwO5fqtXwe11LkD/i4vr6Pm7OSx
	QH1bk1QaROFr9fPuP4/bW4xfu6q1khNqFX2o3F9Um85A9hh7yTSV6eCJ6uYw8VOSo/87D1F61LU
	V+EaTJWHyyDSOfMQZKmeLUJSVRY0AAiv4fNu3w7IUX1Q3Tgey4Cm3fKaKKumA0+L79YXkaelJAF
	yl+Mr/b9IdTLK5qF1o3KEYAyUsvbVXFJykpVNe1IoyO0cAlHNy8/7g1osRGYGcQebL0yuwCCR5w
	Gd0LOKl25818wmWQEyxv8kyqXWVo1UZSlyjFQkgncavSSmqMhm3uCfr1W9BHlDAe7HNE8FMC81+
	Xv7pw=
X-Received: by 2002:a05:600c:46cb:b0:488:c51f:e04e with SMTP id 5b1f17b1804b1-488d67f3a0fmr320690825e9.13.1776291889047;
        Wed, 15 Apr 2026 15:24:49 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm3144295e9.5.2026.04.15.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:48 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: libertas: fix OOB read from firmware bssdescriptsize in scan response
Date: Wed, 15 Apr 2026 22:24:46 +0000
Message-ID: <20260415222446.1546616-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222446.1546616-1-tristmd@gmail.com>
References: <20260415222446.1546616-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34859-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: EE4D4408B11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled bssdescriptsize field in lbs_ret_scan() is used
to compute the TSF descriptor position without validation against the
response buffer size. An inflated value causes out-of-bounds reads from
the 2312-byte response buffer into adjacent struct lbs_private members.

Add a check that bssdescriptsize fits within the response data.

Fixes: ff9fc791940f ("libertas: first stab at cfg80211 support")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/libertas/cfg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -555,6 +555,14 @@ static int lbs_ret_scan(struct lbs_private *priv, unsigned long dummy,

 	bsssize = get_unaligned_le16(&scanresp->bssdescriptsize);

+	if (bsssize > le16_to_cpu(resp->size) -
+	    sizeof(struct cmd_ds_802_11_scan_rsp)) {
+		lbs_deb_scan(
+			"scan response: bssdescriptsize %d exceeds response\n",
+			bsssize);
+		goto done;
+	}
+
 	lbs_deb_scan("scan response: %d BSSs (%d bytes); resp size %d bytes\n",
 			scanresp->nr_sets, bsssize, le16_to_cpu(resp->size));


