Return-Path: <linux-wireless+bounces-21126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2BA7A4B2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 16:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AAA16D197
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B224EA81;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdYXCYR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB2433D1;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689275; cv=none; b=FXc+LIEANXI14ND9YgZcAVseG4d1KlY3Jg1OMV221+f9oLECMry32DXVHFtOmFwhaaU5jr2z7A8+FaiIbRT46BXqzmhXgMpDz6a8HRkDv3ngFioRGlWFbzh2tukNMaVONo0y+vTGw5WbF8FzGXcU5POW2my2N0ELv/IZC+Wmb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689275; c=relaxed/simple;
	bh=CdfUb+Gx495PVB48hHNxzZmMWdZExGRDPCHUi+zDxJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3v6lkKGz7tZ1KVPMo3NhBB2vWGz8E9ETC5xbrXDYfu2uVW3i2KROQnkAWTLKZSdMNAx0n+nO88fXR5GzzU3Q5HUh7Nkp7s5EVckzSL8byS0mm0COLtsPmq89OCwZjJK2oBqeIzYzzXGWDQzsJ9Eg+2dI9V3w8bQr7GJigxjbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdYXCYR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 918FBC4CEE5;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743689275;
	bh=CdfUb+Gx495PVB48hHNxzZmMWdZExGRDPCHUi+zDxJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rdYXCYR4AwrCJU5SZcBL8nQNI/rsFaGkMDCl9NwjJVX4ASq6IG+YjDlN5nl/BhhB5
	 zDqr4ak+HDqbQ/UxmZTXkloaKgzufAj65PzlmYCP/wn6WzxVmLG13TGh0iCuS1M6r1
	 rgDKI+JN4MjB3MsvoD03r/JguQ8Z0qjkp0UTPIkGo7hSaNKLawrESTFSbmANjioCsh
	 VWuT1ORtGdcLDmyaTzpil3Y/HEuun5Wx9wJG7JZqx2UrrQD9yPagDQ2iRV1KQdA2Pi
	 P7UwsRpB07dZUlSYAw4MMMkoPJbRdzAFBAN1spo4Z52x7Aurv1xoIoFXLQwQJrvcmZ
	 XclgVngKDOPSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0E3C3601E;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 03 Apr 2025 16:07:48 +0200
Subject: [PATCH 1/2] dt-bindings: net: wireless: Add Realtek RTL8188 USB
 WiFi
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>
References: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
In-Reply-To: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743689273; l=1657;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=6b1it+r1AmIIbl9MaNmUVNJ7dqm/3ZZS4M5ZCpj+F30=;
 b=YDrrRB67eDRetNqSjtCKWOBuVpglvJnAwdFk9FRsZxPSlWBLXb2QLQpdO4Coc2iJyUZVpCj99
 BguwI22F9v+Dt7+EJp0PmVOUy58EegxjWqnkphLZu27KL4mR7ZcOqYU
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
 .../bindings/net/wireless/realtek,rtl8188.yaml     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/realtek,rtl8188.yaml b/Documentation/devicetree/bindings/net/wireless/realtek,rtl8188.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b637c71e3c4d81b47d338394b2e0a7772035c2c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/realtek,rtl8188.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/realtek,rtl8188.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL8188 USB WiFi
+
+maintainers:
+  - J. Neuschäfer <j.neuschaefer@gmx.net>
+
+description:
+  The Realtek RTL8188 is a USB-connected 2.4 GHz WiFi module.
+  TODO- website or soemthing
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+
+properties:
+  compatible:
+    const: usbbda,179
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



