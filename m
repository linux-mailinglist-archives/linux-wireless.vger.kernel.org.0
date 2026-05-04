Return-Path: <linux-wireless+bounces-35832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EroEMSC+GnIwAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 13:28:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2A4BC5DC
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE42301DE26
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F43AA4F2;
	Mon,  4 May 2026 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8pMY5gA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DD354AE3;
	Mon,  4 May 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894078; cv=none; b=eN5/jo/YToV4Y5JQdoSTYkhHONCcxdJ4Rcw3VYE0XfCYB5XAJTuloEKTJnUwlcU0mLy0xxGBwi6xgBfifv1CGPUR4sK2kLd9Mb2xsBC/FoIRXbTCC9Rf3O1+ulY4xrcsNzI3D824WtE5M7Q9bzRIirwQUoMjv3vc2Oml8uj8SMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894078; c=relaxed/simple;
	bh=vmwhKpIuJ/kZwCXjcaFmLTe8fKVmq6dYhXjPDXJ2dss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIaN1Ty1u7kbhYMmZL1drIR04iMXMTKtkne4efG3tlqpQz0fmuvM4pEugy26HZlNXRpODMi6tFCAKIXtAKeNAVNQuGXHRZI06nf1oJ1fyXHiALoeywt7RiNOw1x2s6uY5Wg0QoCrZiGGLOkYDhUFb0IdQdN1fygE574W6AeQDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8pMY5gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6DCC2BCB9;
	Mon,  4 May 2026 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777894077;
	bh=vmwhKpIuJ/kZwCXjcaFmLTe8fKVmq6dYhXjPDXJ2dss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8pMY5gALGtg1xGJyZawkZqX7NzKmzo4hhJUD7PMuWFYqDT8DYoMLbSATCHNzy+9j
	 9pzpd9WM9PXAQ+qliFpwwott2DWy2pCyXdx5Pw7lqK3jbHhf1CT65KX7rWU5Cw0MIc
	 sd8rLoBV6+GFdaDmgxzjH9jwRFlBKMUpt6nmcM3IcrwXVlCgYr+0etwE0BZvRLMz+b
	 8klOVo3i4ybTG3ezMXQ+iQ5THKHKoQEMA6oGmz/eHqqXBbEiXLOVss8ditfDjE6JuP
	 tpjWuBpj+w4SeVFI9wVqlnmhjC0SfO4TRkmpW6BSmb6MzURpeP0INtWUP8lduNUb2T
	 mLFJIqtsD3TIw==
Date: Mon, 4 May 2026 16:57:40 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
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
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
	apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <afiCrIYSm8AK9xn9@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
 <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
X-Rspamd-Queue-Id: 91D2A4BC5DC
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
	TAGGED_FROM(0.00)[bounces-35832-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]

On Mon, May 04, 2026 at 03:33:06PM +0530, Harshal Dev wrote:
> Hi Sumit,
> 
> On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
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
> >  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
> >  3 files changed, 490 insertions(+)
> >  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> 
> [...]
> 
> > diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> 
> > +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> > +				  phys_addr_t addr, phys_addr_t size)
> > +{
> 
> [...]
> 
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> > +			pas_id, ret, inv_arg.ret);
> > +		return ret ?: -EINVAL;
> 
> Following the example from qcom_scm_pas_mem_setup() here:
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778
> 
> I think it should be:
> return ret ?: inv_arg.ret;

inv_arg.ret return a GP TEE error code which doesn't map 1:1 to kernel
error codes. The client drivers won't benefit without having a way to
decode those errors. So just printing here can help the user to debug
any issues.

> 
> This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
> I can see that is tries to print this error:
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286
> 
> With that,
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> 

Thanks, I hope with above I can keep your tag.

-Sumit

