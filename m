Return-Path: <linux-wireless+bounces-12549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26096E19C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A91C23AD6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C317A58C;
	Thu,  5 Sep 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnLaMQe3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286C17C9AB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559780; cv=none; b=AO7Q1fGU71lqVOkPRemQ8RoORhAFI/2XpLX1IgrxNdR8WROVQZsshdNBcBsfQ67PhEp74oYtKdz8gnjTavR5WU3YXLYTj32+H80Lrhp16Ex4N1+7yiLVaPE1WnuNZSKlxDbmneegR2GKicp1bte53mMF8+Y13Ox/0oXUJLngyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559780; c=relaxed/simple;
	bh=Xcy0CLM9GgAJetdIEVT7MTFuJkuEoehqhcrzVMh5w74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9uUrL7jhj/5TXJrZgYrUkmNszriFd3o86G0SGIobJhLqf1YQ/Lxqtu152FCiktwJPxKefS1hPBfh9jmpk0bg91UhDBJBAUyWZUp/VE8hShrDBdH4kdiJ3YHw2Tla1Sn/uLC0HJVVg34LhRxfseh5vAUlFOgnZdMIKsRI35WkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnLaMQe3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1003089a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559778; x=1726164578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJw3pIHBg3muql+Aezqn2hDO2V1+bI8JIioSJTFJwYA=;
        b=dnLaMQe3qLhD/GuDSgBjmRe4g2rRAtfsMfEREZKhr+/0/tDPiUaf5vDrXRg7iSuQJ3
         phAp6L77CpW2yGLv5OZzmpgbD+k+DnyR3ffH2jp7Jzdedtp4QA/bIAJpDyCwrI/9csxs
         I1e8DCC6LrnQfdYwxqy73qVmzFAEbIC6T+spV386qmwGdfV2VGiuvEUJlqY4NDfwb8qg
         GWAAbeUxLJ7RpWYGfmQXETOO1nKVUoDzfuv7KftcJu/Fe2IkUR4TJF57j8ElSV9/Kb9t
         WQrWHBunYB0F4YSsyRwnNrcBsoa8gF4NYpXNzBRjawBDoDZdEL7mM7VU/56qcwWfH1tt
         p9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559778; x=1726164578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJw3pIHBg3muql+Aezqn2hDO2V1+bI8JIioSJTFJwYA=;
        b=bTAqZVbkHcFMv/hJdv5G2ju9EbipsaosjLNs5wRG7i7TaCIWNpdiEobkLVeVyrdri0
         yjfJOSTMC2UTwNKHS/q/JIm+MvGxLy7rcT9NLp+/eVmJWmIM5y61yC/MKkTfJv2YAinY
         qWj1pr7K+L6if65sinmkGyNeyhhaQOvFpiwvrMRxjtSmbzN1y2j4Z36+t13o53q8ho8A
         l9EbkV2YKR0W0o2XxMCmStsSdYOUQC7Srh/Bx1YCRo8BdrYKiJU7EAgkZaQLg72+JO3U
         mbU7i4Mb+g72diqqLi4kvma4OfLrdfPPuFy6h8F4+9ZtEbwnJ9tDcxfQupWztrMiZrEg
         Q4vQ==
X-Gm-Message-State: AOJu0YxrOVTv/lUQOxDjYWtismC3GNTQYWFzsJWwbNBwsxNj8sutK+LL
	1GKDzUEk6h6kOWzQjAM8tuCezv4DaHRCSdL6agf9fiH3Kjqi61uVK9B+NFkS
X-Google-Smtp-Source: AGHT+IHOmml3gy404s7aqYNkVRCsDPLHv9rh5EA14WV/oOEo9mjWtTSlraK3p0eW3aCIgKb88tZtOg==
X-Received: by 2002:a05:6a20:9716:b0:1ca:c673:9795 with SMTP id adf61e73a8af0-1cece503b02mr17098307637.22.1725559778011;
        Thu, 05 Sep 2024 11:09:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3485199b3a.133.2024.09.05.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:09:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com
Subject: [PATCH 4/5] dt-bindings: net: wireless: ath9k: add new options
Date: Thu,  5 Sep 2024 11:09:27 -0700
Message-ID: <20240905180928.382090-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905180928.382090-1-rosenp@gmail.com>
References: <20240905180928.382090-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These platform_data options are now available for OF.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../devicetree/bindings/net/wireless/qca,ath9k.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 0e5412cff2bc..5c293d558a94 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -44,6 +44,16 @@ properties:
 
   ieee80211-freq-limit: true
 
+  qca,led-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that the LED pin is active high instead of low
+
+  qca,led-pin:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Sets the GPIO number for the LED pin instead of the default
+
   qca,no-eeprom:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -75,6 +85,8 @@ examples:
         reg = <0 0 0 0 0>;
         interrupts = <3>;
         qca,no-eeprom;
+        qca,led-active-high;
+        qca,led-pin = /bits/ 8 <11>;
       };
     };
   - |
-- 
2.46.0


