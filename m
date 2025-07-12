Return-Path: <linux-wireless+bounces-25321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D5B02D0B
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168B74E4DD4
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AE1FF1C7;
	Sat, 12 Jul 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbo4sp+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483231F7569;
	Sat, 12 Jul 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354292; cv=none; b=RVRod2zaphJ1gXqC9gtoVvZwVTvZkFW8Tl7i/rMI6oP3+11lRf08nmJrBYNrniiPnoba21N7s3stR+hR+ct1g92x06rntW8kqKYQQLD0ERtLx4vCXzIZOvXRcKHY2EwCS2ysg5em2wmhea3wkL+2ur3Sa7h8ID02fsoEnGze/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354292; c=relaxed/simple;
	bh=JaDfFc1OkxkkhhPGJCgJpBSsFLpVROVnM9WzXAv/Dl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c02EFmzB27eaOfHs4yW+SiyGIkNvkN7FqWwK5ZRecpC4z/YNuch99z6LHdKF3igKDZJAh8/S6NYXMoCaV/OfMbDlPy5vE8Kc1pHJWt9xmyz2RuaW7UYft/8W+7LAVpLcktdT/N9fiYUFcjUcE3XKneCEQFc/Z33EeXvyPk7eXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cbo4sp+a; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1968407b3a.1;
        Sat, 12 Jul 2025 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354290; x=1752959090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfLL9MbScUSlOSjyWm24E58Y3rU7LU4fcYrGg0K5EsA=;
        b=Cbo4sp+auc80usjLNyWyVPb0O4NHXIOJkqy7cokqgVwPouzMWCUX5i6ZroejemW5II
         iR+p2YiTl12ORHzUdYUs8haYs7bFKJdsbxrfarXOjkF0uE3W5qXQZ7JKl6qKbmxBT3Sf
         C//6i9O3l1KxkLL9LVU8y4Cv9kgaekn+tqc0ldV8m6JaUntq0dVlmDfAcxSrOc3vqQUn
         OUHnqRqS30aoG74mZgitiVxVG12lBymnC0PFYV53HJJVa5dzmZ8mcD72jj7ZuzCG+NZi
         TyeRXeJrTxHHK8l9S93lXZPpj6z2YFRwpENOoi6tZ0MoX3FGmOtZ3nvfe3ifZJ/VTFaX
         T00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354290; x=1752959090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfLL9MbScUSlOSjyWm24E58Y3rU7LU4fcYrGg0K5EsA=;
        b=ESdS3Z82dneZE8vjKrzknL/q827vhw0v3ACZosYLAld2iC8bksTVLPWuPob5Fs4wKq
         72OY1n+H8rLWmO3O5whcU9NAfPDjQ7ee7bWmUf7RDVIiG1bLu90HY1PaRd+fhT7FH+Nd
         mBOwhMYnRQIPvTWW/p/5Fndky7GkQ05iTTGNDJ/yhryvBH4NgVjJiNdT65Ap1UmpAsLU
         lI06hBcf7GiAptzUQzn/Wpj5TxAxDduCZNoeGPy4aYY1MRd+xTTJh1dRicN90zN0o1rA
         +qNnhx6jNxlR95+kDiar9XtzhTpHAenQmuLn2KcuV9rI1ZgL2o1acY3jIeHB97+jO1A/
         4J0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHcZUgU/fU5HBoMB31XoHNEXZrN/rNZs5huDUsAqr5NtO24EU/4qB61A/OBU+PEVrnTqv8vJSTQjhc@vger.kernel.org, AJvYcCWRpb+rYyJePEFW4W1zcoXzoUQliifqpSurfnEZxK/OESdvvohNY/HY0bB4Zpo7AEPkw9ltODZNnTq6fkJ1@vger.kernel.org, AJvYcCXHkTjOt4R27gIWlRrEaL55Vwy/t39fbhOzVDS2ndTsmc6ZEoE3vBHIQyCwwAbHIu335vsfGI1KVafraQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhORgXQkpHeBsd5Kyy81sn7gsjyoAjLQDd6AWX+Fbhg1UmBdi8
	N5bwMZ31RhdZhShpDhAJcu6iJ2v9IpE930A9MHaLnXRM/96ltH1YkN6SGIswGhgC
X-Gm-Gg: ASbGncsLPjmrUspA5n/kvLwI5nEDk/vFzNlti8dfI6nv6pILRC7jmiQV2BLVGhmQc2I
	/pSBzq6p9AfvO0O6VQ+q+nx/re/n3hkOnH2WQ+Sp/OypRYQ/fxOZJ6qgtq+ck34OgoFDw/35DZ6
	ydmSwBkuDOz4dfMIAsy4KpG4wnrEJeMKYspI8uBUEnK0qS8A5Y+uMEy/Kw/tLe9NvgNTVSqSlgm
	6JnJ68JW6NHD/gqHddKX81jH4MoRGQkXs9rRsSc0wKIXbCDzQo+JFz1yUiqpwS5UTaP+0fycJGw
	M4tIUAVlYRmgF/4VOHTDoHqUjD1tvlT+l0EOVpRCHYDU8A8oGaiYcjWSGRiV4rZpgSqK1QMU9uu
	FDr4=
X-Google-Smtp-Source: AGHT+IEmaDL+eIW50uO1oQuIKN5GC4YkbvTHfY3hEE3Iole2C/tppuO6g6t8PhNj8q6jTNSWze+VEw==
X-Received: by 2002:a05:6a21:9004:b0:220:2da8:325c with SMTP id adf61e73a8af0-23131b04c94mr15471348637.0.1752354290253;
        Sat, 12 Jul 2025 14:04:50 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:49 -0700 (PDT)
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
Subject: [PATCHv4 wireless-next 0/7] wifi: rt2x00: add OF bindings + cleanup
Date: Sat, 12 Jul 2025 14:04:41 -0700
Message-ID: <20250712210448.429318-1-rosenp@gmail.com>
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


