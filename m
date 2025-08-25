Return-Path: <linux-wireless+bounces-26571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE29B3359E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 06:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AC83A26F3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833B1D5ABF;
	Mon, 25 Aug 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUKiwY1N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA28157A6B;
	Mon, 25 Aug 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097297; cv=none; b=NLc1u9iKZ6Z3yLvLCd/LghO+ttAFg3Jirv+gRBBsB+ZDjRiSFAm6LbOL5pheAyS/WUDFv26eZ7J2Y6xDcKr5hWxN1vA8aRJDqKC9tFsAKLqUvfwTGW24omU3tr0zhFhjEB5qaa7oXX+L3KDkzGx3H/ptaleCQ/MbvWYPxdii3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097297; c=relaxed/simple;
	bh=AIuCPO5CasPRn05hfq9qOrUxAiSidHeg9FUKwEhU+QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaLam9nfvyHaWRlh8dhh9JeNSFR7i2l5j1vMKWvUdM6q2HN04kfgc5x3HUWxdFRXcWIx2cp9iasx3aoYB59s2I6bDFe1cNW5dFcK40FYq/o2bI5OkrQ91Phdzw532X4cWbo8bZldc2KQCgV4a2xIxV6O48UWU5cAEw8n/HwGB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUKiwY1N; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-770305d333aso2228153b3a.0;
        Sun, 24 Aug 2025 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756097294; x=1756702094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdzPa0BEBkRWaUNX0kDLVlpF0caHN7N5v8Evr6SWOaQ=;
        b=GUKiwY1NBt2HNzLNE2a0agXSwj/ChhZTskWvosUNzcWC6xXB3tpKGg3ZMv+F7+a++R
         kKxpc1clQurMMrH2UVhAUSvNwJe7ANbdAKZQkxDellED+fw1SFGiN3D5lqs0WBDE+OFw
         QITgz5MauDGIIbIH84wtiivQRrOKnbKjIsqmIuJVNFIbCUzATd2DI7skhg6l6lKH1ZkL
         KVoyDKZ991GpGAaZzVWg+90YnzIQ5I56J8YNBRzjwX1CQcMmXOqAYD0bc1UJ8dd280Pe
         CodI7oJhFZhgVnbsef7bUNRX9MqjM/UIWXqyS4z/A3UqYPA2Ly+iaxo1B5sYgqWhsnUJ
         VDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756097294; x=1756702094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdzPa0BEBkRWaUNX0kDLVlpF0caHN7N5v8Evr6SWOaQ=;
        b=uURsWG4IUN+E6Ko+DobhFvVv260nD4eR5vha1dEtlegz1j4KUfpnA8U8BcunRhDVQY
         EeAzNtW0HqRoi+h/TuiM12p+EHHo6la7LWCZ9sUmhi144XaNoS7/mkApta776x+W2V2n
         MOomLDSgkTh50FNP9QbazVjw/BihylDcO9GpqA3c4ejgoHeR/92IRCpHoB+Wm7/w2Ip0
         RQHtuGfvH4Tc9R+vX0qyzxWO9UW7i+QAcdVNG7NzLU0e2t7fmUigFxsOX9vTyFlBozlb
         gA7hfrOFo09pjmtcR10Khhj+SlXgA9GUXiOt5x1MNvFTAtDNNdsWjFQE4w22EdBYYovM
         7R+g==
X-Forwarded-Encrypted: i=1; AJvYcCUv+feRwaOgyA2Q/oAL2xuaYXqrkNaQIl9g//AkLEePqrgXbWjW3c1lv6Tj635PB6Y7WQqLmzg3fNBk@vger.kernel.org, AJvYcCVhLw/7Ud77vEmhR1OfuAF1B+G2bZ59IOs7PjBcOPF4I7lbGbt7+s1VC5OnRm1/osL5q/Cr9Ci4TDDC3Ii7@vger.kernel.org, AJvYcCXILPipiXD2LJtITcXtDrx1EKWtdRScTHjgxK6MXuyu59KaVKJiXABWsU+QVPuK/TW601f95DRK4geaFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VTSG3VwJCI510ap2TwqCE55TR4FnofNTtqMmkUbiuzz1kpMv
	ZA5mabNs7C4BR0yR7W00iHDfG3LUc7YtOpkF8JxdJHW45NzndqzVkBccfvN3yw==
X-Gm-Gg: ASbGnctZq4YL5kRQitl92Te13A6b4KaPKiOscfRbYuNXHMlwj17JBYxretZorMTI5eJ
	cJ4MsZAcConYrgML16Udsy76BarABHGq6yZZ7IQh7aHP2bfE8E32gtBcSZY5J4fnIeMdbuQXM0K
	bl+gYBJUxk+gu3SaugcBQTO0x15lrsT250R71xk/8wnr7OMO4CieUc02/YzBGEP2Tjcn6D/2gL3
	XoifAORz3XS/GCfKBb9hwjjmD36PZHwJB93QGgprVYFrtOQNY9N2/kTSDNhe86dXpmLGWXNb8YH
	nI/M4mh+fAQ82dv+4msXy+RODgJtJSCRyBvklU5tMRiF+bCcL2FiQDm7Qn6CQqRgVDzrCZjWVLl
	JXyodelT9vwy3TzeFsUUgDl1yCCOLSEuUxYDRnHyb0Y4u128zDIyFr4d0aUwOAAba7j1nMuHFBN
	Hy
X-Google-Smtp-Source: AGHT+IEniIyr0eFTKiQ8tAVIM9A/gwEv/fcpnR8q33La4LGXRWqy+DqA0vQcx2Dj2gRgvE6x2f0MsA==
X-Received: by 2002:a05:6a20:a121:b0:235:4a12:6adb with SMTP id adf61e73a8af0-24340d11da9mr16621315637.33.1756097294043;
        Sun, 24 Aug 2025 21:48:14 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770400010a1sm6170153b3a.43.2025.08.24.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:48:13 -0700 (PDT)
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
Subject: [PATCHv3 0/3] wifi: ath9k: ahb: add OF LED support
Date: Sun, 24 Aug 2025 21:48:09 -0700
Message-ID: <20250825044812.1575524-1-rosenp@gmail.com>
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
v3: fix documentation from v2 change. remove of_device_is_available.
makes no sense for it to be disabled.

Rosen Penev (3):
  dt-bindings: net: wireless: ath9k: add led bindings
  wifi: ath9k: ahb: add led pin OF support
  mips: qca: specify WMAC LED directly

 .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 10 +++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 10 ++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 10 ++++------
 drivers/net/wireless/ath/ath9k/init.c            | 11 +++++++++++
 5 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.50.1


