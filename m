Return-Path: <linux-wireless+bounces-23193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDFABE9A8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A88716C6FF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971822D4FF;
	Wed, 21 May 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npikpxEV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4A22B8AF;
	Wed, 21 May 2025 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793762; cv=none; b=Hs8xG+84g3JMbBi35Q+7xiDnA13J1JoTVeo/6SiUJlaXeAtIXnK0FUsP1INVeanv6mu2HNzuB6Obamh8wHDJNM4oUEWeuHQVgmbm6KDqOPAzbyMRLb7tIHjTp4UyS2F2MDpBAdVFErXunvGJnXCR/gnn2jHO/glYBzFFKRizE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793762; c=relaxed/simple;
	bh=xYWtAxWM7T95j7PVs68xH0+OR0v4YPuA+HXyLluIUwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuQaLtZEQaVowUYZfpTbNuDvthh/yzUnPEwUm7YGAO0tTS0wK+6gT7c3EeqNMdikMyMF0Mcd7zFv/sPMqltl/t4OCRtHnl/uXh35KT5DtF+AMc65cOl7vJXCCyd/EFGcbTcEvLhatrz34tWA5JvDJCTd96a0eOfdGntA8D/cLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npikpxEV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c96af71dso4147759b3a.0;
        Tue, 20 May 2025 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747793760; x=1748398560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFijZmAHpugfNM23fWRlOUPUTPaN7XdLx2HnnMFN2xo=;
        b=npikpxEVz7g6bzojU0XEPbHuCaioWAJQUsP9KbHhTknc12NPSeh1jtx+xvy+gQC4pe
         TPvshBD7cYPt56CaRC9BUkDlZbS9YOQJW0/AhIVklCoGlHcsOVu2hKB5L5U4z+CfZYdg
         ERCEVHku4J3HemDOJ8lI8UhdBgOPNqgeM+3PAdwwLchiFmS/s1EB4klz1ikQNTujHzJS
         s9jLBcFy1glNzsPciwEGhgXjQdvLVDf1n0sf+ZGOaOFi1/YkcJ0oo16a+r3xU+GQG+A+
         j/QezdEvf49rOTRbe/vJ23j9nNe4/ybfr2mdNv4hu18andfdYoZMFDtHnWOYx8zsbsM2
         WDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747793760; x=1748398560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFijZmAHpugfNM23fWRlOUPUTPaN7XdLx2HnnMFN2xo=;
        b=wwCFpp0PkvucpjLabXei46B7S7/JA86pbeLE5+bzJMWEI8gfOGYVTslK8S8+MRIBKr
         UZJIPV9eZxShoRHqCTl0Wt5QfMKueWfeF/cdHGaDhtEQNcpEipjnqoURJ8yLhY7AsEKN
         QJRJJfokSGl97/fh+8Rv+A0ceSip2EZsmA936KL8TQbGV0YrIpeHcY59OykdsJj9vuiJ
         eXpE8Lh4EObEJXRnYJWyqMmCPo2C98CSGcNL5OKGY6lRFiyfYcCgvoDgdRypkCIwESqC
         RpMCExQYeJSidhS9IpxJHJRhUU2y1vPFVeBWbRREs9RcYVTXhf5Yu/53OCqG9dD0UiDa
         faUg==
X-Forwarded-Encrypted: i=1; AJvYcCWhYlhHg32qCIWmQtD7ApQCbPL/gAO4PMdeC6klcbIO/udvelILgsRw90aFfaGoSo4ICRJW0jzW0tHOmQ5V@vger.kernel.org, AJvYcCX2x1f4qB0VBQ0/8fPtP6PpTQhMci9A4OxS9UPA8iDQzycK8D4UJ5AUdUhS6/7U3K00p3bQa1c0qzLFAw==@vger.kernel.org, AJvYcCXOjpxZyIkcd0GwX3+HaGgD4tJKNfoIgiXl/uKl5ZHAhHsGct0nUmJXnSFjHnzqyzHJyVmu00nZraHS@vger.kernel.org
X-Gm-Message-State: AOJu0YynBKCUvqNuIUizNj9wNtaQCIiRvEgI6XMc/GuG+4XHX3glke2M
	zlxqT9Ie/5UrkFqHyWZWTuLoqJSwJVpE+bRs+SgHHEgF7gGWUaBCTqvaukWudA==
X-Gm-Gg: ASbGncvZcRbIew+/wm70Hz7cMgLS5DWoR6V9DF/Wd83djQ231stR8x+rLD1T8CipYBR
	WAnBquaqSFdYi1m97n+tBPe3KMvYpnZ5SHhrwEKcu0pZczrU4Yp1sqx37BIrGxxclonZ7x4epaZ
	FfbaVvtBCWUNokwj1WI+QFvEetpu4OXgnBbDS2enIwDk8obR3jgZYeHD3fg/BBdp7PEGVyWvmqH
	hFc1wO314C5KQ+2Fjb9KXXLtyjHlFtuU9dU2dj2q0Al8t2441mY2vpXEX0cLXlIxvsef/O1jWYN
	RwwAhQCpHeu/QpQhFRT+NabSDDY=
X-Google-Smtp-Source: AGHT+IEsqjqtFcYrnCgx+fm0ur12ycP8Jr8QiSOFOgGdSxla/L9uI7wRXAiZ50mzksfOlGOhptU/mA==
X-Received: by 2002:a05:6a00:3023:b0:742:9e9b:a244 with SMTP id d2e1a72fcca58-742a98fb012mr30778982b3a.24.1747793759770;
        Tue, 20 May 2025 19:15:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8758473a12.49.2025.05.20.19.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:15:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] wifi: ath9k: add ahb OF support
Date: Tue, 20 May 2025 19:15:53 -0700
Message-ID: <20250521021557.666611-1-rosenp@gmail.com>
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

Rosen Penev (4):
  wifi: ath9k: ahb: reorder declarations
  wifi: ath9k: ahb: reorder includes
  wifi: ath9k: ahb: replace id_table with of
  mips: dts: qca: add wmac support

 arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
 .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
 arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
 .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
 arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
 .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
 drivers/net/wireless/ath/ath9k/ahb.c          | 61 +++++++------------
 9 files changed, 63 insertions(+), 40 deletions(-)

-- 
2.49.0


