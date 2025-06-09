Return-Path: <linux-wireless+bounces-23841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB47AD1755
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F081690E5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB24248894;
	Mon,  9 Jun 2025 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGC25u68"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C724887D;
	Mon,  9 Jun 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438552; cv=none; b=fuLToGAdz1OKjdwSebZfCe+gM8nFqeJCol32H49FIOsZaXBkkQT0eEmnjrS5Nl0BJZoECXl4lTSWInQlf7qCqDrajaJFYd5V4Z3ReD8tsDaNbILIwhVteWLszCDRqnjjUcJJ/tyIEdKDOi9xacrFuskTTOo3TkBsDt14f/R4FGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438552; c=relaxed/simple;
	bh=EjUUqJu78gnZ+kZus0mVe3cmsSfxzWDnvCU5fOgyvDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbl4rDCD3DIPauC52eOVl5pbRjHNoJIcec5m2MHE3Uz2/HAF97+b0bAaFPdKBSFnyUvoVrWj0PIta1oogh77U+lEoUROEo8xMtfcdhm47JDc3+Iyj2PjHIRunnPkZpON/tgDWBxiw7hWf9uwXQ/luPUF/e5l+KF+imt8szY+uZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGC25u68; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3116db72bd7so4363304a91.2;
        Sun, 08 Jun 2025 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749438550; x=1750043350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3bCHhvCIyIyl0fJCNdcz93NucCjpdi2oytkopjbSYk=;
        b=DGC25u68IcdIm6vMdWnIPTI8yCzSAIm1qqdMaRMHIFyqXdvxr9Hxnn/53tgqjee4ro
         tunA9c5j1oR1pvfmKBnivTJ29JC7d7HZ5xS3aeD9/D0pb/9UBJWr0c1uS67cWVSYfYUz
         3l0tMrc8dn0LDIB7nb8LHZW6Aa3Miqs1QH6lYu5QkyzgECOlUVjte5y/2HIpyHNGj2jU
         ggWIl4WBEve4wdYnsEKgOKRVrmqdaSJBk9Erb1Co4phwJbhU9OWq1efqJU0XfMb+omZW
         NvHlKIdcq7EqhrTCEldFAFFYLx980nomdSSgVEQgutsAoIJ/ROoGYi9THMaEZyj/XQoS
         LkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438550; x=1750043350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3bCHhvCIyIyl0fJCNdcz93NucCjpdi2oytkopjbSYk=;
        b=pQAH5Eb+3khDCbPj2kYWF8cVtbsn7snF6KVWASOEY0c4gAPfrjsxaKJs5om2TWvgW3
         gXgaH05HMuvKNO7bzpHoOlcni+ntis7SS9JeUFYWmyu+RymJyNOeoi52u/gHV7b40EDv
         EieA5woHSkH+9w61dVjNetCW+O7TB9mqlmlOy5omGQHWL8ID639zHPcGyeQMICPXc69W
         0/uzYFbFhw9WpzD4Rqu9sM+zVUqFE2EymoeqvZ52nzJ30p8O3lC4+R8B0/0rlsAwuS/N
         U6NE0XQGhsbKyyagGLsnNrtjex6xYLpwAMygikOAMxWLPbag9c4CxEFUOmkvgjUw83xL
         9eig==
X-Forwarded-Encrypted: i=1; AJvYcCWeHFNDkHVgBbAATIFz/an93LKaG9e2xanmQpy9W88aQI8oDN9OXhHOqEV3wTzZD2FpzMmkYTOslxyG7V6p@vger.kernel.org, AJvYcCWhRHOlgiYX2Syg9m1Uxq4A0lbcHb0yHovUAn6ppi13Bsotx1WdsHpVVB7NGxkd+ekZFSL6Z0l/DCpXMQ==@vger.kernel.org, AJvYcCXpxA9Sb7FZCH9cW3oT6P0lPNFIfZT5+bWx3DG36ycjJYRUvxiLsGR2A9F8AntrjV9Ht3e/3NApfyc0@vger.kernel.org
X-Gm-Message-State: AOJu0YzEU2fq6XVg1bRxbQLkYi/llM91OSpPkMbQcJtiW0kWi5stps3T
	LasY4urHAgaLoMr4SD84EG6ebqxeHX8N5UUe3qJmACZTLff3wlo3t26UWUahMQ==
X-Gm-Gg: ASbGncva0Tw80WUUbAbPxC4UneTa2IFetHITAls1wy9hi6wYN5P+PBfzD9A/1RaylPV
	hd+WMz2tFyah3Co4Mt3QWFj61UfNRvYHqsXVwTMP0oGyMsFDK9BvcXVccqZkLR+JcIkEOkGPQWb
	lZbIJGyLqLpa8dMA7oYI6w1C6qrjIjCUp+wkmLSKwyQs2r+XGmajDekr2fksoZioB194WiRvDfR
	i3DILIOEkQabhT8uLAqBJZ987FD3HyY3Avl3PKCwuhRBw0j06c39AI9EGUnTK86MuLNVruwrR+K
	lkieY1qeo6V8XfqnBke7ef9hmVvxzejaNXD/PBFNG0ufg/Ur
X-Google-Smtp-Source: AGHT+IGDdt6lvdKRoI8nANALMulWUxlZRz3RbGDARFAjSoFf8I30K0QWIhCZQ3b0WJxeTa6N4UvLIg==
X-Received: by 2002:a17:903:1247:b0:22e:3c2:d477 with SMTP id d9443c01a7336-23601d25c36mr181650275ad.25.1749438538959;
        Sun, 08 Jun 2025 20:08:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccd6sm45310125ad.134.2025.06.08.20.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:08:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv5 3/5] dt-bindings: net: wireless: ath9k: add WIFI bindings
Date: Sun,  8 Jun 2025 20:08:49 -0700
Message-ID: <20250609030851.17739-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are for the wireless chips that come built in with various
Atheros/QCA SoCs. dts wise, the difference between pcie and the wmac is

AHB > PCIE > WIFI
AHB > WIFI

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/wireless/qca,ath9k.yaml       | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 0e5412cff2bc..d16ca8e0a25d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -12,7 +12,7 @@ maintainers:
 description: |
   This node provides properties for configuring the ath9k wireless device.
   The node is expected to be specified as a child node of the PCI controller
-  to which the wireless chip is connected.
+  or AHB bus to which the wireless chip is connected.
 
 allOf:
   - $ref: ieee80211.yaml#
@@ -35,6 +35,12 @@ properties:
       - pci168c,0034  # AR9462
       - pci168c,0036  # AR9565
       - pci168c,0037  # AR1111 and AR9485
+      - qca,ar9130-wifi
+      - qca,ar9330-wifi
+      - qca,ar9340-wifi
+      - qca,qca9530-wifi
+      - qca,qca9550-wifi
+      - qca,qca9560-wifi
 
   reg:
     maxItems: 1
@@ -88,3 +94,13 @@ examples:
         nvmem-cell-names = "mac-address", "calibration";
       };
     };
+  - |
+    ahb {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      wifi@180c0000 {
+        compatible = "qca,ar9130-wifi";
+        reg = <0x180c0000 0x230000>;
+        interrupts = <2>;
+      };
+    };
-- 
2.49.0


