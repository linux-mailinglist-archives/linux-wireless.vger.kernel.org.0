Return-Path: <linux-wireless+bounces-35990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AoxCW3k+mmGTgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:49:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72B4D6C4D
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59496300E292
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D9369206;
	Wed,  6 May 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dES6HfGw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036A368958
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050144; cv=none; b=EOrbAgG3lJjAA3hPtOle+NAhd22xPBHzl13ca70Q0K9+UfP4zKGWGQBmf/aghmHDBza1kUNk90QULOgNGX/LACRbm82oUuIZiJ4lXQMbft9ov3GluIthJsh0eIhk29ZTJfXTJnnQtswdxqR/pKj9pdySOC5C+L+XZv8IvJA7SQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050144; c=relaxed/simple;
	bh=ZdZ25Cwyc8EI9KIsO67eAsM12WkNodGogI80eVVD8ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5OtsBU7QIYYaiw/uq9khx5++J2YIVBzEuPSHKDHDcuhDUxeC7SSzgxRmYyYgURCdtJDQNRInyhu3Z+1m3BcJyjp32rKsX2cHI8FLoI3M0ZBVMuUlU/a3pRNF7dh7fvTrtaJIq+XtVyHFEIbWgW84caIsxrFaaKu68wxeWbUGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dES6HfGw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824c9da9928so2737150b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050142; x=1778654942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db185kstbdGF6yJwsHK4uxlvTdgmksgpvYFORZok+t4=;
        b=dES6HfGwfQ36pyjK51EavTdzdOy4JGt7atKkk8eSmKo8oEABGi2VwDQpNq0EdPNAJz
         97meXtcF9p9zqEceK6wMP56vsBz9MIUbYo/qu/SUVfqbLR8CBOnunbgmPXaltezMd/aS
         EEDJ8TOgdLdyFfWBfAxgqE66EGUXX8LK5LVvrrR6pmIoenE11CtjLoXw9Vq4oLlFU44q
         8OFGUicUMJZqVXRbzSlZSDT4OV991VzGne/QJfINCeHOm81aW98Hp5WepfHfPnGLiZAN
         ENp9P3GKdozh32R9wzF1UgrB5rG262NiUBFDeTPGG8Re1aCaL0Et8SFCfx3PM39CfT4y
         ex0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050142; x=1778654942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Db185kstbdGF6yJwsHK4uxlvTdgmksgpvYFORZok+t4=;
        b=YDJBDufIZ/Vq3BvU97/cnus6GYCT0MuHrvOyVdgyPRDK/G5014+yVc67dQPzDll1u4
         lj/h8dnUUMk8LnvDkz9XAWL6ZDddDHGv7TPlZtxJerRw3YKrBv+7qaXIyig3//S4/y6H
         3NnI0Q71hEthm1S1ikdSKWIjGcm21pTji8Gn4Oj3IkxsJlvvIKD3o4GrHzrtlr3ew4H0
         Mgr315QuuXpsGPW1MyAFrjzz41tznqIrZADReZTJDkp04zU93YcnVCZxB2ndmHdh2wHU
         ZrzFXzzH3I0jClOcChAWIhhnsZLoKJGEFpZ6SpZ0RIjGr81fYfz5Z6VKsoxW9ilVqhtn
         MwOA==
X-Gm-Message-State: AOJu0YwhmdpzSRAItZyuUcF+u3dTFgGZCo1qAhLqOTTBFLJbEbCYfbBx
	WQwEl3qDoZY1jRTzOw+/kz/ToXCMotU6ZwwbGLsWnXw+CEGjXq2ztWMC
X-Gm-Gg: AeBDieuMdTSofuMJs55M4y0/+zidF6+zaPC5kh6n6XA4u/i7G4A64uQUJ0A8NZyPpD/
	HlGyACFZ/JvCNpZ0dFJ6zYWAKKcmXKW4DHwCnuawqJsDmenusmtjLJ3pQXoqUU67++5Vf8HD4vp
	hFPoIhOfYcTf3nEL2D9S2vW8j1wfiFvM7egNB4j1etKGWi2aJG3jp5yOcDpwYXMnkL9qNkkpVOE
	OnDiZDSlbA5cNIIoDzOG3Uv0ONGUMFDMW0ds8PqGy8eDwjgEpYkYrbzq9lyQVOqhbWznxpKW6UH
	OTlhN8ul+cb3vcvWdXy2vVXX2Obo6VBiUvYhKOAueoVR5LayWF3K3QBoYkX3e7qOT0AXOGtQn2C
	ZepLDM2oasXgSz03NtQ8UNaAwZy9TQsmBgFE+rTcRhx/6R6f5F0s4Si6yR4px65G7ceHOSxdmD8
	I9QcP0ys+OfVMayCsWDq+nN78YRYfSzp8ACyFh94BdxPvE8YTRZFsOBHJMdhE=
X-Received: by 2002:a05:6a00:bd04:b0:835:4447:69cf with SMTP id d2e1a72fcca58-83a5d3874camr1966759b3a.27.1778050142340;
        Tue, 05 May 2026 23:49:02 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm5136490b3a.50.2026.05.05.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:49:01 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH v3 2/2] wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation
Date: Wed,  6 May 2026 14:48:54 +0800
Message-Id: <20260506064854.2207105-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506064854.2207105-1-maoyixie.tju@gmail.com>
References: <20260506064854.2207105-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF72B4D6C4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35990-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

NL80211_CMD_GET_SCAN is implemented as a multi-call dumpit. The first
invocation of nl80211_prepare_wdev_dump() validates the requested wdev
against the caller's netns via __cfg80211_wdev_from_attrs(). Subsequent
invocations look up the same wiphy by global index via
wiphy_idx_to_wiphy() and do not re-check that the wiphy is still in
the caller's netns.

If the wiphy is moved between dumpit invocations (via
NL80211_CMD_SET_WIPHY_NETNS), the dump silently continues to copy BSS
list contents from the wiphy's new netns into the caller's netns
socket buffer. The other dump paths in nl80211.c (e.g.
nl80211_dump_wiphy() and the parallel scheduled scan dump) already
filter by net_eq(wiphy_net(...), sock_net(skb->sk)) on every iteration.

Add the same filter to the continuation path. If the wiphy's netns no
longer matches the caller's, return -ENODEV and the netlink dump
machinery terminates the walk cleanly.

This is most usefully fixed alongside the SET_WIPHY_NETNS target-cap
hardening in patch 1/2, which closes the path by which an
unprivileged-userns caller could trigger this race themselves.

Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/wireless/nl80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index db546dd93..f2c91a939 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1276,6 +1276,16 @@ static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			rtnl_unlock();
 			return -ENODEV;
 		}
+		/*
+		 * The first invocation validated the wdev's netns against
+		 * the caller via __cfg80211_wdev_from_attrs(). The wiphy
+		 * may have moved netns between dumpit invocations (via
+		 * NL80211_CMD_SET_WIPHY_NETNS), so re-check here.
+		 */
+		if (!net_eq(wiphy_net(wiphy), sock_net(cb->skb->sk))) {
+			rtnl_unlock();
+			return -ENODEV;
+		}
 		*rdev = wiphy_to_rdev(wiphy);
 		*wdev = NULL;
 
-- 
2.34.1


