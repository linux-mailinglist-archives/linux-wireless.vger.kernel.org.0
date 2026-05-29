Return-Path: <linux-wireless+bounces-37082-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ6qC5jZGGpDoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37082-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:11:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C245FB9E3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18E1630F1946
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B2F9E8;
	Fri, 29 May 2026 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="LSEAwMkU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160B2AF00
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013356; cv=none; b=HumcbY1DvA8fZJG6zthQLGLnehbSAMDJxMKZsRSSzWIT5KhYKP5dUA2n0fds4lPbLhe84iyGjS7SSwLGkAO/qNhHlhiCNuN2jhnCujZ00U88Ef0Ufe1VbLXWYVYQF3ZfA59KMhLbf2ZUpsv1ITGYG8MZGrR0Ey208Nwk1JGINGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013356; c=relaxed/simple;
	bh=jzalkTDcXfTL0juq3QudRRH5SlEglV75jQDgtXc2iLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw9xImwkgoSVUvSqRsTpV1s2PC8ZXqegsGj9Kos9SvsPPRfblPBnL2hELNQaM9xd7yN8aO8l1ts3aATKB8WJQyFohkLjD2S+fZptFd99SUf5CV0Uf3G1F47EbXLsGg1sxyl41c4tAuxvC12NbFDTqSxXqSkIRa+QJ/zzA4oTbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=LSEAwMkU; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Skjiwb0oZtpTfSkjjw9YPt; Fri, 29 May 2026 02:06:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1780013163; bh=jzalkTDcXfTL0juq3QudRRH5SlEglV75jQDgtXc2iLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=LSEAwMkU+SQcmVl1n+YlTvQjqNbU2w94SukoOnfQV56pyyqMO8CXjQ3CZ2Icj88a6
	 D2Ka1aQDPmnbBDgdQy7T+kCE1n+uvng+kKzzZCxsvPr/OlOhY9uUagPg7+o9fEN/gx
	 qtbenEtitRUIraenRZgutrLdc2vrj+q1o6NmEoYqulF4WH4JT8yI2NUAFV6q3yUfI3
	 GjkNoMhbbjBlZeM125IUXJLwJ2UZiIzpRhlQT2enCLLh5lTjzq0AhWKOwredrv43eg
	 dkEo1cCxT+of8/TthCkJDtY6MK/rqTZXlJcSQSjB9fMqDp06xWOmXPRww4sXa3I+70
	 YsfHsF30T8GuQ==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Fri, 29 May 2026 02:06:01 +0200
Subject: [PATCH 3/4] dt-bindings: bus: add brcm,bcm6362-wlan
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-add-bcm6362-wlan-v1-3-722242777f58@gmail.com>
References: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
In-Reply-To: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Alessio Ferri <alessio.ferri@mythread.it>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfBcr/DglRpxN7rw6gJy2iDE09fw681n/E0jjnusTr+YBzo0LvhdgKX9REQgLsE+08MNT4wD7AwS0wWzXJJxSryGamNMzjPD3JAECY5TxJEBqpCpvQZjQ
 jtNQyPnP/Nedax3aMJKayvYunmGdpvpOeIXNFL6EW4gfX8gyUyJXg2A73FbfvY+Nfd9QlEoYW+daAjCliaJOEvgIzRis69RY7OYX+Qd+UmK3U7vvV1PLoB0u
 2C5QtwVSKfpRZ8a1k3PeQOkP68M00EKZ05Fg6g68FNKvHo376SjaoXNZQg7alQLznV9EwQME4znJHzZapoiWomx4bxEIibWgzIInH7QxO0fD4YBjUTo4yc2T
 0xIQnInC8zUdo/YlUaNwEl6viUSG71eGNuKwBk7peD6QfG2lLYVvpjWgjTbeizGQrizxGLY09PdyXOw2KrER7EhgCGWbbvJhfVc/iXAkEhmn6vNNabCCQvlH
 GZn6vNEF9cuq+TFWK98ZdraTT736/WIjykftNuFjKJ90kTacCr6eOcT7lPM=
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37082-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,mythread.it,kernel.org,pengutronix.de,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 76C245FB9E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the binding for the SHIM bridge that gates the on-chip
2.4 GHz WLAN block of the Broadcom BCM6362 SoC. The bridge owns the
SHIM peephole, a single clock for the macro, and two resets (the
SHIM macro itself and its ubus side). It is also a bus: it carries
one brcm,bus-axi child describing the bcma backplane behind the
SHIM, with a standard interrupt-map routing the d11 core's IRQ to
the SoC interrupt controller.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 .../devicetree/bindings/bus/brcm,bcm6362-wlan.yaml | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml b/Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml
new file mode 100644
index 000000000000..c8d49ccdd2c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/brcm,bcm6362-wlan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6362 on-chip WLAN SHIM bridge
+
+maintainers:
+  - Alessio Ferri <alessio.ferri@mythread.it>
+
+description: |
+  The BCM6362 SoC integrates a 2.4 GHz Broadcom WLAN block whose
+  register backplane uses the Broadcom AMBA (bcma) architecture. The
+  backplane is gated by a small SHIM bridge that holds the WLAN macro
+  in reset and disables its clocks until released by software. CFE
+  does not release this block, so software bring-up is required
+  before bcma can enumerate the backplane.
+
+  This binding describes the SHIM bridge node. The SHIM driver brings
+  the macro up and then populates the brcm,bus-axi child node, which
+  describes the bcma backplane behind the SHIM and is bound by the
+  bcma-host-soc driver. The SoC-specific configuration (big-endian
+  accessors, SHIM-attached topology, SHIM Control register peephole
+  pointer) is delivered to bcma via platform_data injected at
+  populate time, so the brcm,bus-axi child stays SoC-agnostic.
+
+properties:
+  compatible:
+    const: brcm,bcm6362-wlan
+
+  reg:
+    maxItems: 1
+    description: SHIM peephole registers.
+
+  reg-names:
+    items:
+      - const: shim
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: SHIM macro reset
+      - description: SHIM ubus reset
+
+  reset-names:
+    items:
+      - const: shim
+      - const: shim-ubus
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^axi@[0-9a-f]+$":
+    type: object
+    description: The bcma AXI backplane behind the SHIM.
+    $ref: /schemas/types.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+  - reset-names
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    wlan@10007000 {
+        compatible = "brcm,bcm6362-wlan";
+        reg = <0x10007000 0x100>;
+        reg-names = "shim";
+        clocks = <&periph_clk 11>;
+        resets = <&periph_rst 7>, <&periph_rst 17>;
+        reset-names = "shim", "shim-ubus";
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        axi@10004000 {
+            compatible = "brcm,bus-axi";
+            reg = <0x10004000 0x1000>;
+            ranges = <0x00000000 0x10004000 0x00002000>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            #interrupt-cells = <1>;
+
+            interrupt-map-mask = <0x000fffff 0xffff>;
+            interrupt-map = <0x00005000 0 &periph_intc 0 12>;
+        };
+    };

-- 
2.54.0


