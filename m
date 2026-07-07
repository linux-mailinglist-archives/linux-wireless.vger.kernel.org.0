Return-Path: <linux-wireless+bounces-38761-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CrEjN7UFTWqTtgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38761-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 15:57:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5002671C319
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 15:57:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p6buScci;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38761-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38761-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F14783017FA4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA341F7F5;
	Tue,  7 Jul 2026 13:49:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516503EDAA6
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 13:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432177; cv=none; b=WptrGEU5PhW7r0cDUZQp98ujJm/KeJpMHeRkDisNZRUOv32CPOZ6q0L4i7c9FS98etVsKWY80vZLnuFYJDnKcwWMX7vXwkU3TYehkZxBuj+hc4stDVwhXlyENjL2pwHp19qEd/HU960KJ004kxuBlwpwEA1Fg8eYXnZVbZzqwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432177; c=relaxed/simple;
	bh=3qVUcr1acVvc4AVR+5GMPV/urBc+jS6lkvNCsiQ4uWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/KWXJHlElQjBA9bh84eq2jq18b0oIPpkf8Q0iOR7fH0181GxXt+2VcrP6063OfsULjX8gzbdauJTpps929CyQ60kv2lyZtGYlbUHHQKgZ7KTKAWa1LHdYe0c+TZyLg4GSV4/cZ+z42mEHEAxEOI1doNewVRDFKn4TsyIo3C8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6buScci; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so2498425ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432174; x=1784036974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/xcduOpXa5czs+0FrVopF6m8A23j8FD0rB2iLn0HvMs=;
        b=p6buScciifvzx9hLrbv0DVwlKD7SN6tPdBz5buuOljeULOAM6u2Ri9Ju2ObZCyvE2n
         wd3L4XEvm6qGSwiszME+4TBZOmwx5SIs0ufJRcXH4jkDgqRIKzOjqM0hnt+JMJPZ0ppH
         80yiMRG/IhaIjqoYbGGNJEaLHug0w8wlw2QgxH0fucy+/WG0U3mMR0C5m4MgTn8Pw4bo
         fxPbi5XaIvPoVam2PYJL4cr7v8MYnuPkrfU3HZaYUvHyIWEwfnPmzaFPu96nxuETuWtw
         PihZbqbX2Xc9l4hu4RASnTaayjTwhyejlIunuwef0A/fx6VnSZWcGOMXrIwpWzrwkWX0
         hhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432174; x=1784036974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xcduOpXa5czs+0FrVopF6m8A23j8FD0rB2iLn0HvMs=;
        b=QhTMVFGqJcvJsFBLjPHsCiicW0V7q3rXPFFWmAfbh2RfMvaFsE+xDLw2UUQZ5rb2Ns
         YQVxapq+WEOHc3IGxuPy4HNUJl8HJNjm/WTqkR3s2INowj8Z2zENcG2SqIMavwRw9Im5
         vg/1D5me7D1j2SOjp4khk6GSqRcM8bb/MRie6pkrtxZSVgDAmsXmT1QODu8/uk20PgaD
         TuoUCyf+sWXgWYM8I11IfjIlJXv6nGnVuvqjhzarlsgwFpdIwu89pewtFfqCBww+L5hP
         RVqXorpOIvM9SaE9iXYAum7/NuEtL6NZF5KO7Uo+Xp9Hr5DUAMGvUhdoozhYzN3JfxGG
         U0MA==
X-Gm-Message-State: AOJu0YwimU9Yq/VWI4K+aWws6lpq4ZAQj+aj8ch5JekZldUo8PB7Hi6o
	xv3xQTnC02NSFsPYeaZwEeXI5e/JCqsouZKYfegPozN3Jx4n6+iJnGST1H+0GA66eTNvBw==
X-Gm-Gg: AfdE7cnTjURa9f4MvWijbQc/r5Ux8GG8iS7KrQhVBv25xoVUluyqZciSATxiOG/EdPx
	44fsBqmLjQzoMUkfefjcEohhAwC8pH7vMke73Iuo1vCdK4oDbDtIzIiga4tVEKO7MaiKJz0zemP
	COMzZ4B4vsqHZdzUX5XgdXhlbuQ/SYcgmLzWQbNqg7wewgcA6JbarSKm1Rhe3LZ7FJQ/1ZlbCpI
	FK7xTnx23I7Zrcq5XpgyCw+LQWL3tDP5wrSBepYC0Yhc9Ut9IyD1YUkON2POffnexG4I7A/eKfi
	78OLEL1dCw7BO9cfO8lRQysgj65ZFLyxMgTD4UforkNJvAY5J02QGKf1KZr2C4JVUEbjsmhrDow
	O/6z1aRuTI18yJcP4ek5h0pJSqlCdDFt4vybbDJbO2cSccvpD1sEh5DbdX7+h1CTgxZQRYSqS4r
	PcEQQS1CI=
X-Received: by 2002:a17:903:3246:b0:2ca:1bbe:c3d0 with SMTP id d9443c01a7336-2ccbf1ae616mr50648605ad.43.1783432174025;
        Tue, 07 Jul 2026 06:49:34 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm12531715ad.6.2026.07.07.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:49:33 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] wifi: cfg80211: reinit wiphy work entries on runaway drain
Date: Tue,  7 Jul 2026 21:49:25 +0800
Message-Id: <20260707134925.106972-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38761-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5002671C319

cfg80211_process_wiphy_works() has a runaway guard for the process-all
case. When the guard fires, it drops the remaining queued work by
reinitializing rdev->wiphy_work_list.

That only resets the list head. The queued struct wiphy_work entries are
embedded in their owners, and their entry fields still point at the old
list neighbors. Later queue or cancel checks can then see a work item as
listed even though the rdev list has been cleared.

Drain the remaining list with list_del_init() under wiphy_work_lock
instead of reinitializing only the head. This keeps the existing WARN and
drop behavior while leaving each work item in the same state as normal
wiphy work removal.

Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/wireless/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3dcf63b04c41..a7e011ed455d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1278,8 +1278,14 @@ void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
 		if (wk == end)
 			break;
 
-		if (WARN_ON(--runaway_limit == 0))
-			INIT_LIST_HEAD(&rdev->wiphy_work_list);
+		if (WARN_ON(--runaway_limit == 0)) {
+			while (!list_empty(&rdev->wiphy_work_list)) {
+				wk = list_first_entry(&rdev->wiphy_work_list,
+						      struct wiphy_work,
+						      entry);
+				list_del_init(&wk->entry);
+			}
+		}
 	}
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 }
-- 
2.43.0


