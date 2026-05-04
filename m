Return-Path: <linux-wireless+bounces-35831-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO1LDuWB+GnIwAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35831-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 13:24:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74184BC538
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 13:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B094E301E3F5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C33AA1BD;
	Mon,  4 May 2026 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKjpZmuv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E9390C9A;
	Mon,  4 May 2026 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893824; cv=none; b=EJUF3CdqyPbUtFXBIlm0KwfvE85Ya7fXnVkKxQejaY5VPV6dsgEFtqGciCNBifQUlBO1+jRpR8x+tPPEWuvRQG5sh2uQDqqT7ZSKAaDcSfgzMiYRDVYvSlR1FPX2p2lGZpehF6Mdj7ZqJNbelKafp9pAPFgf9Fk68ihwwsXvREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893824; c=relaxed/simple;
	bh=1w+MzSobxxhh4/Z6BnF1Kps4Ui5Z89S5baW8VF7cW6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0dFc4eZIZ46VUvzwRvR6u5SmhRGPeUpL947lQK1hGEW21LL9YCVWQrgFwg79I9SGvnDxVzUgMCOqakBDnu+wkWFGZpDiR3DMC22XWelSy1EUcb7Fv16rviPreyUgg3fR+Rkey7f666ycbVSL0xWHAdSEaMgRcd3ZJG1qLdQM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKjpZmuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17416C2BCB8;
	Mon,  4 May 2026 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777893824;
	bh=1w+MzSobxxhh4/Z6BnF1Kps4Ui5Z89S5baW8VF7cW6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKjpZmuvT3AASZNwdOzNxp2knijQMyMENFMHM5uqAOrV+70C3W/V+G62NSkeLnjzL
	 d7IH3uPHFHyq6SvUwEUCu6X33eAaaVpuGEI+NWlgvBQgKDyKKsXmUsMFbxJTZk5XmB
	 Lo3jNju8AYgqS3cynz2WeFDWRkxL7rvgwSY5jsqgL9E7bn8S4dT+McwB5oeSR6cyY8
	 GE5Y1kovSElzmwnbUck5r3saI9Xt0dB57LfWOdOonvUwnNHfNwZ0RJwogibRCtfsn8
	 L4L0/hTuWlEatyhi8lNXCX9h5krZSukJ7LkRsewUB1J58/zkoNMLAc9tK7EMOodhSX
	 SWLdQcNbZAOaQ==
Date: Mon, 4 May 2026 16:53:26 +0530
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
Subject: Re: [PATCH v4 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <afiBrt7g1Y4-Eozu@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-4-sumit.garg@kernel.org>
 <20260429104841.l555xd2izoyrqjp4@hu-mojha-hyd.qualcomm.com>
 <afStf3iBDtP2z6Eo@sumit-xelite>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afStf3iBDtP2z6Eo@sumit-xelite>
X-Rspamd-Queue-Id: D74184BC538
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
	TAGGED_FROM(0.00)[bounces-35831-lists,linux-wireless=lfdr.de];
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

On Fri, May 01, 2026 at 07:11:19PM +0530, Sumit Garg wrote:
> On Wed, Apr 29, 2026 at 04:18:41PM +0530, Mukesh Ojha wrote:
> > On Mon, Apr 27, 2026 at 03:25:51PM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > With the availability of generic PAS service, let's add SCM calls as
> > > a backend to keep supporting legacy QTEE interfaces. The exported
> > > qcom_scm* wrappers will get dropped once all the client drivers get
> > > migrated as part of future patches.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >  drivers/firmware/qcom/Kconfig    |   1 +
> > >  drivers/firmware/qcom/qcom_scm.c | 335 ++++++++++++++-----------------
> > >  2 files changed, 155 insertions(+), 181 deletions(-)
> > >  
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > index 9b06a69d3a6d..d87a962e93da 100644
> > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > >  
> > > -/**
> > > - * qcom_scm_pas_shutdown() - Shut down the remote processor
> > > - * @pas_id:	peripheral authentication service id
> > > - *
> > > - * Returns 0 on success.
> > > - */
> > > -int qcom_scm_pas_shutdown(u32 pas_id)
> > > +static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
> > > +					   u32 pas_id)
> > > +{
> > > +	struct qcom_scm_desc desc = {
> > > +		.svc = QCOM_SCM_SVC_BOOT,
> > > +		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
> > > +		.arginfo = QCOM_SCM_ARGS(2),
> > > +		.args[0] = state,
> > > +		.args[1] = pas_id,
> > > +		.owner = ARM_SMCCC_OWNER_SIP,
> > > +	};
> > > +	struct qcom_scm_res res;
> > > +	int ret;
> > > +
> > > +	ret = qcom_scm_call(dev, &desc, &res);
> > > +
> > > +	return ret ? : res.result[0];
> > > +}
> > > +
> > > +int qcom_scm_set_remote_state(u32 state, u32 id)
> > 
> > s/id/pas_id
> 
> Ack.
>

Coming back to this comment again, since this is a temporary wrapper
which is going to be dropped as part of 2nd last patch, I don't think
there is value to fix them as they maintain existing APIs interface.

-Sumit

