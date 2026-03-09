Return-Path: <linux-wireless+bounces-32752-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNQ/G/VzrmmlEgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32752-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 08:17:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A2234B37
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 08:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 261143011350
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 07:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2CD364926;
	Mon,  9 Mar 2026 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5r0iMa9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C662417D1;
	Mon,  9 Mar 2026 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040623; cv=none; b=LftruQzDGLvDN7GCdz+c0r0fqOBO8Paf55hAVuMYCQ08QPwKNSf7tfywiYXjsPxw9PYlwymXkwTOwBRSAXG54RfMx5y6mmNwKCu8puN1t+dWCfbso8+IAY+v4KMOowlRG14vBw0W2AAsWW6wdDK7c4iFi3Wm+PgQhx36ptsyufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040623; c=relaxed/simple;
	bh=zoDUerCQkoftGJrLBCxRZwVjBmVhgC2av1MW21s5gzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7CDMahqEI1rpMH2DO7FfSmRQfSJOv6C5IL2zIeTXNQTJAqCAhHS80qrX5m2ZoJPtVSVyzZlddqA+SFzp3QY8o86h0LAjp3N7xv8/VrjvwUKp8FF+UyiZZjS6j03NVOruQw5wcZXDgflaSsvJMG5eAZuBsBgAxXtCQ8vtGsrKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5r0iMa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9DFC4CEF7;
	Mon,  9 Mar 2026 07:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773040622;
	bh=zoDUerCQkoftGJrLBCxRZwVjBmVhgC2av1MW21s5gzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5r0iMa9cgwjghWvBYFF93FIKX7h4ScjcnkEnAFiQFz9ulsevMwQciP5lVOSQKgT+
	 XBI5o4cQVMv+vX9mluWZjiRS+TQqDt58Pyq5luZhP7E25NRhuGbHvjK+EzC5Ch8kDR
	 X6fvGdROQU4ywHdI+2pjqZxdL9dMhvEAueRWTvnMmkFTtDA6WB1vwBOnbjamG9fYEJ
	 hRyhe14m9HB3R8m1qeDlYKPA++JVGqVnKoiOzWlVnlxS0n4OpdlGtUHxBz33VKesYA
	 zuY/I47KJTXsQZeR7tI4G3CevRtCMab4fIY+xF7nqWbZOI6iTZ6i0vn+iENp4MuGPW
	 OQNTW+xRRI4RQ==
Date: Mon, 9 Mar 2026 12:46:43 +0530
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
	skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
Message-ID: <aa5z23EtUF9k1MTy@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <5dab61a6-d8cc-431d-b59e-744d98195d90@kernel.org>
 <aa5Sw1qcCnD5clth@sumit-xelite>
 <52cd78c2-95e2-4f56-9adc-242b6cf3baab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52cd78c2-95e2-4f56-9adc-242b6cf3baab@kernel.org>
X-Rspamd-Queue-Id: 0C3A2234B37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32752-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 08:10:02AM +0100, Krzysztof Kozlowski wrote:
> On 09/03/2026 05:55, Sumit Garg wrote:
> > On Fri, Mar 06, 2026 at 12:15:01PM +0100, Krzysztof Kozlowski wrote:
> >> On 06/03/2026 11:50, Sumit Garg wrote:
> >>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>>
> >>> Qcom platforms has the legacy of using non-standard SCM calls
> >>> splintered over the various kernel drivers. These SCM calls aren't
> >>> compliant with the standard SMC calling conventions which is a
> >>> prerequisite to enable migration to the FF-A specifications from
> >>> Arm.
> >>>
> >>> OP-TEE as an alternative trusted OS to QTEE can't support these non-
> >>> standard SCM calls. And even for newer architectures QTEE won't be able
> >>> to support SCM calls either with FF-A requirements coming in. And with
> >>> both OP-TEE and QTEE drivers well integrated in the TEE subsystem, it
> >>> makes further sense to reuse the TEE bus client drivers infrastructure.
> >>>
> >>> The added benefit of TEE bus infrastructure is that there is support
> >>> for discoverable/enumerable services. With that client drivers don't
> >>> have to manually invoke a special SCM call to know the service status.
> >>>
> >>> So enable the generic Peripheral Authentication Service (PAS) provided
> >>> by the firmware. It acts as the common layer with different TZ
> >>> backends plugged in whether it's an SCM implementation or a proper
> >>> TEE bus based PAS service implementation.
> >>>
> >>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>> ---
> >>>  drivers/firmware/qcom/Kconfig          |   8 +
> >>>  drivers/firmware/qcom/Makefile         |   1 +
> >>>  drivers/firmware/qcom/qcom_pas.c       | 295 +++++++++++++++++++++++++
> >>>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
> >>>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
> >>>  5 files changed, 398 insertions(+)
> >>>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
> >>>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
> >>>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> >>>
> >>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> >>> index b477d54b495a..8653639d06db 100644
> >>> --- a/drivers/firmware/qcom/Kconfig
> >>> +++ b/drivers/firmware/qcom/Kconfig
> >>> @@ -6,6 +6,14 @@
> >>>  
> >>>  menu "Qualcomm firmware drivers"
> >>>  
> >>> +config QCOM_PAS
> >>> +	tristate
> >>> +	help
> >>> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> >>> +	  by the firmware. It acts as the common layer with different TZ
> >>> +	  backends plugged in whether it's an SCM implementation or a proper
> >>> +	  TEE bus based PAS service implementation.
> >>> +
> >>>  config QCOM_SCM
> >>>  	select QCOM_TZMEM
> >>>  	tristate
> >>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> >>> index 0be40a1abc13..dc5ab45f906a 100644
> >>> --- a/drivers/firmware/qcom/Makefile
> >>> +++ b/drivers/firmware/qcom/Makefile
> >>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> >>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
> >>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
> >>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> >>> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> >>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> >>> new file mode 100644
> >>> index 000000000000..dc04ff1b6be0
> >>> --- /dev/null
> >>> +++ b/drivers/firmware/qcom/qcom_pas.c
> >>> @@ -0,0 +1,295 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >>> + */
> >>> +
> >>> +#include <linux/delay.h>
> >>> +#include <linux/device/devres.h>
> >>> +#include <linux/firmware/qcom/qcom_pas.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/slab.h>
> >>> +
> >>> +#include "qcom_pas.h"
> >>> +#include "qcom_scm.h"
> >>> +
> >>> +static struct qcom_pas_ops *ops_ptr;
> >>
> >> I really dislike this singleton design. And it is not even needed! If
> >> you were storing here some allocated instance of SCM/PAS I could
> >> understand, but singleton for only ops? Just implement one driver (so
> >> SCM + whatever you have here) which will decide which ops to use,
> >> through the probe. Really, this is neither needed nor beneficial.
> > 
> > The motivation here is rather quite opposite to the single monolithic
> > SCM driver design. The TZ services like PAS, ICE and so on are going to
> > be implemented as independent discoverable devices on TEE bus which
> > rather needs independent kernel client drivers.
> 
> You still have singleton here. So if you think you do opposite to
> singleton, then drop this static.

Sure.

> 
> > 
> > Also, the single driver probe can't work here since the SCM driver is
> > bound to the platform bus whereas the TEE PAS driver is bound to the TEE
> > bus. So there is a reason for the current design.
> > 
> >>
> >> It actually leads to more problems with this barrier handling, see
> >> further comments.
> > 
> > The barrier handling is something that I carried over from existing
> > implmentation but I can't see a reason why it can't be replaced with a
> > simple mutex. See diff below for mutex.
> > 
> >> ...
> >>
> >>> +
> >>> +/**
> >>> + * qcom_pas_shutdown() - Shut down the remote processor
> >>> + * @pas_id:	peripheral authentication service id
> >>> + *
> >>> + * Returns 0 on success.
> >>> + */
> >>> +int qcom_pas_shutdown(u32 pas_id)
> >>> +{
> >>> +	if (ops_ptr)
> >>> +		return ops_ptr->shutdown(ops_ptr->dev, pas_id);
> >>> +
> >>> +	return -ENODEV;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
> >>> +
> >>> +/**
> >>> + * qcom_pas_supported() - Check if the peripheral authentication service is
> >>> + *			  available for the given peripheral
> >>> + * @pas_id:	peripheral authentication service id
> >>> + *
> >>> + * Returns true if PAS is supported for this peripheral, otherwise false.
> >>> + */
> >>> +bool qcom_pas_supported(u32 pas_id)
> >>> +{
> >>> +	if (ops_ptr)
> >>
> >> Lack of barriers here is not looking right. Existing/old code is not a
> >> good example, I fixed only the obvious issue, but new code should be
> >> correct from the beginning.
> >>
> >> Barriers should normally be always paired, unless you have some clear
> >> path no concurrent execution can happen here, but such explanation is
> >> missing, look:
> > 
> > Actually concurrent execution is rather required here since TZ can
> > support parallel bring-up of co-processors. The synchonization is only
> > needed when PAS client drivers are performing a deferred probe waiting
> > for the service to be available. However, you are right explanation is
> > missing here which I will add in the next version.
> 
> Hm? Existing comments are completely useless. Your comment said just
> "barrier" basically... That's nothing useful.

Agree, following is something I plan for v2 (using mutex instead of a
barrier):

/*
 * The ops mutex here is only intended to synchronize when client drivers
 * are in parallel checking for PAS service availability. However, once the
 * PAS backend becomes available, it is allowed for multiple threads to enter
 * TZ for parallel bringup of co-processors during boot.
 */
static DEFINE_MUTEX(ops_mutex);

-Sumit

