Return-Path: <linux-wireless+bounces-24833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17FAF9C06
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CBB1C472FB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06B24E4A8;
	Fri,  4 Jul 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMvXuqTj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FD248869;
	Fri,  4 Jul 2025 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665348; cv=none; b=l4BVE6cBBgLoidLcWvTe86wqURRBxUFuqdGNr/8gyf7TvfjJSeuvcK9yaqUwCB5HIRkI1GAdbdEhWTujX/0XYNCZ2/hZxT0p8P3ed1fuuD63olJVUqSJ6TNDdsJOpTYSFXr1Y19DYSGXpibW/ZanJWAZF2wgRawmEuwqv9nP6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665348; c=relaxed/simple;
	bh=wgi16s9ONbkKzg07d3eEsZc04Giyv4lr/RVzTFChpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGAPbzdxhJBcq4IvtcPjDrMMVWN4Z4Qf24Ax/3frwq4cst+zVHZb5jFRS4gkxti8AadojVn5dSEwtndeYWkZ2seaQW/GtkYhVn27BOpgVbBGj4dZDBlbKI8BCvR1XGk6V7f9zdTFNykj9ySYFK26/iAINbH6NxGgPjwGziltiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMvXuqTj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8a5053c2so6422385ad.1;
        Fri, 04 Jul 2025 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751665346; x=1752270146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II4Cu1QeU8K5BatbGIsTX5njwU/JOM7LV3cYYXHvMxg=;
        b=MMvXuqTjMIhGeU5R4zaI4XvES0ANtgYl1wh4QhzsrffXNWe0zHimH93s1ze2AUGrf8
         KQpz/Hph31psfUfxOOBXnbnUoK7Yals7GhZrgrNDBPXCd8LpbG3Nt1vFaZt0MOXr01Jv
         HqEOPT94QcpxlL4hbR3Y7sudSwk1nYzg1Jc2j2C6GBmFPMDKLlBbEMtJWRMUpwEoOnIk
         ymngmrNt31GkEepm5gTMg24fR9HWTpdU4Nt1ERhib7pFUn38Q/CTL5h94m/56Z3HK1wr
         mp6S4sMt6wPt0QkcSj67tuFNpBNIn2+1B/LVjd7HpSGtjg8vSrrKlnjUBKep8deBROXX
         NI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751665346; x=1752270146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II4Cu1QeU8K5BatbGIsTX5njwU/JOM7LV3cYYXHvMxg=;
        b=cJ4oQ+OJXEbw0OsdWqEa/NHijbKw275X9ubtzBWMXBNvifOhcRHBgN78QxfhNQqr73
         gG1B86Vo7YLq4VCtGYxG0d8Vt9aPrwjD8X3BgcFOipvh95aU0FGhIPNoztuDQ+k4eUe7
         2lpANsX9DCWEWhoKdA9nXSMwHbTstbVlysRRye+EoG+xlKvtwwNClf6R0UTqJJkRJwEz
         8Fd5z3BPTm66ZK+ou65Tmw/un+tyfcZYl4o+VPn5sYWPKm4cFZBE8gEWHJXIaOv+wtYI
         CeyrgRFkXGWphbWgPe1ZNHD8g2NzETfmwiXYkADQ4+WM4xgQF0lFgcjRrdOdjeDXjp8y
         60Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVAT72wF2YWTMiARnQXwsuBaObRQUJb3SFEUNjRa4DCTMopfWOHHrNGZS/Xf3dbqjia/oDiFKxpZ/VfHg==@vger.kernel.org, AJvYcCVRXanypzCPenbEjBLbalfgNE/ipbIUBlTMjRiGnn+qOk8KZG06Ff4lwq+OVIwo585Dnq/LYS/T/zEjx9S3@vger.kernel.org, AJvYcCVSJTtj6r1x4QsQIrYeO9vb9L/Ak8SBvLpTZvN9LHkah2nfuMinWM8A/7WpsRLypK3pkAiOXRf7kzwp@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/6bpY+X8MxISKLe4X28X1uBYl+gzzCDn4hgDMMwWbG0BL3Pp
	2AnpANVf3Ugb9I/OAU7Dt2vcLZvl/1zST/hboxhzgyTxSwKKEzWHbVMfyO2F3g==
X-Gm-Gg: ASbGncvt86fuzJ8xZfHdM2sT92lh2LIo20QdBvrshjXWmhxEYpV9+SPapSv5LRdLMlC
	9a1BDhBx9AHFo1n/xuJ7SThUEmIzhs+Kw6hUbKOJT9DoaLF5oVE8ZuL4Tbd6no+J4FvLMx0IkJb
	rvIq4nhTqg8hLZFYScPZaZDO9WtfsGL4jqa4Na6Vjovx2wnIso6mkIOLP9V3ofJcLX/g/I9B7H/
	rNlXCvoI8hU807cjaNcaZ5lrH0gpOWs5Oio30B0086m4JvjsX/T+ZT2RSUuF2Gy8AxrhdgRFHUg
	7oj5V1RULzSVFpkoW64EIj1PRTCk2WCdiZ5ENQ==
X-Google-Smtp-Source: AGHT+IFuLOdyjx4vrHeFaSve6Mt6sEcspWYz7meq2ew7UJwcQgMsfVWOc9xX85QAnP38haLZ5qiTxQ==
X-Received: by 2002:a17:902:f54e:b0:234:1163:ff99 with SMTP id d9443c01a7336-23c9108e5a7mr2108965ad.43.1751665346593;
        Fri, 04 Jul 2025 14:42:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84597371sm27950315ad.207.2025.07.04.14.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:42:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	jeff.johnson@oss.qualcomm.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Date: Fri,  4 Jul 2025 14:42:17 -0700
Message-ID: <20250704214219.18796-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704214219.18796-1-rosenp@gmail.com>
References: <20250704214219.18796-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used to override the various defaults the ath9k driver has for
LED pin values.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index d16ca8e0a25d..58c7b873cecb 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -50,6 +50,19 @@ properties:
 
   ieee80211-freq-limit: true
 
+  led:
+    type: object
+    $ref: /schemas/leds/common.yaml#
+    additionalProperties: false
+    properties:
+      led-active-low:
+        description:
+          LED is enabled with ground signal.
+        type: boolean
+
+      led-sources:
+        maxItems: 1
+
   qca,no-eeprom:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -102,5 +115,8 @@ examples:
         compatible = "qca,ar9130-wifi";
         reg = <0x180c0000 0x230000>;
         interrupts = <2>;
+        led {
+          led-sources = <0>;
+        };
       };
     };
-- 
2.50.0


