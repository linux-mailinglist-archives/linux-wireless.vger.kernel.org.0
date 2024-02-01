Return-Path: <linux-wireless+bounces-2976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58958461CE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1C1F247F8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421F85644;
	Thu,  1 Feb 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kMohdYAY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062E85293
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818404; cv=none; b=Gwm3C+K2ZKRp3i04DQCjcGTPPii4wsEVAwNIk3X4YUw55/TqZee7KpCgeIdhvpvYZF7oAo9d4WmQ8DPB6NP1W4J49f4nsFRWYPOeTSCxv55gDK6XSdlBuUuua3GsjHPZQf3go+Z4VSX17mVJcw8F1hPTxfXNxb3Kcri/s9ZqU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818404; c=relaxed/simple;
	bh=SaYp12yVhP5xqyfZ63zxjEKPgF9qCcamsC7VKIEPxjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/K+gH1Sm9jG+XnthQZpc5NxOI4KPZSmpnHIbMAA8t+dG/hJsG6Y9YHO7f44oFT7ROIGOPrwjJgTdgNKXkqq2T4zNPiQM2KVCjiGEzxGeUFaMtUcpaeQ1EJLcfX9HTjgjV8AKBhNk6zaWEJuG/nGrBBXN8N4a+13QtYE7f0A/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kMohdYAY; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e11988708aso615968a34.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Feb 2024 12:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706818400; x=1707423200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R7QEV01xCBNWzJgsFvAy5/1O3rW/XxKsJIx3OsRL5eg=;
        b=kMohdYAYzDNWeOlMt/5fNf1WaOjuYJsSqZSEjfpxQmIfwtYB1ZmfaVChdWrgleZmP4
         Nukn3dMKIdLCoc3RisUrvxP2FK9RHYWQB3U2f1kObz6ADyEQDsXvvBFvUP1nDLkE79Xp
         RW/VOTOkECabTR2wsl1QSUNXDPjvg4F8u1GOFAAH9Rl8GlUixZQVIgm2RyRLH7E1jogo
         gVfjKNsCNitGSiCF7zoCxq1owPol7lPeAv0lQRJuhmuH/n/nWkqb4WwNfMyEe1kZp1Fk
         RdzpkuW3D0SzxYf9klkyuqP81I1iu9NcK7JPr4jfaiXNmVXFAaWhNDOeFV3VNKDHAymT
         LY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706818400; x=1707423200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7QEV01xCBNWzJgsFvAy5/1O3rW/XxKsJIx3OsRL5eg=;
        b=OIDiUod8wgXVh4Ylc1VPS1o/l1vcil/Ld2V8sTyCinV2soJJMudtSm59/BXxvUqEnA
         x21akkkOlZXAXjTH4PfAr+OP1oC5hNaZ8P1zeEVkxXyCq9IhKWC6wOzBSSh5sSwuiGXy
         ErAwhg0NB4/ku7niZqNeNVFA4dcTbEO++zP/Eyz365OuBLe9uOQgkLwSJ05ClRzWHn/N
         cTobnvMJYdUoqmUOVBIRoLN1j+ASzd5yRTszqFyCu1N0pmfvJsMyT0CkRdoAWjGME9Oy
         WLH1pYEwz6HFpbnS5sF2UXZJaijXIEEx3gx5sVHZBJ4c6kVSh6rUjpChb+9YLfgJ1jdN
         Ak6w==
X-Gm-Message-State: AOJu0YxZMA5dsO3p0MYxUTWQylpfodQUkrydd3shsdOrL/rCy57qRqT6
	+dGkL0aU5SFrES+IpIqPq+rOLMJRqHqr1GidZ3IFEQaD1PfibmVV+kolgFr/tj8=
X-Google-Smtp-Source: AGHT+IEoO0esVILVLBHSfIiM0LzVYLmXhyxjHGJlvvZV+mC0bEUoMNDe5BIndJsesPVR5e0QBmBuOA==
X-Received: by 2002:a9d:63da:0:b0:6e2:78db:c405 with SMTP id e26-20020a9d63da000000b006e278dbc405mr1831965otl.21.1706818399695;
        Thu, 01 Feb 2024 12:13:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU8yBM3TZmRzH+7atNVE1qB1Ckhad3RV1uP0C2+FQQ1kx05pv9bnOOX6YjqB1Ovc23NOF8DIvDZhD4F3ZE5eNJZ/pDxZyIQVDDYYrdlhYdtwvxoFYyS2bW83swGY6A//inIJeTBq0uVuc7vvmpk87i55X/VMYXy6tJmXkR6aOSxhrrJgYgkmkEFQwDvtotIqeWxsTPBQcA/TolKetlOrnR9zw==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a056830150b00b006e11c86f1aesm89239otp.60.2024.02.01.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:13:19 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: wilc1000: remove setting msg.spi
Date: Thu,  1 Feb 2024 14:12:47 -0600
Message-ID: <20240201201248.2334798-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling spi_sync() unconditionally sets the spi field of struct
spi_message. Therefore setting msg.spi = spi before calling spi_sync()
has no effect and can be removed.

(spi_message_add_tail() does not access this field.)

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* fixed incomplete commit message

Link to v1: https://patchwork.kernel.org/project/linux-wireless/patch/20240123212135.2607178-1-dlechner@baylibre.com/

 drivers/net/wireless/microchip/wilc1000/spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c3..7eb0f8a421a3 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -300,7 +300,6 @@ static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 len)
 
 		memset(&msg, 0, sizeof(msg));
 		spi_message_init(&msg);
-		msg.spi = spi;
 		spi_message_add_tail(&tr, &msg);
 
 		ret = spi_sync(spi, &msg);
@@ -343,7 +342,6 @@ static int wilc_spi_rx(struct wilc *wilc, u8 *rb, u32 rlen)
 
 		memset(&msg, 0, sizeof(msg));
 		spi_message_init(&msg);
-		msg.spi = spi;
 		spi_message_add_tail(&tr, &msg);
 
 		ret = spi_sync(spi, &msg);
@@ -381,8 +379,6 @@ static int wilc_spi_tx_rx(struct wilc *wilc, u8 *wb, u8 *rb, u32 rlen)
 
 		memset(&msg, 0, sizeof(msg));
 		spi_message_init(&msg);
-		msg.spi = spi;
-
 		spi_message_add_tail(&tr, &msg);
 		ret = spi_sync(spi, &msg);
 		if (ret < 0)
-- 
2.43.0


