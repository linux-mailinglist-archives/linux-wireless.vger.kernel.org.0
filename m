Return-Path: <linux-wireless+bounces-23321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B1AC1392
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0B7AC7D7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098451DEFDD;
	Thu, 22 May 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyXy9euv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F81DE2A4;
	Thu, 22 May 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939522; cv=none; b=jEcWsq1HBnxKNPsh+c9j58y92t4ISrIc49dwzX9h9vRrILagrrq43uWFo1tVmMG+y9VdOomHGLzyz4a1RoBMMGxmReqGDOSNL1l5DQ2Ns3Tuc61qoSveU06A0e7H5JJ2hhDXKlFWKc3HoE6cVfdSedxeRu3hi6ZH2EfgXYSGr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939522; c=relaxed/simple;
	bh=LAVh7geJL1PD75mFZMVsyKCNDPWBKX7Jf3cyBhahb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fywX6Tcomzs+P7O+3d0vja8NR6QSU0S8kMALMkbRKWUN7Spt4xzSKCpltvf85FND+3FXE4sIhOESsDLVN3BiUiNkXySzeShe8N+uUxK8uaxEN6nK2hYUgMgSw6fuzRNb+Tt5t1aqqJIlgdfTPmc9Nvl23kVbp7WjstB5Gn3k8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyXy9euv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so8136102b3a.3;
        Thu, 22 May 2025 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939520; x=1748544320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=fyXy9euvjhqdQTcfsmJM3YE28u0GnvOGpX1NbOwaZmXi4WE/zHRY+ZNF3RnP8aSZ4B
         JyKgW6BO5o4zgpjS41oi/kk9j3rtstea5OEJM+HhBmrgi/X5etpVaVDXGFSbyrY2Cre9
         MphP6qYyK3/kNFQ0zOCFYadf10BQvQhQ48vWeGjGYyH2AfxYszFKF6hFC7xbc42Ug2Ic
         W5DLzikLNoab+y0WHgQdFEV4NB7uCp0zS6w2HNFH7/nNKDWuYXvi05YTWSgPzECPCMIT
         Rtq2KwoP06ACAMAtFyQUt0YSma/hVLUxXlkWdhibO5Zr76JuMi+mwPzQGzu56eCUmJr0
         L9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939520; x=1748544320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=bae0jZJ4FmWCTGokUdOxEfLLdZ6ZIFczOzwVQu+I3X9M33W6JT4q0s30tjKLJ9Ri6n
         KixdETDkHtEbAE8DcI/Tbv8dJ03qa2IIdKFtHIW43XWy0FbmKfxQ7xC0S7mA5KKhqskQ
         HFPEJG8XfPNOg++7fd/oze2lbKVe13pJhbLJxnRfqI359+nyL++PYK/Z8T7p4GhLRfoI
         R9LJ6Ii6ScY9FNyg0RwSj5DFTwSUxO9o2xn+O1iKJL5XnFT+AuWpGKdN4QKah/N241vg
         nyOwVamcnC84dyX7SirN1RuKl0739sw7U+lirHbl5WBuS3c6FN64co7p9v/90a8U7k0X
         sjKw==
X-Forwarded-Encrypted: i=1; AJvYcCVw5028CoLqH5Odd9qNHFnK7e48hP5PBf3nBqzfUzpRSlCZ0agQoUiiiRuZl3dVbUxcCJFavByDXpau@vger.kernel.org, AJvYcCWAnjICTV0Q2Qd/sGYjsNOG/VxZ9aVuSdtwwgToeVDOxGhfwz0e3GF0w7uclntvPWL7hoEeJOJaPoVcs3fy@vger.kernel.org, AJvYcCXZfeqien6p15quW1PryZLDsNSjqEx4MhR0vVi7yofORLULB+SRT/rrNzN973g3GVgn3ii8wkhCEQ0GSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAao9i2LWe7KG6f72zYBKap5Hl6wWSL8MMcgIpW87Af3tAlBz
	JnjwdmvsCUvJcP0Fr3mfD4FnLFMRr6gkcSWWIxyug5yis8lZJXc28b2ySjKiHA==
X-Gm-Gg: ASbGnctJBA06qyjJaFrPTcMG0FR7asdSvjc5zbXtV4wUUD22m9OuadKo5DUWUzPsJSU
	0J9m4moO4rdR3y7I/NMoX2B730v1EVPVot2+BxlJL4ax2/gAIszju9cJkup9k6fOD0pPHRcL8rK
	SnLFsehAeKyPZFcALlIKmUImc7ChwNwHZYecGSNAR7yfJhpnacsxJCvT9wS2PWn14YdBbTm/Mjh
	z8m4ycqkgyfa+5REFiWPRRUn23IhBqYWur4Q4+s0q9QSYeq96MC+J8RGudDjNLFJ0igSHN2iHCr
	+/Pj9b1GG3fUaAJoN/vxX+k8CNY=
X-Google-Smtp-Source: AGHT+IH82BCActNoY8vVNgWpQD33ZdqnU0667xDNWI0aL8zg2I4vCanp9Bh5OfJh9/KzwEpWt7vy/w==
X-Received: by 2002:a05:6a20:9195:b0:215:e60b:3bd2 with SMTP id adf61e73a8af0-216219bd518mr42657446637.30.1747939519875;
        Thu, 22 May 2025 11:45:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm11502424a12.23.2025.05.22.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:45:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv2 1/5] wifi: ath9k: ahb: reorder declarations
Date: Thu, 22 May 2025 11:45:12 -0700
Message-ID: <20250522184516.13176-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522184516.13176-1-rosenp@gmail.com>
References: <20250522184516.13176-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Easier to look at. Follows netdev style.

Also remove ret assignment. Because of all of these devm conversions,
ret = 0 is a path that never gets hit. The first time it does it when
request_irq fails, but that ends up reassigning it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 49b7ab26c477..d2a97e74f451 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -71,14 +71,14 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	void __iomem *mem;
-	struct ath_softc *sc;
-	struct ieee80211_hw *hw;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	int irq;
-	int ret = 0;
+	struct ieee80211_hw *hw;
+	struct ath_softc *sc;
 	struct ath_hw *ah;
+	void __iomem *mem;
 	char hw_name[64];
+	int irq;
+	int ret;
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-- 
2.49.0


