Return-Path: <linux-wireless+bounces-20962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B5A75924
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 11:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13449188855C
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1493516F858;
	Sun, 30 Mar 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Zvk3xP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E44184F;
	Sun, 30 Mar 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743327343; cv=none; b=ic39ZP/4WI0vaTqurX0DflAs5uZuspJ9wMRMgvBL7/bRixInN/oQsShuxCp/X+G1mGZjrhHgRnWVbMdASLvxOjdzVFx8fNkI/XbfsyFgFrW0S+ujYkUIF+CAgtlmfVlqRxzVBFhtBGxY1XCOPNG8Z27AgtpGC5Hko+8bA8WREKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743327343; c=relaxed/simple;
	bh=vn4RWc04KCOkhQV8qOk2vm3dDMRh2QxXa9aIxVcgOm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGGOYWKsrPX7wDIRp0V7Hxu9CtNOHtBMRoRGGzJtYUWPFBtpVkFsWBHUF4sfVTUfacHfI4Jr+467Sd2qeNJuAmtRokIMPeuNn2SuUVkE/Py5qqxanvs6v/sbQCN2i8ky842zkbFX3JYkcFvWmCfY7uf9K0LxFIhPWh7cL60OJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4Zvk3xP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224341bbc1dso63694535ad.3;
        Sun, 30 Mar 2025 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743327341; x=1743932141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=damfXkqqkFLAicUXgLIJ1TCRf/zr9UzA9ia0GSR3ds0=;
        b=l4Zvk3xPjhkjb0Wdo8myRhie3HEP44y/CD5uxfHP1rW8EzIpXM7pkAkKgJrhozK4Pz
         sWiMKPGeRKq9RXF5KF26FswXZWIL1lLo/2g0VxoQJZmHsYLJdUprb7uYLevyal8rtGCr
         B491AfZkcC27kv2fJ1wytu1nm7M3m4JuybqU8ehs+AvjkBhcUWz2NXR0k/n4csvXLuMK
         e/ON8eyCXhr6A63xhGCeruTuBYmIsn1FGxosYzgbR/NvV2yBJjtx0flcA2gRphId3oY7
         +9BIYAG5kUUTxlELvnUOf0au9l9/gGo8Put/JJ9kAY49NvDQoeyiCk20HoSS7gQ/KzXL
         Njng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743327341; x=1743932141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=damfXkqqkFLAicUXgLIJ1TCRf/zr9UzA9ia0GSR3ds0=;
        b=avDcxqADjY0vkorV73wg4cOafhQW6yi1hm1o+z5Yy8EFzLLNkB0G1fiuxA7y0RIIwU
         M6mrJ+a0buqPZ0L3HMJ7n9+CN2YwFIwM5aMR8dAize8m2of7cd4IiCHlec2sw8E/R496
         rq7XAKueN5ExBgW+RXMLyL5/Esu5NO+J50MPxz038mc/s7Xx/lUgYIuck0FPW4h3Fc1E
         9T0pL5zQ9K6FuzjUibILpgDJb7rlxbJTHnq6gnhmxAvVVw9t/M0Y18quokCHuftQOZcS
         /6RcXvFBjnbgncr/9w0zSltJZZ+scDLRf/AvZHjwJ8aFJU85M228oEPTaGU45/uYLV7U
         B/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUO/w8vAe7H9uQsAOBe1U/c+GgjOalYNOL0cLCl6uKngXYwzbanVkF3W+Ne0Yjk0e5iFl6fO0kGizFfJTO/rxI=@vger.kernel.org, AJvYcCUTulJjUaa3Y515qecfdxw5TBNAkWT2iQdvWmxrzQTvu0K9vD+iLxkxkyexgDfeuGRsW6qxmW91U3+m3R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqnHTIExsq5+kdmjfqcQFdFhNml4aA+c1k0jChRU8KPeX6ltL
	1vmRv0m7tRjCL+MLPhxk3/arwwrbmQtJ6PVG9Lwr1SJaJ3GVGubmYCerbs7f
X-Gm-Gg: ASbGncuEQ9AMsa/XtdNwC+xfEkr+a3Uw0aSOA3xpwaWQdRyOVwQasCHZbNvzgpP4EVQ
	Pl3OuQJ0zIq93IZMHnz6jq8dj0xHB+kQpeqG4rXex/yD4jGPS6cVl9q0PPWZdFmF1l2gPVVQaiU
	vMyvTuBRrEA2DgfHzLcucZ2Ghe0a0RO055W5EOrgSyxG+DMvWS7nXOs1rNajr/spU1mqDOD7uUo
	nRjgFo9CZvF0SOPL9+37KPchjmuXHMclDcENTc0ynh3EjlXry5qEFGKq0sTt/0qmlvjA/YS9J6G
	HV0u0BsEHsYCUeNuloi20m/w92lF6dpSwGFiYkT0nb0D0wB/vUq/oZk116nJ
X-Google-Smtp-Source: AGHT+IHhL9J7HVAOvCji2SXZPw9XBxF0oBbuosaUN1df+eNPc5La+nJ642KSd3mgYAb7xdCZcYJavQ==
X-Received: by 2002:a17:902:ea02:b0:224:216e:332f with SMTP id d9443c01a7336-2292f9fc054mr83797765ad.48.1743327340880;
        Sun, 30 Mar 2025 02:35:40 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.226])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291f1f7376sm48560055ad.245.2025.03.30.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 02:35:40 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	jeff.johnson@oss.qualcomm.com,
	abdun.nihaal@gmail.com,
	toke@toke.dk,
	jacobe.zang@wesion.com,
	u.kleine-koenig@baylibre.com,
	megi@xff.cz,
	sebastian.reichel@collabora.com,
	saikrishnag@marvell.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix memory leak in brcmf_get_module_param
Date: Sun, 30 Mar 2025 15:05:05 +0530
Message-ID: <20250330093505.22370-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for settings is not freed when brcmf_of_probe
fails. Fix that by freeing settings before returning in error path.

Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index cfcf01eb0daa..f26e4679e4ff 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,8 +561,10 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER) {
+			kfree(settings);
 			return ERR_PTR(-EPROBE_DEFER);
+		}
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
-- 
2.47.2


