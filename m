Return-Path: <linux-wireless+bounces-37079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULGXES/ZGGpDoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:09:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F15FB991
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9624E30279C2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60C42A96;
	Fri, 29 May 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="Dz+3z4rS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D126AE5
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013355; cv=none; b=DFIyLIB4+FxbNuwjSe/4gNjTP/AM4zMhlRCV06wOiVwxCWIY8Fq3GenruPn1XGYd4TjFGeC+fzRCOSFr917yjVpLB090h/V+J34yAraodnZd2zIWco+i35HvrpN0/zVCoXnayBOWkjAJrHXOkLXSkhhGTfoqRZq3YqCCZF2TEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013355; c=relaxed/simple;
	bh=GZI4QoJ6lE3r080oo9ZHRjwJch2yGlHmCfgqw0RPEqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEpQLZqN6G+QX3iRUWyMPUHsLreSa41pFjLo0yvICsqoVtgZQNv1juIjd1yeHum9d1g7EO83v1FUGMr3pZXqj2/st0GCDfH8k2kSkops/UK2kdJUMdtw6jv8G3UMos6NrYiPHk2xDXIFntI3N3Jt+BGt5iKucMlsLo7C8tSXdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=Dz+3z4rS; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Skjiwb0oZtpTfSkjjw9YQF; Fri, 29 May 2026 02:06:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1780013163; bh=GZI4QoJ6lE3r080oo9ZHRjwJch2yGlHmCfgqw0RPEqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=Dz+3z4rSpvekBOFNIyIwXifSvNeCHsNfPBXOBNhF+v6qhBowEU6zZJ+qXebIU3scd
	 ECzz9gLo9RrFwRBE2bzGfXIj6Pg6fSSwh0kGLlbyQ+kGVjoh4CpTLs5gDVTyVm5D0D
	 Ls/0p8G2bZ0D6j3R0C9NNd55oJo5I71ME6kw7HRUhFXrbAdioNWg/38cpJTkMLGNsu
	 6kOGnmikOg7CYalUEMZQd7z1/HiS3byLTtLnTmj3OLNuD4DcHOaEsF2XpiKw5pluO6
	 WEuzn/mmyJ7jSdlDmdQYRa7M3W3d43oRgWCbS11k2AjzGreleFsUpgfpSGbcY9R8Yp
	 eX2kZiQtiI28A==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Fri, 29 May 2026 02:06:02 +0200
Subject: [PATCH 4/4] bus: add BCM6362 on-chip WLAN SHIM bridge driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-add-bcm6362-wlan-v1-4-722242777f58@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37079-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C47F15FB991
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the bridge driver that brings up the BCM6362 on-chip WLAN SHIM
and then populates a brcm,bus-axi child whose backplane is
enumerated by drivers/bcma/host_soc.c.

Add myself as MANTAINER for this shim.

After mapping the SHIM peephole, preparing the clock, and toggling
the SHIM and ubus resets, the driver runs the macro-enable sequence
taken from the OEM BCM6362 SDK setup.c. It then constructs a struct
bcma_host_soc_pdata - with big_endian and shim_attached set, and
shim_iomem pointing at the already-mapped SHIM peephole - and hands
it to the brcm,bus-axi child by registering an of_dev_auxdata entry
keyed on the "brcm,bus-axi" compatible. of_platform_populate() then
creates the child platform_device with the pdata attached, and
bcma-host-soc consumes it during its probe.

The auxdata-based handoff was chosen over a second per-SoC
bcma-host-soc DT compatible to keep the SoC-specific knowledge in
the SHIM driver, where the SHIM register layout already lives, and
to avoid duplicating the SHIM base address between the DT and the
bcma driver. Using of_platform_populate() rather than a synthesized
platform_device preserves the DT IRQ machinery: the bcma child's
of_node carries the standard interrupt-map that bcma_of_get_irq()
walks to resolve per-core IRQs.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 MAINTAINERS                     |   7 ++
 drivers/bus/Kconfig             |  13 +++
 drivers/bus/Makefile            |   1 +
 drivers/bus/bcm6362-wlan-shim.c | 252 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..4032bd6b9cfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5109,6 +5109,13 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/gadget/udc/bcm63xx_udc.*
 
+BROADCOM BCM6362 WLAN SHIM BRIDGE DRIVER
+M:	Alessio Ferri <alessio.ferri@mythread.it>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml
+F:	drivers/bus/bcm6362-wlan-shim.c
+
 BROADCOM BCM7XXX ARM ARCHITECTURE
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3181d8aa32a3..e992a34c5230 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -29,6 +29,19 @@ config ARM_INTEGRATOR_LM
 	  Say y here to enable support for the ARM Logic Module bus
 	  found on the ARM Integrator AP (Application Platform)
 
+config BCM6362_WLAN_SHIM
+	tristate "BCM6362 on-chip WLAN SHIM bridge"
+	depends on BMIPS_GENERIC || COMPILE_TEST
+	depends on OF
+	select BCMA
+	select BCMA_HOST_SOC
+	help
+	  Bring-up driver for the SHIM bridge that gates the integrated
+	  2.4 GHz WLAN block of the BCM6362 SoC. The driver releases the
+	  SHIM from reset, configures clocks, and then instantiates a
+	  bcma-host-soc child platform device whose bcma backplane is
+	  enumerated by the bcma driver.
+
 config BRCMSTB_GISB_ARB
 	tristate "Broadcom STB GISB bus arbiter"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index a01f97fef3e8..4b24ce0137fc 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 obj-$(CONFIG_ARM_INTEGRATOR_LM)	+= arm-integrator-lm.o
 obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+obj-$(CONFIG_BCM6362_WLAN_SHIM)	+= bcm6362-wlan-shim.o
 obj-$(CONFIG_MOXTET)		+= moxtet.o
 
 # DPAA2 fsl-mc bus
diff --git a/drivers/bus/bcm6362-wlan-shim.c b/drivers/bus/bcm6362-wlan-shim.c
new file mode 100644
index 000000000000..a2de03cf8ff7
--- /dev/null
+++ b/drivers/bus/bcm6362-wlan-shim.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BCM6362 on-chip WLAN SHIM bridge driver.
+ *
+ * The BCM6362 integrates a Broadcom 2.4 GHz WLAN block whose register
+ * backplane is a Broadcom AMBA (AXI/OCP) - what the bcma driver calls
+ * "brcm,bus-axi". The backplane sits on the SoC ubus, behind a small
+ * "SHIM" bridge that gates clocks and holds the WLAN macro in reset
+ * until released by software. CFE does not bring this block up.
+ *
+ *   ubus  ─┬─►  WLAN SHIM  ─►  AXI backplane  ┬─► ChipCommon
+ *          │    @ 0x10007000  @ 0x10004000    ├─► d11 MAC core
+ *          │                                  └─► (PMU, GPIO live in
+ *          │                                       ChipCommon)
+ *          └─►  rest of the SoC
+ *
+ * This driver brings the SHIM up (clocks, resets, the OEM enable
+ * sequence) and then calls of_platform_populate() on its DT node. The
+ * "brcm,bus-axi" child is bound by drivers/bcma/host_soc.c, and the
+ * SoC-specific configuration that bcma needs (big-endian backplane,
+ * SHIM-attached topology, and an already-mapped pointer to the SHIM
+ * Control register peephole) is delivered to it via of_dev_auxdata
+ * platform_data injected at populate time.
+ *
+ * Bring-up sequence and SHIM register layout match the OEM source
+ * arch/mips/bcm963xx/setup.c and the WlanShimRegs struct in
+ * shared/opensource/include/bcm963xx/6362_map_part.h. The fake-PCI
+ * dance the OEM kernel does after bring-up is intentionally absent
+ * here: bcma host_soc.c speaks to the backplane natively, in
+ * big-endian, via the pdata-supplied configuration.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_data/bcma_host_soc.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* SHIM register layout (struct WlanShimRegs in 6362_map_part.h). */
+#define SHIM_MISC		0x00
+#define   SHIM_FORCE_CLK_ON	BIT(2)
+#define   SHIM_MACRO_DISABLE	BIT(1)
+#define   SHIM_MACRO_SOFT_RESET	BIT(0)
+#define SHIM_STATUS		0x04
+#define SHIM_CC_CONTROL		0x08
+#define SHIM_CC_STATUS		0x0c
+#define SHIM_MAC_CONTROL	0x10
+#define   SICF_FGC		BIT(1)	/* force gated clock */
+#define   SICF_CLOCK_EN		BIT(0)
+#define SHIM_MAC_STATUS		0x14
+#define SHIM_CC_ID_A		0x18
+#define SHIM_MAC_ID_A		0x24
+
+struct bcm6362_wlan {
+	struct device		*dev;
+	void __iomem		*shim;
+	struct clk		*clk;
+	struct reset_control	*rst_shim;
+	struct reset_control	*rst_shim_ubus;
+
+	/* Storage for the pdata pointer handed to bcma via of_dev_auxdata.
+	 * of_platform_device_create_pdata() stores a pointer to this
+	 * struct on the bcma child device's platform_data field, so it
+	 * must outlive the child. devm_kzalloc on priv guarantees this:
+	 * the child is depopulated in remove() before devres frees priv.
+	 */
+	struct bcma_host_soc_pdata pdata;
+};
+
+static int bcm6362_wlan_bringup(struct bcm6362_wlan *priv)
+{
+	int ret;
+
+	dev_info(priv->dev, "bring-up: start\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(priv->dev, "clk_prepare_enable failed: %d\n", ret);
+		return ret;
+	}
+	dev_info(priv->dev, "bring-up: clock enabled, rate=%lu Hz\n",
+		 clk_get_rate(priv->clk));
+	mdelay(10);
+
+	/* Reset toggle (brcm,bcm6345-reset hides the active-low softResetB
+	 * encoding, so assert/deassert read naturally here).
+	 */
+	reset_control_assert(priv->rst_shim_ubus);
+	reset_control_assert(priv->rst_shim);
+	mdelay(1);
+	reset_control_deassert(priv->rst_shim_ubus);
+	reset_control_deassert(priv->rst_shim);
+	mdelay(1);
+	dev_info(priv->dev, "bring-up: reset toggled\n");
+
+	/* The SHIM and the AXI backplane behind it are big-endian
+	 * peripherals on a big-endian MIPS CPU. The asymmetric-endian
+	 * writel() in this configuration byte-swaps the value (it
+	 * assumes a little-endian bus, typical for PCI), landing each
+	 * bit in the wrong position. iowrite32be() is a no-op transform
+	 * here (BE-to-BE) and writes the value the bring-up sequence
+	 * intends. Same story for the read-back diagnostics: readl()
+	 * would byte-swap on the way back.
+	 *
+	 * Force clocks on + hold WLAN macro in soft reset.
+	 */
+	iowrite32be(SHIM_FORCE_CLK_ON | SHIM_MACRO_SOFT_RESET,
+		    priv->shim + SHIM_MISC);
+	mdelay(1);
+
+	/* MAC core: force gated clock + clock enable (with reset held). */
+	iowrite32be(SICF_FGC | SICF_CLOCK_EN, priv->shim + SHIM_MAC_CONTROL);
+
+	/* Release macro soft reset, keep clocks forced. */
+	iowrite32be(SHIM_FORCE_CLK_ON, priv->shim + SHIM_MISC);
+
+	/* Drop the force, let normal gating take over. */
+	iowrite32be(0, priv->shim + SHIM_MISC);
+	iowrite32be(SICF_CLOCK_EN, priv->shim + SHIM_MAC_CONTROL);
+
+	/* Read-back diagnostics: if the backplane is alive these reflect
+	 * the values we just wrote (MISC=0, MAC_CONTROL=SICF_CLOCK_EN) and
+	 * the STATUS regs report sane non-zero core ids.
+	 */
+	dev_info(priv->dev,
+		 "bring-up: post-shim MISC=%08x STATUS=%08x CC_CTRL=%08x CC_STAT=%08x MAC_CTRL=%08x MAC_STAT=%08x\n",
+		 ioread32be(priv->shim + SHIM_MISC),
+		 ioread32be(priv->shim + SHIM_STATUS),
+		 ioread32be(priv->shim + SHIM_CC_CONTROL),
+		 ioread32be(priv->shim + SHIM_CC_STATUS),
+		 ioread32be(priv->shim + SHIM_MAC_CONTROL),
+		 ioread32be(priv->shim + SHIM_MAC_STATUS));
+	dev_info(priv->dev,
+		 "bring-up: CcIdA=%08x MacIdA=%08x (non-zero = backplane responsive)\n",
+		 ioread32be(priv->shim + SHIM_CC_ID_A),
+		 ioread32be(priv->shim + SHIM_MAC_ID_A));
+
+	return 0;
+}
+
+static void bcm6362_wlan_teardown(struct bcm6362_wlan *priv)
+{
+	iowrite32be(0, priv->shim + SHIM_MAC_CONTROL);
+	iowrite32be(SHIM_MACRO_DISABLE | SHIM_MACRO_SOFT_RESET,
+		    priv->shim + SHIM_MISC);
+	reset_control_assert(priv->rst_shim);
+	reset_control_assert(priv->rst_shim_ubus);
+	clk_disable_unprepare(priv->clk);
+}
+
+static int bcm6362_wlan_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct of_dev_auxdata auxdata[2];
+	struct bcm6362_wlan *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	priv->shim = devm_platform_ioremap_resource_byname(pdev, "shim");
+	if (IS_ERR(priv->shim))
+		return PTR_ERR(priv->shim);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->rst_shim = devm_reset_control_get_exclusive(dev, "shim");
+	if (IS_ERR(priv->rst_shim))
+		return PTR_ERR(priv->rst_shim);
+
+	priv->rst_shim_ubus = devm_reset_control_get_exclusive(dev,
+							       "shim-ubus");
+	if (IS_ERR(priv->rst_shim_ubus))
+		return PTR_ERR(priv->rst_shim_ubus);
+
+	ret = bcm6362_wlan_bringup(priv);
+	if (ret) {
+		dev_err(dev, "WLAN bring-up failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Configure pdata in storage owned by priv. Used by
+	 * of_platform_populate() below and dereferenced by bcma at
+	 * runtime via dev_get_platdata().
+	 */
+	priv->pdata.big_endian	  = true;
+	priv->pdata.shim_attached = true;
+	priv->pdata.shim_iomem	  = priv->shim;
+
+	/* Inject pdata into the brcm,bus-axi child at populate time.
+	 * phys_addr 0 matches by compatible only; there is exactly one
+	 * brcm,bus-axi child under this node. of_platform_populate()
+	 * triggers the bcma probe synchronously - if bcma is built-in
+	 * (or already loaded as a module - see MODULE_SOFTDEP below)
+	 * it has matched and configured itself before we return here.
+	 */
+	auxdata[0] = (struct of_dev_auxdata)
+		OF_DEV_AUXDATA("brcm,bus-axi", 0, NULL, &priv->pdata);
+	memset(&auxdata[1], 0, sizeof(auxdata[1]));
+
+	ret = of_platform_populate(dev->of_node, NULL, auxdata, dev);
+	if (ret) {
+		dev_err(dev, "failed to populate bcma child: %d\n", ret);
+		bcm6362_wlan_teardown(priv);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static void bcm6362_wlan_remove(struct platform_device *pdev)
+{
+	struct bcm6362_wlan *priv = platform_get_drvdata(pdev);
+
+	/* Tear bcma down first: the bcma child uses priv->shim through
+	 * pdata->shim_iomem and its lifetime is owned here.
+	 * of_platform_depopulate() is synchronous - by the time it
+	 * returns, bcma has released the SHIM mapping.
+	 */
+	of_platform_depopulate(&pdev->dev);
+	bcm6362_wlan_teardown(priv);
+}
+
+static const struct of_device_id bcm6362_wlan_match[] = {
+	{ .compatible = "brcm,bcm6362-wlan", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcm6362_wlan_match);
+
+static struct platform_driver bcm6362_wlan_driver = {
+	.probe	= bcm6362_wlan_probe,
+	.remove	= bcm6362_wlan_remove,
+	.driver	= {
+		.name		= "bcm6362-wlan",
+		.of_match_table	= bcm6362_wlan_match,
+	},
+};
+module_platform_driver(bcm6362_wlan_driver);
+
+MODULE_SOFTDEP("pre: bcma");
+MODULE_AUTHOR("Alessio Ferri <alessio.ferri@mythread.it>");
+MODULE_DESCRIPTION("BCM6362 on-chip WLAN SHIM bridge driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0


