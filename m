Return-Path: <linux-wireless+bounces-25323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD5B02D12
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE3F4A513B
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B822D793;
	Sat, 12 Jul 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwz4Hh7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E1227B88;
	Sat, 12 Jul 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354295; cv=none; b=PMkPnSvZe4OGRWmNVa5WtCyODYUs7cKrBmvu4+nUNkzo/TPT6+gRysOtd3XpRECZiJIKjxSZ3oTfs1AP3OOK9ipm2OEDrawD2r1qKKqpFBprIWTtl+3zNuPiJMWWqq3dm5/fZxWm10T2S1Ilq6wgyIBg+3jnHL+4kWhAzNFhXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354295; c=relaxed/simple;
	bh=hzM4e9GQNPdul6p502bI30fon3cLoRt6GoNokcsR7Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB/Adb3TPt7FHyiJAWMm7dPcudtk9zAf7+BsQNgHxEd9bWEYMW06cbCZvcNq7TVdwR4/T6j82MDNpTri7JtoF7Q9k+tPTbPR3we0mde6ZGLhWY8gSbmXk0GEpO+ZuSx1WvMAWtyaufKfO9pJkb5silJLgD+JGBovWTqPtkOU//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwz4Hh7A; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1884038b3a.1;
        Sat, 12 Jul 2025 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354293; x=1752959093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7Yy54miT/gWfUHu8Cyu4CItLZigxgVN3p5H0HM5sD8=;
        b=Nwz4Hh7Aj2WskzjCmWMR7/xRViGI34FReI2ELXSu6zn/fmZ/njyoiotWAGD4lkHedV
         f+/i1ApEU3LaE05hPKbTRKNTLn3E4gNIu3+0Yn4MKMC93eBJx+fbXcfw/RBLHuW6U6ve
         pK6ospGfKGpiZklzskRw/QFMOms2D1F8bg2UI8n5yg2aCXQ7tnnlFFFAM6UeSnoOH3d7
         uD8Kjq5K0FaTdJp8We9UqihKwDB5qrdCWs12+zLlDjP+D8Mf7OrHhOed5eJ4DHrG0Rfj
         JXyQ7GRziQZAjTZpOvm3y19KJGX9kYXCFUZFPy56zx0OsN/Z3HkkG0PbD18nn6sKFUeS
         55EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354293; x=1752959093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7Yy54miT/gWfUHu8Cyu4CItLZigxgVN3p5H0HM5sD8=;
        b=DMj0A0r0iwnXQVK3DVXL+7QsZ05vc2ttImwIEZ36gYtkl3GWzci9nWjCMKTE9U4FbU
         OX8ztEVjkgK438bLxrBWW5NJ7aF7RCfXVHx0nTyNuWkOUDw76KiN1eaxe1AEpMSCReFW
         RONzfcn+o3fcAayETEo+1whYHgPyJI3Sw88Ovj7iWX+9R+i8/Q/2DxDCQMo5+z+6DIcQ
         Tgtr30XDJFwHDJhacjBvxydL+VUdM74A5Wz+6nY6eJCHCfdJIgv1GTreGx9/aOBhhyRC
         phWTEMqEvCDTkrVtjp7masVLjaImlu1KMZxhDmjbBQkj0Xd64Fdg484Ia8+mXeiXrRpj
         I5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUGOb/B71Wz2koH+tiYtMMy7DYpvdT7WweJN3ZSRRK2LjFH4rbxh0WaaG7w83+U2i6WqoqeB5erNJ++@vger.kernel.org, AJvYcCWEMVCDnwDwJMuXiVq4McfnKxo0Vr04sOuTDqBhrBm+lYRoXG1NVGUqG7idD/6XWJEGvh/EkheLbwhWJnm0@vger.kernel.org, AJvYcCXrQTiebh1n57QU4ZRYaVn8P6e36H0plUI98hck3okxP5CBYoiu/a/uw46kRIePzb3Tg9UC9a7ZX1E8yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dDU23eibHPtdfWrFVduuktTG4fQnoXbub/Kb/IuCAhjngWiv
	JVOyDjQuQApgAQoukBkmIweXI/e4HeENv18FesftvUxrL7luO90uDuCa0wblFyGG
X-Gm-Gg: ASbGncsS1nKcpKHKZnx964u2sJOv++fqN2kOqWJmVImARkHZOlrjNqCCf1lPRaJC0wi
	sxFY2ZyDC3WRnAv1IMJJwfki+ae6uXPuSM6an5hBrYQJov6aVWH4/O23VVFM9F90VK3B/Dp7ke6
	mr6hhVm5MLKjr9PCz9wl9xPs26seK4KlirtrGyjO1xEn2QJGBmppMa2SYOoP2FZYQzyRFIeVyHy
	YOEehAtfuFBE+tnk8YzAl+F+nX5OQPhw6Q+LD9pUhzEklvCFptNKbPOz5FmaPAMb7oORNzRqp88
	u0poQFXvdPieFSXjampMSTDa+FS9XMgtZR0g+mJkxTrLitwEzvqyFqxdmOSboFb2bq4bTr9Mdzh
	fDpEaGBGP2t661w==
X-Google-Smtp-Source: AGHT+IF6HHVjmY1jRKlMjLDChjNeQFSBgVcfL3sqPPUX07rFfyjAqJU724onjmlyPqicF8MkxgnX5Q==
X-Received: by 2002:a05:6a21:62c1:b0:231:e2e:95e4 with SMTP id adf61e73a8af0-231352477b7mr11392023637.16.1752354292751;
        Sat, 12 Jul 2025 14:04:52 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:52 -0700 (PDT)
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
Subject: [PATCHv4 wireless-next 2/7] wifi: rt2x00: remove mod_name from platform_driver
Date: Sat, 12 Jul 2025 14:04:43 -0700
Message-ID: <20250712210448.429318-3-rosenp@gmail.com>
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
2.50.0


