Return-Path: <linux-wireless+bounces-10232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A2931B1C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF5CB22002
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC49139588;
	Mon, 15 Jul 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b="ZIhBCJET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com [209.85.221.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB372131E38
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072397; cv=none; b=UExKKd7af+mM8jrw9Ic+MsJsKi+i71VMUViLCXTk6PqirMnd8y6hdEfMZ5I/0+aeIKVa6fjsMUkCjmZLWG7aKpl2YlA8Soe7exENJbXkM5ZewvCahcAtcuWXhiZtHMbAP8N2DM2ow9t8NNi0YF6C5mZQ7fwBuBXuOAeJnqZmVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072397; c=relaxed/simple;
	bh=JRXyEnJ0mjfSEpHIgz2SPH8IYMLeeWfcoU69RXJFUek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsMP3PuRxDnSQKeLmStD884ELD8VEBI9kBfAqagq/Acr8Y6wpfYLu86XcPSqOqKTJkdqYHzhNElYZiWcaR260ygQTDtet0pba/0GCT3D4+Ffelsl9F24q00j8uwBdSkK+nKx0plV/KGMxPyIqEHqbNRNWxbfUl1a3OJjoGDQarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se; spf=pass smtp.mailfrom=blueri.se; dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b=ZIhBCJET; arc=none smtp.client-ip=209.85.221.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueri.se
Received: by mail-wr1-f100.google.com with SMTP id ffacd0b85a97d-36796aee597so2835039f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=patrick-wildt-de.20230601.gappssmtp.com; s=20230601; t=1721072394; x=1721677194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIJJSZ5zXb6reW5ZOR7y5RdjZLHn9rxRGf86Ywf5dXU=;
        b=ZIhBCJETa230+y1Prs7gn4lNKxLL2dIfVOfAHy6+ST7bTfR57pxrAbGe/BOp9nblE8
         mNXY6mkHAOD0qCNhcvqdTRPHTBL0FYKIikcCThvNSMyMb4cIX5KmWIF40mtgcMPcIuou
         epLMKIG4ibvxF5Y+SfuQZkhYHK1teQ75j6+CTiSQajw85Q1nK1TNOge0eaPvO3S95xkE
         EhfXLdBhz9ritwXCwfj8EtN65IOISkRv4n2DMp5QlBX1RsQ4QtHE+VOuQ2eHpKgzTr+6
         +ku3t0dfrKJy/NwxWWPHefop8jU/dP3KAoujjCLwrLtp85+hvTnCz9ENY7l4DK9wVa7b
         wy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072394; x=1721677194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIJJSZ5zXb6reW5ZOR7y5RdjZLHn9rxRGf86Ywf5dXU=;
        b=YA7MswqBk6vBEpEPIF75iSYLszXywJ/uZi+qeL20sokJyX/4z0bBkwIx+BesFiFqHP
         LfQhnj8Ccs2EEkXjqDNbRMMuPbWp2UIyzZkGIcoZy59alzPDYdD4B5DGpGVUY5K/0VLq
         uZb1Xk7xErsvdr2+CAWO8xyTWeLFxn81XM7IU/ferMW4iOOai91M4nr/402Vr98iflP2
         221wv3nFWEHk1/gC9L2EQAcTC48fKV7wb2qOO9SS1bWzrhFURTY7RS5Ogm3MGlaFpDYk
         VzNuzFsORK8XOkdByC3+NX5ArbrRbMEDPuXFgH9IHyoiqEkjNa1QP9nIl75NIeqR4tMt
         ZFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUxCzBqrdHIvPLZkMEe3VwAoXP6SW09WugsC1w/XRPI7u7i6ods8zlDEbazsey129dkp0H2AqgCKk/wr7ga5SlEjbk1v7kPGzo52pwWbfw=
X-Gm-Message-State: AOJu0Yxx9Wg0XE/VbT6MrVuKW1wRcz0sNY6EgmruIFuO+9DvIsluqKG1
	AB8CttiXne58SwEm4UUWqs9HB50qJmfs7V9As3Bon3dtbDK4zNYQHPerHn0e0qEuawzECq0FA6I
	COp3+lc+8GYlD39A7VatdaYNwhuFvsygR
X-Google-Smtp-Source: AGHT+IGkqNqCiQxG41zDKYbkTdSlXJZZoAudeVBFDGw/b+9Y2AmFQ5YiElW2hfka2NCp5svkdW/CdnXD3jFK
X-Received: by 2002:a05:6000:2c8:b0:367:9988:7300 with SMTP id ffacd0b85a97d-368240be7b5mr521329f8f.45.1721072393982;
        Mon, 15 Jul 2024 12:39:53 -0700 (PDT)
Received: from windev.fritz.box (p5b0ac4d1.dip0.t-ipconnect.de. [91.10.196.209])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3680daaaac4sm156928f8f.19.2024.07.15.12.39.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jul 2024 12:39:53 -0700 (PDT)
X-Relaying-Domain: blueri.se
Date: Mon, 15 Jul 2024 21:39:51 +0200
From: Patrick Wildt <patrick@blueri.se>
To: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Patrick Wildt <patrick@blueri.se>
Subject: [PATCH 1/2] dt-bindings: net: wireless: add ath12k pcie bindings
Message-ID: <ZpV7B9uGVpeTSCzp@windev.fritz.box>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpV6o8JUJWg9lZFE@windev.fritz.box>

Add devicetree bindings for Qualcomm ath12k PCIe devices such as WCN7850
for which the calibration data variant may need to be described.

Signed-off-by: Patrick Wildt <patrick@blueri.se>
---
 .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
new file mode 100644
index 000000000000..8f18868ee726
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 Linaro Limited
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath12k wireless devices (PCIe)
+
+maintainers:
+  - Kalle Valo <kvalo@kernel.org>
+  - Jeff Johnson <jjohnson@kernel.org>
+
+description: |
+  Qualcomm Technologies IEEE 802.11ax PCIe devices
+
+properties:
+  compatible:
+    enum:
+      - pci17cb,1107  # WCN7850
+
+  reg:
+    maxItems: 1
+
+  qcom,ath12k-calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      string to uniquely identify variant of the calibration data for designs
+      with colliding bus and device ids
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            bus-range = <0x01 0xff>;
+
+            wifi@0 {
+                compatible = "pci17cb,1107";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                qcom,ath12k-calibration-variant = "LES790";
+            };
+        };
+    };
-- 
2.45.2


