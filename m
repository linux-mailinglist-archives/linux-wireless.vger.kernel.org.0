Return-Path: <linux-wireless+bounces-11373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A4950CC3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05671C22542
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076CC19D07B;
	Tue, 13 Aug 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g6hHk7Yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C341BF53
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575797; cv=none; b=sd+8G5li01sxaSXTdD7JSyqm69FLxZXvj4qfiYPMkGrNGbRYLpCZgBVKJ3Vpd4Z+VqY+WEri4vAlcCGQWxxVBBetQVsAgDD6gvTcXoPxt9cQPC0LcqFtx7Eqq4d0HZp3r/QiUZUbvlAde9UpbyXP2Z7YBPDi6kk6Dc1MaQ+eto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575797; c=relaxed/simple;
	bh=wZZi2FnrSd3Y6ntD+VqvzTWx0ibV9Sj/dK6MjW4hzrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjTwZRELHsqXm4jeK+ypr6P/qdb5rvsLS7L3y+9/cfLkoAz3ibd6XCTMAn5K/lyc2DN7PsLppsaFZ75IEH3tRT2P00c2zXAPbr8N97c1pE8+C9ETjLrGq816WtcraTu31MAGivQTN6lrAAJ3Lo+AjMNNS2T681ctZWYK4HLkBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g6hHk7Yx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so7415613e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723575794; x=1724180594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpSg/3y828Pw97blr6HDnxsdU+5aKQgCf2MNnTGXTPg=;
        b=g6hHk7YxcXKw9XYZlz/rldPNPtP9sSxJ3sP5e9/TD+gaMjqzohmlaZeYju6RqwpK3s
         EW0YwOgAKdyl9GFH5qavww7ownEi0yz+UHzqKtdW2ThprXl+rQQEditJeq3TgyjN2FUE
         mbEd9Vk6WF/WHVu32tWpkTG7SA+mqCzGMXQhzZdKoXv9KRXYEtWTH7h1WOOIsIGKIRZM
         uIT//+AZ2sQCMC9gON8jVUTrD+OewaVnYf48Rspq19wg5V6bSmNlcuuFLgNZ8a+SIlfG
         Sya7cPzOOX29nHuhRPMkGljQIKFbJbYai10US3rO6qkz2NH5I8MdO3VfXUiDa2kpKFJv
         JygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575794; x=1724180594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpSg/3y828Pw97blr6HDnxsdU+5aKQgCf2MNnTGXTPg=;
        b=RFFnSiNZ3SOAGzwcdXx7aRxIT49cBoElPUeR+y4wuVqmBUhREkmIbFbum8TWqvLTcn
         aC4Z21KqmHD2E7+wp03EggRT2LuA5dzbR+ES+8IdY9h5/fTi3rDSYeHznKr4AHu8jCHm
         NSZ30FCvBY3NtJ9hnt/ht9YyvCcHtGrV1QJ6zXp0BYvM18mKlGWDOKVCujnvWQRzFuy+
         X/NdsPpmWo8A0qGFvDJcBBsv9y8xWS6vMmugdogM55+MJtEIK0M9uXy18tj2gxvJoFQ3
         61G/s/mXSp7XV0LxfpXKX3qzDgW8grEAcyhK5mAckulkIJQcsYCbf7K8LrOI8zt4tOar
         59CA==
X-Gm-Message-State: AOJu0YzisCY4z6BE77Yhz1olXjfneLDdNTwnEWmy2VfanIcWRWe2pOez
	6NbdgYSz+FwkeXyfUF44mf/lELWZ2oHEBoGzGZCD80vR8IBkv5iKKW6n0yAvLSw=
X-Google-Smtp-Source: AGHT+IH+VagueuQIXMxGnIX0w5CylWhKwU2nLQR+DMf+tI3DEgtgkMQnem1H9OyA00MT+ZbTBm902g==
X-Received: by 2002:a05:6512:2351:b0:52c:b479:902d with SMTP id 2adb3069b0e04-532eda5b0famr222373e87.4.1723575794356;
        Tue, 13 Aug 2024 12:03:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d8ffsm229487185e9.7.2024.08.13.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:03:14 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: net: ath11k: document the inputs of the ath11k on WCN6855
Date: Tue, 13 Aug 2024 21:03:05 +0200
Message-ID: <20240813190306.154943-1-brgl@bgdev.pl>
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
 .../net/wireless/qcom,ath11k-pci.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 8675d7d0215c..404974d77826 100644
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
 
-- 
2.43.0


