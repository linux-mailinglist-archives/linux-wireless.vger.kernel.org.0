Return-Path: <linux-wireless+bounces-36962-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHmmDmRnFmqLmAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36962-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:39:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34D5DEF8C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58E13032054
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 03:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668AE380FCA;
	Wed, 27 May 2026 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="nUmFYeUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF73859EB
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853126; cv=none; b=chLuQWeNxijLiN4DRaBEXZejVxwNnWIcTFeM+tpJF+E8WSJTiiLSFDfw+uEL6BinhADniQmxJzp9n2kJJP1p6mLHBz2dcP9przLhM9++eBogcD0BDDmIXGqqKSRljwDifeDq4/qaU8gM+A5SBKDmlrTn2ECaxKdPcZ3xrOkVwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853126; c=relaxed/simple;
	bh=5uZUx07G2zwcoT0aoagtkovCaiTw4aeibh5020b+2RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEHH7FHxsVytXsKLgXq+npTlfnp707fDDMNbKn23v6hrvCzS5zwcP8vcZwTLyxx23o7iOdqGOccROxP60FN8gDUQ7/moVx3QqTVKdh5HQcmSUmPGVyZgfsrBY8RSf7D5UBsV/PxZqeK4teQqR0SAlzWxGHLgMpsdurw15PT2XFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=nUmFYeUB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba17c8cfacso118291855ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1779853120; x=1780457920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B54wCG9wETz3n5/AR5K11ZIhUl2C7b9+5WPOoeaBk0c=;
        b=nUmFYeUBAugQBR/dLYs1MenvmOKNGI6qLzg5xMCn8G1qKs8rfuzJfi2a44geYbs/p0
         /VurjI/y4sE9qJ5EIGg+BUbJZTHj+DmuDNdw/MRabcGtN3Ch+wHnWIl/4gchQ+CAfjse
         hSO0ze1+ngTNU3L9TKwayroj1YvTzDyol9FaJcHiW2mAe3u+h1i4rhKCNv422rOhv8QI
         3PkKL74bdopOTorSfvhmI4jnFUFIQ8u8Xq3HF7k78aFV1WT4gG6AcQCW4DyFiJFVRS+h
         o2Y4IIIL94RZgZhPwMQG6u1cSQcG9NqBEGWHr0fEjP7F+uWZNSUmyzLiiLbDvqUCUKLm
         FAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853120; x=1780457920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B54wCG9wETz3n5/AR5K11ZIhUl2C7b9+5WPOoeaBk0c=;
        b=aVx69dONfHiEC/0Jt1u5IxtC/HbsHP4c+yal/D1cAre6OyMyIwI6spHg6tm/AJZ+Yj
         ZCRov+hW2h5KMTjLUJL5zxmJO+1cfpe8ii9mvxWm2tsIPGUMCmT37JjuKZQSBYWYz3XG
         nweDk8pTrPXq8tXeXHImuLuJwWzdxcpmz1/VRNpLnEBziCZeQfXiyq5wUSdvr+lJsI3q
         P1uygsCZqjQtfBRmhbh5GU1x3OPlEsbe7zN7osRyngESj6ul/5wegKNCxEkb8BXilJh/
         fXknNfiLCMU3DGC/3wp0x7vhkg7mlMBzw9RAbm7Ot040DdWqf9o3YznCzJUiM6bw090f
         NESA==
X-Gm-Message-State: AOJu0YxypGrSRP2Ms22L9x6Sr65SxRzMEpCuOeX9x2QVx1a4tWuwM9CB
	weXBpKEO2aXBZk3zZJRBRvlIbIqPdEZ1fz4kEliKdlW1NuXp6QXSthe9CPYVpHlbTBDid5oB3PE
	C22By
X-Gm-Gg: Acq92OHSThluSOllLZSFRpa4SuEYcaux5be6SeaRjBoz4ovSD2d9AvvA359B+OMqYBH
	l79bkvxMBrYOt9xd27ZAZEv69LKcZ0OqlmOfQAXZhJekg6w09Dt6sMvCweLw3fGINIX+Bs2ITk5
	6Sn5v/crvijl6MJt8iuKZkI7edRH/d2tA1J4FCxhC7gKpq22EWUdlqhR+aPboX7O1AX3Agx1adL
	GYB22bhAWA2iiuyPtZTWdl1d7e6PLF3ALDEzCuuz6KECdVh7GEo9xdYcLb9u2h5WtxFEwy7FzA8
	1aTZhhUcUIMxqhtcjc+UhOD3RATBY2raw+EvGrbfdduSiorR8M/CzlOypIFQDhXWt7YU7NYDNkB
	0Sre2rjlt0pThxbH2NbgqNEYA9PWndLlo4nyV4ZTIjEWVnVMg4ugDGX1CyDXiz73rQwFg1kbEFI
	EP9ODQOQX0T78tg5OFeMVG/wHr0mNyKOf5zYlL8b57c3Wz8Rf35RhEPUskOtDx15lJL44xMH518
	1urQn4Nb+UVopH/RVbIo6QmYooPOo4=
X-Received: by 2002:a17:903:1a2f:b0:2ba:7749:f89a with SMTP id d9443c01a7336-2beb035c500mr223646375ad.11.1779853120555;
        Tue, 26 May 2026 20:38:40 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5924211sm127970475ad.84.2026.05.26.20.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:38:40 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 0/2] wifi: S1G hwsim fixups
Date: Wed, 27 May 2026 13:38:26 +1000
Message-ID: <20260527033828.183821-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36962-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro.com:mid]
X-Rspamd-Queue-Id: 8F34D5DEF8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some fixups to get hwsim ready for the new S1G tests hopefully
coming to hostapd.

lachlan

Lachlan Hodges (2):
  wifi: mac80211_hwsim: don't run RC update on new STA on S1G vif
  wifi: mac80211_hwsim: modernise S1G channel list

 .../wireless/virtual/mac80211_hwsim_main.c    | 61 +++++++++++++------
 1 file changed, 44 insertions(+), 17 deletions(-)

-- 
2.43.0


