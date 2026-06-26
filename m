Return-Path: <linux-wireless+bounces-38187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uLwVM2eRPmqvIAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 16:49:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E76CE1F6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 16:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ep/hAuDi";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38187-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38187-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4F4C304C6C0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4E3FBB72;
	Fri, 26 Jun 2026 14:45:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A213FF1A4
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 14:45:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485157; cv=none; b=Us2/4C8lZgG5xWB8UdklSPSp3DwJ6kDWriwwc/vwI2jceGqQ9ZEw8HIeLEfgwmHNeosjqfjRU72DddmADdcrDo8rTl5bX06/DgzzcPoR+I/GPGcAkwqyRmGka5aWpe6pY8nExeKp8dOOJY4qVvPT0cssqAcBTmvHVZJOJXYJzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485157; c=relaxed/simple;
	bh=AX9U9xN8wChIazxZOxRR5JpD5zZhzI3DYw3FyKRANos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=glTG9y0Uk4ZlQaRrLPJ8bOvAumRSasb6goNkko9N076gtoC5VPOl/l4TScx4XBPlFKei4ChTLTBNrdArFjJ/57nyMXBZBOYS4uSEi/eenrVy2p2yoQgGdo5JMqBzcQOaNP8TgOi2CWeU9G/aDaJxRcIBi6MsVHi8qikJ+vpCoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep/hAuDi; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8453f568e84so947491b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782485152; x=1783089952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdZSOi53dmzzj+BLCmkfJMdj4VvvOVoGTQDT9HDmFKM=;
        b=ep/hAuDi+SYRr5EFzdLF9H1La3mdtzdCnLbD4eaYAed2WEKs8uzX/CoSv1Zj6TdwRK
         KCNPo7HThUTBO8/0kjBx3pBMhdE/QwaEGRqWpnyjX3FZSzetliYp2Mae4CrJVbjapkss
         InswdOCGSEYrIRBrxOSnJSnAYpftxAy4+O1JEUN9zZSA1jbQUbleXTpSxv+f3jY6gOeY
         MbNWyEiHIknFmetQSg5j2XBAEC+dVb/ETas/N3meIlNanyUP7hUwxLcUAA0LbrsLvm5O
         fnwOvd4zRdRhVR1+eu550f6GOlrERyeDZegnQC/OuRkQNvClz9XIbCmqIB5jFEJXt749
         Yl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485152; x=1783089952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdZSOi53dmzzj+BLCmkfJMdj4VvvOVoGTQDT9HDmFKM=;
        b=GLAHy1EfFJUA/rrjMUk8ST3sRdkU0/2v8wNJYEbk0ENJ7E65finagw0yxtNp/UJV1T
         T6kNyxzRHVcPgS/IX0jVMGTXcgicAOBk6eLzEG2fPSc5T+pBFR/DOP+uIIDqPK6ZU6ev
         2jHjBTCD+39hRTyTjmcAED5XpxFGDNy6mv8vEAGbbGO/NOJ2xmGjD7Bg44/TTarn7SLr
         BFKBCamzToYmfUubAD9JrTeN6235/Y1Vf0EtWSU7Ew3MFsH3ioLrrmb/tiaoV2KQa2nj
         yWd/TBTTL7ucntf/nzU1vHw1erBifogGJNoDd+KIOIsZU7mSwh7SAOskFmCS/TLSrD8w
         YDRA==
X-Gm-Message-State: AOJu0Yy3K4Xv9bAC1XIngD04VmwFP5M5n9yJchOXhHNzuR4Bz7RM7ErG
	AyXdndyFJTlIyu0oJM4L+QsUEOtRxFPcbLYVqidyh2C0WzwR9yg7xE1U
X-Gm-Gg: AfdE7cm10L3TUBC1tumv+WyhMr8eq+Xs0itMl1AAIBAG3Q8fss1Hotf8Y0pkZsX5ltr
	q0uvGpS08o91RqM0RqIVcOnRzjTNIOZN9OI6AjvA30/l4WWayzUpljs3xsFc3CTfyneB0bFmOxo
	RZ2Tu6U8q3pZxOKJsks4zn0VmP1pgnAI80Riiy5kJv8+rqSJWeSZQciybKeXqgEfRnkIapxNQJh
	4ffM09mEII0ohhs1kx9ErFxedSPAwJ+pcUAfgx2hPZGg/mnB722KEhF2UrWntW3lo96yaPIWtob
	tHdoc6rZ8HBEEndgdbTu84M8q//muO5Yi7scv6XllrJSSu3JMjMqsnvyBX6D8l1ppC1/bp8IsME
	+Pknj7+/Dn0lBvgZdXNuHSENtjMPXhQAjTVgVwXKDGR7hu0iW+ONx0v6eB22WGG71Dhy3Fhb6hq
	WUCMupDXCTmMV8NUhFgeLVYgSP1NZ+r/myLMNwNSU+i+a7FgMVU3N2g/6480NcKzupHs8m6cV0d
	UabbnFWv6I=
X-Received: by 2002:a05:6a00:a14:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-845b3998244mr8220663b3a.9.1782485151758;
        Fri, 26 Jun 2026 07:45:51 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c39fsm7608673b3a.55.2026.06.26.07.45.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 07:45:51 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
Subject: [PATCH] wifi: cfg80211: bound element ID read when checking non-inheritance
Date: Fri, 26 Jun 2026 23:45:43 +0900
Message-ID: <20260626144543.5034-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,vger.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-38187-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skyexpoc@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A3E76CE1F6

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

Fixes: dfd9aa3e7a45 ("wifi: cfg80211: rewrite merging of inherited elements")
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


