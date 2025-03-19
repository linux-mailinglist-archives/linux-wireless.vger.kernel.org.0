Return-Path: <linux-wireless+bounces-20531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D28A685FD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78934188D338
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA9250C04;
	Wed, 19 Mar 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiKoPFKD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB72505C9;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370178; cv=none; b=S5Kv0/gWfXoRcUXoEdefNXcvYHp0bt4cJrd13n+zX+DAWaNn4Zs0oVZ608vqaFZty2kQPKVxNUkbj7i6D+m/Z2mvomgQ7px1p3jfcS1eBET10KF0XkZqwohRZSb5e2i9Xx4SUWEi4NlWUPNDU8w1e+HSpKib698F4kkaoD0Pa5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370178; c=relaxed/simple;
	bh=8PFrtxpnJpLFkdaeNeF+Kojf2rI5Gt9WPBc0gGLSfzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAk0k3BApY4EfLZeBoTAmpXx8NxmsMk3kgW1fNUO28FXcz8d98BIbLAgJlTMe6W5FfcEfKUE7yKzuJ8IVTfv+vSSoLIePek0b7gcON/eHqex8mhzEBd9ezu6easNs2uzaPPCnRkexd889hkQzX0rBy8gx/nuSm9BbFkPB67ho7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiKoPFKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D52CC4CEF3;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370178;
	bh=8PFrtxpnJpLFkdaeNeF+Kojf2rI5Gt9WPBc0gGLSfzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iiKoPFKDTc33xyKDhIHbKi5oNeIAReF9v27f2A/TwDGMlqH55f0okfelLEKFi7Ryr
	 ALAk1Ojri4s0xRIXxikE0jXhdh0r3vhuV6FUm/3L54FA7CXkj50YCaYp/1wQkbjqmS
	 xT4A+HSqiBsRyFlwnbF2GhJ/D94no0z9n7ptwYdmjS0K6g0MnYqXOMcgWtKlyNpmMC
	 57/wCXho8RgNkZfA4WFzJfDnL0K8jR90UE4umDeBLKBpeSUP38E5J+0bfMOo60YaCF
	 i1FBATmQOHwqazh8fxnnuLFzGghq3pLqH4V2ArXAW/D9azzzPN7g3I7OXbRXaIres5
	 Utmmpvj5OWmBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D625C36000;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 08:42:47 +0100
Subject: [PATCH v4 2/5] dt-bindings: net: Add generic wireless controller
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-dt-bindings-network-class-v4-2-2329336802b4@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=s4h8B9gNJQ6JIaRS+FZDFjTYjzD5y6gNzE0ffwMuDco=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2nV/6rsk3oZ7Zyx3BHMSxD/3T7AS4K6Ut8/Ix
 lXZHWCc56KJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9p1fwAKCRBgAj/E00kg
 crwXEADFNSgiKo48SYtQuekFHAo+4fG9ATvPU7eD5a5aQHSz43A2DGLbx1N0t0m5x+UamLuzAYR
 IMl7W1JI+To73ZgOCDkbdHrt9gOlO7OtyQtcIUENMFEba252GuCIeTbneN3qBnxdB33x5AufHx1
 S70mveR8HrembIKmCEtHpf8+GSNkZ+bD3NzxB945vapzCjoF8uKY0EsUEovQ62pRee+D1k8tQn8
 shug/+iZDVDBrCT7vopf6ENjZPzY+tqqCS+AxHq68frOCCEpro+2vZJEgV47dQ8Glve69kXQ/aD
 DGZ+zh610NGjdnMaJYlAub3CB1AkvwpIAO9ovR55JIZm3wNaZwSMMfLXexOsGZ1C40L2o6DVqXR
 ZNNCGhTGL7wt41wBzlCfSDyQAaWiJY30mpOb9ky6mR91exDXT1jHGLlRkOtPSsEiP+iENDCCgwd
 4FAgcm/1INX6D4ny0yaF0ird6L3ius/ZRotszDiViVYiKOWztVRx3xSBUUBzH6FCfZOtQI6p3+D
 fIfCbd7Le45LQMXKKIh4MWOut9jogpciD+QexzNn+4OtJ+rIhVgCUlRFf2aONo8SS0HzQ5Fj5J6
 usYDTtjvhRDLtmqpDueELxfxaW3TKoYXB5Zn187clI6x3cW8dK7Lg+001d76FLMVG2sMHHtf7qc
 /BGK5UaVHz9dP1Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Wireless controllers share the common properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



