Return-Path: <linux-wireless+bounces-25227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33969B00CD4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788D07B77AA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B51327A22;
	Thu, 10 Jul 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdLV095m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08032623B;
	Thu, 10 Jul 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178111; cv=none; b=pqJhBqkkXp6J0bj/FZrNQ9K5hZUhGPUzYK+h9HwunxbRXrL3Vbya/CYxN6SPD6XTqaldmnQhnDPlRHOw3Y84QIeDbaYeF+Vmkf/c0Xm+N6jA/hcDIaX/pX7XpLQnzQbAKCtSuod7hMor2+88Kg/YottFNZec5jcQ+UWZ7FDtai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178111; c=relaxed/simple;
	bh=oso3s84HHIL4dE7V1UAH+9yd50ezAj1vpkwyK51jz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDhzuhVnmvkLxXQlRaCQPFt55JUm/4IExV7dj2Xq3BQn/emMmDv1+MYUclRC/r/Ad/RquXNnLtLxMKSK6fCWIe0JYwMgjbTLaELh/5LSes5esEV4rJh1roq4DaEpsM9S8XCtDbJFAkBGSAnI5M2KRlZvRBV5edObSXKU9t61lTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdLV095m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso896115b3a.0;
        Thu, 10 Jul 2025 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178109; x=1752782909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=fdLV095myCbGYaFvkmP/5msYe1Qu3kWfgfuaxKSKXeR1yq18KBAXlpAUax6qNXDGYF
         v6YDoA/odRsTb27gF5UMFaepTTIJ0UGhknLtb7I9+iy3UdqgKXcyadXiRWdv8P/685uB
         G5oPHHGlnTzBw9jwGGEfzu39n239thz92IXJwZz+WUXLzfZi2hGelc3e95AnInsqb30o
         yeajNdksNMIM/Y8UAUURERkcX+OzvSg/ukN+tlGCQvfnggzcL/Df+w8Yhx+1sOV+BAmq
         85OW7Wkl4JCrCihntHY9axFple6K7U/U6f8CxWBZjXD+QoPcwrspYjozBZA2Mrj61bl/
         5/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178109; x=1752782909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=FBRcDOJplTQn4t4LlTfjzZ3iElFTbR768TzDYrk6pN8aSkl6nd27WtkmXLuLhq1r10
         /fJRvGf5kBRv9pqD9cenwOee+wcKw03en2TxxE33/f4SRuHnEjneMsf58ON5VnvDOGLH
         Xp4v35QzBvbbZCflw7CzM5D6z7okK/SaKouukj+HYImGiVG9i0WC7cTyBiH5nD5nXmDU
         7OCY4Vc8Hjr00OOts2y5TEfXg46vhbsuVmz6SqQgrHF6uO1Nn6k0kqIwKVufjjFDEGAB
         u7blvdWLdlwX9+zxBLeP+3M5cyIh2tkhnihL8ewcHwyTZui+jLD7hFxw2BQKpeaggw2Z
         33Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUpAkCiZmrIKYN3z9hnlgJXrACT2edbLUS6plXJMZEp/rmpFRU/quGGhc3rLdVXc3OkyiGq1W56v9WhMQ==@vger.kernel.org, AJvYcCVMjoZrSwg6DZ0/ZrIm2LlU4r7F7xnuWUF159pHYvEhVhV7+ikHJRh7AA3o82Wj4e1lbXxQ6YJQQdpF4loj@vger.kernel.org, AJvYcCXa7YxuslhBD2MxZI+eziumFxaFvjQkqmCFR9nElUC7lYlcg8E5zPxfnM+7to305xdE4HIOBLXvo4uW@vger.kernel.org
X-Gm-Message-State: AOJu0YzjN/nsOOuBdUCobDOF6OlQTb+yQNmH4zI2whpIrKa3IzoaNYxf
	0iRnTX4VI7oov+GmqslouS0bXc945xNYLDCpLrrHMOBXbsWQEhosXKYd3f274T2B
X-Gm-Gg: ASbGncsoCjh08lC67sLykrQg6O8kmC+a+UXydhB/Vf2E77sk7ia6Wpms9zWhVjKraeE
	fL0IJMY0d1F+8p/70j75vSbcB45EUHNke9cyO8F7a5EO09XNNM8iXC/CWANVO9vh13UCk5dyH/d
	j84nbFfhrAVS26/J1UO/5kdY8Zanp4+sd9IOuoT0D1F5tOp0UDnM2i0mFiorknOZp3PMSFxEsO7
	XJ5ELFbUiyi8B4I2PCNhLELA+y+oYf36s1Sk89cyOHahRnD78GBBwmXWawyu9eBWQhyWIp3yQuj
	FQ+wSRF1hkoRBOR2z9If0X6vAknvXuCp4v3aVmDj09E=
X-Google-Smtp-Source: AGHT+IHm7ifEhU9jh5kLvbxHJG79Iz/C3ci6HP/z09XwjnL/tPrUzMSYxMVlZlntdqoEtQlW6+B3PQ==
X-Received: by 2002:a05:6a00:a0c:b0:732:2923:b70f with SMTP id d2e1a72fcca58-74ee2557a68mr410283b3a.11.1752178109421;
        Thu, 10 Jul 2025 13:08:29 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:29 -0700 (PDT)
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
Subject: [PATCHv3 wireless-next 6/7] MIPS: dts: ralink: mt7620a: add wifi
Date: Thu, 10 Jul 2025 13:08:19 -0700
Message-ID: <20250710200820.262295-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
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


