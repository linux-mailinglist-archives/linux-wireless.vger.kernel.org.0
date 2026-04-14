Return-Path: <linux-wireless+bounces-34742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBCGAMcy3mlWpAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:27:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 526DA3F9FAE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04239301DCF7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D401390C95;
	Tue, 14 Apr 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InR8j2j8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4903043CF
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169668; cv=none; b=qxhOJeiwoJrh87cq1s8K6xNYiiEY6hP7AfUmkvh4j6VEi6YTkaqGzk7JEE1qFOsul1ob89C6D925jOrTn2OcPUdvPDo8WjieiFtp5U/13eksSlaqt0BnfSSl2ya+eKwnMpF16o3rkn2tLcEn6/fRv0PkNT+EuGgdBHZYDfSMFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169668; c=relaxed/simple;
	bh=Pg0sFIdL9Bj7TCiBCyi37aEsqecqRvLWaskEY9ICd2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRJjvTTFfUzIwvMV1y7+HkVpdL0n3pNAvdPQWs/ao81IG1lgmed1RNCLU+BEwfrglU2S0DnlP5IlK44hP9f+EkvziKjSe7216pV93BfitAQG5rxrk+RjqTVg9NASt8wI0xPkaRlx/XA6zdukcDbs1HWUwSJDqBUrEbRVzUdTgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InR8j2j8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso58968085e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776169665; x=1776774465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySPe/fU+wa35Y49Pkv+5PnQwWcaNhvp3RPQceVFpXP0=;
        b=InR8j2j8IngXDUt60394D3Nvvza7VleL+BYU3QbqTyM+5G7CI4D5jQp0op/icmdBI1
         trJErl/sVr8QgcHnns3VVuhT3+NBAuXJMg9ShYoO0wYYOVuXu35uoX4ts2U4X+otpW8G
         +pHslr74fXwRA0W0I9SL63Pcv2iTPByP3KJGCRyFa5XhmnGGLVlhUViw3vDC2W28OWq+
         IcnkoZU4tAIElkqJ0NypAYK1yELSBuqvbE0nLOTnq2xPiWuMUR7mYs7ZRhtjENhKi8KZ
         XXMTUhQsaV1weFmKeuSCtrJbSWUjD/zeEA43bdwukBrD+vswvAA7EO+RyG8Plod64Su7
         zl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776169665; x=1776774465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySPe/fU+wa35Y49Pkv+5PnQwWcaNhvp3RPQceVFpXP0=;
        b=FKSqf65BMcxpxzp7ZHixc27TgUvgVQ0xMCMb+VrwMA5Uo9NHBZB5TWZtH8x5PmpUBQ
         whzbZBJpXKLcz1dNdkDGaVM7R+Kn6YUiWk76f2vshHxLNx4lAuWtfVup3pTrQ0M0g3WA
         vTIqAO/7ab0StBvc2or+tcPmR0pGn5jv/rsao9RZojrKfmZiJAxBmJrZMODRuuMsHgvj
         GcTVyvLRcMWsJXh+kES/mvSzeFfJ5WKoBkPGex+dBd8ImKi/f6lJayrik0+E41crhFm2
         gOyJRCrlyZSq8Hs0B9LyMWlmr0V0r/e7aEhP3xolbbIlRIBCTBtWHrTyQ9ZoxOStEEfu
         rlsA==
X-Gm-Message-State: AOJu0YxgRg/ZfrGZjdJ2ZA1a0L/VS1ogId2+GM6Czqqy5hsz7avYWnt2
	AHmZaNkD2ZLbCwRijfPN0DyZenswBgqgVdvrDaa1m9vpkmTX8tcowAB7
X-Gm-Gg: AeBDievPsc7KpW9Fo/ib6sArErd9oebE28vnwXe2fLoymAF77mTNMEkx1/gNOlhCoah
	X6eeLOtCNemBxW1z14jfpjqELSf8JIqEWNVsJZ6ATKJmkc+p48XX+2YaAhBwY7yskssC1PzdHbg
	AJRDDn3d9ZxWbnwzslCXg+eZemjdv3XSy+9opNNQLH6dpMGK8GoKNWktyA152ACMDp1EYGi5XZ0
	OQNE77vTEtObbD5DNqEScN1hUchiBWd/Cfgr652J95Tv4zxDH28e62QCVE/zqNRH9hPYixL+JSn
	WlpjrB5wZFkqNlbuJfhaSmITMCuUTlN/6juET8jYGq3zoe2ZzBuDNCRUAJOwYtiV56qHjGRe0zb
	ucGajJd8XUkyZwvWBHmOyuA4mLnMLHTY4/K5n0uxVQKBvL1zxU66fojMffIlrN1eICaWocWxz1r
	r5donUVrqsCiEilaTnitlNfq7n7chaXeMnc53njydAKCM3rXtCYVhylbKVUA==
X-Received: by 2002:a05:600c:4e16:b0:488:966f:70a7 with SMTP id 5b1f17b1804b1-488d67bbc7emr259055565e9.2.1776169664623;
        Tue, 14 Apr 2026 05:27:44 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b128dsm199414755e9.2.2026.04.14.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:27:44 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: fix grammar in MLO group key error message
Date: Tue, 14 Apr 2026 14:27:28 +0200
Message-ID: <20260414122728.92234-1-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-34742-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 526DA3F9FAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The error message emitted by nl80211_validate_key_link_id() when a group
key install on an MLO wdev is missing the link ID reads "link ID must
for MLO group key", which is missing the words "be set". This makes the
error harder to grep and parse in userspace logs, and is reported
verbatim by wpa_supplicant via its nl80211 extack relay, e.g.:

  wpa_supplicant: nl80211: kernel reports: link ID must for MLO group key

The sibling error strings in the same helper already use grammatical
phrasing ("link ID not allowed for pairwise key", "invalid link ID for
MLO group key", "link ID not allowed for non-MLO group key"). Fix this
one to match.

No functional change.

Fixes: e7a7b84e3317 ("wifi: cfg80211: Add link_id parameter to various key operations for MLO")
Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8..b0bb94f29 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5100,7 +5100,7 @@ static int nl80211_validate_key_link_id(struct genl_info *info,
 	if (wdev->valid_links) {
 		if (link_id == -1) {
 			GENL_SET_ERR_MSG(info,
-					 "link ID must for MLO group key");
+					 "link ID must be set for MLO group key");
 			return -EINVAL;
 		}
 		if (!(wdev->valid_links & BIT(link_id))) {
-- 
2.53.0


