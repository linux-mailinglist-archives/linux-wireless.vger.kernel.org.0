Return-Path: <linux-wireless+bounces-26340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24631B23896
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 21:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6805682C02
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CE2D5A10;
	Tue, 12 Aug 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSrmelnK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1052D2391;
	Tue, 12 Aug 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026629; cv=none; b=c/tSsihAi/VC7JYxByXkp5hlejzyhFybIBvwYUnm7mHFjYSD9xauX0TDGLEv9oF9WzSIxM0+urLvSMu2SEgGgZuSer0f4+2PFtQgShI3Sav2f463OgdQFLWrzBUugtmqaQoYO6EQz9wIRmaE/nDCN+IDibs/BNFqZ+7PVuUw7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026629; c=relaxed/simple;
	bh=doe+EQwdZvZ3zJ1shGIVXgaj2nwKSFmYI1IqKnvoMwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nohZ4On4GcJlkDq6FoAqc/+VagnC4hVidEBqykco9/pdlwvGe2fgvxPg33YoVKnJXtlLosdBXiKc8Fg2aLsjtSKYnVf4niCvcrR9sC3qr/ZPLRCIg1nJwHwcpIkqEhyjJbclqF2jL7WOCok2aBJkXXLKrtWe0ICG3Hb7yHGI9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSrmelnK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-707389a2fe3so53033016d6.2;
        Tue, 12 Aug 2025 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755026627; x=1755631427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGreoEEpTU8K4sdNnwbIToOQh6fh9NyP4XQpOi4Pqy0=;
        b=QSrmelnKaeVQafvEcHpirRkDg3pL6jTlgk84caoUwShjacr2vydnF2sL3Ls3gUC4OW
         E7Mk8PfPltSvQnxMaZcG65QsVGiyQHgXg3Hq2+e72SlnvKRd+ySBzVenicUSDomHRFyh
         dWxElFYLVOitdtVG7k9cVOaj1rm2oq8e8Qtb3vte5Z0bivH+bSEL8q/v6RjDz7gSr8AX
         mj8uthNuD1o6KAjrS7WErkdzaGq6z52y1lQEVDWaLqL9eLxf135sYCvgBJJgj5knYKJI
         p0FqQrbspQztWc2x5BANxbUh/LFeCzZS6Vx32S0fmnGzqu3EfExG3SQk7hJ6xvfKkREZ
         ECTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026627; x=1755631427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGreoEEpTU8K4sdNnwbIToOQh6fh9NyP4XQpOi4Pqy0=;
        b=jlIbSmJR+wtNth0RKNSr4xZ5hbGaOaMc8m0/8fn/kyLII6W4CyLuyq9LvH+7/oJyNO
         DxzzmvCs11PoPPbmGiPATZplSYeETICgupC50ATgll34Zvfiqu1ODett5MhlEMxsTY0G
         C1APrvr0gT0vhMHzWim8Ay6MKaREYpUlWgoGC0j7tW7sld4f02eI6ANJB17bCy2x9gfF
         qSNkyG66N7UrikfPY3BxXsIVvOIP41mx7iVDY/AMO60APYaWAA7WzDJQknoyF1LBXZ5p
         xZZ+hcOifJMjqg3ejt2I8ujBTxS2mruEWx/PDBGNSUyaPnIBYANo3A3N0rZBKBMpNoQb
         4dgg==
X-Forwarded-Encrypted: i=1; AJvYcCWeTscxMFMdJgEgW7qiz70CcqCzVXvegkdS8Vp7ThNb+Z4TI/N9tCsTVN+2Riiv2Cw3SkxNFN6cCN/MBA==@vger.kernel.org, AJvYcCWnDAXp42hglXCUJrWgyXpqrrVVYQIj9n3H6GZFKwuKl1ZcvswEo5ZXoWPnK9Yr+6+XwGk0laX3C2YHAGrb@vger.kernel.org, AJvYcCWyJ5UW0KRYmgF4dy9Jnl71Q0HtugnIhoC+jF1p+5tG6WaIdv02mAju+20XUubv9qIt6s3KLGcy/6Mm@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKG9ZGW8wxqeix2RpWQdZuExseGnq9cdcI0dYzrgq+OwEWF2j
	sqsLMhejJ4h8mk6YYwvvy5QJyRxrat5MX1+uUJtTYXh95Owgrrblhk8T70VogQ==
X-Gm-Gg: ASbGnctQAO8W4jU/tmo2fY2yn4yaxE19AttJ9K0HFpB2tZ5ICBd0wz7EmmaxHbnHjdW
	Kipc4q9KYm33muOxLqhX9I5pEdUwBtQGkGLp8ffjNKAb+RflRZBTevTn7m3QY87BQPNL52nuvxP
	EukXevwuKv/+iY4anG12na5Ucb7s/w6O1KR/BHORFPbXd+SH/mm6dhjdEtyL9VLu7o4KJFtyZxo
	rFsl2DsAMKdxCtpI05Rzf2UKaqv728Bpqz42KaRdK57vKerNUDDdMAwour6/p9aXn1utsZRtbq6
	5Fmnt0kKNTKZqD3yQYu2aH5GWK50lkB4UON3sSqlu46l8rBgBetcn+QjKEqcBI8b0v6QKNnkShe
	BhVc4kM2mr0jasg==
X-Google-Smtp-Source: AGHT+IFd/IfriZUzSDjLqFt0INYQ4cZw/jUJjpWzLxKtqyluSTNhPPtUvlkjuDMp6ycJmKBcAVMu/w==
X-Received: by 2002:ad4:4ea8:0:b0:709:e1d5:2470 with SMTP id 6a1803df08f44-709e884a8dbmr3717836d6.20.1755026626816;
        Tue, 12 Aug 2025 12:23:46 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097e906c3csm101471076d6.65.2025.08.12.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:23:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv2 0/3] wifi: ath9k: ahb: add OF LED support
Date: Tue, 12 Aug 2025 12:23:31 -0700
Message-ID: <20250812192334.11651-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port of the prior platform code to use OF.

v2: use reg instead of led-sources

Rosen Penev (3):
  dt-bindings: net: wireless: ath9k: add led bindings
  wifi: ath9k: ahb: add led pin OF support
  mips: qca: use led-sources for WMAC LED

 .../bindings/net/wireless/qca,ath9k.yaml           | 14 ++++++++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   | 10 +++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts     | 10 ++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts        | 10 ++++------
 drivers/net/wireless/ath/ath9k/init.c              | 11 +++++++++++
 5 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.50.1


