Return-Path: <linux-wireless+bounces-22965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B3AB7AAF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785F04C73A1
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 00:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8D25776;
	Thu, 15 May 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvYn/i4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD808F66;
	Thu, 15 May 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747269789; cv=none; b=SJmUURFhBO1WKbOlmXhMztPaFdBvLrk/Wts0Bcsa5wpx7b76QJmIFHJe4sa3gwG0EoCj29Y7+Q+xSg+p/2EW7661edD2evHCaU/irrR9KwZqg0H1nPZO9WllXu5taiPEKGSyNhS0K6zBl/Q3SBwTH1N5uyTLqw263i7o5dXUiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747269789; c=relaxed/simple;
	bh=CaZ4C3YksYVpPo32yraBL2f0bTtgs+Duayou0LWapfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZW2iUNkXG7uZjUqRlLyRxrCRPuhDCVtK09Zulorb9eWKLM33kPLe2MdWxdrU+DpQI+SmVds/jdZHgWSihjVwX0pBsZHqJ1Q9PCEc9wFUMWwomCnVlpXw4ddO1XqV4aDsNM3XoTt+shOsW0yGBrmy6NGXdmJ0vXsgliFxrsuVmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvYn/i4W; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-879c44a1dc4so86297241.3;
        Wed, 14 May 2025 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747269786; x=1747874586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cueXC2hlZsQuDhrii/uQD0jplPg4hNH073llC7Ktm+A=;
        b=lvYn/i4WzfCA3U8fecyOhYOTzQXW2Otj5/d/nA7JP1s5v2dkHUwvpDCA7wKWJntx94
         dI6VmnIWvWJyAAolJdga/rKXRy45kHv8sdLBpEzfzf/CuyrvOLbcBllvuYNmsMDKviPH
         v6uuiqexM4iykGfICRMEXJfW9YO++ESmmqBQouJB+MFgILZSgw4TDZICOqAFURkdQrdr
         +iUAae0xMpQiSF+fdr6XN8gvWB508p+9jsCZ9jC/7u+mlyO1nVfEZrruzzJqTrhNtd9X
         VutqTco8HIx1+UlvqMlNk7XIOXasUrpkDHR5Eo2zEvyGFMRmGA0ajzzoRMnT+KFQQJ+S
         Fouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747269786; x=1747874586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cueXC2hlZsQuDhrii/uQD0jplPg4hNH073llC7Ktm+A=;
        b=fsDcRVCsZKpoOrZI7og8PLk1EJ3QWYMuVQ+dZP6j3xgTY1/p24jBiuD/1P40XGEjKr
         X1XTaOoV9XwUoG1Ek518Uds50k0JVIDg44bbJLHxndzlFdYbC3LelF18Q1WnlqqwbeQd
         7eQjbBBnVhuqWRhC36Dk20iaml8fi9fqIwW99hhUUU6RSI3tY0so42iiaKh5A+Bnpugl
         KI83y/l24IQzyzkADVfocNsnLIt1Qh9dGuqQIJmO2/2lJ7a5B9OB8r5qcDvwm5awnp4K
         OSvRKOHhJYWcOI2SL+cedVNMUvPDvGoFD2ZDeuuawifKAj33++jCo/E6d0joPuzkzXA+
         a0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUD7badEAns5F0lyPfNtORT7++D1NuLsILIEEVA7TrKkujGOXsiePGt+bAzZGwZmdySvcmKyOJkzxEI+4w=@vger.kernel.org, AJvYcCWfFo828+TY4Efj4vcvTK5zJ76/HE+hGZKTEC0pAiuisF9ZHEXRiLiVKs+gzGidguDiBN4GKsG9ldCPFau7IEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9M2xCma1TJV6wVoXDbELn5E7up5rvo2sxSuGR09PkkAn0j9FO
	iAX6kSGgt93HxvX+D4aGlw/hLLMxTOrreQTB1N1yvfxvYGFbU7Yd
X-Gm-Gg: ASbGncsk0Mlp2dIGBl3s2V7LGf/98v6HfU6YIi00qjQttvb/ETb/Huiuybb7upX7Ipm
	haxSVKQ+yqX1uCN6crXWUPioHykoa/Vnna6+Nrg364SKsFcy9aJpKna31q14sPEbNUXBEYgOWWO
	hOoLZkQG789uAwQ6myGPFR4enzLb8hEnkcSMC5eSjOIRAIL4G3EzDVs6N+UfxzNKaEYQdiY6aZx
	fU3JGRYZ+R+jZ1j6tyn9mt75VhSTvKr+ifVjI8aVXdsWgVWftCRSfQcSGb6/DdPL+ah5hdJH/R8
	GsgxUcBySWlrqRaXx4GWUH4nLZoiM2Ptq19mVBkibfTtkBoY8Y8xvfWAqrAqgnJE/CHOjCYuWdU
	=
X-Google-Smtp-Source: AGHT+IGMCVTHaTAAEE9TyxMrC1UkOXyDv9xgn/r9jfFGP1Q8+03YjUg0MM1rRdEdZGDUJNxnohsoQA==
X-Received: by 2002:a05:6102:4b82:b0:4c5:505a:c1f5 with SMTP id ada2fe7eead31-4df7de00c28mr6031983137.24.1747269786465;
        Wed, 14 May 2025 17:43:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-879f603551dsm9775065241.0.2025.05.14.17.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:43:06 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jjohnson@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath11k: clean-up during wrong ath11k_crypto_mode
Date: Wed, 14 May 2025 21:40:54 -0300
Message-ID: <20250515004258.87234-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if ath11k_crypto_mode is invalid (not ATH11K_CRYPT_MODE_SW/ATH11K_CRYPT_MODE_HW),
ath11k_core_qmi_firmware_ready() will not undo some actions that was previously
started/configured. It's reasonable to undo things during this condition, despite
the value used at ath11k_crypto_mode not being valid in this case.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Smatch got the following error:

drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready() warn: missing unwind goto?

When the ath11k_crypto_mode, which is a module param, is not
ATH11K_CRYPT_MODE_SW/HW, clean-up actions are not triggered. 
Considering the whole ath11k_core_qmi_firmware_ready() function,
during potential errors, those actions are properly triggered. 
I'm suggesting a little change over the default case to clean things up.
Tks and regards.
---
 drivers/net/wireless/ath/ath11k/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2e9f8a5e61e4..fd3017c444a4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2163,7 +2163,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		break;
 	default:
 		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
-		return -EINVAL;
+		ret = -EINVAL;
+		ath11k_dp_free(ab);
+		goto err_firmware_stop;
 	}
 
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
-- 
2.49.0


