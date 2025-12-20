Return-Path: <linux-wireless+bounces-30031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD2CD31D5
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89DCE300CD55
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC32E11B8;
	Sat, 20 Dec 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVef5HR6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039322D8DDD;
	Sat, 20 Dec 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244475; cv=none; b=PWlztlpaKtp2RbfAM3K/0Ktrk21QRthACexkxDwYsnBQW/CSU3I/E3U3wt8dCVtf5VohvisNG8IwEIh58Uqb7J/lKy1L8uBrKWU1KepAiQ1/++3pqkHAzl7onQMKHbQNMxS58RZikKdrIusjvGZUcZhDs6Gag6koQiwV/knP8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244475; c=relaxed/simple;
	bh=4lws4A6g2JWpwRYu65XNJCfCAPljUNqFY3i6D5w2kgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i49sGbjULNdPrv7YMt5u5bUe0wXLlNw5+3JJ3f2pd4masKlyPy+qOYnW6rrvRm2jx+2RllweLYmKX3KP7MgWfwGMV3W6/X3Gpll4HesmYbXi55OUY54c2FdO4ul+lowWps6RtWLjtdIlwtt+pfmo4ZMqjCH3kV/3mq5VpSjc6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVef5HR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E193C4CEF5;
	Sat, 20 Dec 2025 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766244474;
	bh=4lws4A6g2JWpwRYu65XNJCfCAPljUNqFY3i6D5w2kgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LVef5HR6S0XIwsFFCZpPatIc+mJFjp1/2cIIEGA8CDXjVfdjxTvKLzc0gFM5n1FG7
	 mTg9iPhOd+S8mRiXyKpt+1Zc5E8nBRHcclLHipZSXJIJ3dq1tjsUf3uZUECwPCx95m
	 2Ep4bgo8wqRKGtuaEB/rXZCnWpEZC5Z1toHRur2mRbZn8SuumZfVDnBoHfWenMHaqZ
	 xNtL/9k3QR+IqV8gbYiKIYKhS8fMnHP1npjEc1laUWlY3sNL5Sl5a2azY0eYTCFHOP
	 MeYx1GvVX3M55seDWzXzYKDEUAI5vMD20QIjA3V5Xv5yu4bhVG7oGbM1mGyM5RIvYg
	 KilaItIThcx6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E052E668B4;
	Sat, 20 Dec 2025 15:27:53 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Sat, 20 Dec 2025 16:26:29 +0100
Subject: [PATCH v6 1/4] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro 11
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-surface-sp11-for-next-v6-1-81f7451edb77@gmail.com>
References: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
In-Reply-To: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766244472; l=1715;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=adcMCekTMwA6DiDUgSju4pCxwPlTO2nkglFu0N6BA/g=;
 b=shgfsOS1fm08+GqW7IKtYrZolTZ4i07CrrUtB2xNo3yWhAFov1Gw3EbrKkEVj3c1RsMfr92tm
 35ZtsFQ81TzBKtNHqltkZkQRZo3Pjb/AQfPDXU4db4aJ5RIndiWZyh/
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Add the compatibles for the Qualcomm-based Microsoft Surface Pro 11,
using its Denali codename.

The LCD models are using the Qualcomm Snapdragon X1 Plus (X1P64100),
the OLED ones are using the Qualcomm Snapdragon X1 Elite (X1E80100).

Due to the difference in how the built-in panel is being handled
between the OLED variant and LCD one, it is required to have two
separate DTBs, so document the compatible string for both variants.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca2010508a8225b9549d8c634efa06531..4e94776b8c4cd915d7779628c005a021d27aab63 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1067,6 +1067,12 @@ properties:
           - const: qcom,x1e78100
           - const: qcom,x1e80100
 
+      - items:
+          - const: microsoft,denali-lcd
+          - const: microsoft,denali
+          - const: qcom,x1p64100
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,vivobook-s15
@@ -1089,6 +1095,11 @@ properties:
           - const: qcom,hamoa-iot-som
           - const: qcom,x1e80100
 
+      - items:
+          - const: microsoft,denali-oled
+          - const: microsoft,denali
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa-lcd

-- 
2.47.3



