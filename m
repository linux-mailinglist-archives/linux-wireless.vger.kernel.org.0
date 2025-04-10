Return-Path: <linux-wireless+bounces-21396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25279A849A0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F2C4634AB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDF1EF37C;
	Thu, 10 Apr 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9sSImZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC41EEA3B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302383; cv=none; b=Kcg7Hy9rBcH/UQTe4IEdObzEjMakaMzFY82iiOp8IGnHAK70Xur0AjqSRB3x3di9p+YC3pXnw3DrIfzYpOw2eZq2La6uSE8q36umT3aTZWHurFc8aWzQR9MFheelWTb4XcpLwWSdwpKPoP4q4OdROaop/Tgjrl1mpEXJpCEwdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302383; c=relaxed/simple;
	bh=uahR4xkljdW6YAEH4HqJNn8IYJmLvcayuCU2q8UueVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eo4ueFv9zsHQh8hJn5j3HgciF+lK6T1/4UiSZxXqsuZJXX1A8ZPPTf9a5MnpE24LDCDRoTWw0GF2M0LN1Bjxl+nI1l+Iz3EdTPhdEP/1dnz6ROb8Mmm5VwzV8IsCj7WQHblvTzkdBpg1G/Tyz9LL6D6DJ/CmcybaF3gbVlgWOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l9sSImZE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso10849015e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744302380; x=1744907180; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ckJ5dfd0gLEO4J9dWqs05uCPbUjSjr2AMEvPSWIg4=;
        b=l9sSImZE0eZRKee+ZfzwBqfW4Tq+KbG0zohtpgkkS7v6ndsheUuHJcxggaoqeIEdfT
         sZWTbAQvdbqieo+2jOXwnJdDuG+Ya2IAz2foFfvpDLS+nCin0Jy3aZdlLwxgThxJ0YLS
         TkQJ0UCcT4mvRz5bAr5YhqmNY6XgRm01tZLBmZJVbuntE74z2MWSxsgRbA6SZYw8xFHc
         X+riralRPQycB3srXYL+3uEh6/+zf7i8KU24ALwZx6VIhXy7Kdy3hmnapZlS0ZpvJy5M
         3WWXFsdO38dzYlGIr4svKU6e+0lru94G3M2pNCtxbohG9nVza3NNA5JuyY2Jz+wmU6hk
         j4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302380; x=1744907180;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ckJ5dfd0gLEO4J9dWqs05uCPbUjSjr2AMEvPSWIg4=;
        b=V5BflYgEtlSJ8okiL8cGJ6t97rvwtxtWZ9n6YfXT2L4fE9YuvoImBtFf6/x5uZSXjV
         E+zfBZfylY3KIYDKt34rzbGa0bPRCBBprSNI2kU4q1WDt43jX6TIXy8ENOgmd4Agz+W1
         UPtp2CA3ZpZhmZLRjn+NRJ04s1Dk6yxALG/1svRQ1ThmheXgYeYBUoNqN/6hE7YhITo8
         LXw4g0Ku5wKdVk4MoWGbxD5p83LCpemapc03Yc2t05P+cYBtcXC3dWietJ+11iZqMbnb
         1NsmqwTKDSmdxd0j8tObQFvp5oevyP/ejmTQSiVku+Ws66+ILI1B1smQHB+Wo76RpQ8Y
         ikOA==
X-Forwarded-Encrypted: i=1; AJvYcCVKBY7doYc1erNV4ekS3bFQpSg0RRYawSfLjOf/BJPdBvYVPTds7TfnXm9LO+rLjgsCNzecKhEDp24TolG10A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ulmcW8l26CwwfzWyQ0IUROU7aL5pxeLPhrY9J/agxbkTEdOZ
	LGfqthVPoQ+DtAR6Whx6UtvVt9iy/HH6UUiXCl25/LgvaiTJbtTMe+6LUFjflxs=
X-Gm-Gg: ASbGncsLS+Myl8mgLfCfPxcStH5ib7lLtHQTC0yIlWP/ma/TUzvM4a3XqaqzLOYeZIG
	W2Sks6BblhxwFCEMWoDfVVhETlNecQZwpZqyCIHDk+m3O23u/bVRMpdcIH50OtsWoHBfGxZhtpG
	Ft8LbRDjhFxU22vaVsBs1KL9VFsW9ScPHhUPLR/QnwIcHvrFcHAl7dFp/ckJNw+VZK94yAIcZEY
	F673xPafGxwfdjZsgBYkpgKL7gqi/yBOb0GG+8FU4PSA67/CjebmgSV52+bM+5w2C0ZNDYE6gPe
	wb0g5QXiso8dRO3hHvNKsz/VIb75E5ux5boRQubGduuWB6UXQ6+fDXiP
X-Google-Smtp-Source: AGHT+IE1nYH0HBU/WHO1w0aQZJhBOQ2ARrY9ROHGDPijYcKFnQf4Jd5ojzOvEeX3hT9ouKniOfxAnQ==
X-Received: by 2002:a05:600c:190c:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43f2d798f17mr40725835e9.2.1744302379796;
        Thu, 10 Apr 2025 09:26:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d89389ed6sm5196989f8f.41.2025.04.10.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:26:19 -0700 (PDT)
Date: Thu, 10 Apr 2025 19:26:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Balamurugan S <quic_bselvara@quicinc.com>,
	P Praneesh <quic_ppranees@quicinc.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: ath12k: Fix a couple NULL vs IS_ERR() bugs
Message-ID: <937abc74-9648-4c05-a2c3-8db408b3ed9e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_memremap() function returns error pointers on error and the
ioremap() function returns NULL on error.  The error checking here got
those flipped around.

Fixes: c01d5cc9b9fe ("wifi: ath12k: Power up userPD")
Fixes: 6cee30f0da75 ("wifi: ath12k: add AHB driver support for IPQ5332")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index a9d9943a73f4..636dfe237a79 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -360,10 +360,10 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	mem_phys = rmem->base;
 	mem_size = rmem->size;
 	mem_region = devm_memremap(dev, mem_phys, mem_size, MEMREMAP_WC);
-	if (!mem_region) {
+	if (IS_ERR(mem_region)) {
 		ath12k_err(ab, "unable to map memory region: %pa+%pa\n",
 			   &rmem->base, &rmem->size);
-		return -ENOMEM;
+		return PTR_ERR(mem_region);
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "%s/%s/%s%d%s", ATH12K_FW_DIR,
@@ -929,7 +929,7 @@ static int ath12k_ahb_resource_init(struct ath12k_base *ab)
 		 * for accessing them.
 		 */
 		ab->mem_ce = ioremap(ce_remap->base, ce_remap->size);
-		if (IS_ERR(ab->mem_ce)) {
+		if (!ab->mem_ce) {
 			dev_err(&pdev->dev, "ce ioremap error\n");
 			ret = -ENOMEM;
 			goto err_mem_unmap;
-- 
2.47.2


