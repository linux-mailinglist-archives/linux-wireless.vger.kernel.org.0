Return-Path: <linux-wireless+bounces-25324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A0B02D16
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC14A55AA
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B02309B0;
	Sat, 12 Jul 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZpoPVtZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EE22D4DC;
	Sat, 12 Jul 2025 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354296; cv=none; b=PWZDAF3omtDOUF6vMEleafVZFgi0QlWtTWklH24UKJzGXSINSI7UDLp8ea9AJOa1ZA7cvBDvv/tgM7MzKK6LNAr1AXS3S6+SnfG7SNz7G954vkIWo3gZqS189MqHiSjxuAfYSx4YpM/6EEA7aFiiLKrlgdOZ0ymC0L/Fuh3/lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354296; c=relaxed/simple;
	bh=aZE3O13kaygduab8acu4CFZ0TPxIo6RT8TsC9jdZETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAAAeJGGzogkDq/GrytcbBMc3ZbOaekUaI4gxWoiVScklQqhK7D6E3+ZjE+Chilg6OGZrWJkpQyoZk5OU0hPIKJPGP79cl8OvKsf49DjCKCqPj1ZfSU9H+1T0PaiClys+HoJXzvrZnbN9EVhRaIrO7bpiJ1OQ+dRflKpJJ4gNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZpoPVtZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b54af901bso2035917b3a.2;
        Sat, 12 Jul 2025 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354294; x=1752959094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL2X4PSlvKw2OWzjEtTQ+YQrEzIWKJ93JS59r843O7s=;
        b=PZpoPVtZ6n6wLuTZuHz6/dLuiPPGp5m+9KKJABB0Zyf6HZ4fLv3YrtjOwEBpB3JwG8
         95oHyD7PvF+ZKOsSJoA6WN0mIwYtfR5T9Xjw6Ov/P4hVjum3ZyhGaxfKJmBkIRWhRjwX
         l8CpNjJkYqjbu3UX0fjhRV7e2IigbBIqQ5yNJM5LQL2/3WNeewdh00EiyADsavk9NGDF
         E7sBAJRQnuCQnJJMqKmDV+58H7hxOmgRo9bAsoGncwAF6b6P8uLu4xSGjA3Ol/tO0Mqf
         sHbY27K/aFerUoen2TDsHUJMwYsuWk7qjDaSBpDNY84rp+K5OTHQlUi33FyMs1f69xwv
         b2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354294; x=1752959094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL2X4PSlvKw2OWzjEtTQ+YQrEzIWKJ93JS59r843O7s=;
        b=RLCZHDmrqhE9JXVZ/UMU7Q5VjdQZfSYpWpLXBf/SiVKEzxBII4vi4h9nZVsp+JEmrt
         xLD/d2pWvjia2IwOsRla+bZokDxj1AcEXhYs+3WrkCB/JCkXCGPvAxYamMd8TbcfuAs+
         xRqB6hSulEmDlpmvAJsHEiYLNCiHsqDKmiCvCm+H6Ee761E96FZAHjuPSP+lhfC+yzQ7
         vCNAFWfxbzg+zO8fsfy7xi/R2hd7QNbWBb6Kzl3kRdfvDkmJ1uDg5ANQKgr3tcVztphn
         mFlkp4zy5+Le8YBys/2wmq0OLYwOXVsT03RWC8+BJn4Oi4266+opAPnOowQcYIt3RAzO
         qGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkAzfMJKje8EoH9kjfmkjnStS+gJrA79aDBVJpeUj2xDmUa6VlTI1ruzquLgkcoeaiBixI9q1bpuTsbsfe@vger.kernel.org, AJvYcCVmmaI4vZkzaTfKSVMUucyvdAMztYwQ0FaRyhu8+ATpd0evzFwRfeUGbrgHpqUHZXeVJbCrsA2CvidWDA==@vger.kernel.org, AJvYcCVtQ7ouZ/WioEy2wHzFZCn+9ntxuV1Ep8TG5rADoIUljPFzqjhA98BWeTf0oGNXl3vsHbVHcQm+QYGN@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLpxNaz+eQ/seSDkGbzfNjVk1eR116Ds83JdSE0/4aCYzm/DW
	FewhB+OSfdi44JCJyOEJQMPpx8g7arHGLqjCHrk1lLM3iT5j3SYGIrb/m+/bC1+U
X-Gm-Gg: ASbGncuncylvDbUbplnqhaUiv55NJekRXz8EcZrjZWxkJws7ZCmwqEbrS0TCvZcCUvj
	LNJBxr8IngwQ1sS3NV5LeBPk3XRmXxujWPsHv5YzyzvukeFAHaIfRnYojfWeNeeR6944nHCLz1G
	Lhao24F4JFaQa/uDtC5moW6/E5evSxN2hQEoK6uOpvLnhLqORGaa0jhdocy3f1gBiMeyTvCeQoZ
	FIF6kMpR+rtly7AC5tnx17+c3GYg3DudYsUJmA3IB33TJwc80mXPLgBwaNX6+mNda2w5Q3ucQfu
	ho3P9XPsBsQPNIPpoySwjGgRITVFRokBXPBc3Houu8Nitu1/vX0fVdVRfWjVxT2/0uQLmkKEQYH
	mXq6lYlPVvc15Ng==
X-Google-Smtp-Source: AGHT+IFVM9eIPyUa1MSyRIq+YL7Q8u1+8iMgtoX+w9Iao2/yT9qN8qNzp7afO6cMCSrv5R/Em19RlQ==
X-Received: by 2002:a05:6a20:d486:b0:215:df3d:d56 with SMTP id adf61e73a8af0-2311fd0281bmr12030929637.21.1752354293932;
        Sat, 12 Jul 2025 14:04:53 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:53 -0700 (PDT)
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
Subject: [PATCHv4 wireless-next 3/7] wifi: rt2800soc: allow loading from OF
Date: Sat, 12 Jul 2025 14:04:44 -0700
Message-ID: <20250712210448.429318-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712210448.429318-1-rosenp@gmail.com>
References: <20250712210448.429318-1-rosenp@gmail.com>
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

The data field will be used to remove the custom non static probe
function and use of_device_get_match_data.

Added OF dependency to SOC CONFIG as adding of_match_table without OF
being present makes no sense.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
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


