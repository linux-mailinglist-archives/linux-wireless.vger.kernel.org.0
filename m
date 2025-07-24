Return-Path: <linux-wireless+bounces-25957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44369B0FDF0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5806D561DDA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEC2E3707;
	Thu, 24 Jul 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC7sTXoo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCA632;
	Thu, 24 Jul 2025 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315956; cv=none; b=IvYdZG8l7L/mDxNF/UGcL9sTswR3OVXc7iolj7q7SrW/kWunZPoVt6NUM5a0wdZhbXPxo91hras1Z2bhwZhp+GcD3+We27rVDFI9krO+dzI2G/Py0V7OJZmMArElPo6ykIayI0DuffmfrJTXuvctHeDA2cDzB2Tag8MMECEiZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315956; c=relaxed/simple;
	bh=XiXme2f0z3wQ+8XYg+XWC2Vf1WkVgtNQf8ffPM76shc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnO8V4a9EuAWhZb4LHtYMQUFGSYTClZn3H8m+ePkug8TQ7qti3h2jkdSjhXu4Lu836/i75VIXALE7WI/T3BqW63pZObuZC6Smnc3PV94ps4s2LZYmZI9Uxvc1CJDX0ZwZyx3wrtgiUVqO0LOJwDYRDgdObHQ7+DgqXg98czcSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC7sTXoo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235ea292956so3357825ad.1;
        Wed, 23 Jul 2025 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315954; x=1753920754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTpTddyuKctNUEYfO0rxSs6K3yAM4P9q5YKhBPu/tHI=;
        b=OC7sTXooGelNd/n0alg37Nt1hz7c5xV1YZEeWvYCcyHDGwuQgDzOYfrTYTeYWyOo1i
         BaTqBSajPUw/Sl8rSdNsxZAo0xuBMZeaJI9dAQqdxrXV0qOq3gatAA1kSWhNbaWb6vtz
         78bK7xL0uwxgJCit/r8IG5pXy254+qrJZqZ5xd7OpwLhVs3tierUDursHYJNPqzRsmJE
         PF67N2LyTal6ZW9ejBdyPA7nCVCtXCUgulJUcX2OH1u+oC8D4zjUWFJGqwZdAS3fpXeh
         rWvAErGIYfgU8mdDljfV/dKU0hUhfVf3jiRbxiZhaDSe7fx8sItXy1TBvyU0y1homPol
         hMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315954; x=1753920754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTpTddyuKctNUEYfO0rxSs6K3yAM4P9q5YKhBPu/tHI=;
        b=eZsjPF4lxoWi+SZ1CWuHuKM8hgp/299Nx/3FxwStig8aZZlZhyCz3+yp0m8MMYS4OQ
         CsGY5NNFMYMffHuLCmwpGI6janq/eBUX5aG7ijFv4X+rIYrg11jMO0R+U8ar2WBgzzk/
         batqP6HFq9KxBhGwVCUl2Oir/dtNeo3TxlmQaIeFnFcvqefHjxriPcL+5EJKm8MHp7xj
         r5VV+vf+0q1BSKpiG0duZG8e35zppIS795T3HwSyT/vQWotFj+9VJsbgP6H6ciQGCFTo
         oSjkfpCYSEWYCHYumbvjZoA4H4RlWFHpDrTaiita761VBucXInlxzIymw7zp8qW83xBf
         CB/g==
X-Forwarded-Encrypted: i=1; AJvYcCUhN7Vfw6+80YVaakiaWZTMH11fxT/ffxGbzNZ+Z9bwNeYsXJQbxnwqgEF55kdcieRQxHMixLCmj8bLow==@vger.kernel.org, AJvYcCVJwtrXeO1D+1m6i/MivAE23oN2mnT55Z+zXhnXgmuCi89qz1EtagkRhRaDknEeghFJBRHjmg1d6sxKSM3S@vger.kernel.org, AJvYcCXW6hL6ABq3IbDh2Acwum5UoJeFme5yfqmI6vvezrKGBHhFNNtbGGKqJNOINBEnewlFJs9SZQ/ObRvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgcPJkWzej9dv4aPfh0fmdFd0//7b/dwEI3WaWpdMZt41bVqf
	i7afCFSn5kMqmh4bCmEkVtQr8TfPc/ludhk0mRlQrhwqL10DNYWwGvtb+xbXvKwx
X-Gm-Gg: ASbGncsOltj7zdVZSOh55rZ48Pk/BHXz611T1GOwIpwERbWsdhJLJld0pzpFivX97Ys
	vcdltsm0/NsqrUQcpava7QloY2Y7hbuCGQJqBsgnvT0ix5MZz2apbobiP4lXKDiU+/37VW02rds
	sP/BGi9HxWzuaWS9mxluOSe8cWP1eJVP6L/JhSsSDgMGgEBNrrV1+gh/lvTF04BIonMSktqyhz9
	SdTMJjKxmKU5wkZKd6tl+vDSId577pgvL7AoDaeXIeX5uGr/mFqJtu509PiPDEFwhPmJKsTovwe
	Ie5e5zC3QMT451tCo6ASQ6GtHUs1QTnpSBRfW0LMUv4KKL/1yvZd+bOD4gu69K6hcdDRb8cilOr
	qA7G3YaJ38eH78Q==
X-Google-Smtp-Source: AGHT+IGHLYMUv9LEcUD43PYfTGsYmU2avkpWaUUoLGqpbY/ygtaMwLuoC9g6d9Uoq4vQdntros2eGQ==
X-Received: by 2002:a17:903:198b:b0:235:e942:cb9e with SMTP id d9443c01a7336-23f9813ac30mr62978905ad.9.1753315954220;
        Wed, 23 Jul 2025 17:12:34 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:33 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 0/7] wifi: rt2x00: add OF bindings + cleanup
Date: Wed, 23 Jul 2025 17:12:25 -0700
Message-ID: <20250724001232.2275-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
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

v6: add missing Reviewed-by tag.

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


