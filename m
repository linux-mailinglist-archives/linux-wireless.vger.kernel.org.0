Return-Path: <linux-wireless+bounces-11396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BC951685
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347351C21553
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840913D518;
	Wed, 14 Aug 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DknMwwF1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E122BB1C
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623788; cv=none; b=hHAwksHJeWd3x/vHYj+Kj/YBhgdq7g34qQoNgS/OyKKn0Ey43EIxGXm0JAeg18Zg0qbuKZWAxuw0dPL4nEU6wABV4Sr2Z1gLwNsY7B/JLRe2ZLDIWOYUOsZ5zwq2iEr5bdfix4d2hcAKgD72+vNXGYYUKX4OzAxEdGHdFYasUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623788; c=relaxed/simple;
	bh=7zQmXFtp0irvN6V25CC38ilmSUQlNSUvGWilWaQsDa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLQ91jmY0US5NQSBUZYYawpuOsRym0NCYc/bGj5cvec08Hi80q/abwF5sFDZdXp6UISDbUSkDjxGnxG90XuPMMJj2ESZkHqQZejeFHFCzJbV5AaNcCyfYdZzwhiy0yEsTzNRX5BPrXbrnXjTk6bAFJseS3ieafwQbeJkFQjtvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DknMwwF1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efa16aad9so8195729e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723623785; x=1724228585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yid80DCBncovH6jR5spdivR69CuAKWTUFwGxvj0edc8=;
        b=DknMwwF1iqYMri+KWir1qjp/1q93kiG2ukTDehLU3KEtlIyaT8ZmHTkGOucvF1sxgL
         D/TYfaE3BjviBTf6gzZ0rZ3uyiIQmqP6bWGE4dRIDx7VgPMgpb8MtaM23/M2pGAuCxg4
         RvTR6ATap/N1uQ4Y4z6m7T+300IzjZzCPuI45t3TCwqRguwAtr2Yx0YY20o1bPOXuGfB
         OHFqIyGaWL7jXZn/5RwfYsz2dqkooEALsijotU8UGPIW6T+BdQc6nazM0U9wQ7YdV8Mm
         hztkoD+VWA/9eFJZZhbi4u/jJ8Pos+L/qgMn9nQEUOYA9fFkHPzVQRTBeAj8GD0bU85P
         s44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623785; x=1724228585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yid80DCBncovH6jR5spdivR69CuAKWTUFwGxvj0edc8=;
        b=j5EB6lozuAleidk+iJntLWisUyDk/JELmZbt2xqv5x58zE7/v5+EWLVZPceIVshndW
         t9ENi9KBzT5b46YRknJfCEdNl/ERNN9xdzMGGBe6XTGtsHp83MPvkdCOYVJueacVV4lW
         BPyX50gRbboOJqC7asIHDoqoZNW5KrmSmjD+lcIbcsJ9wxDIasa8XPWtZTqksPu6Ams9
         /6r/p+iTGtE9OlhhaAt1S+X0kMn1921Vkd9PcrCZl1SsC+eghrdzEdFroTZ+4Dtg01xJ
         fiemmWGWtLEvD5hcVJFhYdairyZz8BreNbEet8Qbt6Yzg/s7A0pwYtrV4CAdbpw5nUGu
         bpLQ==
X-Gm-Message-State: AOJu0YwBxLaXIKrUvtE3wUXskFxvzhCt9KtZkKuAf+a1R2WR1kCzw5O4
	BJTYxW0Xg/1hBmPfLI4ujWaXYw4v3qpVL1yI0FdSys+q47d2AfkHM2/va6pC4lI=
X-Google-Smtp-Source: AGHT+IFPWXB9dUnt/qnGZpgUiPgGFQ/Gcyv7ImyYRoukKJSYr8Bd88c9u6QJYgrVy7BunlV81DHiLA==
X-Received: by 2002:a05:6512:3c89:b0:52b:c27c:ea1f with SMTP id 2adb3069b0e04-532edbcdb37mr1268165e87.55.1723623784986;
        Wed, 14 Aug 2024 01:23:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e78:fb96:21f1:335c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3cd99sm12606325e9.25.2024.08.14.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:23:04 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs of the ath11k on WCN6855
Date: Wed, 14 Aug 2024 10:23:01 +0200
Message-ID: <20240814082301.8091-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the inputs from the PMU of the ath11k module on WCN6855.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- update the example

 .../net/wireless/qcom,ath11k-pci.yaml         | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 8675d7d0215c..a71fdf05bc1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -50,6 +50,9 @@ properties:
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
 
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
   vddpcie0p9-supply:
     description: VDD_PCIE_0P9 supply regulator handle
 
@@ -77,6 +80,22 @@ allOf:
         - vddrfa1p7-supply
         - vddpcie0p9-supply
         - vddpcie1p8-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: pci17cb,1103
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p8-supply
+        - vddpcie0p9-supply
+        - vddpcie1p8-supply
 
 additionalProperties: false
 
@@ -99,6 +118,16 @@ examples:
                 compatible = "pci17cb,1103";
                 reg = <0x10000 0x0 0x0 0x0 0x0>;
 
+                vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+                vddaon-supply = <&vreg_pmu_aon_0p8>;
+                vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+                vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+                vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+                vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+                vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+                vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+                vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
                 qcom,ath11k-calibration-variant = "LE_X13S";
             };
         };
-- 
2.43.0


