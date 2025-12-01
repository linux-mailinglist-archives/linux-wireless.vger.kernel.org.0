Return-Path: <linux-wireless+bounces-29435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF099C957BD
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7001E341CD2
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899E41C63;
	Mon,  1 Dec 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="braBkDvA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD778248C
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764551761; cv=none; b=Bns0135sp2nr605gjFlSKq0PiLai5mDF6Q1Af16TeUxKhOgks2f30kzbWOvSR2ejhFAz0DrIiWvdSM9yCEpOKIbA6JjCkfnLrsBWEgRyEPCx4CGoHprKpRMUp2H/GaLQY8SVRo/ojjTlmpZQ6nibOy9PLvhUpr2zCz+/vkPLH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764551761; c=relaxed/simple;
	bh=DQZX0aUN3deUMYMHSt3awIN0HT0UN+IAtGAYEYKj0VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEDgwUfp8bQhGcnnDJKfeNMyzGVFAVmeMJ77VV3HWxB7fcJ0Q5S5mcdqp/4b/UPMWBMWUDTBTpxKkj700tz48XR5+eCSC0fehBT6msTlli75RQD0wvOLjDO7DSrkzW5zpiKBWDUDa6VtS1xJ8rmInJJVL4HLluTuBETSG5apd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=braBkDvA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b91680f8so31124565e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Nov 2025 17:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764551759; x=1765156559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vBWJ3jPxPdxJcqHzl2HAKyWXdjwinH4jPFuqseBeF4=;
        b=braBkDvA/sZjIRDpvf9C03Emab5eKXMJhN3NKbFpw+Dpk0idMAC3wahAiIRlaax76y
         Lj2AmB7KfAWonjkm6/emTjk4p1cw/vv9N47Cb1eVvTrmRmt7yMnZbw0Glu+8x3beRqXJ
         FmePu7hoHbrzu2GUT46NOlmI8iCOtqP4Qx8V9MBlBzt0LgKYr+08pSavu9P5Rht/LlJh
         2buZOga+5RtWIJI9CBWcgULquhlcFkzG9RSlo19rGZa+p+vb4ZNS4jT3w1SMw5JHNDMY
         kTx2YjnWV9lYlR/a18JQh8jMPVO1txh8/IGlct6HPJJAxctYIWYFjQXk1fnnSuq2OFqF
         UHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764551759; x=1765156559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vBWJ3jPxPdxJcqHzl2HAKyWXdjwinH4jPFuqseBeF4=;
        b=VmYAB+CFxNlPbcEikKpq5KA5y7kH8rJIw0FJ/z2Ce57YgyidvRIvl59z8VL+RFPwxr
         t3hMC8k3S3ASn0MQ7Pp4gKGUjAKXy3AI27uERGfdpnjlQvDe6D7fm07eypvUzODP8ogy
         wkvEAy1ObhpbCMmcbL9v3M1EYzIxFKaDJk57yC8P9d0VORsC3Lrmhf91NJRSSoGmJAXh
         CJxE38YKjoc9SboR7YIqU09Czuyq3iVWa/d+DuRy0LwSgmV3q9DZk+fV7A60zgfXW8sG
         Qvw84E7989QSWZvTp77umyoItkxPYZ1z6x/G1KpCbjwlr7XuK1WsUveD0swVnY7sECSY
         jkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+6PWcKm5jNfjaMG7LcLAWj7moPwYLpDeOltcsa9MpbVWqQ0gaixvY9Z9Tu+/+GSQC4VA8DrdkHsENw0QljQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjZHNlHWCJAgTIPK6CJTIFXYwdyQ5iG3GxaV1lZwXGjOx/+/X
	8P/mLOC8ULq7Sq92EGse2YjhltFdPJf1brMgeeAnMYVoEQz6Icd4WbbQ
X-Gm-Gg: ASbGncuTVKNh42F+TqCnLN2m+ffcN2Drkv2TSJo61v4AxY9fvohySa/Q4nl2Pq/haH1
	pFjzoU+otY0jNsFsCKhfrlI8TtSwFEH9a3gZ6YBPpuF6qe5z/wIGlZ7JtucNjXV502/YSxJq/p9
	OzNN8Zm8+4U+GWap4pipVuDjE7IG93xUoM8zkCTR3ZiNgK9U2vCNaXU9BU5N7iLD9AvP2KYx80i
	mQ7bDfmvkK/yNGGDZGfvvc6a7ImQdYrAzY+4ce3j8lITMejoMCkYmnHlgr2KUlr/tmQc8oyFiac
	8kVurj8k5Bf2PW0kUILGhXUByfoWmmTGdzXWqByZRDedC9hc1qsWJAhKa0+sPALUlmKULqi88Fg
	g1NDBj+3zMTazL0KiaSe+jU/dL0ifrT5kLrIwRQWyosTJtTdzQL9q5gWLnqU1PDYETndHcDW2fm
	XrY9g0nKxg+vbSrwR/Dijor/Vwyo1uQbv5Ivm9bbQsd1xc5XfrWKBqCQ==
X-Google-Smtp-Source: AGHT+IHPudKEEX4VAjuHNzkSbk45c8iSpRbQfuQpSIb3ohjq0wxflc5C6EoWRIJcTjRDZbjpyIxAHA==
X-Received: by 2002:a05:600c:8b35:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477c10d6fdamr360907655e9.10.1764551758470;
        Sun, 30 Nov 2025 17:15:58 -0800 (PST)
Received: from alarm (92.40.200.0.threembb.co.uk. [92.40.200.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479110b6da9sm216152305e9.0.2025.11.30.17.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 17:15:58 -0800 (PST)
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
Subject: [PATCH v2 6/8] dt-bindings: wireless: ath12k: Add disable-rfkill property
Date: Mon,  1 Dec 2025 01:14:47 +0000
Message-ID: <20251201011457.17422-7-daleyo@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201011457.17422-1-daleyo@gmail.com>
References: <20251201011457.17422-1-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

rfkill should be disabled according to the Surface Pro 11's DSDT.

https://lore.kernel.org/all/20250113074810.29729-3-quic_lingbok@quicinc.com/
has added support to read the ACPI bitflag when ACPI is supported.

Document the disable-rfkill property to expose one specific feature
(DISABLE_RFKILL_BIT) for devices described with a DT, so that the
feature can be disabled.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index dc68dd59988f..be44b1495ecc 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -54,6 +54,9 @@ properties:
   vddpcie1p8-supply:
     description: VDD_PCIE_1P8 supply regulator handle
 
+  disable-rfkill:
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.52.0


