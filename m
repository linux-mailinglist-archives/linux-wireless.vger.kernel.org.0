Return-Path: <linux-wireless+bounces-26343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592EB238A1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA73C3A6CC3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F52EBBA7;
	Tue, 12 Aug 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+cQE4Hc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F342FFDEF;
	Tue, 12 Aug 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026638; cv=none; b=YDoPP2jTcy9hBBRPns0o2GKs99TrBSGwQzc3TOSGLyIPaG+R0pcaXYXe+T70PcgAfTlP2EYzht9AGR6zsz674IcGOEBEC9I4GKyhgb3is/tzyspx/pAp0bTgB56A5MtdgaB2oSpt2M6Ok9wlq0EmdwSUCUnJwwEOS54KzLdDbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026638; c=relaxed/simple;
	bh=JU3dr+Crf9Xb9K7UG3kzrtxsMTafuGut+zNbA4vOTaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+P57sV4EhdKrfoDSD87+wWrbjdeXbDg6RcT3LfMzP4oQrNPR0w+R7xsHM+yfGOfVUFbRgzGWeytzdQV6cPOhd0mGyOz8y2nZL629/2lltR5rdmTx3vBHo+3jlA4O1KJPYFK88hJEAN9tryOFgSLGCVwANjpRRjiE+JA8LsrDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+cQE4Hc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b06d162789so67940231cf.2;
        Tue, 12 Aug 2025 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755026636; x=1755631436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAMPXkeC97be5vrkWMOP6D7jQs9OWhWX6Txvw9DQCp0=;
        b=c+cQE4HcZpS4O6Mk3zc0DIf4QUD90xmE2jIgSgKL0g6Qedcdt9J/sPXaA9heiH3TIl
         gEdiclqB4ohQmXrMxcSvOJSfoX1OM43Wz8XA2yRKGSJTcLLXc7qDVoJMXtto1yzpL/e1
         TisdCITkkzfMoqHS0fesljyCg1NTTO5FfyFiWZuptkvlaCbsMNDSEpllFPziNwd4yuUA
         0ZFwIugz5VWlTltunLSR2QHfGpURu6jdUfWB/IycYbxHrqCBYfGzUUn85e10qxjL5AFc
         jHZNyz3YuZDKl3oHNzy5xRG9ufkD4kV4BGEWC2lzsFh5wy/47ubqYd7utpKnqQg+Q8on
         Rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026636; x=1755631436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAMPXkeC97be5vrkWMOP6D7jQs9OWhWX6Txvw9DQCp0=;
        b=dlWRg8M+tx89rK+NjVPLh1ZIZk7ar29wevqWfLC1Zh8psNO/EGVHHjVEGGiV11NHaR
         FaWt9P+Rzsds8KHHhl6s10S3WmttKODOaODPv5B22sJCNJed0TZdyH55ZVfe3L2wlyr0
         XNBOQPsIuib4jvWbmlp6Y+TKEUyHLFNgqRcFSH5xAveB2rt8jaVCuRrk5bAr05NPVUQy
         rq1OwXjxH43EO/xiSatC+N5bRXP1Yw7aBCaof1o/Hx3EMO4Ewfx9SNKZKGcXXJaIx67V
         hTeWYKgwlRqevM4hcNIcgDcngrQEoBJ/LUkgq0lYtIxxwUG0HjdCkN823Ff6NSi/63lG
         HtEA==
X-Forwarded-Encrypted: i=1; AJvYcCU8TArwcAL1SulfUbD2h96YXj4BHiLBakblc+FukgjkrZNp420GEyCtddfajD1Pg/q1kdUYvvAAEFBTfQ==@vger.kernel.org, AJvYcCVrivJcV3v1oeoANlkcDKCpCgnm+/2+P96MaRVQwcbD2PoxuNdZIydenNOzyL2ZEqyyhMcXx1wVw14F7x0P@vger.kernel.org, AJvYcCXuvbFlUzMCWIxY8yIT6OanCm4pvYhITbFX0Vy27DtBn0XBJ6T9fQJL79sBGY71aHgs6/PI4yg6L+3g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+nk8EfMJFcDisLO2+xPISnXPNjZ9B2huWJ0WN+F1aHYc04zKR
	ppW8sz6WpjFbFc8SFgzSggWNmcMOGuRw57Ze7VZpsSx2YjZF+bbq1StNCZXzYA==
X-Gm-Gg: ASbGncuyYQpxsqBlOx9ru81Yq28J6mOkfZDKHas4hHmYLj0UO5eOtAkHRmWWMF/1jY1
	3NEGPs/Jxyws0cO/RUkDZc1c9nXRNgMVD6p7vFgQ8dsRIOdJ4mQp14Gn881EM1vp/ILwdNz0qwu
	Hh8zzxtFnOdnfxm1v1x2srK5VrjIPHYePZVYoDHknS4d3oJpDCanVDvYmyywKICSlIHdBPZ9T14
	b4AV+6TvOBA8h6DONw5+bL2m4SfjZ2YdeYsnlo9OquoTEw39rnLELXpBWK+bBAef7GfKeH/CBks
	km3HDvVA65SMg2EPm5almPKaCEne3snYLmIhSaQ1E/kIhK/pk/yCCacC6vLv+9nS7rnbKTCTUrI
	JJnE=
X-Google-Smtp-Source: AGHT+IEONCf7cWEXdiNlOm7qpzqCXEN0am4gWgDXvIBizpWxDhCHrQn63WlDGoi1E/X4jo9p75CUwQ==
X-Received: by 2002:ac8:6f15:0:b0:4ab:80e0:955f with SMTP id d75a77b69052e-4b0fc7d2796mr2792511cf.34.1755026635733;
        Tue, 12 Aug 2025 12:23:55 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097e906c3csm101471076d6.65.2025.08.12.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:23:55 -0700 (PDT)
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
Subject: [PATCHv2 3/3] mips: qca: use led-sources for WMAC LED
Date: Tue, 12 Aug 2025 12:23:34 -0700
Message-ID: <20250812192334.11651-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812192334.11651-1-rosenp@gmail.com>
References: <20250812192334.11651-1-rosenp@gmail.com>
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
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 10 +++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 10 ++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 10 ++++------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index a7901bb040ce..344e1a2ee6ea 100644
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
 
@@ -111,4 +106,9 @@ partition@2 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <9>;
+		led-active-low;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 37a74aabe4b4..573ca7752698 100644
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
@@ -101,4 +95,8 @@ spiflash: w25q128@0 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <0>;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index a7108c803eb3..6891d9589b68 100644
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
@@ -117,4 +111,8 @@ spiflash: s25sl032p@0 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <0>;
+	};
 };
-- 
2.50.1


