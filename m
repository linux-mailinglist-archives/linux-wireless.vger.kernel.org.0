Return-Path: <linux-wireless+bounces-38861-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DQHYFzmUUWqWGQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38861-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 02:54:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4F73FE01
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 02:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="ESsO28b/";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38861-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38861-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7133020A9B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07A1C3F31;
	Sat, 11 Jul 2026 00:54:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5A35893
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 00:54:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731252; cv=none; b=Nu8LDUp0qc4Oilww7J5TdY579HJZJnQ+45m6qAgajCoXYzPXhOD+VyNgPTcz+/ba4OJ7dhyiEP43ohOdOkDvUkVUe4DjtwcxV2NSzge+RyFDtB5QNpKL++Itl8rohUpO3N6Mjr9eIzQSmtWyGjGIKo/+3WiBjvqs4FXgrRXMnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731252; c=relaxed/simple;
	bh=oApeQBB2es6SZQwjV8Xt9HR9yOpez9QQ+SzH7wnSmV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QzfWZFx4iNAr2R7D+glTf82TVwmGZk/bkW2AUU4ZdViJUn4oP7Q/tsb7cuuQXA2dJmOWcvzDR52I8Qfi+9jB5BxNHajaGNnB4m4Kq/ayIKktc+ngLWJ8plADxMZDR9u5lIwmqMdId+tbAnxUn2ySMCoA0ctuVAlX0rY2rScTIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESsO28b/; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc88e22f92so28213425ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783731250; x=1784336050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jBFErHW4jyCZ1FOOH3e+xQFnVy/CtEciwfCwQ/d/uI=;
        b=ESsO28b/zEH5BnqomcqD73V1jokz7seISPuY/FyMbCn0DA57D40c4tvd/95gXuArlN
         AMPnOaK8T31U80m9CPASi+KMPKKNH7R4ufm/16eIcmc7Fzvb7u4GM3KJ4hlYmgWWawhf
         z4MIy+Zu4tHicksXA8oZakk4U3u78WhoNiEjwhFGxrYWmxoBpzIkM7MkqNO1hXk/9H64
         WvBGyCZngRvAnK7frbdJX72lt3/+H2RFExclj0+BMovApk2pys47CidLJPq53eoGxVY+
         7cxElK/WWzNyi9HNeJiUSUfe1soYwQHcb9VP4v6JEwz0bdzP9vN5JamlRgfjq+osxA1A
         jmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731250; x=1784336050;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jBFErHW4jyCZ1FOOH3e+xQFnVy/CtEciwfCwQ/d/uI=;
        b=U/qmAgqDIwTa0uigZC3vw+A2iQZKG/Hgc3TGtgoIZQU5sGkDNkBHCfe6KL7wUIbHcD
         QBLQGlQa+pV8jN6ic+e92EtFRM78+TZ8rUnrWWN8GlISnyC8IvBgQn0emjPTWxE9aBe4
         FvO5VXsId3hBmG1n1TteXSYkaxKGNgESIK13xDdzoIbjO9s+Rb6kMb5MhoAGWhxqBzNs
         VmxnwhXHVCSpzI3VbvU3Gj+ih9SCx3CoUUOLbxNKBgXapYyInxsDJE7ZCOTaIp0+elsR
         VJ670NxpTG5PQoWt7xxgNvjd0aKmJY7Qv2c5gVYP4AUNVoMrnZAgcX8B/6y+H1uxW6P9
         KUCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvLaQwtq8xcCb9gFHZyL3cxnk1hzcsYJGi/L5wbCEMzT/125fVabr0AX1lXv99VRWLiA1EpAmgs8o2z/jmtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGY7ICt/91G1ROB0AiA/FtYX+iuOp6G49bpDhoeG7nX1C2WIxI
	hFwQ4jqpDmpEWLxfpKsuuQ1Up/OvjF8io9zytARs9aJCgUDGygXPX5VncgeUjOfM0XvoacWTYjD
	cl/yvxvTtszykpA7k3eOoaL+zPA==
X-Received: from pldd21.prod.google.com ([2002:a17:902:c195:b0:2c8:4c1:883a])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8f:b0:2c9:97a8:afe5 with SMTP id d9443c01a7336-2ce9f27e6dbmr12598325ad.40.1783731249956;
 Fri, 10 Jul 2026 17:54:09 -0700 (PDT)
Date: Sat, 11 Jul 2026 09:54:01 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260711005405.2861680-1-yuyanghuang@google.com>
Subject: [PATCH net-next v2 0/3] align IPv4 teardown with IPv6 and fix driver regressions
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
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
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:enachman@marvell.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:johannes@sipsolutions.net,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38861-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1A4F73FE01

This series aligns the IPv4 address teardown sequence with IPv6 by clearing
dev->ip_ptr early in inetdev_destroy() before freeing the multicast list and
individual IP addresses. This prevents RCU readers from accessing a partially
destroyed in_device structure.

However, clearing dev->ip_ptr early causes __in_dev_get_rtnl() to return NULL
during the notifier loop in inetdev_destroy(). This causes regressions in
some drivers (prestera and mac80211) that use this lookup helper in their
inetaddr notifier callbacks.

To prevent regressions and maintain bisectability, this series first fixes the
affected drivers (Patch 1 and 2) before applying the core IPv4 change (Patch 3).

An audit was performed on all other registered inetaddr and inet6addr notifier
listeners, and no other drivers were found to be affected.

Change in v2:
  - Split the original single patch into a 3-patch series.
  - Patch 1: Teach prestera to ignore duplicate RIF destruction events when the
    RIF is already gone, rather than returning -EEXIST and aborting the chain.
  - Patch 2: Fix mac80211 to use the valid ifa->ifa_dev from the event argument
    instead of looking it up via the netdevice.
  - Patch 3: The original change to clear dev->ip_ptr early.

Yuyang Huang (3):
  net: prestera: ignore duplicate RIF destruction events
  wifi: mac80211: use ifa_dev from event argument
  net: ipv4: clear dev->ip_ptr before destroying inetdev

 drivers/net/ethernet/marvell/prestera/prestera_router.c | 6 ++----
 net/ipv4/devinet.c                                      | 4 ++--
 net/mac80211/main.c                                     | 4 +---
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog


