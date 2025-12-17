Return-Path: <linux-wireless+bounces-29853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A02CC9D62
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 00:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980B230358FD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102892D97A6;
	Wed, 17 Dec 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ7PPPAS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835025333F;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015817; cv=none; b=NMMEskfjqhioHBO2cmnUY7Lz1pUkqCwHvfUaq9cbnOL0BSJvOqDp+QS6qzgxJ16DURu4w033hRUfSNhvcf76mC+7tU7DxS4mve7iWNy0ZulL4nmodbsA3Nn/zJHVcXJkYXdDbHpGjgLFljZ/9q3guZ5ZtpyNIsDFljfw1UfCxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015817; c=relaxed/simple;
	bh=97wia3zS1qlYRADNyWZ1Dearx5E9Qhtfzmpsvc4CY1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGgPyvbMlf5rEbmie9BMF/vNlQYTLtKq3X3fBzwvjkXr66wdXRfZECbhYzBbTg7JlnAnjdWqx55C7SfpRqUPs7fc12475hDtis2axhAntEqKR9dQl9CAYs1t6+E6hXoToWaQ650LA33m5cvtk4bY6+CaL/k1UoG4t0iGoEKuY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ7PPPAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7582FC116C6;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015817;
	bh=97wia3zS1qlYRADNyWZ1Dearx5E9Qhtfzmpsvc4CY1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sZ7PPPASDFFO8yLqhmWDxlKm6HjerwDesovkOoIKUtnR5jSrZEx1ZDWXM3nmP5XVA
	 aVSZhEL9zj+dbNmSVz9GpvRBltUqClg4aj/KmBi8yLg4MAVMygmtN1VkyCjNmrLB1z
	 kTZiXNwoEq36yTaaaZxYyC4dvhXYwd8UIrceKny017cHI2KbBJGMRDdOoLCBTEuAug
	 YaNX8zE8CJecCugGsM3GfyI8MS/u4SXhd51eAtju/4xqgUpFORC8TBttpiDKXbdosy
	 jKOm5zCd51p3jkLza5kr8dYnf2rXiaUmbIhWJmBpKodAqMKdIiAC97GLcNKEaCPTg6
	 YGVV+UP7c0xOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63876D68BC6;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 00:56:37 +0100
Subject: [PATCH v3 1/6] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro 11
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-surface-sp11-for-next-v3-1-875afc7bd3b7@gmail.com>
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
In-Reply-To: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
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
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766015816; l=1359;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=qhZGa2NeEFuwnlmtetVVgl3HuNxZv/a5Bxw1IkCiHVY=;
 b=B5FfylNnd9JStM4MWLyxTQ8KbZQ+xR+ncPAvrCe1feg7LFBArZWMSVMQP9uxrP4U+FzK0W+a5
 Mv2GLTwX9smDRgjjVOk7yG9oN6Mxks5iqDQr/vSEKvQCUvGjA1hW8sG
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
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca2010508a8225b9549d8c634efa06531..7c99bc0d3aae3dc6e9c08fef0a535e114a3297a8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1067,6 +1067,14 @@ properties:
           - const: qcom,x1e78100
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - microsoft,denali-lcd
+              - microsoft,denali-oled
+          - const: microsoft,denali
+          - const: qcom,x1p64100
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,vivobook-s15

-- 
2.47.3



