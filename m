Return-Path: <linux-wireless+bounces-36098-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBjWADkb/WkjXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36098-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 01:07:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB24F00DA
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 01:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE6F3302A1BB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 23:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E294371895;
	Thu,  7 May 2026 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc06uxXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604B327BFC
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778195252; cv=none; b=CuoeXdXn6G0A9JVngsh9I8JihMYtgnBM5gjH9Gqznkaf1AUmj6H5765WCV5tReLg2FzQfrBBXLRqFgCq4VCxmMfIGqg0hDmXmzfymFZDOxiyy5GhsCQnGJkwq37gNmQ050rB8tuLfVZVChtfUKphA/6nLg7HpBHa4HSt8Sgbxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778195252; c=relaxed/simple;
	bh=AEh1vtssFVIE89CNDRfhYm/mSMIJG4MytUBKgB9HuTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bayBwS8ukfLjrLCy2tIava7leYwFjiOnvsXVUJilTNPA5Q0iaT+5wA/R/ww4JTQYjxIArzs+jsl6XYNe0w0G+VYL6uriRGgCDGPxjgp6vwm82Aq7KjztaIVCQpRVEKNZjk7IKQL/HbXzls+8gHSkcJlfkElzBTUxCkwtubSFxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc06uxXa; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-466ec4c6846so517263b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778195249; x=1778800049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvRiVt1el++gcKfvSCCnTTgWm2Nr3p2gnsAl37CcJe8=;
        b=Wc06uxXaiVxHHD7u7/F668m5ykJZ7Bb36BVQSzJbtPyd5rEC3VsStIYsdDzCfTG0xU
         OpVM+RMp/Tob2YMRq9phD6bWoDo0hdbeYIw0yWRrymb4aRn0BDXGRaMxefjkdxu3If1x
         S+OUfMcmsgnMEfFXk467kv5lSp6rksQiz9p12kQL2/0fKKO/Vk8v6XJ8Y2Ohk7qSlAMq
         LUCsv+M7+DMGLXyu467XqN9id1RzxepFsnSU4F+7RwDSvOf2V8X6ImBKWN3NVAhobtw8
         p/AVc7jxIYMH+uQ3RkIduBbL9rJyB8xw3KoBcizwi6oj8PJp7feOhbXQjslJqRo5XLl2
         u3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778195249; x=1778800049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvRiVt1el++gcKfvSCCnTTgWm2Nr3p2gnsAl37CcJe8=;
        b=CLnZcrkFT+lcwVez2UagG8maIPwKhnJ9QGROiuEtH6aefGJUsPNvfvehYkyqH5pHTo
         oB26JKkRFA4KHC6anvAKZ2BFtTmB0Znb6imixI3BGPnGaSs7bCu2+8BzwkgEVWdOz5XU
         xuiE8hU03JWoXFwhyWf8B/V92Vf+0UuZxhHHGy247qQtKqRsAEn33o00XHABWNgKVtQ7
         lWvvW/dTltzy7yONfmKquVdnaxNw4wo9zJ6ZQOuK+kJ8U2FpqlrbIfKWL8fSVyyoY32o
         tZCryXrkjJqoGf9zu/7P1ZhGSa6yQE/ZKHy3V7vBkuhUlYcKkCLDSx8Do2/Zo0L1fnCG
         iB5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+NApZrrLV95rwEHNPGzqZxhac/Vby6k0txGfViuYv7xGBwQcUiidivS37Q1Gs6AA6hh+fsISA7Zz2AP2zYtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsP4VMbZ9fFm+2Kp9ffqGMaGmXM3U88Pceo7iyTe9p5vpemA9
	HNhj8XwvAtrC2fgp1hEmV7pIqQO4sHvOgN7i9B9E9b47CKjAKxM2oOb6ANwBComW
X-Gm-Gg: AeBDiev4B9awXhiW4E1OfEa70t6s47GQKFqian46maEhtU1h2puAvrMdgLDm2EuqopC
	K2iwAHNNrMuPEeiloab9r5NoDEZjG9YkiFNvppm8w+bFFDy8uuE8p4F/AFlwiar3vr55YowPThR
	VcB7HANfU+6boYSnlK1O2ChXUrwY542qP7hovvrmSnU83F5D6FMheB6tYSLei3ZC55K6rjDV7ng
	9Q5jE3KUbC+2XWWOhLbLVK2LQ783Z6cLzh0Fwsou/ytDErTI9DHZ3LweyVBnR7B1zMXeRvhPniM
	9FDvKz+NrElXNhjCXC7w+V2Iaec7Qxw74a0FpSU4ovL4PIvsyecZ7HYSZojBzMjVIWlljZYHxUA
	ly/1DXfYHzF3CLPOka+5d89ziIB+ZFxU2frTo9OTYlLqG64aV3o5e/t/Ojon808c1PvA1higr28
	HAE9xWntGPnCgqXjmJRhZiSckpEDZ7pwKPPpbf70Mxcs8RPh+ccE5rOXmFlxfM2AxTeTevEP8zl
	0oagTNADvmeYB91cFJcfBlpG1ZIEetj6InnMRR0C0nM8cjLHSoD9M2dpYgcXEYRT002CkmwQdeO
	bwmrHRoAzX6WfaPXWqyYcg==
X-Received: by 2002:a05:6808:4fca:b0:467:1941:1f0d with SMTP id 5614622812f47-4804221cf91mr5859497b6e.11.1778195249436;
        Thu, 07 May 2026 16:07:29 -0700 (PDT)
Received: from johns-MacBook-Pro-14-inch-M5.tail522c20.ts.net ([2601:282:187:ee90:49ff:4269:cba0:b5f6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b32dbsm13641585b6e.3.2026.05.07.16.07.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 16:07:29 -0700 (PDT)
From: John Walker <johnwalker0@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: security@kernel.org,
	John Walker <johnwalker0@gmail.com>,
	w@1wt.eu,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: advance loop vars in cfg80211_merge_profile()
Date: Thu,  7 May 2026 17:07:20 -0600
Message-ID: <20260507230720.64783-1-johnwalker0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <78faec4efa3019c6101ee0a6c329189f1ddf845b.camel@sipsolutions.net>
References: <78faec4efa3019c6101ee0a6c329189f1ddf845b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66DB24F00DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36098-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,1wt.eu,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnwalker0@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

cfg80211_merge_profile() reassembles a Multi-BSSID non-transmitted BSS
profile that has been split across multiple consecutive MBSSID elements.
Its while-loop calls

	cfg80211_get_profile_continuation(ie, ielen, mbssid_elem, sub_elem)

but never advances mbssid_elem or sub_elem inside the body.  Each
iteration therefore searches for a continuation that follows the same
fixed pair; the helper returns the same next_mbssid; and the same
next_sub bytes are memcpy()'d into merged_ie at a growing offset until
the buffer fills.

Advance both mbssid_elem and sub_elem to the just-consumed continuation
so the next call to cfg80211_get_profile_continuation() searches for a
further continuation beyond it (or returns NULL when none exists).

A specially-crafted malicious beacon can take advantage of this bug
to cause the kernel to spend an excessive amount of time in 
cfg80211_merge_profile (up to as much as 2ms per beacon recieved),
which could theoretically be abused in some way.

Fixes: fe806e4992c9 ("cfg80211: support profile split between elements")
Cc: w@1wt.eu
Cc: linux-wireless@vger.kernel.org
Signed-off-by: John Walker <johnwalker0@gmail.com>
---
 net/wireless/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 328af43ef832..358cbc9e43d8 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2462,6 +2462,9 @@ size_t cfg80211_merge_profile(const u8 *ie, size_t ielen,
 		memcpy(merged_ie + copied_len, next_sub->data,
 		       next_sub->datalen);
 		copied_len += next_sub->datalen;
+
+		mbssid_elem = next_mbssid;
+		sub_elem = next_sub;
 	}
 
 	return copied_len;

base-commit: fcee7d82f27d6a8b1ddc5bbefda59b4e441e9bc0
-- 
2.50.1 (Apple Git-155)


