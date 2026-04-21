Return-Path: <linux-wireless+bounces-35134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJAxERds52ke8AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:22:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6DA43A92F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E1730078DF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A703C3BFB;
	Tue, 21 Apr 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDUCyVwG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368913C277F;
	Tue, 21 Apr 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774161; cv=none; b=jTEebs0YEylwjxgR1g50jdh6pIS4KvH5hqQPJsy3SAsoFx5PKXZCG0pQAKxtxWafESD0VwXv2aWkIXAd4TM7qrYYkJpi18v6zejkdjVcwK5+oJ32wViXOmC93amEbZss6XGxslKsMjfJylhyYDwXyo5Hew8NTHWnZ0COMNW77d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774161; c=relaxed/simple;
	bh=FjTWTBKyxU9wnoOFIU6eC+Zsg/ak07chnRRJ6hIxvXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCuYTkFZJ5lNMw6qGCiWWRzBMh79+4I9ZaTxQmuVydrJW2JMDClZrFq5uMo6DPqXlewjJqfS3WN2urWk1bmydXlqXWPXpYOtYIGndJWyz7wud2w2b2TpgsMbjOpjK/8J8L6PNz8mZnfbmqBWGqXKdyUGU/6DLE8w4v4HS5Yn+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDUCyVwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5106C2BCB0;
	Tue, 21 Apr 2026 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774160;
	bh=FjTWTBKyxU9wnoOFIU6eC+Zsg/ak07chnRRJ6hIxvXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDUCyVwGb8ya/GZDqDieIScgOVrPOl3I/FJS9ccMew51Xp1PwcmYEtedShhwnrxmc
	 RCa1sJsDGPFZz7l6xh8HYRvZ9j5G0bWWeLPo1qSM5vCkcLDW5wJx2OyFKcOZhGoLOI
	 YwnWftevNO1eAx5/cWBBv5WlkJhG/5+YfhdJ7vYHIkPT3IgE3VLw8p3NofnqsNgFtH
	 RYEOsuva6FlMuZC1XmZz9dmSpii3t/okBhMPqO1l7pjE1ED/sH7WZTsW/w8Cyns2AW
	 HTHIQlNviNnES+NmZ/S8HynmnxRzzgDyzjO6jdJPH1Z83lN19f1bjFMnu8aORK25oM
	 Z2/yYBPfJux+A==
Date: Tue, 21 Apr 2026 17:52:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
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
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 00/15] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <aedr_gE2Sxs-UvbL@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <adPLx3nCBb8IHz2b@baldur>
 <adSOFCL26y5qt1Cu@sumit-xelite>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adSOFCL26y5qt1Cu@sumit-xelite>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35134-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: DA6DA43A92F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:24:44AM +0530, Sumit Garg wrote:
> Hi Bjorn,
> 
> On Mon, Apr 06, 2026 at 10:09:27AM -0500, Bjorn Andersson wrote:
> > On Fri, Mar 27, 2026 at 06:40:28PM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > Qcom platforms has the legacy of using non-standard SCM calls
> > > splintered over the various kernel drivers. These SCM calls aren't
> > > compliant with the standard SMC calling conventions which is a
> > > prerequisite to enable migration to the FF-A specifications from Arm.
> > > 
> > 
> > Please get our colleagues involved in this discussion, because this
> > non-SCM interface does not match the direction we are taking.
> 
> I thought I have already involved folks from QTEE perspective (Apurupa
> and Sree) actively working on FF-A implementation aligned to this
> interface. It would have been better if you could let me know where is
> the direction mismatch here. In case there is a better alternative
> design proposal for PAS service with FF-A, I would be happy to hear
> that.
> 
> Anyhow for the legacy SoCs like KLMT, we really don't have any
> alternative but have to stick to existing QTEE PAS design with OP-TEE
> providing as an alternative backend. Surely we want to support loading
> of existing signed firmware present in linux-firmware repo for KLMT with
> OP-TEE being the TZ.

After further offline internal Qcom discussions, the teams are aligned
on the vision to use and extend generic Qcom PAS layer for all the TZ
backends whether it's legacy SCM backend based on QTEE, OP-TEE backend
as proposed by this patch-set or future object invoke (based on
SMCInvoke) for QTEE.

I hope with that we can progress to get this patch-set merged in next
merge window. I will send v4 shortly after merge window closes to
address misc. comments from Harshal on patch 04/15.

-Sumit

