Return-Path: <linux-wireless+bounces-23385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5C0AC3703
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DCD7AB545
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A501C2335;
	Sun, 25 May 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbAbkQNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF91B4F08;
	Sun, 25 May 2025 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209383; cv=none; b=LgKnUFzm4EtrGXUUGJ7bk3NyD1lWKvaXRXzuN908IBRSna7sxT1RaVdHuc9Nj2hzM33AmYRxhEyAY2QI5U4ehKx5ZJG8g4cFWtRTggbq7e/RFsJJ2r/DFfBbctamAnDdz62qpsEXXBHGJpJDNlDqm4MON5XUnR4Ut3tBMoOQHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209383; c=relaxed/simple;
	bh=LAVh7geJL1PD75mFZMVsyKCNDPWBKX7Jf3cyBhahb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/UrK23ZZvdAFNBGZVjJ95i88HVYV20CqiTs8YSH7Heja/72dNSCL9USYcn4YmLKy/PTCl1U5M0M3UUyP/jCBJtLzr58H4db8LU2daHilecuVs8EYFgCYRMAKAWpHC0gjmWBbDaw4qQ9xoJ4iQfVEfbJdm9iOR6RzvaqhY4go7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbAbkQNQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c336fcdaaso10021195ad.3;
        Sun, 25 May 2025 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748209380; x=1748814180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=UbAbkQNQYbNjAL6Dl1NfhfzGuIrFrzfJOq+dd4BTt25asmRz2LuoKIHW0m0wGt9t2q
         hdgLiO2H1IYrvjxtBDBykCmxJGoaNcFpQAlYYXEaXY6Qg66nSBNvA4BWcdSyOMx1OavS
         b60kZ6WwferY2a20m+QpAP5JiXi6aZbODd10AC3qOpBW1mwJuUDyL3tF/uZvuprAzCOX
         DSCvripkBH375F0I20XTd2RQEMcRU+ZJMEjXjMuo8nLo9QhtJ7D/ad4yThPq3gpXuZgi
         zHnIe4g9ssoLPG94KRtiUeGg1JDdJHivltvwpJH5YTfQ5OWE+tF0lFAk1lCEn0qdespC
         MAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748209380; x=1748814180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=T7SQ3pJIhHv0U1piUoJ28IKspobsG/96DqQ6Hgphj18pOJHRmMafowRkxUSf8p6Caf
         eJZ8SQZ034+PUO/rs0LSTlST3EZQ+oLeshifcS1XW0MfMlIGWBnvS3+qR6+GmR+XWH/z
         5H31z2DfrWgKOTSc58bIttyPeosw6cMB/Bw3P8O4oPOfC34/IAeIJeL7yS8EA/NHSO8b
         oUHV7fiv0nLxvu6BzB86V4xvGZsYSCvYn3uevi8SSpr2kWEBkqX7isPo1nRtHEo1TYfD
         WKIQojSQ8XGNPzsGJ/XFB74DkG4fIZ+F5Gt0K5rbOFe7GrbaLlwvCayZrippsQlpvTYF
         t+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEDeo6j0Q2p1iMHlBgTTFLjeRR1j1SBn+sWmpgQgf1/yOLIG0BixETuoUQZWynCUmFH4usN1WzXrlvJw==@vger.kernel.org, AJvYcCW2ROgpPqxLGI/R6EsERc/kpm4ghuyCUOKWQ4931sM0dobBdIo9BGq1lAR0YGBjJ8e0hqvyEnJWP8YJ@vger.kernel.org, AJvYcCXg0B1QZbguBjrGYP8Xmz/ygtA/Ki5FuBHsfj5VGH16uGPqybFQAz69uu86WCuiUuzf9lwSCnF/l+jed7mi@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNpoStyeN4aAX1t7mqkSNFwy5UdgG/BVoBFi0YD5cf4EGEQEL
	RezGPV692ML/606XLAf7AacmKFFP6GsrTz4oWwWmo+BDJIp4nX0X8JJ3aYOeZA==
X-Gm-Gg: ASbGncsD0XIkBF6vmJ+QKk0Uz/ELAoq+mEUK0l9zJUsy1YkzZqJLj11BA4TVcxsA8RB
	MVz8bJyiMd1y11pPy5XAq0/25meQJG9XIhHPCXXJjGSNpXL7IjHOrNYp9QXZtyScvn7zwuOjhN3
	UAkWcDipneEWhE7p3eUQtDCVVELpL4fhlyBvCSUAFcECR7BFCXGu7/NAJkMcvec2gf75UjGNTpe
	XO83KAAuYWji2ZQCJZKyHdMuyCBUkYegYEXl7xDJKAYqyMSr87F8fTM76ABcbB3IhqaXWCwzrYh
	OVeoZwERUIyewAkd0HGF+TTbRnCd9OVG5fZYfw==
X-Google-Smtp-Source: AGHT+IEVMFzOa9R0IaaI+pWRQi5yXsaPBwgS07kdKqjymnhBqQ+PXQxAPwshRfYaPtzKIXazDkvSIA==
X-Received: by 2002:a17:902:f551:b0:231:d108:70e with SMTP id d9443c01a7336-23414f779ffmr116961385ad.21.1748209380093;
        Sun, 25 May 2025 14:43:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340934d91asm35083115ad.166.2025.05.25.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:42:59 -0700 (PDT)
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
Subject: [PATCHv4 1/5] wifi: ath9k: ahb: reorder declarations
Date: Sun, 25 May 2025 14:42:52 -0700
Message-ID: <20250525214256.8637-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525214256.8637-1-rosenp@gmail.com>
References: <20250525214256.8637-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Easier to look at. Follows netdev style.

Also remove ret assignment. Because of all of these devm conversions,
ret = 0 is a path that never gets hit. The first time it does it when
request_irq fails, but that ends up reassigning it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 49b7ab26c477..d2a97e74f451 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -71,14 +71,14 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	void __iomem *mem;
-	struct ath_softc *sc;
-	struct ieee80211_hw *hw;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	int irq;
-	int ret = 0;
+	struct ieee80211_hw *hw;
+	struct ath_softc *sc;
 	struct ath_hw *ah;
+	void __iomem *mem;
 	char hw_name[64];
+	int irq;
+	int ret;
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-- 
2.49.0


