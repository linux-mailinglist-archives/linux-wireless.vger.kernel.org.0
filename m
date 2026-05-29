Return-Path: <linux-wireless+bounces-37164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF+8LdMcGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B2609A34
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5564C304FFE9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E436E498;
	Fri, 29 May 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWIIDfyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6C368D42
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096208; cv=none; b=AFXz0Xgncw5q2J07xrAR5F+69G5S+YBDc8dujFAp2Szuaabm9GZwsy1wdMPqMN8v630sIVlnzPY8iFlW7MFBytW4G3xiyvn1njZTYNbpjNs3RIbiP4cjFo3psA+JVWMEseoe6TRhB9Jr7SvVXkZQVrlSdoBwTJBC7ZRUfnZsD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096208; c=relaxed/simple;
	bh=hXEbkMSvvyoJNq4PeaaDeLfF+/4YXS8mD5YDKhjz4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nzj3damiiQ3sV/5NKFj0Xph34/0lRLBTTDcKwjt49/BbVFcmKWnMmWmqR+n2r5YgAK4YCa5vjIZmZzMQmZfFLr1t6k90t2EOt0HufqQlGc0RZh5gib8vvYNAvtvQuFNgeTPIzv3p0/plOIzpewxa+bLJuHbnYEnarlVSJaCzrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWIIDfyC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso513845a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096206; x=1780701006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkAFjs0pl9rNK9x4uY7qHoj5/e2KVlplxUNHi91E7I4=;
        b=KWIIDfyCwHNX+x48XgD9RPbWsUy0hbhVvMvvbbpAM2kY+tUuZp61gpc7Snmwfi63yv
         oPwmfooYt8SAiGyCFzEN/J6g57g0ryXkUCnW8nkFTRFJ7+0n+iDau1RitTLpFzNaAgqw
         3KS6Scg8uht7UHOPdz5VHQTbpLtnTf/c7kxzLUTmONUhwMv4uMAu5/AmnKceNjJud5G3
         iUXqnCnN5IcoANNZN9SpQjbj+8/V4qmBDFYph41a3nKv6Gzttfu+CmZRt9xa1iJDafKc
         H1LMJiH8yT3puqElr0W5dYo3QTrQjE9c7nfrc9Xy4C5fl3WOPkAJE/Gt7ahXGAZdIBy5
         JLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096206; x=1780701006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NkAFjs0pl9rNK9x4uY7qHoj5/e2KVlplxUNHi91E7I4=;
        b=EOmrbTfXlWS27gpX4nuklMq6ihc2u5AaYt+nA5T2WxMPBWD84R1YGxcqjYqZkDUZf8
         PrpNJ18cmXDLq6ou3ydGSQzDn/jXqnmc0wu6UtrZUmmdfMAuLnjCWTyYIBUtHktIFjGr
         Hq33p91LDZl7cuUH3r5uFPHKAGyjlCck+UrRy0rwJ5nhG8ybb3RMlrAJczjSmid1Qv5p
         eOo5UgqlkxS1GWKlpnt6lLD4jQlwBGu11kTe3BQqYQEfZPHdthsJtoi54p1h8seeODFW
         55k5OSzNy+pzbcABeUul5J3/Fk4Y6n2jPQ4gkgbJHJsS3Sl+ODfVxLpl/bBqn5+5ohjd
         4hgQ==
X-Gm-Message-State: AOJu0YxsVbXUaZ1hlbKbZQ2WC0ZDB0Nn0d1O02L0VfvVbsP0djsFrnvS
	FrM+WpdYKJXjBmyGuI5fIaNPIWoyDt8eXKQnlxVkKALZXXEWNsbrHbpb64iCXg==
X-Gm-Gg: Acq92OFS5fIpaAYrc09TgZUw702nzvRBUWgoaDVK6ZDTZ0zARtTl78+2y9oPNkStDPU
	tkOvUUrA10zut1ApkEayVSSsIrxUFu3boDMs7rUzZvICSm2oOci/F+jKYCeo+RFWzhwgVsOcg8f
	EG1RVTQ6dIB0uCExFGpxqQZrwgyYDQ3+oGw/VRMNFPwFGlgQneOZqNTwfdgXgUTn+LeM/7VXNBX
	rdZIFaxdbwQG+z7En8yD+CJ7IUKkdWhcMhgJmMTr5iI78ImPyZInxxbF27gtO2LSGn6ND4ocXTo
	FuJsU+SPyoe/llRwLt+3+xLcUtqLjvENVEz6ikupJlwD/5n1CmLPVDORO0nTlGTsInNbu1QEcuw
	Fk2348OH0hBRaE/83dKG7m8E+p17P8pUzutDItCK8HttxFi8c0xv5V+TgssUFc8h5bZOebHRnx3
	q+IYC7clWBMwwEYwnplpaf7sCxKqE=
X-Received: by 2002:a17:90a:c2cc:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-36c50217929mr1119291a91.22.1780096206172;
        Fri, 29 May 2026 16:10:06 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:10:05 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 7/9] Add KUnit test for ieee80211_mesh_preq_size_ok
Date: Sat, 30 May 2026 08:09:49 +0900
Message-ID: <20260529230952.124754-7-masashi.honma@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37164-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 7B7B2609A34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/mac80211/tests/elems.c | 105 +++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/net/mac80211/tests/elems.c b/net/mac80211/tests/elems.c
index 1039794a0183..576ba746a526 100644
--- a/net/mac80211/tests/elems.c
+++ b/net/mac80211/tests/elems.c
@@ -9,6 +9,94 @@
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
+static const struct mesh_preq_parse_test_case {
+	const char *desc;
+	u8 len;
+	bool ae_enabled;
+	u8 target_count;
+	bool result;
+} mesh_preq_parse_cases[] = {
+	{
+		.desc = "shorter than header",
+		.len = 16,
+		.ae_enabled = false,
+		.target_count = 1,
+		.result = false,
+	},
+	{
+		.desc = "too short non AE, target count is not included",
+		.len = 29,
+		.ae_enabled = false,
+		.target_count = 1,
+		.result = false,
+	},
+	{
+		.desc = "too short non AE, target count is 1",
+		.len = 36,
+		.ae_enabled = false,
+		.target_count = 1,
+		.result = false,
+	},
+	{
+		.desc = "too short AE, target count is not included",
+		.len = 35,
+		.ae_enabled = true,
+		.target_count = 1,
+		.result = false,
+	},
+	{
+		.desc = "too short AE, target count is 1",
+		.len = 42,
+		.ae_enabled = true,
+		.target_count = 1,
+		.result = false,
+	},
+	{
+		.desc = "target count is zero",
+		.len = 26,
+		.ae_enabled = false,
+		.target_count = 0,
+		.result = false,
+	},
+	{
+		.desc = "target count is 21",
+		.len = 255,
+		.ae_enabled = false,
+		.target_count = 21,
+		.result = false,
+	},
+	{
+		.desc = "non AE, target count is 1",
+		.len = 37,
+		.ae_enabled = false,
+		.target_count = 1,
+		.result = true,
+	},
+	{
+		.desc = "non AE, target count is 20",
+		.len = 246,
+		.ae_enabled = false,
+		.target_count = 20,
+		.result = true,
+	},
+	{
+		.desc = "AE, target count is 1",
+		.len = 43,
+		.ae_enabled = true,
+		.target_count = 1,
+		.result = true,
+	},
+	{
+		.desc = "AE, target count is 20",
+		.len = 252,
+		.ae_enabled = true,
+		.target_count = 20,
+		.result = true,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(mesh_preq_parse, mesh_preq_parse_cases, desc);
+
 static void mle_defrag(struct kunit *test)
 {
 	struct ieee80211_elems_parse_params parse_params = {
@@ -91,8 +179,25 @@ static void mle_defrag(struct kunit *test)
 	kfree_skb(skb);
 }
 
+static void mesh_preq_parse(struct kunit *test)
+{
+	const struct mesh_preq_parse_test_case *params = test->param_value;
+	u8 data[64] = {};
+	struct ieee80211_mesh_hwmp_preq_top *top = (void *)data;
+	struct ieee80211_mesh_hwmp_preq_bottom *bottom;
+
+	top->flags = params->ae_enabled ? AE_F : 0;
+	bottom = ieee80211_mesh_hwmp_preq_get_bottom(data);
+	bottom->target_count = params->target_count;
+
+	KUNIT_EXPECT_EQ(test,
+			ieee80211_mesh_preq_size_ok(data, params->len),
+			params->result);
+}
+
 static struct kunit_case element_parsing_test_cases[] = {
 	KUNIT_CASE(mle_defrag),
+	KUNIT_CASE_PARAM(mesh_preq_parse, mesh_preq_parse_gen_params),
 	{}
 };
 
-- 
2.43.0


