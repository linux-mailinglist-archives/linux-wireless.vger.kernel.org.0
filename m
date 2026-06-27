Return-Path: <linux-wireless+bounces-38198-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9HNEBS2KP2pGUQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38198-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 10:30:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A23356D17B3
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 10:30:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OZZXTprs;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38198-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38198-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 262463009158
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62B39099E;
	Sat, 27 Jun 2026 08:30:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FB34DCF3
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 08:30:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782549035; cv=none; b=YRVshA0/QgSHx8hB1ph81UJwB6zACVeHtjcR54MGspxKdc/kpLwc3602Tp8p3Q3IVSo2tKxr0NL3fh3jZj7vpQpIwdpzQpiYCZojhRM2Amodo9hIFAGHBC+2HBMxcsba1cQUi+h/T8D05xIYzPImZr5mf5zldMjDPV6+C2FEVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782549035; c=relaxed/simple;
	bh=UsnhKNetPInn6C8gKXQH4i2VomblsScIHThaYXpTtmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AChIcC6YAx4sgy1xM8JGIehbZo7WLQU4bAV7nRDyMoQGUbxp7pmjh8VB75SemBuHL0XI3BmwMC0nj/MLQoEyBZCuIcYTRyGiU7WB+QAta0u+Ip0RMpF1vHlFpCyVp1tlGnj7Y/up8Ta9SFZLEnKKdosDHamIZxFEvsJveH/SsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZZXTprs; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c7cfa17fedso16864915ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782549033; x=1783153833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtT5g5YW2OGj0JW5pppGyBl6Hvxi0mOag4ijeWX4SQo=;
        b=OZZXTprs8REoqjHuLwnsbiMkJsn8mrMqSfriXvGfms2ALG2yKbzfZrinsxdHzUKimb
         re6X2hdP2/R8ohM/2f4sktrzBl3mF4bwWM8ejbkQytz9/7lBduNsI7miO22h0hlzkJDE
         Lo3tKKbAdBORMDd7NR7GCQl2XYbKGxBoKBFHPFny/V/q86arjHr+YdJeOiUvplT/PzXu
         DAPRCJ07drprM7yjP62XFohU//urYo1BlUE7kiOtHgWBK1k0mDrghdFPTXBaJYmnx+0V
         IfdXspmI9HOnGtzznEO5q5ruUBXxEJOxFdskpC8Q19cQ+pAPNDZMSSJ1Bmt0mEwb8c1M
         GPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782549033; x=1783153833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtT5g5YW2OGj0JW5pppGyBl6Hvxi0mOag4ijeWX4SQo=;
        b=B+LcVjr7UM/rYPz2uWSfQGWkcbmaizZ8M4GDAk+mPhZd6eucg4+4JkFqNZHK23PLVy
         H+SMakRCLkKInDFM4iluaoqtdzBTJ0tx6uM00vdOxeQedPEPQ73e9XDLkMZv+GyQGmj5
         UAVZG4zy+VJwiYKYEsQPQ8fBaOzuFZjHlO9tDZTdFm6g84aGFYyjLvPZnvIsAHqTzzGd
         kwxIfzxtVq7tkOIhWgpCmGY/ejUK9ArWseCbam8ANWETj8al88SYldeNhXNi1HParq0G
         IF7m8WNHXpWk1FPPFy2wWVr+Ub6k1zustQ5uNTiD6hPqdPPzhJXgRCUBK2/WPhkQRBjT
         v81A==
X-Forwarded-Encrypted: i=1; AHgh+RoraHdKhXx0pnKlJTvl8ensVjt28s6ydACMCMDcCNqrPUyzVD/akeuPBinfhPUq7kW81qJshPFIzJiijcYGAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FcntPzzNIn3uak63I85uFnkt12G2UUTSb5W0i08ZrsCZald7
	GhyQTw2ODjghViDIcBQn/Aw7OGR2bCAE5yYu8nHANX2pOdgHkH0Z1ghxG2iL+g==
X-Gm-Gg: AfdE7ckTl23i8l0KqA1DRc09nyHUIFcP1vnzUtxbYhAKUY8neqz9DHYD8AMPI9yuEwj
	vuvloN0iWWks+72+jDxtRlgEuqODAsaKwK6ghb2RsTvCNBlYE+7k734+IIcoGGKJ5i635ETZ3lQ
	VexS38tO6y5Jg8t5Yb6h6LWZ7/fpWsyP/VGmyFkiHdSdRGMd1o20RYl9nzgWKNbUlwkmjxp6ens
	QzYY+b2FjI6RBy2rl+57w8TMYzrYXnkthbLq3VJp4EYwAm/l14mH6HhwNy/yTLrkAA7+0t7iLQp
	idUXH+mGv2lcgF6rvW6hfhZWkcfYLu7J4uWvjSHao9r/3T9fBV6URB18+MdCf9SWR68L0jI4aFr
	KuzjQSUpwN3SQllwJvg7ZnUzZfKeaW1a22rY6lMVqZJovTf74wZ7ne/n+5nICTKUmDmu7DFDHjV
	4QWKdOXPrwpaPuTJqkEMWdPmtih6N3f6WANrMcTQ==
X-Received: by 2002:a17:903:2f8a:b0:2c9:97a8:afe8 with SMTP id d9443c01a7336-2c997a8b0ebmr25052495ad.43.1782549033052;
        Sat, 27 Jun 2026 01:30:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9c170d33esm2110615ad.27.2026.06.27.01.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 01:30:32 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>
Subject: [PATCH] wifi: mac80211: defer link RX stats percpu free to RCU
Date: Sat, 27 Jun 2026 16:30:28 +0800
Message-Id: <20260627083028.3826810-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38198-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kaixuan.li@ntu.edu.sg,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ntu.edu.sg];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ntu.edu.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A23356D17B3

sta_remove_link() frees a removed MLO link's RX stats percpu buffer right
away, but defers only the link container to RCU:

	sta_info_free_link(&alloc->info);
	kfree_rcu(alloc, rcu_head);

The RX fast path reads link_sta under rcu_read_lock and writes the percpu
stats. A reader that resolved link_sta before the removal keeps the
pointer. The container stays alive from the kfree_rcu, so the read still
works. But the percpu block it points to is already freed. This needs
uses_rss. That is when pcpu_rx_stats exists.

The full STA teardown frees the deflink stats only after
synchronize_net(). The link removal path had no such barrier. The race is
hard to win in practice, but the free should still wait for RCU.

Free the link together with its data from a single RCU callback, so the
percpu block is reclaimed only after readers drain.

Fixes: c71420db653a ("wifi: mac80211: RCU-ify link STA pointers")
Link: https://lore.kernel.org/r/20260626080158.3589711-1-maoyixie.tju@gmail.com
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
The earlier inquiry pointed at cb71f1d136a6, which added sta_remove_link().
The regression is c71420db653a though. It moved the link pointers to RCU
and deferred the container free. The percpu free stayed synchronous.

 net/mac80211/sta_info.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4c31ef8817ce0..6d58571a364d1 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -355,6 +355,15 @@ static void sta_info_free_link(struct link_sta_info *link_sta)
 	free_percpu(link_sta->pcpu_rx_stats);
 }

+static void sta_link_free_rcu(struct rcu_head *head)
+{
+	struct sta_link_alloc *alloc =
+		container_of(head, struct sta_link_alloc, rcu_head);
+
+	sta_info_free_link(&alloc->info);
+	kfree(alloc);
+}
+
 static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
 {
 	struct link_sta_info *link_sta = wiphy_dereference(sta->local->hw.wiphy,
@@ -439,10 +448,8 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,

 	RCU_INIT_POINTER(sta->link[link_id], NULL);
 	RCU_INIT_POINTER(sta->sta.link[link_id], NULL);
-	if (alloc) {
-		sta_info_free_link(&alloc->info);
-		kfree_rcu(alloc, rcu_head);
-	}
+	if (alloc)
+		call_rcu(&alloc->rcu_head, sta_link_free_rcu);

 	ieee80211_sta_recalc_aggregates(&sta->sta);
 }

