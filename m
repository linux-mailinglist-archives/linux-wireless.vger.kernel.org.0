Return-Path: <linux-wireless+bounces-25959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64464B0FDF8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E4D5623FC
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05012262A6;
	Thu, 24 Jul 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYvjiUGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D35BE4A;
	Thu, 24 Jul 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315958; cv=none; b=NsrZpajK0VYK692vTJyILCBqVCPZef/LOQJiZ5IOM6sy9mpR4hSILp7/R8lRIZgUB4CaJ5apkT/ygHUE9ACjm76/UzgblvOBE2YQQ7xEjMbvIZ9+iCCOkDVLevWqWlvYe07FeaD04AgLRcNYUY9sKXIN42m5RgIumkcXx/PbtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315958; c=relaxed/simple;
	bh=zd4UuPZCrtSHYK+p9EWQWSiE00iML8GgKnQHxJ6A5to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkVRAkn9iJMaMyAAdqAL9Pb4I+aWzuUHqk2YCFlOLOUiqyJ6adk6XKS28z0YfR+FeTpaIaSNBnO4klrU9O8BdrpRVZslkAu09ywCvYAYm0PYc5XY826tcbqTp059RXWur0e6oJ+AsRH14BxOyZqCjxDBt7tn/dsYpIBFda9ts48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYvjiUGf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dc5bcf49eso4794005ad.2;
        Wed, 23 Jul 2025 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315957; x=1753920757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnsv3lN8DlbmZn3yUsY+QjerAU+aMz4ylZM8H3xwJJQ=;
        b=iYvjiUGf5E0a6XNYicNMqpVYpmnKAOoxPOpiH3QZ5/Bjl4V7pwEsuM8lBXsn9J8Q0i
         AwNMln7x3C4Ftpy8mswiMjXkZb2OcY9UCnJ9+7ebCF460JcS5BPYlCY7JKKEsNtoC2z/
         fHAwpcYcbm+6B9QOufQgHsS4WwZZXzvN+McIpSIOPyMIXQvymFISHRh15yxNJXDwJJyL
         8qkpqh+DfEM+fMyeJUeOPA+Qc5H15VoXiS5Ny1yipY9hrRB/VtmZmf8B/iyy9EoCRpRz
         ll8DMJAUwcPcCum1qqtDDg49WnZY9qvyneckuY0c0s+VOg+1w+3XC4Bwda/i/12CHuZK
         ZAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315957; x=1753920757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnsv3lN8DlbmZn3yUsY+QjerAU+aMz4ylZM8H3xwJJQ=;
        b=bfDYU0A4ECkaUZDBkVQ4Lvx5B7hq6t9H8cPmYa1jsVG4KmuIKBCDhH1xob2zSlgB4K
         y26o6I29MT4YzO7CEPAJ98J+twEmmgWlBAgOTKvsuNmQTkoFfCQhqF1TJv97Mrps4CIO
         Y0bflWLl5NGoE/vKedJ1ucC0cA/niaoFCSwaWgLalzpIXtsv8uE18Wf0VWc4CgLxSJej
         /GHuhi7yL+wqxpaNctCaV19+hxAlC8MJcA5jOBS0EdLCjr0MAAMtpiOxSOLngJYHmHqD
         RL4OSJjqI9mKiLiqBe2Am1zb5fUVKfM3lwKQvbz3V9rygtFzxC4hGAxGn1rfC7Y+XveA
         udkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPz5UJg56v8vDlRPgRIPc4RDdkmBEOZpaLidGe5zZl8tGhelZs4FcGy7JyMnCQk1oZK3DNQeznImcE@vger.kernel.org, AJvYcCVEK3PZDn7TxY5LmND3N/jubxx+iVKl8ccU4dS6s127Hj3bOvve/wXJ1zea2o0p2g1bL93VspCV5rLVv05E@vger.kernel.org, AJvYcCVwcErZ0UKwKP4q6jDhMXaWGlRyovCpYD+i4wsaHAEmnmHq3CGilizGWsffjhi68xxqcgCeNvFy42rbLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1p3aTyrGCMYKo12vo8S9BTILo/HLdbl3y0b4sI/84m1s4KogR
	tVLf+a2LKSjj4DMWs+yau1I0ov3bVrUbQsr3VLwIICLMPj6j/B929BlhTnHstWJE
X-Gm-Gg: ASbGncus6PVRJpADdQ3Gw/e55D8HwRp5scGeqlM67izxpBCfaOaHWxg/G+KkGMcX64P
	9MAinI1YDFRxT1Go+7fQ7a6POlpFXDo3LeEJxxBUbDEqCcLJyDYKm8MBLlc39b7+dhRu3sfIv0/
	KP4ZL52j+46H2aTCdz6c5iQ8YHCzWsednzyF7yUnyogT6dYuQs8jvPM9wv95LRSJfidiYEuZb63
	rPmqV2oQYd5h3x0IcS7wxL2qu9b5OuRmgVYGwkKR8IGQJMzp0llnLmj6nZLpPVRcUxQ3IltPige
	2tAmjl4Ss6MO21hx9Pv8I5xRCIj/E2qgXdvpAkik4vZzezKgFqkACtOHcBViRsr5uWQCtsJ7kQ0
	ExV7VtmR8GQ9C1Q==
X-Google-Smtp-Source: AGHT+IGZ4DXoXxATu74tb3G6fvKGlcLQ5jkV6mUrbgM8vUEicuu7wE3mkHfegW8UEH8u8pBJbGBVag==
X-Received: by 2002:a17:902:dacd:b0:23d:ce98:6110 with SMTP id d9443c01a7336-23f9812c147mr79576845ad.10.1753315956702;
        Wed, 23 Jul 2025 17:12:36 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:36 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 2/7] wifi: rt2x00: remove mod_name from platform_driver
Date: Wed, 23 Jul 2025 17:12:27 -0700
Message-ID: <20250724001232.2275-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724001232.2275-1-rosenp@gmail.com>
References: <20250724001232.2275-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mod_name is a legacy debugging feature with no real modern use. An
analysis of the underlying MIPS setup code reveals it to also be unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 701ba54bf3e5..e73394cf6ea6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -246,7 +246,6 @@ static int rt2800soc_probe(struct platform_device *pdev)
 static struct platform_driver rt2800soc_driver = {
 	.driver		= {
 		.name		= "rt2800_wmac",
-		.mod_name	= KBUILD_MODNAME,
 	},
 	.probe		= rt2800soc_probe,
 	.remove		= rt2x00soc_remove,
-- 
2.50.1


