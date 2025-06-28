Return-Path: <linux-wireless+bounces-24638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7D8AECAA4
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Jun 2025 00:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E485161E58
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Jun 2025 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997623F299;
	Sat, 28 Jun 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8zBX6H7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC2220F58;
	Sat, 28 Jun 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751150047; cv=none; b=pJXw+2ZMowZDiTtQByy0+2AYo4GnJcB1WJjX5TSPyMLIBopp3p+JdYiwC5RCyMAj3MYJHocglzDbKyhJ01WL70fTSKCalRYEya8+m0w6NkpV3BA/rBtyNgK5i6D/llF0yqbGaJxdz8PiJskFF2QGlNy/0JoIfbmijR1RldqhOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751150047; c=relaxed/simple;
	bh=5ie1EJ2oP2f+6il2Ki7zMKtu4rX1ah1GBZClm5w825Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXsXov9XxVsIkEMq1kXSJKJd3Eq9OOVywVAg7F5tcRkX8g5LQ6X+RiO4knnQUI4x9c//lnTH6NUNPUtL2oWcrkyv0vZh0v0KK6dNzFtZrx/vflwqmUNxnpgwVHGBMSrQRiPlfxWJJpGXPEvt0O8jyOEPHEYF6hZC0jxskPhJu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8zBX6H7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553cf020383so3565458e87.2;
        Sat, 28 Jun 2025 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751150044; x=1751754844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atihKq/As7Ya1frZX9RRriCyzwKL57gVfEKZqQSlyvo=;
        b=c8zBX6H7ldGEovgN74FOxO9iq2bLvSpm9XK5B8sztSPD0kJxkFBp7AozeYa0Dro8iV
         1Us4Wf/AT/E50PpGc07KwVz6xlQbeBr7YyLqVwGddbuxPhxn4F3i+i6yURzZCVeXxaN1
         iVGoFKqvEYL0aVnGJSyJFOflOLwEfEFnpNZ+RYlYDeLsf1PevFhzB4abok3BB1WXRBJ3
         op47rSymKhNmNoqUQtFFf7wmYDIzxfJ0eM8nv2O6253LKrB9yMxj2Hok5XY6QLrNPYGr
         7GT1FfnJSRLSaB8+dPNAvhx3RbYmHLNs/O6TIzpIjEPx5HNOGJ3Zk4Y7Z6DCN+PCRLCZ
         risw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751150044; x=1751754844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atihKq/As7Ya1frZX9RRriCyzwKL57gVfEKZqQSlyvo=;
        b=hpequ4M0ONa5i6AUFOUnx3+W9zvKeASYCI+zSHfpBi3rJCP/3d2jyt711WcTJh1/HD
         QoXHuew007vI0UTlJI1GBM+cM23BMDYn1puvfgoKTY9QoDrmYbzrho1e/UwLUuGptkRv
         0kK/A+gEdO71BDrqkcJu4H78URqlEecukIRVPXQuhcYKNLgF1/fr9xvDvsb/jG/T7noH
         qpJzxALrtkEyflLXLzjN16m+h4pmX8Fn1NtwEBqBaIY8/h2PULqkg6JQPHRsI+trpWL3
         fqacAyeqGOomHVro0bbVr0b1Z6xqXehTMY1a+ef8CSmUMGHHFWHMkt0Md3Pz80n1wH6j
         QrJw==
X-Forwarded-Encrypted: i=1; AJvYcCV2rOmiA3vW78rrMixpBE6NpIrX/mYies6jsRQ2SOeI5q2/jHYuG7w8qFOfJ2LUsKvNKmdVQosG895JS4w=@vger.kernel.org, AJvYcCVs7dcxNCngzsS+HGPusWM3WjH61k7k2BGJA06jraCWfBGQcy9yzywpmHzw/L2hABrBU032vRCFSix0al3OuIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJM94E7I+eYFozwU8hpUMQllU/RpIFaaLupehIetWXBG6NE8K
	FNgMUHmYLmeB2qrm/mSb8RQw6PF+y4cf8c2FUwQILqvEysCSWmYmSMg3
X-Gm-Gg: ASbGnctYaTbowH4Wox+HzbzbEWRGcTWUIjJis+wj33BYu2+BsG6zF3fMldap8Vq5SYz
	FU+R+K1ZIn153R4wgzWRhI0DQ9s6Qi3lT1sNgszCw3fnBrUu/uS0PjlYfy/VwI1cUODU/tXD6qL
	xXypiK1Q/BPE0jKTw797TdQdm4ZdxPRJGHcerUEKoH6te5HLDXr3qRW0PyWwxgC/QyezKUufs5s
	dlmquc8viiwtcFHsBnIlOX5vBX3BCqf8oSV4QtsvEW81aK+tMyCHohPju+SBxZFFDOTKOzY5RSB
	Z+ILN3ab1LxbyizvxmR077UX0UEeMvnXKRlvrWqBpTzfCsLSD38grNgEuRhGTe997nO5Coqu7zV
	ZhBB3nA==
X-Google-Smtp-Source: AGHT+IHOgWQ+G3h9HShdacrpYNucnC6d79KlhvUQKdRoGhGz41L+0lt6alrVzbGbJJ2XVlLdeu0RUw==
X-Received: by 2002:a05:6512:4017:b0:554:f74b:78c1 with SMTP id 2adb3069b0e04-5550ba209d8mr2628043e87.43.1751150043301;
        Sat, 28 Jun 2025 15:34:03 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24d36fsm936915e87.71.2025.06.28.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 15:34:02 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] wifi: rtw88: enable TX reports for the management queue
Date: Sun, 29 Jun 2025 01:30:48 +0300
Message-ID: <20250628223048.3597641-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for AP mode. Otherwise client sees the network, but
can't connect to it.

REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
init function (__rtw8723x_mac_init), but the value was overwritten
from mac table later.

Tested on rtl8723cs, that reuses rtw8703b driver.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c | 1 -
 drivers/net/wireless/realtek/rtw88/rtw8723d_table.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
index 81020fd907aa6..fe4b112f582ba 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
@@ -199,7 +199,6 @@ static const u32 rtw8703b_mac[] = {
 	0x035, 0x00000000,
 	0x067, 0x00000002,
 	0x092, 0x00000080,
-	0x421, 0x0000000F,
 	0x428, 0x0000000A,
 	0x429, 0x00000010,
 	0x430, 0x00000000,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
index 27a22b392df00..bc7c6111782b2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
@@ -10,7 +10,6 @@ static const u32 rtw8723d_mac[] = {
 	0x020, 0x00000013,
 	0x02F, 0x00000010,
 	0x077, 0x00000007,
-	0x421, 0x0000000F,
 	0x428, 0x0000000A,
 	0x429, 0x00000010,
 	0x430, 0x00000000,
-- 
2.47.2


