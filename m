Return-Path: <linux-wireless+bounces-32731-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI17Kd9UrmlACQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32731-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 06:04:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9B233D56
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 06:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CE33036608
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016FB2D5C83;
	Mon,  9 Mar 2026 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kifEbwgH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BB27F01E;
	Mon,  9 Mar 2026 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032648; cv=none; b=jG0aE14htOs9xLsHx2QuzMpbaS7mS3XzDCbfaLPS2NFY2A/Bm/MXgP+dR1wF4NL12WBrT1QO+PLiiJ1WtihlEr8zoPmVk05HvSbwL7ZidsIsebh4JdfpcT1OWuD1uTfg66FxXwFqPf4TgRdYev/prupbWMUo2ysWz1CpL9uoMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032648; c=relaxed/simple;
	bh=nlljNcMEmbBFbwMlFYIHGVsIVpYN3RV0Ax1svPiwBxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9eZ2ogjxN8JhiD+O5n9+BBz1NEY+/luz1NFXYG2quHY7ZSiehuFz2EzRKUYALqMc5DqFG5VI56qU5L961ScXsa0Xp/9u0tBKiAyZ3yUKPyw3OspfFw27NIec+BPilxaKWtX8kG3vQXGQEDPKUQ0nneMTBjjKRrKzn8eKV9AK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kifEbwgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F1CC4CEF7;
	Mon,  9 Mar 2026 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773032648;
	bh=nlljNcMEmbBFbwMlFYIHGVsIVpYN3RV0Ax1svPiwBxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kifEbwgH38BQFm5WxRPTeN3CNvd4K+gkDSR75UnwaDfst+kFhLsxDZG1gwvv0J2zV
	 niepDzatZrDdxCyHDXvhhEYaaQDTaD9gHpvogArXx689+0dN/J0l163W+YpD1I7TTg
	 KoowqFeMkUjngRi6nIIGr6ofrkDkLXrijpMGjI44dDeljAI41dks9IHL49Qcbc2Jtx
	 EsgvJI3bOn0gaQgOvxo+NlrKVhm8I++VaArWtdCGv7V3J5RxvyJ0DpEE0gVbE3av+F
	 YXcofqmqvy7VrQqhyw3fGViE5VGK9u0SxRxFRyCohcNvIvvlghkKvcJ8/a4adVDxJr
	 2HH0J6B12cKPg==
Date: Mon, 9 Mar 2026 10:33:49 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
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
Message-ID: <aa5UtcfiIe78oj1S@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
X-Rspamd-Queue-Id: 51B9B233D56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32731-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 07:49:07AM -0800, Jeff Johnson wrote:
> On 3/6/2026 2:50 AM, Sumit Garg wrote:
> 
> I missed one k-doc warning...
> 
> > +/**
> > + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
> 
> s/scm_//
> 
> Warning: drivers/firmware/qcom/qcom_pas.c:173 expecting prototype for
> qcom_scm_pas_auth_and_reset(). Prototype was for qcom_pas_auth_and_reset() instead
> 

Thanks for the k-doc warnings report, I will fix them in the next
version.

-Sumit

> > + *				   and reset the remote processor
> > + * @pas_id:	peripheral authentication service id
> > + *
> > + * Return 0 on success.
> > + */
> > +int qcom_pas_auth_and_reset(u32 pas_id)
> > +{
> > +	if (ops_ptr)
> > +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> > +
> > +	return -ENODEV;
> > +}
> 

