Return-Path: <linux-wireless+bounces-25000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED8AFD827
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F42E541DF4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE58248F4E;
	Tue,  8 Jul 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOuMNCni"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E1241CA2;
	Tue,  8 Jul 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005878; cv=none; b=Wg48jrrTiFbGXxZyYFNOu8EwhB6MF1wx14sWlsk9kcXJ+N8egS7jOcMigJ2LdzQPzMfJJ917xkivY/JsdvVtngzmZdpGZJelzEPeCpZZ9Idsi6WSxj1GeJq/rZZ2YqgbBC3wmhlD38LGT59+7A4VP95IH1qCypDDH09InOfESfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005878; c=relaxed/simple;
	bh=oso3s84HHIL4dE7V1UAH+9yd50ezAj1vpkwyK51jz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo8XUF2sRIlITfc/hv5EiFe7hWzQO3x5yVhuAPxPSLTJK0quNyQz4sxMr7czLgznNW9l2kk1ubBPufVz/Of/d0jOOQm4Atd96KtPGXoBn2m0E8p61/J04IpVphrVrXExw6Vh6qEILH0ZvNjz1ikFgz1Oc8yEDpTeOkmUnzOOCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOuMNCni; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so264671b3a.0;
        Tue, 08 Jul 2025 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005875; x=1752610675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=cOuMNCniHhGypleWW9Z35nhiTrnMtFakXYe7gSyHh71+qq4UvQZX6BE+P1JNwI8BNY
         D0ASvZ+PgPdby09uKlnadzDWl0snSjobAC2Ewsteq3ZSA74xAYMrJUUI+mOYPguXeXsu
         vaegBOqcZPoxhwHCUPmF+rg8SFqaOIuvDZ4ITWUKvlobXa2MIu9dSDiTc+xTmofqbJqI
         Z0CTy6V9R3Lv9NLOEGQwqfpkiZet19hyhhsKl/FpgNsVLRVSyEqolignvShFCs6u7PHt
         mJ6mqa4YsSY+dd7pdKy6wQ6KtoMNHFm6mgGmhbPq+mpWzqxitN1/XtkTrxMzf8zo0xQy
         ITtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005875; x=1752610675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvZgwDhd8R+31/oVgTrgK7V+PUBtSsqxq+ciLntuUVw=;
        b=eBxFgnCJcyniyvAbYvpjpziWlLFIf5DqC3Mv6ppBWk+X9ROYxQpXMtrqab5//EdRIe
         xXOt0YBaZ4z56LCkxeqxrUg8qzxyKfF27mJ0MSccQHXdbvb2LjOjtljmkgPmkd/yJ0/J
         sxA5d2e33rmoDyoAGLInBE3GjDT84kyzNdp2jTmN4opW9kfzw95VavZfTbK9ePxBhLMS
         loJFKbBckBCaIoE0XgL9Ppgz+jRRTaf62+ZLtegmTH5KSBtjlR4zTYOfmybTq4ccWeOG
         nOEvb5W+p6vTGcEFijteAE6Ah3C+iFi3gMwG8D68UxLu4+/Ce3hbGlrKfjjjVLJqaT/K
         pBRw==
X-Forwarded-Encrypted: i=1; AJvYcCVqLs1Q2DU+nLnhT00SuUYB6Vwz6MnRiiUAoXigWm1vP/3cF/q0339tlvIzOryq/1+cmdcj78CnrXDF423Q@vger.kernel.org, AJvYcCWJUUPRn+h0DE7mqTPB50ONVHF6qhb1Mg3DzZeKxj39qgj+gLKFeJLO2dxa4bNNdE+1HFlMgAPDvOPc9Q==@vger.kernel.org, AJvYcCWpeQK/2N6X+K37wmaFzwf8RiagpA8YUoaaUyAP+QQ8EO6NgBtfOaZs4iGeHmgRL0vZJ9Ba2zhkgtKm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bVPKI9Z7LFo+ps4z1WuC7Uk1smvCRBxHmqtWhISDHN7Fo8fD
	dISC4ZZ8pZ3hbOdUkoTWaBfSnyHxVgo23kbR2XNW9zh4yygPajmxTh8S2UtJp2qEAcw=
X-Gm-Gg: ASbGncu4G3yHHWJIZqx78cGt+xj3223pIpGTId/n6Ri7NXD7QI4L4hVS5MuCVOkyNXr
	OdeOBVIY+GFdnhaV16qKb9YnNZ8pBgUElv/yWynKmOvZ0ioPAa0hvSVXQW9zuijrHlcfvF/TMRY
	wnlke49oBeJagwBy+BgJlXCvXcA+cRoQNIUKH2Oh6Lz8fjT6AYdLcac7O1I3xXO4OEFMyp7tPAd
	mhJGOC1X5yixDcL5PhWqXI0tKDnDZBLOlRoeTrERS0NFRKfn4Lq/jG1+J1rnvtv8araHtO2Ce32
	Ta53bkr7AAHZDTxqjeyT6I8/9lfJar2mxxy0GKv9zRo=
X-Google-Smtp-Source: AGHT+IGomUnEwvNFZ9RVViKBVPxUvwGewuMOyD18+D3MRX0eoPM54PqDSPSGW318yDq1AOglDIUS/g==
X-Received: by 2002:a05:6a20:c79a:b0:218:17a2:4421 with SMTP id adf61e73a8af0-22b60db4dc6mr5833909637.10.1752005875381;
        Tue, 08 Jul 2025 13:17:55 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:55 -0700 (PDT)
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
Subject: [PATCHv2 wireless-next 6/7] MIPS: dts: ralink: mt7620a: add wifi
Date: Tue,  8 Jul 2025 13:17:44 -0700
Message-ID: <20250708201745.5900-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708201745.5900-1-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
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


