Return-Path: <linux-wireless+bounces-34367-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIzIMkuc02mrjgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34367-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 13:43:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6A3A31F2
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B2EE301385C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCCE33260D;
	Mon,  6 Apr 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEwkjpkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186C153BE9;
	Mon,  6 Apr 2026 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775475780; cv=none; b=h8Te5bBtV4QVR23KndBXyQc0os1Eu9f+uID/pnk61A/plrunhAn5/OmUSvPKVSrpajOThIz9pxPo/QINEdS1XLutZC2eMDeHgiIWENvZ6eb6Zt7MN76SIyxk+snwTP6VVSJ7Q2kw/1NL8nrriNEUW4pCZsJ6Ux3ta0JVgqA/rSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775475780; c=relaxed/simple;
	bh=FGRHUXyR+0IYeCGEAzCaangJ4UIXGFGgJFbwE4z892Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnQsDCXTavBN/Tm/+F1kKE3/t+DkL3UIbDbmTic164eCWznorYRbpGG9m+b3XOHlku2Fgi19+clKxZUrVjXvq3KW139xV+VhGOC7wCEiv4yVUH784xxVwecqzo6R6/q35T6aBnyXIROTjQXIY7RJYnXcNjblX5LVrskjKspJzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEwkjpkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F7C4CEF7;
	Mon,  6 Apr 2026 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775475779;
	bh=FGRHUXyR+0IYeCGEAzCaangJ4UIXGFGgJFbwE4z892Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEwkjpkgZJJUgzLAMipZqb7S3m6PFvmEe1MRqsi12pNbrWPbTPr+/ozV0WB4e3kwc
	 wUFFUuEvlco8X0oM3WIbq9yPqBJEUoDRTdYVLYUFB2rLHKjh8gNzdqJKD/ZZA+/iG9
	 1xttCsrneXaxcIrBL9n1jqQndgGGSU6R9UiOuHMqxrC6g8cjPDhBpYAasm+A5RKcHR
	 nV9r4Cclk4K062pas6X6TeGAxUgQ9hdOz1Jzos5uBp1OPKQb3IZujuUKw/GO3+cLck
	 va/Idz0NKezYCEsD/GzpcK2QssI9WrYqRPMFymOo9jE/73sGxbCzQuYHAdNKM1hmip
	 dP8d3gB/fbK0A==
Date: Mon, 6 Apr 2026 17:12:42 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
	vikash.garodia@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch,
	dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <adOcMsk8a_Clb4WZ@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac-KQ7e8-syph1Zl@trex>
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
	TAGGED_FROM(0.00)[bounces-34367-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49B6A3A31F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jorge,

On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> On 27/03/26 18:40:39, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> 
> OP-TEE based PAS service relies on the linux driver to configure the
> iommu (just as it is done on the no_tz case). This generic patch does
> not cover that requirement.

That's exactly the reason why the kodiak EL2 dtso disables venus by
default in patch #1 due to missing IOMMU configuration.

> 
> Because of that, it is probably better if the commit message doesnt
> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> implement the same restrictions that QTEE (ie, iommu configuration).

The scope for this patch is to just adopt the generic PAS layer without
affecting the client functionality.

> 
> I can send an RFC for OP-TEE support based on the integration work being
> carried out here [1]

@Vikash may know better details about support for IOMMU configuration
for venus since it's a generic functionality missing when Linux runs in
EL2 whether it's with QTEE or OP-TEE.

However, feel free to propose your work to initiate discussions again.

> 
> [1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

-Sumit

