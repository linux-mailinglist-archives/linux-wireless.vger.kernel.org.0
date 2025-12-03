Return-Path: <linux-wireless+bounces-29464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C17C9DD28
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 06:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9E0E347893
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DDB28488D;
	Wed,  3 Dec 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMwXfDSU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839892472A6
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764741115; cv=none; b=kU02KuHSPXivQ8q2ZWI7bJtkuEH1nLZUY4+u+QZs6xSEWq0m1l8A2JEp9GR/T/ZsQO+Bs/tMeQmUQsyUY7/nv42EFRWsMnauADY8HLEQiZhrc+T5kH09Xy1vF1OQBp8Yp0/J37sx5J9ixZYuH4Dd7g2/h0sjnIuwGVXuYOkVyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764741115; c=relaxed/simple;
	bh=RGhQblUeGNlM2KUQlBlhC5GbwNKibWuvUt7N3Pf6jvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmipoPR3ocfiUNO364NfBbGd03vPTHOtQMNH3Ozwy6dhaJhp2g4n2pr9H1WDxxs87HOQJxbzy5syIQEUJV2pa0NwPzMiP2MJ3xuyCGz6YxTpUR+3/b0Leh0bZDESLoNnIhdM5kOl22OfGPZ1bf1Z+XNCZp5fQnVM8a9luIW1dUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMwXfDSU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso4594701b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 21:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764741113; x=1765345913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG8HVy8WBKfj7Gbq7tiRoF3XvKUwWlK7Y7HtxcHNPoo=;
        b=gMwXfDSUAsS2QBwgU/HRZV64eyNpCAj/Hr23ctTaLPzPhToS1URdVlG+V97hm0Wc/s
         f9vDkkd+58afYSsGnHMT+alvQzcrKsksS8t3qyLRnlonTk7RhgFabvdOTaZMGmQuopS9
         f2hpUekd16zKdYphaVlK6Z3jyuKE6wgpjJLeJgRPefaK6VbW6L0CmBKQVrvtOWE1U1N+
         m89n3vCZz5lhrs8vXit6I8/myY2MyHVEFAwQ8xuJcEK1GW3NfHx7QEfmn5qJZmjId0GQ
         HQrPncOnm0JjdInXOXUVbIPTIemRBRd9Ub63pOKSK9fv5W0Ba7T+DDqiCTLhVLhkiPSj
         4l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764741113; x=1765345913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG8HVy8WBKfj7Gbq7tiRoF3XvKUwWlK7Y7HtxcHNPoo=;
        b=lDxoXCDThDa2OL7i3ak62sfk724O5d44QR8QL/TfXf5sJIhetmN4XnoShsroYfUuGX
         /tqTurgadOB+9LuBSFXtX1sGXxJq1pw6A1UUIoLINFtD51+P3zFapwzyHGzmroEfUctL
         vr/FE0hXUK00nNUOsU3fS0xQI10UzXEWOauQ3gVryk3MJHR2gWiADg0ngRIL+PbRZV1N
         TKOwOi1PK3o68RZexattBTeEObj2Djy8j04UPr68j8CuRozsTuOVEMQz+leLu5LGYc2L
         sFmETnkyjVpiZ8v37zNOylvZTnX9zjqPDKOwyoimLdDApJ9yU1vyu2FXW10+6dXEfM0I
         AtbQ==
X-Gm-Message-State: AOJu0YxkNrfQldTnvjoTFo/0tVxPMXW5RenAdrtsU+x3A5TPF54Q8qxX
	rsmC3qIEcT8it1+ddfDU6L7aM+QxLTWGGmn4ABKwfPuxqy8fLWzbxwEKRmj4iQ==
X-Gm-Gg: ASbGncsudwslc26bzINyaqmsHFEFSWGC33yTn/sfLMkTL8JmjO0ER/M9WoBI0UHNlSk
	wci2LX5SJGwhgp0p9TOinSwonl7Q31S87lYpEvl3bsNLPA/hirHBbHAs5Sp0zyI+4dPvmdjnsuf
	VI9K4T6PPEgcql0EeKETlLAMgDb0h8JxYeDgXL0LCVyXce6dcZ4BniJUm3+GGvHVNwpdPaNrk2H
	UWO7U9xPGbUwOyU3a0aaJPffTfd/W+4gJatIFHYx6n5EQfiiomkueRRx0qghBa0kzYxye4dyy9d
	Igl4YiWfMAxfXQR9mUNQjLoa8WdY/pDjfJNTr6tPbahXhrvOITHyZ2vMKZoJTJ6Jz71GzAbUm3j
	qsYT89qzKJl3+gKeOGkvEJ9rb+nDr1Yc5EivDxQg4qR1Fm3vYB9qDK1WBGQ==
X-Google-Smtp-Source: AGHT+IHyEgLPqLDrjP+uUbRKGsluxoDUb/5jT6uyYFa1j70JyUaxLsI0PAs0cLoSijP1iOAiWrzdgQ==
X-Received: by 2002:a05:6a00:3997:b0:7a9:d1ca:8a44 with SMTP id d2e1a72fcca58-7e00d9f11d7mr1283429b3a.24.1764741113397;
        Tue, 02 Dec 2025 21:51:53 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfd0b6sm18920939b3a.64.2025.12.02.21.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 21:51:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath11k: ahb: use of_device_get_match_data
Date: Tue,  2 Dec 2025 21:51:35 -0800
Message-ID: <20251203055135.38641-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No reason to use the non OF version as AHB is OF only.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 8dfe9b40c126..2837789cf4f1 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1114,7 +1114,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	enum ath11k_hw_rev hw_rev;
 	int ret;

-	hw_rev = (uintptr_t)device_get_match_data(&pdev->dev);
+	hw_rev = (uintptr_t)of_device_get_match_data(&pdev->dev);

 	switch (hw_rev) {
 	case ATH11K_HW_IPQ8074:
--
2.52.0


