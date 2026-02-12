Return-Path: <linux-wireless+bounces-31774-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMuCGOrujWlw8wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31774-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:16:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBC12ECE8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA2D430048F4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5C3EBF3C;
	Thu, 12 Feb 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oex44UkU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EE2C9D;
	Thu, 12 Feb 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909415; cv=none; b=bnmgXzBf3erhSV4F0EvpbtpiURBURBB4vLpR5jPfh9aFyjhVty51tT0ngo7gig1LMvuC+gCqzQC3WVwcwmxv3oJNHfyl3wH7+oo+XYonAvQcIMqfEtgCLgYPkO6eFrLVOwGursFI3NjPSnJxmORx9vaUk7Xun9AGj8QwEMRZD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909415; c=relaxed/simple;
	bh=/YxLfHepNobMPznsIT/8d/F6MCTOOI+heTvJBv7kiXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku0P8HJESw4YxQWUsp3ak14oUmmapk8999DhEs3Gswbx8xyqsfqNZ96Qh/ewOtgKpaPDyyKfOlUaMfEAKx7DL6YCQar9dAczNaTGMaaHvpfAdaRHYxcOf2SBNmLjYLb2TR523+LDIs/IVE6wAVnEJRvsUdpwLytjN/7ajQgTXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oex44UkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2030C4CEF7;
	Thu, 12 Feb 2026 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770909415;
	bh=/YxLfHepNobMPznsIT/8d/F6MCTOOI+heTvJBv7kiXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oex44UkU03+7lRzAzgkAdYqpU4PK8HFEyN8f+VLkQmYHRec+30S4RJYoJhxlYAQPx
	 ABuVrxqU23MegqnHULPRoXj4VwojimjSgVqbM+MIiqOZt/ZBBExRCntvQxgGwEdyuM
	 IPn/Pd5+t9BkmfiWmUJQKORvUuDD5cFPMEXA1nCUOj3zozq37g5UR8L3WWzQRTuC3Y
	 tcuQwYNhqu6s06Es8of2AST5DdKTUdpbi5ysKm1kxoBA1PGesYuY9NVa+YoNb74+4E
	 dWVUE51Yo/foyemRZVOYgInb/OpqQ6Plfgxqk7AGZPaxibIC3YRVjlvGd/UtBjqp1f
	 Mr4Hbw/kYIkBA==
Date: Thu, 12 Feb 2026 09:16:52 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: Silence remoteproc probe deferral prints
Message-ID: <zpddlyuwrxr2rwjsyzsucgm3irtxmetyhhajptveojnmo7vcni@ntyqoahm6xtq>
References: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
 <f028462c-ae31-4fa5-b414-e03d3a73fdf4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f028462c-ae31-4fa5-b414-e03d3a73fdf4@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31774-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CCEBC12ECE8
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 04:01:21PM +0100, Konrad Dybcio wrote:
> On 2/12/26 3:52 PM, Bjorn Andersson wrote:
> > Upon failing to resolve the remoteproc phandle one ath11k_dbg() and one
> > ath11k_err() is used to tell the user about the (presumably) temporary
> > failure.
> > 
> > Reduce the log spam by removing the duplicate print and switching to
> > dev_err_probe(), in line with how ath12k handles this error.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > ---
> >  drivers/net/wireless/ath/ath11k/ahb.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> > index 8dfe9b40c12626649639fc1dd9da0e5e0c2dcaf1..08d3a0c8f105b26b1548c5d6006f6ea162fe58ff 100644
> > --- a/drivers/net/wireless/ath/ath11k/ahb.c
> > +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> > @@ -807,10 +807,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
> >  	}
> >  
> >  	prproc = rproc_get_by_phandle(rproc_phandle);
> > -	if (!prproc) {
> > -		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
> > -		return -EPROBE_DEFER;
> > -	}
> > +	if (!prproc)
> > +		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER, "failed to get rproc\n");
> 
> I'd like to think this doesn't really change the behavior, but I'd rather
> see this that in-house print functions..
> 

I'm having problems parsing your sentence. Are you saying you rather see
us keep using the ath11k_* functions?

> 
> >  	ab_ahb->tgt_rproc = prproc;
> >  
> >  	return 0;
> > @@ -1190,10 +1188,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
> >  	ath11k_ahb_init_qmi_ce_config(ab);
> >  
> >  	ret = ath11k_core_get_rproc(ab);
> > -	if (ret) {
> > -		ath11k_err(ab, "failed to get rproc: %d\n", ret);
> > +	if (ret)
> >  		goto err_ce_free;
> > -	}
> 
> If the rproc handle is unavailable at this point, we undo quite a bit of work
> in .probe.. would it make sense to move this check way above?
> 

Given that devlink doesn't covers this, but presumably cover several of
the above resources, I think that would make sense. It would be a
separate patch regardless...

Regards,
Bjorn

> Konrad

