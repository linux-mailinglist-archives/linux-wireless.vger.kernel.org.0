Return-Path: <linux-wireless+bounces-29257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3CC7D63C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 20:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38C5B3515EA
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BE2C11C4;
	Sat, 22 Nov 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODwVJJ3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013228727E
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763839347; cv=none; b=Ef4XQObPWRM1I53QjuxzWohieQOHsUPTNK2sY8zFZjf0mKOETk29yvQP7W7K62EOxK/inTKdDUGcaImtTEbqEp4HD6PNe12lgTLwRYyoIBIz+w9ud/8a69LV8yts7bgwGTTJkNF9dJ61bNZjLsHiTWtYXXMtoApzDUwTrHrnRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763839347; c=relaxed/simple;
	bh=vzWYr77Lw4i+lnLPudFWFiHKqe3GTkRNm8Z1R+FZ4BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1pMmfyR2YBjmPHNK0JQ9xcQ5qo4/iEz/rhiOeTC4CZQKHD41atUsa4Y/fkRW6cxXn0rpvR8jnVs9gp4evJbHOH7Ez7XW0Gv6pgW53PWaXJwedKg3mFkWzKlXzq/+NPOSeZ+CrkRiTuTOMMuW5ahBLINFXuLl+ggpjTiJ4PQdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODwVJJ3V; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so5179125a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763839343; x=1764444143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0hrOV3lyNr6WMG3TksH1+AZYpbZBOorGv+1K1dsn9A=;
        b=ODwVJJ3VPsb37U82TDt4kiFNMT/i+iqSAYv6ZFeLJyfcVdYM1jCFk97++18mPleFfq
         GIUy5Vw325HHEjWtTaDCy0z4iSjxMv8aHfgOzhX8t6pyJkS/G1qhiIV3eqbUg+XGc0xd
         zEwgg6A96TFpqm0YpQ+ymcnCAkURqC9PcY8RTC9mu942LCjbVMJa2IZSAUxEpdPcnjiR
         Kck4FYDL8oTu0KTWlI0BjYMVnzEg0wSmmu5tgAKAbpIlFnZGggKYZjPI1rjOBZo0tSWc
         m9ajKy2+r2E63+bKe/sBwGIMP9G+hV/1FxRfWJrKpFtYSRhZ0+K73aHh3zraH3I0RVd2
         P4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763839343; x=1764444143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0hrOV3lyNr6WMG3TksH1+AZYpbZBOorGv+1K1dsn9A=;
        b=EsnqHSYsdvu7keVuhJeAk20IpnlLJLKMqosw9WHMcoMDsbL5oR+L6qhE/DDNN44Ekw
         bBIy80Z1nebpw15o1Ze9xnM5gELXF7ecqFrlR1f7NgVi2cIkF0hDwc6aN+86CVwqbkhu
         WOWqvN8tjJekV3dQU3EAmM1UVbdUyAlJTqYjTp6V1uRBm4wfLfmpKwgoA+qgfhtUanIc
         i7Vrvmy/aeyuYUgWlXZIMKtCfkIrwD6o20drF1E3yX8Ucfaqdf0tJpIwyPe1s2yuKc4b
         BJI++3KCeUSSF4ygWTHw780UnRF81sclc6zU9sm4STRe2EoNAYoOIDfjVP0INoKOQD5r
         3xDw==
X-Gm-Message-State: AOJu0YzqIxY/WcP16MBRG9A1A3uWyFmy4DrjfxMLqyPwlgnqUFVNeEmU
	QCITrd/5llMcK7s3kxX4ZiVnVMh0tYBDvjt4K8f/3D8n6blwi6egYstfZK2vTtk+
X-Gm-Gg: ASbGncuxCslXm+m7WEbgd6cYEdR/3pUIhc+97ShSuHEg8fCQDLUJUZI8fUjZBrMwGeo
	3QiH3YSz8VX4BW3AQz2Xvk1NyLHQaytIz31MAZu6Gd/QC8bnVTDy/Hi97qRUC4xrkIv/u0N28xC
	BcnGGXVbNU+liWe2clkWMMesdxcCjeQS2wXKog8yJYnWyTtIDdBu51yOUcEo68cgwmts31mNCmP
	7VXKQqUKi6Y0B67bT64zfxSPKMYzSlm2mHWG4T6bx/srOPIR2onjtTrPPYJltzGG5tfKDD3fGTC
	yVMPNpcLbByHoV0mPz3QaQ72iUTZ9bKUszYy1TcQ+HBsNsBQSNUjv19yu3Q7iV+sCyuFlL3seEj
	HcWjIiqy1MubRbEkE9aiIdeaR0peHrTfes1IVS/8dpaaQir8iCEzs7LUDg4sif5tJ/SBIyUCa5X
	t+4yBK/0jF7y4hP6J6iAXsd0rIKReA7/Om1r6H5TMHm6OOryc084o=
X-Google-Smtp-Source: AGHT+IHV7obPsWpdJV0FlwZAvQCKxcZbMqOtp99Iu5uznzsA/GEI7KwSupyfF8kH2Dm4tu2+6Hy3lQ==
X-Received: by 2002:a05:6402:35d0:b0:640:6653:65c1 with SMTP id 4fb4d7f45d1cf-64554322775mr5910313a12.5.1763839342743;
        Sat, 22 Nov 2025 11:22:22 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm7517378a12.20.2025.11.22.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 11:22:22 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 0/4] background CAC fixes
Date: Sat, 22 Nov 2025 20:17:02 +0100
Message-ID: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V4:
1) added proper locking for work queues
2) Added Fix: description
3) checkpatch fix (--max-line-length=80)

V3:
1) extended bgCAC cancelation patch to cover more issues detected
   when tested with hwsim, like skip CAC abort event when radar
   detected, or clearing lower level bgCAC correctly
2) Set CAC ongoing, so user mode don't have to guess if CAC ongoing
   For this one also have iw patch that will extend iw phyX channels
3) For test purpose extend mac80211_hwsim and report bgCAC support
  Allow to cancel bgCAC from debugfs or simulater radar when bgCAC.

Janusz Dziedzic (4):
  wifi: cfg80211: fix background CAC
  wifi: cfg80211: set and report chandef CAC ongoing
  wifi: cfg80211: events, report background radar
  wifi: mac80211_hwsim: background CAC support

 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 ++++++++++++++++++-
 include/net/cfg80211.h                        |  3 +
 include/uapi/linux/nl80211.h                  |  6 ++
 net/wireless/chan.c                           | 27 ++++++++
 net/wireless/core.h                           |  4 ++
 net/wireless/mlme.c                           | 29 ++++++---
 net/wireless/nl80211.c                        | 14 ++++
 7 files changed, 138 insertions(+), 9 deletions(-)

-- 
2.43.0


