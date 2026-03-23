Return-Path: <linux-wireless+bounces-33718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGTdGyw5wWm7RQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:59:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C72F25B8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CBBB301D566
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB543AA1BC;
	Mon, 23 Mar 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoUvT0Ua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1D1F3B8A;
	Mon, 23 Mar 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270572; cv=none; b=R9PgymxOdc13zBNGksU7AX7BOVCVBmVWMX8PsT4D9gCF8q8tiDIWZPosPbtBQQc2W3MjtF2y63kS7MRxZ43/IrRkdwLHn1P9aII1WxAkVm8K/5vd6Ki3AITgnt8zqVdPbkecRovEhWIyrj9l0ziYWuaSFI+5vF/QKgE9OXKLsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270572; c=relaxed/simple;
	bh=PcarGU8E9MYAzSiGlIlaN0J/d/2KgvnXGF646Sss/6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfE0dgbXevY+/Rv7X5va19F5AAkTKn1a2MfVLr3+2jGHhgEqeemuaBs2vt5ElpocvzvWrFVFdWNJiSW1oWhBFXM7Y2d+z70ThJZzyQgFk1Gv4WRIn7xCemuRPRKVT0TflosIwLPh7JQx9Vr8kppKt3u98wDxLJesW8X6gWH57v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoUvT0Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F94AC4CEF7;
	Mon, 23 Mar 2026 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270571;
	bh=PcarGU8E9MYAzSiGlIlaN0J/d/2KgvnXGF646Sss/6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoUvT0Ua7vExYFgPZA0igjTdgV0kBq94+evWjMhFBjOIZRv4xfdNUbiaxRXEfZMq6
	 91VS32MQ+DNV8yrBKUUuWfsUhYYbBdqA2iOX/1ZwqUfR3o4KK55KUT2sg/AomDWEVJ
	 cML8StUwS91VgBAOaGqn9DzrXrCZkJgJmXnHsIyEns5DJl0GkuS5xEozjfMwyEYLMI
	 tUjxXbsQKfDvWtljLmC/dhr0bPEzLs3j+Dt/v6AOidSmPjND8gkQSoG0ROJevzjOye
	 BsJCTGQ6iR64jHHIJ0sY3Z/7theuY1nSZ3Mlnh6tPIwZ/YiVv44DygZqJ1F8pvKq7T
	 hl+W33yrZuphA==
Date: Mon, 23 Mar 2026 18:25:53 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
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
	trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
Message-ID: <acE4WXdiuTd1tjAp@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <20260313072450.sx7vqtvh62nflhff@hu-mojha-hyd.qualcomm.com>
 <20260313073121.qb7yq7tcga3sshcr@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313073121.qb7yq7tcga3sshcr@hu-mojha-hyd.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33718-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 9B2C72F25B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:01:21PM +0530, Mukesh Ojha wrote:
> On Fri, Mar 13, 2026 at 12:54:50PM +0530, Mukesh Ojha wrote:
> > On Thu, Mar 12, 2026 at 11:57:43AM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > Qcom platforms has the legacy of using non-standard SCM calls
> > > splintered over the various kernel drivers. These SCM calls aren't
> > > compliant with the standard SMC calling conventions which is a
> > > prerequisite to enable migration to the FF-A specifications from Arm.
> > > 
> > > OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> > > support these non-standard SCM calls. And even for newer architectures
> > > with S-EL2 and Hafnium support, QTEE won't be able to support SCM
> > 
> >  using S‑EL2 with Hafnium
> > 
> > > calls either with FF-A requirements coming in. And with both OP-TEE
> > > and QTEE drivers well integrated in the TEE subsystem, it makes further
> > > sense to reuse the TEE bus client drivers infrastructure.
> > > 
> > > The added benefit of TEE bus infrastructure is that there is support
> > > for discoverable/enumerable services. With that client drivers don't
> > > have to manually invoke a special SCM call to know the service status.
> > > 
> > > So enable the generic Peripheral Authentication Service (PAS) provided
> > > by the firmware. It acts as the common layer with different TZ
> > > backends plugged in whether it's an SCM implementation or a proper
> > > TEE bus based PAS service implementation.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >  drivers/firmware/qcom/Kconfig          |   8 +
> > >  drivers/firmware/qcom/Makefile         |   1 +
> > >  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
> > >  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
> > >  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
> > >  5 files changed, 401 insertions(+)
> > >  create mode 100644 drivers/firmware/qcom/qcom_pas.c
> > >  create mode 100644 drivers/firmware/qcom/qcom_pas.h
> > >  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> > > 

<snip>

> > > diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> > > new file mode 100644
> > > index 000000000000..beb1bae55546
> > > --- /dev/null
> > > +++ b/drivers/firmware/qcom/qcom_pas.c
> > > @@ -0,0 +1,298 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > > + */
> > > +
> > > +#include <linux/device/devres.h>
> > > +#include <linux/firmware/qcom/qcom_pas.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +
> > > +#include "qcom_pas.h"
> > > +
> > > +struct qcom_pas_ops *ops_ptr;
> > 
> > Should this be static ?
> > 
> > > +
> > > +/**
> > > + * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
> > > + *				   context for a given peripheral
> > > + *
> > > + * PAS context is device-resource managed, so the caller does not need
> > > + * to worry about freeing the context memory.
> > > + *
> > > + * @dev:	  PAS firmware device
> > > + * @pas_id:	  peripheral authentication service id
> > > + * @mem_phys:	  Subsystem reserve memory start address
> > > + * @mem_size:	  Subsystem reserve memory size
> > > + *
> > > + * Return: The new PAS context, or ERR_PTR() on failure.
> > > + */
> > > +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> > > +						     u32 pas_id,
> > > +						     phys_addr_t mem_phys,
> > > +						     size_t mem_size)
> > > +{
> > > +	struct qcom_pas_context *ctx;
> > > +
> > > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > +	if (!ctx)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	ctx->dev = dev;
> > > +	ctx->pas_id = pas_id;
> > > +	ctx->mem_phys = mem_phys;
> > > +	ctx->mem_size = mem_size;
> > > +
> > > +	return ctx;
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_qcom_pas_context_alloc);
> > > +
> > > +/**
> > > + * qcom_pas_init_image() - Initialize peripheral authentication service state
> > > + *			   machine for a given peripheral, using the metadata
> > > + * @pas_id:	peripheral authentication service id
> > > + * @metadata:	pointer to memory containing ELF header, program header table
> > > + *		and optional blob of data used for authenticating the metadata
> > > + *		and the rest of the firmware
> > > + * @size:	size of the metadata
> > > + * @ctx:	optional pas context
> > > + *
> > > + * Return: 0 on success.
> > > + *
> > > + * Upon successful return, the PAS metadata context (@ctx) will be used to
> > > + * track the metadata allocation, this needs to be released by invoking
> > > + * qcom_pas_metadata_release() by the caller.
> > > + */
> > > +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> > > +			struct qcom_pas_context *ctx)
> 
> please, align this with previous line '(' for all the functions.
> 

The alignment is fine here, not sure why the plain text replies show
them as not aligned.

-Sumit

