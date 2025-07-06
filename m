Return-Path: <linux-wireless+bounces-24855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD82AAFA7F2
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56093AE3AB
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E792BDC23;
	Sun,  6 Jul 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXRe1Nt0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7C2BCF6C;
	Sun,  6 Jul 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838079; cv=none; b=uygtKwsVXW8oT2IecdiMazxArLd9Y5FiOd62xswMmzuG9m1bVoiqUecd3SE0L5uqZ0V56bz43Fo9pmbjl8UE62QgcPIh1JxZ5i25qZSNNBhIngZTU4z7AYm8SG6CKMF9n4+BLFNUBiSlhnjmxSnS8P7qRP3XXSlzdPDqhXmPh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838079; c=relaxed/simple;
	bh=ISJUnyKEjL2GUKAhw9PQ/SluS9XWJMt6wPNGEkcIaB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADRe4xmc4bRKEtxT9K8qWg0l16AoD6kS7VyDV9iErQI59altCa8ihphsWXqJ4RHT6mwhpq7RcnARG01KVi9WFE2/DiLRjX8AZky0qx9gWAQDbAnjODuLe7x/JB1EnwH/fng8MZ2TbI9Uo3WqQwNGYQl2TZFtO43dIBv88nJcsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXRe1Nt0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1424629b3a.1;
        Sun, 06 Jul 2025 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838077; x=1752442877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swOgqNchoKoKbvtt/1M0CeLEVRw2Niempvg5FVKkFhI=;
        b=ZXRe1Nt0WNqOaVmqLpF0cwQR5JiRYGhWtp3gz7pJqmnJo9KQ4kaa0PJKwH8Dkxgy4+
         Gf1/aLCtQuHUPvenYUEZoRyiIygojEeKljyGmq8xeVAuNKl0FGnWgJXelH8IMP5wMb2N
         ddXXzZpVixNdMFlD7ePuaD7HlqNm/8cOsd0eLy1sPXuCUEBZruDNtyiOGFQkWwOwm2mG
         h0X1StkF8jvTLcW2avyejMMQsdBUssuQu65JeL6LjSk47IY/VIEEMgtVfh9tlJM9x2a7
         2JgUZpFYIiXxSpIx6EhVuV38WFsjLoqvTWoG1QMCjoFUxvX15/fnhw2gKkmKIxqPGEV/
         Fb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838077; x=1752442877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swOgqNchoKoKbvtt/1M0CeLEVRw2Niempvg5FVKkFhI=;
        b=vncDN5lUPVf+lzn+2VB/ylbW0u7h83W5xb8+VpHV3rXO3QPw+egHJQojhrw6SsC8nn
         PPWEjA+cv6hzHZLT74qbYWQ9PaGLLBksFTyGmpOfgHvlTM1Ov1lkGiQLca2nrs4TTsf9
         fRKCiZmYeEoclR2IueyfoVVwu14NvKbw2bC9h8oIXY1vBx513PEDrQs9rHcxwc8v4ETC
         8LLAgp1/Ohd0Ncz10oCEJdIVp4UYlcTx7323Dg3tIkm6tHkxyrOztCbofS+T21i8F0Yz
         jWqVfqQf2CBiBM7dPYHSIupM6fbx86xvp5wxCne+iKBHxk7IS3pWXygXm/kE0PIOF5n4
         WzIw==
X-Forwarded-Encrypted: i=1; AJvYcCWx/MaWwM/C7aorNAOPIlGP54F2OyYnIFoq1y1d8Izj8eHXTEvwG638xw80F69rDFXlQSDZGl34sxcr+zm8@vger.kernel.org, AJvYcCXVbS7bha2kHwNuiVyNBqdY79AcaDDqea48JWMBqKLCZEq6hTGZnLVx1D9OD2tKcJkWctlofIuD2GFk@vger.kernel.org, AJvYcCXx1AG4hghZtLyGgZb67g6MUk/GbqPd7p52X+tSkkxqbi2zKT68SQKvEoVivF0c+RO8kJpSPIuM/hHM9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqcEfh8SMRrTvhLQtxKXSXUyIWT7l7RKRCOuEDZ+vPI4CCR+K
	V0uV3EEp2lkcFfo3RBCA5/2Y/Pgfzd1KkmbCXsVW5iBB7kh3euj78QQ1qoOuOVNrIFE=
X-Gm-Gg: ASbGncv//7u+JdIck7bnfPOf1e9jyfw+VASPNfyTYHXlX5LUd0FaTeUsw7aSsjVsnya
	0aCeDUsPn4D1RPy9mOzUpNT1Xi4WKe6BaRakP6bULieWc6myFYWiBHlKFlJOHTwcjXv5gwsyT0k
	Ncaz/2+dVMaE0u+QMYsFy7YBS1JTzpakjnQxYDW6WFvU0WPCDlNHcoVTZk0iFw3F5C+KRBxfmdd
	PrZsGZ8qWONMQQP+b+nVsVYAoMBHBeb9Y0jv0Hhuiv3EHWSI2P5ZP5FFAgm5FMcatlZzPNxohzG
	wuLJKcz0S7zxrcefM1ZuzlMBLJZ4gQV+OqZKf5C/ktE=
X-Google-Smtp-Source: AGHT+IHSFD8W/9aMoucidCPvq+qMXi+IdM35I/qq7pBEKJHsLmkxu5ounpaoHPbBTKQ79HMYjGlkSw==
X-Received: by 2002:a05:6a00:3a1b:b0:748:e38d:fecc with SMTP id d2e1a72fcca58-74cf700d34bmr8770853b3a.22.1751838077394;
        Sun, 06 Jul 2025 14:41:17 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	yangshiji66@qq.com,
	ansuelsmth@gmail.com,
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
Subject: [PATCH 3/6] wifi: rt2800soc: allow loading from OF
Date: Sun,  6 Jul 2025 14:41:08 -0700
Message-ID: <20250706214111.45687-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214111.45687-1-rosenp@gmail.com>
References: <20250706214111.45687-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single bindng to help the already present dts files load the
driver. More are possible but there doesn't seem to be a significant
difference between them to justify this.

Use wifi name per dtschema requirements.

The data field will be used to remove the custom non static probe
function and use of_device_get_match_data.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index e73394cf6ea6..db8d01f0cdc3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -243,9 +243,16 @@ static int rt2800soc_probe(struct platform_device *pdev)
 	return rt2x00soc_probe(pdev, &rt2800soc_ops);
 }
 
+static const struct of_device_id rt2880_wmac_match[] = {
+	{ .compatible = "ralink,rt2880-wifi", .data = &rt2800soc_ops },
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
2.50.0


