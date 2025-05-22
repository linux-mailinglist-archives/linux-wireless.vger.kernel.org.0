Return-Path: <linux-wireless+bounces-23328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD9AC1541
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 22:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0137A6783
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DA1EBFEB;
	Thu, 22 May 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6TJCySC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812D148827;
	Thu, 22 May 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944331; cv=none; b=C9XPeidSmTkIE/IUynrsH4agobrRQCoNQw99LDOa3Dkb/a2FN1epwLpo5ZU5RVqMsRSkroGpyBZ2XmGtqhze5Xh3FOOP2For95XHqmNIn8ukuqe60xEBJrNQsac2Ad+oyPjyrY+2SugkP65b9yNAnN/JV0X5z61MGhppsI5/Pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944331; c=relaxed/simple;
	bh=g62bCrkPGn4DhPfRt4BBU9rJEliO6Mnud/Cr8E48tFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnM0JXE2oUA8VDkijaa7c8JFz05KnvmPACqYhTQ6AeBT1ZIwaK2NKWIDCpyyZlza06kZW22x5NuLYQ64ZKGLp1bRTmXpw2aqwG36abHS1E09iovdfUXY7Zm32VbOGlWgSvBk18FO/sf1REocURJmxuoyESOTX0RFbujqnJeqFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6TJCySC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c53b9d66fdso1143422285a.3;
        Thu, 22 May 2025 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747944329; x=1748549129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wSVqz32Lg2dSnny/+XxgnMzOGKReyfgy7ECXHzhydg=;
        b=D6TJCySC/eB3DE+tB0WW/5HE0IIxZUoqrnHPb6iKTEzqoSkD+Tx7y3Kh/6KrLg6KC3
         dyV7nRa0iUaiFUC6uzOi0SHwiewOqjSJDCeSnerYKUAixZoY7JROrcstrDbhFPZG+E5v
         8WzM2gcltOhMKvIGYe1mC4vq2U4hk84RT4A2OmB2hAYjsrl0jGnlfxo1WbtU+DgvxtK3
         6WvSYOpPUE7PMJG0UMcuAL4jwukUo0AuLOPlqE9fM1BzfuLbP1rBDTchSlrlGV2Jf+6r
         kmxBiqrZIyPI0L+fC9f/8wE4tA7yygR4Fps6Js7tNZX7hfjhaMg27dGn3cfxaxkW4yxV
         6F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747944329; x=1748549129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wSVqz32Lg2dSnny/+XxgnMzOGKReyfgy7ECXHzhydg=;
        b=ByuQjuRv3mb0ZFw5sdzhzxQ7WQiGeSvOt2QHBznFxjm8KCd9zKDWd5+eOlIAcpVQ4I
         9NmnLjbSANNWg9eq7hMb+T7ClzT/rGoF6G1LhW38QQL9c7f88DSN6i9SalnqUERYF/03
         NHR9k5lTIBz5dk1Cr5OTuVU+AS28RIqbFlm+BJuIBEB6KCEJgVkCg9qInSPcveEruOJI
         r4hnww7Zalc7sETh4OeOxDY71ND9eEydr22BhBceTjunlLjoYvS47mrekqX3tZgsnN21
         FBBGy2W4zZWsIvZWkk39v03yp9FtExEDfix64qTADNK9Evh2+ALO2fBsWyVmXhoIVqdw
         U29Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjT5IxeBM4pnmlwTXtOd12sMwK6Zm9Pkqn3qcMpqjmGtB2Wl7hOpmJrX7lj1mZ1Usg1tDqDrVsRvSsols=@vger.kernel.org, AJvYcCXZHRkSfZ2FTgKzluLrS2n3kv7Ou3YXuxPWXG/bEdTXUsepfPcyTZK5719xArDPZeSDkCZSLcTi1T61+yADRJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluRFrPgHI1NOsATl0wMRnnkjZWy3cAcVivQmH8b6CLqpMoNFX
	dtIOOE38rodB1eUbn62eZSwDDx9004GHOnJePadfQgIE8jR5w7rx8pXc
X-Gm-Gg: ASbGncvwxNO293r6cATEINV4w/nsSbBBRg/xik8dd1427xgdd86tm2O4FabSjOJZk9Z
	UUkMVYo7INBrpEPOR3OJm8F3leKfs1bNEfd1ao6cyZx0dHQPHTRaeEkcPP0+YVSSylu3NiRw11E
	aDd7Cldec4W2fQue0uO/itPF/76o0tTzHXrIuTMXp/c+wmGBmdcXNYYfHiZkHfzLSfZ0tfDFJBI
	Fuw3E9Vjv2DRWRThYG/XWil1R6qRrUv7YP1X4fgBRwFdkwZ6Xt7V3x81hnuVxeZlT0XVIJY3/iA
	5vliblVL5yAbGhGR+oMt+wepPad9ajEn4qOkRDiEKD4cfdGSPQyeTJjQEGaqGzlof7m/o+ZcmEQ
	=
X-Google-Smtp-Source: AGHT+IG5nSWFEty9vCN6gC150pOJ2PmZw80Dh5SuO3c3/HPGrsLNCcHFR/yUs1nQe+u4ZesyOmiwHw==
X-Received: by 2002:a05:620a:2903:b0:7c7:a5f5:5616 with SMTP id af79cd13be357-7cd47fae57amr2902555785a.42.1747944329026;
        Thu, 22 May 2025 13:05:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec228c01sm10867459241.33.2025.05.22.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 13:05:28 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jjohnson@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH ath-next v3] wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready
Date: Thu, 22 May 2025 17:01:12 -0300
Message-ID: <20250522200519.16858-1-rodrigo.gobbi.7@gmail.com>
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
started/configured. Do the validation as soon as possible in order to avoid
undoing actions in that case and also to fix the following smatch warning:

drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready()
warn: missing unwind goto?

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Changelog:
v3: move validation to the beginning of the ath11k_core_qmi_firmware_ready(), so
we do not need to clean-up things. A small change over the commit msg due that change.
v2: https://lore.kernel.org/linux-wireless/20250515222520.4922-1-rodrigo.gobbi.7@gmail.com/#t
v1: https://lore.kernel.org/linux-wireless/20250515004258.87234-1-rodrigo.gobbi.7@gmail.com/
---
 drivers/net/wireless/ath/ath11k/core.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2e9f8a5e61e4..b894e27435da 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2134,6 +2134,20 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 {
 	int ret;
 
+	switch (ath11k_crypto_mode) {
+	case ATH11K_CRYPT_MODE_SW:
+		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	case ATH11K_CRYPT_MODE_HW:
+		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	default:
+		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
+		return -EINVAL;
+	}
+
 	ret = ath11k_core_start_firmware(ab, ab->fw_mode);
 	if (ret) {
 		ath11k_err(ab, "failed to start firmware: %d\n", ret);
@@ -2152,20 +2166,6 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		goto err_firmware_stop;
 	}
 
-	switch (ath11k_crypto_mode) {
-	case ATH11K_CRYPT_MODE_SW:
-		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
-		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-		break;
-	case ATH11K_CRYPT_MODE_HW:
-		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
-		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-		break;
-	default:
-		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
-		return -EINVAL;
-	}
-
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
 		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
 
-- 
2.49.0


