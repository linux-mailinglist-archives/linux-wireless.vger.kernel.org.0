Return-Path: <linux-wireless+bounces-34314-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDZyIGgLzmmnkgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34314-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:23:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D83846B0
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3339303AFB0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B137CD50;
	Thu,  2 Apr 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzUiQ4mf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83848263F5E;
	Thu,  2 Apr 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111011; cv=none; b=g79gS5VfS/ZtF8a8Ils5EToccfo9D/fj+0w1l/mLpd1DTO8dcR6IDU0Dxuk94AG8msD+NXyqxiNOvlGRecTV7YpP8pGJExAlNXl2+MCilpk7EjftD+Pwmp8CnP8HLRxnBE7Xa/IY2r3Ezm47NEY9xmi1UMPnvHh2Ur+PpzuzA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111011; c=relaxed/simple;
	bh=1hQ/0S8oRZgtSiNRnqfKOBu3rBMgkc0Kel/5lQ1b46A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIkxXBaVKZD3koNEkJlOHlKv5DEVZXzJH2j7tTVkJlaYgSqedd6HMmx88nD5hyhZHxxs141N9KOp01iioX8Yec2hgav19ZnWHDMi3UHvQVYqq6/XiZU8g0SFLh18uIOGpMcPP07gpWIJpNs05d5+ZHM9j0OQQckhDSRhyRY/feY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzUiQ4mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4408CC19423;
	Thu,  2 Apr 2026 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775111011;
	bh=1hQ/0S8oRZgtSiNRnqfKOBu3rBMgkc0Kel/5lQ1b46A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzUiQ4mfFOS756slYDURtvWpR2Ytv3yQGpI4Sf4C+iWVOYt8cVr7mG7+EbAssI0Uz
	 tKt3bupqMb0IGEo0l5QMWenRFYuepZSlE59dndMiGgTzN5OHCtgK+epcuRpDWewria
	 OvFr5G45c/vo6qPb7lH7943uGc6KOcS5L1LUHhJfeEVaarY8UK/7QjnuXdvJaaQTIi
	 WxkvdWbD/gpALn/M//30PYbtyIH5X9KuZbEjYsbnU/pdNp3gVzw9VWHkLaQVs/ICPH
	 WXfTOkssuLue1cK7zBOnJggMvNmxsCQId3WDUEPpIDhAv4w/Y0VYE3FujAvPdKogIB
	 EgNAsgH3eSveA==
Date: Thu, 2 Apr 2026 11:53:12 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <ac4LUJbR6jUIWNgI@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-5-sumit.garg@kernel.org>
 <000abdb5-a8b4-47c4-860b-5666e650b545@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000abdb5-a8b4-47c4-860b-5666e650b545@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34314-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 6B9D83846B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:06:47PM +0530, Harshal Dev wrote:
> 
> 
> On 3/27/2026 6:40 PM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Add support for Peripheral Authentication Service (PAS) driver based
> > on TEE bus with OP-TEE providing the backend PAS service implementation.
> > 
> > The TEE PAS service ABI is designed to be extensible with additional API
> > as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> > extensions of the PAS service needed while still maintaining backwards
> > compatibility.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig        |  10 +
> >  drivers/firmware/qcom/Makefile       |   1 +
> >  drivers/firmware/qcom/qcom_pas_tee.c | 478 +++++++++++++++++++++++++++
> >  3 files changed, 489 insertions(+)
> >  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> >
> [...]
> 
> > diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> > new file mode 100644
> > index 000000000000..d63122c34f04
> > --- /dev/null
> > +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> > @@ -0,0 +1,478 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/of.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/uuid.h>
> > +
> > +#include "qcom_pas.h"
> > +
> > +/*
> > + * Peripheral Authentication Service (PAS) supported.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + */
> > +#define TA_QCOM_PAS_IS_SUPPORTED		1
> > +
> > +/*
> > + * PAS capabilities.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + * [out] params[1].value.a:	PAS capability flags
> > + */
> > +#define TA_QCOM_PAS_CAPABILITIES		2
> > +
> > +/*
> > + * PAS image initialization.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + * [in]  params[1].memref:	Loadable firmware metadata
> > + */
> > +#define TA_QCOM_PAS_INIT_IMAGE			3
> > +
> > +/*
> > + * PAS memory setup.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + * [in]  params[0].value.b:	Relocatable firmware size
> > + * [in]  params[1].value.a:	32bit LSB relocatable firmware memory address
> > + * [in]  params[1].value.b:	32bit MSB relocatable firmware memory address
> > + */
> > +#define TA_QCOM_PAS_MEM_SETUP			4
> > +
> > +/*
> > + * PAS get resource table.
> > + *
> > + * [in]     params[0].value.a:	Unique 32bit remote processor identifier
> > + * [inout]  params[1].memref:	Resource table config
> > + */
> > +#define TA_QCOM_PAS_GET_RESOURCE_TABLE		5
> > +
> > +/*
> > + * PAS image authentication and co-processor reset.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + * [in]  params[0].value.b:	Firmware size
> > + * [in]  params[1].value.a:	32bit LSB firmware memory address
> > + * [in]  params[1].value.b:	32bit MSB firmware memory address
> > + * [in]  params[2].memref:	Optional fw memory space shared/lent
> > + */
> > +#define TA_QCOM_PAS_AUTH_AND_RESET		6
> > +
> > +/*
> > + * PAS co-processor set suspend/resume state.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + * [in]  params[0].value.b:	Co-processor state identifier
> > + */
> > +#define TA_QCOM_PAS_SET_REMOTE_STATE		7
> > +
> > +/*
> > + * PAS co-processor shutdown.
> > + *
> > + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> > + */
> > +#define TA_QCOM_PAS_SHUTDOWN			8
> > +
> > +#define TEE_NUM_PARAMS				4
> > +
> > +/**
> > + * struct qcom_pas_tee_private - PAS service private data
> > + * @dev:		PAS service device.
> > + * @ctx:		TEE context handler.
> > + * @session_id:		PAS TA session identifier.
> 
> Nit: Column alignment of comment descriptions.

These are aligned if you look at them after applying the patch-set.
Plain email text isn't good at showing the alignment here.

> 
> > + */
> > +struct qcom_pas_tee_private {
> > +	struct device *dev;
> > +	struct tee_context *ctx;
> > +	u32 session_id;
> > +};
> > +
> > +static bool qcom_pas_tee_supported(struct device *dev, u32 pas_id)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_IS_SUPPORTED,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = pas_id
> > +		}
> > +	};
> > +	int ret;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS not supported, pas_id: %d, err: %x\n",
> > +			pas_id, inv_arg.ret);
> 
> I can see that similar error handling pattern for tee_client_invoke_func() is
> being done by other clients. But it seems that this error log doesn't really convey
> whether we failed before or after entering OPTEE (or some other TEE) for invoking
> the service.
> 
> Could be better if we print 'ret' when ret < 0. And print 'inv_arg.ret' when
> inv_arg.ret != 0. So for example, if the param marshalling fails, or some other
> issue is encountered when processing the params in a different back-end TEE
> driver, we could know from the logs.

Okay, I will add print for "ret" as well.

> 
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int qcom_pas_tee_init_image(struct device *dev, u32 pas_id,
> > +				   const void *metadata, size_t size,
> > +				   struct qcom_pas_context *ctx)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_INIT_IMAGE,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = pas_id
> > +		},
> > +		[1] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> > +		}
> > +	};
> > +	struct tee_shm *mdata_shm;
> > +	u8 *mdata_buf = NULL;
> > +	int ret;
> > +
> > +	if (!ctx)
> > +		return -EINVAL;
> > +
> > +	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);
> 
> Why not move the DEFINE_FREE() above this function so we can use scoped free
> here as well for mdata_shm?
> 
> struct tee_shm *mdata_shm __free(shm_free) = ...

mdata_shm gets freed as part of qcom_pas_tee_metadata_release(), so no
automatic free here.

> 
> > +	if (IS_ERR(mdata_shm)) {
> > +		dev_err(dev, "mdata_shm allocation failed\n");
> > +		return PTR_ERR(mdata_shm);
> > +	}
> > +
> > +	mdata_buf = tee_shm_get_va(mdata_shm, 0);
> > +	if (IS_ERR(mdata_buf)) {
> > +		dev_err(dev, "mdata_buf get VA failed\n");
> > +		tee_shm_free(mdata_shm);
> > +		return PTR_ERR(mdata_buf);
> > +	}
> > +	memcpy(mdata_buf, metadata, size);
> > +
> > +	param[1].u.memref.shm = mdata_shm;
> > +	param[1].u.memref.size = size;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS init image failed, pas_id: %d, err: %x\n",
> 
> Nit: We can prefix %x with 0x. "err: 0x%x\n."

Ack

> 
> > +			pas_id, inv_arg.ret);
> > +		tee_shm_free(mdata_shm);
> > +		return -EINVAL;
> > +	}
> > +	ctx->ptr = (void *)mdata_shm;
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> > +				  phys_addr_t addr, phys_addr_t size)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_MEM_SETUP,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = pas_id,
> > +			.u.value.b = size,
> > +		},
> > +		[1] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = lower_32_bits(addr),
> > +			.u.value.b = upper_32_bits(addr),
> > +		}
> > +	};
> > +	int ret;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS mem setup failed, pas_id: %d, err: %x\n",
> > +			pas_id, inv_arg.ret);
> > +		return -EINVAL;
> 
> I can see that originally in-case of error, qcom_scm_pas_mem_setup() bubbles
> up the return value from qcom_scm_call(). Perhaps we should do the same as well,
> return ret here instead of hard-coded '-EINVAL' which overrides any useful
> return values returned from the back-end TEE driver.

ret can even be 0 while still error from TEE. Let's rather do following:

	return ret ? ret : -EINVAL;

>  
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_FREE(shm_free, struct tee_shm *, tee_shm_free(_T))
> > +
> > +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> > +					struct qcom_pas_context *ctx,
> > +					void *input_rt, size_t input_rt_size,
> > +					size_t *output_rt_size)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_GET_RESOURCE_TABLE,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = ctx->pas_id,
> > +		},
> > +		[1] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > +			.u.memref.size = input_rt_size,
> > +		}
> > +	};
> > +	void *rt_buf = NULL;
> > +	int ret;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> > +			ctx->pas_id, inv_arg.ret);
> > +		return ERR_PTR(-EINVAL);
> 
> Same comment here, we could return ERR_PTR(ret) instead of overriding to
> '-EINVAL'.
> 
> > +	}
> > +
> > +	if (param[1].u.memref.size) {
> > +		struct tee_shm *rt_shm __free(shm_free) =
> > +			tee_shm_alloc_kernel_buf(data->ctx,
> > +						 param[1].u.memref.size);
> > +		void *rt_shm_va;
> > +
> > +		if (IS_ERR(rt_shm)) {
> > +			dev_err(dev, "rt_shm allocation failed\n");
> > +			return rt_shm;
> > +		}
> > +
> > +		rt_shm_va = tee_shm_get_va(rt_shm, 0);
> > +		if (IS_ERR_OR_NULL(rt_shm_va)) {
> > +			dev_err(dev, "rt_shm get VA failed\n");
> > +			return ERR_PTR(-EINVAL);
> 
> Why not just return rt_shm_va? It already encodes the error in the pointer.

Again let me add a null check while returning rt_shm_va.

> 
> > +		}
> > +		memcpy(rt_shm_va, input_rt, input_rt_size);
> > +
> > +		param[1].u.memref.shm = rt_shm;
> > +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +		if (ret < 0 || inv_arg.ret != 0) {
> > +			dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> > +				ctx->pas_id, inv_arg.ret);
> > +			return ERR_PTR(-EINVAL);
> 
> Same comment.
> 
> > +		}
> > +
> > +		if (param[1].u.memref.size) {
> 
> Is it possible for param[1].u.memref.size to be 0 after a successful tee_client_invoke_func()?

Yeah it's possible if there is no resource table entry needed for a
particular PAS id.

> 
> > +			*output_rt_size = param[1].u.memref.size;
> > +			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
> > +			if (!rt_buf)
> > +				return ERR_PTR(-ENOMEM);
> > +		}
> > +	}
> > +
> > +	return rt_buf;
> > +}
> > +
> > +static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
> > +					 phys_addr_t mem_phys, size_t mem_size)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_AUTH_AND_RESET,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = pas_id,
> > +			.u.value.b = mem_size,
> > +		},
> > +		[1] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = lower_32_bits(mem_phys),
> > +			.u.value.b = upper_32_bits(mem_phys),
> > +		},
> > +		/* Reserved for fw memory space to be shared or lent */
> 
> Can you explain this comment a bit more? Plan is to allow passing a MEM_REF here
> which could be lent/shared to TEE via FFA ABI?

This param is added for future compatibility where PAS firmware is
loaded in arbitrarity allocated memory region by the kernel. Then that
can be shared or lend with TZ for authentication and reset sequence.

Right now the kernel is already loading the PAS firmware is fixed
reserved memory regions, for which this param is unused.

> 
> > +		[2] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> > +		}
> > +	};
> > +	int ret;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS auth reset failed, pas_id: %d, err: %x\n",
> > +			pas_id, inv_arg.ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
> 
> I'm guessing once all clients have migrated to PAS, plan is to drop this wrapper?

Yeah, this patch-set doesn't aim to change the kernel client PAS API
contract apart from just renaming APIs. Surely future work can change
the PAS API contract as needed.

> 
> > +{
> > +	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
> > +}
> > +
> > +static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
> > +					       struct qcom_pas_context *ctx)
> > +{
> > +	return __qcom_pas_tee_auth_and_reset(dev, ctx->pas_id, ctx->mem_phys,
> > +					     ctx->mem_size);
> > +}
> > +
> > +static int qcom_pas_tee_set_remote_state(struct device *dev, u32 state,
> > +					 u32 pas_id)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_SET_REMOTE_STATE,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = pas_id,
> > +			.u.value.b = state,
> > +		}
> > +	};
> > +	int ret;
> 
> Nit: Why not ret = 0 initialize and always use ret?

zero init will still be redundant..

> 
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> > +			pas_id, inv_arg.ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;

.. will rather change this to return ret.

> > +}
> > +
> > +static int qcom_pas_tee_shutdown(struct device *dev, u32 pas_id)
> > +{
> > +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> > +	struct tee_ioctl_invoke_arg inv_arg = {
> > +		.func = TA_QCOM_PAS_SHUTDOWN,
> > +		.session = data->session_id,
> > +		.num_params = TEE_NUM_PARAMS
> > +	};
> > +	struct tee_param param[4] = {
> > +		[0] = {
> > +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +			.u.value.a = pas_id
> > +		}
> > +	};
> > +	int ret = 0;
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> > +			pas_id, inv_arg.ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> 
> You could just return 'ret' here. :)

Ack.

> 
> > +}
> > +
> > +static void qcom_pas_tee_metadata_release(struct device *dev,
> > +					  struct qcom_pas_context *ctx)
> > +{
> > +	struct tee_shm *mdata_shm = ctx->ptr;
> > +
> 
> Nit: Unnecessary extra line.

Extra line is recommended after variables declaration.

> 
> > +	tee_shm_free(mdata_shm);
> > +}
> > +
> 
> [...]
> 
> > +
> > +module_tee_client_driver(optee_pas_tee_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("TEE bus based Qualcomm PAS driver");
> 
> Since this is a tee_client driver, isn't it self-explanatary that it's TEE bus based?
> 

I can rather say:

MODULE_DESCRIPTION("Qualcomm PAS TEE driver");

-Sumit

