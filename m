Return-Path: <linux-wireless+bounces-11658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AD9583CA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE88B1C24679
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB018CC0E;
	Tue, 20 Aug 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g93AtGvW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683B18D651
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148753; cv=none; b=rH1oYCHHBizwAixP5F5cLBAWtY8ILionVrWoUZoQgC6ji/hYOFYSOLqShcp4BeiQUtv+8Bdez5OjWap80k6MmQFTWMV+ic0XuGpNbEgSYXYU/AP8j+nHLzIo4/vIx20l6jkJX6KUIKdlUpIpaK6IVbMqnNB5Fvr7iOy+JsGdMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148753; c=relaxed/simple;
	bh=VewtWXS49rpJWHjz1uJir39tVL9jfwaiGXaUkx0zaPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSq+F58Hx4UOGcR8Mdtg4vrepr8AAm808CEA7BIPFPmA5rm2xJsAiQnNoBj89kwSpZTP9k1+YX+wrqvC2RPZdusHQtxprpDhIH5FQlhO0+C0vVR/ccOhNp/Q2F0xIQsAsBTdAOeZFTFrf7BQS6bM7D1eVGGxpNkXDZvmKSKE+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g93AtGvW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d162eef54so3413542b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724148749; x=1724753549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kIAhfjDAT0axAt0+BwPuqQ3ky4+ehVgWPUi5t/CRCY=;
        b=g93AtGvW8/VZO6aNeqrOG+t08+BT6XpfXmcfyOtfT8+A5Lj/owgyDI6xwI6cZ56NkL
         9UazQ+aDYC8XXsYnLg6Qva+NepMBg2BN9X3COQHIUdWTHmJ6h1aOBc8/g2AptahG8hCu
         vO5IH5IF/1OT53Y7A1fGdJQvX0FeHQNiCYIV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148749; x=1724753549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kIAhfjDAT0axAt0+BwPuqQ3ky4+ehVgWPUi5t/CRCY=;
        b=b7YPYelnNOYZN8s10idgTzwv0bKmDICoIMkjUPUHUNSPZcGGObdfABjkVZwEGXJfaI
         ye4hz4J8UsrpQM0BWygFTyEoFQxFS5z1NO/Nrn6E1MgBo8XbfK6qpXXGo3ofXdFNq7oj
         ygvDcftt8BncnN9zThFZVhEPH8oylV2snMF6FkFC+1knQwxdpC7G9fqeJHkAlxV6xwDE
         9Nh2Ut4OegAcZRycIOUY/tm31R+wERD3QKIgqyN7+KCC/pqNus40dl9olrGUV0zTclC7
         OuMo/N1klhR70ZUUKJbUJhLTJ5xSRLcZh5NvqsuN3/zgl/tLg0nTje6kyNxAuVOrzrlT
         3xZA==
X-Forwarded-Encrypted: i=1; AJvYcCVa8HsIjE8+7c3HI9k+BZ/1TNySw6nl5OSvEv3a5H03hiNErsuAxCMeSKcaVVfNHtUg01oFXq7hQ1NyWtKSz9FM6DnBK8XTISwlBl7ulWo=
X-Gm-Message-State: AOJu0Yzjx8M4vAXTn8bzLIfTAy0UIok81m/Nnsg2myBGsuMR7YKnHIdV
	rLhLz/bbwSCl/kMQJxki1th0APD38tEEQ485/4rCl/VT68hNifft87qNhXxmCeeJDhRjrAqmyf3
	Z8w==
X-Google-Smtp-Source: AGHT+IFn+Oek7Agv106ZiUW5dAmUwXfOggJfDPRWsSst4ULyviFLXwjGXgAlAEpvMq4hMh5bAPWL7w==
X-Received: by 2002:a05:6a21:318b:b0:1c6:fbc4:7a02 with SMTP id adf61e73a8af0-1c905060b59mr14542718637.44.1724148749225;
        Tue, 20 Aug 2024 03:12:29 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-713f3c35cf0sm3111052b3a.173.2024.08.20.03.12.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:12:28 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	asahi@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/2] dt-bindings: wireless: restore constraint for brcm,bcm4329-fmac compatible property
Date: Tue, 20 Aug 2024 12:12:15 +0200
Message-Id: <20240820101216.355012-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When extending the bindings for Apple PCIe devices the compatible property
specification was changed. However, it was changed such that for these
devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
string in the compatible list property as it was before that extension.
This patch restores that constraint.

Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f41..47f90446322f 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Broadcom BCM4329 family fullmac wireless SDIO/PCIE devices
 
 maintainers:
-  - Arend van Spriel <arend@broadcom.com>
+  - Arend van Spriel <arend.vanspriel@broadcom.com>
 
 description:
   The Broadcom Single chip MAC part for the BCM4329 family and
@@ -27,7 +27,6 @@ properties:
               - brcm,bcm4341b0-fmac
               - brcm,bcm4341b4-fmac
               - brcm,bcm4341b5-fmac
-              - brcm,bcm4329-fmac
               - brcm,bcm4330-fmac
               - brcm,bcm4334-fmac
               - brcm,bcm43340-fmac
@@ -46,13 +45,15 @@ properties:
               - cypress,cyw43012-fmac
               - infineon,cyw43439-fmac
           - const: brcm,bcm4329-fmac
-      - enum:
-          - brcm,bcm4329-fmac
-          - pci14e4,43dc  # BCM4355
-          - pci14e4,4464  # BCM4364
-          - pci14e4,4488  # BCM4377
-          - pci14e4,4425  # BCM4378
-          - pci14e4,4433  # BCM4387
+    - items:
+          - enum:
+              - pci14e4,43dc  # BCM4355
+              - pci14e4,4464  # BCM4364
+              - pci14e4,4488  # BCM4377
+              - pci14e4,4425  # BCM4378
+              - pci14e4,4433  # BCM4387
+          - const: brcm,bcm4329-fmac
+    - const: brcm,bcm4329-fmac
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.32.0


