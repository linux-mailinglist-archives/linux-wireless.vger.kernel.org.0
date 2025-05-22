Return-Path: <linux-wireless+bounces-23324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FEAC139E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6DEA23728
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5F1E501C;
	Thu, 22 May 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f90VcGQ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B631E1E06;
	Thu, 22 May 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939526; cv=none; b=BPgzDggQ3kF9Qd4Lp9Obsa+Ul4b+QUxoQPEfixnBuJ8uDfZFyTV6AomlR1TpVhK0ovz9HP/It3RXmlPNup97Uely3b68d7lctNHjD90lrL3BSSq/ZlbitIKedoA1hpiSEi05Vaax7vgDjeLVD2+ERH8WMXYzECyAobyXhihsPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939526; c=relaxed/simple;
	bh=mdl+sarQ+2QfHzGOrQvNeh7W0jb+p0S007RInUhFJmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzPzDew11um/Od+HHoyfcWfx61NRgcgP+mWIDw/vYI9hqTgpnefdhK2ClGSxWge2J632x2U1ly28DQQnitv0tjjYNbviO8agg+Lg/JW1hNr5v+yWyGdm6/jR2v3PoEZUImhJiSQRjAmNVhvopWu5W9LP3+Sz2l9WDkiTVM4fw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f90VcGQ2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c44e014so8136157b3a.3;
        Thu, 22 May 2025 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939524; x=1748544324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q5TA9nmQWJys6LYZulKrAmVUie4NN8lnpBt7un7g70=;
        b=f90VcGQ2z2tTcDqP0TGL991tbjLSasKJSrXgoA1AgAiAGEr9WY/syHHiA6wb2Q/o6f
         L0JszR/vCb2e0d6CWSnMbvp0x29uvO3iWLXvmMlw7lC3sGjV7CA8vXlvR+/FMuiN/hQy
         O5L1rucVInIfCf17ouQd7u9gixdOxKbHGdZkGwT5X4kLcz5xi5B3Ylu5y+NNZSB1dzkZ
         yiJ4Kdvc2KK3MZGKX2wutuI3XxCZtKzp1uwLl0eQbeuAnz9OD5LmfDhpW7U/ERpEwg9p
         GSwlje+3r3bjE8ZMGSXKcj1j06e0TYJ4eVRwsBZxhX3CHuB964hUd/9L21/JsORFTZZp
         1ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939524; x=1748544324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Q5TA9nmQWJys6LYZulKrAmVUie4NN8lnpBt7un7g70=;
        b=sBg4CkjOKLiE29/bVuCrDIJrPNZnyr3c5X00ar8O3bTPMLD/fqCJJ7phwO17HAOuAo
         t/78pOvL02dufBMey4IRKBzPnetqZW4NWHDUhCzHq4DVPBL4zor+229qs885nxGmI/xo
         qC+7W2we/Drym74RUfpyII+gJQrihCbC388GARm0zYCJX7G1GaIA5icL7a4LGdEhxBzd
         lEJU767cTqLlAmptpzMafpJrQrUB7fZnIy8n88Tl1xnZu0irBq2GHLpdeIpEZXfW9pzo
         Ggs1gxxBBcsB+0tRMCeQz1nL2LEdj/y67sdRpy9CCuSAOZw3TkAHZMVk+TbU39psX4zO
         MdQw==
X-Forwarded-Encrypted: i=1; AJvYcCURMPsC1wqYcd7oa93PbWx8ogJr48cgw0Bfg8nWUjZK4c4FpcUatb9E+JO7LmudYDLcnFNagyH7Ef/oCw==@vger.kernel.org, AJvYcCWWqRMVlcn8At58SlQDUOV9kdTETqTitK0aEkuhbU1w8Nsucbr6gfN1+qZkh4supgirrG4fmlK6TuxF@vger.kernel.org, AJvYcCWyUyv3s9WYCAmj+/Cve7GDAMHq2P4tUkuPQtCLVK33/qrdBWsmzFoVoVHDxDOE/Y+ireFgZdk0Onu0b7Gp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/sIXTwyW1UN50xoCsBlt83eEJpEX/tZoVjRZlw4la7j1AFGu
	FFtj0wykgQStFvdVPeb+O+0Kw11DIjji3SIpN7O1z44OPDRjDECfA5XBN8or1Q==
X-Gm-Gg: ASbGncss7XHOyJhSL5HNLzJ+yBHJUaQEXZaAxAzmtcWIp8uiO+2lHm3afOyn7rTBnsy
	rECdWmIy5fKXGw9ecfAr26m7UGpELEdVeJQpOVOpG3otocAGk4HSd1+7px4nQ2Dq7TkAr3PFJCE
	6A1twxkqB3qbpMsJmlq29QYcG2pZqaNJe0rrO96qhC0HGPh/pysRHVMNIs8WH3JWbz0EcWW5Puz
	CQGQ9YCCThCL5zL/S9Ld+pbYj1unpViC0VasJjlsiL1HR/AOxilNxyQT0DnLb0xrjeQbRSe/uJh
	n9L1SzOvynTReFhoippfUXPncOw=
X-Google-Smtp-Source: AGHT+IF0teBCBhSGoMWrfR+mIwXMKC7BSfHEmjtXhp0/1y9ycgo1n1nGdQy9oW4tCCJppSe4JHqm/w==
X-Received: by 2002:a05:6a00:2da5:b0:740:41e4:e761 with SMTP id d2e1a72fcca58-742a98c144emr34162758b3a.22.1747939524178;
        Thu, 22 May 2025 11:45:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm11502424a12.23.2025.05.22.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:45:23 -0700 (PDT)
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
Subject: [PATCHv2 4/5] dt-bindings: net: wireless: ath9k: add OF bindings
Date: Thu, 22 May 2025 11:45:15 -0700
Message-ID: <20250522184516.13176-5-rosenp@gmail.com>
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

Now that support was added to the driver, document it.
---
 .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 0e5412cff2bc..81d00f257922 100644
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
+      - qca,ar9130-wmac
+      - qca,ar9330-wmac
+      - qca,ar9340-wmac
+      - qca,qca9530-wmac
+      - qca,qca9550-wmac
+      - qca,qca9560-wmac
 
   reg:
     maxItems: 1
@@ -88,3 +94,18 @@ examples:
         nvmem-cell-names = "mac-address", "calibration";
       };
     };
+  - |
+    apb {
+      compatible = "simple-bus";
+      ranges;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      wifi@180c0000 {
+        compatible = "qca,ar9130-wmac";
+        reg = <0x180c0000 0x230000>;
+
+        interrupts = <2>;
+      };
+    };
-- 
2.49.0


