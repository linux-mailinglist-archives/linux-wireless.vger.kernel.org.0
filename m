Return-Path: <linux-wireless+bounces-36726-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAj/OPItDmoK7wUAu9opvQ
	(envelope-from <linux-wireless+bounces-36726-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:56:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D2859B7F4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699A8383CCEB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945046AED1;
	Wed, 20 May 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj4jdjHy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FED3FE66D;
	Wed, 20 May 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302382; cv=none; b=CqLLjrQowEsQ+GEpDA8gZULy+9l9YvJ6+bN82sy3eUp8qy2lMJ6bpn4ot4x2fH4ab+EdsTHUFqw/TTuPusBR2v08vfHIRqzPHzIetOV7Dr/rDlYQRfTq4NmH2iSoXXeWiXBBWrc0EV+yGSpYS35Ynv8c6qRAzUnPykhALZx82qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302382; c=relaxed/simple;
	bh=QnhxnHtucHKw6Uua/rQwPfSkr3Npc8iASaSu0+j3ytM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3n55OptMuPWlya9bGB07ZCJJDWMyrEjvFhnsWAMkWgi03TIEpL+V6frX0c7bITaUab+h5ZG5V9ztRZyYVKPWl3Gq2nr+2NQpWjYP/18kxVtH9HXs5C7xmdF9+0oS5OJMF4fHlZkvTOQl/Y7Epdr6VBUe+rGGp5EMR2kzbeFF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj4jdjHy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC9F1F00897;
	Wed, 20 May 2026 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302381;
	bh=Kx7bWM1kJr6AOGlca9EF/UDaya3vcfDIi8gsI0tM7xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nj4jdjHyclmkGQphNLKvljHh2Oh2mJxYSFwUYxk8N4A0juSC3p4zrdZpAPwmwED7O
	 XNvE3oLYFJqleRrk3PSuNs9F/+FEieEzGuJ4abKxgNQ7KZofHNo33I9+e4ddCwocbQ
	 x3I+o46EultDco4KSYYQ0w7dRLVfrr9n8XmrLqTu4cOXhRdfRt0ccSS/0kq4in+3Yp
	 GywhzsoRU74CftCcgAA1LsEUDjPBejWNSDXZa3t+tk+agf6MR7ileZJ/V3tETZEwIR
	 y1sisiWPqk3zz9juYnIctU7rYebD9DyJ+XBcLeX5utyxkwMHQqsFdSzNGQWrHFbyCL
	 T/r7hTlGIBNXA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	netdev@vger.kernel.org,
	Christian Lamparter <chunkeey@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 07/10] [v6 net-next] dt-bindings: net: add st,stlc4560/p54spi binding
Date: Wed, 20 May 2026 20:38:12 +0200
Message-Id: <20260520183815.2510387-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260520183815.2510387-1-arnd@kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36726-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.0.0.0:email,microchip.com:email,devicetree.org:url]
X-Rspamd-Queue-Id: 33D2859B7F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The SPI version of Prism54 was sold under a couple of different
names and supported by the Linux p54spi driver, but there was
never a DT binding for it.

Document the four known names of this device and the properties
that are sufficient for its use on the Nokia N8x0 tablet.

As I don't have this hardware or documentation for it, this is
purely based on existing usage in the driver.

Link: https://lore.kernel.org/all/e8dc9acb-6f85-e0a9-a145-d101ca6da201@gmail.com/
Acked-by: Christian Lamparter <chunkeey@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v6: no changes
v5: fix name in MAINTAINERS file
v4: renamed file to st,stlc4560, matching the primary compatible string
    require st,stlc4560 string
---
 .../bindings/net/wireless/st,stlc4560.yaml    | 61 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml b/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
new file mode 100644
index 000000000000..a32265c07350
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/st,stlc4560.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST/Intersil/Conexant stlc45xx/p54spi/cx3110x SPI wireless device
+
+maintainers:
+  - Christian Lamparter <chunkeey@gmail.com>
+
+description:
+  The SPI variant of the Intersil Prism54 wireless device was sold
+  under a variety of names, including Conexant CX3110x and
+  ST Microelectronics STLC4560.
+
+allOf:
+  - $ref: ieee80211.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: st,stlc4560
+      - items:
+          - enum:
+              - cnxt,3110x
+              - isil,p54spi
+              - st,stlc4550
+          - const: st,stlc4560
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  powerdown-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@0 {
+            compatible = "st,stlc4560";
+            reg = <0>;
+            spi-max-frequency = <48000000>;
+            interrupts-extended = <&gpio 23>;
+            powerdown-gpios = <&gpio 1>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8063cb56feef..93cf1fb72357 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20306,6 +20306,7 @@ M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
+F:	Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
 F:	drivers/net/wireless/intersil/
 
 PACKET SOCKETS
-- 
2.39.5


