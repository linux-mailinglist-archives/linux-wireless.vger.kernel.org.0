Return-Path: <linux-wireless+bounces-25398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF631B046AF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4044A3302
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAB26B765;
	Mon, 14 Jul 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvuhEJ6d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C622266B59;
	Mon, 14 Jul 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514599; cv=none; b=kTw9bIbkDy8bbMmyff9Hw+NI0N1QlUC4K3v9QoIBAOOJUTKX6aeCa5QpJF/pLYHlyJLLFtw5OUKeQo/gub7Uqbs9zH0FTKmglyHssRPNrnZM0Fqs5Fs5nPIIIvSZO9kwUZedJ6OOFeVfVhrapBluuFryoJJfK3XvHQVtP3X2OpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514599; c=relaxed/simple;
	bh=0aJdUw9TeYZ6XbjFold1qejFsdtCWo7V+1B83llu208=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVbbNuwa0ZHHK1KS3yEmcpsYn3hFSQmxLcAiqisujZBMzUNLF9qws6KsbIGQEznIV/y+vqJ5qsLA418s6WE13ber0Fy1+Lt9RFJSES5CdksomBqaeMef22oNaa/ztlYiWfvtYiVUXa9etETjdioT5NVSwd5SrLDU98yPjDN9xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvuhEJ6d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455b00283a5so18708025e9.0;
        Mon, 14 Jul 2025 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752514596; x=1753119396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27zoUGw+O71pRkY17Cb5b44izqDIRpoqwysQTHKG9hU=;
        b=IvuhEJ6dvEZnNdKXNUYHCNbZRYbV79tPjmz4S2oRsnE/aq0xCQJwX3h7poTr2UCyy1
         43qXEfV/iLR1BGxAwvPb4z/HNw/blldnikKp3vl1cf3NwcG6AGNxnM9l0is7WjNoOpRX
         wvua7+QTDHPtRzTsBu36QUcTlVI9qv+4wKnI8CptdOQeIERi9U9SIaTdl3dHvD1bSMUa
         vEyCoqtvMII8pMUVa/QUZ30Dyi3WwOjSWOI/UKDzK0rczdZJZyGaEZSIvWr46QsUoW8r
         snssasNUETTQW6ByxGFcqWaMlJ9AfMhHaEbjjAnGzEOzclMst3yoWhqq/aBnMvAdYn2t
         vBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514596; x=1753119396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27zoUGw+O71pRkY17Cb5b44izqDIRpoqwysQTHKG9hU=;
        b=ittZJxIVi4iMD719ZVSeSvNgFi37RCrbcIh9T19x0Egg0PN1FdQIEGZ07lXR+RfOz/
         dNrqokieaYXIhVK3fiYEQgwFetKzzG4wS2C6ptUTCr2S8nAkjPhsq0d0/a1EEExS5n1l
         zf6KCNIZqXGCH9vhj034vQ2WBtA0FYIofMf6fLrDvUdKA1EKatiYnuXG97GUyAeiyypE
         AqbAD3/fAzXrDObSLr4nSNAidnBlFFYjGWZeQfvStjUm/P/2V/QWFpX6iSbT0boJtvdy
         nH+Aggc7VJ91scHZT49G9v5/I63Yy1kdORDs9NSIXVbXAvXru4vH4UBrdpwPA+nGGPOr
         tTcw==
X-Forwarded-Encrypted: i=1; AJvYcCUpdSYAIvoCOc/MqJ9AoMmoMY+NLj+Y5Tt6idsHg13dENibhnqHl9DfE8DqOMin6yLtmJCcnEawlS3KngH3@vger.kernel.org, AJvYcCV5wJ4fHLqLFEZW1v9/THeMcO/f8jpSxms4nc2AT9tXjDov5+mDzSXwQeB7CwPn92nAUEmdMFLnLhOkCTv/zf4=@vger.kernel.org, AJvYcCWb7xdAo8ag548tKIgQloexi3YbEpfd9vn4t+/K9sLWYw8XmSiJUW+KB01veNzRR5x+04k/Zr1cnWQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSJpMKQ7FkrepmKoPEKz2XAzcjgLTXdAWMhBdPN63xl9+1RO8
	aDK7L1BZfzq7A+SJj5Jnx8dRgz8WAZV49m6J4LKHTzpRkS6ABH7XFB45
X-Gm-Gg: ASbGncvWZ+kZzPhjkOP9pKnusXm+8v84LnLIJeohCJyjbZJbwROfgXZHwoluuySsoXb
	3SW47VAjiEiuf+fJJkyjRCX/NDA26HbV/oPovW37DOFPtHP0oxNd4TkIMbhQX3Dfo0vjF8ZVWeH
	KbMbAL4PW+2x4bvq7/7Pjs7cPkMeYlDOfNSKerPurOfxXNTaLEZkSTlR4zFa12/SYk0dbQ8kX6y
	nBDFryB78v8A9bfdSaKtAQbwihKEcpopXVyxi0v/WjJbQxCGHh/B6b0UB1y8zpXgAk/breD5uzz
	GhbaPPC++A8bVcsBgcuNm2B87m0LGs1WaxAFWFC0Km+hof68PbL98EV7aemeWCtW7TH15d7Jl1H
	CMP1sZ27lEdE68MZVOuEFYeRoaeZgsqOrPcM=
X-Google-Smtp-Source: AGHT+IHgvMVpSzu1V0uiZyQXxUUB2sDhT1TXAVv0QnYeeVesufnJpndQ8w9cDsN//TZkJRwawRLG8w==
X-Received: by 2002:adf:e7d1:0:b0:3b4:4790:8415 with SMTP id ffacd0b85a97d-3b5f18d977dmr10613323f8f.48.1752514595511;
        Mon, 14 Jul 2025 10:36:35 -0700 (PDT)
Received: from alarm (92.40.201.95.threembb.co.uk. [92.40.201.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm13152531f8f.60.2025.07.14.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:36:35 -0700 (PDT)
From: Dale Whinham <daleyo@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>,
	Dale Whinham <daleyo@gmail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9 RFC] dt-bindings: wireless: ath12k: Add disable-rfkill property
Date: Mon, 14 Jul 2025 18:35:43 +0100
Message-ID: <20250714173554.14223-8-daleyo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714173554.14223-1-daleyo@gmail.com>
References: <20250714173554.14223-1-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Document the disable-rfkill property.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index 9e557cb838c7..f15b630fb034 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -48,6 +48,9 @@ properties:
   vddpcie1p8-supply:
     description: VDD_PCIE_1P8 supply regulator handle
 
+  disable-rfkill:
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.50.1


