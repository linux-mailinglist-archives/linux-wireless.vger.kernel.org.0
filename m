Return-Path: <linux-wireless+bounces-35184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I3wDibX52mzBgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 21:59:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A443F278
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6F630682F8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FA3DD526;
	Tue, 21 Apr 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDyyT/G8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B93DCDBE;
	Tue, 21 Apr 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801539; cv=none; b=mqgmPfXJHWoDHTYjdU3+UA7nrPNEqmWfWsr/0C7iHfG2nCC7LtXMlTqZeVKjKWDRz/ID2Fip8Ku1YeRpIIAvEJp71a0j2S7uznAftqPdX2RSPVf+ruG9zL3fK3ZHsSv9R56dsYyzXA4Ad+8l9WfUdoqEybM7ctjSwIM12ZB8O7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801539; c=relaxed/simple;
	bh=6Y3XJTx7QfULoZhyBK7B6XVakPKj7Nc4iKBX0gVaDyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0Eb8iS6u+6OngGqUmlgmMvJVHjh/RKgpxU0QdATMJwINWY2f0q8utUZ1jCh8Hnlqpueu5R1QVQT5HWF6TJGCGU2nFmCO4AYmfHII1ctCHRV5OqMum9Lsl01bXcfBuGzc3lF4HtcYTF6QLs/t8L7CLMRHK/qtQ3A3mKhgiuz49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDyyT/G8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B756C2BCB0;
	Tue, 21 Apr 2026 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776801538;
	bh=6Y3XJTx7QfULoZhyBK7B6XVakPKj7Nc4iKBX0gVaDyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QDyyT/G8eZH50ql5rjOLdalKdIqZE2fgMeHyyuy67vpqrYy+KhkwUuA/0xdO00XVl
	 Vfx1OeFBwa6Ssr5eIjztzSOos+9xfG8Vkp/EVQHXKCnNlqVAx1f8O5kKRcY4tRK0wx
	 Fy47U2hZXsEsHQaXu8SFJpMDLdICx/1SZ5j9ZyEvtTVvlRy/eiajhjsz5CuPG2UmVD
	 Pajh++oAgO3eUkWIFUawc6HbdS9mLh/w1vAUHaCSAx2mUVCbEO8WyarGbjkCkjSEle
	 ryJP2M2scBaHs85zbgfXy4jFugN+BqjkSaBkPOITh2/5bPniMWJxXYdWXzCqm3B6qi
	 jkzWBcBv/lEbQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Xiwen <forbidden405@outlook.com>,
	Alex Elder <elder@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Rao Mandadapu <quic_srivasam@quicinc.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix phandle-array constraints, again
Date: Tue, 21 Apr 2026 14:55:25 -0500
Message-ID: <20260421195836.1547469-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,linaro.org,gerhold.net,lunn.ch,davemloft.net,google.com,redhat.com,sipsolutions.net,samsung.com,gmail.com,linuxfoundation.org,outlook.com,oss.qualcomm.com,quicinc.com,foss.st.com,nxp.com,suse.de];
	TAGGED_FROM(0.00)[bounces-35184-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E03A443F278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The unfortunately named 'phandle-array' property type is really a matrix
with phandle and fixed arg cells entries. A matrix property should have 2
levels of items constraints.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Can someone from QCom provide some descriptions for 'qcom,smem-states'
properties.
---
 .../display/rockchip/rockchip,rk3399-cdn-dp.yaml         | 2 ++
 .../bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml      | 7 ++++---
 Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml | 6 ++++++
 Documentation/devicetree/bindings/net/qcom,ipa.yaml      | 6 ++++++
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 5 ++++-
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 5 ++++-
 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml         | 9 +++++++++
 .../devicetree/bindings/pci/toshiba,tc9563.yaml          | 5 +++--
 .../bindings/remoteproc/qcom,msm8916-mss-pil.yaml        | 3 +++
 .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml        | 3 +++
 .../devicetree/bindings/remoteproc/qcom,pas-common.yaml  | 4 ++++
 .../bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml        | 4 ++++
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml         | 3 +++
 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml        | 3 +++
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml         | 3 +++
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml        | 3 +++
 .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml        | 3 +++
 .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml   | 3 +++
 Documentation/devicetree/bindings/sound/samsung,tm2.yaml | 2 ++
 .../devicetree/bindings/spi/st,stm32mp25-ospi.yaml       | 5 +++--
 .../devicetree/bindings/usb/chipidea,usb2-common.yaml    | 2 ++
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml  | 7 ++++---
 22 files changed, 81 insertions(+), 12 deletions(-)

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
index b30544410d09..e47e1e09300a 100644
--- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
@@ -42,7 +42,13 @@ properties:
     description: State bits used by the AP to signal the modem.
     items:
       - description: Power control
+        items:
+          - description: Phandle to ???
+          - description: ???
       - description: Power control acknowledgment
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: Names for the state bits used by the AP to signal the modem.
diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index c7f5f2ef7452..c53f63068b77 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -123,7 +123,13 @@ properties:
     description: State bits used in by the AP to signal the modem.
     items:
       - description: Whether the "ipa-clock-enabled" state bit is valid
+        items:
+          - description: Phandle to ???
+          - description: ???
       - description: Whether the IPA clock is enabled (if valid)
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index f2440d39b7eb..5c580bc7df08 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -158,7 +158,10 @@ properties:
     description: State bits used by the AP to signal the WLAN Q6.
     items:
       - description: Signal bits used to enable/disable low power mode
-                     on WCN in the case of WoW (Wake on Wireless).
+          on WCN in the case of WoW (Wake on Wireless).
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 0cc1dbf2beef..326c1a94a1a0 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -80,7 +80,10 @@ properties:
     description: State bits used by the AP to signal the WLAN Q6.
     items:
       - description: Signal bits used to enable/disable low power mode
-                     on WCN6750 in the case of WoW (Wake on Wireless).
+          on WCN6750 in the case of WoW (Wake on Wireless).
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
index 363a0ecb6ad9..ea8df6890478 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -167,8 +167,17 @@ properties:
     description: States used by the AP to signal the remote processor
     items:
       - description: Shutdown WCSS pd
+        items:
+          - description: Phandle to ???
+          - description: ???
       - description: Stop WCSS pd
+        items:
+          - description: Phandle to ???
+          - description: ???
       - description: Spawn WCSS pd
+        items:
+          - description: Phandle to ???
+          - description: ???
 
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
index c179b560572b..3c614cb7ce88 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
@@ -104,6 +104,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: Names of the states used by the AP to signal the Hexagon core
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index 4d2055f283ac..d459296df0c2 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -101,6 +101,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: Names of the states used by the AP to signal the Hexagon core
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 68c17bf18987..6260f77b7e4b 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -60,6 +60,10 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
+
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
index bca59394aef4..3e410cbd45cf 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
@@ -92,6 +92,10 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
+
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
index b1402bef0ebe..f0bee69baf0d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
@@ -134,6 +134,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
index 94ca7a0cc203..3ea83207ae32 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
@@ -91,6 +91,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
index 005cb21732af..1f1d73610510 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
@@ -148,6 +148,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
index f4118b2da5f6..0111384d55d5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
@@ -104,6 +104,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
index a3c74871457f..b9325967b8a3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
@@ -92,6 +92,9 @@ properties:
     description: States used by the AP to signal the Hexagon core
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 117fb4d0c4ad..e009f8ed9e8c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -84,6 +84,9 @@ properties:
       States used by the AP to signal the WCNSS core that it should shutdown
     items:
       - description: Stop the modem
+        items:
+          - description: Phandle to ???
+          - description: ???
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
index 67586ba3e0a0..c752e4874e7f 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -46,7 +46,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - description: Phandle to I2S0.
+        maxItems: 1
       - description: Phandle to I2S1.
+        maxItems: 1
 
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


