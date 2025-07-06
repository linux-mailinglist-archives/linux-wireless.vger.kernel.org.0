Return-Path: <linux-wireless+bounces-24854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10DAFA7EC
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320FC1770E6
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600412BD024;
	Sun,  6 Jul 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWxI2NAf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5EE2882C9;
	Sun,  6 Jul 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838078; cv=none; b=G8rWGrZC+xr7oPHjYA8zzd++V4MgIA3hMkuLGTRs28KS1Po+CNDjc66ny5BD3EYEtM8VMuxBLXxAUInrQdcxMMXW0fosCdyx7lakqQhWL2fi2gIPgdzgCBx/sMDX4oSq3cWETe2e3x5iVmS3CnXWNBtPVUPUqubKfEJr02EEesY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838078; c=relaxed/simple;
	bh=b6gbwR2gSs7Kmg85siBAQ4vpuSplRso9xZ9HTGNhXoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWUWMzQlKVhiGzcNEE6mQl2+UuawUXG/Obcpsugl9sSbzePAl+xXpi4B5LrA2GezTNSYvg5dUamNudqEpqsNbay8urlSrcyM0lrQIVnSJ8Wn6iKQjr0gSivrjZ5MY8gvYGJRqg2OlPUu6f2iYQQFQo0/EiCqr0I1usumJ8Gu210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWxI2NAf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74924255af4so2283363b3a.1;
        Sun, 06 Jul 2025 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838076; x=1752442876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX+WqYiCw5qRjWmx7tMtJD8AKsU6fZ26cq9/PxDn0ME=;
        b=gWxI2NAfQ0FFXOdknOIw72wZC+nXmRKtWKX5eMU361AR7TFgb8VaBnvjETuELeb12G
         jgJIwQ7DPz3kbrgLMV7725KKtsXzzDRfW3E2zUZ2ideKVOlVNj2velQDIb9JIPiY9GNq
         gvIuT9eQJ4nLioW+cRcI0TfKSHFwQ+GEbZY6WGibVU2AThlEOd62g3+9e1YfA4+O+KjS
         3NL/VMwC3fPKoKHqH07R7sRFsfkxR8l1EP+Ru8kAaAm2k4FCzPnAWTQLc6TrumlCv+KU
         8UJlRQOZ7DpWoNLVfZlcMfIrx5jfNe042bZU1KrJAcj0tKs8zG+zY9dp7lNRbBCEJl9q
         XDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838076; x=1752442876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX+WqYiCw5qRjWmx7tMtJD8AKsU6fZ26cq9/PxDn0ME=;
        b=W60QoK1i3e594GBk3oKM5ncDR0zZ97op14VMsheZ3D8+P9M0TXF3m+anJ762U1yBji
         AUZRr9LH7bjBjHQOIhVNvsN0C2tC3ptUsU2IGwszFdxjaY8WJTToTDOJyG85a5rzDbBo
         fcI0PSvjzZKUdf5g+YZSaoRvIrU70y2Jfj0VTwWz9mVbVCcqPKcl++j/JeJIFzh97o1m
         o58OYssUXUnY1YqJ9PP2DPImFQ+QJboHoNzafQYmF3MrAp5qfqCSV8UTPp9UblekFWND
         TXuScjKQ8CmilaQZx2cOwMdjMhURlRMHHCdcOnrTw7WlCJjlYueOxwO64rXJY4MY3y10
         ns7A==
X-Forwarded-Encrypted: i=1; AJvYcCVAh22V2VpjFycAQiaatsS+B+fenYBh5SjIqJ7BGZ+TRJgwDKfeQU/nIrWocq/neUrqYvmGyC4bf3mg@vger.kernel.org, AJvYcCVg3m/GDgMzUi2DONx+rXe9HdbvNKaA9sr56a1EIo7Q8XTz5eOeT29aXhfbAhzKZUxM3CQL1kglcJBWqQ==@vger.kernel.org, AJvYcCWHEt6LwLUQhgebfOTJWO491/ReORr6s0SoqmixgSqeLz600+IDlwEqmv4L4zxXO8Kqkt62aJTOUy0T2OqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4P183JQY+pxz8aMvea82h+yjgeBjL/nBSUoyxeZ5BeuGpBvwS
	AJ8rxd1iCN1SNssgLVqnb1ygIwIXq/K1MSnXiBCYt04xk/iIUJhvdE/5CWhy0UQfgg0=
X-Gm-Gg: ASbGncuj7dfLz1Nvba7i0qbGzWjxMvP7Hpcg2T76bsTdAO9iNUxoYAHksltqKogSAN0
	xbZn2RZiQOOYjHx8YjUdIfiNcJ2C7IR2ycmZW+3jbfFYoMxwaSpxG56e3GXzg4g787Fz56IsDKi
	ceICE2Nh4uduFb/tyLN/eZu3/LmnM3Aqk93RM5IUNJURzZByotPdaXcN1CBMz7YzhVfeabUmZED
	cmVhouhhHottgFOc6r79/WZ4UEJOS7dMkw19jG751MjnpUA9k6mjxopFcJJWA2uYMRZ/cT3YD2d
	+a5SdLGIwoZg2S38EgvhdNQCdMuThIBBx7xB866p638=
X-Google-Smtp-Source: AGHT+IGfAFzujLmWILt8UVxmRYxZiuG97IHsQSc+DfTggeEZMyI9sqg7u8YqmP6IrvzcHwDGVbxv/w==
X-Received: by 2002:a05:6a00:124f:b0:746:3200:5f8 with SMTP id d2e1a72fcca58-74ce8af2e9cmr13029730b3a.22.1751838076031;
        Sun, 06 Jul 2025 14:41:16 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:15 -0700 (PDT)
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
Subject: [PATCH 2/6] wifi: rt2x00: remove mod_name from platform_driver
Date: Sun,  6 Jul 2025 14:41:07 -0700
Message-ID: <20250706214111.45687-3-rosenp@gmail.com>
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

mod_name is a legacy debugging feature with no real modern use. An
analysis of the underlying MIPS setup code reveals it to also be unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
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


