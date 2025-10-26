Return-Path: <linux-wireless+bounces-28283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C34C0B029
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 19:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A755189F39A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074822EDD62;
	Sun, 26 Oct 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="Alvj1afz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B22E92DA;
	Sun, 26 Oct 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761503281; cv=none; b=pNFQT3B/K74CWib0yd3xwiC1osBrfYR3J4HSvWPLe+ls7JizXpGLm+jI3PZvY2yLwptzqZ3RwoppzRCYmdIjefpO0DAxnWTp3RflaYLVqbmZxJ32QCsFEtxYkasPtG2pvl82d4Zmh4nf/+UqGCtlT1JOs8j5MLWSQngU75CiT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761503281; c=relaxed/simple;
	bh=0HhYOYWxfjpg+9Kq7lCk7i1xML9Xo3LVDTHR8xeZOSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4FLMvrXMNcEQi9+nuTQRMbouIzMwu4YZJOed5edh/TwQblvxbGUL1qiIR/2s4S8ZNwDLjqayYkKc5fEoS9jjY3KY87njE3o2MXh5wPqAQWS1qd/L8/zqAtYTO1E7cQkc8GXezKNNOzghYE67hsyJWjIH8iRX/q3xx375MXwILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=Alvj1afz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1761503228; x=1762803228;
	bh=thIl0eoythKb01PWr+ANwhU9Ff6R4yl+rTHFbaUTblI=; h=From;
	b=Alvj1afza8dYCwi0s/dGQRKNnatbHJflZbyYAYLJg0iaHsYdPTg3Ak3CnTSa4Mj0T
	 H7D49mQ8BjVd6krsOK2qcgoUc+ziHnYRt+izW8yW5fOTXibom0SCSpm5T8R+lez2wG
	 IH+5VJA0oCzOJikDRjHyosg72fInAPlXBsxFcGOlsemuBl4w+5/qAhGjowantpx9Nt
	 4bbE3S4MQwnMaQBd1z/FRxlpSFbfr+lyJyfPOiogPMx5p/QPF4w4FsIpWTMybkc9+1
	 mgO4TnvKR32d8Bbl9mpwf9iyFCHyr9+hCHs9VY70agWF1DWPTFUBAutZ6YDA5NVFF5
	 Y4GCS7skZiphQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 59QIR6Wb043073
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 26 Oct 2025 19:27:08 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>, Jeff Chen <jeff.chen_1@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [DONOTAPPLY RFC PATCH v2 4/4] arm64: dts: samsung,coreprimevelte: add wifi node
Date: Sun, 26 Oct 2025 19:20:41 +0100
Message-ID: <20251026182602.26464-5-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026182602.26464-1-balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a node for the phone's WiFi serviced by the Marvell SD8777 chip a
communication with which happens over the SDIO. Also enable a regulator
without which it is not possible to connect to networks although they
are discovered properly.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../mmp/pxa1908-samsung-coreprimevelte.dts        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index b2ce5edd9c6a..36d6ae4e902e 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -475,6 +475,14 @@ ldo14: ldo14 {
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
 			};
+
+			/*
+			 * Needs to be enabled in order for the WiFi to be able
+			 * to connect to networks.
+			 */
+			ldo15 {
+				regulator-always-on;
+			};
 		};
 	};
 };
@@ -523,6 +531,13 @@ &sdh1 {
 	pinctrl-1 = <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
 	bus-width = <4>;
 	non-removable;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi@1 {
+		compatible = "marvell,sd8777";
+		reg = <1>;
+	};
 };
 
 &pwm3 {
-- 
2.51.1


