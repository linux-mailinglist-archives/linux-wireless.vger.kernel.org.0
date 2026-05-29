Return-Path: <linux-wireless+bounces-37165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNLjI9QcGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B05609A3C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 859833052715
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51749368D42;
	Fri, 29 May 2026 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYp9yobZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B836C580
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096209; cv=none; b=lVy0MBNYa5CVyaVCAO5o45t+z5JZbyKHSVoFkCiBYsdAr7eRHPsrpqEacShkSYi6ndl0MBIB4B8Z/Cb3K6SU19VrgKxmcKzxizag48S1/v4oDHh8YpjjEgk1YqaHgYQYe8ah2uvp052esQUCl3qebl/M/1U0AnWiYjRnzikNhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096209; c=relaxed/simple;
	bh=4c59LqD687uyXtS/NKkaigS7hLv1RJbTj1QFG2DYBCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1KAKzAdpm+2QwotYAq/Zi3tYexeI6WNRalqX3g6IfWjx2Pzgn6SCj9tt/vjuKUWgNKigwFZqmYGcBj3/XjWRjWKlrXGSGwOHvqV1acFgt6+BLihiVMxlIQkYb5Buk+O3XQMJSOW4809dQ45+PfpsFm9el4F81A2derzVv6Irog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYp9yobZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so1238343a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096207; x=1780701007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQOkpIhCNGH7E5vbF0EIsmOb8F/THYc/kz5isyXFaYo=;
        b=nYp9yobZrCNtVtZwoC8BKPfpdCVUo4AxrBImFz2M2aAYcQJjOdabSHSrR3hYqTWTiK
         8w/ZcoH8uZs8AJ5fKAaKL1cdvHBz3u8+faHUkNpA3jBjjF4kdxVPMQZvFZ13vufa6hmL
         GzuqQhKBRReVEVY6H8TCgHFQfsLRTWxA8s/24+CV9UwjA4ZfnPCCvLDViv/ozfjIcIxy
         2xhAtBa15DCeItiq5kTEyK08e9EjoIKoYoiy4ld1xbBRE3Ru80lJLQ78yv7PXPuNzaDq
         fYXUCmwWGl5NY5HBD8CE67o6eWwo2bQGa1vv3r/eoawcBsK7syDiAW6SnuKenby3XCNK
         I5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096207; x=1780701007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQOkpIhCNGH7E5vbF0EIsmOb8F/THYc/kz5isyXFaYo=;
        b=Je7pS5UDJwoYnBp1QpQRNGPWaGe5lgPGs/nRuB2SZbiKBG1F5EHjO1dza3xIqvkYua
         jL3934zTYfbKHURVb/Rjn67F1L7mbIrzr1ul/rR1VhbQNhVQTGRy8b4RHsnodSgCRfSo
         v1QbTgSq+5swYSAp5Ajg0dROcHJHB7TqqbLgz9hUtrm5KElsTnRkuq3e8DtiPXEFXH+f
         QLQr2IpKNwZKvoyTI0/FcB6AnOsOMVvwbBTknMZJtcBQyLxk8lYPkoI1BvTHe8DXe7fp
         vASsILwaVLW0zjBZiAU0mS/4ym5WtUsJeyJRkpERFWErMKVO7M0BdNCBJQlb0NLvpN/p
         fQ5g==
X-Gm-Message-State: AOJu0YxidD+uRaE+/LZ3QZ0CVgF0C0VaZCExZrpO1kSgYkh88cAYIDT8
	4vKkOFQIZGhLLne1L7tuZZfRitzfPah0f1T9e/HQe+diF54tvuUsesp5mWcc7A==
X-Gm-Gg: Acq92OFZF/NyTZg4NUNxYkzaYdqhxkKoLF3oAHLy61wXmwGdipnZ1c12A95RuLvb+JJ
	ELwua6q70bczuhigr8txV8HQgTh6Es388XiBk2gWLQMHj/aBNyfzwmbqsqY1KO5MBbn1zkG4TIU
	mg/pJLVeDeVRQX0X0+lQg/lo/o2askzSrwLR97gjLawNoVVWzODQdmRytPBW+WpfAoq3nHl5HJc
	QZSLaJusHLOSpyUTsenGnO9fIPuB/MBA3TQPABuD6oW5Avg05B997f6jszlNhGxbkeEIZQdmi1y
	v11HYC4NtU444wMc4VgXMPPOJzt5aqGzJ/9+UOP74q+850hnzi28nlr4sBgs4pEE8QXwo8lYXDy
	iKTPD/8fxgq9XyqXT3tuiKhxL9NfwaytybdZZGSZgrON6HC/QuzGLHGqWttVelx4Gl6CtXiGyAy
	g23k2sRrRTWx9Kl4xMbTqtfioEsIY=
X-Received: by 2002:a17:90b:264e:b0:369:7433:2fe with SMTP id 98e67ed59e1d1-36c4ff25853mr1171761a91.6.1780096207427;
        Fri, 29 May 2026 16:10:07 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:10:07 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 8/9] Add KUnit test for ieee80211_mesh_prep_size_ok
Date: Sat, 30 May 2026 08:09:50 +0900
Message-ID: <20260529230952.124754-8-masashi.honma@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37165-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 53B05609A3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/mac80211/tests/elems.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/mac80211/tests/elems.c b/net/mac80211/tests/elems.c
index 576ba746a526..b96424d5d025 100644
--- a/net/mac80211/tests/elems.c
+++ b/net/mac80211/tests/elems.c
@@ -97,6 +97,46 @@ static const struct mesh_preq_parse_test_case {
 
 KUNIT_ARRAY_PARAM_DESC(mesh_preq_parse, mesh_preq_parse_cases, desc);
 
+static const struct mesh_prep_parse_test_case {
+	const char *desc;
+	u8 len;
+	bool ae_enabled;
+	bool result;
+} mesh_prep_parse_cases[] = {
+	{
+		.desc = "shorter than header",
+		.len = 12,
+		.ae_enabled = false,
+		.result = false,
+	},
+	{
+		.desc = "non AE short",
+		.len = 30,
+		.ae_enabled = false,
+		.result = false,
+	},
+	{
+		.desc = "non AE",
+		.len = 31,
+		.ae_enabled = false,
+		.result = true,
+	},
+	{
+		.desc = "AE short",
+		.len = 36,
+		.ae_enabled = true,
+		.result = false,
+	},
+	{
+		.desc = "AE",
+		.len = 37,
+		.ae_enabled = true,
+		.result = true,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(mesh_prep_parse, mesh_prep_parse_cases, desc);
+
 static void mle_defrag(struct kunit *test)
 {
 	struct ieee80211_elems_parse_params parse_params = {
@@ -195,9 +235,22 @@ static void mesh_preq_parse(struct kunit *test)
 			params->result);
 }
 
+static void mesh_prep_parse(struct kunit *test)
+{
+	const struct mesh_prep_parse_test_case *params = test->param_value;
+	u8 data[64] = {};
+	struct ieee80211_mesh_hwmp_prep_top *top = (void *)data;
+	top->flags = params->ae_enabled ? AE_F : 0;
+
+	KUNIT_EXPECT_EQ(test,
+			ieee80211_mesh_prep_size_ok(data, params->len),
+			params->result);
+}
+
 static struct kunit_case element_parsing_test_cases[] = {
 	KUNIT_CASE(mle_defrag),
 	KUNIT_CASE_PARAM(mesh_preq_parse, mesh_preq_parse_gen_params),
+	KUNIT_CASE_PARAM(mesh_prep_parse, mesh_prep_parse_gen_params),
 	{}
 };
 
-- 
2.43.0


