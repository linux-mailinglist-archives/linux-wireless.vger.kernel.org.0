Return-Path: <linux-wireless+bounces-20967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F12AA7599B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878A9188DAA2
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85F1BD50C;
	Sun, 30 Mar 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le/SIPUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86458184F;
	Sun, 30 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743330899; cv=none; b=gnUuqft5cJjyHG+3mZEHKelQ+GSkXE4Vrn7Vjm3Di2J9YeLl5JE1+psZgvckNH16X2x4dpKWsTfmk4J+TWtGmTDDVgpQamm6KsP/gcvXKGOiLzO/qieJ5MfAyNgUo3KpNOGx8qgufqDvGi2ROpPGJzvvUd4Ekb3Njn1Q7YQe8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743330899; c=relaxed/simple;
	bh=CTFnlW/udSDv88n+9dJ8nEXvEm2pfyeAT4QAhA1DEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXVnLJYi1cXifPJ2DNGkVzmjHTqcvl7H5xSa5kVOzLS1idSQ3bYgjp5Mlpk+eDx30K6Xcn4KBvpoXM5aOr976p3dvKGFKk4+NRMN/jl/YuNrcX0dZgicMVyvE8Ovh4ne+xkdZCsXBixXgAD1VGBKqgJBq7m7rEsM1V/W+9CXhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le/SIPUB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so44506175ad.0;
        Sun, 30 Mar 2025 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743330898; x=1743935698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6ILafFdAuS6ZwMjkWQd4TNYrYxem7zRVOv+WyE0Dgc=;
        b=Le/SIPUBaYtdjtNTcbQ4c4mnRYLbDZZoBDpAhkLfDbQvJ1Ru85EOlmqFQwimNm4eku
         4QdAKW21vBY4zXOiGug3a0x1JI5V/XT4LcTIMjhtXQJZIlRfqZPtdK9UkVsw1/PcyEFz
         IbZ5apEucxagF5ZsBSc22LTkfJ12vTjQEj1Mf2O2G81mj86P2jHpSiuqHx9i2VmVf416
         xoXUW1McyMhkZIuW+0I4G0EVYoN/E7Tyy8+/W7ISDdkaraQGV6C2FmoGbXzBtWL0k8QX
         UxO4yvYFu8ltafc0/7n5v8yAB1kX7HAwt872zvyrUW+fhUcjpA5XhPHB9fQwWhgxBMB+
         fCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743330898; x=1743935698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6ILafFdAuS6ZwMjkWQd4TNYrYxem7zRVOv+WyE0Dgc=;
        b=kKUWWM+6EXUbIyWUD1RrPxyqrWm6eNZluMBh2t+FRWHGIU3fcLOZ4bB8u0xcEFQ4Jg
         TkMglnfH9lYUjFUFc4TeRKV494RyFQUow1FwgNPA7adrXc0JLU1iLJipwop/RKA3rLuM
         rEcqiODvtN2ZygauOjlv6DNMKgXVGMZJPUyeNYR4O48nwpUg1QOQB66kTTv4gmyJG8cC
         hkB7JW+fMyqHw2isBgELBoYqaS8LUbsFPgudnPrrxdAQ6iAzyIzWmzWNHkF99b3Ssouz
         sUZOP/omvve9cWJB83UPfDhe4WRTcKPvQuin8wzM2H3E34xnPnM+KbhuE/VR7VOi5yd7
         Jlxw==
X-Forwarded-Encrypted: i=1; AJvYcCVJVu2k3b0sZrPbJb9ZcSxcKM7EPAq+EHR+NTfFr3PvNTrTCa0CVXOOxd+HoswzbL4ss5ybppFdNMGCyMf6gtA=@vger.kernel.org, AJvYcCVQZSwDoUXBKnq34v4Td8AGwD5soJbwcu1UxIkpGSgznuBo/WWrHhd4IyudxCUpO/FYI3K/1IOsk1drczE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2dkZ+rCB7fT/04eyt/jD0o5crNFeDt260UT9YwDn/Y3a7IGK
	odGWsX4HZ5E61+iEyYG4sKIXR/XUz2QzwPl3v0DRDW9Z88azwUur
X-Gm-Gg: ASbGncs081GMrpL87AHQIhAYocaleieql4rPiYeK+t2riA1koC46AlVB4S7BkKZacru
	iLMHLrg3yXf6tNhodbSlsxMgO2+YEHSGTqzSgkzYoaXyVtHmjoZWP7EMc04zZa73Xg5eGrUfW2k
	ZKHehxUXAp6XRtCJBAg4h5FmyS66r3fV6/QOkBsewQxTXRD+xznRVbcmfXoHn0+PRpFcuVS+UMN
	1IIpCFIX+azM7jEByyfe1vXsQMynGsQBMKrlpD4lkvhZqg/q8lTVsTDdwg9wEUXY2Lwgjy3/jVs
	P+4bcuNfDsmYh2J4jrnT5uqWl9656egALCqVeZBxUDDYEPkO3UFc2bkqEtH3
X-Google-Smtp-Source: AGHT+IH8jyiJdNbL2Tnz5sqZEPmHYfQeGIc5jmN+yL9P7wGGppF5FQlkFCFXB02xpCFhvQ80wcUgUA==
X-Received: by 2002:a05:6a21:3408:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-2009f5bcdfemr8257677637.5.1743330897784;
        Sun, 30 Mar 2025 03:34:57 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.226])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-af93b67f3f8sm4617113a12.7.2025.03.30.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:34:57 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	u.kleine-koenig@baylibre.com,
	jeff.johnson@oss.qualcomm.com,
	toke@toke.dk,
	abdun.nihaal@gmail.com,
	jacobe.zang@wesion.com,
	megi@xff.cz,
	sebastian.reichel@collabora.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: brcmfmac: fix memory leak in brcmf_get_module_param
Date: Sun, 30 Mar 2025 16:04:24 +0530
Message-ID: <20250330103425.44197-1-abdun.nihaal@gmail.com>
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
V1 -> V2 : Add subsystem name in commit header as suggested by Arend

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


