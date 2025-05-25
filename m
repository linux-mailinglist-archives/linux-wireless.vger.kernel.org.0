Return-Path: <linux-wireless+bounces-23384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C33BAC3700
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE901893F47
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022351A2632;
	Sun, 25 May 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2QSUnEP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19F3FE5;
	Sun, 25 May 2025 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209380; cv=none; b=Wp6POSjXRgvWk69K5PZ5SgH4qIytlsxxaDJmNXeUEl/kGtBLwPxk2aVOY2Su7vbyao3lIIftQjqcvSGMltLHBW+/hEgWEZbkp4ztGJ2rTFSxNHL/BVHITGvKT2P0f80b+R2BSl+IXxCIaPRDK24v4V62IRdURLPpEvjt8z8R46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209380; c=relaxed/simple;
	bh=QlJkMiueppZMRRDV9RhyQbTA08vyK4crlnYF7K8cCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPK/cR+SCiO4WfE4cW/zuREmU5wvNfE2RXKhWjbjbT9f5rbyVZDDb8a6dre9QoobhQeTAmP14T8hPINmlPeZSroM79OYQXChcG362BtiImPXxfeH65GJA62GYusdnHteSsoFCPs1k9XH8DTBf07Yn74jC7VMvasHsosZa1aaj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2QSUnEP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2341814895bso10203245ad.0;
        Sun, 25 May 2025 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748209379; x=1748814179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQsZDQ8ChBqoa7gPK3pcsCRBK0QjdSKS6lDWtkEWdOs=;
        b=S2QSUnEPSPka0w4+ImOuuatMKCviPpdS632dZT7mZ6Kkf4A1Y54nU7GciCR1qFK5/a
         qkuZVfTx8qqljkUefQT/DoHWSDYNCFYcwK4q81mE80LgCX+ZCt3ghY3R9CGmOM5sR5ZE
         o++q3znX/gtao5D0v/lQ2zKEMkEWnh9VLDl4Qv8KleNIrnVC2ETWLc2PuDUUMYETy5Tn
         6AAkYTImMD+54g34zPGGOP9vy9GrZaCfQGnGDYvUlO0/vYa82/UJpjQXJpWmTPeCQ+4B
         LVduA9zvTLZb9JaCd+v3AyttR8w+M2qwfubYtglPTLKtUDUtXXBh90IN2GWYJI+IBC+U
         8+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748209379; x=1748814179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQsZDQ8ChBqoa7gPK3pcsCRBK0QjdSKS6lDWtkEWdOs=;
        b=nhNFCHE8H/eF0mlscO6kJGd/nfm450h9ipDnJYrJliXqi76HKI1u8wOlSKtDv/foxT
         qCfvwDBuHMZRMV80R3C8NVpLYn5vOnVEGGzJTtRdRADN0ffq3QcqolkFV+3WwimTmoTW
         wkamifbteBggc4uDriJGK/L9xNVx0TIowt3zFlNbONzwOoVSDwfTGU1dA/GeUgi/RTY0
         rlPV7JOFdwZmHESLZ1vJEMFa/x/ArJpoDwJh3qjxS/E595LDQ2hoQxCGcEBFdt7zVcql
         /yVhQR6TGD0QDHHrTPMaSIgKW4/S5/fCSu8jL760AmoIp8zqtMJy7oXgmU8DPeJ0eUNl
         BChQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwJMdybFkuxa6uR9ceUaJLhca7COr7l9nJoJxSwbHXzG3yLwyTjn7fqNoC+4PJLmH88JUIGQdY38bQulT7@vger.kernel.org, AJvYcCWh84e/hdUarnA8u2tPBWTeIs53q5ahMXwBP5LuY8uvhWG6Iz04bpMur3cspGHl+g5Ba6ZdCyfnJjVU@vger.kernel.org, AJvYcCXxYbMgiBL4I8QEnp3xhUMBR6wHZeJq6eE8j2LKJFu84NdpaJonOEvsK4Sqmay+fO/aEIoxjC4SzTWEwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi40K5y327qzidtqQHyc0/CtcUg7VO6S0h0D0H2mS0udqmQwvY
	bBhlxCjyWL9WI0v9DUGwyqLFNxIED99JnPalqX03ltSenf9Vpq7EGosbguxbAw==
X-Gm-Gg: ASbGncsABV1B5Nlvlsnjy6klN0HWtK0VMgu3Q1qifTl8yGYzqZc7OpIV0P8FwECAt6e
	xwrcHO3zbAxb/Tl/ddjiDXpn8f1WZaYODvFFu1PyAZLt96MOSt1ZRP50FfmXTKr+yCLF2PhrG8i
	WjKP98NmxEmCgBKDokJyaqjgyamG1q6sRBJVq8Ny8E0HX39VZsTFJQvhGr5LR/z4Wl2cgxznJ1T
	g/9bBPrJ+hF5pbcIhV5fZS0NRLL7220ejxrKusnkqYqSAYAHz2thMiJ3zcBKjy6L+Uw3BzNv/b/
	6D6WqzLuhPodffoHWDeiYEo1Rxg=
X-Google-Smtp-Source: AGHT+IG8ghJC6zp8CVAOSrCv/ztl5IAMTcUVN3LNowVA0qXoh/su3TVmi4U1f+4p0BkKRacCcE+drg==
X-Received: by 2002:a17:902:ebc6:b0:223:88af:2c30 with SMTP id d9443c01a7336-23414f4d252mr101857255ad.16.1748209378603;
        Sun, 25 May 2025 14:42:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340934d91asm35083115ad.166.2025.05.25.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:42:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv4 0/5] wifi: ath9k: add ahb OF support
Date: Sun, 25 May 2025 14:42:51 -0700
Message-ID: <20250525214256.8637-1-rosenp@gmail.com>
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
v4: fix up dts example in Documentation

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


