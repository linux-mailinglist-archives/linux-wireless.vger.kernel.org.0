Return-Path: <linux-wireless+bounces-37679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WOYJPryKmqgzwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 19:40:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75867413A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 19:40:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FRRf6KQF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37679-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37679-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AF5D3002B2C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A404968F8;
	Thu, 11 Jun 2026 17:35:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98F383333
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 17:35:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199316; cv=none; b=DBV7skFsQKkBePSuOOtU9DfGNN0YfW/BygcLwDWncAJvaAkcMZ/rxp6Xu4HUOuphcRLkJGc4jb3kG9CYeR1Tx1FvQWABWIxDb6TXL0kwgy1reCKOPTB02uoY+Ze9LloJuSC/STzKzjj1ZUKi4rt6MLBY3Ww5zvQpVjwdBKFN7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199316; c=relaxed/simple;
	bh=FuQd8meff7oP6JE01DWJHh6bS3K5BZBiEhXwQSMVXEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFfsKtTKZNAypA6rniEerdhXs74iDy///QDd1WdlJZsl8+PvSJ+0EjALscocliBDfpd1vUUO47fQMO4aVvbsNKtK5MSsEnCkbgLgvPVHVF1RSNC5IsRkimg39AJJQd7TsMKN5XAjh9Lvowt17z+EkhlHTo4jWHNkvr+wvDfXEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRRf6KQF; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b8d414666so145803a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781199314; x=1781804114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOh4h1Jbp5Tyf36zO2G+zbdh9lsb9GzpQeGsDyR6Flo=;
        b=FRRf6KQF4azGjv6YThEWK0B7Fv1icigJzi6/4MaDWj0bv7CizKCkan3LR9Dt7w0IGZ
         9Kh5B3caJVj8y3EBgaBjU2KXelvrkCNyW75nwX3KlJo8sm55zV/2jB4bFxla3p5yIRI3
         /+zKqOGpgYpgaI3xbG07RQzPfk4i7RwKl+Rhxx9UJU6O8BiMKck0NFmZiIUMiws/IuEM
         IqUzeeFGlQE03Gle8bNNOE+yZrRd6s6uwoEscGCAYl8jcfEhljIpyrFoDDv7CxyAVQnt
         WAMmpcQRrSRI4h72ECiarOTOj65MwvmeyLSAuhPjGH2QfPzha7EHMrUevrR+tMgBppMe
         zQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199314; x=1781804114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOh4h1Jbp5Tyf36zO2G+zbdh9lsb9GzpQeGsDyR6Flo=;
        b=UyycZpCx/Ox1cl/TBFY/Sl+L0Los8GlkGwmwMcdJPRbYrH7/W+0bsA/PYiub0rQRvL
         UOw6G23JMTii3OI8L2S+63eRNBSnHYyMn0rv8yaaQihZzqYrRXm17RWJyFwwuj+Q/UPd
         vux/KR0zY1VkGt2Hu0DD8sg4eM2ZlwWJom1rsoj4CCptJHD52KHQWWSBmdgv5UkBQMxb
         wWc83fRjoFWrPyd47GqHk2qKRmIWRF5ZZ90Cjj2QeUuc0nk/jNyCxG0scS+VzA02RoUL
         gDYBXJVZ23XqyiJcVfI6n4Wdyn9pzCWbe4+ALm9OiarI+RkwSZyXsWmu5SoiJS2W4Uuv
         Gl7w==
X-Gm-Message-State: AOJu0YzTHr4XhktIjaS24eEawyLZrErNYP/mMNp/vzG/flB3orqMutkZ
	frcgDZTNr36mgAQQwcQUyjnhz9qtLfY6FUOkvA/HJM9pKGShkcaIBNl9
X-Gm-Gg: Acq92OHllSJzVIrUnbMZ46xGwy/GTNEC5zCJE0Ri1s8T0TiZCOIN8CbA1leYE8SWime
	M7y6H6n54tq72yUrFmPy+xz+4kNR620WiijEvwiD6kCU/fiwoC7LekZB8C5FAHKs/I4Q42E70Nb
	Ws5W9CYL4rff3SdJM4RvBrWv59mvePECQsDO7GRAaGLqbDXVe1Tg7VZ+ajaeXnEr4heBBgCJdIl
	EBX3y9zzs855uyBoT9w4/TyUER9ZUmT9aYfsfa6idNh2yahT7ZxvdRj3ckImRt00+STLhqNR4y3
	osU9D5HOgqJDfuJv90krscQL5gEWdIYZuloDKdjbnSm6Y0YtrFiPn3mw3nZn2xIYkCZlw41G1my
	tV8kE6MT+qLNpTIkV4ovpCNRTn1PbuRxKJpOlqmT6n7DlL65YLBLf6WYNy4h0EaWkVeGbDUGhTD
	NIutcoCl38q//AurvKWRgNy8qU6GorlxjNmyOOFxFpPwwd0aFHrLFlCZz11CTxkBM=
X-Received: by 2002:a17:90b:394d:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-3778edd65b1mr4601128a91.0.1781199313748;
        Thu, 11 Jun 2026 10:35:13 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843380c9307sm2416294b3a.29.2026.06.11.10.35.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 10:35:13 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: ieee80211: validate MLE common info length
Date: Fri, 12 Jun 2026 01:35:07 +0800
Message-ID: <20260611173506.36838-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37679-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E75867413A

ieee80211_mle_common_size() uses the first common-info octet as the
common information length for all known MLE types. However,
ieee80211_mle_size_ok() only validates that octet for Basic, Probe
Request, and TDLS MLEs.

Reconfiguration MLEs also skipped the length octet when calculating the
minimum common size, and Priority Access MLEs skipped validation of the
advertised common information length.

Account for the Reconfiguration common-info length octet and validate
the advertised common information length for all known MLE types. Keep
unknown-type handling unchanged.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 include/linux/ieee80211-eht.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index a97b1d01f3acf..a557df0088c08 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -844,7 +844,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u8 fixed = sizeof(*mle);
 	u8 common = 0;
-	bool check_common_len = false;
+	u8 common_len;
 	u16 control;
 
 	if (!data || len < fixed)
@@ -855,7 +855,6 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	switch (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE)) {
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 		common += sizeof(struct ieee80211_mle_basic_common_info);
-		check_common_len = true;
 		if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
 			common += 1;
 		if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
@@ -875,9 +874,9 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		common += sizeof(struct ieee80211_mle_preq_common_info);
 		if (control & IEEE80211_MLC_PREQ_PRES_MLD_ID)
 			common += 1;
-		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+		common += 1;
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
 		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
@@ -889,7 +888,6 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 		common += sizeof(struct ieee80211_mle_tdls_common_info);
-		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		common = ETH_ALEN + 1;
@@ -902,11 +900,10 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	if (len < fixed + common)
 		return false;
 
-	if (!check_common_len)
-		return true;
-
 	/* if present, common length is the first octet there */
-	return mle->variable[0] >= common;
+	common_len = mle->variable[0];
+
+	return common_len >= common && common_len <= len - fixed;
 }
 
 /**
-- 
2.50.1 (Apple Git-155)


