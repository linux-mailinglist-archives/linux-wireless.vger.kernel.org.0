Return-Path: <linux-wireless+bounces-19417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C03A438F5
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 10:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A5C3BB9EB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983012698AE;
	Tue, 25 Feb 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/FGa+3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C626988E
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474354; cv=none; b=Fe6B5Sf+chTtPy5oYgCzhFm89OwQ4pn1wYZBNWaKp1jmDiRHrjy0Jj+xZrEv0NOhV2nlNFKePrw4USOV3MZ6V5yLZG9kjyFq0TfbImMhgFlw08oRRNVqbGInI7oe4UiSdmhxb+MQXKQ7d277EgWBgzo4hUcRgJdiS77qP1LEJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474354; c=relaxed/simple;
	bh=Dz5yNmE8eSdxa0CmdJl8w6wvj0WWXjGEMcH+7qjSCmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlPcjcNgVSst+caeVgFK0H3LdxbXmOY3PLjcjQt7/gG5hWxs/gq8RRqX2ioXjSegg/bhj6IEMo6QUxE/aXMVRxydokndQjSYwKvxIKChzUY3DAzmz4uULOX8SQvTR5aMPY99A4/kyNqXiHfxDDTj6d8QSZHudDtNBwtNZoqD+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/FGa+3V; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7f9f57192so70746966b.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474350; x=1741079150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCfhYp/tqNoV2tEavI68DM4qQ3+PDh9QaJPfXDvyBHc=;
        b=R/FGa+3VNGlsdc8bJjGQ49drRlnxRJ2z4JmPXlB5kXuPmeFbbnuieqpl7J6hHiHehv
         /cnzfInXRusMVV35qtUWkTPrFYHFhna4QxrNZA/q4gG/ec3PHIwWo7FLNulPaVaNNnQS
         L+h7S1I2H6ast4vKDCeagfap8fZYiqZielH8BKFSyYUFFnd1AkPVVHJ/dwjUjfdMJ00p
         Cnr4uf1Dphj5U77sabmQrm8Xtl89eBwlc64AQqOHnb2Dq2Js56BoxfwD+433VP4D8NTf
         PQ+SfNogYllh1FKCK9uSzA3b1H6ZtwXu5s8Jd16IbeKkHJn3T7PKN+WIrFNFBVEhTxjr
         BiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474350; x=1741079150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCfhYp/tqNoV2tEavI68DM4qQ3+PDh9QaJPfXDvyBHc=;
        b=StH/+6nRZE+YD8zSFhplXn/XPXHndfCcZm9fbyiA1l+P7ex+ZN+ofXxJh6pINuxahy
         rIwwEcfeOcIv1pk4tKMdDXqc4uIzHQLVm9wytZ1j9/rZ2Ubq9mG6aUBjJGMlb1BBIlfU
         bwpsvY7PqaFUxzm6N3fUpvs2eWK7DjkMimgMgqDv+g4XKwP4S+fjqvuLYP7+ZCt7JGOd
         h2ZVcVCNZoGEH0t9tkTTjHF+iIZO1Lp+xDoYMr/G3XQeZZQenyIghMLYdwHYirEISmP6
         RmflYqdWM7jXkvgSM6LnktQU2cl1WjNDcSX2isa+PCPdhjCA9wia7IXid2X7oJYgGgEx
         ONjA==
X-Gm-Message-State: AOJu0Yy4/X0/mpSh3hF8cSyMuY8RmTOF6ZwB0qNzgsqxoJC6jP4RYMfZ
	rf3EDP1iLYa2lQYeMFumKDmsCRgEh4j7JiSu6syKTO7kW1y/1fqbLa6JZyXqUR5UGhcWc90EQfo
	Q1eI=
X-Gm-Gg: ASbGncsIAz6BoKDf6yscpuU5ybMWKcL6hhW5K8KNPcMDhIq7BMJDG0SMu0ZDTj8EQau
	qhQ1+EOb/XLAyX4ZVvljFT/umCoRO6xLK4ta6exsoaedSnHyyu1///ztfsUhb33vn0cfTmJgWgG
	4nbB/74JcHs+dygp/8+kDuC9cZGMRJPalVv/pDhgb1znYwVcedXssreTO3tGRODR63u3iavA2b3
	mTyBUg4nAgE94cZ98ekTgkaOjbfwhaQ1ctxZaZ7tozq+NQdFv8gdzonS/fkmLB2/umzmM+4xjoN
	weLNDNmLSU9I0uBvdZlZ39BH28nnMAZOhLgn3uhWB1Q1aOfZL7r1ukOL1Q//08PDXIfeemB+L5e
	V
X-Google-Smtp-Source: AGHT+IHtKrgOP/DE1J4J0Y0A0ldGOKWtPV8QRy1Ye1jhGLz4Lda7FRnPOyCqYEGlT4EJBTKJOYvyIw==
X-Received: by 2002:a17:907:7f17:b0:ab7:63fa:e35a with SMTP id a640c23a62f3a-abc099e1dafmr622362066b.2.1740474350361;
        Tue, 25 Feb 2025 01:05:50 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm106681566b.148.2025.02.25.01.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:05:35 +0100
Subject: [PATCH 4/5] wifi: ath10k: Deprecate
 qcom,ath10k-calibration-variant properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-b-wifi-qcom-calibration-variant-v1-4-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Dz5yNmE8eSdxa0CmdJl8w6wvj0WWXjGEMcH+7qjSCmE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvYfj60TnvUIEnv7U3Skox2u9XlT7lKh41uz9Y
 LYH4CNb/eSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72H4wAKCRDBN2bmhouD
 161WD/9+7eNP22O1Oi7cVRGHtqvvI7AoMm3h0LaGetUerCD1eAKZJHbQ3ecjiMPTc0nT7VFIOCw
 3QOup8KQRLR2Ad9a8S/wxCAj3co/NXb1sVBb6JYaGjBcDLQLADmaN4emAwavL8SWzD2vy0cL08z
 5OJ3jyibeH1W4qGX8N1BRK5gGpazHOAw6aguwdtqdGT6JTVfbhwXcNhcamzfXvOXfc6O2cKm2dw
 Jt6r36tA914fiY3AHnZX6lE5Zv5mGEleylSa6rtxiCdmUTi3S1P6kWe8kJ6VUzkB5fdbUW5IA3T
 Fp4LCa7ziayx2L0QuJz1mdw5GDW1m8moNDTt/SfGRjQ2SKZMakXPcxkYQHMuhN2WhALPm7aDV3P
 wcB6732IeIZh3ELZHGhy3by02TPGmqey/phS7bhzaoIHdyV9oUd7qAKA+OvbbHmeFdEdFqeHyWq
 CVMNPqCW0ZeF93yytlQEo/n73t951xCiKgqQhNOQ7hkmxxCE2ZXH6m1WzvfhQeBdtLCj0vJwADV
 LnhjWjTsqO7Js2AWCtoK4pUGXI4NNP+rBXvUoxwy+1ovIb8jNiLAb94xArpXOqRpAtgLq0QyIkP
 A5M79qCl+RbiGigr2q+kdL3MtVIXdTMd4+Qnl+RCeKcskpiD1/Q7XYl/nu71067RPMVs41engGh
 0P3cSdAcMOAX2zA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add support for calibration-like properties without 'ath10k' prefix,
while still keeping everything backwards compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index b3294287bce1f7785231d3bf0f90cb15806937b2..6d336e39d6738bbe7973a25e073d03a07b9ae733 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1163,8 +1163,11 @@ int ath10k_core_check_dt(struct ath10k *ar)
 	if (!node)
 		return -ENOENT;
 
-	of_property_read_string(node, "qcom,ath10k-calibration-variant",
+	of_property_read_string(node, "qcom,calibration-variant",
 				&variant);
+	if (!variant)
+		of_property_read_string(node, "qcom,ath10k-calibration-variant",
+					&variant);
 	if (!variant)
 		return -ENODATA;
 
@@ -2259,7 +2262,9 @@ static int ath10k_core_pre_cal_download(struct ath10k *ar)
 		   "boot did not find a pre calibration file, try DT next: %d\n",
 		   ret);
 
-	ret = ath10k_download_cal_dt(ar, "qcom,ath10k-pre-calibration-data");
+	ret = ath10k_download_cal_dt(ar, "qcom,pre-calibration-data");
+	if (ret == -ENOENT)
+		ret = ath10k_download_cal_dt(ar, "qcom,ath10k-pre-calibration-data");
 	if (ret) {
 		ath10k_dbg(ar, ATH10K_DBG_BOOT,
 			   "unable to load pre cal data from DT: %d\n", ret);
@@ -2337,7 +2342,9 @@ static int ath10k_download_cal_data(struct ath10k *ar)
 		   "boot did not find a calibration file, try DT next: %d\n",
 		   ret);
 
-	ret = ath10k_download_cal_dt(ar, "qcom,ath10k-calibration-data");
+	ret = ath10k_download_cal_dt(ar, "qcom,calibration-data");
+	if (ret == -ENOENT)
+		ret = ath10k_download_cal_dt(ar, "qcom,ath10k-calibration-data");
 	if (ret == 0) {
 		ar->cal_mode = ATH10K_CAL_MODE_DT;
 		goto done;

-- 
2.43.0


