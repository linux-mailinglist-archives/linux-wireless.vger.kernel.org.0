Return-Path: <linux-wireless+bounces-25882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C6B0E583
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8AA60D66
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7E28B510;
	Tue, 22 Jul 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/mWs/Qe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93F28AAE0;
	Tue, 22 Jul 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219749; cv=none; b=t+xbBdKdGUI1oLraa5IKi7pXXbwwq6ZHUd7JVaOLUaTj8w9qyOuK7JcGVjXCKT4ADwRDIx1GAVKwAJ9TFbJPJJlmfCJHJ+wyBGEiJCN7XcOkPkpT908LEPLYQQHbiR11+IA9aSWPxS3iIlCBbQR0F5e8Gmq8tNzJLXSyGguRwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219749; c=relaxed/simple;
	bh=l76BpW5KpgFESq7uzOpMqV/PGl+mJGSIO1se2d//vCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peQbw0uAsgeRktV/XxgeTKkGk60SFkyra2fBtJiFCsU1TJfKotAQ0BF6OijgB+FhGf6UxFYFxu5g79trqrK8DP08BMmT/bsc8sDt5kvNMw9ty812P4p1As6nJ359wVOlk7uyAEs8JLf144EVjxdOj63Jw/kNaUynumBCnAeCXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/mWs/Qe; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so5969524a12.0;
        Tue, 22 Jul 2025 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219747; x=1753824547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3M3L8HiZ7559N6K6thnkBLv9YHllIdFzaUOaUD8drU=;
        b=D/mWs/QeeZb3sjDH7zqiWsFVyyKOT85sbproOTriTF2A26lYvJu4PPV7cndqegIc9u
         +kAy1R7LIJ8J6e7/7pM6GgE9S0+kTnNEucM8OZnNO2U2vsu26wQghA4DHShVwh/WQxxl
         4ujdrukd8wVE0QI9HC6vc8k5wCofyN//AaAdKxXUgeYELsZGkflHT0uA/iZFANzQcMug
         gCgrNTgTsT1LT620qaLq6G51GXVkZqoGHA0CP3eHwBdfAeruCMFhUYvtcau4S5f3oecR
         jqAjYiv/RT8OcZ9WBZLS7UAQq0IAF9kdvnIatubK7XzznQHQFCKX/7A5HbznYSvmK6Uk
         Y4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219747; x=1753824547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3M3L8HiZ7559N6K6thnkBLv9YHllIdFzaUOaUD8drU=;
        b=P/f8ZFhFmwFqYomVznm26zV4v8gijUoAL1s+JkDXtLBd+MnWNFk3iMULeKSjN5QT32
         RQWhvNRfs2onbgGLqrASA2Y1wM6uMx/ibrLVoT/ootf0pXJMVqT3Mxw6gvhp6aGgDwKk
         7yWvplp24md/r4vM6Qh1SUT10zl2bijDvJ6dgcPrGn6fTwy0nTsgbRL3F1kT8fkt3XwB
         s0gJ62RAvQYt9YXGi2Aw7Imx3s8OtmAWWOOrbKztnm0zSSI8Y0jRVsH8zah9hQJaXOn9
         vci37NNOjzjByj7wKjovqGnwNEBlS7e23Huo6SgJvDkTbjR3j+TDdL62yM4k+pc0yAmC
         ny+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5NAkW2mshHYUVREvX6O833iKJTF4Nb0k9sx4QW/itOfGpScl6mcmp1lanHI9mE6dZOSbf1uIsk+Ez@vger.kernel.org, AJvYcCVZPjMUwdhuRJAzIktzFPRlSQVg3wQZOBLAp4UcdRGP2jlgGqihzg4X40usXzDLaEcOBLtMq/Kbva+5KA==@vger.kernel.org, AJvYcCWf9FMqbvtSWtXQ4oZCEdPnmWT9TzxhMOD7D16l71WpheflOF05rWtIRYq5xTD8k/zRIBHTNFk/YWXuMYIw@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYOezDo360JeA8/4JZ7ctAOoh5jQ1/DvfPUhJnMW8Z3pO8qYx
	loiFIujJw1dIc8L9VQLLNY1HQmhXkEseHOoTTM20hw2hD4TY4fiePtZkxi/8o17r
X-Gm-Gg: ASbGncsm2XxmUbeSaMyqWtyT5PVrgTU09SS8jaNZBJr2hNTD9ZcPdLHFZXI56x/7IVq
	vaTTYDPLv6RAzdkj+t2zKhXJ8pvCohnwpjCVwB7cAEelfgbR4HkU8+HAhXwT/oTHzS2o+odRREP
	WBJN3FWW5Ad52ZRrCkH2m3irhfCfGwTpmP8tatObumi67jygmXOEdeLZyHYwzP/lpEqx1/WaWbL
	eiZw49LaHHkz6yggoLaRQLxVtwwIimguVGwNuevFmpBTqEY2k6t05tY1ziwSZQmCjW6XpqVH/EV
	BVm4D3a6oANQ8qzeN97o7QO80itav5HUBumiKtEFZgaX/CmFRRJGwbgx7kx9DKzriq7AQkLj0PP
	t6b0=
X-Google-Smtp-Source: AGHT+IGL5mabbxfP9KzqcErUAbDJ1RsEkxJMqcMu68mReCYzySiR8ftWeMGB8GD4+qYKxlQxQFBUfA==
X-Received: by 2002:a17:90b:3e89:b0:31c:c085:fde6 with SMTP id 98e67ed59e1d1-31e5060696bmr1332850a91.0.1753219747234;
        Tue, 22 Jul 2025 14:29:07 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:29:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv5 wireless-next 6/7] MIPS: dts: ralink: mt7620a: add wifi
Date: Tue, 22 Jul 2025 14:28:55 -0700
Message-ID: <20250722212856.11343-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722212856.11343-1-rosenp@gmail.com>
References: <20250722212856.11343-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT7620A devices all contain a wifi device as part of the SOC. Add it
here to get it working.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7620a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
index d66045948a83..460164bdd430 100644
--- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
@@ -62,4 +62,14 @@ uartlite@c00 {
 			reg-shift = <2>;
 		};
 	};
+
+	wmac: wifi@10180000 {
+		compatible = "ralink,rt2880-wifi";
+		reg = <0x10180000 0x40000>;
+
+		clocks = <&sysc 16>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+	};
 };
-- 
2.50.0


