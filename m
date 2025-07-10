Return-Path: <linux-wireless+bounces-25221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C77B00CB9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623AE5A21CE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E292FE326;
	Thu, 10 Jul 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg2yvYm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64D2FE31D;
	Thu, 10 Jul 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178104; cv=none; b=ObItJcWVnofEalVHJXSnKUgO7xsCUz1a66eF7drgu1XnesxUfwuzc7PN9GoD+W/LmPluCrP9IKozeWE+2p5ztlNT2z18rokya2cAAgz0HuslKSeXhM5JiUHqXKeZcM3fpRfwozPfRKl1UH/q5Wd7+J6vNn542ag3VO1HVrqho/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178104; c=relaxed/simple;
	bh=9t4OPbYbY5OAsvXyO979yIiDGecVNk0IR7O14ze/28U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FotW60W/Qzsni9h3X7SQdBzTk9zceb5mc7BaR6+gvmj/mVNkfBrsNBvGu5QCgJBfl6X6ikNyH6/6zqx/6G2JCUpc8s7d2SAocxo6RDMD5LarojUbBcVE7LcIaSe8oJN4FriwybHYiNeBaPeAUc3d3msxEyB7tNdi43lfbuEuh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg2yvYm4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74264d1832eso1982067b3a.0;
        Thu, 10 Jul 2025 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178102; x=1752782902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrD6G6uWm4iVHDO8rhUuewFU126DhR2aJytxsLn7Lp0=;
        b=Bg2yvYm4dWuERqQlZTpu6UnBnAdWhZTmYRcZi+5TEqyWCZsA1prpuSHczl8YakSaaE
         ozFqYDoLL+9Z66Yv/GOFZxZl6Aere2OFX2w8AZ9NKSQQdHLDd/Yeq6YEyrPqJ6Wycoae
         Ym00kMP/n4+tkiIfSccvPBD9hPgXAiS5kTQs34jDPTdezFoWPm4YSLs3r9wXVJg36mpZ
         mDIJYFW2Tjbljad/mJjQtZROz8Zhsnu7xUhreiqUMVsrBEAPnpGIGZ2ol1zDWPeIORBa
         DNmw88nSibjVi6TFqONfM7i9uGz+nX6CDmuE9QAZtA7xqrB0LNd1VD/ERBxGeDXzIejT
         gkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178102; x=1752782902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrD6G6uWm4iVHDO8rhUuewFU126DhR2aJytxsLn7Lp0=;
        b=AEf555cGSxXLnmyRdmcXt+r64cq2fTqwHXRi+QViRcJjK6gSUGGAD+Jg+idn9ApeQj
         snhUgh1ZXRh1DqSvBAez1y+/GPR/H7gMyGa5k2PvJLR2zm9hfVaiH9hkajtMvBdp8nBl
         3NDBiefxFS51bJzL0VKMk7i3PbPQifaMKdm2QfjAd8d783IFuTWPWlQUpKVzVsXQgj1G
         1MMocbANndHY2miSsHL82iY4l0tIPUOEmi5RbuVVPd4DPbQ0nYb5y9sy6mG+IMyfBb0H
         w5SV9WHm9jgjfC77qslUY+VlStvikoxoIn7YRjYwmPIuxKxGaMksR6Hc/fF5wWjvoxa2
         tWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaXdF4iFzoixAdQVLgDKN52ahUMK0Jqjef5CYzjvTdMRKeuxsWohnquwxweCH1wPd7Ol6/GuuaTBgf@vger.kernel.org, AJvYcCWIwyjzNZXltbI1n4GSx92MxqtpWrAEFWadF3Kk44vWPUH2lqeI9Tfzy4Pp+L/ClxxFDf1Hx/y6LwNlLA==@vger.kernel.org, AJvYcCXuBRtme595yAVsQmAB8NFqlfjgnUWvht4vU3tcGw0E6YNWc+DP1RMMbCb3VuiFvB7NlQIEcI2Sf/eWhQxv@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHq+rA4nVzV4qO1gMzBk5Npg6EgmMWkILb3OkkDqkAuYuLeFZ
	A/b/X7kVd8ttMi2Ul2IYLdiYkn2BelJi0ImOcmthbbJDG/LN140uKY/waREYyVPz
X-Gm-Gg: ASbGnctoNyU8HOB6cLSUR1q8IQhkpsEceWyRy48mbPZzJMoSjTmGqwTnm/GJ2mJWWkT
	xyPKkHoIHcijwUsDbs95VjVTlWOLu05lNrnue91UUoxSlxzmxbJmJsfIwL9e4GBrjd9/3w6Dc7Q
	fU2DtnUyNvW5AQJylWgwKaeC7tkY3d96c3iLcZmtZwaZU/l3I7De8eREGdyfVDcdRslUeeaBkAK
	urxdhjF0hDFAxusBluPkCj/3wBxHX+Q13RP73KtD/banL+s7LZJ/F7Ga0e6EjcVKi9CuykCMtkf
	Dllkr0RqctKOPle5k3YIbNYmv4Bda4S+7pEY5SeuMDg=
X-Google-Smtp-Source: AGHT+IE6ziDEGlHzKPQcxsHZf+p+xEI0nTizoC/4zeszX1wWc3SyRmkm4rOzmm671Ky9r2t0WlIOEg==
X-Received: by 2002:a05:6a00:1141:b0:73e:970:731 with SMTP id d2e1a72fcca58-74ee2949c61mr396274b3a.16.1752178102166;
        Thu, 10 Jul 2025 13:08:22 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv3 wireless-next 0/7] wifi: rt2x00: add OF bindings + cleanup
Date: Thu, 10 Jul 2025 13:08:13 -0700
Message-ID: <20250710200820.262295-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't even compile. Added OF bindings, documentation, and other
stuff to hopefully this doesn't happen again.

v2: move all of 2x00soc to 2800soc. I didn't realize only two functions
remained for no good reason.
Fixed typos.
Slightly changed probe for clarity.

v3: fix wrong compatible in Documentation.

Rosen Penev (7):
  wifi: rt2x00: add COMPILE_TEST
  wifi: rt2x00: remove mod_name from platform_driver
  wifi: rt2800soc: allow loading from OF
  wifi: rt2800: move 2x00soc to 2800soc
  wifi: rt2x00: soc: modernize probe
  MIPS: dts: ralink: mt7620a: add wifi
  dt-bindings: net: wireless: rt2800: add

 .../bindings/net/wireless/ralink,rt2800.yaml  |  47 ++++++
 arch/mips/boot/dts/ralink/mt7620a.dtsi        |  10 ++
 drivers/net/wireless/ralink/rt2x00/Kconfig    |   7 +-
 drivers/net/wireless/ralink/rt2x00/Makefile   |   1 -
 .../net/wireless/ralink/rt2x00/rt2800soc.c    | 102 +++++++++++-
 .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 151 ------------------
 .../net/wireless/ralink/rt2x00/rt2x00soc.h    |  29 ----
 7 files changed, 156 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h

-- 
2.50.0


