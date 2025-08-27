Return-Path: <linux-wireless+bounces-26667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EDB37659
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881295E4D6F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23631212B2F;
	Wed, 27 Aug 2025 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxdeAdor"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9820ADF8;
	Wed, 27 Aug 2025 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256234; cv=none; b=OoOCnGBz1OZo6PZx4zB40biCVw/oAOrvA3ocmGJNXMmhIcrf1Vzq0YlhwJpK8ygWAQqVmuL1+C6ie791NGPqVVVF33OSYoahCZysHPFn9Jslt8dr1ZJ9PH9bmUcp6W1uqdY/YAEtz9Vv9+D3dN0ftNflMQ2WYMNaaOShLZvHtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256234; c=relaxed/simple;
	bh=aSiHJJ9WXzlVv9knT6/I6iHouh299Sae5FDjQsAQAKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaXusKdqbbyQ+PPdnAhhU9+cboaW2SbEFaDU7TxMFXonpH2Dcr4AbO+0gw9VBOU+Tkg4uh7RWRIT7O8+EnQ/h/nUJg4HZt6nWTi7MHLFQccO7h6Wn3ZoLoEiAJzaxci0k+vwsLM2f1kYBFROrc2j0hFK0Tab3N/hhoHzbnwFpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxdeAdor; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771e4378263so2432287b3a.0;
        Tue, 26 Aug 2025 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756256232; x=1756861032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+mQsn5nOVfRc5NpRhiJTO0agCV0nYMAh0ExZWY5vJw=;
        b=TxdeAdorlzs7XLcdGjkIfdbQKOGmOCAUYBapv78lG1ded6ZJUkDwrvIkHJ1X0rw2W0
         XqMC6JwMZw/XqSuc/5rXmYhBolBztYIonshJLMPmMBeAg+D9fTXBeDwuMgltZ1Znf5C4
         lkaGmzbEhbAfQN0J5bpjqXnpjuWDFNAm9AVriTdOfsxfVZaaRVV3h0fJVdUjscIShIUb
         vJKkC763E3aflz34zUNlz7XxSLYX7EdzJgKQi7yEicMirALZACs8or6zW1bOnTu/g5km
         5qad9ucbdu/7t+1z8VNQVwUENeAvS6RM7C7HyOSLrbsD+ZsBt+0SCwsHzClYp3S1Rcik
         2zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256232; x=1756861032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+mQsn5nOVfRc5NpRhiJTO0agCV0nYMAh0ExZWY5vJw=;
        b=t3Im2grPvcb6dk43G8QvYWxpQgwYObDCIXM17JbkKnrEfFyPlKrpB5MsoaqDvIxLOU
         BQG+ZOZGSVB4g9hOF05txy9Mc7+U0637rqM/KolCEhA6UcW54gqdelI2pBM85meLy9BV
         ejnndhnCVg8xriuQZvojn5AIvocikRfYLoFSs7Ik381COYEFA8j0Du3lPBa9gU4nfm8F
         tl1h05mL9IBwiifl7zAvMlqJBxpyNtLWPdn80tmLQbgywWosxL6cBKs0pYSI43Z33DhF
         6iwt/jji5/2CA3xQpDjIlkJjnavxhPIkJae/hac5rJ009R2W7VznzlFdd61HO4TJlfxS
         5XmA==
X-Forwarded-Encrypted: i=1; AJvYcCUyIjIxn4FvTP5AZ+g4ffE2gqCDu4N1tqA2uBW4tCu+P/voOXDuzLyFjTf4ts1z0NRbjhnwDmfF1rmtfA==@vger.kernel.org, AJvYcCWp9/OqCty3NgbN7pygN3MTGCt2N7LiCqTKFMcTOG+9DCvNq5X6psbadiW1Z2qvkdWIp1CIJtbNZ8Yd7yOq@vger.kernel.org, AJvYcCXcbjKeJ+1ueQPWW2GyYsJa7wcMojPGKwwTCdJCt52iJVRaYscl2IwHdQUJ6kJg3ZaElsIsAjLQ09ej@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/WBRmLs9TCjVbL/YhRklnyz4RgX9Pqq3D6gGopA74zoCp2vi
	yS+Ta5JRMz51/rJcqGNKPDSlfSyrehRDBt2+gxBkXsNcUk4k65KAlAEP4OFVBQ==
X-Gm-Gg: ASbGnctORtzEBvpmfKlqm+xDFg6RM3WEEnNAyUN1EFpBNGtxUw6gkUL7wMIp8ThX9UB
	pHQ5ze2EXjOqGOjBAhmR9LTpyb75zvlCQiC6HEtEJ/75VD8Gv3IMvnIsRTdshikX5ac4mHwowf0
	DY9AjurTyMHniXEfS7jhztsgbC2XrlN9zmzY6z6zTcjg9jRk1ZtaE62y4+CEOvyDeMtBmoi946F
	Oc7oPdGti7uaIA+SftpQn9OGgKaFhUgbJ3YR/DfoNNJKKH9c9o7FWbfM5M0/dkWNHbDOF6DObaR
	XZeKmOFb5VmrhyUZxO47RSoha5ML90eoRvsumVOQK/EnXBnKqpK05vevMTs7L0+hIgae9yf0dyn
	hXp1TkqCsDi1H34L/YkVa0ZuQ39PVCIRxjk0TyPQfPlSIF9vlbS0k4BoNIxlhMI37qg==
X-Google-Smtp-Source: AGHT+IH9ISDmR2/0VTrTeaTdohaSBjoHB1/bbyP2/lhVXGYdlZJrIcYDkB7uxf31eltgLCrGZP+UDw==
X-Received: by 2002:a05:6a00:2189:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7702fc8b7d5mr24500402b3a.32.1756256231552;
        Tue, 26 Aug 2025 17:57:11 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77057368ca0sm8382515b3a.58.2025.08.26.17.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 17:57:10 -0700 (PDT)
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
Subject: [PATCHv4 3/3] mips: qca: specify WMAC LED directly
Date: Tue, 26 Aug 2025 17:56:58 -0700
Message-ID: <20250827005658.3464-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827005658.3464-1-rosenp@gmail.com>
References: <20250827005658.3464-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ath9k driver creates an LED unconditionally being driven with
sometimes the wrong pin. Not only that, the current dts definitions have
LEDs for the WMAC that do not behave in response to it. Fix both issues.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts |  9 ++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 11 +++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 11 +++++------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index a7901bb040ce..0e813c38c31c 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -56,11 +56,6 @@ led-2 {
 			label = "tp-link:green:qss";
 			gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
 		};
-
-		led-3 {
-			label = "tp-link:green:wlan";
-			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
-		};
 	};
 };
 
@@ -111,4 +106,8 @@ partition@2 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <9>;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 37a74aabe4b4..19d72a0fdd8d 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -22,12 +22,6 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		led-wlan {
-			label = "dragino2:red:wlan";
-			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
 		led-lan {
 			label = "dragino2:red:lan";
 			gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
@@ -101,4 +95,9 @@ spiflash: w25q128@0 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <0>;
+		led-active-high;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index a7108c803eb3..c12dd4a72772 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -22,12 +22,6 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		led-wlan {
-			label = "tp-link:green:wlan";
-			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
 		led-lan {
 			label = "tp-link:green:lan";
 			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
@@ -117,4 +111,9 @@ spiflash: s25sl032p@0 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <0>;
+		led-active-high;
+	};
 };
-- 
2.50.1


