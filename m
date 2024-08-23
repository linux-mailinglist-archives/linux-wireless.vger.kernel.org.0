Return-Path: <linux-wireless+bounces-11853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3395D221
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9AC28402C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CAE18BB8F;
	Fri, 23 Aug 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuToEJv6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03C18B486
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428513; cv=none; b=i7tSnG+BQIMkv1e9Fj5DZwxteGKRhV+wZPh8W95hky7dQNanNj1WSG4fq97J4cnCUbu4mJDu51Px+Ihx6bJhixu0HOaPyFtu3V1rvYFXJbpSOZTx1ExQ8GvmjFRSPjwnDxNMXELGLVFGPo3HuMUX17OABwtx3o2yFtGjTwILyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428513; c=relaxed/simple;
	bh=0/RMbfCqdDW+ki7JM+qDNhD/vuNbMcB1PBGMH6eB7Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBpHsfHAYeaGlvsIjacJXOiYp0PJ8pU4qL9efE9X2JDF8Zy4kZ91L/0DTnXBkBuQ28rTHb57fFOWjWdN/zMlfFFmyIE542AvKUvPXIO+0quJSLs3Bdu7sTNfnmM8jP/EsGc4Z63OYUdA7AHBYlUawVUEVij2rhqSVwo7Eqex/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VuToEJv6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202146e9538so19403885ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428511; x=1725033311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yoQlQBMoaeviEeMYROWWIq7igQUTvyq0IdAXsNASGJk=;
        b=VuToEJv6vgibqYSMrqClAilOxSh/nGSjZTjnFMJ1mtXvIedgPfMULfdA3HpN83a4nh
         g6HS1WhrXVr+iEpxg65Pk0cGrtDAxhTc9skSFfdl3gLgqAtRaKmbFX0HRTzj4uwVfVLn
         pZSXWDXJ9KAS2ERdNYLRVF0vrZ19+TSvnt4m+dWStIANjkY1L1yDsbS8gqBGSYniRYvy
         UfymgH7atUDnzmgmxLYivhm5bThtvWnEgawFK+FJLYXmxee8QCU2gVXRsIniyu7NDPUv
         gembbN6/Ef8QxtHl8UOh2j0OeVMCOy+9sWOq9l9HUbfh4aKiAYWj4P5q9B1hCgiBSwTC
         Sq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428511; x=1725033311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoQlQBMoaeviEeMYROWWIq7igQUTvyq0IdAXsNASGJk=;
        b=R9ZGTFRMsnk9ebEYjFPhT5V+MNEo8I/QdK66k7FeS92IPnC54ot7J/qX8fW/vjq+mo
         tJcdvgfheREB8I+SL84PWexVdGGSgDaWWDP96DfWICIacqVFBMfvatQZCttip1SjEZWg
         7pe9OJoEtTDs3RSw1Bg4XDm9BSpX06WSj2c7S4EzBGqXa4/u2pc41pALpzi9IjGBt0H0
         gurtFDZa1MGH9JOyfZ2+L4Nr/6zXBfx2171KP4Sc+MIAvmr0zZs/KKcRav8zcTcKznMB
         pnCU/rxWDa1sEgFWkt6ltrKufkuOJu5xR+LV2q+QfITgvTnKCZvZWCUa8crKILYsW9y2
         Lsdw==
X-Gm-Message-State: AOJu0Yz4mlL7Z4jXDxsNIc31t8oBQ4Rsb2O12QyJY9v8OQlZj/QfL6dJ
	vCoLkIjzhdPqJ4LKnFSSI7aoN414jMY9gUBU0/ubwOmVdcb58vz+MBCTduMLrQ==
X-Google-Smtp-Source: AGHT+IGPvpbEUE4s6S0SbLzYR3UkuZy6wS2mnTCLAnr60KIk0mleIYxhMcsNyazUGiMqKU064D+TrQ==
X-Received: by 2002:a17:902:e741:b0:201:f2bc:7789 with SMTP id d9443c01a7336-2039e52c2aamr32196235ad.60.1724428511406;
        Fri, 23 Aug 2024 08:55:11 -0700 (PDT)
Received: from localhost.localdomain ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556649bsm29824005ad.49.2024.08.23.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:55:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] wifi: ath11k/ath12k: Set IRQ affinity hint after requesting all shared IRQs
Date: Fri, 23 Aug 2024 21:24:59 +0530
Message-Id: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a warning from kernel IRQ core that gets triggered in the
error path of QCA6390 probe. While fixing that I also noticed the same issue in
the ath12k driver, so added an untested patch for the same.

Finally, I updated the irq_set_affinity_hint() API in both drivers as it was
depercated.

- Mani

Manivannan Sadhasivam (3):
  wifi: ath11k: Set IRQ affinity hint after requesting all shared IRQs
  wifi: ath12k: Set IRQ affinity hint after requesting all shared IRQs
  wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with
    irq_set_affinity_and_hint()

 drivers/net/wireless/ath/ath11k/pci.c | 26 +++++++++++++-------------
 drivers/net/wireless/ath/ath12k/pci.c | 26 +++++++++++++-------------
 2 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.25.1


