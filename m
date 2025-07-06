Return-Path: <linux-wireless+bounces-24858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B725AFA7FE
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB443B7A31
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA62BE7CB;
	Sun,  6 Jul 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNo9iAVx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F31E8335;
	Sun,  6 Jul 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838083; cv=none; b=Sso4q7M1kdWHsq7S3u3Gg43Z0yNajexu9aabusXdQhpwtCvICw1Vc/VVOTV+FlVNbEwP24vIfCtPmyPLfCGsKLlIwNi5Ahs6XowPyRBf9D4bxQW+OAlcMIxpQGAh7DX1wjjLkKJbJOkh4ATBu+Nq9Pt4ct2z3Yekmm0js+zb4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838083; c=relaxed/simple;
	bh=oso3s84HHIL4dE7V1UAH+9yd50ezAj1vpkwyK51jz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQXu9/stezz9MNqQDLdCZwNpRzFsgcVDwW2I3r4xAUs0IPgp7Xo6QKSYOJs9bdQxONJs42ywlKunzKl3C02P1KYKV8CteunMprqp4uXHey5ArOoZeMkH+vzPldncBrF/4fUcJUYk5Pmvhsy3xNdCBa1M869NJvYgIt/WWqnpmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNo9iAVx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b54cead6cso1488432b3a.1;
        Sun, 06 Jul 2025 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838081; x=1752442881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=eNo9iAVx3h26F51EjW9ES7u7jGyMg0T3E+20kHdefK8iN+/ZswlboQ4IWssKcxEZrb
         QyfuDGViAyLP2UV2EEO2aj31/tx+TkB1m0A/uMz7MFViYKfQx7n39UpcvYWOntbIqZ6G
         mdID9Ypc2phcVW+rriSB7VcJPLkCvaqbDrU/LpS50SvdaMolhPe1M65BnLz52XCERqh7
         PO9byeMEctY5qXRc7riTC4FsUlqVrieqm4egmME8Lhbg/dv7E+FeQ+FGkEbN6ll2ee0u
         nlIQLpidHg5i1Pgh2VUI6R7kPbTmc69G1uVqnR7hmGbs29ZZahKO4RItWbw5VVEpB3t/
         KrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838081; x=1752442881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=HltTuGNYzLSXoIR0z9BtybciNjmzeAkDWO8fqIDXRTVLqUAtSXMOfhdX8AztEfbjZ8
         aEvw4NIUOR2cq8bClCVwwIaArfbjjpyTGzR0A31BssIKwh2E8b3JFViXHI2+pBYAWYFo
         iEdaItaXyubHOFP4IlleVvgZ4ugiYFUyEblzEn01oMefOP95uTOybIiGfvxvjh4KwwAo
         9T+62sfvfUxnxIdj6/8VMeGkASSZWnfJDBbIfN0M5Y7OeKPRzW8l6A7M8E9xAVLJtRv3
         fRGJIGRPmaImehIN7Dl0mm6+6ARAPjTth0THPmx1Aw6VX9TFprAORkTtKRyX0ve9rBYK
         2ckw==
X-Forwarded-Encrypted: i=1; AJvYcCUWmFK6BB1oggFUXs70tQ2FGjEHcv/8wE25o7amL86FymminxZ5fDnojWhsfeRNAJbB97SRdW5ppxrZIR+5@vger.kernel.org, AJvYcCVaQjNRMvEYNTiiiZDP+jg01y4ElaFlEygh2YpySXhVTeo2XchWsNVMUDbIxwhSFvMgmzUamZ0uQamlEQ==@vger.kernel.org, AJvYcCWqxcdZEoaUR/G4p90Mm/7P3WpjxsRgfNrsGCms5GN125YlqaZmNftKbzzC7PunnMs9sS7nPpFyj/K8@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPFEx1NVCzxHnOFCRiIxVBSomll79+A2Y28tqNuTv2cPqJFvp
	Bs8FgqLPVsjlOZD2QURTYTx77GbZm82dqXKjkEpYxNT/JPAeWrHI5bEd8VVmGv3dOFc=
X-Gm-Gg: ASbGnctwO1h7pnREFWg+xMe77pNpX2TkCPR/u813bJtEThug9BtznbWuJyYejdjt6AL
	08Pm2tnK6oVIAWRrp+b5kzxtwZFRvO/tTx2CEAsOuULoQxHSSCrZB4UXUSk5Eg32tWJJ6eOT5IQ
	nH+7/5hw0/WrFYzm4BKU6kaXy11HQod6NeNmFXlE4WVXtgtSPPo8IZGVmZnEb1+SPVU2BjnK1sh
	q9WkFqfyYbf8ikpk8Ab88MB2I0VxXfdl45oLGcrd3HEQml+vkKKbtWyVUoMDMRn8ltkhN3Oxmwb
	bscdOMlOb6unNFjJXWtQoOqUXMOQ6RGu95LoxDWi1iQ=
X-Google-Smtp-Source: AGHT+IEphJnWnMpJ5IZuXkzIdAl/4PySIfNR7SCiDO+NvDhnTpiFTe9sAWW/ka2hDv/gm3VHHolLYQ==
X-Received: by 2002:a05:6a21:3282:b0:21e:7d1b:4401 with SMTP id adf61e73a8af0-225b9484b0bmr16419609637.22.1751838081538;
        Sun, 06 Jul 2025 14:41:21 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	yangshiji66@qq.com,
	ansuelsmth@gmail.com,
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
Subject: [PATCH 6/6] MIPS: dts: ralink: mt7628a: add wifi binding
Date: Sun,  6 Jul 2025 14:41:11 -0700
Message-ID: <20250706214111.45687-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214111.45687-1-rosenp@gmail.com>
References: <20250706214111.45687-1-rosenp@gmail.com>
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


