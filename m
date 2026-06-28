Return-Path: <linux-wireless+bounces-38215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GShwM+2PQGrfgAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 05:07:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA2C6D2FE1
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 05:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lu0VtDr5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38215-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38215-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E366301412D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DF262D0B;
	Sun, 28 Jun 2026 03:07:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AD4315F;
	Sun, 28 Jun 2026 03:07:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782616037; cv=none; b=InqEo5mzzUUapt0o1DsijPaxEZyaSPeeIfpgbu0YPSjd/5tbAVeyzzsGv4KTrnzqxrNEPduh1+/x8X8IoPsOTcwXal2DizcFUZp0q0I264eIw5iQZyLnIDDDTAsoSgN4epUPSrICNR7t3LxNx2NS1ta7BvZb8VUsmRfHn0Wsfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782616037; c=relaxed/simple;
	bh=Yo4L18fh7VvlYUxkirlUx93t9UYHughwTkMPL5DLwqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRNyH7P8x+bfboC2xBa4ClwUZntA4bZ3fMceeQOTu+ztX3z/iki26cHZHAWCWvyshjCybwQFujxmQTT+Hx2mb6orHVOComFfUho+8QqNWkpUk70D1ewsYOlH/YZMrBD1EMSHaaWTVFaoG7PT2k3YD4ykpypqqL8Jj8SQtzvCK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu0VtDr5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806041F000E9;
	Sun, 28 Jun 2026 03:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782616035;
	bh=vmkXcgYl+w/R1qnunR6PXyn5dCrixKgKvmxDaG58d0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lu0VtDr5h7i8BPVcYGWggTsEN1HWGUyBHpvQ+ivLYx+dwKxxVv5xx7QXxzB57eGKA
	 tO1DM6iQgNP1tPmAKEpwHtFMU3gtm+J0aiKZ3UeuHb42TPYr/ovLH/J2Ky23SD2BEt
	 Tfp+B7BWIfCZ1O8HuHB4/TNeCOSm5cErCo4mpcA9Ai7f4l52BGc11+mbvmL56cg+Qx
	 Ez/bZOyo0/uh8Fgd4oVjho1IWhDtQLJxC7CVJfQhQRWOP9VXl9qjsdBvYdQfqsA7vU
	 I0yU1daXd/kTOPks4tPmOmVRVq2h2LFqXyl549ZBSDLnNx4ME0H7Am1UDYvRQOg1NV
	 L5nBys3SveKpw==
Date: Sat, 27 Jun 2026 22:07:05 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: george.moussalem@outlook.com
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Saravana Kannan <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
Message-ID: <akCOYIIhyl738PC6@baldur>
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38215-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baldur:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CA2C6D2FE1

On Thu, Jun 25, 2026 at 06:10:06PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add support to bring up the M0 core of the bluetooth subsystem found in
> the IPQ5018 SoC.
> 
> The signed firmware loaded is authenticated by TrustZone. If successful,
> the M0 core boots the firmware and the peripheral is taken out of reset
> using a Secure Channel Manager call to TrustZone.
> 

The remoteproc framework deals with life cycle management of
coprocessors, but you don't want that - you want the BT driver to own
the life cycle.

Further, the fact that you split this in "BT" and "remoteproc", results
in you having two representations in DeviceTree and in the device model
for the same hardware.

I know we have examples of this in the kernel already, but they are all
racy...

Please see if you can embed the firmware loading, authentication and
PAS calls directly into the BT driver - to have a single entity managing
the life cycle of your M0 processor.

Regards,
Bjorn

> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/remoteproc/Kconfig            |  12 ++
>  drivers/remoteproc/Makefile           |   1 +
>  drivers/remoteproc/qcom_m0_btss_pil.c | 261 ++++++++++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c521c744e7db..6b52f78f1427 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -163,6 +163,18 @@ config PRU_REMOTEPROC
>  	  processors on various TI SoCs. It's safe to say N here if you're
>  	  not interested in the PRU or if you are unsure.
>  
> +config QCOM_M0_BTSS_PIL
> +	tristate "Qualcomm M0 BTSS Peripheral Image Loader"
> +	depends on OF && ARCH_QCOM
> +	select QCOM_MDT_LOADER
> +	select QCOM_RPROC_COMMON
> +	select QCOM_SCM
> +	help
> +	  Say y here to support the Secure Peripheral Imager Loader for the
> +	  Qualcomm Bluetooth Subsystem running on the M0 remote processor found
> +	  in the IPQ5018 SoC. The M0 core is started and stopped using a
> +	  Secure Channel Manager call to TrustZone.
> +
>  config QCOM_PIL_INFO
>  	tristate
>  
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 1c7598b8475d..df80faf8d0df 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>  obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
>  obj-$(CONFIG_MESON_MX_AO_ARC_REMOTEPROC)+= meson_mx_ao_arc.o
>  obj-$(CONFIG_PRU_REMOTEPROC)		+= pru_rproc.o
> +obj-$(CONFIG_QCOM_M0_BTSS_PIL)		+= qcom_m0_btss_pil.o
>  obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
>  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
> diff --git a/drivers/remoteproc/qcom_m0_btss_pil.c b/drivers/remoteproc/qcom_m0_btss_pil.c
> new file mode 100644
> index 000000000000..7168e270e4d4
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_m0_btss_pil.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/elf.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/soc/qcom/mdt_loader.h>
> +
> +#include "qcom_common.h"
> +
> +#define BTSS_PAS_ID	0xc
> +
> +struct m0_btss {
> +	struct device *dev;
> +	phys_addr_t mem_phys;
> +	phys_addr_t mem_reloc;
> +	void __iomem *mem_region;
> +	size_t mem_size;
> +	struct reset_control *btss_reset;
> +};
> +
> +static int m0_btss_start(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	if (!qcom_scm_pas_supported(BTSS_PAS_ID)) {
> +		dev_err(rproc->dev.parent,
> +			"PAS is not available for peripheral: 0x%x\n",
> +			BTSS_PAS_ID);
> +		return -ENODEV;
> +	}
> +
> +	ret = qcom_scm_pas_auth_and_reset(BTSS_PAS_ID);
> +	if (ret) {
> +		dev_err(rproc->dev.parent, "Failed to start rproc: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int m0_btss_stop(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	if (rproc->state == RPROC_RUNNING || rproc->state == RPROC_CRASHED) {
> +		ret = qcom_scm_pas_shutdown(BTSS_PAS_ID);
> +		if (ret) {
> +			dev_err(rproc->dev.parent, "Failed to stop rproc: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		dev_info(rproc->dev.parent, "Successfully stopped rproc\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int m0_btss_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct m0_btss *desc = rproc->priv;
> +	const struct elf32_phdr *phdrs;
> +	const struct firmware *seg_fw;
> +	const struct elf32_phdr *phdr;
> +	const struct elf32_hdr *ehdr;
> +	void __iomem *metadata;
> +	size_t metadata_size;
> +	int i, ret;
> +
> +	ehdr = (const struct elf32_hdr *)fw->data;
> +	phdrs = (const struct elf32_phdr *)(ehdr + 1);
> +
> +	ret = request_firmware(&fw, rproc->firmware, rproc->dev.parent);
> +	if (ret) {
> +		dev_err(rproc->dev.parent, "Failed to request firmware: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	metadata = qcom_mdt_read_metadata(fw, &metadata_size, rproc->firmware,
> +					  rproc->dev.parent);
> +	if (IS_ERR(metadata)) {
> +		ret = PTR_ERR(metadata);
> +		dev_err(rproc->dev.parent,
> +			"Failed to read firmware metadata: %d\n", ret);
> +		goto release_fw;
> +	}
> +
> +	ret = qcom_scm_pas_init_image(BTSS_PAS_ID, metadata,
> +				      metadata_size, NULL);
> +	if (ret) {
> +		dev_err(rproc->dev.parent, "PAS init image failed: %d\n", ret);
> +		goto free_metadata;
> +	}
> +
> +	for (i = 0; i < ehdr->e_phnum; i++) {
> +		char *seg_name __free(kfree) = kstrdup(rproc->firmware,
> +						       GFP_KERNEL);
> +		if (!seg_name)
> +			return -ENOMEM;
> +
> +		phdr = &phdrs[i];
> +
> +		/* Only process valid loadable data segments */
> +		if (phdr->p_type != PT_LOAD || !phdr->p_memsz)
> +			continue;
> +
> +		if (phdr->p_vaddr + phdr->p_filesz > desc->mem_size) {
> +			dev_err(rproc->dev.parent,
> +				"Segment data exceeds the reserved memory area!\n");
> +			goto free_metadata;
> +		}
> +
> +		/* Check if firmware is split across multiple segment files */
> +		if (phdr->p_offset > fw->size ||
> +		    phdr->p_offset + phdr->p_filesz > fw->size) {
> +			sprintf(seg_name + strlen(seg_name) - 3, "b%02d", i);
> +			ret = request_firmware(&seg_fw, seg_name,
> +					       rproc->dev.parent);
> +			if (ret) {
> +				dev_err(rproc->dev.parent,
> +					"Could not find split segment binary: %s\n",
> +					seg_name);
> +				goto free_metadata;
> +			}
> +
> +			/*
> +			 * Use the virtual instead of the physical address as
> +			 * the offset
> +			 */
> +			memcpy_toio(desc->mem_region + phdr->p_vaddr,
> +				    seg_fw->data, phdr->p_filesz);
> +
> +			release_firmware(seg_fw);
> +		} else {
> +			memcpy_toio(desc->mem_region + phdr->p_vaddr,
> +				    fw->data + phdr->p_offset, phdr->p_filesz);
> +		}
> +	}
> +
> +	return 0;
> +
> +free_metadata:
> +	kfree(metadata);
> +release_fw:
> +	release_firmware(fw);
> +	return ret;
> +}
> +
> +static const struct rproc_ops m0_btss_ops = {
> +	.start = m0_btss_start,
> +	.stop = m0_btss_stop,
> +	.load = m0_btss_load,
> +	.get_boot_addr = rproc_elf_get_boot_addr,
> +};
> +
> +static int m0_btss_alloc_memory_region(struct m0_btss *desc)
> +{
> +	struct device *dev = desc->dev;
> +	struct resource res;
> +	int ret;
> +
> +	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> +	if (ret) {
> +		dev_err(dev, "unable to acquire memory-region resource\n");
> +		return ret;
> +	}
> +
> +	desc->mem_phys = res.start;
> +	desc->mem_reloc = res.start;
> +	desc->mem_size = resource_size(&res);
> +	desc->mem_region = devm_ioremap(dev, desc->mem_phys, desc->mem_size);
> +	if (!desc->mem_region) {
> +		dev_err(dev, "unable to map memory region: %pR\n", &res);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int m0_btss_pil_probe(struct platform_device *pdev)
> +{
> +	// struct reset_control *btss_reset;
> +	struct device *dev = &pdev->dev;
> +	const char *fw_name = NULL;
> +	struct m0_btss *desc;
> +	struct clk *lpo_clk;
> +	struct rproc *rproc;
> +	int ret;
> +
> +	ret = of_property_read_string(dev->of_node, "firmware-name",
> +				      &fw_name);
> +	if (ret < 0)
> +		return ret;
> +
> +	rproc = devm_rproc_alloc(dev, "m0btss", &m0_btss_ops,
> +				 fw_name, sizeof(*desc));
> +	if (!rproc) {
> +		dev_err(dev, "failed to allocate rproc\n");
> +		return -ENOMEM;
> +	}
> +
> +	desc = rproc->priv;
> +	desc->dev = dev;
> +
> +	ret = m0_btss_alloc_memory_region(desc);
> +	if (ret)
> +		return ret;
> +
> +	lpo_clk = devm_clk_get_enabled(dev, "btss_lpo_clk");
> +	if (IS_ERR(lpo_clk))
> +		return dev_err_probe(dev, PTR_ERR(lpo_clk),
> +				     "Failed to get lpo clock\n");
> +
> +	desc->btss_reset = devm_reset_control_get(dev, "btss_reset");
> +	if (IS_ERR_OR_NULL(desc->btss_reset))
> +		return dev_err_probe(dev, PTR_ERR(desc->btss_reset),
> +				     "unable to acquire btss_reset\n");
> +
> +	ret = reset_control_deassert(desc->btss_reset);
> +	if (ret)
> +		return dev_err_probe(rproc->dev.parent, ret,
> +				     "Failed to deassert reset\n");
> +
> +	rproc->auto_boot = false;
> +	ret = devm_rproc_add(dev, rproc);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, rproc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id m0_btss_of_match[] = {
> +	{ .compatible = "qcom,ipq5018-btss-pil" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, m0_btss_of_match);
> +
> +static struct platform_driver m0_btss_pil_driver = {
> +	.probe = m0_btss_pil_probe,
> +	.driver = {
> +		.name = "qcom-m0-btss-pil",
> +		.of_match_table = m0_btss_of_match,
> +	},
> +};
> +
> +module_platform_driver(m0_btss_pil_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm M0 Bluetooth Subsystem Peripheral Image Loader");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.53.0
> 
> 

