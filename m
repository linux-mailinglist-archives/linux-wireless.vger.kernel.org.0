Return-Path: <linux-wireless+bounces-37166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I6BK2odGmqx1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:12:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3A609A8B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEDC3094C94
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136CB377023;
	Fri, 29 May 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY55tmc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833738736F
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096210; cv=none; b=JBLlFcKeMhCqWzb8lOrmbgaFqofyhYW/f52vAyl4XwWtP9US1TVZzFGBFXOcLyrUluCkVyFlVP32efWY9avEaBqaB3Gc6ZsfHL/vJwNq5Tcr5HIvYagBUnk5VRHru6kXFIDDN6de+zBSoQv6KAOsPm3vvQCcL9wu/D09MsX/iXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096210; c=relaxed/simple;
	bh=ss2tcaFc0BFObUP/KdMLVXs1EEtM1pyfB2Uy2pKlQe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTMmP37hasIAAA3QaN+Yq0LEBs5RUNQd8gbWPHtGvrbfzPZUjhCkWsjszonXZtqzp6Sr5m72NogRfEt6PG9TIycg/rNZl8EAjo80+EWZ4GigXutWsBliVOJiYtWKXj+se6yvhWmcxGL1iU8CBU+dtigsZO43pHWaGZPgcC/c/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY55tmc1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36af4b7840aso4346321a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096209; x=1780701009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWfzeShOVWToCkfoI88EIVOQiWktvkFbLlkzMLXgqMM=;
        b=HY55tmc1E/VS9aibgbO7vOQ25/3wBXfJInbq8+ri0Vtym2Sx6g2BrNcQCO4undBfPd
         S51688+xNbZgk5QSiKnDBtkUtCJbockbqasCdAPQlqqlMMdL8fEYOIcHQ4JrsaGJ0P2B
         +mt/zIojEggWtwkvIet3kMOzpnC+TjC0crHEA/jtDKdgXZkkVfrTVgmIIQ5Ri/xbDI0Z
         N+fOwVZff5zRn3mpJpD1fa9zQ6P2kq7V5aPIku9rTerSCjYVpKxDaeWsapAqshEczivz
         Yr71NFHRYbfnoOa6sBsFRFWonesc/QMxV8jkrsZC895VpiPJQAWbAEzlUl2LaBZgBPPB
         AQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096209; x=1780701009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWfzeShOVWToCkfoI88EIVOQiWktvkFbLlkzMLXgqMM=;
        b=cbv2AGate6rn+yeD8dqXEYm2y+mJKgg51R9fMJOYdPQIJ67xWsO2d4FRYYLFw0MIcJ
         219wA1pirhPxvwzF5OTmPvCJb3Kb5dMTyZTDp4AkT4X2rolj+LmJY0JZsHYGDAX/sHHX
         1TmGUvk5BFR3xWU/ULzTqlpTE125juUMTqLHgS4sT8jXqNP5cSa1pp4DmcamNQ0mmib2
         9JufYeeNtsOVCD4NRKEaGWlwMydEmMrp2kz1uqtLX9BrXv3x57V5++dVk4q0vODOLi7t
         7gb9X4xBiCQFwi3GTd0fo+1tKNG5GIv6ZzQ3Wu5k9ThEJ36P/PZeEunsjE2fFfUp9aD7
         XQ/w==
X-Gm-Message-State: AOJu0Yx2nHQwARi5GCghsWuaDnzpsvmra35mH/S7YOB8IShk0TefW6q1
	QrNC9QEXlTcl7EIirfzgJNuz/OL2DH6eCd4ufQNn0wA0Q3R0aK8q2BfcV9vQSw==
X-Gm-Gg: Acq92OEflXw4Bhj2L0qJqHoNjCUKI2b1PmntI/2SAm1NdpUggY9zusoSa9UBJy2YTdS
	nU2O3LLGtBFhd/Yvd61FG9wTE/X0CL0n01v+AuL8H1aojd2e/bSpnEbIqMJ9N6uFfidouriTRH/
	4+7CGVSrdWr6uqCJ7zDmEuUWhfXHZyDnT+V5BMlggTrrKP/sPbqjaMAm/txk+jbU5+GbhtVbXaX
	+fMzHg070wi9iNguoRDWPAqv42jk1F+fO2kxtZwF7FQhv1XDYODcfBvPz2/bpg6zTL/eJRdQnkz
	zg7pTIMz85seeuPguPI2y4tfrsJlJlQJ079TyQEwQw1vO6KEB3gaG3K0ZpX2lGuhrELz+zeL0df
	GKqeVNGVfrRn7kb/KcWtppdLSXCHrnWOAccGvUPDlXrzc5MaoPnTuuXjvnTbAY4+0WB3uALz78g
	T4Ue0bcg1CpDr1Pdmg
X-Received: by 2002:a17:90b:28c3:b0:36b:bec8:94cf with SMTP id 98e67ed59e1d1-36c4ff34042mr1232545a91.9.1780096208923;
        Fri, 29 May 2026 16:10:08 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6275::18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc10c8746sm2512632a91.0.2026.05.29.16.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 16:10:08 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v9 9/9] Add KUnit test for ieee80211_mesh_perr_size_ok
Date: Sat, 30 May 2026 08:09:51 +0900
Message-ID: <20260529230952.124754-9-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37166-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 33B3A609A8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/mac80211/tests/elems.c | 124 +++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/net/mac80211/tests/elems.c b/net/mac80211/tests/elems.c
index b96424d5d025..4b13a5aad875 100644
--- a/net/mac80211/tests/elems.c
+++ b/net/mac80211/tests/elems.c
@@ -137,6 +137,109 @@ static const struct mesh_prep_parse_test_case {
 
 KUNIT_ARRAY_PARAM_DESC(mesh_prep_parse, mesh_prep_parse_cases, desc);
 
+static const struct mesh_perr_parse_test_case {
+	const char *desc;
+	u8 len;
+	u8 number_of_dst;
+	int ae_enabled_idx;
+	bool result;
+} mesh_perr_parse_cases[] = {
+	{
+		.desc = "shorter than header",
+		.len = 1,
+		.number_of_dst = 1,
+		.ae_enabled_idx = -1,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 0",
+		.len = 2,
+		.number_of_dst = 0,
+		.ae_enabled_idx = -1,
+		.result = true,
+	},
+	{
+		.desc = "number_of_dst is 20",
+		.len = 255,
+		.number_of_dst = 20,
+		.ae_enabled_idx = -1,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 1, non AE, short",
+		.len = 14,
+		.number_of_dst = 1,
+		.ae_enabled_idx = -1,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 1, non AE",
+		.len = 15,
+		.number_of_dst = 1,
+		.ae_enabled_idx = -1,
+		.result = true,
+	},
+	{
+		.desc = "number_of_dst is 1, non AE, extra short dst header",
+		.len = 25,
+		.number_of_dst = 1,
+		.ae_enabled_idx = -1,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 1, non AE, extra dst header",
+		.len = 26,
+		.number_of_dst = 1,
+		.ae_enabled_idx = -1,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 1, AE, short",
+		.len = 20,
+		.number_of_dst = 1,
+		.ae_enabled_idx = 0,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 1, AE",
+		.len = 21,
+		.number_of_dst = 1,
+		.ae_enabled_idx = 0,
+		.result = true,
+	},
+	{
+		.desc = "number_of_dst is 19, non AE, short",
+		.len = 2 + 13 * 19 - 1,
+		.number_of_dst = 19,
+		.ae_enabled_idx = -1,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 19, non AE",
+		.len = 2 + 13 * 19,
+		.number_of_dst = 19,
+		.ae_enabled_idx = -1,
+		.result = true,
+	},
+	{
+		.desc = "number_of_dst is 19, AE, short",
+		.len = 2 + 13 * 19 + 6 - 1,
+		.number_of_dst = 19,
+		.ae_enabled_idx = 18,
+		.result = false,
+	},
+	{
+		.desc = "number_of_dst is 19, AE",
+		.len = 2 + 13 * 19 + 6,
+		.number_of_dst = 19,
+		.ae_enabled_idx = 18,
+		.result = true,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(mesh_perr_parse, mesh_perr_parse_cases, desc);
+
+
 static void mle_defrag(struct kunit *test)
 {
 	struct ieee80211_elems_parse_params parse_params = {
@@ -247,10 +350,31 @@ static void mesh_prep_parse(struct kunit *test)
 			params->result);
 }
 
+static void mesh_perr_parse(struct kunit *test)
+{
+	const struct mesh_perr_parse_test_case *params = test->param_value;
+	u8 data[256] = {};
+	struct ieee80211_mesh_hwmp_perr *perr = (void *)data;
+
+	perr->number_of_dst = params->number_of_dst;
+	if (params->ae_enabled_idx > -1) {
+		struct ieee80211_mesh_hwmp_perr_dst *dst =
+			ieee80211_mesh_hwmp_perr_get_dst(
+				data, params->ae_enabled_idx);
+
+		dst->flags = AE_F;
+	}
+
+	KUNIT_EXPECT_EQ(test,
+			ieee80211_mesh_perr_size_ok(data, params->len),
+			params->result);
+}
+
 static struct kunit_case element_parsing_test_cases[] = {
 	KUNIT_CASE(mle_defrag),
 	KUNIT_CASE_PARAM(mesh_preq_parse, mesh_preq_parse_gen_params),
 	KUNIT_CASE_PARAM(mesh_prep_parse, mesh_prep_parse_gen_params),
+	KUNIT_CASE_PARAM(mesh_perr_parse, mesh_perr_parse_gen_params),
 	{}
 };
 
-- 
2.43.0


