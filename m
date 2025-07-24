Return-Path: <linux-wireless+bounces-25963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E91B0FE05
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE34169946
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59FA18A6A5;
	Thu, 24 Jul 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgOGH7pr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604A148830;
	Thu, 24 Jul 2025 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315963; cv=none; b=l4aSzKFP7UnpP5e/ovmfnlr7RO4nfxqpbYmH/UpaUsUorafghtqAyHDbaV5CP/oN6ud0EvnP6h2iBIcoGQa6qXiiCgYO4dE/xBZCYxPIeQu+xrjXhFv4sacXR0bhxtySRQOHvY4kQ3+ds8gHRlHBKLfVRxt5XxbN3WayzW0ypIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315963; c=relaxed/simple;
	bh=ijnXUxDDUHN1/XvzafL6d27KQdbRnPZL50EKvcRjRFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o92JeJn02Q1lD+cVnJ4Am5Q7hTNKdPqLb+JRWtgZAbAkDmZYrm2Dhgzqm55lmBIaaRsMtnuTPoeWBKrFSI9fq5gu7s6a/Z+a/r2TK0B4BLwC9L3Gn1QNF4k/KM7riUvO+D8LC3sqlL5wyRS8+oCnheqNz8Cbue5fqUsp0M3aJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgOGH7pr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234b9dfb842so3195455ad.1;
        Wed, 23 Jul 2025 17:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315962; x=1753920762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHvGJwSgUhit7XMftNzp9FtkE863EyD/nfcPU6k268Y=;
        b=bgOGH7prEXRyAvWez7wgtS3MjbuJv3tQeWfjZTzIzCgAtVWKh1E60mAvwIf7JO17DT
         Y8GT+50pU4OGut3PhT29Ki//aKmlY90lFrNV+UWl7Lp8t/dE6aah+1sFtHx9FPdNrVUL
         l0zeKs01Y5kgE3V6RTfcQacU3+ORN3L5seC/9X+0wPiHvlosSK0s+l4WRyrv7hJHp0Hm
         UUsPPfCP3Wd81Lzfb+A8xVfpX7BpiLnDgBvR0OQKA1TNQ641WiUTvfjCaP+vSe88vIoU
         Q/E0QCsowlU14RFeGFxbynE9su8z0izwG5uzMSMcuVHvMXGKJC0iesJ5IdtRrgatJSYz
         HoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315962; x=1753920762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHvGJwSgUhit7XMftNzp9FtkE863EyD/nfcPU6k268Y=;
        b=ATr3LdHTFJClIuvslYembQ/unydYlAJFSytyx6BU+1UiyqiPTql95zGwTzjD9WkCYo
         HINGJxqWG9Iv77kJ5xDUisye7NrVu7rICiKyGDBIV8nA4kb6LGkjD1hgyXytJX4nfbti
         Can2CdQO79hXxb1eKz3OvJF88KhFA7PDo91CVsPRJj7hzLKFgWVrTPD7KSnJgRr2whZ5
         4v8Cp44ivYirAmxWl9714QW/bf6tutnGsH4Z0IYSj4BltGckZkmhX00RcTc3u5PJ5NHQ
         0ZIfUmrySXLIvKmm0PHFdIv8Bpa9rMxpofRiyhCd/pchz3KiVAmFoDD5xc6E+Li6a814
         ovXA==
X-Forwarded-Encrypted: i=1; AJvYcCUE7J2Mycx05MISQaamDUOE/K0ElLK/IIJcI+VMdabomLipDUb13J6GWrnlD1+uwOMzffng/i7n/A5GV4Wn@vger.kernel.org, AJvYcCV2ZsvywnhCyZkzBZ27N8ER7f4dSgPJ0r2bt/ar3eyZBIwHPEyVvieqowj8eMan5AYk0z9xlODBJhrShg==@vger.kernel.org, AJvYcCWI0nCo/4w2czzwSbf+HSIp3FP7I1m5qbKvqTNdBKD8cMlSJJSeTYulAaM8zfY0uGa5WG4AYEgpVkdG@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxsVtcG1w68Uue1p99SntETri1j40zJXclyHPAT8FcWc3A71i
	UVYGGL/oSt1VTCU/OgOC6+HRNonFO/Qb0pKx8rR4m9isywqfpTUO5ozKevhvfpne
X-Gm-Gg: ASbGncv9qhKvT/xwpCiQuFMRfrKdvlbvky9ZEJU9pXTT93Jj21v06gcBkYwVXqgdJ7j
	emfh6WLZPlaisWLcL+8YE3UG35LzZbB5/fPP1ReDu3YQ1qVO4Ulw0SxDSHgxWHcOQw5elcl8JJV
	Pbt+gkIuJDUKysIAsVBeUTjXJ2PJLqLACreh/br4J8mAp6MsG6jz3dHH3mTVXEu80v0ZGouHqe3
	ocIjRrP4Y7Dafd4hQC+rNXaDRdlZMQjwlSgz1PM3/f1yMyVaOvGbqsQfdXyihQowaY431mN045c
	wzGkKHCJ2nJvT4cG9Ek/f1TgKWh5pLEONEzr8PulJnMDTSDkmMXR2qjC/IB8Mznmsc8TVI/p6cD
	D+XU=
X-Google-Smtp-Source: AGHT+IH5W+cWX/6Lw4RE33r/VTyfoRy2lyKOk7XkxeVAx0d8TuGczQAVYWXMV1RCf3gKX2bPRfn/rg==
X-Received: by 2002:a17:903:2b0f:b0:234:ef42:5d65 with SMTP id d9443c01a7336-23f981f3d31mr60238605ad.52.1753315961681;
        Wed, 23 Jul 2025 17:12:41 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:41 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 6/7] MIPS: dts: ralink: mt7620a: add wifi
Date: Wed, 23 Jul 2025 17:12:31 -0700
Message-ID: <20250724001232.2275-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724001232.2275-1-rosenp@gmail.com>
References: <20250724001232.2275-1-rosenp@gmail.com>
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
2.50.1


