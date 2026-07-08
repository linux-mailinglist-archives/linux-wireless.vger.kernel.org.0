Return-Path: <linux-wireless+bounces-38806-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aZFIO3usTmrMSAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38806-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:00:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1772A0D4
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:00:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JpeoUPX6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38806-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38806-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3F17304305A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63753E5598;
	Wed,  8 Jul 2026 20:00:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC543E4C64
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 20:00:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540835; cv=none; b=Ky4PSu8imZZBsh+FPkJfzCyYsKuMVc6q7Gg9M3xrcRrHhcTXW17a9oWHXRq3kxQMSQNqirtEC7X8wqJsDTEFvnyg5YcrxWrnmg0ZBfO0qGVOdQKnWTpaqUwkfN1uE2HEjeL2BQn9HVwtuk9XkautTIbp8fQhw1cvnCuR//Nc1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540835; c=relaxed/simple;
	bh=jXsNetM5zyhgHWCvL3yiRo00woCO9r0oqie0QzxXmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFyeeOT9D6aXQlcvSJtTKgAxkbSHD1ApxcQ0PTGADGCIl4HLEuaEAyOOtEFsxQdwTEgiDcYeQNL0+JsG8FreWWjDliOJpE/FlZGN+Zj71MBCbq3+Cd+7Qq5r5PWh4gTm44ALKfnBHibOjXPuCj9PRsGCGA9GfaMi2uySsw9N84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpeoUPX6; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cae1a3a744so8715295ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540830; x=1784145630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jidlubEt1qEXlJeLtvIjppUFVqj2pNZjtUN9qoZK2zw=;
        b=JpeoUPX6RTWVgFAeRIEc3b6KdseyTjUyLn/jS1aVhUQ7SnDEEPLHXuCugD/EA/ChFI
         IEJm5hFWH8zz/ZmQfXdWe+K30fKLVLM06k0MS+Ne8XMx8TP577gDKT2R91C6sOJQYaks
         vss2VW6IhhtTkkEt26s9nHHpbU586HJVJvN2WgGkibcNff+OJ9QEKGXuvKWKw72Yrg74
         XsDSeyJb0kKgUjJ0wKvxJCOWkMCLuQ9WonfDYFZp4pt5QBgYcq634CxbCNR+XQ6Ds2D0
         ZNVAdJdXvuDg3xVetHccS/LarVyd2qMs9xJrhorNNpZSNnGPiZ6+QVF1UfhyAyRgKgda
         Be3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540830; x=1784145630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jidlubEt1qEXlJeLtvIjppUFVqj2pNZjtUN9qoZK2zw=;
        b=gvfRRLFiixExD68G+52Awe27lKf7mSVVx23ARiyaTLKH8HqmRbO9JtuFoBLhfy/8He
         dySiEawk2Yh5P14gd+lLCW8snoTJnTy5PQU6e3ptua7Qojpg5vfJZ+2nD7fUR+YEjwTM
         dZUCBJVdFamdMwfRDm1RKMj/upuwR1JO4f0vlSgUfMK8GrljNM+IynELkuYtq0e7jCgY
         aZQDNIjfusXRpmWaVbxj0GRUzcv+I9TlQecnKJZIASrGQMLKGUEJd3/ww8GUTsFTuESF
         oVY2ZSaYVuHqUYMd4w3WFcb2SydsYdDxgpGSECbsA7ecVEQ9OAjk2jzn3xCNA0a4RxYI
         obiA==
X-Gm-Message-State: AOJu0Yy6gOKhpHDgHoOSl7nQKaIJrpPuABqCLg6Sjs1qSza9aWEor2t7
	c3wbIOWgGWTcz9yrd0XMbC1mzPUIcjdLSgz4j+82ZxwKTwtLamHzXQlG/kWKvzTaT1T4ng==
X-Gm-Gg: AfdE7ckrysV70pRUHLFGQ6YvvpBhIluiI6ygQnf9Par+op9IlxTvPFZqhb9h2PBclxR
	OHUFgJc0oX5DekOOe5+77DeZuqT9OuwcFBxTOunk9RDhpnSz3oJNOwV6MOafDdhD+iMzc3aueA4
	82cdDIeW6Oy+eC6Uhl4oKTGhDfpehZrG73rTx+iF5gXcPVbioJkXwfqfPrGAkifV13ygBk1sO2O
	c0BLD0MIG4N02NYDGzvUU+KqrpWQ8I41iuDtPudXGf+qTDQfNmL51GE1BwwvdbRz8Dq3vPqXFwL
	caV3cf75jxO0gQgxJTpbbEpTzgZawRd5vTiyDAxQC/6nVxnvld/hCI8IdZAldrJVdZcZzKuNqPC
	aU+dmJVExTkg2QWv4XNQ2C1nCMbmmCYh73grE2N1udIjoo6fknXIipOmaAUc20PPRCfUqERtwv9
	HUv49gyB6OmhVhrBOcmuY9k4TrsjVq50jiYVYoOguRS3xw+uc3kLIQPmlkozQkuqs=
X-Received: by 2002:a05:6300:6ccd:20b0:3bf:49c8:f73 with SMTP id adf61e73a8af0-3c0bcbc1347mr3085582637.35.1783540829957;
        Wed, 08 Jul 2026 13:00:29 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.13.00.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 13:00:29 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH 8/8] wifi: nl80211: clean up color-change beacon data on errors
Date: Thu,  9 Jul 2026 03:59:11 +0800
Message-ID: <20260708195911.84365-9-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,chromium.org,dolcini.it,sipsolutions.net,google.com,oss.qualcomm.com,kernel.org,phrozen.org,marvell.com,tuxdriver.com,quicinc.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38806-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes@sipsolutions.net,m:jaewan@google.com,m:daniel.gabay@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:pagadala.yesu.anjaneyulu@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:lorenzo@kernel.org,m:john@phrozen.org,m:patila@marvell.com,m:cluo@marvell.com,m:linville@tuxdriver.com,m:quic_alokad@quicinc.com,m:enderaoelyther@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65A1772A0D4

nl80211_color_change() calls nl80211_parse_beacon() for the beacon_next
template, which can allocate params.beacon_next.mbssid_ies and .rnr_ies.
The out: label frees those, but two error paths after that parse
returned directly instead of jumping to it: nl80211_parse_beacon()
itself failing, and the kzalloc_objs() of the attribute table failing.
Both leaked whatever mbssid_ies/rnr_ies had been allocated in
beacon_next.

Initialize tb to NULL and route both error paths through the out: label
so the parsed beacon data is freed.

Fixes: dc1e3cb8da8b ("nl80211: MBSSID and EMA support in AP mode")
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/nl80211.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5adcb6bd0fc56..7e796d7c1a661 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18724,7 +18724,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_color_change_settings params = {};
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct nlattr **tb;
+	struct nlattr **tb = NULL;
 	u16 offset;
 	int err;
 
@@ -18754,11 +18754,13 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 				   wdev->links[params.link_id].ap.chandef.chan,
 				   info->extack);
 	if (err)
-		return err;
+		goto out;
 
 	tb = kzalloc_objs(*tb, NL80211_ATTR_MAX + 1);
-	if (!tb)
-		return -ENOMEM;
+	if (!tb) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	err = nla_parse_nested(tb, NL80211_ATTR_MAX,
 			       info->attrs[NL80211_ATTR_COLOR_CHANGE_ELEMS],
-- 
2.50.1 (Apple Git-155)

