Return-Path: <linux-wireless+bounces-6500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3328A93DA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 09:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C61C20DFC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5B3BB50;
	Thu, 18 Apr 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wid1W4n5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/4ygdub"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E443B785
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424700; cv=none; b=CyVMMfCiu+3TEGL/fdLTf95oiDwVjCruQ+cdwbW52YUg9hqnHeoFGggrpKCi2oX5Yi+c+h7zwCexmh1G3ze4xyPLiml5DdjVw8uNaLPEetwIef5kuPgCwza0Me0KnoPvi4LpzNtHZACGmNjqsjVm/5voZy0AMpYEM5zHNLOwXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424700; c=relaxed/simple;
	bh=uJ4r5v/1xIVYi2Yjh0uVpypX59+NdyZ6qX0mLY1hh3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STfRn+jzKPS2QV15jaoofelGX69nnCz/77KChwszNk0wiyCW+vKIFYt1usAeRyewRXoaGw6vid+mBO4v2cpgENhxBDe6bZKMy8ua3wc2nGiOFXa+Puzg9yX9tOxSggHm+ffmPBQIRFOGDDsJa5vuCs0ssBRiidVpsqmWYaTzfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wid1W4n5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/4ygdub; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GshJdNJYN5TKc60JbKWXS0PyG2sTUFUk3CpEuQrhy1M=;
	b=Wid1W4n51d0Guz71Yj2nU4bE4Mw0Rbye5DCR8uCMDGrUAPrHk8/Zq4TtitMduvyWAeF9TY
	JDP8rw5CopqcuD1DMaM0B5TS0Ug7oYNOXr6B6m688H7ll7aynhpCzmzbQGzutu7iOTp7Me
	X7bhWr28GbIBHxbgh1jCOEHjmbHDQYXmEjA22nND/xWrbHbQ+9r8x5kXH+J93LRtxCa7WY
	BYVWq3Cd3SE6HWiQisIvBt78D59IPtfSa0EItPMKycF+HSEezNZJn6EGrugB0J28+gt6So
	viPmISY5QshQRgx2R9LobXMWuurGYuKu5ep5GwBASmpAHS16QzpcJbD2sjafeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GshJdNJYN5TKc60JbKWXS0PyG2sTUFUk3CpEuQrhy1M=;
	b=Y/4ygdubgtpqh2qY86yKgSyoisioyvf96jkrPO5yyOfRD01kDMwx6UYsMDNbG66hGgOF9K
	GgWqp0GLf8jmPJAA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/2] wifi: rtl8xxxu: WPA3 support
Date: Thu, 18 Apr 2024 09:18:11 +0200
Message-Id: <20240418071813.1883174-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], here are the new patches for supporting WPA3 SAE in
the rtl8xxxu driver. Tested with 8188fu.

[1] https://lore.kernel.org/linux-wireless/eefdf5e598eb4e758130d416793ad9d7@realtek.com/

changes from v1->v2:
- rename enum "rtw_rx_desc_enc" to "rtl8xxxu_rx_desc_enc"
- change subject for patch 2 to make it unique              

v1: https://lore.kernel.org/linux-wireless/20240417093352.1840632-1-martin.kaistra@linutronix.de/

Martin Kaistra (2):
  Revert "wifi: rtl8xxxu: enable MFP support"
  wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 9 +++++++++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++----
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.39.2


