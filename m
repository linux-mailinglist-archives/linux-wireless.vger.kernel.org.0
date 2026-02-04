Return-Path: <linux-wireless+bounces-31517-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELOHMuEAg2keggMAu9opvQ
	(envelope-from <linux-wireless+bounces-31517-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 09:18:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD5E3074
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 09:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C3CF3012CC2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B638E5DC;
	Wed,  4 Feb 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNyDDUAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D136C59F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193119; cv=none; b=N7CGP3/0NC0Yrha+Fv+lZFDS8SOKc4AFm9SmdDrfPLbgJyXV9EZQLlWah1AI4IMZiWQqnTNGiIGVFDWS5kQGlRnlozzpDiHWFs2VDPEILSZKJrOW5MGD6hRAwkCXMmJeYpuW90sihBSsCqPWOEZXygLoASZfGFmfyZufS5g1G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193119; c=relaxed/simple;
	bh=CmAuiWTnfTw6CxWyxFdT73KrhSFv3MZzhpRILF+Dm/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwMAcFck3bO821inIsk+ounwBFLAwp8qHWKnO2nZrsMrYkKETcbVQFcm5vb2EdSADmhdYbAFBoqE6+HSHJqmk8PnMTcQI1+DYY+C8kSi35lfDbvvXmZwXqFsJbyRar0NUSyYOFjQA5FX4mEyAYyBXkBIe83e6iQsgCtYp6l5n6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNyDDUAW; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b70abe3417so1003679eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 00:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770193118; x=1770797918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+12J6wAvYsHe6gylK40n9R4Ga2aOlKmtmFkjYWPvM3o=;
        b=UNyDDUAWliwsgokJS83xaqiFlsAXJIAF18DZ0CT26Owrsfg71KahacklQ8EWnEPU7B
         fNaolUB+FYJmPhpImJD2uIFKtc8TY9aRYpO+xIayNSqwmnVW+vg5CuDkCAr9EXjFqLw9
         VA6GDQyIuQx39yvVs6NnEAet4OIqODZRnz4KxAFmCrQHLQ3ZOYMQMKYGXhft1z2lrRAx
         okLk8KH4NGbGT3wGFFA/0EVw87luCrwsKXFQ2VmNeWo6PU7eCJ24uXYferRWHmrYxhhR
         G2vT82r9FhAvQjuhE3ViTedDfD06vhts240H0ek/5UWNoTK+TL5X9REzm5rjCyww9T9I
         dLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770193118; x=1770797918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+12J6wAvYsHe6gylK40n9R4Ga2aOlKmtmFkjYWPvM3o=;
        b=OMKHDrHdKYxVNyefHSO/GvQ48Mkd+xHxuSXCUDrOl3bV5KfuCjSN00JZg8mIC2Iu2h
         9jzmMKjNzRSAsr5Z8+m6Zz/P4puRDw2z83oodd6ex69gY42ajx0Pluvo5pzjj7x3QcM0
         B9FB6jUwlkUlGktdJRm31tFakw3wuR7UYg05+74/0yd5+DHnXF+th1ZQRuTISID+V/Xy
         g8x139WCqc2eKTCQFSrGDvrs19LiaGH+w/nK5MhxxbJhycE1lX0nwmfX9jyHBxMnAVWa
         CTYAJTGEneXf1jcpNYcMPZ5RcDo5Obp9L2f4cn0mYf08M/en+wFX3rMxVBSyeg29z34d
         jzDw==
X-Gm-Message-State: AOJu0YzyMrQJsYLuN+U3kYu2nLI4YkPS/hWm8AV8Yu/mBKOt8l6x3tkP
	f9LMEBj4VAmtfY4TfoG4HeR0oMhyHgf5BGeISooHhAdBH0sKlW3MaYog
X-Gm-Gg: AZuq6aJ2yjsoPZ5YWKzzZ1AhCtWCwLJU/PJTLQGSNDmRSX/gsWJkuPWcK+Yu/Url2Zb
	S83pImFBpF7cbYCkM0YHus+Vjx0KtKdfc3YagKN3JmL2vtvD5jn5IHnm5bCtfScieYuRS9gWCWj
	n3vHnGZpWm77D1Zf/X/IXV39ZTOFfb0QmwGuP6huq5aHBnwwzTbCElmdHjqBkmqKCQ1Jumq63VI
	UX8ZXXc/Tzpg0USrCla95LwfKJ4ROgPWugSMvxX5xnkPGbW35eKuBTO+OiohMskQniTgcuElGE3
	Zr5LsHhcCQUTB5aff58qJAHuU6xmDzGeclhfeEST2OCKUu0M8TtypELuuYZU3DbB3lfMZgl+yr4
	2IDIvj8YyPApPG1VkJOC5/nPVRwEi/wIo9QX2lPkpySHyQ2UQNAnqW83d9dqZhggQb5Ej91NF0u
	kf2wgQ9esUUPaeEYb9wEN9PWwuhHOiJETm7/bCeQ9665sIKDHLDWK6vFbNxW9yJW2WKwCd185oL
	/0CW2KdaxK+YNTWrCGt
X-Received: by 2002:a05:7300:2303:b0:2a4:61d1:f451 with SMTP id 5a478bee46e88-2b8328bb865mr946839eec.16.1770193117807;
        Wed, 04 Feb 2026 00:18:37 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832f8e78esm1093729eec.16.2026.02.04.00.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:18:36 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] wifi: nl80211: drop impossible negative band check
Date: Wed,  4 Feb 2026 16:18:21 +0800
Message-ID: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31517-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47BD5E3074
X-Rspamd-Action: no action

band is derived from nla_type() of a nested netlink attribute, which is
a masked u16 value and therefore cannot be negative. Drop the dead
"band < 0" checks and keep the upper bound validation.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/wireless/nl80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 03efd45c007f..a92b4e24b28b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5759,7 +5759,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 		enum nl80211_band band = nla_type(tx_rates);
 		int err;
 
-		if (band < 0 || band >= NUM_NL80211_BANDS)
+		if (band >= NUM_NL80211_BANDS)
 			return -EINVAL;
 		sband = rdev->wiphy.bands[band];
 		if (sband == NULL)
@@ -10536,7 +10536,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				    tmp) {
 			enum nl80211_band band = nla_type(attr);
 
-			if (band < 0 || band >= NUM_NL80211_BANDS) {
+			if (band >= NUM_NL80211_BANDS) {
 				err = -EINVAL;
 				goto out_free;
 			}
-- 
2.43.0


