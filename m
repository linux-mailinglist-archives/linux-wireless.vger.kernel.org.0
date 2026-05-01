Return-Path: <linux-wireless+bounces-35753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LpCMhC09GlaDwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 16:09:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C54AD1B5
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B585C300EFB0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341513BED70;
	Fri,  1 May 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDwd5OvA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978E284883;
	Fri,  1 May 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644552; cv=none; b=tbHWq0TbmmJ0n5pkyUZeOnXR4qbqSTvbvHwqyH4N4Hl5Gx+YF79iKOr7eIq7KF/Uj6fMRyQo4RP+khIjzrD9F1QV96rK926IdRytwnXdwAYbwz0kntU0j0NpgCviUOu+ovuE+ElR/FcCCKcF0bL5fIMsp+JJe0F9a3LxmHKNzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644552; c=relaxed/simple;
	bh=SMByRl8lFrdxKKnkS4vcwTneFAh6CDvoMKSWnMddQSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSLoMZXOHbj4T4Au9iiyBetyRC2tADgUzd+HHpDWBWF7V4RqQSsN2kFrIm/c3FfnkO664fXqviz1T20SYVgyyXFpiRIjOJZ29zrXRfsWh8cEn7yaSFgZwGpFwurvqi2FdFj5pJ6Sh4CgnNrpXqHWHA37mC8qzWc4OGP+Mj+RY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDwd5OvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C19FC2BCB4;
	Fri,  1 May 2026 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777644551;
	bh=SMByRl8lFrdxKKnkS4vcwTneFAh6CDvoMKSWnMddQSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDwd5OvATcOeJ+h7ekKmApfuAVD+xci9lzfuOrSfnPI5zTnw95tDinFDy0ZtNzrpT
	 9GgQLqYQQZwD3AnSe2EdNxZapxTi3VwG3sVbd9e5FDlaTknEMVZKOqCF4YjaMkN0yk
	 I0S+VqEEVePJvpJ0g3mqzm7tNtqaHPy8o4enne0DSuKwB2+cCN27TtpMqtvFJ1fq0Z
	 1+F76IuKgFfxsQ20qOaCElTQCstndw1qlLjeNSmbD4qHxnnT2kRC8VSWMMp7Exn9ao
	 Rstx6nZYaRWrYUZZCfMwH2X7TQGgSf6DxgxTWHcTo91irDUe7RsbmfH4AcpASMq04z
	 tpk2SVdf69Gbw==
Date: Fri, 1 May 2026 19:38:55 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com, sean@poorly.run,
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
Subject: Re: [PATCH v4 09/15] remoteproc: qcom: Select QCOM_PAS generic
 service
Message-ID: <afSz9ymNrtlEjyDU@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-10-sumit.garg@kernel.org>
 <20260429135257.utgighzczrbnl6cp@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429135257.utgighzczrbnl6cp@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Queue-Id: 615C54AD1B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35753-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]

On Wed, Apr 29, 2026 at 07:22:57PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:57PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Select PAS generic service driver to enable support for multiple PAS
> > backends like OP-TEE in addition to SCM.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index ee54436fea5a..da3c5d9562ea 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -230,6 +230,7 @@ config QCOM_Q6V5_PAS
> >  	select QCOM_Q6V5_COMMON
> >  	select QCOM_RPROC_COMMON
> >  	select QCOM_SCM
> 
> Check do we really need SCM now ?

For WCNSS we don't need, I will drop there but others have SCM memory
assign needs.

> Why not the change for WCNSS, MSS ?

Ack, I will change for them too.

-Sumit

> 
> > +	select QCOM_PAS
> >  	help
> >  	  Say y here to support the TrustZone based Peripheral Image Loader for
> >  	  the Qualcomm remote processors. This is commonly used to control
> 
> 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> -Mukesh Ojha
> 

