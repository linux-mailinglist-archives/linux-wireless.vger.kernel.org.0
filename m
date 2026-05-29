Return-Path: <linux-wireless+bounces-37080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP3FEFjZGGpDoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:10:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D87375FB9B7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 843F03044A6E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA224502A;
	Fri, 29 May 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="QMosyoPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D717D2
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013355; cv=none; b=taQNxCHs5JwZhpPVefoVMoApi82FXwuaqlLXibe8q03ONgB5Uo7uB4bCRWS5sJ3fvFmTJMIZezkYTctfAW2B6mNTzXgrfD86cNHtOwuk7HpzbtCaUcO4CJQKDXzuUldGOVbes11Vd4+jXqlnxHKvF3Y5z149FRrowURGiSgV948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013355; c=relaxed/simple;
	bh=0BDzmRbguSTWh4g30KCuCQo1zkNgrMFY4/7MyycAsuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUGyXbVWN1INhCFBAA+PDxrLROcD889ofGnYTaTZw3HoYlvhaTdp14dgcfsRBaER0AByRNRsqvdVa8vW/Xwx044fxdpFm2SNhrtE5LGhsLfT63h1p25jIxt1sh9wkL93ck0MSYnE5MVKfwUql7IQcugRyBVzCqfR1hB9gmWDOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=QMosyoPI; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Skjiwb0oZtpTfSkjiw9YOz; Fri, 29 May 2026 02:06:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1780013162; bh=0BDzmRbguSTWh4g30KCuCQo1zkNgrMFY4/7MyycAsuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=QMosyoPIqC/rGlGMQWgDRCzzefyiZW3P40vaQ75uXEzLBf70kmOQ4dfDsRklgXpWt
	 s6vuB1vfu5Jbd/hvAG5X2MwfHzRWFQtZ8JSG2zCLzpGjSPrteRCGQmZtgRoAC5nZ0S
	 mF7G84VPHZrsK+4UNpzDOnXvI8EXcDUa5BzlMvYbR/iwNr8GyvFjY/cj1eH3gqNWhM
	 sEZJCUR9Mifbj5Eh+uvLsNOtU3ray30iqzPXOv4ktJQEofErKRgOwxX+kyn0BXcha1
	 B6pDw1nAlhQKYz3Zh6J+6WSUXkdIbLo64AI6d+RbG2EN5W8t4JcCpvxomlR54fivA9
	 USrXlwHwNkNVA==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Fri, 29 May 2026 02:05:59 +0200
Subject: [PATCH 1/4] bcma: support driver specific quirks from soc pdata
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-add-bcm6362-wlan-v1-1-722242777f58@gmail.com>
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
X-CMAE-Envelope: MS4xfEqJjOvyNZ7IZw8V1bFtR0LGeea5ChksvNZ/vFRqWLblRWonEW4o1mQgGMKGBkzXg9MbUUlCThxHNDCAI5EXMQwRXBpru5vfb3sv8WzT+dBswgBcmRGg
 7IoMBI8WbC8Uo+a/V6XsFFbR5zJoUAdvH0m3+PaInfTSCKpOSGk/xKgX5QDr4I236FRUXZEpZ4Q0Rp/WCotHtH5iqfsUmXSx5RmIkps90Paav5D/n+X2GOsZ
 EFT1+AT0PWzkojKg/0tf7d9RRjhqoMoRoGid0EBf4g0BAsEZjyUgsXUrKEmc2353OdOTyuC9ykaeEnFuTLAW7NEfxWKSnsCg1pjvrVHFNwTjXglL+PBfMDCc
 QJQ+0NEKRuaNxt1D+VJUvtfeJXQWdhh+tPUwQi07hgodLFWfgCEWgCNmUSG0i2rrLBs6ka5gY5+wnAaQf+RtQnPUi1OTDq7YKzG/LUnytlyhlWXm/dyuhN/H
 svFVNKdPo7XbiS8qxGOMmt6vBo0EG9SRPAZfBpplSiItqoV8MuN4/LK8550=
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
	TAGGED_FROM(0.00)[bounces-37080-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: D87375FB9B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some BMIPS xDSL SoCs (BCM6362, BCM63268) integrate a Broadcom 802.11
backplane that is reachable through bcma but differs from the BCM47xx
SoCs the host_soc driver was originally written for in two ways:

  1. The AXI backplane sits on a big-endian peripheral bus on a
     big-endian CPU. readl()/writel() perform an asymmetric byte swap
     in this configuration and land each bit in the wrong position
     inside the peripheral;

  2. Per-core DMP wrappers (NMW/NSW != 0) do not exist for the cores
     that bcma needs to gate (ChipCommon, the 802.11 core, and the
     SHIM core itself). Clock and reset control instead lives in a
     small SoC-level "SHIM" Control register peephole. BCMA_IOCTL and
     BCMA_RESET_CTL accesses on those cores must be synthesized
     against the SHIM Control register.

The brcm,bus-axi DT path is unchanged.
SoCs with those constraints instantiate bcma-host-soc programmatically
from a parent bridge driver (e.g. the BCM6362 WLAN SHIM bridge, added
in a later patch), supplying a struct bcma_host_soc_pdata that selects
big-endian accessors and provides an already-mapped pointer to the SHIM
Control register peephole.

Internal changes in this patch:

  - Add include/linux/platform_data/bcma_host_soc.h carrying the new
    pdata structure (big_endian, shim_attached, shim_iomem).
  - Add big_endian, shim_attached and shim_iomem fields to
    struct bcma_bus.
  - In drivers/bcma/host_soc.c, add a parallel set of BE accessors
    (read16/read32/write16/write32 and aread32/awrite32) plus a
    synth path that routes BCMA_IOCTL and BCMA_RESET_CTL accesses on
    wrapper-less cores through the SHIM Control register. The new
    bcma_host_soc_ops_brcm_shim ops table groups them.
  - bcma_host_soc_probe() now reads pdata (when present) and selects
    big-endian ops + SHIM routing accordingly. bus->mmio is mapped
    via devm_platform_ioremap_resource() so the same code path works
    whether the platform_device came from DT (resource via reg
    property) or was synthesized by a parent (resource passed in
    platform_device_info::res).
  - In drivers/bcma/scan.c, bcma_scan_read32() and
    bcma_erom_get_ent() honour bus->big_endian.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/bcma/host_soc.c                     | 224 ++++++++++++++++++++++++++--
 drivers/bcma/scan.c                         |   4 +-
 include/linux/bcma/bcma.h                   |  14 ++
 include/linux/platform_data/bcma_host_soc.h |  31 ++++
 4 files changed, 260 insertions(+), 13 deletions(-)

diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
index 20b1816c570b..f39129fb9cf2 100644
--- a/drivers/bcma/host_soc.c
+++ b/drivers/bcma/host_soc.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/platform_data/bcma_host_soc.h>
 #include <linux/bcma/bcma.h>
 #include <linux/bcma/bcma_soc.h>
 
@@ -165,6 +166,195 @@ static const struct bcma_host_ops bcma_host_soc_ops = {
 	.awrite32	= bcma_host_soc_awrite32,
 };
 
+/* SHIM peephole layout, subset of the OEM "WlanShimRegs" struct: only
+ * the per-core Control registers are needed for IOCTL / RESET_CTL
+ * routing. The low 16 bits of each Control register map bit-for-bit to
+ * BCMA_IOCTL; bit 16 (SICF_WOC_CORE_RESET) is the per-core wrapper
+ * BCMA_RESET_CTL bit 0 promoted into the SHIM Control register.
+ */
+#define BCMA_SHIM_CC_CONTROL		0x08
+#define BCMA_SHIM_MAC_CONTROL		0x10
+#define   SICF_WOC_CORE_RESET		0x10000
+
+/* Resolve the SHIM Control register for a given core: ChipCommon and
+ * the IEEE 802.11 core. Returns NULL for any other core, including the
+ * SHIM core itself - the SHIM has been running since boot and needs no
+ * gating from bcma_core_enable().
+ */
+static void __iomem *bcma_host_soc_shim_ctrl_reg(struct bcma_device *core)
+{
+	void __iomem *shim = core->bus->shim_iomem;
+
+	if (!shim)
+		return NULL;
+
+	switch (core->id.id) {
+	case BCMA_CORE_CHIPCOMMON:
+		return shim + BCMA_SHIM_CC_CONTROL;
+	case BCMA_CORE_80211:
+		return shim + BCMA_SHIM_MAC_CONTROL;
+	}
+	return NULL;
+}
+
+/* Synthesize wrapper-register responses for cores whose DMP wrapper
+ * space does not exist in the standard bcma layout. On SoCs that
+ * publish a SHIM-style mini-EROM (BMIPS xDSL family: BCM6362, ...)
+ * ChipCommon and the 802.11 core report NMW=NSW=0; clock and reset
+ * gating happens in the SHIM's per-core Control register, which is
+ * where this synth routes BCMA_IOCTL and BCMA_RESET_CTL accesses.
+ */
+static u32 bcma_host_soc_synth_aread32(struct bcma_device *core, u16 offset)
+{
+	void __iomem *ctrl_reg = bcma_host_soc_shim_ctrl_reg(core);
+
+	switch (offset) {
+	case BCMA_IOCTL:
+		/* Low 16 bits of the SHIM Control register map bit-for-bit
+		 * to BCMA_IOCTL. Returning the live value lets
+		 * bcma_core_is_enabled() observe a prior disable that
+		 * cleared CLOCK_EN/FGC. For cores not in the SHIM map
+		 * (e.g. the SHIM core itself) return BCMA_IOCTL_CLK so
+		 * the core is treated as already-up; the SHIM has been
+		 * running since boot and has nothing to enable.
+		 */
+		if (ctrl_reg)
+			return ioread32be(ctrl_reg) & 0xFFFF;
+		return BCMA_IOCTL_CLK;
+
+	case BCMA_IOST:
+		/* IOST is synthesized rather than read from the SHIM
+		 * Status register: while the d11 is in reset, MacStatus's
+		 * SISF_CORE_BITS field is unreliable (observed: 0x1008 on
+		 * a disabled d11, where the "2G_PHY" indicator bit 0 is
+		 * clear, which would steer b43 down a nonexistent 5 GHz
+		 * path on a 2.4 GHz-only single-die part).
+		 *
+		 * Synthesize a stable IOST for the 802.11 core:
+		 *   bit 0  (2G_PHY)         = 1   single-die 2.4 GHz
+		 *   bit 1  (5G_PHY)         = 0   no 5 GHz radio wired
+		 *   bit 12 (BCMA_IOST_DMA64)= 1   corerev 22 is DMA64
+		 *
+		 * Other cores have no defined IOST bits of interest.
+		 */
+		if (core->id.id == BCMA_CORE_80211)
+			return 0x01 | BCMA_IOST_DMA64;
+		return 0;
+
+	case BCMA_RESET_CTL:
+		/* SICF_WOC_CORE_RESET is the wrapper RESET_CTL bit 0 in
+		 * the SHIM Control register.
+		 */
+		if (ctrl_reg)
+			return (ioread32be(ctrl_reg) & SICF_WOC_CORE_RESET) ? 1 : 0;
+		return 0;
+
+	case BCMA_RESET_ST:
+		/* No "reset pending" semantics in the SHIM Control reg. */
+		return 0;
+
+	default:
+		pr_info("bcma: synth aread32 unhandled offset 0x%03x on core idx=%u id=0x%x\n",
+			offset, core->core_index, core->id.id);
+		return 0;
+	}
+}
+
+static void bcma_host_soc_synth_awrite32(struct bcma_device *core,
+					 u16 offset, u32 value)
+{
+	void __iomem *ctrl_reg = bcma_host_soc_shim_ctrl_reg(core);
+	u32 cur, new_val;
+
+	if (ctrl_reg) {
+		switch (offset) {
+		case BCMA_IOCTL:
+			/* SICF low 16 bits == BCMA_IOCTL. Preserve
+			 * SICF_WOC_CORE_RESET (the RESET_CTL view) so an
+			 * IOCTL write does not accidentally release reset.
+			 */
+			cur = ioread32be(ctrl_reg);
+			new_val = (value & 0xFFFF) |
+				  (cur & SICF_WOC_CORE_RESET);
+			iowrite32be(new_val, ctrl_reg);
+			pr_debug("bcma: synth IOCTL core=0x%x SHIM %08x->%08x (req %08x)\n",
+				 core->id.id, cur, new_val, value);
+			return;
+		case BCMA_RESET_CTL:
+			cur = ioread32be(ctrl_reg);
+			if (value & 1)
+				new_val = cur | SICF_WOC_CORE_RESET;
+			else
+				new_val = cur & ~SICF_WOC_CORE_RESET;
+			iowrite32be(new_val, ctrl_reg);
+			pr_debug("bcma: synth RESET_CTL core=0x%x SHIM %08x->%08x (req %08x)\n",
+				 core->id.id, cur, new_val, value);
+			return;
+		}
+	}
+
+	pr_info("bcma: synth awrite32 dropped on core idx=%u id=0x%x offset=0x%03x value=0x%08x\n",
+		core->core_index, core->id.id, offset, value);
+}
+
+/* Big-endian accessor variants for SoCs whose AXI backplane sits on a
+ * big-endian peripheral bus (BMIPS xDSL family). read8/write8 are
+ * endian-agnostic byte accesses and reuse the LE helpers above.
+ * CONFIG_BCMA_BLOCKIO block_read/write are intentionally omitted: those
+ * targets do not enable block I/O. aread32/awrite32 dispatch to the
+ * synthesizer when core->io_wrap is NULL (legitimate on SHIM-attached
+ * cores; that NULL state is allow-listed in scan.c).
+ */
+static u32 bcma_host_soc_read32_be(struct bcma_device *core, u16 offset)
+{
+	return ioread32be(core->io_addr + offset);
+}
+
+static u16 bcma_host_soc_read16_be(struct bcma_device *core, u16 offset)
+{
+	return ioread16be(core->io_addr + offset);
+}
+
+static void bcma_host_soc_write32_be(struct bcma_device *core, u16 offset,
+				     u32 value)
+{
+	iowrite32be(value, core->io_addr + offset);
+}
+
+static void bcma_host_soc_write16_be(struct bcma_device *core, u16 offset,
+				     u16 value)
+{
+	iowrite16be(value, core->io_addr + offset);
+}
+
+static u32 bcma_host_soc_aread32_be(struct bcma_device *core, u16 offset)
+{
+	if (likely(core->io_wrap))
+		return ioread32be(core->io_wrap + offset);
+	return bcma_host_soc_synth_aread32(core, offset);
+}
+
+static void bcma_host_soc_awrite32_be(struct bcma_device *core, u16 offset,
+				      u32 value)
+{
+	if (likely(core->io_wrap)) {
+		iowrite32be(value, core->io_wrap + offset);
+		return;
+	}
+	bcma_host_soc_synth_awrite32(core, offset, value);
+}
+
+static const struct bcma_host_ops bcma_host_soc_ops_brcm_shim = {
+	.read8		= bcma_host_soc_read8,
+	.read16		= bcma_host_soc_read16_be,
+	.read32		= bcma_host_soc_read32_be,
+	.write8		= bcma_host_soc_write8,
+	.write16	= bcma_host_soc_write16_be,
+	.write32	= bcma_host_soc_write32_be,
+	.aread32	= bcma_host_soc_aread32_be,
+	.awrite32	= bcma_host_soc_awrite32_be,
+};
+
 int __init bcma_host_soc_register(struct bcma_soc *soc)
 {
 	struct bcma_bus *bus = &soc->bus;
@@ -202,8 +392,8 @@ int __init bcma_host_soc_init(struct bcma_soc *soc)
 #ifdef CONFIG_OF
 static int bcma_host_soc_probe(struct platform_device *pdev)
 {
+	struct bcma_host_soc_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct bcma_bus *bus;
 	int err;
 
@@ -214,14 +404,26 @@ static int bcma_host_soc_probe(struct platform_device *pdev)
 
 	bus->dev = dev;
 
-	/* Map MMIO */
-	bus->mmio = of_iomap(np, 0);
-	if (!bus->mmio)
-		return -ENOMEM;
+	/* Map MMIO. devm_platform_ioremap_resource() consumes the first
+	 * IORESOURCE_MEM regardless of whether it came from a DT reg
+	 * property (legacy brcm,bus-axi path) or from a synthesized
+	 * platform_device_info::res (SHIM-attached path).
+	 */
+	bus->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bus->mmio))
+		return PTR_ERR(bus->mmio);
 
 	/* Host specific */
 	bus->hosttype = BCMA_HOSTTYPE_SOC;
-	bus->ops = &bcma_host_soc_ops;
+	if (pdata) {
+		bus->big_endian    = pdata->big_endian;
+		bus->shim_attached = pdata->shim_attached;
+		bus->shim_iomem    = pdata->shim_iomem;
+		bus->ops = pdata->big_endian ? &bcma_host_soc_ops_brcm_shim
+					     : &bcma_host_soc_ops;
+	} else {
+		bus->ops = &bcma_host_soc_ops;
+	}
 
 	/* Initialize struct, detect chip */
 	bcma_init_bus(bus);
@@ -229,15 +431,11 @@ static int bcma_host_soc_probe(struct platform_device *pdev)
 	/* Register */
 	err = bcma_bus_register(bus);
 	if (err)
-		goto err_unmap_mmio;
+		return err;
 
 	platform_set_drvdata(pdev, bus);
 
 	return err;
-
-err_unmap_mmio:
-	iounmap(bus->mmio);
-	return err;
 }
 
 static void bcma_host_soc_remove(struct platform_device *pdev)
@@ -245,7 +443,9 @@ static void bcma_host_soc_remove(struct platform_device *pdev)
 	struct bcma_bus *bus = platform_get_drvdata(pdev);
 
 	bcma_bus_unregister(bus);
-	iounmap(bus->mmio);
+	/* bus->mmio is devm-managed; shim_iomem is borrowed from the
+	 * parent bridge driver and must not be unmapped here.
+	 */
 	platform_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 84742408a59c..983a62ddeebb 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -143,6 +143,8 @@ static const char *bcma_device_name(const struct bcma_device_id *id)
 
 static u32 bcma_scan_read32(struct bcma_bus *bus, u16 offset)
 {
+	if (bus->big_endian)
+		return ioread32be(bus->mmio + offset);
 	return readl(bus->mmio + offset);
 }
 
@@ -155,7 +157,7 @@ static void bcma_scan_switch_core(struct bcma_bus *bus, u32 addr)
 
 static u32 bcma_erom_get_ent(struct bcma_bus *bus, u32 __iomem **eromptr)
 {
-	u32 ent = readl(*eromptr);
+	u32 ent = bus->big_endian ? ioread32be(*eromptr) : readl(*eromptr);
 	(*eromptr)++;
 	return ent;
 }
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index 60b94b944e9f..aaa6c5674c2a 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -362,6 +362,20 @@ struct bcma_bus {
 	/* We decided to share SPROM struct with SSB as long as we do not need
 	 * any hacks for BCMA. This simplifies drivers code. */
 	struct ssb_sprom sprom;
+
+	/* SoC quirks populated from struct bcma_host_soc_pdata when a
+	 * SHIM-attached parent bridge driver instantiates the bcma-host-soc
+	 * child platform_device. big_endian selects ioread/iowrite *be
+	 * helpers on the scan and host_soc accessor paths; shim_attached
+	 * tells scan.c that wrapper-less cores (NMW=NSW=0) are legitimate
+	 * on this backplane; shim_iomem points at the SoC-level SHIM
+	 * Control register peephole that host_soc.c routes per-core
+	 * BCMA_IOCTL / BCMA_RESET_CTL accesses through. shim_iomem is
+	 * borrowed from the parent and must not be unmapped here.
+	 */
+	bool big_endian;
+	bool shim_attached;
+	void __iomem *shim_iomem;
 };
 
 static inline u32 bcma_read8(struct bcma_device *core, u16 offset)
diff --git a/include/linux/platform_data/bcma_host_soc.h b/include/linux/platform_data/bcma_host_soc.h
new file mode 100644
index 000000000000..e1e7c5acb574
--- /dev/null
+++ b/include/linux/platform_data/bcma_host_soc.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_PLATFORM_DATA_BCMA_HOST_SOC_H
+#define _LINUX_PLATFORM_DATA_BCMA_HOST_SOC_H
+
+#include <linux/types.h>
+
+/**
+ * struct bcma_host_soc_pdata - SoC-specific configuration for bcma-host-soc.
+ *
+ * Used by parent bridge drivers that instantiate bcma-host-soc as a child
+ * platform_device (e.g. the BCM6362 WLAN SHIM bridge). The legacy
+ * brcm,bus-axi DT path uses default values and does not supply this.
+ *
+ * @big_endian:    Backplane registers are big-endian peripherals on a
+ *                 big-endian CPU. Selects ioread/iowrite *be helpers for
+ *                 all bcma register accesses on this bus.
+ * @shim_attached: Cores on this backplane do not publish per-core DMP
+ *                 wrappers (NMW=NSW=0 in the EROM); clock and reset
+ *                 gating instead lives in a SoC-level "SHIM" Control
+ *                 register peephole reached through @shim_iomem.
+ * @shim_iomem:    Pre-mapped iomem pointer for the SHIM peephole.
+ *                 Lifetime is owned by the parent bridge driver; the
+ *                 bcma-host-soc driver must not iounmap it.
+ */
+struct bcma_host_soc_pdata {
+	bool		big_endian;
+	bool		shim_attached;
+	void __iomem	*shim_iomem;
+};
+
+#endif /* _LINUX_PLATFORM_DATA_BCMA_HOST_SOC_H */

-- 
2.54.0


