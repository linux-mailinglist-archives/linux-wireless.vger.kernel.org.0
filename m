Return-Path: <linux-wireless+bounces-24997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E2AFD81E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64121542626
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0424501C;
	Tue,  8 Jul 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEZSGreP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B3241CA2;
	Tue,  8 Jul 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005873; cv=none; b=Fj1m3cIoCCsMYv0NsuXYaU5te2zjWp+16cpJJpWNKDPHYc6np76ybFrh5McWXq5RGiSRvLDA7dJbvy9+hbvzPkq0XomHJGb2ire1sfAirWYWA6OAfEW/vOuVMbdLZInhrq0OjTm/NmQc8UOOdQiqPUoV2q6pOlq0Ye0HkuHEaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005873; c=relaxed/simple;
	bh=ct7lwlmAT8/f+/iRjJ3dyzHaVO3ooUiOe7cpt27Npe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeY65AmeSdVv05o0J2hbZM7NnVpBmVHuJbSdAV4pdET8Y8z76qRsR+J26NgrFdUs8+cByBxAZjpG4dmvhwE0AXN5Ehb7cenHX7cZMMTCgYY727ArLPZ8XZv0xRnTzeujxlrTzJ+zf0plMzU6hufmDE7UO5e9+GL0bqQgorsAlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEZSGreP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3810362b3a.3;
        Tue, 08 Jul 2025 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005872; x=1752610672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QNlEHfEUZYvh9WH2X1qfGtuDYzY2qNWdQQnVhSVobw=;
        b=BEZSGrePoLoP6XFpAhagU3oLNhcl0KrXCewsiJ2WzeyQZyhDvxRX16GetYUxtjt5co
         GBDTfPaYROkH8XiBOZ9E0oTRlG0DtQATMI/apLKptOX6nMs544XmRTeXBW+mipJARweD
         83NUwa7pOHA8KXi8iDIU/Mf43ZWexsocZPLwPkZqBDskODafYaYxIbzU43LfYLC7qjoE
         LWDBuNYDrnXDda9f57Ww4gzR+KvKfefL/EaNLvPa64sZPsZVVXCND6GpHlqpTf90XnwJ
         W4hZgpN4Srh0XTUdm7S26YLtXtEqU5du/Y0av6XRgrPkZAW0YHlTfCgZ4nF8jSqg0Iv6
         Kqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005872; x=1752610672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QNlEHfEUZYvh9WH2X1qfGtuDYzY2qNWdQQnVhSVobw=;
        b=qZZ29NHu2NUm5MgtEB4oR499fM/5m1gVplLGp0dNNHaxOuIeb6V7dxzhKsW/c0VKB+
         930e2ReByy1ngRzGpSkl5S8vHI0bBj0yyhCKwtdB3Zc8KH6n9tB2rwmlUvTHv/yy1TRX
         CvbHbMhFscSicdudj6g+84fVT0zoNbvaS4pGdrqkYoKgWOMvybwwrWqllHFa2rx/qu7S
         XJKGRNHBE/JCKSP1Wg4Kt/Sa6VRhf69uDHPI6LA7OdO5YbU+fBAMGLnRBfcmO9Swc3uJ
         LjyL96/sGbs49ZkQtMhCf8Jf4fs3150KCPS6/NAiXjA3PKUNcTNKYLsZKOzuhcO4fy3E
         cIeA==
X-Forwarded-Encrypted: i=1; AJvYcCVlvA84prwQ9FNtXNFxvSIabQqkzZOpA3k9sMZXhbbIH++/RTwIEa4seoD0Ttw4nvb6ZhfnGLDL2uleNw==@vger.kernel.org, AJvYcCVuOFXgteKAyr5s5EwOFdeV+/ezgHgJ4ToAedQftMdS283t6lWtNywSqoYVXOfa/Z5zxGyy+/58kExgmGz1@vger.kernel.org, AJvYcCWieCNT7ouAE1TN25bcHS81OyegEjcYl9CeTFTSCb76wGbHfCWHBPnrtzyYOMupGsfSDV/QE1n97pA7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tHoI6Ln+FeMKS5Lidy8elregL9T414sVLqbiR3pjueFoeOXJ
	ZbrdYwrmJq9nR3zFhxfLO4wGiHwc1rXSjFv4tJbgiwev0INasKNOe5ltWgKdSZfFiSQ=
X-Gm-Gg: ASbGncumqvOEzf7unqOuVzEa8p6Na2tSb7WG2Kn2VmwmXbJuMeTYwReOhxD1/ta9owp
	RWAXPBJPzc+JZZ57UA9JvlvG94Z/aFI3cppy4cn0r5MP5ypVqpDgblO5rLahBG7nEVhV/jFPF03
	a4mesENA6fCNytD3ME6mevSyu7vhTQAb9urKZWLfXKjdf592Q8FL1wZNdHqZc02ACYOCCZe5xG7
	WKI6aneDoFBwowL+0FUIX52CFOCdDAM5judTbVhLN3eD62dPhBT819yZubHN80PUeSnbYI9W89W
	+qzz40HGun8WWrIIRvqMKAmHLagZBaSSiTd5qdNCCcP7iRTD7y9jgg==
X-Google-Smtp-Source: AGHT+IHbYO4srYMIJVFpXEofQgmzn6XNXlOmY818mJw4NNQt11WzJSfS6QV2PLjLjUQtpdhW9yWPFQ==
X-Received: by 2002:a05:6a20:3c8d:b0:1f5:9098:e42e with SMTP id adf61e73a8af0-22caf53c026mr334789637.7.1752005871552;
        Tue, 08 Jul 2025 13:17:51 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:51 -0700 (PDT)
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
Subject: [PATCHv2 wireless-next 3/7] wifi: rt2800soc: allow loading from OF
Date: Tue,  8 Jul 2025 13:17:41 -0700
Message-ID: <20250708201745.5900-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708201745.5900-1-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
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

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
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


