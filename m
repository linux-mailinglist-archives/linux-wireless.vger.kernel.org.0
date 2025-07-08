Return-Path: <linux-wireless+bounces-24995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D7AFD815
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53F248803B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CE23E33A;
	Tue,  8 Jul 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbWs5jjA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666C1E5705;
	Tue,  8 Jul 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005871; cv=none; b=dBUVs71Y6ntKynl0hwr0WnoIXLrW8cvpRtZAyP/OxyOop14Jiss1u6hRrVEN6XTwguSjmDcBNpPn2p4hOqH2or4wWrb1CfwlrSHM+H5scPMT/JtMoVRnfF9Wh8HcpW1+DncW2X4ELL/BGLIU5TrCmo0KpGRO26O5VZrh4iVjiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005871; c=relaxed/simple;
	bh=YCkNNYbUlQ1yp4wyqrMiVxx4dJja+wuo0vcVuYc41DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm0saeVXoTQgUqdaIm0v9n0W1Q+sxCOp5aDvGE1aXWLarh5tWgo3BNH/OhqovKu2CZzfOOS3BADhj1ksRfHbgJ0GvLrN4ll5elRq1hjA+SU9ZXYbBd227p7qe5Xbc9JsoWQE6lkeUC9WADQTKpMc+K8YRtY5Aky+61NY3B6FD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbWs5jjA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74924255af4so4216363b3a.1;
        Tue, 08 Jul 2025 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005869; x=1752610669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scg75GovixsEvdVxNi0J1MYQaQj+4lzopjkTkcLZ+rU=;
        b=ZbWs5jjAWHkcsCLpmnH6S1hs7lSJYqta8bNXEbgyunkTkJ7YvsQbckWHmDiJDCTboG
         bvhe87GZTdFhZn/dkpLITcatXAo3WP/kgJZCanSw79/okibPDraBUpCO2g1ooyW6DA0k
         P3iOVb2HWlSK3JYZ/aCgbQadoA7AQq6/JMdJyKqPHqHkK+2BHG9liBJCAZ9UlnFBEyFJ
         T+dzQcGkmDmC8R39yt/K5pXyw3c/eKEEVdOVg7aDGGxGu5zZq52tJoOZ3mps2D+TTt2t
         8gAFvBHxKxR0N1aBwWk4rMlhYGL4AdyyfyQ3/pCmM8LVaHTLXXFSSkA600Fxt7vzVLim
         DK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005869; x=1752610669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scg75GovixsEvdVxNi0J1MYQaQj+4lzopjkTkcLZ+rU=;
        b=R59lmeMgHfEZvNVBh/+63OSdcI6qg1C55WLt0yK42CDjpYCVHYfSvfUwolVNDRekMD
         niCPBPdH/AtMYC0EnMKEDp+JM3fHI5LeOi1TXTaFj6m/5+XJTkvBpBKNqrtfWSbKIpWI
         0FBWgUs+MCzN8JPp7Mob1O3o4H/Ee8Denelq33areKV3vOL7HjNT7Un06725hbGhfpcS
         UZ3t5jgjlD84IbABw7HQvgNW3XEhzoqNd3SKU5UFMumh5x5jT3i1lz43q36xceWozJZM
         sdASjLebfuF9WXDpYO+wFz/HemFp8yl0IhNIIiyeW5cubUKjH04DiWHWotWJ1E7AZt+X
         FTgw==
X-Forwarded-Encrypted: i=1; AJvYcCU3OO3reS0Np7OxN9nCcayZ3x1IIRzq6HApjL5V/gH5UGvOBVyQ8FnPgBdGOQrNrTL4uBk6sqmfuh5h@vger.kernel.org, AJvYcCV10S+j/XCw4eyoXz8tzPf6ydU+4m1J+Qv5bTU3ZHtoQtlR3ix5UntYsZ8KR4YFVYw/bXoJtc1hQEppfQ==@vger.kernel.org, AJvYcCVhLgzQCEh0n8etRg0qr3vOvq6WwNcAMHhXl7pyyFUoIRLstcHuX8NZ7wzUuRlSUM+h562uxAkccahVfHnA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6+TjZNkNe5CupWGRUF2zL981ZwNWqN/u9TP0SA+eYglvtHdB
	Mpf1MQTMNxcqJeR+5/YLjI5rgfrh8ITwPbXyvvOOFuJ0Y5fTWVN/J9D+b/DW30U71dM=
X-Gm-Gg: ASbGncsunXw7xoVeqYhUsuO81HO2JX09SfLNCxJOJFlfr4lRtJyKPbSHzGzYfDn26OH
	nTn4mQOVCeiffT4q+yOIEas7PdZdhlm3IJ9KEizbjYmKJxFh/h9CJeogCSQHC3iSNkF2b1WG4vp
	WTTKzvV0Ol+0oYP0JbfB+s99tf1J8Lj3I9aPi/FpdaGFtAvOZSc2Z/q2L8+KLtXoFQ5vHNblEw0
	gETHfOzzKjrMK2dTLAbWQ7YvngoQZ755+ALpLfOgHeYa8B0/V5EgUHroDSTAEgjT56g7PEunD7x
	UD7UGBaOjlk4cCzK2S4K2sYYvQsBhj9879kFHTwl+is=
X-Google-Smtp-Source: AGHT+IE7gQhVAwp9fhcqycOua+SFs2Dl3cKAYG1+itewGXdulvInrIn8vF9et5YngO9DfMMful4Iow==
X-Received: by 2002:a05:6a00:bd93:b0:74a:d1ac:dd48 with SMTP id d2e1a72fcca58-74ce8af6b1amr22166596b3a.23.1752005868808;
        Tue, 08 Jul 2025 13:17:48 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:48 -0700 (PDT)
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
Subject: [PATCHv2 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Date: Tue,  8 Jul 2025 13:17:39 -0700
Message-ID: <20250708201745.5900-2-rosenp@gmail.com>
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

While this driver is for a specific arch, there is nothing preventing it
from being compiled on other platforms.

Allows the various bots to test compilation and complain if a patch is
bad.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
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


