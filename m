Return-Path: <linux-wireless+bounces-38745-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A8+IOh/MTGqdpwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38745-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:51:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7CE719F91
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:51:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SJ1PegD0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38745-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38745-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0C35303C678
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F23D5C07;
	Tue,  7 Jul 2026 09:48:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE670808
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417717; cv=none; b=ISByz+gdJyZ7RllDocxnAzsqC3AgOLfsfPqj3kzPPGno9J8PJ2dCpEE9q/FT4v1+4QUJs+iYFPvT8eb85BXAHcpGk8jG3AkPOhWx8srbQ+lQB22w2YRDq8IOF3YzhrlJveFB1uyP+DIMDWkam5rIXiHy+mpHy1qPl0hDfdKK4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417717; c=relaxed/simple;
	bh=vRz18SgEEOj8TQdJtXT9tGpbtIx0CYUiRJEM90Fpm0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AisGsnBscXQ1kv7u8mqDAMgyp+EQNaF0OAUNhHS9QVZc8B3MLhmt61DwTMNT4HAA/xBnXSV8jdsEHOQ5pczb1mwQUZz40w8kH1pSWe0OBsW/mWgKDMYd4btmnyQ6buqRypfWmP7iWBOLUbUU7r1bcuZRooPCTgX7RaQ2CaXIVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ1PegD0; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84780c95e2eso3150366b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417715; x=1784022515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHuPDXrv2XXNS07fUsoB0zQeifyt2lknu8CByaXQxnA=;
        b=SJ1PegD0G4A6f273ID1RyXmgiv0ZxSdokmX6AyzqeyTkwmSly0dvvSDENm1W1CWCXJ
         ZBdlr2Yq7vPDCSM31yYuMnu2gGV5ftdEgurbO2xPohEMd/KE4IzRqXwZE5P9iku5GsnA
         PbueMNPuujCus3BEYEV2OQig7a4BoN22ZUS5TLjHus9U5SYrad2N1eb16ph1AzXkNJLV
         k96d2bBhZuPKQzkYsJ3A7Z/W4Apv8DVWvC5hzCYeDZS4HSUQOqmGONhB0lDquxJAxjyD
         M9mYvLFr/ezdeIHgy01uDTpr4HGySVVmwlB4v/zGI+Gv3/7afj3h7kGrNBF2rKA6wz25
         3a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417715; x=1784022515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHuPDXrv2XXNS07fUsoB0zQeifyt2lknu8CByaXQxnA=;
        b=PSzj1gCXKcblx8obiDkjJ4+q604FVeaHWqcbf/2AHY4i+T2oupX9fQw+29y3XycVXR
         5+CbEKAtiBspT5zFj9I9ItpEc6WTLCFn1d6QVvibXojP4ltSEyDdqoHjr9GeS+U1o6m5
         cE/YdySiBtp+yDoF2Bpbt94Lyb6Li1H8VXvSK7P7hxKgRSiP5SA7KXzzkYheq78OhYdx
         nQomb+hxTgr7M1QknEvG5JZmR1agbgYLf/lrObgQLPZRKbf/iARYghwPHaXL1LJx/rmS
         PUnOkiZkCZfXE1Ls0op62wcbmOslcT983nJkr0QSJhHsc1Dsx3CsLQ1e7rTG6DggrorX
         MIsQ==
X-Gm-Message-State: AOJu0YwGOK/JX0icui9AyMyU+jpLg2Njq1Cdr68mn1cWB+zb8Cgc9u+k
	muhgvROD5xr/bHO6hiqDM1HF4WJR5nIaQk+H4rYwicfYOqaW/PfT/Sn2
X-Gm-Gg: AfdE7ck7faDxJL9Y2xZ9H/SpSBHPfW9hCauWti7/OfbDgiZ7FlD04XDXedp4SsM/gyJ
	NMTs4bU+KOMiixJMl7T2NI3cLCjubRJ1p3IqCwPWuWZmspRItlpWKT439kcIUcS7Tt0zhtuAS4I
	9x59eZk/pN9+fnZgQUVk6cqAhk+cFNw/tKzan7WX/A1b9NelculVC2gfHpRm/K++qCDVQuEONVP
	h5oYOUjhsXtzWMSauZ1b4AWyE8KvwODEn5Xx4nJESofyJ2eL/dXHE2C8CbFX+NgMnO0gIbhaFrv
	HSXQppq+OrEpJIUtIf3+SiPirzQTRCp6Pi0Uy7dS8aKBAuy3YNnca2c03JmITSM/GPI+T5lrAI2
	nE3N6J50PNPlKm7xlekJvxKBCj1vGJbmHmu2Dxa80lx/fcesmFdZWZ5m4j/6gPMjFAPemykwc0e
	fHhc4VaQK+LU7VrOLH/VAxBgZc/jMIo67ZLz7dLHQ0Q+JxPZPvGKM=
X-Received: by 2002:a05:6a21:1f8d:b0:3c0:9c1a:894e with SMTP id adf61e73a8af0-3c09c1a9cb5mr2699654637.70.1783417715345;
        Tue, 07 Jul 2026 02:48:35 -0700 (PDT)
Received: from localhost.localdomain ([192.197.201.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm6649122c88.12.2026.07.07.02.48.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 02:48:35 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
Subject: [PATCH v2] wifi: cfg80211: bound element ID read when checking non-inheritance
Date: Tue,  7 Jul 2026 18:48:28 +0900
Message-ID: <20260707094828.16465-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626144543.5034-1-skyexpoc@gmail.com>
References: <20260626144543.5034-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38745-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skyexpoc@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7CE719F91

cfg80211_is_element_inherited() reads the first data octet of the
candidate element (id = elem->data[0]) to look it up in an extension
non-inheritance list. It does so after testing elem->id, but without
verifying that the element actually has a data octet. A zero-length
extension element (WLAN_EID_EXTENSION with length 0) therefore makes it
read one octet past the end of the element.

_ieee802_11_parse_elems_full() runs this check for every element of a
frame once a non-inheritance context exists -- e.g. while parsing a
per-STA profile of a Multi-Link element in a (re)association response,
or a non-transmitted BSS profile -- so a crafted frame from an AP can
trigger a one-octet slab-out-of-bounds read during element parsing:

  BUG: KASAN: slab-out-of-bounds in cfg80211_is_element_inherited
  Read of size 1 ... in net/wireless/scan.c

Return early (treat the element as inherited) when an extension element
carries no data, mirroring the existing handling of empty ID lists.

The bug was found by fuzzing ieee802_11_parse_elems_full() under KASAN.

Changes in v2:
- Fixed the Fixes tag to point to the correct commit f7dacfb11475b
  ("cfg80211: support non-inheritance element")
- The bug was introduced in the original implementation in 2019, not in
  commit dfd9aa3e7a45

Fixes: f7dacfb11475b ("cfg80211: support non-inheritance element")
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 05b7dc6b7..0a44856b1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -205,7 +205,7 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 		return true;
 
 	if (elem->id == WLAN_EID_EXTENSION) {
-		if (!ext_id_len)
+		if (!ext_id_len || !elem->datalen)
 			return true;
 		loop_len = ext_id_len;
 		list = &non_inherit_elem->data[3 + id_len];
-- 
2.43.0

