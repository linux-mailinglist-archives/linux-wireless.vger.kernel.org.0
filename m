Return-Path: <linux-wireless+bounces-36006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNFRKmsq+2lAXAMAu9opvQ
	(envelope-from <linux-wireless+bounces-36006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 13:47:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A54D9D93
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24240300D303
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC443DA49;
	Wed,  6 May 2026 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK9Rzoig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175B426686;
	Wed,  6 May 2026 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067908; cv=none; b=unnZQDwjJH85Z06A4YOq4wY0ZuAvvsy1SHriXhP4cOA7kGqjXrcR7ffH+b9bOcnFTsviJsT4WZA1wegQwJdAD/X9d7+81FqgmzAJ5TA4DrdLn206l1XFmlDy1Sb/XqJWOc4ISVtyDchFK1ayg56XGNbSaFmnWgC8uOzQ5mds3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067908; c=relaxed/simple;
	bh=hhTrGP4S/BXwCHAiPhtKUBT3aM5H12HQDgaM3WyB8SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwaRt/WL54xGv3z5pz4pvrBJB7sBMmGQxySIPpq32nimsnDU5kTNXf5TU367gHC2gav1yu9zSM0hTRjP7e2wFe9gKYtVnzU4q0l2CeXxv5yVK/75yUu5JRwbhbOPNCKI56mXWE2+FY2b8lRUlyIn6SiC1dT266q0vG1fQBMQaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK9Rzoig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E248C2BCB8;
	Wed,  6 May 2026 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778067907;
	bh=hhTrGP4S/BXwCHAiPhtKUBT3aM5H12HQDgaM3WyB8SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK9RzoigiB1D3DXGs/HNMPpy5luVXNjQDMJ/gNJwQwvD3QX5cwaaDXLByrbYh0rD7
	 unldqglV7SpdVuXWY+NgLy2tFLcj1HLkdrYiuAfhotSgVMFmyVebpugEr32x4ihMc0
	 /tOg24M8MPx0qFmabWfnU+kelwaO+lTgzJKEa2z6qkJ7YGiJg6aNwzN4jGpgCTc8oc
	 NVhfIHljXCC/NcCUwAOnt7rBjjzZnbCv+41BW+iXoF7z+oYkX7+01Kuy8XgtzhiqEs
	 2wR7jxsdr6NctbnKkN145c3AfMYB1T4A8mwdhnVOx2bukV3wZrjpRg2SdK/mGdfwkf
	 QLBVpImLnNOrQ==
Date: Wed, 6 May 2026 17:14:50 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
	Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
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
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
Message-ID: <afspsrA8zT8Fb4z-@sumit-xelite>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
 <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
 <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
X-Rspamd-Queue-Id: 455A54D9D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36006-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 07:50:03AM -0700, Jeff Johnson wrote:
> On 5/5/2026 7:27 AM, Jeff Johnson wrote:
> > On 5/4/2026 6:06 AM, Sumit Garg wrote:
> >> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
> >>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
> >>  			 ATH12K_AHB_UPD_SWID;
> >>  		/* Release the firmware */
> >> -		ret = qcom_scm_pas_shutdown(pasid);
> >> +		ret = qcom_pas_shutdown(pasid);
> >>  		if (ret)
> >> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> >> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
> >>  				   ab_ahb->userpd_id);
> > 
> > at some point the "ret" param was dropped, and this now generates build warnings
> The 'ret' param was dropped by:
> 8fb66931fe31 ("wifi: ath12k: Enable IPQ5424 WiFi device support")
> 
> Not sure if that was on purpose or accidental. Sowmiya?
> 
> -       if (ret)
> -               ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
> -                          ab_ahb->userpd_id, ret);
> ...
> +               if (ret)
> +                       ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> +                                  ab_ahb->userpd_id);
>

Ah I see, not sure why I didn't see any build issues in the defconfig
builds. Maybe this driver isn't enabled there?

Anyhow I can add the "ret" back here.

-Sumit

