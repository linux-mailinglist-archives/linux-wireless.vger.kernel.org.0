Return-Path: <linux-wireless+bounces-37754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vVdcI0VVLGo9PgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:51:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33467BDBC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iarCaaC4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37754-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37754-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C463311685
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7012396B84;
	Fri, 12 Jun 2026 18:50:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63C3A0E99
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 18:50:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290256; cv=none; b=qvhcY9edo8QVLWSu0kwwwPDGwCrwBvRkeAaTpBQK50x1qUfz453AL8wTIh+45gkBWAo7S0jiSvo7UbtGBVyMn7w8L3i8yRysYSexBu8kSRTL2DqVG3mn82VJfeOetCXoUnSRshuZKB+SMlwBaVHPfbP8SL/KcXaXloepAsQ+Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290256; c=relaxed/simple;
	bh=hlcOSpzCIeLy9An8PLGHbmJPvzwoOQPxOMGo6PLPsS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPql31dYv7cSMPBmOMlWAziZpnexKMdr6LAecJ/yn1iGus6UnnBNULF7yykU6QJ9pvoUt3eJc5lEpkFZy1uUObEKF10BJJUKjl+3Fk3CgqPFHjqpr8Wny4exmiM+86XSx4PM+xMMESOq3xwKKVmMom2lnEYPPElW2DRxrS+2bSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iarCaaC4; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf20f6be6bso10428685ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781290254; x=1781895054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhYmWtYKzLZAshiSMxu3UaHeW+9G/xRMBLm0pBnYPNk=;
        b=iarCaaC4vnCYvLrFhvGftRiRKARzuhPRpndN0cgHG8D5gs9Gp3yqvHRncIoSnEQKXk
         FgIckTSXSKVn2n9foQsIrUGGL9LJY514ELyl0G3A5w8mxqVt4x2TqrYfwTrpanjXBUOX
         nsqrfYO6m005h9GxwtkM6O64wfvan1JjmxlH9iAf5urcRtqNrMPtdF9Ntkvh9egY+w0Z
         4LlE0tdVYhbKio8yYTTCzQ+QArjCcQbVlajIn26RSVaTi9x8Ttx04VRHoHxhrkPPzcMy
         yOhxzIHzVmkL3uY2wlcdhJ8BoShj6DbFj2YvnAxGfb9jZHByr8J34VaiVFQzOCTF+9/l
         cWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290254; x=1781895054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhYmWtYKzLZAshiSMxu3UaHeW+9G/xRMBLm0pBnYPNk=;
        b=JBncCxA0kk83Q9RHQyAj3UXOJiCVuvZ8tGx6dvxihk0aZlC8/XkzFlIfyxL2csw41P
         gJs6mzGQ5SOCTXB0ACNOp62cnzTAW0AHndYjOkAvXU4l4018d8gWmZO31pvvoV1Xq/Cp
         nzxzsWkJqRJd0PIkZ/w0/hDMNcUs3KggSiLyalRqCQHWz8aj4OAkYRJH1+NX4Zhb1sS3
         Hv0KYrlkYSVegzXe1tmH2Wn+O4S9snpsf/s2wVwx08qh020kZnevSGVznnXHkkI3mDGh
         hnyhWH0dZoyzZGt6iVnqnFFKN1LOzXoTDQi+/ZHSiicB8lYusRda499yrQVhmRnzxCLW
         4NTA==
X-Gm-Message-State: AOJu0YxOcyCNGutrKK14TYel3pnnOrOSY4a/vVypZeouu1d36IMgeeRg
	Pg0zWrwXtFIjow8aC7WPEvDg3OQTnIETgpmjQm0KHB8RbxgR/JDgM3qhXzFG037UUPh6KQ==
X-Gm-Gg: Acq92OGeLNPppj/9ZXVP+HdChH3tF5x7XlL8elyXMA4vv8tubrOFrafJWWu0QcJ1S1b
	YtVKIFW9166hepp3qoox3Fo0qsFzlIl1WWM8WrR3B6uUEhZsm93m7xHzDrikjaB3BS6wHbX3edq
	4RhmJkLaEHdMLrKvfaE+k4jmUodHsgfFDN/zQIV053JJXjvE3Pxsvqe+BqxxJ08BO0orZbRc0NQ
	31ZtgCqcqeT6Zy2c8GldauIMuXyKOi24UjxDxrdKEPsrG3fL6/5GihzXX61/ApNOt/CZt3ZhF7k
	K0RqvB3u5COtm9ZgId0o0OX9lIx8KVp21TGno6zz+TfA8oiXe3Y1hvwH+lNHuNEz6xljjVurRl0
	ATAVtFcLk49rkQ3rLyO5ENzvyOX10IIlNT2lbWrtvG41FENKA50SxWoouMoo3npib71YYpjp4LO
	ZpeUzA0qnT4EG09fH9hJFmJrSVryBuZdFtyjuv7Y+rf5fQYpOKj0KjpxjBiPKQJ6O89rdx2UWvQ
	A==
X-Received: by 2002:a17:903:41cd:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c40ff3a3demr46700605ad.6.1781290254330;
        Fri, 12 Jun 2026 11:50:54 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm28464465ad.62.2026.06.12.11.50.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 11:50:54 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] wifi: mac80211: validate deauth frame length before reason access
Date: Sat, 13 Jun 2026 02:50:45 +0800
Message-ID: <20260612185042.66260-6-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612185042.66260-4-enderaoelyther@gmail.com>
References: <20260612185042.66260-4-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37754-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED33467BDBC

ieee80211_rx_mgmt_deauth() reads the deauth reason code before checking
that the fixed field is actually present in the received frame.

Validate the deauth frame length first and only then read the reason
code.

Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b98ddfa3003e1..8be470d730f52 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5179,13 +5179,15 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_mgmt *mgmt, size_t len)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u16 reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
+	u16 reason_code;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (len < 24 + 2)
+	if (len < offsetofend(struct ieee80211_mgmt, u.deauth.reason_code))
 		return;
 
+	reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
+
 	if (!ether_addr_equal(mgmt->bssid, mgmt->sa)) {
 		ieee80211_tdls_handle_disconnect(sdata, mgmt->sa, reason_code);
 		return;
-- 
2.50.1 (Apple Git-155)

