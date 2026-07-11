Return-Path: <linux-wireless+bounces-38864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w70DIs6UUWqxGQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 02:56:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D750873FE32
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 02:56:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=iJno1SI8;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38864-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38864-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE7330265AF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 00:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE17835893;
	Sat, 11 Jul 2026 00:54:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48181922FD
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 00:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731271; cv=none; b=fBpefnJ7ksDQPa/RwWdkn0ySeNugs715H/wg7dVgRAU7QjTQdwzYX85pmhAkrft1QH+N5LppiFvBEtBza2XmzkNBPWYaz5hb2HeUo+bZlY9EfCk6XoEKdbaupXEZZ99okJBBacyGlJbo5VQY004eXgF4mR/6ZvFararNqKe6/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731271; c=relaxed/simple;
	bh=M2hWQFzhSKgrdKI6qiemtu4JnDynZZgc1Roe2FLVgwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ru/PfiC6oU9b/qGirNTfarzjtOHLyitOEO+Ue6L8yQ/aPbU9jeD6Zb+DK/v/yq3BL1IN1MYucKhTpUzCiM66M9AGG8zYeUffajYyL3E4VaeGRb0zOZ87A+JntZOQmUUb1s4XYnLO/kXOd56+dg+ESwE2TiA6u0daQyFxOubLK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJno1SI8; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cae455cf6dso19780585ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783731270; x=1784336070; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=iJno1SI8DL0SB+oYISqrjpLBSO+0f4h0jiy7bSXIYEKjbe1yeUa7Y3mlkZUUpHHtQM
         n+L8JE4qdEXqm6hBYQUN+e2Bsa9NspI3VP7uNzJ3ibOlmyuVsjOJq3/53YjaNqVx/X73
         IFwpzYxpwcBWVESJ3542e+IH+4VnNC7OJ8sCcYK1fRF7FJyWtG6NV5+mKL8uImpOH5tM
         wY+YBfLUJyGAY4sWjTg5FA5UJZHAiZf4tjTqbJ7mByU2cssBT6jq+GrWKmd6DEBHdl3g
         bc2xLTiQpeJjGFbIhIFGxp+Ig1Cpzry/DxsVLrU2Vk564n/jjJ20fLcAjPRrpc5KgDlz
         1nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731270; x=1784336070;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=HL69pygyEBT/keZO/eW4qDNq5/5rSLwdRTkuUZWj7Yf2CKul0BMtZfXgIEMNSlJVH3
         EXcQRDx+xF8BfV15WYknxqg+vGJdM2AtWjUQ7mEns4JyTPvdVL2j2Zg4xYyevzLY3qkj
         6A33/H5kkxWW1qjjWv5sK3KuMNCMPzGiQwg2HbTp+kDffxo75c5iar1vH0IUg0Qsezvm
         jaiA5UgxoauhF2TuYdXUyBSUsOtdOCZaA/WPv9GZmACJ+6hxiJmuQPsAITaWLA/t5OEH
         upvj4vdeYwG6Jh4KXYIm40WzFCKQhKtQUrka6rjN+Dt7dAVeyZ/Nqjm0gVishxMgYSbR
         84Ew==
X-Forwarded-Encrypted: i=1; AHgh+RrirO8I3G4IueajFKsBmwMQ2vvOVD1Sy2HxGUVOeQPBqzSn65WcBEcmbAugQ/RKAPAO5ayEFbCZCPPAZBhOLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rt15m6KYbEy2CADOI9/70Bb+4WQnjGS3dek5SiAGqekiQAo4
	SD208f+pe+e5ipw4Z+CjUkcsm4z/vDUItSoXnGUj4aDxdg4+Zuf7y6eCdecji7UjoG8eFkZbthD
	nYfdbAUhDnjfaNHaeumx+R48LBA==
X-Received: from pluo8.prod.google.com ([2002:a17:903:4b08:b0:2ce:6df9:bda5])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:292:b0:2ca:f16c:87b3 with SMTP id d9443c01a7336-2ce9eae97efmr11997835ad.19.1783731269952;
 Fri, 10 Jul 2026 17:54:29 -0700 (PDT)
Date: Sat, 11 Jul 2026 09:54:04 +0900
In-Reply-To: <20260711005405.2861680-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260711005405.2861680-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260711005405.2861680-4-yuyanghuang@google.com>
Subject: [PATCH net-next v2 3/3] net: ipv4: clear dev->ip_ptr before
 destroying inetdev
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-38864-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D750873FE32

To prevent RCU readers from accessing a partially destroyed in_device,
clear dev->ip_ptr early in inetdev_destroy() before freeing the
multicast list and individual IP addresses. This aligns the IPv4 teardown
sequence with the IPv6 implementation.

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/devinet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662e43..3b31f4bec30e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -322,6 +322,8 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 	in_dev->dead = 1;
 
+	RCU_INIT_POINTER(dev->ip_ptr, NULL);
+
 	ip_mc_destroy_dev(in_dev);
 
 	while ((ifa = rtnl_dereference(in_dev->ifa_list)) != NULL) {
@@ -329,8 +331,6 @@ static void inetdev_destroy(struct in_device *in_dev)
 		inet_free_ifa(ifa);
 	}
 
-	RCU_INIT_POINTER(dev->ip_ptr, NULL);
-
 	devinet_sysctl_unregister(in_dev);
 	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 	arp_ifdown(dev);
-- 
2.55.0.795.g602f6c329a-goog


