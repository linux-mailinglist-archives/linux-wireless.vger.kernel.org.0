Return-Path: <linux-wireless+bounces-36601-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOSNJYb6Cmpd+wQAu9opvQ
	(envelope-from <linux-wireless+bounces-36601-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:39:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BD956BB77
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB4730038C7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D353F39CA;
	Mon, 18 May 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="NeG/Q3wv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F53F58D0
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104387; cv=none; b=biClw54Cd30udv18lhwzFmY4eL2Kzb4SUL+UTONlL7Fhzze4r3hdJayxxwHLFaHRcT03KjsJgpIQm00AjT+UBWRGePbrVzTVjkhTDDU5IXZ5ifwx99YX/4mwnEJ+uX7EVObCtUHKn+xAdQiqDJ+38eS5SNCMdYqV02YNA5aTD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104387; c=relaxed/simple;
	bh=JtIKq/g2MQypGhKKOldmwVEF4MW4Jxs6sWtTWjlRTD0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+7igIC4aanxsE5vvGQ2cdBXB2NZ58QBvck+pHrR/16HMk/u9j+jjLBQZ9TyQ+LBasE6c850Y3H6Bxk1iyugfYlqcudU6yU08IA5cobgviUP92ATOAsOccfZvSRgajqUIs828x6RUAwDBjanfaBQIhetioISzjj+nb7mmXbE9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=NeG/Q3wv; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id OwJywigXH0dL0OwJywoQsv; Mon, 18 May 2026 13:39:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779104382; bh=JtIKq/g2MQypGhKKOldmwVEF4MW4Jxs6sWtTWjlRTD0=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=NeG/Q3wvko3e1fziYsDhPuRoU/qAlM3yh6pUYO1QhSljuBzgPyW8Vc/OPWLcD8PXI
	 uJm6ONwOYjAq8J7S1qL0cqWTOFwO9shBlcBblxGXK1sbEv68/ILmizTnfwvUW5TsWQ
	 JTbPkzveDKyw8a6VDZ2T383dAPqXqKvGazEt5tRHyaqgrP1uRw8OZDqk8ETpm//anp
	 QX8eANWje8pxpqxpXiFYBxtr2dnt7PzZ8LyAgrNwcArbIYEqEfYSdFfcERKI+PK//R
	 sets5zfBJhzeBjOe/MrtXdt31xJfPNF96bUFpVgeEpr09r/F/o6VXSRzPzpvh0asIS
	 6ZlNZx6qHs/Ng==
Message-ID: <82d2ae7c-3913-4d1c-8e2f-f586c4196ce1@mythread.it>
Date: Mon, 18 May 2026 13:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 1/2] bcma: host_soc: support quirked big-endian SoC
 backplane
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org
References: <3e236bf0-5269-4631-8e56-1bc199c2f643@mythread.it>
In-Reply-To: <3e236bf0-5269-4631-8e56-1bc199c2f643@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDFKb149pB3nBMQpyFe8EtohjU3v4Ov4v8bmY+r+a4shjaqFQRDciQFQD9m3b+P4qDpRMMKT6cXvLwjQiqSMhhvPp9aG1uUL4UP/MSK8EuNsPjCIEnOx
 yVUxeNM/WnVP0RFIVoXw6GeUOeBlFuFd6mnbrKw/ZqtV6xQ+k0tUqZAVCxBAjmpBMLQ5CS0Hf248uECRWmjv7IV5p7alf4bI/j92BimVBPmTPbLl3ma95ETo
 fqMQ8sRj6KQLW/E/caSJJJBIHSAI2BfhrAMUKEEIBgA=
X-Rspamd-Queue-Id: 02BD956BB77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36601-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mythread.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mythread.it:email,mythread.it:mid,mythread.it:dkim]
X-Rspamd-Action: no action

bcma_host_soc currently assumes the PCI/MIPS-LE layout: little-
endian MMIO and a populated io_wrap on every core. On a SHIM-
attached backplane both assumptions fail. Add the minimal
infrastructure to host_soc for this class of SoC:

  * A big-endian accessor set covering read16/32, write16/32,
    aread32 and awrite32. read8/write8 are byte accesses and
    endian-agnostic, so the LE helpers are reused.
    block_read/block_write are intentionally omitted -
    CONFIG_BCMA_BLOCKIO is not set on the targets that need this.

  * A wrapper-register synthesizer reached when core->io_wrap is
    NULL. It maps BCMA_IOCTL and BCMA_RESET_CTL accesses on the
    ChipCommon and 802.11 cores to the SHIM Control register.
    SICF_* bits in the SHIM Control register are bit-for-bit
    BCMA_IOCTL; SICF_WOC_CORE_RESET (bit 16) is the per-core
    wrapper RESET_CTL bit 0 promoted into the same register.
    BCMA_IOST for the 802.11 core is hard-coded to a stable value
    rather than synthesized from the SHIM Status register because
    the latter's SISF_CORE_BITS field is unreliable while the d11
    is in reset (observed: MacStatus=0x1008 on a disabled d11,
    where the "2G_PHY" indicator bit 0 is clear, which would
    steer b43 down a nonexistent 5 GHz path).

  * struct bcma_host_soc_quirks selected by DT compatible string
    via of_device_get_match_data(). The default quirks block keeps
    the existing brcm,bus-axi behaviour (LE, no SHIM, NMW=NSW=0
    cores rejected); a second quirks block selects the BE accessor
    set, sets bus->shim_attached and supplies the SHIM peephole
    physical base for ioremap. The new "brcm,bcm6362-bus-axi" and
    "brcm,bcm63268-bus-axi" compatibles map to the SHIM quirks.

  * struct bcma_bus gains three fields populated from quirks data:
    big_endian (consumed by scan.c on the mini-EROM reads),
    shim_attached (consumed by the companion scan.c patch to allow
    NMW=NSW=0 cores through), and shim_iomem (the mapped SHIM
    peephole used by the synthesizer).

scan.c's bcma_scan_read32 and bcma_erom_get_ent now branch on
bus->big_endian: a BE backplane otherwise reads the mini-EROM with
the wrong endianness and bcma_get_next_core() bails out on
nonsense component IDs before any of the new code paths matter.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/bcma/host_soc.c   | 243 +++++++++++++++++++++++++++++++++++++-
 drivers/bcma/scan.c       |   4 +-
 include/linux/bcma/bcma.h |  10 ++
 3 files changed, 254 insertions(+), 3 deletions(-)

diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
index 20b1816c5..964ff84fc 100644
--- a/drivers/bcma/host_soc.c
+++ b/drivers/bcma/host_soc.c
@@ -165,6 +165,224 @@ static const struct bcma_host_ops bcma_host_soc_ops = {
 	.awrite32	= bcma_host_soc_awrite32,
 };
 
+/* SHIM peephole layout (subset of WlanShimRegs). SICF_* bits in the
+ * per-core Control register are bit-for-bit BCMA_IOCTL; bit 16
+ * (SICF_WOC_CORE_RESET) is the per-core wrapper RESET_CTL bit 0
+ * promoted into the SHIM Control register. CC is ChipCommon, MAC is
+ * the IEEE 802.11 core.
+ */
+#define BCMA_SHIM_CC_CONTROL		0x08
+#define BCMA_SHIM_MAC_CONTROL		0x10
+#define	  SICF_WOC_CORE_RESET		0x10000
+
+/* Resolve the SHIM Control register for a given core (CcControl for
+ * ChipCommon, MacControl for the 802.11 core). Returns NULL for any
+ * other core, including the SHIM core itself - the SHIM has been
+ * running since boot and needs no gating from bcma_core_enable().
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
+	u32 sicf;
+
+	switch (offset) {
+	case BCMA_IOCTL:
+		/* Low 16 bits of the SHIM Control register map bit-for-bit
+		 * to BCMA_IOCTL. Returning the live value lets
+		 * bcma_core_is_enabled() observe a prior disable that
+		 * cleared CLOCK_EN/FGC. For cores not in the SHIM map
+		 * (e.g. the SHIM core itself) return BCMA_IOCTL_CLK so the
+		 * core is treated as already-up; the SHIM has been running
+		 * since boot and has nothing to enable.
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
+		 * Other cores have no defined IOST bits of interest here.
+		 */
+		if (core->id.id == BCMA_CORE_80211)
+			return 0x01 | BCMA_IOST_DMA64;
+		return 0;
+
+	case BCMA_RESET_CTL:
+		/* SICF_WOC_CORE_RESET is the wrapper RESET_CTL bit 0 in
+		 * the SHIM Control register.
+		 */
+		if (ctrl_reg) {
+			sicf = ioread32be(ctrl_reg);
+			return (sicf & SICF_WOC_CORE_RESET) ? 1 : 0;
+		}
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
+	/* No routing applies: surface as info so unexpected accesses are
+	 * visible without DYNAMIC_DEBUG.
+	 */
+	pr_info("bcma: synth awrite32 dropped on core idx=%u id=0x%x offset=0x%03x value=0x%08x\n",
+		core->core_index, core->id.id, offset, value);
+}
+
+/* Big-endian accessor variants for SoCs whose AXI backplane sits on a
+ * big-endian peripheral bus (BMIPS xDSL family). read8/write8 are
+ * endian-agnostic byte accesses and reuse the LE helpers above.
+ * 16/32-bit pairs use ioread/iowrite *be helpers. block_read/write
+ * are intentionally omitted: CONFIG_BCMA_BLOCKIO is not set on this
+ * target. aread32/awrite32 dispatch to the synthesizer when
+ * core->io_wrap is NULL (legitimate on SHIM-attached cores; that
+ * NULL state is allow-listed in scan.c by a companion patch).
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
+/* Per-SoC quirks selected by DT compatible string. */
+struct bcma_host_soc_quirks {
+	const struct bcma_host_ops *ops;
+	bool big_endian;
+	bool shim_attached;
+	phys_addr_t shim_base;
+	size_t shim_size;
+};
+
+static const struct bcma_host_soc_quirks bcma_host_soc_quirks_default = {
+	.ops		= &bcma_host_soc_ops,
+};
+
+static const struct bcma_host_soc_quirks bcma_host_soc_quirks_brcm_shim = {
+	.ops		= &bcma_host_soc_ops_brcm_shim,
+	.big_endian	= true,
+	.shim_attached	= true,
+	.shim_base	= 0x10007000,
+	.shim_size	= 0x100,
+};
+
+
 int __init bcma_host_soc_register(struct bcma_soc *soc)
 {
 	struct bcma_bus *bus = &soc->bus;
@@ -176,9 +394,25 @@ int __init bcma_host_soc_register(struct bcma_soc *soc)
 	if (!bus->mmio)
 		return -ENOMEM;
 
+	quirks = of_device_get_match_data(dev);
+	if (!quirks)
+		quirks = &bcma_host_soc_quirks_default;
+
 	/* Host specific */
 	bus->hosttype = BCMA_HOSTTYPE_SOC;
-	bus->ops = &bcma_host_soc_ops;
+	bus->ops = quirks->ops;
+	bus->big_endian = quirks->big_endian;
+	bus->shim_attached = quirks->shim_attached;
+
+	if (quirks->shim_base) {
+		bus->shim_iomem = ioremap(quirks->shim_base, quirks->shim_size);
+		if (!bus->shim_iomem) {
+			dev_err(dev, "failed to ioremap SHIM peephole @ %pap\n",
+				&quirks->shim_base);
+			err = -ENOMEM;
+			goto err_unmap_mmio;
+		}
+	}
 
 	/* Initialize struct, detect chip */
 	bcma_init_bus(bus);
@@ -202,6 +436,7 @@ int __init bcma_host_soc_init(struct bcma_soc *soc)
 #ifdef CONFIG_OF
 static int bcma_host_soc_probe(struct platform_device *pdev)
 {
+	const struct bcma_host_soc_quirks *quirks;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct bcma_bus *bus;
@@ -245,12 +480,16 @@ static void bcma_host_soc_remove(struct platform_device *pdev)
 	struct bcma_bus *bus = platform_get_drvdata(pdev);
 
 	bcma_bus_unregister(bus);
+	if (bus->shim_iomem)
+		iounmap(bus->shim_iomem);
 	iounmap(bus->mmio);
 	platform_set_drvdata(pdev, NULL);
 }
 
 static const struct of_device_id bcma_host_soc_of_match[] = {
-	{ .compatible = "brcm,bus-axi", },
+	{ .compatible = "brcm,bcm6362-bus-axi",  .data = &bcma_host_soc_quirks_brcm_shim },
+	{ .compatible = "brcm,bcm63268-bus-axi", .data = &bcma_host_soc_quirks_brcm_shim },
+	{ .compatible = "brcm,bus-axi",          .data = &bcma_host_soc_quirks_default  },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcma_host_soc_of_match);
diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 84742408a..983a62dde 100644
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
index 60b94b944..f41616ba2 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -362,6 +362,16 @@ struct bcma_bus {
 	/* We decided to share SPROM struct with SSB as long as we do not need
 	 * any hacks for BCMA. This simplifies drivers code. */
 	struct ssb_sprom sprom;
+
+	/* SoC quirks populated from host_soc per-compatible match data.
+	 * big_endian selects ioread*be/iowrite*be on the scan and accessor
+	 * paths; shim_attached tells scan.c that wrapper-less cores (NMW=
+	 * NSW=0) are legitimate on this backplane and routes IOCTL/
+	 * RESET_CTL through the SHIM Control register via shim_iomem.
+	 */
+	bool big_endian;
+	bool shim_attached;
+	void __iomem *shim_iomem;
 };
 
 static inline u32 bcma_read8(struct bcma_device *core, u16 offset)
-- 
2.43.0


