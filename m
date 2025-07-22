Return-Path: <linux-wireless+bounces-25877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E22B0E56F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1621C874ED
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9BE28640C;
	Tue, 22 Jul 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNGjIj56"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036038DDB;
	Tue, 22 Jul 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219740; cv=none; b=LmyeYZeFYmqM19OcKwawqH7P9JEtcrIi0/ZI3LMnF+phBHcyqwOorETZLONcMb9kO2pXFwK6/6Yw7VfhDA6OWZySYcf3Sggknd6HMvT0zliMccc/Uj6OAVLrXjldmpmJ1BJ6tNkjEHDfDa/uDrbXljSAHO9GPfvcxX/Y0awIHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219740; c=relaxed/simple;
	bh=iL3Cc8xg7BQi2OW9rzWQ+J9fwwH9zN9iT7L2oo1EA84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oz78a4VLWyo98HYmKXceoCUaSzOCp6LLoRs7jDuuOBy9UKeHkREqFBjjmedJL6CIxwL8j+Faa29XcUbS9T4KEcXJi8Vzx+EUfrh3PnoHPmdIjj/2adKUARWoLuuL3rpBxZlsOksiEKMADwSWdqcdn4k2xwV7YfTlsbB84NMBU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNGjIj56; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so5095252a91.1;
        Tue, 22 Jul 2025 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219738; x=1753824538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48867Pal/1jOpEz3/91Ogv4kveVZARbA4EPs2QFDNFE=;
        b=bNGjIj560kRivo2U2Tc7Fi+LqojOajXt/dViWJLFTbzESirPjgb6z4SbmvRvLW8RPL
         syA5uOcrSkK1QqFLe9bzh9lqwsQpT30Gxl9kYwPsgmn2L5KJuLGZKHc7pq2j3kg5awU4
         ZThS/xOL6guyT+xusThsMOV4hFMJ++gIfeTh+a+e44aSEP0bKdsdCwHK+n/UtCRrGyKN
         pGtcxeG5U6noyQvKBEkVjFkC62s1n5lbHuflfDA2OBVGBvNeW+D5dGeU+Kik0Agv0bSv
         GBo+TLAxPQXou4BsrpTwU3tCc5WAi1LQyEgUowJagztsmZbQiPej+om20GleuTFrxidG
         UmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219738; x=1753824538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48867Pal/1jOpEz3/91Ogv4kveVZARbA4EPs2QFDNFE=;
        b=NHd4vEtxNeBIVrCuC7xxbOlsGsiShX7CAPJ2V80ThctUeYT+0gU5T4QtLvArT19b7P
         Y8vcuXMXbiOeWKjS7f4sv1OY4yTS1Q1BIvyZohnY/gHrp6wmYVRt15IAj4pskpZ3BuMx
         5iLQB9WE2E/cJLpWpichIgrYn5KhtUx9bYmHKLZMYbMGpLwedcVRdgn9nrT85dSX0VQP
         wHECUuF26D7E8Qo4LyAev4vOpEeErn14VK/1Ht99ojAh36YrVobq1TkH3NSC5FYOlmh3
         pK1hgIt3wSfrli10nx4jQh1Tb3N0FBFn5N0PfIvgQSCpphiqFCKwJqmblnjzHeBpHr7E
         3/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVTmKMy0Dd3Bap6Yi5ALTUwdKiuMwJ2fINotgGE0dy32dteWwEXrbvpEQeijW1hZ+SG47SkVnSAicJv@vger.kernel.org, AJvYcCVxlqWbJSfPEP3tSujufiZXMm8FfM9VsUy2WnH8boLGXnBxDCK6IbDkbcY+GQfkIqiuRas3JcRLMLDDww==@vger.kernel.org, AJvYcCWOgRWKK5XRETsNlVZL5IGEQNeJoiM7qs5FOGpZ3scS8cmQnFp8EmGNk9JJw4mSx86Hxdpyfgn7MeNmAI4U@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7E1QwgDIRaYWyCd3rFrHQRHfZ3XkZDjuntAvKspkvVrQLfbTZ
	emX5oH5xqxNOk3ruRXRa+PA6nWgqJmpADIlo9TfbWYxaOL0qzIA1HO/B+l8a+1go
X-Gm-Gg: ASbGnctW2YQ08VHHvFwfyYLp5K5NW61TYh7eLuPWuRTMn0oOLP3xvlbEJK6ZXg6wSts
	SKLQCMWG+wEDGDlVYoIKGCycnVF4HPflhZGPscq/GDRBlBtIAhNvnjLO8u5XkZhKJJ9LMLT6KCV
	9BNl494YctKJAfQeRbSfwqs/liqkbNYH7vTyz9qJKS7tCNujC3+Y55zJ9QmyWmKKWbAnG7wbZ/t
	J/HwD80FhzfjoxwVQP4lKk51Q3v8uLMPSZ1uYl1j7CddxQKpPQTf1cclD+qh8art/vLHJheMnkP
	N1lOvG5CYfXv383jMwO1KAqB3UEalRatIPX6bsCIKlyWvv3vnIcPszyaeCoYMvkMVR3mWMYKDi9
	3mik=
X-Google-Smtp-Source: AGHT+IGdeHskm5Ee4Q3qMconqScb7wNu5KePjyblDVvV/Acs8WP6sY23sealp7liXFINeKE+T0WJQQ==
X-Received: by 2002:a17:90b:4b0f:b0:311:d258:3473 with SMTP id 98e67ed59e1d1-31e5076a94emr948092a91.13.1753219737973;
        Tue, 22 Jul 2025 14:28:57 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:28:57 -0700 (PDT)
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
Subject: [PATCHv5 wireless-next 0/7] wifi: rt2x00: add OF bindings + cleanup
Date: Tue, 22 Jul 2025 14:28:49 -0700
Message-ID: <20250722212856.11343-1-rosenp@gmail.com>
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

v4: renamed documentation file as there's only a single compatible.

v5: made clocks and interrupts required in the documentation.

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


