Return-Path: <linux-wireless+bounces-35153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UONTFNqB52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:55:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35343B994
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 500CD308F085
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604613D9DD8;
	Tue, 21 Apr 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F40g/40P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8303D9050
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779387; cv=none; b=grXQl7iciga40+e6P2y+8jfQOKISxnh4E13I1hN9m0vr8Y8lj9YeLfMgS3AQGGV0nasgndjNy04lMX6Y3O2jofX6ATHynkgrWiNP//WzU3XbGy8emOlKm9SdATIO7W7obN4wNNgCghkal8wFk1tCU5jkTI/TK79vWwihmJMorlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779387; c=relaxed/simple;
	bh=c/bZxv6gDBXjU9aT8y6UhmuhShqHpL/bUDIqZjpYfmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrKlFs33kXV1TfmONRR3CXC+riJfsKxAdH3JrtlotAHyoG/oZyXOf8Jt/XTKh3N/PHw4jaEaIwR5vCRUW8azP8HcH2s/JoLsZKQRTd9h1kn4nIkK8aNwqCDBvAHRjg2DFvabbLPHLguMaTxG9OPwy5yuyVVmLGdrsc3wR0KiVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F40g/40P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4890098abbaso29137825e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779383; x=1777384183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0zzfI2rQEV+jXiB+O0qtXX4eVvaANJECW9EykocPFs=;
        b=F40g/40PUbYT/5iR7MZSbfAR2SlITnGi5Mg8JsfiRrigdQyH54LEvzfYC8RjqBdkXa
         zA1AKm3ZMrjfPBFaq67q4YpNlEGdNMdn6gY2xxf997Iw1G99ap+oIM50srk9kPDSXAFG
         FQtjXQS7j8HLqhPNwEZAum47aTwLyAJfS9fQO6Xb5tCRSOXVTlTOhCZT0pzuEyy0RIdF
         2D3Enw4Rt+aQXTe31UclsGzPPjwK+vHnfS4t1QfhISPH0ZL9+SHxouBdFhRDU0h2JvUk
         ZASNcYsDi9/IKjhn5QMvMMXKOD8nQ1ZSsde33ozePU4XkgMdcSH2jNFH2iC9lLBGlINV
         zteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779383; x=1777384183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0zzfI2rQEV+jXiB+O0qtXX4eVvaANJECW9EykocPFs=;
        b=eGGPpuvhfnREe2VmyrjNWb441ahPM3BvbqFeMy/UW6feNZ7tfzfMYVU+L08UhF8tgN
         ni7HyfgS/3oaLCvrpsJnCWUVsoK41RtOHaLqS2o5yBgQrxWCvBKuOrE5KqELw1bVCVwm
         /WXi0mUN/uvnGDpgatj4aTc1+ipJlf6ZD4f6T3aLSgbzPlB6gPQDAWE+opT9oLuwbxm/
         GwBnoQMmpbIWZePVY0/4UqIBP4N8lvOPmw0bpkGI3PTBdl+oUk04ue0DW4knkJnoriCc
         5eSZv0gS6G1vROe0BwlEDvV7AeVFkfmNBqKNCzC9HqHdqA49ysdzAJBXU+Q03yI7gCJl
         rqng==
X-Forwarded-Encrypted: i=1; AFNElJ/KmEIFc8qnyMZFo/G/FNgIMcFv0ZK0ZyZw7fkL3KLCbDRAXyBIAs4lqQiOWxsMXon6T+KjA31KQ1Ft1vlp4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi59XUedmrMjI9crvjjeD0LdytCjcHgBtssSK04llDcV+es7kb
	ZPELl6nwlR7jJQO5ag4tZR8548npomo0RiCYtPmRI2Xt21DUeYBOh5Y=
X-Gm-Gg: AeBDies49WRW0yEA7g1t23LF9G+XNdJ3UWA/memLM28ZMdrb0M4g8DtxRgCB75/W2a9
	0Xo0/e6cL8engFo6nP8QtIEzAWTS58ku3P9Jl4JJyKWQlvytE9lHlofltGnDc0AZU4VVUdjhxPP
	MTXKeBMU9O6aT3ttjnG42jyQj6FeWmVH6jK+BXmijkIstCNVQKQiCFVmq1FqOukeCLazUgOc6B/
	MglSDvqJrizZAtKpomMmAVha7V0/gqYs1zFl0/TXVgZtfPDvYFPOcUuOLZY4120C0f25j948aSr
	amdkuFbKBIdwEiWbihpivWOpBI0OZOpy4kCZqhn1N5dKa7bwvg/DYVllI6MzTgFaE4AKpIDD77F
	nFi59098eAMOLwB7lf5VIWXqiFrUyp9l0etnFM0pU0NZY/QqRW8A5FuVhFpSKXhOi3yjsedh09I
	ITrgg=
X-Received: by 2002:a05:600c:c177:b0:488:a82f:bba9 with SMTP id 5b1f17b1804b1-488fb7804f3mr246600625e9.22.1776779383165;
        Tue, 21 Apr 2026 06:49:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/6] wifi: mwifiex: fix OOB read from firmware sta_count in station list response
Date: Tue, 21 Apr 2026 13:49:35 +0000
Message-ID: <20260421134938.331334-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134938.331334-1-tristmd@gmail.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35153-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED35343B994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled sta_count (u16) is used as an unbounded loop
counter for iterating station info entries. An inflated count drives
reads past the response buffer into kernel heap memory.

Add a check that sta_count fits within the response size.

Fixes: b21783e94e20 ("mwifiex: add sta_list firmware command")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 85512f526c5f2..4cf654046c6ae 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -976,8 +976,16 @@ static int mwifiex_ret_uap_sta_list(struct mwifiex_private *priv,
 	struct mwifiex_ie_types_sta_info *sta_info = (void *)&sta_list->tlv;
 	int i;
 	struct mwifiex_sta_node *sta_node;
+	u16 resp_size = le16_to_cpu(resp->size);
+	u16 count = le16_to_cpu(sta_list->sta_count);
+	u16 max_count;
 
-	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
+	if (resp_size < sizeof(*resp) - sizeof(resp->params) + sizeof(*sta_list))
+		return -EINVAL;
+	max_count = (resp_size - sizeof(*resp) + sizeof(resp->params) -
+		     sizeof(*sta_list)) / sizeof(*sta_info);
+	count = min(count, max_count);
+	for (i = 0; i < count; i++) {
 		sta_node = mwifiex_get_sta_entry(priv, sta_info->mac);
 		if (unlikely(!sta_node))
 			continue;
-- 
2.47.3


