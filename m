Return-Path: <linux-wireless+bounces-36089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMqAI1T0/GlmVgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 22:21:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC574EE5EC
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 300173059023
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F83B2FFB;
	Thu,  7 May 2026 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbOAwkOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090231F988;
	Thu,  7 May 2026 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185091; cv=none; b=hBE8ziAGAOgcnTGttA9WfIEZUfHVQrddKJ1DOEOC8ASPvYCq9vX9Gztx+HoMDRtvEsqxfkmEjdg3OkGhrToHyJrVFioguHsvb44oR1cpLasZxsG57MZNPz5HwD6bZqjQDaeJAchjcp786VVAi8FPT9EMhKjPTIUkeAOM2eBbNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185091; c=relaxed/simple;
	bh=0rCxiPiDS9kWmfm1pqCs6DQt2eO1j7j1yW3SUOD+G1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjbMHorSfjHS2eqh/3aaGH+dHh1K0QzdlBK+bIgjRoS4f5IoVFHA8QbFiQNTbAa3u4UKyQQElmDlnKl5ItimLgIKSodUJQSzZi9XoyABZFXEyIq61Pk2x3yskxFTBFrf8n7jcR3bCVRNAaygb085E0+/RcZHEp7N+DV61H4SxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbOAwkOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C37C2BCB2;
	Thu,  7 May 2026 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185091;
	bh=0rCxiPiDS9kWmfm1pqCs6DQt2eO1j7j1yW3SUOD+G1o=;
	h=From:To:Cc:Subject:Date:From;
	b=hbOAwkOiU/1q0zcaNPcMfQhIabSbfOLvUZKGi2msO4/hafdOe0sj/rI9QhLnEwWoK
	 msJPDvuglxhYu+eyamFQ3OobYFC5Ncic56J75L1+1UHQH7juK000qo5tzUFr9JmE7o
	 MtqNkci4z0BpEczBUYis/XdWOfPFydG9OCIFJoaGWVsM8r8M6U0J5eOsgfdImaP4X3
	 /ovY1nDWhNx0NT/7Iov0xyqq1QHakKNdqP/rQxjiKadsS5+L4CSm03BbvCeyG11vbb
	 ZQgEbDPrNdIRdHsnaMJSxdlSln32j9iEajohG1wPnWtIFHTLzBiKK428rCV9/NvT1r
	 nQzxrRxUIjebg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2] dt-bindings: Fix phandle-array constraints, again
Date: Thu,  7 May 2026 15:16:00 -0500
Message-ID: <20260507201749.2605365-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CC574EE5EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	TAGGED_FROM(0.00)[bounces-36089-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,renesas,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The unfortunately named 'phandle-array' property type is really a matrix
with phandle and fixed arg cells entries. A matrix property should have 2
levels of items constraints.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Add proper descriptions for 'qcom,smem-states'. Thanks Krzysztof!
 - Fix i2c-parent warning
 - Fix extra blank lines
---
 .../rockchip/rockchip,rk3399-cdn-dp.yaml       |  2 ++
 .../bindings/i2c/i2c-demux-pinctrl.yaml        |  1 +
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml     |  7 ++++---
 .../devicetree/bindings/net/qcom,bam-dmux.yaml | 12 ++++++++++++
 .../devicetree/bindings/net/qcom,ipa.yaml      | 12 ++++++++++++
 .../bindings/net/wireless/qcom,ath10k.yaml     |  8 +++++++-
 .../bindings/net/wireless/qcom,ath11k.yaml     |  8 +++++++-
 .../net/wireless/qcom,ipq5332-wifi.yaml        | 18 ++++++++++++++++++
 .../bindings/pci/toshiba,tc9563.yaml           |  5 +++--
 .../remoteproc/qcom,msm8916-mss-pil.yaml       |  6 ++++++
 .../remoteproc/qcom,msm8996-mss-pil.yaml       |  7 +++++++
 .../bindings/remoteproc/qcom,pas-common.yaml   |  6 ++++++
 .../remoteproc/qcom,qcs404-cdsp-pil.yaml       |  6 ++++++
 .../remoteproc/qcom,sc7180-mss-pil.yaml        |  6 ++++++
 .../remoteproc/qcom,sc7280-adsp-pil.yaml       |  6 ++++++
 .../remoteproc/qcom,sc7280-mss-pil.yaml        |  6 ++++++
 .../remoteproc/qcom,sc7280-wpss-pil.yaml       |  6 ++++++
 .../remoteproc/qcom,sdm845-adsp-pil.yaml       |  6 ++++++
 .../bindings/remoteproc/qcom,wcnss-pil.yaml    |  6 ++++++
 .../devicetree/bindings/sound/samsung,tm2.yaml |  8 ++++++--
 .../bindings/spi/st,stm32mp25-ospi.yaml        |  5 +++--
 .../bindings/usb/chipidea,usb2-common.yaml     |  2 ++
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml  |  7 ++++---
 23 files changed, 142 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml
index 1a33128e77f5..195f665970bf 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml
@@ -41,7 +41,9 @@ properties:
     minItems: 1
     items:
       - description: Extcon device providing the cable state for DP PHY device 0
+        maxItems: 1
       - description: Extcon device providing the cable state for DP PHY device 1
+        maxItems: 1
     description:
       List of phandle to the extcon device providing the cable state for the DP PHY.
 
diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
index 1eaf00b90a77..deca72bfc8cf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
@@ -40,6 +40,7 @@ properties:
 
   i2c-parent:
     $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
     items:
       maxItems: 1
     description:
diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
index 41c9b22523e7..e447579e0f22 100644
--- a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
@@ -39,10 +39,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: |
       DWMMC core on Hi3798MV2x SoCs has a delay-locked-loop(DLL) attached to card data input path.
-      It is integrated into CRG core on the SoC and has to be controlled during tuning.
+      It is integrated into CRG core on the SoC and has to be controlled during tuning
     items:
-      - description: A phandle pointed to the CRG syscon node
-      - description: Sample DLL register offset in CRG address space
+      - items:
+          - description: A phandle pointed to the CRG syscon node
+          - description: Sample DLL register offset in CRG address space
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
index b30544410d09..33746c238513 100644
--- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
@@ -42,7 +42,19 @@ properties:
     description: State bits used by the AP to signal the modem.
     items:
       - description: Power control
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
       - description: Power control acknowledgment
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: Names for the state bits used by the AP to signal the modem.
diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index fdeaa81b9645..68ec76fe4473 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -128,7 +128,19 @@ properties:
     description: State bits used in by the AP to signal the modem.
     items:
       - description: Whether the "ipa-clock-enabled" state bit is valid
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
       - description: Whether the IPA clock is enabled (if valid)
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd55..d4f4d72ee0d3 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -158,7 +158,13 @@ properties:
     description: State bits used by the AP to signal the WLAN Q6.
     items:
       - description: Signal bits used to enable/disable low power mode
-                     on WCN in the case of WoW (Wake on Wireless).
+          on WCN in the case of WoW (Wake on Wireless).
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 0cc1dbf2beef..d4aa56e2f823 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -80,7 +80,13 @@ properties:
     description: State bits used by the AP to signal the WLAN Q6.
     items:
       - description: Signal bits used to enable/disable low power mode
-                     on WCN6750 in the case of WoW (Wake on Wireless).
+          on WCN6750 in the case of WoW (Wake on Wireless).
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
index 37d8a0da7780..18cd91e2728c 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -168,8 +168,26 @@ properties:
     description: States used by the AP to signal the remote processor
     items:
       - description: Shutdown WCSS pd
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
       - description: Stop WCSS pd
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
       - description: Spawn WCSS pd
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description:
diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
index fae466064780..b3ad05d90201 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -49,8 +49,9 @@ properties:
       A phandle to the parent I2C node and the slave address of the device
       used to configure tc9563 to change FTS, tx amplitude etc.
     items:
-      - description: Phandle to the I2C controller node
-      - description: I2C slave address
+      - items:
+          - description: Phandle to the I2C controller node
+          - description: I2C slave address
 
 patternProperties:
   "^pcie@[1-3],0$":
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
index faf2712e3d27..4049157dd83d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
@@ -108,6 +108,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: Names of the states used by the AP to signal the Hexagon core
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index 1b65813cc8ad..4a1b439f985e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -101,6 +101,13 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point or Shared
+              Memory Manager device handling the communication with a remote
+              processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: Names of the states used by the AP to signal the Hexagon core
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 68c17bf18987..4607b459131b 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -60,6 +60,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
index bca59394aef4..e5f5f92987e1 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
@@ -92,6 +92,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
index 7c9accac92d0..21c82cd3be03 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
@@ -133,6 +133,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
index 94ca7a0cc203..23b8e3079f3b 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
@@ -91,6 +91,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
index f349c303fa07..43dfb90ac18d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
@@ -147,6 +147,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
index f4118b2da5f6..f3f3432948ed 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
@@ -104,6 +104,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
index a3c74871457f..9666ebf1e7b6 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
@@ -92,6 +92,12 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 117fb4d0c4ad..a55e55f5f014 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -84,6 +84,12 @@ properties:
       States used by the AP to signal the WCNSS core that it should shutdown
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to the Shared Memory Point 2 Point device
+              handling the communication with a remote processor
+          - description: Single bit index to toggle in the value sent to
+              the remote processor
+            maximum: 32
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
index 67586ba3e0a0..985b7d29cd33 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -45,8 +45,12 @@ properties:
     description: Phandles to the I2S controllers.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - description: Phandle to I2S0.
-      - description: Phandle to I2S1.
+      - items:
+          - description: Phandle to I2S0
+          - description: Unused
+      - items:
+          - description: Phandle to I2S1
+          - description: Unused
 
   mic-bias-gpios:
     description: GPIO pin that enables the Main Mic bias regulator.
diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
index 272bc308726b..b6be47f67fcb 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
@@ -49,8 +49,9 @@ properties:
     description: configure OCTOSPI delay block.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - description: phandle to syscfg
-      - description: register offset within syscfg
+      - items:
+          - description: phandle to syscfg
+          - description: register offset within syscfg
 
   access-controllers:
     description: phandle to the rifsc device to check access right
diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
index 10020af15afc..e6a5e79df348 100644
--- a/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
+++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
@@ -97,7 +97,9 @@ properties:
     minItems: 1
     items:
       - description: vbus extcon
+        maxItems: 1
       - description: id extcon
+        maxItems: 1
 
   phy-clkgate-delay-us:
     description:
diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 691d6cf02c27..fec04702f530 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -61,9 +61,10 @@ properties:
       offset, and phy index
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - description: phandle to TCSR node
-      - description: register offset
-      - description: phy index
+      - items:
+          - description: phandle to TCSR node
+          - description: register offset
+          - description: phy index
 
   nvidia,phy:
     description: phandle of usb phy that connects to the port. Use "phys" instead.
-- 
2.53.0


