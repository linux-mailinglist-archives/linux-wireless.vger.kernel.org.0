Return-Path: <linux-wireless+bounces-23387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07910AC370A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E570189411E
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB411D88AC;
	Sun, 25 May 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gigw+IhS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35513FE5;
	Sun, 25 May 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209385; cv=none; b=GYTPBc749QqFYfEUxIZes6c6DOM2nKjdvBiIz1emTS40x0FEyHMBzM6E0EuB4lN3zYMia9xL8PqTT2uES9wOHgYjrk7YD+NRFUagFXoWLtxArmV0oKHBQiw4k/x4F9EWR2QGKYty0su9pIf0/7tZCiCYbnQAEHwwxARTAxZh5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209385; c=relaxed/simple;
	bh=HryFMxtPGQTUX66WdSMOipC0PhAm8iDYY5ItQB0wHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CidNDD+YcOkJhL3nOVN7BstNdUpj8DKAoq+74GGvXoa2XWHx4qgR3cz0cTa+BiREU0dUf1jqLuSqMibvF838xbzrtO2X25F0uwetF25RMEBjbrh5ZRDzBBMGYKW7E+0d+iO0TdkpiyDTdxAIl1j7+2C8lXK0EW8yAxtByts3TU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gigw+IhS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2346765d5b0so2035425ad.2;
        Sun, 25 May 2025 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748209383; x=1748814183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH+ITiCFQ4yVUKo5JFu8IMtQLXqlQ6GPmC9LCOWHvoQ=;
        b=gigw+IhSF617BAkZN4h0n8dRn3AxTC8dLXpAFR1nKAqNFVLRSNdt2mnZNZDL6LnkCj
         ebiIPiybe+uiuyXuwUTuRz2yA9rn58EN2OoM0cYhRTW2FuXQbFuzaDQZ8iQAWcDlF9Vx
         BM4dtAl5hE+H7oDruIizZeatUMufXSDCTfWg8Yrg0y8vxecPDq5v0zzA1cI1nZN85spg
         uex+8p4HvrBXscxRIaKfm5YTsO+BVlD7UPoBP8sLhLSfVt5LWeLi6ogmjZRv8+Gr2Jp+
         m4buF12awwls7wKW5h2u6fH6pOi6lup0qVkNE15BH02P7f9/VXIRZ9jonsCKjYMSUtJa
         WiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748209383; x=1748814183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MH+ITiCFQ4yVUKo5JFu8IMtQLXqlQ6GPmC9LCOWHvoQ=;
        b=cCyP4gsuktFEwFJEABSzmj7/sNIx1nT1BmOmO2biGuAbhEmDqULkcziKY7ZtUdSBRJ
         PiMhjFbzjsvUzs+j6z1693qnaUSgPA+uKIr++SrXIsvFgcgbUzCd/z4iAcRJO/pJrVIw
         58RkJJF4gY/NSqUpiVl89hzKCKEdJSTHs20PeKV0QEw5DLtsZMhWFXBBIqqsTqbv9gpv
         KiwFJZDg9imgSpBXCaC1Spra68nn2/O9m4OjkcArCDliwzbBogds1A9Hx0a1JHeioFYI
         xpE8a4YqdVHpuL4lsa9bmTX5J+xyWL187rtrr/3lqKhyoZPMAZQV1EBSaCxdMG789Zs2
         StOA==
X-Forwarded-Encrypted: i=1; AJvYcCVnrtua1LIgDrcfv1MveaYnhO00sjXn1kDw3vvPGYxsyZrqGB7QP+SvV+O85XpF6bCRF+zAHvpdwQ5PgQ==@vger.kernel.org, AJvYcCVusfFoFx5y00Fm+FSyviSFNpJD5YMGckSeDko8ePybJ7zbpNe/ph34yzYEoTDSqYs722R7jwWhlLHGmFTi@vger.kernel.org, AJvYcCWk4kmEZOP1lhps6UI1HZAZzJiy8qzgVL3aIZZ9lkBtuqVgtZgt6epz32onusTknf1AsiedK6lON5cl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3r6o9L26kK8Oif5dzXlKSA3OzTCDqCaT8MVeOVQAGscbIZDt
	wYyHK6ZbxMebXn8/AR+0X1qHzwjqKLSQAgFyGhLoEJXFVJrgEXdG07/EG9T0AA==
X-Gm-Gg: ASbGnctlFY4yo1tWFg4/GCyfuYpj/qDtVGtiHvSX1O/CLgn999otEjd1ebq1JcxI1RL
	mcPCxY+x7c78a88CnPSeJGTXfMVfwlX2gbw7iUL1U1V2G9vtN2e8TPOiq0pZ0GPUEoWNdqGXYZx
	jNxHg2ZvO4ZsEHIbMeg4u73DpfpDftX5SWs4BuSn72BNcW74B91p3SuGMkTQmI2EpVkh4M7g0Lr
	56KwdmVXYco0p/+xHWrB0G5S1EYVEL0UgWDOO8gg+2QPEH6UCgpufKUpG5yK9KnfTm+7f+Z3Yv/
	rPAChA66RcgQj42YzWukIkMDp4uByRq7dgNLUQ==
X-Google-Smtp-Source: AGHT+IHVuG0pXGAPSsFdx2JKLQ0D+CIypotEiHKZH0pY71D+4HxUhL2n78R2dpM6unFCJj33MS9OUQ==
X-Received: by 2002:a17:902:f787:b0:22e:4a6c:fef2 with SMTP id d9443c01a7336-23414fd47d6mr117312385ad.53.1748209382961;
        Sun, 25 May 2025 14:43:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340934d91asm35083115ad.166.2025.05.25.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:43:02 -0700 (PDT)
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
Subject: [PATCHv4 3/5] dt-bindings: net: wireless: ath9k: add WIFI bindings
Date: Sun, 25 May 2025 14:42:54 -0700
Message-ID: <20250525214256.8637-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525214256.8637-1-rosenp@gmail.com>
References: <20250525214256.8637-1-rosenp@gmail.com>
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

These will be used to replace the platform_device code with OF in the
following patch.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/qca,ath9k.yaml       | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 0e5412cff2bc..68d56e5b8680 100644
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
+      - qcom,ar9130-wifi
+      - qcom,ar9330-wifi
+      - qcom,ar9340-wifi
+      - qcom,qca9530-wifi
+      - qcom,qca9550-wifi
+      - qcom,qca9560-wifi
 
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
+        compatible = "qcom,ar9130-wifi";
+        reg = <0x180c0000 0x230000>;
+        interrupts = <2>;
+      };
+    };
-- 
2.49.0


