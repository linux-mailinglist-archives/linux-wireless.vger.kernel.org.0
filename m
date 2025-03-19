Return-Path: <linux-wireless+bounces-20532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2FFA68602
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51633AB231
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C3A2512C8;
	Wed, 19 Mar 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv9/trWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CE250BE8;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370179; cv=none; b=Z9vcA120djxXKNDSwIEtHLdbwdklnpFJNFRSPO7beuL7TZM1FYnRboeM6wdE8wq/9cOxe4+6rviagjXY3xv1t0KnuUuIFpJVEjV73KIKQUyzLAPDqTeZMucYlHPaaZiw1/SEpz7t9CqTV46arCfenluPcsRwFvZtonn6Ewzlw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370179; c=relaxed/simple;
	bh=WsQ0u5tUFXCTjiL5eblOj9asrKR1vH8dhgSLDWTqT24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oW60KxV6YuCWxD8LRf2XPjRrg0LwFAH8axuX2HY6nzUbqxWNB/uAgthTCKDR8Lt6kqj6WkqKaXtQ0gUpQbSCvU8jWBR6gQWS34z/pUaGNKbKU2IwO7Qq25wQkBku0IVGqLpJLyz3/ts3lpsjV46I3UKoQZ14gnzBIQr5+2vtDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv9/trWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63055C4CEFC;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370178;
	bh=WsQ0u5tUFXCTjiL5eblOj9asrKR1vH8dhgSLDWTqT24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bv9/trWWiqz3CrIUHj91hAZkDVipJTOLrHKJ7y9XyYh34fxnkDa4kxqs3d+VL/C0d
	 /S9YI+qqcm0f79OjaF9WNaFFyd5y8fS4x+/1wDldlUNEC0zOEjvZot5Zqa/Ftac/sZ
	 u/Vz9A1nCH9ku88ZAW7zNJyx85I6o/Hlxo5/HnnJ4NcCkpn6r+dQc6SQi/KNeaz+rR
	 ybHGD+T2ihKhXj1Hiqf10vFftlQNMrCKiOa6QWw56BqVFwyiotXjk5EVHHjuON1JBN
	 xWzEivgCPlJJVM+xigdIPNjVzHBlKGm1fr7LPUCWAGZ1xX/VU45tT8QTOeoIRV+TSv
	 /yN5YhSJpV/zQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA06C35FFA;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 08:42:48 +0100
Subject: [PATCH v4 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-dt-bindings-network-class-v4-3-2329336802b4@ixit.cz>
References: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
In-Reply-To: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
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
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
 Mailing List <devicetree-spec@vger.kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Ykanx8wzDbyUa/ls65ZFTHRGPUtwaqJKAXv1MSG0rDU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2nV/qIBBtD+92YGrTaZ6GD9reQMC2Inj3zs73
 N+8JLdqnNCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9p1fwAKCRBgAj/E00kg
 ct3SD/4jAIh8CmZO81HMcbQ37zZZgxfpTo6ov/fnVOOHd8MeKz5r5T8PvXv/fu60t0ou3WTXroy
 lt2hSsnu13cX0uvqfKCaTffSJUGlE5kog1XKkcePDd9bdse3Eh07yNdaVAQSK9McZuvWi8Cw/gW
 7RM5rccSuFGlCwxZrNj26vAKtfDRjMjMrSOqoiibo2wuFJyu8gtzLm4f1H969QIFnR43TTsKRzo
 wkops2UoeJR+DPBK+4fT5lwxRLtTVtLS1p8nTLFyN0gHdhNcKtZjPoX/tKiG+hD7dl8ErnxvyaI
 l7uoKnO9Sqe6wDGAd6wTk3xMSMbl97JvPhx2a0Ox89vjDWvOCnwCZv4QEkyDCPueBd8oXt7mEtE
 Lq6P7om+cW++205M2Oij7pwsPTWoUJLQuikRBoR4tlaN3WgV/s236zfu2BS0FS3I3ps2UDRjGSg
 4b6ItRoim5Kaln5vH1V2aFB7QNx9lSD9f25oFdudmktgcnaRmtw6GArJXiMEWAsCspNyIjJRix0
 s3oGIiA+sKJ3+7UbvYgGCxk7re0aIavOrDBsZeY90mCrBAi8Zy2rgXnisMYPLMQ86OhLms1G7TE
 5wmTvgiNnKruWcP7MkCZFzc97zoMVq/Xf6g1Hx/UibkIQUkDmrd/twYyA0BsrfSDmjaAp1HhWhE
 k96mQxvVC9Q+neA==
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



