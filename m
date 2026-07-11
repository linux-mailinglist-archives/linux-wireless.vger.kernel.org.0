Return-Path: <linux-wireless+bounces-38863-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oAIOCZqUUWqpGQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38863-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 02:55:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38C73FE29
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 02:55:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=YSZWKIaS;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38863-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38863-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC212303EC24
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 00:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC5199920;
	Sat, 11 Jul 2026 00:54:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A771A23A4
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 00:54:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731263; cv=none; b=m5IUT+sSkcl0LmR6SCO4Qyt+urp7mp08qcHx4YS3oPo5CeCnZDfoBivyFA9BAkHomEhd1uThy/fy2dl5yEoPz8LrxMpLSUw+yPErUYClwT9ebaiRyogyag1E3qhjnXNCanFDe4zcm6LWsv+VPxcFfek72vvJthaY6W5VeJCciCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731263; c=relaxed/simple;
	bh=7O7Ys5pGj78/u8nrdu2ukPAzmeAitV2Xu6aD4Py/vEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9IolpaQ9rC88igiTyrfX6kGis05IlgDFokhImCFFUW/RRTCE6AqE8OyS1ZZ9KO+znNScvZVMzsOYy3ZHBsZA2jRaQzbdZKKAB1zWxF3bgyTB7mBNjZB6JJ73vNqS+QlhgRgmvXehn3P74vINQ5bh724L9Wgv4ltZe3IUtViQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSZWKIaS; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cd01a14e81so19555955ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783731261; x=1784336061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52oFjEQxVKmNTciLxs+PW1u2TYE3Y4rq4FXh2hf1zy0=;
        b=YSZWKIaStbK0dVGXjq6NZpCqgKor8rVCqqINvRiGB3m9ecR99Ynf6bdSGUjuKlGDme
         Vzq15TRX8z66OAcfz/8EIqGmYUPs+t2rFBRM0cMo+/aBD97KKNKRgx+5Yj3/ZcNqnJGs
         XMstGzC3rj2ioVetk2ESjVVJmQMJvYPMpTef3JMPOXDQXSn1Hj25uf7Zy30bLtYlf6n2
         Pqsan7QFjY5ckPaWUDDK54d9bvO2abivs7Ai4nxI48TWaoi1Bq6aEIuzJosSitHd+aL+
         eTUnzhuTRJUqSnlwJYjHaOwl0gi83U7L55guR1jO0lh7XiRt8bGvnIM7YyP09p+CYZS6
         S62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731261; x=1784336061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52oFjEQxVKmNTciLxs+PW1u2TYE3Y4rq4FXh2hf1zy0=;
        b=ZLI+sO7otqybOcjS3Ib0UL9an8oNR89zaJAc1fYbJFWJH09SpzGCFLJlYR7Pp8XTvH
         nT+DAJF5DeAJdAxetxtwXBYKEJKVwO4kk9mKxJ3u7lnmm11jvOxYDjKQ+SA7/I55yGBF
         qtaWml9cJUH+grmT4Wf2G30bqUzfJ7GyfdLHRP1IsK2XcwzfiKk69emgZYyHQBHUSNPp
         pdeGFBLUVfCNqbAsEd2DFDs/aX1EYMyk9OoO5OZ9hNEi+Lxy8RZCLCt2nITJPDXRplcY
         Yagyliy+n0Nx3tWnc7unkVpMcL4W4VQVbErf1ZiDH3VZqkQdEn0oe3Say0H7fSlzaCb7
         8CDg==
X-Forwarded-Encrypted: i=1; AHgh+RrQpXn8v/EePPBSw5k4vn142U5Fhfa9JuKu3wcFbdwDSZBg9xZeCRayIMNM60eD6Oyb2OrFfvOgKsv8NsD1jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrHcUoCKg69j8mLyVQsEoETPkTSz/zKa5LlkwOhXjoMk7dCtD
	z4yBJb4qpcJnIDXsUABEqvwX91xr6sjlROR3MDBMSMTj9j5VPfDi9BjxeHV5tAjSsrN2NLxuTUg
	S1nAJrxvGGlED6EUHFWHMGHMsrA==
X-Received: from plss9.prod.google.com ([2002:a17:902:c649:b0:2cc:f9a3:ad11])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db03:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2ce9eabf95bmr14620515ad.14.1783731260961;
 Fri, 10 Jul 2026 17:54:20 -0700 (PDT)
Date: Sat, 11 Jul 2026 09:54:03 +0900
In-Reply-To: <20260711005405.2861680-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260711005405.2861680-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260711005405.2861680-3-yuyanghuang@google.com>
Subject: [PATCH net-next v2 2/3] wifi: mac80211: use ifa_dev from event argument
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:enachman@marvell.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:johannes@sipsolutions.net,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:kuniyu@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38863-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF38C73FE29

During address teardown, the netdevice's ip_ptr might be cleared before
the inetaddr notifier is called. In this case, __in_dev_get_rtnl()
returns NULL, causing the notifier to abort early and fail to update
the ARP filter.

Fix this by using the in_device pointer from the event argument
(ifa->ifa_dev) which is guaranteed to be valid.

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/mac80211/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 90d295cc364f..0e7a60dd1d8d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -588,9 +588,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return NOTIFY_DONE;
 
-	idev = __in_dev_get_rtnl(sdata->dev);
-	if (!idev)
-		return NOTIFY_DONE;
+	idev = ifa->ifa_dev;
 
 	ifmgd = &sdata->u.mgd;
 
-- 
2.55.0.795.g602f6c329a-goog


