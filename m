Return-Path: <linux-wireless+bounces-37396-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AE/nF4vhIWqsQAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37396-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 22:35:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6916643651
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 22:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=aerlync.com header.s=google header.b=XmRgPHtG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37396-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37396-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=aerlync.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 431DF300FEC6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F243DC84E;
	Thu,  4 Jun 2026 20:31:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8D35B650
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 20:31:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605070; cv=none; b=ChVstzm7J0ifPx7xZE5FcCJLJXOpniqvoeyYE/aOOZ6Dhr6y6jb+I/5ckgfp+FE02/kItMjm2V3jEAEbdMboTKTEqggeg0JYUajkq8aS9xf/OcUqyw400gQ8Aqx1zKtLMU7D94VFnsy3KrHuM2aw5cwtyHgDc0xvGWyFvLNezIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605070; c=relaxed/simple;
	bh=CkN0u8cRdMLyzV7Zn5tLTL8tarY4nPspYNhA7JSi6mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRtQB9uKam43AygW0nBjkQd8XJI+687dy1xuhcYjQeQXWL2L5I9GE1lGQrZS0JKh/d4FWn0EDmduvbqHvX8FfjLm+yt7Huoyiy14X+zMKRvM6m7Ek+3vJ7KnmzB1vSqyvF93jq0eZQdIpH5pIaKqTtjCSTB844aK692oyKa6xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=XmRgPHtG reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422871b42dso670763b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1780605068; x=1781209868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVATRmmMpQEg9DhMRX7oIN7FABlX6nSvf45MKBJznWg=;
        b=XmRgPHtGdyyH6dBWhI9ilr5YFp5+/wCZ8czZ5JKuxjGjowlaVKPMQ31FKXxqySdwIY
         hbcekCwDd+PA/hUJkma6yuOh+CEbZ5wM7ILAZf+Tkc2g4fNZZPEzp7M9zareqXA+f+v0
         dhZzBjnWuUFucb9NtST/2yuv8NW3JmPX4rpYx4F0G9AJrk1CLfozpSRv8CelvrECxAq/
         1z+wG8/zh4Dl9pCU2VpucN1KwyffXMDDYu9V4OxsBXZSMTsFRZOjx878O+vcF9bBS7Gy
         L9i/GqSmXzZzF4k2wkj1jdyC7q5dmvIVN3B7JTMeU+XpaApi0VyQEY1GdL/Y+CQa+ZNz
         n2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780605068; x=1781209868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVATRmmMpQEg9DhMRX7oIN7FABlX6nSvf45MKBJznWg=;
        b=IwSd1gJbzN18xvlYjRjPjBd4YtprZa4QJNBjw9q1WsfF22wcdmxUaX4ezEOYNcsfZe
         JbrcZjMy8Z/GRdCe/DVaSQWQHEWTza3V3NlkW+cuTvBD6bIyPKd2LD5SBJ+iVZXtiGzp
         eWszhiM+MjYYXfnschpjFaxy0fvnuJwie78+rjaT7MLw7zWbNnVk2xsRSH4uuO3djz//
         FcBLN+JGSqGelAn8HkIWTx3nM4KhnqqiqRqO4VAgTGMoBXkhUzqhwjCCg+QWKK7arnS5
         0oDtwRZ+cZUXT1+obxile2VvZ+2hcI39lSF+bujQZVoeLFwt3Q773ad+TbSyYSBbW3c6
         IFMw==
X-Forwarded-Encrypted: i=1; AFNElJ8t5+hQKD+37eJ6KMFiqA7vpPkHfrgGr/pSvI7689NIQV7C7m1zExG3FTHyKUKRH/AWqLB6EUrPkoBLLuqEww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOuECVZSWGx/o6hOgxORTWv4efV1xlznnsZ3s8SW8IH/gL1rSW
	JC1WVlFEx+U7dnDGfm/A7aCcamjhD9SPn5TaLWX+E5zNLh1sNQC+lIaDZx9K6nxsPbUSeRL+CIr
	UmPJj
X-Gm-Gg: Acq92OFoZYaiBUfNazFRevjdFK+6jREjC1rVDf8OH8W/TW7aOyj+H/8SOAnuJxfRXFU
	dpuV7r7gOZChXPS+K9Mrw2shiiJHlTyfvUBs/4ImzED/C3qHHAhJbwfce5DgKDnAdGt2MNRXRbo
	EEA1zxt6o4vhJmzUe8gX23yOUNEa+eh46IqDKLwzyC6RnO9wzuo3sD48bAH8pyTdEe3In0dvt0k
	GKUYtmZ8JUNpAGlboDnYv7EomThC3W6xCqOtekYQPXJJQPaibtZ6ZzKjHPBXKrg7af1W1O2HaHl
	gvVxYvqtlUyfn627rlpEjetpJojD12ZSrOliqb4CaOSsZo8z8bm4LI/jw7ch/y5wul/TQcFtFku
	S4N8z4ErBB6XCl97lpBtLYtEfRtM4ah3oo53apx8/Bj/n6uM/IZlPGlrsdD3DaXoW974SzHbMVM
	5c1KC+j/fWdDik6yV9+/eu2KQxK5PyeaCpBcpkMj76zoKALtP/MiNgNmKRG+KD0w==
X-Received: by 2002:a05:6a00:228d:b0:836:3f6a:3e77 with SMTP id d2e1a72fcca58-842b0d6437emr302633b3a.17.1780605068414;
        Thu, 04 Jun 2026 13:31:08 -0700 (PDT)
Received: from thiyagarajan-Latitude-7490.. ([2406:7400:bb:a01a:ad10:ad2e:3c48:7280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221470sm7630086b3a.6.2026.06.04.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:31:07 -0700 (PDT)
From: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
Subject: [PATCH] wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications
Date: Fri,  5 Jun 2026 02:00:27 +0530
Message-ID: <20260604203027.406815-1-thiyagarajan@aerlync.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37396-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:thiyagarajan@aerlync.com,s:lists@lfdr.de];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[thiyagarajan@aerlync.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thiyagarajan@aerlync.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aerlync.com:mid,aerlync.com:from_mime,aerlync.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6916643651

Currently, ie_len in cfg80211_notify_new_peer_candidate is defined as
1-byte field, capping the maximum IE list size at 255 bytes. When a
large beacon is received, the IE list is truncated, passing incomplete
data to wpa_supplicant. This causes supplicant to fail parsing the IEs.

Increasing the size of ie_len to allow the full length of the IE list to
be forwarded properly.

Signed-off-by: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7db9cd433801..0d97a47c35fb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20958,7 +20958,7 @@ void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
-					const u8 *ie, u8 ie_len,
+					const u8 *ie, size_t ie_len,
 					int sig_dbm, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-- 
2.43.0


