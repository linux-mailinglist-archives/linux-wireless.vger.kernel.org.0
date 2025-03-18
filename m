Return-Path: <linux-wireless+bounces-20511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1AA67D78
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508F1882048
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B1212F8F;
	Tue, 18 Mar 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfwrWsRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346E210F5A;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327809; cv=none; b=Bbfq1Y16Zo3neSrc3YqbIyE0oG2tIED3M5BpLPejBT1x4Ivx7xbOh2lkPnvFmNJA6zQH8dfRhZWMj3vE1O/vUt2itDjaRPATHaBXvEkVqTbBjOvDVqXyFrsgf0VQ/xesdtLAexXihL6xc07QgKJX1KzYURY699x0STFftr4IBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327809; c=relaxed/simple;
	bh=W2KVWNPN3q1oCOVjls1zYysH5RMEzPFQGAawQFKsj54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLRRn12iVcitmR6Jl4qNw3CxM940zX90hbRpkqXSmC5d9EIRS9bAtpeGYR9Ces2HRyCyxKzV9e2VMtaqHRztXv38RXuhcKixRWkn//qAMVi/D/jMrShIS6Tuu44qyxhSbZHPKbC/Y6VDhy286PBVWwL5PCcywACaEmyKSJEJug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfwrWsRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97237C4CEF0;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327808;
	bh=W2KVWNPN3q1oCOVjls1zYysH5RMEzPFQGAawQFKsj54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lfwrWsRXpZ9nG4pwbXwDJbVV1H/6SUjBAFpSE8xSgNITA2FihQU3gUvUwrkVqLZ/K
	 30Iz0M1jnAbxi3k75HVk/239syDOtUrJrQYPqKaXPzGY2Tz0n3OeY6vfnvQ027cpyW
	 iwWDdBcE2771gEccZ1uXFcN5BVC+KDOqhkH2YdvgQrOlpOLv63saGUZ1kVS2hRtrjV
	 WoUMk9WKARD1movpZyZi8yVps+trgR/QQYZ62C+jGNlDtzU4PMX2gjnwB3yGiVNA7D
	 Ha1c/Jeps8Yr3Ezuni6vSazp3V4RDEHf2yuTSKSGWMQMtruWskQRBz6xICAx9OBg2X
	 5n25ux9uTZVgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B61C282EC;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 18 Mar 2025 20:56:46 +0100
Subject: [PATCH v3 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-dt-bindings-network-class-v3-3-4d8d04ddfb61@ixit.cz>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
In-Reply-To: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=F26gMFvM4q7wCneWHdYAidCttNYCdnepTJdhqq9kBJw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2c/+OJVW2gz+HIjuFQflSTYGI/7N6UB8moiin
 ztWD5x6yGCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9nP/gAKCRBgAj/E00kg
 cgFHD/0dU/17AixTsOgnPu4cKlfCEEd0CcnNB1Mg9Dle+Jsju0Fn6pATDufALx/RqVto5IR5apa
 yJlkm6EcEOXq6SwfySNCHAIypSfgoZp/Y5fMuaHLdq69tD96PXvPfbCRtd1gPGr1Bq51yvSngcV
 9NmwDF4gewdP+XFavYO5EhkfnpK6ejlQtVbiVXb2hRR1+nunPgCxwYQl+XlIYeE+yplOF5ko2ty
 EEq+DuxxiqIZ6qcOzmSQjjYXtbKjw1bAqXb0ZZK9iV9BuJ5REGQACGppWwuJ/l30DexB3dCUuN6
 Uv2E0zElwxNfHZQKxSzrNrIm0hzVRm0q8x7/0lQMugp2UnSdxqhVFcDxluyf0NzUeVqlY7z5Ayq
 Fzz63WAk1F9V7rzhG3XA1+d+PN+HH8l3xLnEcKpg6mMK3AKxedZ6uihtqVfM14NbY0Q91gL1xUc
 f551PAqOX1AJp42ADBauvsnjAN1GWoEApk0NG1ll6vqBL9AUA0PPJiDHe69jYVVOMYS9Yg1FNij
 aPdCX1iLsnEGt5YVGo2FrbC0L5ZxEmNeMod7m3uGZxsZFJGyFL6dHl0nlamFrp2bt+uYrNGYzPh
 Sl0O+pfTJVmP5NdC0N0ylZsbju7vVSxIy3Dtox5X7HSqnVIbfMispYBHP/shsBF2U391Xtbk7cB
 Zx6JPLVs4Ikwyvg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Janne Grunau <j@jannau.net>

The wireless-controller schema specifies local-mac-address as
used in the bcm4329-fmac device nodes of Apple silicon devices
(arch/arm64/boot/dts/apple).

Fixes `make dtbs_check` for those devices.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index a3607d55ef3671514cdf2c884cf5bd0ccaadb162..7c8100e59a6cd045837a2f602e367f3f79ced5ba 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -16,7 +16,7 @@ description:
   binding.
 
 allOf:
-  - $ref: ieee80211.yaml#
+  - $ref: /schemas/net/wireless/wireless-controller.yaml#
 
 properties:
   compatible:

-- 
2.49.0



