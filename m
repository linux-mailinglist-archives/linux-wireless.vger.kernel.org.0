Return-Path: <linux-wireless+bounces-25224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28AB00CC4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62C55C5CD9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E988326A55;
	Thu, 10 Jul 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiQ65G3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CC32623D;
	Thu, 10 Jul 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178108; cv=none; b=fFpzAZM0t8g/JR+ZLk+HMwiGtYdaVAz+9vcyWC/QOI0ak0jlesm5hKnGaOfK52DstQAwfccJY9gAmFS4MhD3JEcS6FZ5EPDLIxfKvewND5LcBuhTchX8jwo4p/QZXoZmEwFNVItyCVWQDGOAwVe3Um9qgBPiyicbxphqrK6TpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178108; c=relaxed/simple;
	bh=aZE3O13kaygduab8acu4CFZ0TPxIo6RT8TsC9jdZETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMeTjBHatf797e7WrFM0kmIPhCMfumVMcNP46SPqdJ60Y0cBnqNXQKY87sS0ZvX/xOakvEWsKsD2lijVp1ADXR2Qh9/WmubZqYEQsOry/YCkw3ZHzTURELf5/xDEMQqf39s8BB5aazl38FRIS7rKbQSo/oLBayc3m1/N4abDzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiQ65G3e; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1086294b3a.2;
        Thu, 10 Jul 2025 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178106; x=1752782906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL2X4PSlvKw2OWzjEtTQ+YQrEzIWKJ93JS59r843O7s=;
        b=NiQ65G3eZ2VT/5FA7YGbYWQoo5WuEES9EL/0rewH3iLlM3ZdWhotopQxbjNqerVTnS
         JbOioAjczi45+AVQKoLSFyPJ8PvShTaC10wBPI+n2szrw1PfsZQd5IAT+ahkvWTC6EOc
         jx6tUnITkSvZeH5mbdY0geWCrVeHBURqBWRgXguSCuuyMosa/UbyZtB3ZXVvSNNyOD5b
         KbDvBRKkfbcEcYjX6mlDkbpksNZGWuiXljhc1PjaeYQjfSImd1JsfsY+WhdF1j9TvKhg
         tZ713PdAMi/xfP5xgyuci4P62ff6U5z278ZovSOG8wAN0p6I1cnyZfMOkaBpf9+JiGHS
         +acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178106; x=1752782906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL2X4PSlvKw2OWzjEtTQ+YQrEzIWKJ93JS59r843O7s=;
        b=a0oTY94xEfexok3dQPCKEaF0APBQvzCkqyXgOUwmPSITq4N+TzQ3YlqOTco18bftTy
         UAwu0KcFSCSYE8seIB2vs7nQ/u9pnFLJJX5v3NXgX9einUFP1vhxMzrIDBx7/NnsVSS5
         YkIBzid2jUpAHM0UdHO9iGnWoeWnJ28F/pHR2U2rXCWvIJ5vvzprBWf1B1ptcn8PhFxg
         fFAbtrqM6iH6Hy3GknGdJ+8sv8xYr6K/A3x5UWf+I9qOVsMiobclO0iNl6E2Ue8V/8ze
         ullp0w7VUQeSqo5NW8J+n4X3OZVVbEb6bRMTlNiJzGjqnFRypW1dkUOj48eOdra94sZG
         xBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOUpiGruvMoi3kk6l82mOsI7hFFUyAaNV+aUyXFVQ+HCvfQkh8nNvFcJenfZau8mSfPjQuh69w0Yz790cL@vger.kernel.org, AJvYcCVUxWGrF97mXKYtco2LVa+v6G+Ap3HPXWWuUIT3MphTyfW/w/G5P6wnSiBREfCitDqHMqOvn/cBwxl8Tw==@vger.kernel.org, AJvYcCVy9MqQfxiis4O7tBd/KYYD+A0nL2eJpVUzUJ5d9oFMU1AR9mNWoAF7IPmFNZJhay4Z4Mq0uriuCuHE@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaHfjFPjWramluL+D9UfjGEg9CnRpKnIfPaZ6sU5V1Z2ulUMl
	a7Ha32bynZx9xUnLSkS+ku9Z8iVS2bjYzOy6TSNXrlfjEIGaekVNHuhbrWx6t6QM
X-Gm-Gg: ASbGncstJkRaDm7gFwx91O+QRSZClxVQmqZpa5PxpDCo+fdvgKfMoTa3LHOB00IWwsY
	nuzJ2bHDwD58ZsB+tdsyFb1r4SWmLQ7IxeWWvxRj9n6maFeT4/1myLXcZEXum0QU7GTCCWm9/dC
	oPIwF+fc+roQLAQCXuBhTCbBgcP3Em65ZknNJy7FpMCLN8rkBHn5tGwxyLDzBtm+S9A7AivAHre
	dr2f81KZkxxiX0mrXsL6gw84cpqdQTSmzTu4aWWpsxN9GlOrXCUD2Luwp0dGJxewKPtUaBD0792
	SpXhjFIne2aOtXdLWWeJ1t2GT/jKqKbnNI35lah569o=
X-Google-Smtp-Source: AGHT+IHfPGQGYb3EmFwhXCalIpBTrUjKXYsMjtYbocmnfGZ8PHyWlghL+KSVZ45IoryDzbeskDxV+Q==
X-Received: by 2002:a05:6a00:cc4:b0:749:156e:f2ff with SMTP id d2e1a72fcca58-74ee109b523mr518595b3a.7.1752178105798;
        Thu, 10 Jul 2025 13:08:25 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:25 -0700 (PDT)
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
Subject: [PATCHv3 wireless-next 3/7] wifi: rt2800soc: allow loading from OF
Date: Thu, 10 Jul 2025 13:08:16 -0700
Message-ID: <20250710200820.262295-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
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


