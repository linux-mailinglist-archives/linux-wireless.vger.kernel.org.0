Return-Path: <linux-wireless+bounces-34063-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EbGLcR1xmlFKgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34063-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:19:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F03441B1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 237FE301FB67
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C043988F5;
	Fri, 27 Mar 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA5KYHyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5431DBB3A;
	Fri, 27 Mar 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613950; cv=none; b=pRzTLR5fACSlYtrsMEWb6R5nGfCJLQszjn20ErShdSkZ68zp3BaPvV2vxeshRqBPzuOjpUanoYwSaStC78DZseDHWs/p/pCpMI+1qBwPwmeMVS13gKDvgm/WAoPWXTr+s2s8b6U0nfP+IcMLny+rNamZ/yMnuH9iPZX0KKj5tCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613950; c=relaxed/simple;
	bh=WdmmxLC4uZUaxNYg07u+R61NqLzB+09CSA+9gpv6wjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBEuYkKztwLFmS0yDIiwgCQt5YAwDjACNu2Tz9mV8SVN6GP4Yg5iLahJVZoCxy1YPNlF6Pg9ivD2yHLezqQJ0xwYumhDFs70sAUirvTO++jW2VbWTZi2K8lZCDFGMkxI0adUGJiUF654qbFZt52eaju0bup7QWJXfrAdSqeF2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA5KYHyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE0C19423;
	Fri, 27 Mar 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774613950;
	bh=WdmmxLC4uZUaxNYg07u+R61NqLzB+09CSA+9gpv6wjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA5KYHyR7h3Q8MfGqowvF8zh3gqZs2NKETp6VjzAQHFOxAoWEqN0DxyQgjKOs/s4j
	 qXoc++EGCuN+Jk+SBWCPkkRPeNWml7CZJMT/6nIXgPViu8Dnrf5Y0JvyDOyGoeqnbI
	 0H5VWYLLc8pldAYA4QYKHb8XZkd0dRadiA9mRFVYgx1cYMtKzVV+8iqrV7NgH528iQ
	 NLZxMIbfgUxSiLRf8oVPOV+33glZq4ueSjniXmTt5fgoBdhmEIK2PUTDmmUKysdutE
	 loM8mBn20nJPvqYo7NRuB1vdTTBJYMQIPAhOc/DLPCFcpNFcwr1vGOZ12458rn/B7m
	 QhOIXoObtExuw==
Date: Fri, 27 Mar 2026 17:48:52 +0530
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
Subject: Re: [PATCH v2 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <acZ1rDB5-koq8UqF@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-4-sumit.garg@kernel.org>
 <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34063-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F8F03441B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 05:40:16PM +0530, Harshal Dev wrote:
> 
> 
> On 3/12/2026 11:57 AM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > With the availability of generic PAS service, let's add SCM calls as
> > a backend to keep supporting legacy QTEE interfaces. The exported
> > qcom_scm* wrappers will get dropped once all the client drivers get
> > migrated as part of future patches.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig    |   1 +
> >  drivers/firmware/qcom/qcom_scm.c | 336 ++++++++++++++-----------------
> >  2 files changed, 156 insertions(+), 181 deletions(-)
> >
> 
> [..]
> 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 8fbc96693a55..2d7937ae7c8f 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma-mapping.h>
> 
> [..]
> 
> >  
> > -/**
> > - * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
> > - *				       context for a given peripheral
> > - *
> > - * PAS context is device-resource managed, so the caller does not need
> > - * to worry about freeing the context memory.
> > - *
> > - * @dev:	  PAS firmware device
> > - * @pas_id:	  peripheral authentication service id
> > - * @mem_phys:	  Subsystem reserve memory start address
> > - * @mem_size:	  Subsystem reserve memory size
> > - *
> > - * Returns: The new PAS context, or ERR_PTR() on failure.
> > - */
> 
> Shouldn't we drop the documentation for the exported functions in this file as part of
> patch 14/15? After this patch is applied, the devm_qcom_scm_pas_context_alloc() function
> still remains exported and available.

I don't see value in maintaining redundant documentation during the
course of the patch-set. The wrappers are only maintained to keep the
individual commits compilable such that we don't break kernel git
bisection scripts.

-Sumit

