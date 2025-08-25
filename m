Return-Path: <linux-wireless+bounces-26572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A0B335A1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 06:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35F9D4E2096
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2159272E56;
	Mon, 25 Aug 2025 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8WWomsP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BF23C8CD;
	Mon, 25 Aug 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097299; cv=none; b=Y7+JFm9DSGV7RytMk54iNKehtaBPeUznX3FQIy9DGWFuUD+bDiWrOebZaLblqX/RxEdtyuOmuASnpiPWSQ/+ueJSrA4ZSItfNviBctBnfOKG6/FnPZHRJ7rmRzKsRYfG7+CrgSDdl57f8VGTVQPEZ6OIYuAWtQOO/5Ep7b5hj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097299; c=relaxed/simple;
	bh=VQAqLQTedVfiHboeFgJCeECZBjpKhMujL9+WI9Cvn6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBzmPkrZyJEzLgm7gWZqmYK+j6AWTqyDvVDgcqdc4qfUdb4yt9R+oyVKA47SVw5dKMFr424VEe/cANmsnf7NWg4oaaAibV0SpCgxLgocWVA2turel9Z+e4MzFvRZ2MRdXtLA9ACk3actM18VHn6e4zdNIZdb/j+LvwBLDRX+r2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8WWomsP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-770530175a6so538995b3a.3;
        Sun, 24 Aug 2025 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756097295; x=1756702095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzQ8M1wt2Lm7b7OtUgTgL/tytdwLTVWCzOvF2+iMQtM=;
        b=N8WWomsP5zaAwq1pththp2HbIT+8wlTuiXi/eJNUZobyKyvX2zLC67gllI/dwgsTSj
         hBKfkZ+WA86vrFCOS+mpSPNVeqvxWpXtyHQXmw9PeoQm01z++fAGu4/3NKpGnJ8ZFKd4
         yM0P/b3JDoXLpadlacZ2/U7BMnnfKW8M+jfHStgglraYB5ww/RbkqqbQSvmqFVvsLD1m
         wj7dL61xtKlgIcaPA79SYpdEwXVCXmywVysu55BYfOMUqdkxIgZ7z+9G1tMM00I6d+IX
         UGS9n8EGEOAvlzcZu03VCuEmAijTJpaJvrAFHl2cY5CvnctjtbWwDgE5Lsu76ssYrnNF
         3bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756097295; x=1756702095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzQ8M1wt2Lm7b7OtUgTgL/tytdwLTVWCzOvF2+iMQtM=;
        b=K6Cl/LYFN9gSxZCoMiOZPri2KX52Z3kYdw3+3LqJUsXOGm4spgSrq9JdkKzsBTnzrf
         xwlX/arTvt7d1DPiUWTdRh/aJ4olJmpwcp3qPR6n42aMfyozNlLV5dBqPtpqFPsdChHm
         jnzE6H76GujwtojddIba+lFN0kMU2GEf1ryU+iqWpMHyWCGylkjIRyQbe3Xm9uojEL83
         R++6ahm6F50KemCjoVygFD999oxektbBfHlcWZfaX6OjFy0NpXJ4g6o2rPzUjkdedAKY
         OhNVIopgvo2368zld0veE+YYUzX3/1RI+GHOuiI9FNbun6QgpqYOlYzs05ioMdGG6znQ
         LQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCU+I8rpfz2a5jxZ9i2II0C1HKRhvDHsOGhPWX4dIFx0LH42nRw6CZ1TG2Mnpv9vPBHk9YqjYi9+cEHOqQ==@vger.kernel.org, AJvYcCV2tzHHUz95QmhjJXAiMSrR4K/HnnOI3zBOJgH3m1qLGJjL47QF4VcTq7GiiNbn/eebqsOiF6wiEP6f@vger.kernel.org, AJvYcCX9xkNbzpLkxQ3dTEPvHXSmKB8rGJ9eeXPkbktyFgSwRZW9vVUSNVU805vxEVH9y3jpqv4vM10BCULlX1T7@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1wKSEQBUDUdOeHEsuUTkJMGzVoJnjTEyqVYwodEwROjf4beO
	DTjwsWpW2LYglH/Zhc/HN51pborNLj4Gst8N/q7QF38uI195xc5WhOiEge8yeQ==
X-Gm-Gg: ASbGncuyWpZ07rGe/wMn8Co7Duwqd42v6geM1VF4ZwYIxOIOm1USFVR/jeGrhc00BKW
	bOX7jJom8IX8pTqMwups5+q8CASZX0O6MniERofULs3jLJufc1NhBDaOhBmH/UwS2NRRJ6XykxU
	cXvY3W3pfkkSapXl1gCGePp34fpOj18HEDze0UuAozk0sOYk1i9UMozbUVnHTGfOSTVkm/KT6m+
	r543yHOWUu+o2+8SNOSFYRUfArJalTeCnPkF0TKMxE01kSmvqkoeRup9NzDAay/OeWuvCnbNykq
	UsamQzOiUSc2l1RSV+XnUC8q3rtkOyStzKwq1OCMvDmwB71tUoBmDzdvomcnGRtiGSwS+4Dwy9L
	xRVTYe6OTtIk2nEVvSwR1iGygCLyxDkhInh1vx+CSYEEWjLpHQCE+2IupbrpAN19oCA==
X-Google-Smtp-Source: AGHT+IFnLqW+QKhMvsuBnAtP+/QB8teWEWsPx0I9iheKRo2W/b6aCfYmudAFQZN+E+cA2wZQRXH1PA==
X-Received: by 2002:a05:6a00:13a8:b0:770:59c2:e9e9 with SMTP id d2e1a72fcca58-77059c2ebe0mr2914414b3a.11.1756097295252;
        Sun, 24 Aug 2025 21:48:15 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770400010a1sm6170153b3a.43.2025.08.24.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:48:14 -0700 (PDT)
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
Subject: [PATCHv3 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Date: Sun, 24 Aug 2025 21:48:10 -0700
Message-ID: <20250825044812.1575524-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825044812.1575524-1-rosenp@gmail.com>
References: <20250825044812.1575524-1-rosenp@gmail.com>
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
 .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index d16ca8e0a25d..bbac017d34d0 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -50,6 +50,18 @@ properties:
 
   ieee80211-freq-limit: true
 
+  led:
+    type: object
+    additionalProperties: false
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
@@ -102,5 +114,9 @@ examples:
         compatible = "qca,ar9130-wifi";
         reg = <0x180c0000 0x230000>;
         interrupts = <2>;
+        led {
+          reg = <0>;
+          led-active-low;
+        };
       };
     };
-- 
2.50.1


