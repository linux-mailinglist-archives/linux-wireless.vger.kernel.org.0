Return-Path: <linux-wireless+bounces-25322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DCB02D0E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A919A17FAB3
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C0228CB0;
	Sat, 12 Jul 2025 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4+GZRBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362F1E5714;
	Sat, 12 Jul 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354293; cv=none; b=GvMDCHA5oFGoL4mfhnEysl2T7s9akz/cu1p+tn444G5lw8zPUcOy0rauLXklLiKzSGDkmzN135tjQo1+SZbgNJvosHI+TENOmWvdOaZLKuOnoRId8Py2JN8J1ahmrVXRoIvy+a5Cg1bdtYylSHOS2HEzn6WNlKFjCeE5zkcGUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354293; c=relaxed/simple;
	bh=qNyJkm7PeaSYbzvL4wRwzO+7J0l1FEJhgQ8HD0Y7GWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAGpQa5X6fxLuNLGetBTSY9NBT5T/0ewY7gfIX6P5UKX0KPXPCnNshAtImxCUEDQrknxckTeJy75hOw89Scnrd8qpWlxwf/uYnDcyV+LR2C5skupwiihZJ+ygfiT6SirvEcwYtE+FRC8SgWjC4Pk6v7TMUiYn+lSyY63VXYxpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4+GZRBL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so2996153b3a.3;
        Sat, 12 Jul 2025 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354292; x=1752959092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfbqWqhAF1GPPRiAu1364uXMrz946WcMqg/i/HnGuaI=;
        b=d4+GZRBL2BQo6rX5TMr95dLCrMdvFdmgk0/dvKPV8uTQ6NbCbu/wBkMF3xOutkHLST
         A00UXiBwpkpW7WU7BnAkVi59nCnlLRI6wQ2MIpXhpVZDGYxZa8SGGNpcqx4O+GsutgT0
         XEXsnYuEC+L1P1nuqiwLRW/ykmHMHnyZxs8oyQGSZJ/OdZNVBZvRnrQfHhyCYnrsePxr
         w4gfzklkOxfwJeZBf9WNvGIK3yl9G3WoJ7MKqXX/WDA8fgQ3fRKUsbFQdxoYueefN9Ex
         G0GIPiicxPM5D8TLXysKbRM6e0BK83ZixgfEl9v6bK8URtQAtWuydjW1l41rAE5hCVeQ
         GQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354292; x=1752959092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfbqWqhAF1GPPRiAu1364uXMrz946WcMqg/i/HnGuaI=;
        b=vRtaZQFfVioX+6nDR0VT5iASBAExJfSaPw8iZWqqIa2V+38ztp7ZbYMIn6tFPv5jfF
         nD6Iy19BSv5EF9XsXpI7uAqiD06kEf7ZHm2XhVmYeLMXwfimpuznaS+dIK/oZui2HJRl
         uHC6sLT8EyfP/+SRVLZKsrgsb4PG+h3nk1T1AXB6R/xR9Fh8pRqn1xsAjCvb7UlIt9AI
         /AXECdC9qyojyaRcerb+JgyulJ8MJ5+UTo4/5g4HHxdRBG4kSLHvU/k8XrFkUHZ7+zMw
         7LWwTlCjGaQgcpIXWJNyZqkUKLZ2x54QniJa8fCsErjtUYMuwQHiH1cIjc/jNX+eWkpm
         aOUw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YvrnJC0oqWcE090o+KCsXnghyFgV142HCGgqxT4q0arasXQm85ij5vgViq7Bf0xb6ZvOWUD465bYSAiv@vger.kernel.org, AJvYcCXIP3DbKLTvAZsFbcIZbqbBwDcefYZ2lFkbgzbDOshXmQO6PEVx98uueAdIyLAi+mPHxD1Y0WVzBLgF4w==@vger.kernel.org, AJvYcCXWN+nZV+znfaoCM78xF/MofF56vehrxcjlLlfFzhEaVR/beok9E+v/NETZ4uHogVPXg6fQF7oXR84o@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/7+OfUQyo6H65mJZOcjAohHQTSguxMAVMdnfs5N0BEfBLESN
	umTSjlKfLmMWSiHS5fmMCWTfeFeb3Xa+BN8BMJeeAh7yS9ZeyEhxjlUg0g5NEvJ4
X-Gm-Gg: ASbGncu4lFemLpn1Rik0y+gyo3LpBJGkh+zJU/9Z2glVRMUVZhaDEPvjA6/UZacRLG3
	1ndt3y4O8vmD4RtvZzBciUzDUo3HR7WoB4dVakNKkv/21bp4UGTk3ROO38QoPv98LiXCqYY4FDm
	eS+N51xpLgiiZOApC7dFi5fJ0dCaJBrb995Nbs/X72qRz4b+R9YvRVtYUs9aQ33VARijGm9NjRJ
	WiUBdHf8x2fSf8MgGjRLCgH7tb+Zsa+1NSa+/LIoLXoF+yWZi0l2PmpKfnVN/HJuo1SeATn5yTg
	IAWuyYdCm14svFYVsFMvVsG4mXvos0n7yzBCgayNOfMlmGd6MNzRgWjiZTY+IPt4CHCI8wxvvhk
	mYzo=
X-Google-Smtp-Source: AGHT+IHNhPABi5WGgAsr77y9g6llbfq85pqYA/U1Ld31ANa2lqUSnt9jUyA7+28dGs1pA54AczxQfQ==
X-Received: by 2002:a05:6a00:10cf:b0:748:f3b0:4db6 with SMTP id d2e1a72fcca58-74f1e7dffdfmr10394456b3a.11.1752354291601;
        Sat, 12 Jul 2025 14:04:51 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:51 -0700 (PDT)
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
Subject: [PATCHv4 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Date: Sat, 12 Jul 2025 14:04:42 -0700
Message-ID: <20250712210448.429318-2-rosenp@gmail.com>
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

While this driver is for a specific arch, there is nothing preventing it
from being compiled on other platforms.

Allows the various bots to test compilation and complain if a patch is
bad.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d1fd66d44a7e..3a32ceead54f 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
+	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
-- 
2.50.0


