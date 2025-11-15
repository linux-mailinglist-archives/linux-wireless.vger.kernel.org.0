Return-Path: <linux-wireless+bounces-28995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD7C60995
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A393B1915
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26E224F3;
	Sat, 15 Nov 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5j4HIDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012E2FFDDF
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228573; cv=none; b=ZYFcRouzTgwDNjLZhm1lXOrK/hSZP9sFquBn96w2HAJ2sZ09qU5pC+KQA+9TA+j3zizWKByWiaT7VFhItKaN496/nqvG2OK/KiIvRHr49wzU1K/A+F01GezxwpIOpmGMQPFmjK7yw8030cMHJa5H1Fd3tKbZrTXOyO4QewHAWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228573; c=relaxed/simple;
	bh=yns5qi7XQEcaZZaod52Y0LJDT2/+Tq5wF0kc+VZSQhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3zsLEEqQyu5sTJonygxuLfHSaVsQtvIwV9XT/K+8ZqXHwEUs4AMsJrAG6gyJd07N0V7lq03QLZyB2Wt7gV5W2/iRZNlzh16eQI4XdIQTRcRFm6d/8n6B7vmchol1hLyIbpLVWgrzFxP5SRklUcOPzqyj4bvTMnVIj3yy8gqohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5j4HIDa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso6431554a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228570; x=1763833370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPIua9GktDgJ4rq1nomUtP/dSYOP5/vsFjzI+J2byp4=;
        b=i5j4HIDaAMhDgUKl1kja3R2+rb9uMOiWjIzPR+n2k4zPzg29hPZw/bvUCR1qvYJZy8
         Y5zSHzX7NNt+d4Tg+ypEEm2aF74HuRNXBjwd2+1yPxPu0qLPJlQq3zqHeggzGiYOWn5C
         ghWxOcTVcKLGnC5uNV0DR/bp461ReTkEy/1WaLv8JmWmk8AP/MiThF82kkgNafrVRLdP
         z/YoCi4KoWF9hD9AvTfDLc4C3KFkNZ5muIVRswAH1crvlElBlEO/aeJ7ToGII7k8gjlm
         M25tbxVgVeAzgM+4al1f0vrVB1yK9ySJtIctzaVoyB+W3v0TdjADFXSuAB7QvLdFJ5IN
         Xc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228570; x=1763833370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPIua9GktDgJ4rq1nomUtP/dSYOP5/vsFjzI+J2byp4=;
        b=hyNb3ZG/xIZ9xJUuozmER4T5WSbbRk+SetmcvEzqLvRQ263K0qsQvxinNokNhc4yQ8
         kZGh7NzjqN3/2NSRke6UZa+VjumRDe8fMVQdjJkZhbaFNcyv20y8EybcADH6k8GeDn8j
         cseseCniMxmVChluas1BqIwMT5CHNaC76luNSoO+qj1gd6BkuFVgOlXqfGwN0EeUwFIS
         vlVGrgPExDODBJr6m4RapCOmU9619g+wAF7XqYvfZ1Xv5MsS70Vrw7pTatLhzvV2K9Qp
         pTpnMtNnEGpwoMYwvif5lz8ytzrTiMqknz8VbLDJ+2NR+JRTIfcefQ5QIiuFvsotetpd
         2XCg==
X-Gm-Message-State: AOJu0YxROrh2WVZrmRQgi/3NGg97UahxzAGcktxE5F/5XnB1iHTB8SFa
	rdqqU7Z0L6uwj2HNKUx3Ulf+ynFRY3vMCxwPRb8fSkKjuzGptkiDyItdHwbBAg==
X-Gm-Gg: ASbGncuMDJmIYVoz2GTY+/vU//b+vSCSkNegzc1wLiJzX7cOlOe0Pn+ZaKoEpDyUABv
	5e29qDaZ3LChz4gTnw9DDKDBrxBM5xLBy6myfosifHhBjel4gh9jeOOwywGYFbmqG7FKjpWq409
	G8kqn510HnX40wHRRJCnj9QOeeDi/If8Fy5yZpLdGXyedxu++DKHqGnILFf6jHm2ndvW5306Cxj
	MRCl9JcsSw0qQCCYqUpIsfyxZN91NDoC8AXoOiEAEvq08hsx/8or8Vu65qUe6Tp2dKJM2bqX0ru
	VYDt1Rs4m5l9YwxpOOeGYKU7ssDohhop4/tJCM9uMeQ3AAs1fz3xkVbdWn7hEfNyTdRf4urla8P
	+AoSp1jvRT6XCHwonNw8BKZMdIELYvY+BpaI94KxI8v6lmIh+F42Ve6FGx3MPHSvEsUeQYZppLc
	/jkgF+VekjjEU1pWAXQRpgThdJ0MAmtOSD5LfcsxxIxTMfWvVtfWA=
X-Google-Smtp-Source: AGHT+IG99XlxZ9+uxp2MhBJ205wQvuDEqmn37VzSLEzOqZ4cCFNUEubje3hVZYxKPq5nP2MOHQX04g==
X-Received: by 2002:a17:907:94c5:b0:b70:aebe:2ef7 with SMTP id a640c23a62f3a-b734839b941mr74010166b.14.1763228569927;
        Sat, 15 Nov 2025 09:42:49 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd8099asm664941666b.43.2025.11.15.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:42:49 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 0/4] background CAC fixes
Date: Sat, 15 Nov 2025 18:33:18 +0100
Message-ID: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New patchset V3:
1) extended bgCAC cancelation patch to cover more issues detected
   when tested with hwsim, like skip CAC abort event when radar
   detected, or clearing lower level bgCAC correctly
2) Set CAC ongoing, so user mode don't have to guess if CAC ongoing
   For this one also have iw patch that will extend iw phyX channels
3) For test purpose extend mac80211_hwsim and report bgCAC support
  Allow to cancel bgCAC from debugfs or simulater radar when bgCAC.

Tested using mac80211_hwsim, iw channels, iw event and hostapd.
So far looks good.

Janusz Dziedzic (4):
  wifi: cfg80211: fix background CAC cancellation
  wifi: cfg80211: set and report chandef CAC ongoing
  wifi: cfg80211: events, report background radar
  wifi: mac80211_hwsim: background CAC support

 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 ++++++++++++++++++-
 include/net/cfg80211.h                        |  3 +
 include/uapi/linux/nl80211.h                  |  6 ++
 net/wireless/chan.c                           | 27 ++++++++
 net/wireless/core.h                           |  4 ++
 net/wireless/mlme.c                           | 25 +++++---
 net/wireless/nl80211.c                        | 14 ++++
 7 files changed, 134 insertions(+), 9 deletions(-)

-- 
2.43.0


