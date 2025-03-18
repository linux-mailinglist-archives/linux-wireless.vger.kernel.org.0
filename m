Return-Path: <linux-wireless+bounces-20510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF7A67D74
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B50881F63
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F908212B1F;
	Tue, 18 Mar 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxwFl0g5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340A20E6F9;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327809; cv=none; b=YPgA1jrMsTGzk0Zcoe70KeimjFx1PHGt4LO17Jm8TA8do4wQdXA26i42GJSC7EYD02LF6VgbOa07Z2AS5adlNEzxmdfH3ZOCdCxZ+fbCXk1hG4FRKY1mM0Ku1YWYvastJHUdRqp/XbDmX26hj4ij1YMJpL+figF5wJXiwbDzEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327809; c=relaxed/simple;
	bh=D64G++OxdU2DtleL7cRnKQfbgQpbcoG0wweacSalwo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emawV8Wx29CiD5BRC5gC7mYbcFa5xT0RwFrChpuvUGy6FdXtE/BE9MAXhoFCLtf5QWjGl3Kgxag/YnWPnwchprZRgHfpbQnGvHG4yXr25KKFZ19w6T7f2S58CcCM7fI92cNBcWpKvdzBY2bAlAXr7cxWlZEm8a7iR158ysJipfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxwFl0g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 805F6C4AF10;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327808;
	bh=D64G++OxdU2DtleL7cRnKQfbgQpbcoG0wweacSalwo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fxwFl0g59S5c7rs6lYMe5VpzvG8JStxpTI/JIlJg6wkdkQbJ4t0t5C8l+Iw+vELnp
	 q4SIJupmDsua/7ZHUumJzew1yJHg08gH4TQnArt/AtUXeszfghsHuA4oRvd6Bv+n9O
	 qjE4xScdKqDMhk69G8CfsccuwElHvtz3JpIcR9ft/6qlIRJuaZDiLnIl2Qy3p3LXdr
	 lMyj2vLfeidbj0Oe3cXhl+eaYnZ6pin7AibdSDkLUSV4F9+6zBicMqvCcn3i+2lQVI
	 JsH0xzkQi75y+8JBTvObeqrzKxdJooF46bBN5u8Na8en/vS3BW8BcHebiOWXSOWeK0
	 754yp0JXbbyIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73319C35FFA;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 18 Mar 2025 20:56:45 +0100
Subject: [PATCH v3 2/5] dt-bindings: net: Add generic wireless controller
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-dt-bindings-network-class-v3-2-4d8d04ddfb61@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=P3wxtxq+fD4LWVRBZ1MpaWJgE1IIo4CuIxn7yG+ZET0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2c/+2Izef9m3kj/hpAUM3U5cGidvjC+W0Vt2D
 fwwdoXVqJGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9nP/gAKCRBgAj/E00kg
 cgbvD/4xduajTZBRFlLvfYA2TDr5D6etA3CjLCwejbi5IHfaMb+e7iyJFcqgn9kmvgmfmQKFDmh
 6jVcmN3/PnX0B2uaY0Iwy83/MxSp0RZnkmkIhg07Y0H1sHWIkJIjkegw6OUpaOmsSEcRaOjDw/J
 ODUY7ddiwIryzizg3reyHVx7zrr7UQIxhQhLnQ48bchp2ZZXdpsQB+wXaHOxAyJ58B5Q8qbndgA
 V3dIKt8YBYYM/Q2uBi7dtwJqgc0gtiRU22mgFS84m5zzWO7f+P9ZpVUCY0xufD3S69nNRXIpfsK
 KMLvjJgK5Afiyjbp8BeWD46wKgRaSt2AckKoyjRwrlLtfXR7ELY0DLg4YJO5i7lf7vZgv4Zpmhq
 AorV6Z0g85Ac66o979xe0VlWZWfmnYDln14Qxj1CVT44Ms0S57ghFqbCTh8lijbIk9aNcd+6Vbs
 YmCy8YVGvgnofDxTNOCE6WNBj0R8AA4cpdZnlYeA76MNvBc1qyrOVHvsZYZl3LUf0rR93e0FZ/X
 ViVwrr+3CJeFUa2hlCj69Lj5o4Xt1XRoeLQsmUrXSzvrNOnwloMvEr//0RhVQmIE1wLJ9NGFcVj
 TiuIzCXNpL4Ebt2+JYbdDkyBHzX6ph2/9jkcAiGN+shX0UwProNDkv4z3Y9YPVOIrY9/wkQCFfb
 vlJJC/Y2yKS8t7w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Wireless controllers share the common properties.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/net/wireless/wireless-controller.yaml | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml b/Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7379f6c1aa05c15a5bc7b34df6502cc174af9a90
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/wireless-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wireless Controller Common Properties
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+properties:
+  $nodename:
+    pattern: "^wifi(@.*)?$"
+
+allOf:
+  - $ref: ieee80211.yaml#
+  - $ref: /schemas/net/network-class.yaml#
+
+additionalProperties: true
+
+...
+

-- 
2.49.0



