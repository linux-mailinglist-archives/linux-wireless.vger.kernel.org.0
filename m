Return-Path: <linux-wireless+bounces-26341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BCB23899
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BE06881A4
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A322FA0C3;
	Tue, 12 Aug 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPJPg5ts"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556482D4804;
	Tue, 12 Aug 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026631; cv=none; b=otrDDJs54GIrk+XHMl2OdOfV3P9A/NKvBfSpF73GNnIw46lQJtBUMBMyIKWjHMgmbvUjzVtdpbiuAPO5LnwQZ4PVfYn7OD9J5645d6QC2vbjww9f5vk87RDjBc8mIMsyMhUuhCjURzcH0lEIskE7PJ3pKM1y/XbuBKlfFjZzEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026631; c=relaxed/simple;
	bh=6MU+MiY2SIBHJMAIT6+B7VIaDEcQJkWDdmGlHGOOQso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyIVfq4wF9CjAEy/I3Bm7p8krWSTc3QNlGZHEz+Mxywrn0wG9qkjUBfyJXENMUKSVntf8zPfDGP4u1ZvOw9KoCmsiODtxSOoxOQ5VsBZURLlunpf5ivcN3EsBdzCYXzkvh7ioSsKOaJ/rze9Z6+8yeu4UQIabqnzLqFl+sqygXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPJPg5ts; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e6974a290eso547180385a.3;
        Tue, 12 Aug 2025 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755026629; x=1755631429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmj3ucdGs3avw6O32ycuRTdSd2UqTmdLPfvRjeaorpQ=;
        b=QPJPg5tsIxnNG8PqsiaW2/nZWMP+3IPtKuZRNe1jwPlGfbPlqSdf0AA3k2U684GXei
         ApFUwc/m6rvWqKlSXHtwW+Y0HcVEIHMA8jy6oAyktXcE1ry68YwHy+YhSL2u0++7FCB7
         6KjTE7TRCnQdmsO2fZnviZov1XPNmdKn3TFiUwNIaJ9GbGKKbeRRxDCKpkBQZcfH4mCF
         rlRIP1UQ4B7xsgmO/cusFWLjR41x2Z2t3w/84/8wGN0+EPeBFAcZWHhYYUXvrN/7nUAa
         X0pH+0LHPde5cM9WFBbmeWrdwjcwI8PxU7ClRYwL40WyaD+xHkqW9dNUr8flam3U2tDr
         3uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026629; x=1755631429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmj3ucdGs3avw6O32ycuRTdSd2UqTmdLPfvRjeaorpQ=;
        b=coD0KnYy3VTHjfZTc3CYodkxX/48ImIg5EslmVbt4K43t48UMc4ntTg8AATLq1FRHC
         6VLA3ToJfts/a9CoY8y6mv+V5IMHJu63Coxe7xrHRQp+lPLDIyEBN9fVliUls61O8vj4
         uHuLCqagX07LcGxuNSE9P4c0prXK342LUx7z2e477HfNpYZZdD5JCm3+7XweM0Oh9lAr
         mM2XX/+wGnE8UcRqY4QM1LSuHxulgYwFXLRxKT9ppCgB06t+mJDOcYWMzl/IWlwlVGNw
         hC32GqTk9oQjpicllNJER4ehns0PPgf3FSKZRWv0KONe5/oyFGm32z7jgT8az5uWAcnf
         AHuA==
X-Forwarded-Encrypted: i=1; AJvYcCUBJFIfykDNPq7pPb+NCI4FxMnDcCovfkMuvzXYBGwz5xX3CiFKBDzt9Z6M3kGcneTsGe2q69F13mal@vger.kernel.org, AJvYcCV5KJT61QluD49eXjqw8Zye9nRXM+5yNH+8QNNL7v2TYIRALBezlMZx+gjBpGTkZRfCOuua1X/h7lBqHVz9@vger.kernel.org, AJvYcCWkUOiuKMwdtEje/wQgTcnU23yY7chBwShSCTAGLreqXRw16z7zHhJ8yEl92psOnk1DFnaMWGVzn44rEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFDQ6dFKur3r09TFpI5usdf+tGpFDGZ3FuW1QdYT0hY8FpCmf
	DVV3Oh4qjGPb8I3yYU1C9M2gMX7KGf2XQYnOSg18PXrYxUaUYdePrTrvofOs6Q==
X-Gm-Gg: ASbGncsgE8qFPMrUaj5l4ud6csubGcrr9Bw4n0SjRkYbU9xeQuQ0J3u4ThE3jMnBFhu
	EQaBN4yBDoj0q+qGKuht7B6wUY5J5DbaR3Qh/I+oK5NDYI2MdcVnMkNsbJ/HvnGmxTUlw4qUuVS
	bIKEWF25Wj7D7payQUjLTrBTe7t2AYCbCTYF5IwtIu0WjZJGg3OtSahrWLLHxqGfRs7Lv4GRNpZ
	j+cpzcnEZNpas0l6Q37eaQN6aNF6mBenu7gf8Zw/2L2kfp4Y0XcBc+PxoGGUL3GYN/Mn/mAYxpB
	SyU0d3kIWB/laMMz9bKhrcFd47h4ooocQBqIEmp/ulbFwSkFGRZFmzmKGzrXavDIiecrY60K39L
	Xr7G5uF6uQKWd1g==
X-Google-Smtp-Source: AGHT+IHr6ot52GKGqU0Gf1Fiegqejaz6yleEz52MHvpCEEiy7W+pJzds730Yyxmp1W6Jf8UcNN/ISw==
X-Received: by 2002:a05:6214:529b:b0:709:349d:14b3 with SMTP id 6a1803df08f44-709e89689cfmr3335376d6.47.1755026629101;
        Tue, 12 Aug 2025 12:23:49 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097e906c3csm101471076d6.65.2025.08.12.12.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:23:48 -0700 (PDT)
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
Subject: [PATCHv2 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Date: Tue, 12 Aug 2025 12:23:32 -0700
Message-ID: <20250812192334.11651-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812192334.11651-1-rosenp@gmail.com>
References: <20250812192334.11651-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ath9k driver has various pin GPIO numbers for different chipsets
which are not always correct for every device.

Add bindings to specify the correct number and if it should be
active-low.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/qca,ath9k.yaml           | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index d16ca8e0a25d..e701046146f2 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -50,6 +50,17 @@ properties:
 
   ieee80211-freq-limit: true
 
+  led:
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+      led-active-low:
+        description:
+          LED is enabled with ground signal.
+        type: boolean
+
   qca,no-eeprom:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -102,5 +113,8 @@ examples:
         compatible = "qca,ar9130-wifi";
         reg = <0x180c0000 0x230000>;
         interrupts = <2>;
+        led {
+          led-sources = <0>;
+        };
       };
     };
-- 
2.50.1


