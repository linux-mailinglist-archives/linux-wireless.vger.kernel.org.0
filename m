Return-Path: <linux-wireless+bounces-25879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBBAB0E577
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F6BA677B2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E928751F;
	Tue, 22 Jul 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPBjNy/n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D79286D4D;
	Tue, 22 Jul 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219742; cv=none; b=AKt2nrlkxYqnrfchxKls/Zt7pXLCgspBcMG73s0XvBSkF3xFAjqvDufZ0BYqw7MhcEMcF9oq6eyVeR3KuZfefY0EMyg2WQFD392WvwVxBTZkWHUn14TPZCgpVf2ZFQ7bUK9XzHukaR9Vh1aFU6CM0OqpNT+IIhd8/+Y3xY846rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219742; c=relaxed/simple;
	bh=hzM4e9GQNPdul6p502bI30fon3cLoRt6GoNokcsR7Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTULCjB5DWoeu3XYiIAfsEi8TrjdFRy1bukksHKdNMmzIH8XzG0REbG2n/VFWyLWHMn8vTlvaN3qTsSfsDhxfp/3aNQhbugRFISNDs//mA2xEbViO7cZHtkw3cybKL8OPHxMiDsnOFH8OhI6zjTxNcjil6B4P9Ry3tPVp7QmNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPBjNy/n; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31ca042d3b8so4827886a91.0;
        Tue, 22 Jul 2025 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219740; x=1753824540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7Yy54miT/gWfUHu8Cyu4CItLZigxgVN3p5H0HM5sD8=;
        b=EPBjNy/nBf88XnoHpWZIqioaMJ4Ksp0sPCcH0GjCFnwKifS3seHqWxLPJD3l7jeXDr
         ofByryyoeRahe/qBh/T5nElqah67Mkkk5miC/wljbJ/29unEW9EXYIptSwl8vaZPlWWm
         +Ql73VWW2E/kF8ldK+z9aKyDGS4PscIFdFgR5OO99MpQSWtQNZ7ATCOdgJXwD83boKoz
         n0ESArK1zlrTYVHrrk5pOx1WtPzgGRoFKKtUxi96yTItD0uvhR8YYHJUYdQtIt4ngh3I
         Uzqyqr6nJoLM2kvNhOk7ClAAPtFQOdEoMWcextoV4yrauDrBjLTeQxBDgpJ+Vxx0fhxv
         92bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219740; x=1753824540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7Yy54miT/gWfUHu8Cyu4CItLZigxgVN3p5H0HM5sD8=;
        b=Xezh9ffaMRNcPIsDuBFjwjsyioT01ryHwlnhqKbUSYxF8w18MTDfmzHyg7IXhj0mUU
         3tsSvk+tI0p3S1zj0o7UcZXOvlsCF/9Wrcm82qntWOBAYVXHUPV56PQmW8ApukVqqJGa
         P8JfYhllQ9c9H1wQ1b/y+kg1vDLoD+SkwSJArBrDB6K6MXv8pa0tK3GydENAQr67NLnQ
         FEFSbkNLfv/7zJsVE6Ob/V+gSf9GXKk2hoDbJMhejRIVj41kLSFauNnMkgRYl/84aj6V
         hqeKul0BcZburH5YMM4D8qa5Iw9vN3PILJSsxmhh/EvD5FFbrHEatS2yZOj3aGH0es/X
         lMGw==
X-Forwarded-Encrypted: i=1; AJvYcCVuofLb33FOiDrslu6jGzHRi9l9MI2Ppj0g6DVCz4iDFmkSKeU0sIEhY3MtycmTiFeUg2aZVOC0YtrD@vger.kernel.org, AJvYcCXUYLpxVpxE1eZV/xE0vFDdQjenuYOY6gltGvcrb44IXGTPXAOt94woRaqOKIwGjwQB4hexjruAefUZIA==@vger.kernel.org, AJvYcCXnWdDQTBA9Sx686I143vWWkhNEpVb57CQdiLGbq5KL5MfL3baIoe9QLiHNxBU6heTqJc1DdkgrQQY1uteo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyho8gq2KSnXVdihJO4+uHBmlEw3S+WKQ7jCbWV2qPtdkpBMaEg
	PyHrwOwN4f50+vb7lm/e8jyvFKKc70INYkZxKy1lzug35t/Kbvg6X0Ymt4RCn7bk
X-Gm-Gg: ASbGncsU0Qvg9WdIT0SVkYuItZZOkQrGXJRYZPifW5MeTF9WCim/S6d7slIsOszZc/Z
	OXwNAY7EjwOnq7P90y46vZ7Alu+H5coNH4lQ95cztKWoGmUrJeGrUrFlRLWfSDFUPHM1Rz7CyJz
	a7ZRpAEsCJWysILQecVttxyLzu/rc4vvZflED+9WOqgwzfA9ZDXh6oQX1WC4qS4HMtgJvIc3KO5
	VoBrRnR23EjC+Dg4H5eOuZA/6w3hfRcMUega2rhXLe79uLtd0hhyhUY9w6UmDXkBCrhJlKsjsW7
	fX7jfclyCEsk1Tq6WsqUWKSX2J4K4yZSs3r7HqfMdUDiPna20NCG7rsD9s9R0YhWd+mroViO6/w
	NRyE=
X-Google-Smtp-Source: AGHT+IGO4q762c1r7M7A/2Y82pf5EDsMmw323GEAeChX2rH+Kvl9M0dCW3IK06XLGSI9JA8iiKUIWQ==
X-Received: by 2002:a17:90b:3806:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-31e5075a8f8mr982845a91.15.1753219740389;
        Tue, 22 Jul 2025 14:29:00 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:29:00 -0700 (PDT)
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
Subject: [PATCHv5 wireless-next 2/7] wifi: rt2x00: remove mod_name from platform_driver
Date: Tue, 22 Jul 2025 14:28:51 -0700
Message-ID: <20250722212856.11343-3-rosenp@gmail.com>
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


