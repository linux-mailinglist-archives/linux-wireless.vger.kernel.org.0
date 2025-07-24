Return-Path: <linux-wireless+bounces-25960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B66B0FDFA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFED1C27B5A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659924964E;
	Thu, 24 Jul 2025 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHQNdNip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1F1E519;
	Thu, 24 Jul 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315960; cv=none; b=ZvkeQY74rRj61ZGKNholB8h2UrQ9fc22CVSTFvAX1JuFChRF6Valbm9ennaqwT9iVw4Qitjki5Y7Z0DLTXM3lcNohxQ9vqm8cN8MjvHnwtMvRip0UZ09FIjl6ZP68Pw33Y4m48OMbnbwJ3AAcS6WeRmm6I8eIpKHweoPq5QJJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315960; c=relaxed/simple;
	bh=n3hz1bc8GlvYDilmzGlM6VyhOzOw/FTYwN+BaMbGor0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thsLL399MFL2KGJAnsOfA2+7zC9nwhWpEj1xZ2icYBn8Tpg97AsihZ/PU8EDsgWMptuoUiNCgmQLaRKkwEPI30xesvS4oU90uo1IIX5i80cjzwXUa82NbiX24AD/Hb/W0RxrAG7dG6RbLMycBSwdhcf66T4SoOlCPL/0J0qhrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHQNdNip; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23f8bcce78dso3937185ad.3;
        Wed, 23 Jul 2025 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315958; x=1753920758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNqdppqc12AolCaCIftKMEQ9tW6lvqeQBpAU07+UPTE=;
        b=AHQNdNip5mR3S5aNvWAXwCLUZbGMUB8/QCAZBQcS/m4sYyojUpLUXVHn2Elnx90IkC
         Mws4kDg+QQtkP1Bt55+4Q4+Z/1Uj6EqYIfMomvFrqsrIVdJevkqsG3LOp4okIGzzOt0N
         JL2OKXbAu86fDnqmZjrMkWqvZc3Vwf4DtrnKl2jx0SLwLdddzzx7EPBO49vQ6p5utcZt
         Xw1MsfI2ioyUBTgqmk9ZIAjGAP/+TPlR2QP73PnAMT/udQq6yNSNcPiFTwWvCXuSiFhe
         WVpWOWLSPo0FJp61GuytGMaTXZ+cHrCLevOi6tJCE8WrnIQFAX71yBTbtt3ozVY7nddy
         ceyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315958; x=1753920758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNqdppqc12AolCaCIftKMEQ9tW6lvqeQBpAU07+UPTE=;
        b=qR1SY+uYxPsYYDEMGue8pX2GyA+N8AeF8JFJG4lHzT1C7mq8kzgGvL3AnvEA7ongFd
         b7UQZv9EA9B7TpJKeiNTPlyTbJ/Jx3zSPHYtW5ExOdML6Jl/MhXrT9z57SBE/Y9Xtc24
         tuDCXzTMG2KxDCmdrNpSiMFP37vgRDF9jdyGlPfbyn0dG4ebeckSl9ZC+bqaqGCOAwVM
         BRIee+QZ73mlJ6BfnX0OgXcxpMJK4OpOodpFvAb5o8xxc3vlEbpNBhRL3aex2Ri/EA6P
         ifSxpHgd0YsHLBJTYxzXFsDIF4w7QE6GpUrOLRTILIVqGDAgtJaugBOqPJTlbniGkZaT
         JU2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+gr8UTBzZGH3o8E3XyQh4VbszZOJ0uFXEUfyNXuQQwXIXCF5BfU5cxsdOwpTeM8fISNWI7sTaCZ6no5Jc@vger.kernel.org, AJvYcCWyzpRDVYr7Md2BprLCAFz8tZ3OascvFMmA3qtCkUokOCV3oLGI53bnWEDkddXw6p1DrHLC51NDtv88@vger.kernel.org, AJvYcCXSCLhJiMpBEfzliuMezkg1QWndC7+tbPC3uCgEPPG4v749gVGs/QlXFMJq7VmYG2RrSbC7nkllQdzHMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzS4e48JpqMWofYbfwRODIbbhJYQl3SgdZ/YnladdPlI2+0AZ9
	95d9qY6JWB5e0ja1egqY7zDPdIrZLTl1KAlSjpfkulIdk/jtOzKkIC6PbyIvce6y
X-Gm-Gg: ASbGncu7PSgijdisrAtvnWk7aNRxk6/JzV48dYFmtKyTaUnJBVhWyTAs23XsscoPHUq
	m8TmYr1+GjCVvMX8YhNHeWguWNAFXpSW68PjCL0BbDp753WwYgACdM0AFeUD3D9a2jhqRzbu7xL
	sfpN7ZdEghu+R6lurkPag1GZKEoiiLaqhsZhA0VEzU59e5ANIW/xPbrZ2vlMKwr9I3Sd6IKPE+N
	rtK79GOXgPh+67Jd4RqBxqbMdewwqIMC0SybfQ0hCpalnMsw6h41nKvowK725kIE9lh5prqGmvt
	r5SeHefyXF58MMwkbODq5t2wo8QkQOTb2QH5jTVvliWXsr+2PVu0OBdV1JaEDSIvWp9MXcdB324
	ziaqn/5T/8T2BBQ==
X-Google-Smtp-Source: AGHT+IGMRR2Fu0m9nCYId1OSGijOuULND7c5nOfjYDjUOnjmLQE7uUvUkOvwsaBmf941o5cvm73+Rw==
X-Received: by 2002:a17:902:e84e:b0:234:c8f6:1b17 with SMTP id d9443c01a7336-23f981b3991mr81365885ad.38.1753315958029;
        Wed, 23 Jul 2025 17:12:38 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:37 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 3/7] wifi: rt2800soc: allow loading from OF
Date: Wed, 23 Jul 2025 17:12:28 -0700
Message-ID: <20250724001232.2275-4-rosenp@gmail.com>
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

Add a single binding to help the already present dts files load the
driver. More are possible but there doesn't seem to be a significant
difference between them to justify this.

Use wifi name per dtschema requirements.

Added OF dependency to SOC CONFIG as adding of_match_table without OF
being present makes no sense.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig     | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index 3a32ceead54f..a0dc9a751234 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
+	depends on OF && (SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST)
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index e73394cf6ea6..8015089c4a39 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -243,9 +243,16 @@ static int rt2800soc_probe(struct platform_device *pdev)
 	return rt2x00soc_probe(pdev, &rt2800soc_ops);
 }
 
+static const struct of_device_id rt2880_wmac_match[] = {
+	{ .compatible = "ralink,rt2880-wifi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt2880_wmac_match);
+
 static struct platform_driver rt2800soc_driver = {
 	.driver		= {
 		.name		= "rt2800_wmac",
+		.of_match_table = rt2880_wmac_match,
 	},
 	.probe		= rt2800soc_probe,
 	.remove		= rt2x00soc_remove,
-- 
2.50.1


