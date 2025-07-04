Return-Path: <linux-wireless+bounces-24832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B617AF9C04
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51610484721
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 21:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07419248881;
	Fri,  4 Jul 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeGsff0O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815102E36F1;
	Fri,  4 Jul 2025 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665347; cv=none; b=sodCQdxep7/XdvarHiizHyj4Ed48PzN+yRvEo/sCByDi2umr1vHrCghHDr7CtsxTMp7nRh4ZlwVrSeUxCpTupF2P2/XOWf+n3av53Hxj+vrrq9m1rKC5C8yPoN8HnTRmEhjqpCdNg6zjeGY1KMowGtn5SkvzmTQkj/NJ0/1UdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665347; c=relaxed/simple;
	bh=Tm2ScYCePszRDAOARVkMj4eiXv9AjSDhMtX3nWRI9D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkdec8d3Uus2jqgCu/nS4oZAzpOedB5d+kLbqByDElUkQK7TXX2gYfV+ItAmrKmHp2/QGy+mDx8ZKoChW2R3gnSwVku9w2GHiQ0MpYAWPRWnbIJOaA3zeeJl1FNxCUX2rKyicRVyCjWt/wqR5aZf28bEDyjUDeAR4XAj5GpRNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeGsff0O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234fcadde3eso19282005ad.0;
        Fri, 04 Jul 2025 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751665346; x=1752270146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=conCnjeSS9NpLb01Dumo3Ma8H/S9n3kVumDrz5Yxfw0=;
        b=OeGsff0ODUCx5aCHDB/7QRvCbrIJCA69w02EoaPX/ZZO3e9KGHT+8aKVe2DaR0KFlb
         M5wcGGkue+zCnX2WUJvGv0uroo0CIs7t+X+sS0BRucAmcbQJDSFKX6lN2K7dfy6taFnh
         POSzyeHuoPacqQdIU4QV69Q07Hiiei3qRdBPtt2CCTENhCvp4Cgip/zhKjzKamDYFoYo
         ihvBtsO7nUfy4lX5Z8Xr6EbeK7OcsKpIQcKlaSWP69GSA7VPpKN01AkFkFwEtbzQ9M65
         OcUU5ayLTwnlO6LvKs1XkT3vbTpGAGRz7yfoPvw61OL0kntn8mHHbKcVNnUz4/bAujeV
         ij3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751665346; x=1752270146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=conCnjeSS9NpLb01Dumo3Ma8H/S9n3kVumDrz5Yxfw0=;
        b=V+1MFTazzcjMrg1H6/OHMYIy+ry/wATiZRLlHGJsH86kwVjg3i1WT72xDB+DgYiBR2
         n2fZbEqoSlm0XYUgtZrxrHPKxdfDJcWBtthKdvoH/cUbrd2UmYZIhDswxdUPCBmgkm90
         +o6jddy9OUeb5P8cawXUHqLC/LrR8+UySywxoOpswv3G+F97sPSdIbqu4fTJwK846DNN
         2tiXpco4hSBy2vipKvJN5Vb0WEKxo/PwkynNJT99t2JIkavH4m5MoFV0Eom+ZbgSioY/
         Qq5FNHiDBLeNWwrT2VpR0hSMVeW87Q9kxjvnKdigxsDRC49GLyiaD4HLfhTaE56ar6R9
         tb5g==
X-Forwarded-Encrypted: i=1; AJvYcCUAZYGP52yjJBHGInHsE+H1FHrhWaKBWKRUvn6Hj0Rlz5dQjxZuoA85IXcX/1FAnjLERsABGA5gCcpTpB6s@vger.kernel.org, AJvYcCVRNiNuWxoZkUX++dT6R+7Ib5LcFWhfoQI6Jx4g14MXHklrh/xlBJ4Z/L8eXP6fxhCsFkimYmVqyqojzA==@vger.kernel.org, AJvYcCWCKAL9elpLjhPvjsDHseGcjF/27nWbz3NRB+PMdksxN6w4ViY12RygNTDWAkA7Mp/D5mr6dpyfTNeM@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqFsbtqkbKUlsDuu6ZJOGct/vTnyNYC47fE8qlmNUuseUcfWs
	hlWG9CLocAwjXpgxY7Cs55MkTAgfi1xce3pDdb67fWRoycbieteAGyhys/BNxg==
X-Gm-Gg: ASbGncv08dOVi2z7tm+D1vPImqV+Tm2EQWIeDNcO+r8tG7nvfLcbfymwU/THDA86b2e
	F8FPUPx4AmDiXEHLbzmoodej4M1fHnnEDIeiZRFEiRYRXQ9rSfC2QzCTN03WveeHsv1bPtnHB6G
	SI0YzTfVQPZDk3dt/LNsGmkPXrG1saVgABycUjbm+AnreWprGpubWXUC+dqZ4ACTWSBrBSXTYO/
	TOFvEDqyZUzzi4WXOIS4SeWmkUZTF4rgIONiWBQXyQguKbfUjoKJIrTSFrVQd4QX3Qy+2zhUcTZ
	wmTzlQrOPdQRwYn8prII5GGedU1Zk/Io3df5Eg==
X-Google-Smtp-Source: AGHT+IF8QgEExnn4eayof//7hJKu63BA/uDDikgLDkV2XV57cJ2YMFUYgu1bjmg7L9ro3dR3rnFSzg==
X-Received: by 2002:a17:903:18f:b0:235:e96b:191c with SMTP id d9443c01a7336-23c8755bfa8mr61897145ad.29.1751665345533;
        Fri, 04 Jul 2025 14:42:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84597371sm27950315ad.207.2025.07.04.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:42:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	jeff.johnson@oss.qualcomm.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH 0/3] wifi: ath9k: ahb: add OF LED support
Date: Fri,  4 Jul 2025 14:42:16 -0700
Message-ID: <20250704214219.18796-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port of the prior platform code to use OF.

Rosen Penev (3):
  dt-bindings: net: wireless: ath9k: add led bindings
  wifi: ath9k: ahb: add led pin OF support
  mips: qca: use led-sources for WMAC LED

 .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 10 +++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 10 ++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 10 ++++------
 drivers/net/wireless/ath/ath9k/init.c            | 11 +++++++++++
 5 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.50.0


