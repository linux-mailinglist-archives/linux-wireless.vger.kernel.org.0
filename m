Return-Path: <linux-wireless+bounces-12492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39EB96C2D6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CDC1C25006
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73441DEFDF;
	Wed,  4 Sep 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6DsnZUq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960B1DEFCC;
	Wed,  4 Sep 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464968; cv=none; b=oCbCF2FRtKGK47yU4vUMwzfR/SYVKxZBEyX4feIXzRMdA88vQkg3nVY/ffl390KkNjGVA8v7kDORcMkpcpdpoMQ8NqM8mOpIxozvCpr3kVfdcqI/ZINBs/cDCjIbD9p73qOZjk1H56cAQOI5UE/DEhx+ffKSVrN2ecGGxy9qTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464968; c=relaxed/simple;
	bh=gTJrWsflJRH8i+wGV7R/FlxM/03HQmUVxlPhNaScABY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GMX4bFcuO7OUaUHmbBzS04m949B95iblZjJ6cUMZSIwn6lwA5WDeI2I9zyvh+vn/zY+8c8D2EpxschoIcB2kpMEkZDCoQi76cb/8vAcjHCnSBuOij1kFiWXicc2b7L/CVeBeA1Ru9l27yQ5HKPP7kIVmJR6hAfnczg7kSXvv/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6DsnZUq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8692bbec79so783256466b.3;
        Wed, 04 Sep 2024 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464965; x=1726069765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucfDxjSvRyxzVqonQmGsLlVw5jt/PwIM8Oy9nZdeRiA=;
        b=i6DsnZUqYtG3W6+56R0fYFvqx8m7/38zYLuHwHwscUOb/K6iNbewztCmLT4XGTiTg2
         T4FXv1dTq0b4cDWWFutrqbv0bAJ42gFxECcGmnvC33owRJ7dRIde8LeNeHvn4UbFgxRc
         aR0BS47OPQobouwGPuKRYnsZ389eh0+7TlM12lI6hH8HBDeoOLQgSzR61pYn74PNMXzC
         PgVjclOIIcj5aVeXYFsXTZV5bi3zGq8euzunXwFB8EIbnz6ymhJnZz+eYAsB2ZUytw+1
         wwYp1wYI49MLAMaaQlcdFoiGtkEI49pEZQtJ4KFx0jNEEtkXNvEPmQxjKbjXjyTx1uCA
         zp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464965; x=1726069765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucfDxjSvRyxzVqonQmGsLlVw5jt/PwIM8Oy9nZdeRiA=;
        b=UEcWwoz6GE0itIQpsJoJr0UfLRDmc5kfwuEdsPSaNs2ftvpVe3wSvGzNRDFb4Pt1Pl
         An4dIUMi0XGOMJq3JN0hsWRGns+2M4pstJKUE1JJ59XCtGS1CdIJg2PKrXtzzB10GIFk
         VuzUl0NCJP//Oa+yKjNttz6J2C786Zexjyn1P8qjP6CxmVQgwCXb/hAIDgl7Y54yq713
         cECQXH9rSe2X/LacFW+IUXBk1zw60gzWqJh5+xyfTfRwCgOdkiotE0yxReKR+o190gy9
         SzfuwQIT2LJUFGwyN8oyDCC0Ik/7ZVsHoRHH7oDgQj/p+7hTvg7JEFX/FLmeBkCN7/ZC
         EstA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/kQYQQkEZseFfhfB6dqoQdTHkpzoHP+aFQ74/vNQTWpqperpfqTQqp82cg+j1V0ysme9p4GNqeXH5yI=@vger.kernel.org, AJvYcCWfwT+pKv9V1HmiDMU7yuc5/JYiVx8yXFc4le/C4ESry7cKEJwhtG8Dxj6JKoX/55+Bphkbai9D2eMBccvu7tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyijb0b3K6lg90ZLkaX7K/mVvf04OcmkstcwW5zxB+2L+s1Kjhn
	BQIwXIoEtkdsHsdzraqy440kXIF7IBYzD9XWymmu9/Ka/LNqn+5U
X-Google-Smtp-Source: AGHT+IFhXK5+Hg6Npk5cn92j6pprBkKVnnrHx6kaben4LyrmhWYlBqama/o1UbJSgEJT7tVkXG+Etg==
X-Received: by 2002:a17:907:3e93:b0:a86:7a23:1284 with SMTP id a640c23a62f3a-a89a379cec4mr1300521966b.48.1725464965246;
        Wed, 04 Sep 2024 08:49:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038c0asm7825566b.62.2024.09.04.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:49:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: knaerzche@gmail.com,
	leitao@debian.org,
	linus.walleij@linaro.org,
	javierm@redhat.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH wireless-next v2 0/3] Use functionality of
Date: Wed,  4 Sep 2024 17:49:16 +0200
Message-Id: <20240904154919.118513-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Split the patches into subsystems
	- Use DEFINE_* helper to define the resource

---
v1: https://lore.kernel.org/netdev/20240902225534.130383-1-vassilisamir@gmail.com/

Vasileios Amoiridis (3):
  wifi: brcmfmac: of: Make use of irq_get_trigger_type()
  wifi: wlcore: sdio: Make use of irq_get_trigger_type()
  wifi: wlcore: sdio: Use helper to define resources

 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c   |  2 +-
 drivers/net/wireless/ti/wlcore/sdio.c               | 13 ++++---------
 2 files changed, 5 insertions(+), 10 deletions(-)


base-commit: 97b766f989bcd06e5a7651b1080001d7327012f5
-- 
2.25.1


