Return-Path: <linux-wireless+bounces-24994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A9AFD810
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E6B485BCB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E3216E26;
	Tue,  8 Jul 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnq/VJN7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AD14EC73;
	Tue,  8 Jul 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005869; cv=none; b=SAUoMFt2sjVB4W8ucHqB39KTt6X/kqzCrU31Jj3pabJEp/sjFBBWZLJgI1FGfJ5SBZbNtYB7/8o+DgrV0hHXVtyKg7rYu4hb6EZ4Mpkw5VXMaRgTkcG9QRW/pS7YEg+0jT3Q6wn51Vlqf+Rkf0N0KsqwlFLFcaLXcTZv4ORDlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005869; c=relaxed/simple;
	bh=vkIwiUUoskp2nTIzQuPKLfqizM839LywUOEUI/j4HcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHVXiZToWs2OpgKj8gIcKfieRwn/hjDgPVYPYEWW/H0dCVq5rTnCN3EPzSvEE8yyz3evKToYbrD0Vl18C2HShiJ5+52cSrSYsrO9F/zWksx+VWkXAuiqikMhwxOWxkdfTWX8ZeGTNdrnU12wo+9n22IF4cgBsSYLKa+uim4aBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fnq/VJN7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3226307787so3742260a12.1;
        Tue, 08 Jul 2025 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005867; x=1752610667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTTrNTGhub8A8V0WSX4PYi6yLCXMR+wXKB4MowDi9Gg=;
        b=Fnq/VJN7VRhB2J/vx2CKNwc/oLTSyje3IjtJyAIYeQvIxPDe/82LHsvWN6OKLPuCYl
         dGuBRmmrS4d5XYbulJtxEITWD+24JJg3Q43AmdJbAXnI07KMOC3o+c+Nxy2eGJcTuxBM
         rGfc4jqfK7J4joztO7VEH8WoAMBMhFHraRZzkIuBNXqvpHa7jUdH38YFwbeRvjjyZgsY
         AUKOtRGTImUmmYy1SE2ZAuStGMHU77nRJV8dI2gafrMu3WViBG9AQeI1o3Yqk1EbWZh+
         GsqCZsEJMGIgFKgjPMnAYgVTfVAHLvQ204A3BFD8JmEP3Lit4ZELcfYTsWsyEVjS/RUs
         Xv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005867; x=1752610667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTTrNTGhub8A8V0WSX4PYi6yLCXMR+wXKB4MowDi9Gg=;
        b=rrGk25eKfnT1LTLa/A/D/WhffKqV87TX0zcyQsvVoovFJAu+mKiTYGrF0woH/tSGG7
         pvGh2s3QlYwyFlaimUYMbVbZa+42z45YJmce1HRp315EnbKh5S6u5xih6wJ0gi52+zHe
         6fZCsz5nwFDDINxj2c4Ho0lu3WY+eK0sLWi/c6mldTh7OLDouDxgbClvKqIIl9lXvJLH
         mO/u8AHiOQDx/cJJ+cfbhDOzhkPQ+2ybz0h5H+mPu4EyrIJtZnLxkRGAKNmdG4ocpOnm
         Ja8prhbDJTj13iRPsBli9zuv5uy65f0mUYNKqXLeULJohKBJx06UrqPJOchMGDynMyaW
         S1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV17kUXv1WeR7OE0/v1WHIVtLr03RlmExn6TVgpT29Pw6sMGZOoMBbb4/eKdat3RFxjIPbJnDFYJdvh@vger.kernel.org, AJvYcCWKfph1Mbdv2LsxpUZHIjdHi7onRuq1WYxAII38m3zFl8aKWKbmj/HlCmUdErygtyJYSvaFV4FfmTgDiA==@vger.kernel.org, AJvYcCXtfeGgjDT1STiTmcAP2kFkQ7kagOfuPlsOEEQt8mox/Yih/JBdDnJm3aHpbkh4jNsZ3tM1YrmkpGMUOM5f@vger.kernel.org
X-Gm-Message-State: AOJu0YyLol90cTHPCMWGSfFEifGAfJEvQytxBPTiuHOl2DYTbcahwEW7
	0rRyAl5znage5mSPJdFVIfCsLtK2B0rC+gf4lTftW7Mhlf7LIltTGl3ZfL7mj5GQfQM=
X-Gm-Gg: ASbGncsWM93MDksxqDeoUwa07UPxled9xWrx6fAHFjVX+Io6InPiXsxQMJkHUjxIDQw
	FQFLf1kV4jwIM35MnempD5UnxpurAlUZt7hHfwK4tsbKG1aGeovD8ztsy84MyUyGvYxQmnbxsvj
	4IPzKP573nbcSstOk+RJfrVbIDXmTihSgQhCVE5lvdUag0n/xy06zf74wpeV+yerVgUtNhxByE8
	B9Ihyb6pj43XovgC9a3SBNz8Nve1Ygq8WEkgsS01sbj81UMOx698bQTqZPwtDUjAdzwKuWImmvZ
	EtbatKrlHpnSBEuITD2dOQyLLc9snF+BG579AoJzAOo=
X-Google-Smtp-Source: AGHT+IGIcRTQ/IVzI2tJOroz5Lqm+kvT8pKeiBj/N2Gf7unUpL73LQu99cUIoFH4FDd+4jyRsbL5bw==
X-Received: by 2002:a05:6a20:a10a:b0:220:2da8:325c with SMTP id adf61e73a8af0-22606387110mr30289384637.0.1752005867470;
        Tue, 08 Jul 2025 13:17:47 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:47 -0700 (PDT)
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
Subject: [PATCHv2 wireless-next 0/7] wifi: rt2x00: add OF bindings + cleanup
Date: Tue,  8 Jul 2025 13:17:38 -0700
Message-ID: <20250708201745.5900-1-rosenp@gmail.com>
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


