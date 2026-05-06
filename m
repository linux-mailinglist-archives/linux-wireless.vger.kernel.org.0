Return-Path: <linux-wireless+bounces-35988-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IKsK2Dk+mmGTgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35988-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:49:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 520A84D6C3E
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33CB730022F3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05A366DB9;
	Wed,  6 May 2026 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deaV5zYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537903271EA
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050140; cv=none; b=iwEO12DMliXVJ/2CBqm/ouuTkQMnstqpgkcZ1ySoeIHF2fg6wDvNJ8eXvQNu15rqOWGCCkb9GObB+EmQCi5Aka2UxCBB0PhueqwmHdSMtoHCRNy+lXB7whH7izNZ+Opy9MrbKdT/YbTYBuP31IAxf+bCbI4vvW5YkrRH6Qm+GOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050140; c=relaxed/simple;
	bh=SYu7RVrUmMoG9iUO12IgAf72mZlAL+uOYEqH7EzIqjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=go7c7cwKxY3ax4bUYi5+6mFMoBnz43fZlrO/iB6Evuy1gp1WZsrouQnptYhZKWjO0hOkd4Jn5T4CHbZHQp2xwZamHN9iYq39fQ2chTyKX1P6mQNQ63Hcg26G3vQOdG2Xxv0cTMbQ9MWz+ahsciq3JZw96j2FpSTbpQe7d8KiFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deaV5zYq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83537a80ab6so2193055b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050139; x=1778654939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzrm2VJz61vcEBL476pCcHtOXQuib+2XkdbYCtAO5mM=;
        b=deaV5zYqvYcRs/EGdvYPXr2kqxSJ6fipG+tQlxKSV+eed+Le1BZselpdZ1nEYWtkp4
         0PLBLYFYSTW8E8T4rpWtshZX6tV8HQQzF1VCsWGoPRJm5whZIyX47UY7JUUNXaAlmCZD
         rIizRF5djwURBApE/43snE7t+XJKCFPw4/c9dPTw5BaPWPJPNgKk2r09zbZVe4G+dbkB
         oryhK3AYHcjhdmRiP0NSkklcbgVsrYngzSNB/DSkiQk+h49/BkiXdTKv+cum2ml+eGQv
         IYy8MlmGPJ0n7LAxaH6ZoR7d1EaIWtHtjAMAGPzM3OYcxNBKUH0Uf+oT8cSK5WzSH64H
         TW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050139; x=1778654939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzrm2VJz61vcEBL476pCcHtOXQuib+2XkdbYCtAO5mM=;
        b=FA754g/s46OogZ5qK35LObWoOF3HnsuqAzGV18k9JtRN/aQxah5tSWoZNvh5pCxq71
         2lfAoyVHgk3m9S6Qewj3NmFvnCqgrZ/Dv/nbISRGXp2ibj5LfzpLKbsNAol148mAb2MI
         4/qcOyRV1o3f31/wFoAXFMGrUStBrJPUiGXVVg/1Nzpz/cHKJMkvDp6mafSbX+7tp4mP
         EMLdrOYJW+ClOqURO9njfFEypWnQvPAo0UyZlYJXtLAfYr5aBVO4OzEoejBi8ZQuLh4S
         0zBJIh9wqFiOhR0VZ7ytuXaYDQaRIhqZ2evrCwazS//0ICJOzNbostv2yk4h9UsSHMaC
         NCgg==
X-Gm-Message-State: AOJu0Yx87BTxriuUsfsj1S0evfAhmQOCr/jzXDQlR6pf7HC7pAGuKbtc
	f1lfPArIV/BspL6Aaay0Lln8itQAzzeT+LwvdVrCvZIoBrEjuxr86dCF
X-Gm-Gg: AeBDievZUxJSrg8yssKH3awhJx+2IzQlMw+KiVv+fVqoYN/atRToYfW4nFRFBSJC8JG
	VJHg5LtUEi+iOsbF/sUMZlG8v4twmqrjh0bTSgq/CBPcJmdVXaahNvqaIopWY9w1GZjPAtediiV
	JFNbSruzT79sV95ZTKVLMngyz8yHY/42jdcpLC4XLUKoJy8aeecGLWxcScUoWsapD1Bjdwx+id7
	29Fwu4pdmzqR+w7sYDZEeoV8UYb4Yuil9s77NNrty4S1kyJivETKWLo7RmclF2vufFITlzRIyIw
	sjCCJWXaMS5RZb++ycFTXkZKXfyqNmPCuzZOwLlGXeazZdbygXm8LS9JsoshHqzy2/XxFsMaEgV
	Knmv+d8MUhphEWxgyv+kjv7gjUIQa8eZ3OX0+f067l8PuQUJSGENZsj0JHneuhlemimqjJlHSS2
	VYyZFnaTEXwr+nxRtWJRQkkV0+PA02qraaLBiBytEIVFcOcxt3BXe96pb7DFE=
X-Received: by 2002:a05:6a00:198f:b0:82f:42bc:3386 with SMTP id d2e1a72fcca58-83a5c8b06f9mr1853301b3a.21.1778050138659;
        Tue, 05 May 2026 23:48:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm5136490b3a.50.2026.05.05.23.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:48:58 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH v3 0/2] wifi: nl80211: tighten netns handling in SET_WIPHY_NETNS and dump continuation
Date: Wed,  6 May 2026 14:48:52 +0800
Message-Id: <20260506064854.2207105-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 520A84D6C3E
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
	TAGGED_FROM(0.00)[bounces-35988-lists,linux-wireless=lfdr.de];
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

This series addresses two related namespace handling gaps in
nl80211 that came up during a recent inquiry on the list. Both
follow the netdev convention.

Patch 1/2: NL80211_CMD_SET_WIPHY_NETNS uses GENL_UNS_ADMIN_PERM,
which only checks CAP_NET_ADMIN over the source netns. The target
netns selected via NL80211_ATTR_NETNS_FD or NL80211_ATTR_PID is
not checked. Mirror the rtnetlink convention spelled out by
rtnl_get_net_ns_capable() and require ns_capable(target_net->user_ns,
CAP_NET_ADMIN) on the resolved target netns. Reachable from an
unprivileged user namespace whenever the caller already holds a
WIPHY_FLAG_NETNS_OK wiphy in their own netns (mac80211_hwsim, or
an admin-delegated container scenario). PoC reproduces on a KASAN
VM with mac80211_hwsim and shows the call now returns -EPERM.

Patch 2/2: nl80211_prepare_wdev_dump() validates the wdev's netns
on the first dumpit invocation but not on subsequent ones, where
it looks up the wiphy by global index. If the wiphy moves netns
between dumpit invocations (via SET_WIPHY_NETNS), the dump silently
keeps copying BSS list contents from the wiphy's new netns into
the caller's netns. Add a net_eq() check on the continuation path
so the dump terminates cleanly. This is mostly a clarity and
convention fix. Combined with 1/2 it also closes the path by
which an unprivileged-userns caller could trigger the race
themselves.

Changes since v2:
  Both patches: dropped the Reported-by trailer that pointed to
    the same address as Signed-off-by, per Johannes's review.
  Both patches: added an explicit From: line at the top of the
    commit body so the email header From and the Signed-off-by
    trailer match the patch author, addressing the bot warning
    Johannes flagged on v2 1/2.
  No code changes since v2.

Changes since v1:
  Patch 2/2: trimmed the comment per Johannes's review. The
    comment now describes the invariant being protected (wiphy
    may move between dumpit invocations) rather than referencing
    other dump callers as motivation.
  Patch 1/2: unchanged.

Maoyi Xie (2):
  wifi: nl80211: require CAP_NET_ADMIN over the target netns in
    SET_WIPHY_NETNS
  wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump()
    continuation

 net/wireless/nl80211.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


base-commit: 65493f27a6008bf84bd11bd41c5e1ea6b0bf3c3d
-- 
2.34.1


