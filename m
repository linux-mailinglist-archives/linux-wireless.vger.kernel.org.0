Return-Path: <linux-wireless+bounces-38299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 62pBLkxuQmoC7AkAu9opvQ
	(envelope-from <linux-wireless+bounces-38299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 15:08:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A26DAC97
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 15:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZEw+acYq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38299-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38299-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB0D13029A68
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEC406281;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813504048BD;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738120; cv=none; b=JTnyp0OkOye36xeuQ9kO8H5Vxv67Ysia3HC/LvrAmIY4uKsU3EOMhSGOZm5e7axwC6hnwCvxmVFPXOjtplJsOG91r7J11pLxzJQGi0z2TtQhyyyUR3x2QgvqRjOACpio6o7wVPjp/oGqaxnmuWBe2AaZbECb9ocUcI36FAngBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738120; c=relaxed/simple;
	bh=mp2zw6QM51Bf9uwEWNv98NT6Uz24l/Zi/3UavuRce3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7sBkuaFGAnSOpuLxelgcJ/x06CETve1CV8fv3ZpSVyruayTclqOP0TGCQte2Ckp7a6I5aY1h6jzUeqF6Lju26BMbLA7jSbFGzUm4CrWYN/8iZJ/pamOpe9yCoV6aHm8+afjyD1+10NIrpt5Uth2K1tZYFI0bsMGYb3wFZRFXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEw+acYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB87BC2BCC9;
	Mon, 29 Jun 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782738120;
	bh=mp2zw6QM51Bf9uwEWNv98NT6Uz24l/Zi/3UavuRce3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZEw+acYqmxsPDg4tAFyEXzewIRP9z5mTMl/uCjFJM6fJ6c0C5FK7DyRferFWXbEJ5
	 96IvIYgBu8nU5pTZrhv2BIPbCNF6c4lz3bEfeanBpW5Ai/GpFty5oc4n+rCPpT55Li
	 BBIADnViwVLTlnRwwO3OzA9dANQzWYqgo++g4JeEjK7xc3ZZma2hA7ikT1f+yKKXNH
	 yY9E8TmtmsSmKZWqILY8eufGLB0gk25jWCAWOo9Yf+D09e1jXh9R8ESIaP9XhHkwx9
	 pshYnUoDPcVV3CZ+9wPWsx0T8w5EnI9IVZp05rA4OOLS2RJRYRCb8TFZNMkFBbBTxo
	 1qY5C6HSRTetA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CEC43327;
	Mon, 29 Jun 2026 13:01:59 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 29 Jun 2026 17:01:44 +0400
Subject: [PATCH v2 1/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-ipq5018-bluetooth-v2-1-02770f03b6bb@outlook.com>
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
To: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Saravana Kannan <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738117; l=2762;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=YKnhdG7CPmG+0uZVZGdNpApSjclFarkABMgTKFaYoG8=;
 b=rt+aUHohgoD/gX5hHu3M5/wFqt/E0QOgK6XWCstHy23ovbksclu1j0vkWQUSou3RyLLt06k7m
 i/R3aQ0x61tAB4bEKicIaVUfAG1JEj3+8svp2H+hdHUyC9JuY7MeF+e
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:george.moussalem@outlook.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38299-lists,linux-wireless=lfdr.de,george.moussalem.outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,outlook.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,outlook.com:replyto,outlook.com:email,outlook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF8A26DAC97

From: George Moussalem <george.moussalem@outlook.com>

Document the Qualcomm IPQ5018 Bluetooth controller.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../bindings/net/bluetooth/qcom,ipq5018-bt.yaml    | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
new file mode 100644
index 000000000000..2119162994e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,ipq5018-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ5018 Bluetooth
+
+maintainers:
+  - George Moussalem <george.moussalem@outlook.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5018-bt
+
+  clocks:
+    items:
+      - description: Bluetooth Subsystem low power oscillator clock
+
+  clock-names:
+    items:
+      - const: lpo
+
+  firmware-name:
+    maxItems: 1
+
+  memory-region:
+    items:
+      - description: |
+          Reserved memory carveout for firmware loading and runtime data
+          transport between the host and the Bluetooth controller.
+
+  interrupts:
+    maxItems: 1
+
+  qcom,ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: syscon node representing the APCS registers
+          - description: offset to the register within the syscon
+          - description: IPC bit within the register
+    description: |
+      The outgoing IPC bit used for signaling the Bluetooth controller of a host
+      event or for sending an ACK if the remote processor expects it.
+
+  resets:
+    items:
+      - description: Bluetooth Subsystem reset
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - firmware-name
+  - interrupts
+  - qcom,ipc
+  - resets
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+
+    bluetooth {
+      compatible = "qcom,ipq5018-bt";
+
+      firmware-name = "qca/bt_fw_patch.mbn";
+
+      clocks = <&gcc GCC_BTSS_LPO_CLK>;
+      clock-names = "lpo";
+      resets = <&gcc GCC_BTSS_BCR>;
+
+      qcom,ipc = <&apcs_glb 8 23>;
+      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
+
+      memory-region = <&btss_region>;
+    };

-- 
2.53.0



