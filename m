Return-Path: <linux-wireless+bounces-33721-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNxyEP1AwWmqRwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33721-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 14:32:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF72F2FB0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0438E304734F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038043AB27E;
	Mon, 23 Mar 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6gv3IeX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8837C90E;
	Mon, 23 Mar 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272163; cv=none; b=hTGbRWI7/V6i1NblonUOlbobdp22n13Q/cMhxGwh36D74O0q1i4wBJ4LcUvfD6R5BOFW0aQrUtguLCIN44+6e+76FJEzItyWLK4X3NGN7Vobin/BkyhT3LQMSKkkQsyFtyoksNiR03JaYxoboYlUZ21JGSNY79nF4dZJ9pVuTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272163; c=relaxed/simple;
	bh=Q/XBDBJYNBjvT4Fib6BMGQRPTrjoicozUK3Bve9QYsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0RBwfZDLBRhLswHAe7j0a30zBoHccNc0Uftobdbzn0ndbAvA+T3G2ARsBgJL1qgZxr6CCCZG+pOTkzG0iCBZAr7FEfZ+WBM71eREZ/a02yCBdeL6opzn54YrZSf4JJeJ9NVezGjdC/qkj1IIV5BMTVet8+kYOd72fevC4wk5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6gv3IeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A23C4CEF7;
	Mon, 23 Mar 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774272163;
	bh=Q/XBDBJYNBjvT4Fib6BMGQRPTrjoicozUK3Bve9QYsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6gv3IeXrkpY2/ShKgiHHi9GyujozQPD0EN42/bEtKlPlZzrWFPCaffBKwM4FWmxH
	 qtxjXKM8k5U6K7imqqn0Ghur2DdHhztguaPyYcKBwkpOj+gvOcYPi2RMidO2CRmhJY
	 Q4zc2JkWhompIe+Udj2kIXlAn0URhbD/BLr2/+lOd7qzUPShGwBim7E6rbsejOdI4s
	 gsPCKI4TofLJGQB3fUfsCXhftBsCQNrN9yuq3XGF7uMBL+QwQ9NZWU4+pYR48zoAEi
	 kn2qru6xYghv8AMQSYaGvMCHekh6x8jPOIi+PXxOZP7nHy6LH8qeP1A3imkLYVN6ab
	 qb6Uc0xhR2ZFg==
Date: Mon, 23 Mar 2026 18:52:24 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
Message-ID: <acE-kAi2tkPh2qie@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33721-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: A9DF72F2FB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 08:51:16AM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2026 07:27, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> > 
> > OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> > support these non-standard SCM calls. And even for newer architectures
> > with S-EL2 and Hafnium support, QTEE won't be able to support SCM
> > calls either with FF-A requirements coming in. And with both OP-TEE
> > and QTEE drivers well integrated in the TEE subsystem, it makes further
> > sense to reuse the TEE bus client drivers infrastructure.
> > 
> > The added benefit of TEE bus infrastructure is that there is support
> > for discoverable/enumerable services. With that client drivers don't
> > have to manually invoke a special SCM call to know the service status.
> > 
> > So enable the generic Peripheral Authentication Service (PAS) provided
> > by the firmware. It acts as the common layer with different TZ
> > backends plugged in whether it's an SCM implementation or a proper
> > TEE bus based PAS service implementation.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig          |   8 +
> >  drivers/firmware/qcom/Makefile         |   1 +
> >  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
> >  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
> >  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
> >  5 files changed, 401 insertions(+)
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.c
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.h
> >  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> > 
> > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> > index b477d54b495a..8653639d06db 100644
> > --- a/drivers/firmware/qcom/Kconfig
> > +++ b/drivers/firmware/qcom/Kconfig
> > @@ -6,6 +6,14 @@
> >  
> >  menu "Qualcomm firmware drivers"
> >  
> > +config QCOM_PAS
> > +	tristate
> > +	help
> > +	  Enable the generic Peripheral Authentication Service (PAS) provided
> > +	  by the firmware. It acts as the common layer with different TZ
> > +	  backends plugged in whether it's an SCM implementation or a proper
> > +	  TEE bus based PAS service implementation.
> > +
> >  config QCOM_SCM
> >  	select QCOM_TZMEM
> >  	tristate
> > diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> > index 0be40a1abc13..dc5ab45f906a 100644
> > --- a/drivers/firmware/qcom/Makefile
> > +++ b/drivers/firmware/qcom/Makefile
> > @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> >  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
> >  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
> >  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> > +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> > diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> > new file mode 100644
> > index 000000000000..beb1bae55546
> > --- /dev/null
> > +++ b/drivers/firmware/qcom/qcom_pas.c
> > @@ -0,0 +1,298 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/device/devres.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include "qcom_pas.h"
> > +
> > +struct qcom_pas_ops *ops_ptr;
> 
> Same comment as before. Don't create singletons. And for sure not global
> ones.

This pattern has been carried from the PAS API contract among kernel
clients and the SCM PAS service earlier. The clients don't hold a
reference to the PAS data like underlying platform or TEE device etc.
Hence the need to have a global data pointer to hold reference to the
ops data structure registered by drivers having different lifetime of
devices. Also, the PAS APIs can be called from very different client
driver contexts.

Surely, avoiding global data is always better given a better alternative
is there. Do you have any better alternative proposal here?

-Sumit

