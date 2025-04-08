Return-Path: <linux-wireless+bounces-21283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B948A815A2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045B97B964D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8912451C3;
	Tue,  8 Apr 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPaiY989"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0923F273;
	Tue,  8 Apr 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139639; cv=none; b=P+irbqfA0uzfBdBjfg6ZHP3J92BkZONWln+u9e3AOtyvsZwglga2EbyCG1bAfA3ApxoLxAtCvl22JQoqofwnCW6YcQbnwzRNBXehmhb1gbf23kAYmJ9IaDwz5xgbsNkl5+7YgWcW5ooePDyVXG8CWw3pU0K/TmBlonND6kMo1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139639; c=relaxed/simple;
	bh=88n+/OmONN80dFebJ7pjCh/IqPsrPBPEi4aqhvPQZTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZQw39hC8UClBkkob8xfqYWYKAWjjteSnSmMpWLUAdUb1rMqc36Sahhw0b3lubj4g4Oy5HS6IKTvOzQsIMhtbJdC3ARF4uruYMuXm1tjqHFnKzd0klMZAmSkMEAa+rZZBa1S4LhfiOU8XsA6+KNrm48W4vnmhRkOCVYu2RQ/Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPaiY989; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56D64C4CEE8;
	Tue,  8 Apr 2025 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139639;
	bh=88n+/OmONN80dFebJ7pjCh/IqPsrPBPEi4aqhvPQZTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MPaiY989micZMK2KwK14OkSWYH/nN4F5j2Ec0cwSThksUNrPDG7lKWAxV/1Iu23Ca
	 W22FOxUIflzgBD5yHIYMVo4VlI6/OOURTh4PD7mAOfgbh10TfTDcak5cmTgig9CnDJ
	 1udak+yhRGGUGJr/i+B0WR0VhkKaUULD4DSjRwI6zLLc9klB4iPcAQO1xmMgAYmUKM
	 OvFc2sg0avd8zniS8QKQt4IaJXcnWkXUxYjDgyYDIi/1kfFEoenIIb/SpqY+Gb+HuD
	 njYLki9jfKkCnC65tLEbmJv6ZBGWFsn7/wOqcV08aJiAxk4nUxW01mEYfHX9kKHTH6
	 Vwrma25qVtEsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41929C369A5;
	Tue,  8 Apr 2025 19:13:59 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 08 Apr 2025 21:13:12 +0200
Subject: [PATCH v2 1/2] dt-bindings: net: wireless: Add Realtek RTL8188ETV
 USB WiFi
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-rtl-onboard-v2-1-0b6730b90e31@posteo.net>
References: <20250408-rtl-onboard-v2-0-0b6730b90e31@posteo.net>
In-Reply-To: <20250408-rtl-onboard-v2-0-0b6730b90e31@posteo.net>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744139638; l=2077;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=4nIhUGSI5Ng3z4pAy5LHnkaqH2Vjs66teKpBTHo1jxU=;
 b=+vY+V/NyRm4aQpt4QGCRdBd1HVGT5r1dsJSfIREdxcTqOB3DKIiMrYUpU1cEl4rcc02hiyeDx
 48hktykm3uHDQtYx43hY+hvBe+POUGq04XV6kV1FXjHHpE9PxKasWPO
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

This is an on-board USB device that requires a 3.3V supply.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- Use my current email address
- Remove TODO comment
- Rename schema file to realtek,rtl8188e.yaml. This is the same
  granularity at which the rtl8xxxu driver is split into files, making
  it unnecessary to rename the schema file if another similar chip is added
  in the future.
- Change license identifier from (GPL-2.0 OR BSD-2-Clause) to (GPL-2.0-only
  OR BSD-2-Clause) because GPL-2.0 is ambiguous
---
 .../bindings/net/wireless/realtek,rtl8188e.yaml    | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/realtek,rtl8188e.yaml b/Documentation/devicetree/bindings/net/wireless/realtek,rtl8188e.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2769731e07083b14e2f7388858dcded92c442018
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/realtek,rtl8188e.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/realtek,rtl8188e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL8188E USB WiFi
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description:
+  Realtek RTL8188E is a family of USB-connected 2.4 GHz WiFi modules.
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+
+properties:
+  compatible:
+    const: usbbda,179  # RTL8188ETV
+
+  reg: true
+
+  vdd-supply:
+    description:
+      Regulator for the 3V3 supply.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi: wifi@1 {
+            compatible = "usbbda,179";
+            reg = <1>;
+            vdd-supply = <&vcc3v3>;
+        };
+    };
+
+...

-- 
2.48.0.rc1.219.gb6b6757d772



