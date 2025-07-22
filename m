Return-Path: <linux-wireless+bounces-25880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E341B0E57B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350CC543DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03346288524;
	Tue, 22 Jul 2025 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpxEYKQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748322874E0;
	Tue, 22 Jul 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219743; cv=none; b=T6WWDPIS62/p20o3hA303lQV0isYb118Vz6dTJP74Psi1J++byCZ1GCZmdl0VNCE/3o3LhauwokDZth+PRynXlomG2Lei77WyEOMd/CfmIzhl4nhtM/1zVPJFSbysW8opIcpi/DyolF3i4bVJLUBdtJhdNke/XX9p5oMZfy2iy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219743; c=relaxed/simple;
	bh=Z/dt2QUyYqiLsU+9n4pCsyTXy99hLQFfPeIkBwAN+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5kHjay727K1yOshaWGpJU4Y+941km4wefQZCl3AhVhq/PsQR2tPYL034Rbm1IYDCkiFgLWzhMvQIt+YgIy/vX1rYXAE91hgGX+d35x02QnKsqPYDE1i1Sb4RRhjvmkzjuJLnv3OczDdGW/Jtd9pY5SPFlVHcvU9Uw6IoZZihnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpxEYKQs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31329098ae8so316118a91.1;
        Tue, 22 Jul 2025 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219742; x=1753824542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmepHzHt9JVFvnS8JDKPsFHySoDTq6dXaw/2Vy9CkC0=;
        b=QpxEYKQsCIcVL0iVzVr1HvEIFRLoxahBZkKhzYTPK8JfQl/I3LzUHkY8ZzSsTp78Vw
         A5U+iJ4eCHfI0Gx9uGGO29E4UkAzPP2ltFSOz/OFk8tQ7HMiCIQzqQ8rDCJZ0rVuPA/e
         jb6hMBl7M3+8+Xg3JrKLKDGV6kpZtPFr4F5bIbMoZIc3P2eCQjNFdyzkVFyD1nMXgqc4
         Tplweqq0gj6vBGEvUlLRnJfarib0+DAJ6nM/hDnq7Byst5i2e56TT1VUEX8Q+QiHKfi7
         p05lKriNpyIAnzvS3X3rW+82WJGfxz1udZjZ5AKE/cuPcS9AK+fASM03THWFLGCyhsbR
         DyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219742; x=1753824542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmepHzHt9JVFvnS8JDKPsFHySoDTq6dXaw/2Vy9CkC0=;
        b=itBJml761mm9G5ZKK1yV+fRnRv9+2q152ROz1dwWmM7jLo0EqDff6lxE8B/WLjxXgW
         9rai3iiKJe0JPRRgTGT+BEXhsCH5ztnH2Ci5jXIX+DrKk17CBaBz6YBX9gY8ANrcBxQM
         Njywi4rYfBqRepaEABcfB8OW1OGeNTyUxuEVjeQYT1wabWSoZi+DtrwX3ppa6RcRJ4QT
         anI2B3ulYO3dVwAfAW42ldg49mPQqdDPv0t46MtNmJwdoP0OkMQGrANe+IW/DxlVPept
         wSkSPNgC3PkuAZlqO0u7K7zr2bS1sgB0j01k+YMrke/nUcaLRh4whPXb/Z8nnoEqIozF
         i//g==
X-Forwarded-Encrypted: i=1; AJvYcCVXPocvODjfMlFKQo/6lLIoW109B5P7HEyEr+/ByQGwXAjPaxsN3XptnYyYCDIeWknDd1cT1vSbT7Vh5g==@vger.kernel.org, AJvYcCWriuQl5m+SMlGIvRHwesLDRX/uaPj6zuDyDEKHw4Z8qpfFaIGjyBiBz3n7Axyv609GKbcY7Hve91u9@vger.kernel.org, AJvYcCXcrsVNmCv3TibWguMk6O8tM3pO9tjKRjTZk/m4KruXApsxCWLzyNtKgq+at8HcJZsAxqFQWfENiX1BHrJa@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoO9hyyCAeSXd6XlE53LFRSNRmEx4AN9wEFRyrAr9Ov+UpQxs
	w+I/Gsf/JUftIwXCWkRkpifFU0pH5lns/j3PqyIZjXcOMrh1phnvhldlaPgjU2Iv
X-Gm-Gg: ASbGnctARMNLFwe0Wz7m7aM1JUpjaaw71Yh5Q1obrl+ERS09YDQIG5F44/e0rA96A9C
	PN2hrE3vjMWiacvPTyf1x7EZAHDr8g7Os6yDSqLRxjb8RXDEQWi2fpqlStwx3XvhzadOBaXFyHc
	/u7Vif0slsf97Yj3UZU7fEuZI0qHmql7uRHLTS4npItz5zV14+CSzyXNVXfMxwCIrAliZ0DOgD8
	nnaJGy/1n0hWb9hsfOLMNriUakG1MfV4b2ezlMYc45KqxnmEyi2xlw7tcsLo848dfw/npjTrt/q
	3clp9ShTvJtfWm4owxJqFyIwZAUvBVrS4UJYmaZzmNhowLD8yI4IIkOb6Vd3ygHaB8f0BaidTME
	Nr6Q=
X-Google-Smtp-Source: AGHT+IG+E0Ci7wudIZxVA6QJDirzK3xriERd962AI/mtpe5WGnUieqGbw4ApECQVJBKNsAH0l3EfTg==
X-Received: by 2002:a17:90b:33c9:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31e513cfdd3mr501767a91.17.1753219741673;
        Tue, 22 Jul 2025 14:29:01 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:29:01 -0700 (PDT)
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
Subject: [PATCHv5 wireless-next 3/7] wifi: rt2800soc: allow loading from OF
Date: Tue, 22 Jul 2025 14:28:52 -0700
Message-ID: <20250722212856.11343-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722212856.11343-1-rosenp@gmail.com>
References: <20250722212856.11343-1-rosenp@gmail.com>
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
2.50.0


