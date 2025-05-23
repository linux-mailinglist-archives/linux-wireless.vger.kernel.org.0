Return-Path: <linux-wireless+bounces-23344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8327AC1D02
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090741BA2587
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D514A627;
	Fri, 23 May 2025 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzV5Abgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58AF33F3;
	Fri, 23 May 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981932; cv=none; b=fKBdAFstrk8uIKY/9bDWuNHJMUmUZHiL9FKTLIBOohVEFlOgLBtqvgDjvgvJ1no1fdaa+tLNGiP6SILD/AfalAokhlsQLanIQ82N+6C4JYdmwgQW4jUaYesa+aM8xUEmVzo0pauJIQc7J+/BV2N3ME0QPXUdXG7zomFRV6Nz210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981932; c=relaxed/simple;
	bh=iczsGgbOp2ghmmrVs4dItJAR6r10cdIAcSuFTkkOvVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mthyXw8RvVmlcqWman2ie1QlYLSnX5AyvfAqtETdy3WLWKe22Ji9ZozT7/uvPPogacZPaId8DkloUNGStUR+EoM5/0ec+vqP87jWj43Xcu7DePMzGFjr94sBH/i/kLxtLaZgIN8fal8aSzcYXC2zgWQECF+3k1qkSr2AgTsn28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzV5Abgw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c3d06de3so6811712b3a.0;
        Thu, 22 May 2025 23:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981930; x=1748586730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ3uQbc8/jUzObnwzagu5VXqL+U22usgEm91G+BMtpI=;
        b=mzV5AbgwCkgT41VDo9Io/Rl/DVLoDpW9iu7uzncN4vjKLW0QXUyK8zVvFcr7UX9zjk
         YIBvsXeGLSGJI53F6e0026QOr3oDf4duq/5hs1tNm9arkLTzn4UfmE4IZzuPnbIqNhSC
         zNgZ0zhM0SPj/e4aKgdzV8eLKq3aWvk3OWZOTbzdCYDpIwwFNb1KP5aUqcI1BAp6VQzI
         LfQiHD9arBFY6b0OJrWj1bLE9rW7DZToikvrE81vJKCFBg5jW7hVmTutaqs/KXYdng+n
         PkWFKDYeZ5BThLWKdAxCyXRi0WLOJ/AjBVPB7JB+A0wuhMXl5UI9WXXOZA8zYloPIiXA
         kvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981930; x=1748586730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ3uQbc8/jUzObnwzagu5VXqL+U22usgEm91G+BMtpI=;
        b=bSW69XWI6N4h944HAJKewFKliYoRkrziBSiDgAxVejBbWqNz1gzwULwPzOQzqJPCiw
         zMVGCvHMYv+AQBRkqyw71GSrkDrEHlBtH31LmPITsvzCL53fo47kD3tKTAwmc3835FYV
         uJuEoFX66iRR/iUGZGeXZAod24Uqh3eqt0vAU0nfz8ww24/D6S7h3wLCZEth3UyhyFQI
         tD3pZmt4GHK5WYf5IYv1qnvpYdF+Wnd/U97S8HWdSeZrObMbGZGAlRHyVqHQeHEnTx70
         ELn2qp9JZwXVNmaxOieMGj1UrVL16uq39fy3nrNPR135ZSrDkJ6GG+GoI/8kRSqg+TZu
         SyTg==
X-Forwarded-Encrypted: i=1; AJvYcCUBmgofFWK7vmstSOImoGGArTlc9LMjEXstrMPa7XtlK2Rvjkldj4b7Xhh75aM9RWJbf/lOSk0nKUKoHg==@vger.kernel.org, AJvYcCVoVawzc6Gngs7/kvRial4qpQH9FZe5vcAHSX2o17joP6fV+vhla00Ieepa6Tqb8j3uCk09Gy03mKmEu+mY@vger.kernel.org, AJvYcCWFd/vU0MZ5QYEDvmZzVMzY4rCwQDhvc5H2RpbuFXy+cTTUamXGGeKkqiU4TfT4PLV+aJ4YoEQuFw3X@vger.kernel.org
X-Gm-Message-State: AOJu0YyDtcQeHeXcsOJ3FlEK+DK0VI8xAOV82QROiXzULZp5Ky1eXiTn
	d4nxjdKCD1wxPgourALT2yWz1XnJ2EP2bP7UpHgi4444m5dfv0aq3vQdVM0zVA==
X-Gm-Gg: ASbGnctIbCtOHM8vIdvA/9HGJIAghRoyCNOwPIGs87ac0QTQhD7tcHS2qJaZ8+yt5pW
	e+pG0fugQ0xQlrs8Mw6mlW4zBycuz54gLk+fDb7vUxEkCe3btu+KPX+pWItm3yxGD2BG0xy10qE
	K7folM2g3dzkNkQAyCWxo5yoVtftzyBzJl6iJBLpV+e8XWGap56ezTYAvtHY40fGuo5rMmyDOuw
	1nZsrZlBrJD32TkYhE8qyzTc5I4AtXUlvfZpQg6AM1kfTV6MIbfZOsSh7vy0txlg/Ef2jcy8u7i
	M2DZGptItVgAWUdWkFRRX5ziJO0=
X-Google-Smtp-Source: AGHT+IEi3OOVNro5y9f22mFvO5EjQRMJ5a/Z/1C5GltShokVPZZyPEEcJSSFjjjMZgN0h5D6GTz2vw==
X-Received: by 2002:a05:6a00:c86:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-742acc8ff71mr39363528b3a.4.1747981929616;
        Thu, 22 May 2025 23:32:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm12177783b3a.78.2025.05.22.23.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:32:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@ndb.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 0/5] wifi: ath9k: add ahb OF support
Date: Thu, 22 May 2025 23:32:02 -0700
Message-ID: <20250523063207.10040-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First two commits are small cleanups to make the changes of the third
simpler. The fourth actually adds dts definitions to use ahb.

v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
v3: Use qcom prefix and wifi suffix as in other ath drivers.

Rosen Penev (5):
  wifi: ath9k: ahb: reorder declarations
  wifi: ath9k: ahb: reorder includes
  wifi: ath9k: ahb: replace id_table with of
  dt-bindings: net: wireless: ath9k: add OF bindings
  mips: dts: qca: add wmac support

 .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
 arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
 .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
 arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
 .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
 arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
 .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
 drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
 10 files changed, 84 insertions(+), 41 deletions(-)

-- 
2.49.0


