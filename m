Return-Path: <linux-wireless+bounces-32271-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEsFAEwcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32271-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:23:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 993861B2A76
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD28531F6C3E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495635D5E2;
	Fri, 27 Feb 2026 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="CNihtoxU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B534FF60
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165711; cv=none; b=tjfPRFLmIWVcgiUm8lJhLlKB9xma3/D2TT03m9vBYcAP3aTojio22lhcMYPVbHKJQXJ4OEOw7TRSZXQ83W4bgo0X/IfDpiBomPgEw4xY91goNBrOPmzdIxTBaFp/uaa8uDOy08tQHnmXryWkBjeHFhHuwSSBBd38I/BBJHYZIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165711; c=relaxed/simple;
	bh=uMJynkx/O6bdBdkFYzgA2QZyEir/x8/YP4F/uP5EXuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emyGzQ/TMs0cdWQxuFWfhcZ3LscJpCIsa6irhBmYH0+kC/6FK8lbRQ4bEJovV4NiBLwYqeoWul6TksK/PNFs/x3BnBTiZI3r810XI0/dmUcbbundibjhSU8IoGW04qZyU5kzFj/BSqKzc2pPJn1Et8yCVCJXcSCGLubYmzrBTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=CNihtoxU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a962230847so15253645ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165710; x=1772770510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gQaT39X1pW5Uj8P6xeoT4vITsfrQrMrLtWroQphzDA=;
        b=CNihtoxUdecozE3VrGz8Z7On7OWLmj5irBehKXIOC1kL6M2PdPRyBRkGUU0dJ8fRaC
         PhuPsQSryxwNh3/3MbdpZa7QZeXw5UPWVs/y6EHfp19ELR/23BXlrF9TZDw0F5GHR7IY
         4UABZ1cHvSLn7SJDDIknkRHYT2b1Vax2TxXYaf/cm2gHRjRvW1KQyLUjrC8gCNScV+FR
         aRXn2ZygazmJSDeB+LD6W76kWCPhvHcTb1chcg7O44lrBx3Z+w+07R52T5tOhRXZDCNF
         db3hO0Yq1ZoH8sz3WTz83FMMbTu+n3tWb8aDgQqFqkysPK5lJjlmJe7pJxATMzLm6DyM
         VeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165710; x=1772770510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gQaT39X1pW5Uj8P6xeoT4vITsfrQrMrLtWroQphzDA=;
        b=puTFnB5kLbEMfg9m9ZzGkzElqOVP+U2RnBaHlSbTs18tQDXPr2IHwRxJZVI9pDbLL/
         XZOtLTuqlS9Ebc3odnJYFyBrLZYERgV/DTxigisOxS2QG5IDL4wf9bVQowHS464jf0rt
         588aXNj5Sw/CCDgD7DumQRQAIsATEEJJJiyVNdQy9e9sH6VqaOKZEF1eNVKaa9sntMfd
         E5F5aWAd7HnddhVDCpIyX6erCnNwapapkjfS9u076L9fqaooPSmRthKEKJ5Lj49ZPwNe
         22VQwp39ZEzQkjDAKxqErYLAR4NwVjFPCM0Mh9n+sq7Dvp9b/uoeOSxmPZ1SsZTQh3Lo
         5+rg==
X-Forwarded-Encrypted: i=1; AJvYcCXSRUNxvejp04hO3Ccj+Mb/Pnz2uW7OrNpTRfPENZEPC4hsZ+VqXTCL0FhZh1QXC/gkQtWAvfAJoESJ1sKCpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzt7vBoiO202u6bo6VmtcFmc7lGmU2P0/nNCBmr71DLzfRRNX
	POkYRASDbJzYgJtJGmco15UvTjMHm25ecXmUZoLVIxatWPrQNjoZCyOfUIglHsxmOvE=
X-Gm-Gg: ATEYQzylIeyZsxvzUHXb0BU0a4/uFAZsquLVPvQqcHyBRd9Z5NTA5uUfM8a13+0uUzX
	Ya3PMG+b2GAyPiTnL8CEEl/CDe7gkPZbLrie0MSWeRZiMEJqUTiYV0LDuN47/dqYVfKueha1/VM
	F0lFZ14CuP9NLjljMiNVM1mfeGub6pk8hdajlJgTfKaqkB62o/DocabhofM4+vy1RvgLgrM3E69
	M6zwGTpY6chh9yupfLp1uk+g1/elmYxi8OW1hPEkkugRsaLxIUZWRXHPkZsj8RBm2bxU0TDwyRj
	67nap3bHCbK3NMuJyZmWBjGq9CdKlMHIf5R7Q55a6unQ83A7Flc6NE0KnylVAk4VS2dZ48FZDNN
	/BWBFPmJdVplLf2veQBA2n0OsEIGtocPrM2+SUGZQSEIL0JCsfXtlCJiQMUaP2jYbV8bX4sd7wJ
	8T2pE/GuUuMOnGXd0DW08oNaNBYw5fK4P72dJbstdX5YmIV/HEuMt3kiHq2wV1yY+xlkoBfvZA8
	jPSJGK/F9yx1CFMhRleQCmNVoj93Ds=
X-Received: by 2002:a17:902:d488:b0:2a9:62ce:1c0f with SMTP id d9443c01a7336-2ae2e4f3d26mr15698125ad.55.1772165709705;
        Thu, 26 Feb 2026 20:15:09 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:15:09 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 32/35] dt-bindings: net: wireless: morsemicro: add mm81x family
Date: Fri, 27 Feb 2026 15:10:42 +1100
Message-ID: <20260227041108.66508-33-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32271-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,devicetree.org:url,0.0.0.0:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 993861B2A76
X-Rspamd-Action: no action

Add dt-bindings describing the Morse Micro mm81x family of
chips.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro,mm81x.yaml        | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml b/Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
new file mode 100644
index 000000000000..653a7476cf8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/morsemicro,mm81x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Morse Micro MM81x
+
+maintainers:
+  - Lachlan Hodges <lachlan.hodges@morsemicro.com>
+  - Arien Judge <arien.judge@morsemicro.com>
+
+description: >
+  This node provides properties for configuring a Morse Micro MM81x device
+  connected via SDIO. The node shall be specified as a child node of an SDIO
+  controller.
+
+  It is recommended to declare a mmc-pwrseq on SDIO host above MM81x. Without
+  it, you may encounter issues during reboot. The mmc-pwrseq should be
+  compatible with mmc-pwrseq-simple. Please consult
+  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml for more
+  information.
+
+properties:
+  compatible:
+    items:
+      - const: morsemicro,mm81x
+
+  reg:
+    description:
+      <reg> must be set to 2.
+    maxItems: 1
+
+  wake-gpios:
+    description: Phandle of gpio that will be used to wake up the chip. Powersave
+      features disabled if property not present.
+    maxItems: 1
+
+  busy-gpios:
+    description: Phandle of a gpio that is used to indicate the chip has data
+      ready.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mm81x_pwrseq: mm81x_pwrseq {
+        compatible = "mmc-pwrseq-simple";
+        pinctrl-names = "default";
+        pinctrl-0 = <&mm81x_reset>;
+        reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+    };
+
+    mmc {
+        mmc-pwrseq = <&mm81x_pwrseq>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@0 {
+            compatible = "morsemicro,mm81x";
+            pinctrl-names = "default";
+            pinctrl-0 = <&mm81x_busy>, <&mm81x_wake>;
+            reg = <2>;
+            wake-gpios = <&gpio 12 GPIO_ACTIVE_HIGH>;
+            busy-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
-- 
2.43.0


