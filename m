Return-Path: <linux-wireless+bounces-31506-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIOMOU1GgmlHRQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31506-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 20:02:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED44DE06C
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 20:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 299A8315CE95
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A62DECC6;
	Tue,  3 Feb 2026 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuSnmEfo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A52628D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145054; cv=none; b=Z0KD2SW+yUy/2fIhpswA/P8sW0iR3fvwklKKIik7LfsSbjf+ar7mbMpMfxJpQGC4+Lj0tdk8qexCvW50MRlzV/AHGG7ZJH7eQe00kMu0sDU5rbuJ5eMox9J3TAV1TpFAyzV6GmsYIYYIJ9QG+KfyDdrxPxOLp9ZS9fe+flLW3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145054; c=relaxed/simple;
	bh=HOGa73DSHlmk+qMLmsTjR/Runnyi4a1XbLektJ7Q6ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuZrGRGkapixScZ5BfYmt1r9V+PcHZMqhwAJxNgIhxWZ8jMajOr1XBqvu7hKlDGnqgXgs+adCbeVXG+fUgwiU8l/wieeN3REDagaskIlBE/zUeUv6D+aL+MzJytvwLFqxv32dcpDYbSZRMu4ariLrcDRWlcqIky5dOoSg6Q+ORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuSnmEfo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso1075185e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 10:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770145052; x=1770749852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1Mg8m4uKi39aVoM0hZEYbMPcLG5m6gWxGXZ4r+0Im8=;
        b=TuSnmEfo/m+Y7jgeUBdTcCvfpbL1BzUyzs9lU0X6VbGZk8zHkVX0FVY81lGB8WTsS3
         ZHZ5T2Ruq2wgpfWfxgHLUb2wgjA3ptX0f6ZPVfLeNzXVgqi/fb5ENyGkpjzi0TIcdw9l
         0pFyt0t15GUpdsA445S7LD5m0wvnNgQZh3WUf2lUrw2kxaBKGAkl6TXn1JSJve/yb+ru
         0nbWzGeVpIE3T3AOUCok8rOamjY7ViQfvOSpWo9aAekg86n3FODDs3bJGi4Sk6CVOex3
         GhMttlmrYw4/rXQBiy6R8ditqJnyAZ5JXfu7RK5ZwMPGeV+D4DOX6/qCn+nVjUCS+93J
         uGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770145052; x=1770749852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1Mg8m4uKi39aVoM0hZEYbMPcLG5m6gWxGXZ4r+0Im8=;
        b=Viha2Gx4n06gXP1LY5TjBGPk7V0VASvDk5mLocB9HMYu+fM0doUgAawjRjzibM3vhT
         18gQuvHqg2Su1+w35ZrgsSfs+7cpSJJJmzOutUCPSvg9445WFU6Ugn4E6K+jnUVozdA6
         AapDydg/hv+tSDkeAHMr2lGBhzJPneZ95ZxgO3tQxIQhbeW5UgfAuAOzNIiZw1UQmIrO
         o4D5yYn2wMPjovNuKV1lM4sdHrVnQDXdqhklUfi8rRJ5VQbd5VdkOF9bcFkok2fBqgCw
         wt7crIi/60MB7Eq36QjfuOsod3Ma69nmQ7GnEk26JEQXE+AniCk1QHTF8pIXhNKLyRmW
         VbkA==
X-Gm-Message-State: AOJu0YyT3Ys8jWUVg+cvapP0Qdkz4LtK1+gSxCLoo02jdQ56VyYODZzc
	0ENdcp25wjMjttdbOpGCcZvj3nhNy8xZR6qf7mx5TgFu5HQwSic9PT0hLJDskA==
X-Gm-Gg: AZuq6aINM7fxwBszb5KAJrPbxWNijRJQ0fCrGkbkaOrDil5UifiJmuC6iMRR+pzzeLE
	fjD/B3JWWKYTol7gdPGJ6TgSvY0FvbG3+nArtYpny4m1wFefnugpQuWGzQpBQKKJhu8mbcbaVY7
	gcoiaT+XaVcW3nEiIYJfK/AHcLrv/m1Fl/AUqBoUiqS+Hk3XbYzSXHpWuBdKMAsnYRl/5xa6mzy
	sdXECQDP2O6ImLHRxbGnBiESFOHoD3YTGhyEp4jUAJjtYrVNIOzJXBpoGTPrH0b8kx9uSNf3Ryv
	p+CYLLZWFgMaXhDU63ziWpr4MwtCAUO8QxImg+RmdCThrFhuPE4McPKDzg3El8p1PoROKPk5AYN
	ZPhjxdTx2ZyVUNNLUI01/Y2vg0BxE6ohnLf9htv8B8nO2Pr+N+RHej6KqyQID8kPxkujvaFBiGu
	njebYcc7LCmj/4n6x45QMi100NvUvB+CoXOOePYmLpIC6qGwIE
X-Received: by 2002:a05:600c:4743:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-4830eb30bf8mr6412695e9.7.1770145051585;
        Tue, 03 Feb 2026 10:57:31 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830eac4d11sm7773425e9.3.2026.02.03.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:57:31 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH wireless-next 0/4] DFS/CAC changes
Date: Tue,  3 Feb 2026 19:53:45 +0100
Message-ID: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31506-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5ED44DE06C
X-Rspamd-Action: no action

- report CAC ongoing to user mode
- add hwsim support for background CAC


Janusz Dziedzic (4):
  wifi: cfg80211: fix background CAC
  wifi: cfg80211: set and report chandef CAC ongoing
  wifi: cfg80211: events, report background radar
  wifi: mac80211_hwsim: background CAC support

 drivers/net/wireless/virtual/mac80211_hwsim.c | 77 +++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  2 +
 include/net/cfg80211.h                        |  3 +
 include/uapi/linux/nl80211.h                  |  6 ++
 net/wireless/chan.c                           | 27 +++++++
 net/wireless/core.h                           |  4 +
 net/wireless/mlme.c                           | 51 ++++++------
 net/wireless/nl80211.c                        | 14 ++++
 8 files changed, 162 insertions(+), 22 deletions(-)

-- 
2.43.0


