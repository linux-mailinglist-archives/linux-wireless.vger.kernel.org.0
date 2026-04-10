Return-Path: <linux-wireless+bounces-34631-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAssOuFL2WkMoQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34631-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:13:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F93DBCC3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031C43003EAA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213402D949B;
	Fri, 10 Apr 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="OGsdQbts"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE891A683D
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847843; cv=none; b=PTV2EFMQ0AQmYKHGVadOHE+GXu/ybkkQbEVdYwL2b59OvZ/jcK+xnqRWD1OzPdpqU4ensVUZWZZue+JCW86MjWoWYYLIG6NeshgytMUvrUOyU1QMDyxJk1fDYTl5Pjk99bf5kfR3PZCXGbTG/rhXoeJh17pbdShB0UfHe7Dm9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847843; c=relaxed/simple;
	bh=bQ5KYD21/3sJ4b+6i16Dje+YHNrR6xVlAT85d7MnJjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FD6jr0Ti01zmjkBRz3FpTiexia48VKfGn6+qheXArpf6PUfbssiYNc/zSxmUPpVuHE/vZsGr9XXT6R7RatsNUtHQJCw5N+V1dHPF2F/uP5zZDLNWaBV7LpWv7BmNumKJlHV0XXuijO+1pmGhArmZjLNenlXvFomBL/FQNinXA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=OGsdQbts; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so15473225e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847839; x=1776452639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00lwwLj8YF6qxS3qPwZZNhYjb0G0oc7kTdVU48sY0qI=;
        b=OGsdQbts/hzazOIwePkq08a/QeWrBMxSJYTTHCgVAoJMDd/34+756FmoReUWQqhuB5
         vQK53tGoedtRn1YP+t5nxC4plJ+MchrGIOTGhvCHg0sNheQ591vpeiLtrO3kSkdtxDhq
         3SayenfIJ84JnMrMHAeE+NUCe3NocK0NthzZhdPt6XrqYpLeQ+7ye4MWSb4s6hI6ka6L
         bhyaQA2Yvfm4xRl0yNo+cqiFr80xWCoh7abzaILDO9HXuME5uDUR0g6JitG4Wpm7M4J6
         HP4D8e9zMNWMK28cC+oc9vAvSL+KQ/SzcDqxHwopaOkwSRP7ET80+NGrQIxkjQgd7FjR
         PzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847839; x=1776452639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00lwwLj8YF6qxS3qPwZZNhYjb0G0oc7kTdVU48sY0qI=;
        b=LA2KjcnQ+nFY69tKD4dVjBqzZ2iQSttaJSonLXpVObZxuEwjw2lRbTeACUkTKeK9RG
         GjwTdiB7lrblnvoOfJOidX5ABpRId6hcm0QoYQdklO+4S/zFGFsL6nq8AiiCGWeZrgw4
         OWeUjXBse9/aiOFTWB8GlteddTvophJXKKYF92UWbZo21Ymddd6BKaNjtsuuuIHhq2vl
         ZVly/iw++rhw/mTvY+7OaEFM1xli7UZz4BzYraRCdOJRxFSD1nu7YZ1gy8KST95DHYTg
         v9l18EMFdvIX0WxU9UbqqIaRiKiK/7nJrLCLvckv6yH+KzU09rk4gAhJ9DNAJgz12v2U
         imxw==
X-Gm-Message-State: AOJu0YxNEjR+5f2YRBko/gqx7kUI4ALcCLCBq2EB75K06f7YYPcjyU5R
	eF7NJmHaY6tmgow3VffKltkvppQ9oDqevCsklWlsiHcNhsoOALHSg7V32tusNjp+uGKDwhNGntY
	m5w87
X-Gm-Gg: AeBDietLJVBb6ENlpbl1b1+H+0jzN/V3/Gc6kvcYZKrpPjOf44CdUAyuFOMbwGioGhF
	SezP3ZqLdZ5AfQHalh+zMCiaaVCe0NbUBJzqFgE3BWmkzcG0NCXLDeg5TQpFrEFt1XstW/bKOud
	kXlAt8mQb/lyIxINiPLkxfX5ZirB8jdAprlJdC23WIiUMcTCNQPFXG4wKxW2rOu2bYw2SDggOqQ
	8eqAjmySU2GXjGf4gDtW/5icQJ2ZEsBigPevq+HGKOfMGzE04JYe44muH3B6ovloOEo/kJ5LpMp
	A6BDaS2J5Rteq7k4mpq8JVBAQxMO9pXD3QQvYhre7XhlW5UvcoO/b5l6I9eTb35uqNTNF1h5j2J
	cP2OKreYQbmDKzKsGwpdHroc7JiWZX4K4jLr3G0F4BqxEmHVDbL5bWSwyD+wqqMEJmTBbDJWnX4
	FsvmYnWH3Vcir8aZI1cSFLI1WCP1jSWNqg52y0TCvfXmEPsjFtzEDHON5wBaZw2pn6LoC327/tx
	ya/MFnLTTse
X-Received: by 2002:a05:600c:19cd:b0:488:c239:d498 with SMTP id 5b1f17b1804b1-488d68712d5mr57165205e9.8.1775847838762;
        Fri, 10 Apr 2026 12:03:58 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:03:58 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 0/7] Do not read band-dependent reserved bits
Date: Fri, 10 Apr 2026 21:03:47 +0200
Message-ID: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34631-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4B0F93DBCC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is a recyclying and extension of a previous attempt [1] to 
not read reserved bits depending on the current band for HE/EHT STAs.

Convention (section 9.2.2 of 802.11-2024) states that reserved bits
should be set to 0 (unless stated otherwise) and not to be read. Some
STAs do not respect the convention in transmission and the kernel do not
respect the convention in reception. The practical effect can be a
really low throughtput between a MT7927 Windows STA and a ath12k Linux AP.

I've been quite drastic and added a check of the current band before
read a bit that might be reserved whatever it's from an IE that was
received or an IE will be sent. I also removed checks where they didn't
make much sense and the current band was complicated/impossible to
retrieve. That is why I'm positing this as a RFC.

[1]: https://lore.kernel.org/linux-wireless/20250120114551.1542812-1-pmartin-gomez@freebox.fr/


Pablo Martin-Gomez (7):
  wifi: nl80211: remove EHT IE size validation
  wifi: make EHT capa size check not read reserved bits
  wifi: make HE capa size check not read reserved bits
  wifi: do not read band-dependent reserved bits
  wifi: ath11k: do not read band-dependent reserved bits
  wifi: ath12k: do not read band-dependent reserved bits
  wifi: mt76: do not read band-dependent reserved bits

 drivers/net/wireless/ath/ath11k/mac.c         | 11 +--
 drivers/net/wireless/ath/ath12k/mac.c         | 35 +++++----
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 16 ++--
 include/linux/ieee80211-eht.h                 | 58 +++++++++------
 include/linux/ieee80211-he.h                  | 21 +++---
 net/mac80211/debugfs_sta.c                    |  7 +-
 net/mac80211/eht.c                            |  3 +-
 net/mac80211/he.c                             | 73 ++++++++++---------
 net/mac80211/mlme.c                           |  7 +-
 net/mac80211/util.c                           | 12 +--
 net/mac80211/vht.c                            |  2 +-
 net/wireless/nl80211.c                        | 31 +++-----
 12 files changed, 149 insertions(+), 127 deletions(-)

-- 
2.43.0


