Return-Path: <linux-wireless+bounces-5597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F324892296
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC0E2849D2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFE7E108;
	Fri, 29 Mar 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxsR5jrj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1611C0DDB
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733090; cv=none; b=hrB1XTyDXrkBPTxctEXHcq1nTV7sch2C2Nx5zsLtajfkQm0kotm2y1kEGIeV0fWxYt16ELRA1AuqIiatWpq92b2Hq3/x46AwyzbKHVMB8hVVyA5eYdsvqm51bpUseFzlorR4yvBwitBrYpGMhWuERRrFJ4oeZAuaRC0KoVDlN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733090; c=relaxed/simple;
	bh=eEGxfdcCTYxCSdsfWcOpsv23ZxFAEdyVBf/IME0qEwA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OkNqDyf07lSLNQTGF59lnow8awY8UyMZfruYhWT3tGzJ0BnPhkyS0ivpDtCqGYQXf86uPF1HG3GbSfBYiJCpTcuaXPzUBqNbDPE3UTO2r21bdr1qwNySJ1OTpH6/sIQqEPTkEzwPXeJvjlikkdMxayzFGgqpzAc/w/mP1Gxdkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FxsR5jrj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41494c040a1so14878435e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733087; x=1712337887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhpY2/sSxSgf633Uejn3ClbyqlJ5glhXVmlmIc3u9NE=;
        b=FxsR5jrjAlVAictB0bS3qOHkYFKmufOfVv0drLE6LPbnKyj5nMqPntRk45ov41Pep3
         v+W9MtaKG4sUEwkQbn7CIvqf4GNeRWvTrIikuT25ZZmdhriJQ1iGeG27BRbD1PM5Bglq
         fjA+ME18PYlWOruVkwAORrVJ1ONnUzAmfjNZeqBTCWvvj1wItfDyH3vLJCxXvHdenFcc
         3AaOB176F1fOZw2LZ8Hqt9xs4GV7su+E3zgqmpxPJ2VPPeR2sxHjjPQOpi2PecAtK3mJ
         lcbVKQ6L3kn9R9M4gnw2CscumeLBmt4KtN2BIxpYzRZW9jBLlE0fWnBahubb8SBPL6TV
         FR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733087; x=1712337887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhpY2/sSxSgf633Uejn3ClbyqlJ5glhXVmlmIc3u9NE=;
        b=a0JdBjyCtLe+tYpNLKdKTRbgqFPdKUH6Fc+g9cHDgWgwDUfKX6sLkRPemTpi96nIhx
         U7KeTC4HxO8RDCTRAAckTI5KZV94pg9ygUI0AVPdj8TImVY2cFAg6mgSBWqIsRu6NJ4B
         VgRrCdlKco7kar6cZqPGads7z9aurZMsRu1Al8bsO555nDaJd+09z0N1v0d29+QyRmq+
         LU4RX8wgtK85Bp/9sE1HKlfcwDglQ4kOtjoaSj3vzxqa0y1KSYzoL2i/JMuKQ4i5i3lf
         wgOqMyuWFYUTDifqoKIBhNgkzv0zip3F1I8QtCbqtXxP48eAKC6UwuGIRsM5/L6sK/hb
         19Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUNpIAr/Mcpz8JbTvC8gMLTV6glDKsUcYuA62JltujbVQ2zJ4BsfN1TVYhk4I5fTCyDUTbyLA0ZCSt0lYNFbyqnyshUW4y2pVbE7/33Jvg=
X-Gm-Message-State: AOJu0YzCoy2YfiQVjcqAQQj8g5FxTbCnw5E2X3BbZZ0GrIlt4/ZoEEnr
	YvUK7dJjxc/IPOZlk5Ac2IKov/FAchYTd4+rs82CqKzBGe+LGBo3CHzdCDIThMo=
X-Google-Smtp-Source: AGHT+IFEO2bOiupeq/1rDtRC/aMhJZXwmO7jnra5I7uHBa3pijFH7CMrdcmvi0s373UtBtHjwOFsDQ==
X-Received: by 2002:a05:600c:3115:b0:414:8e02:e439 with SMTP id g21-20020a05600c311500b004148e02e439mr2287942wmo.5.1711733087503;
        Fri, 29 Mar 2024 10:24:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/7] mmc/wifi/bluetooth: store owner from modules with
 sdio_register_driver()
Date: Fri, 29 Mar 2024 18:24:30 +0100
Message-Id: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE75BmYC/x3MSwqAMAwA0atI1ga0KqJXERfVpBrQVlr8QPHuF
 pdvMRMhsBcO0GcRPF8SxNmEMs9gXrVdGIWSQRWqLirV4e7o3BjdbdljIHGoJ2qIK1NSW0PqDs9
 Gnv85jO/7AURoSI9jAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=eEGxfdcCTYxCSdsfWcOpsv23ZxFAEdyVBf/IME0qEwA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlWLp0DJFC/xhyQE8KhK45bNEoEr5kpWe8NA
 fcOQnb5UbaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5VgAKCRDBN2bmhouD
 1330D/9XTfkMweODfG2XrR3FLnaH3Zr2uZ/dY2eMyoYxEu0KTLG3NhhtuhezcWz7zl7D2tbB9UK
 aW6s/NpxvXHUfNdDOxG0VlnsxUBNcaAT2M0vixWp8+ZK8pdJ9Ka/vgijrEUSuspUWTnWhLRWaBe
 e+QuLQOk1A+uqpAc32pXtZu1WyMlyH8UGC7um0bX/T2d8UjEx9t8iFn6P9d2+YOnbnupzMULOyG
 OaxRhTTdxY51AfqxDqjpJwQvURBPgP56r0fLdLzbN2EihTvSut00JGGgHYjo7HkOBZYyNHmHkF7
 a5XAsxk235XYdMgeeXzN03hWgWPyVi6do+UVE6ceJ5Fg4JzCQHdgSdqfEj6hbDcWSo+SDggIU++
 v7zrmJk7V93QujfnpWpb9tH7Dz32/c1YZpHpeJKMq52lIKVeY1Uu5cbXKV9Z4CKNr1AvuUNe96N
 yIdYojpfGg5KNOo7u1fI9sWZ5CrbHBK61EYC11w90cdsvcX9gL7gK+1cT96+QLDT9lWD7OcRgQ9
 gmsRazF1JjIynVJMw4UMCMy+xgQUqJvwaHAFuT+FhyNLTc0tpwH+PHMVB4RU0c0v9XeCZ4ZuDB1
 Y1ggLd8QLzYOfE8l2GybSOFzwT+5sphcC/0RlIT8n0zrY2rGg/zlk0s0ebD1NnLCTbAFujltFLe
 qqFVa0e6yTfXaJg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first patch.  Everything could go via
one tree, e.g. MMC, or the cleanup patches removing owner would wait a
cycle.

Description
===========
Modules registering driver with sdio_register_driver() might
forget to set .owner field.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in commit 9447057eaff8
("platform_device: use a macro instead of platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      mmc: sdio: store owner from modules with sdio_register_driver()
      bluetooth: btmrvl_sdio: drop driver owner initialization
      bluetooth: btmtksdio: drop driver owner initialization
      wifi: ath10k: sdio: drop driver owner initialization
      wifi: brcm80211: drop driver owner initialization
      wifi: marvell: mwifiex: drop driver owner initialization
      wifi: silabs: wfx: drop driver owner initialization

 drivers/bluetooth/btmrvl_sdio.c                           | 1 -
 drivers/bluetooth/btmtksdio.c                             | 1 -
 drivers/mmc/core/sdio_bus.c                               | 9 ++++++---
 drivers/net/wireless/ath/ath10k/sdio.c                    | 1 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 -
 drivers/net/wireless/marvell/mwifiex/sdio.c               | 1 -
 drivers/net/wireless/silabs/wfx/bus_sdio.c                | 1 -
 include/linux/mmc/sdio_func.h                             | 5 ++++-
 8 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: 087c142b2b04898c897aa77938d05a93907150e5
change-id: 20240329-module-owner-sdio-abd5de3f1d74

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


