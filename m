Return-Path: <linux-wireless+bounces-35138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ19EcBx52ke8AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:46:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4F43AD34
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF62300FEE8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB53D0927;
	Tue, 21 Apr 2026 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKaBnixD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D12D7DD7;
	Tue, 21 Apr 2026 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775416; cv=none; b=Z/RJA7VoEHomJDUtnOGCbtBqM11eydryeYhGGzw4dUkAtKdQ/3CNWE/dNmpAQDKCBAH2TE3NX0R5aq4y4ICMvUZcmQxZuiw5GkOUs4c/xNzKUz8DbJwjXN/ScK5F9xjyAxL/VRPSz24SJrR7l9cxLIoVDRMFZdeluVlD7qoFEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775416; c=relaxed/simple;
	bh=+V8ZfRYrjzwJXgqe+fTwt5G7FKr8RN3Pd3uuU7wkOoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKr7vVxX4hhEK0b3nQQ2nPz1JUOr6GUKr+Go0FwCJgJsFf0vSNhbhbSZwemnchnDtYyHAal+tdCEqy7oC0aq40Fy80+6533TRdXIbjUGSjnc3VaUMXbYmbxjP7ATkF7PH5j0gC53MJquj5ReLXfseTO/9RlznoiBHXE+KQ9LLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKaBnixD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4193C2BCB0;
	Tue, 21 Apr 2026 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776775416;
	bh=+V8ZfRYrjzwJXgqe+fTwt5G7FKr8RN3Pd3uuU7wkOoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKaBnixDB559hSNI2VTzNUIPYmrAI6E00jRbjPrOokUf/IxdtI+SshEpQoAyenhw8
	 76rWm2uvZ8+hauZIvZZX6A7nFC0SxJ6kMrA9ulppvSD3C+FJ/CzVar45/8h/DB2zcv
	 YGLim2xCtfRLj1iQMqdaLuz8sX6dE1TTVXRbPe3a1uXohDZKA/UZJ6tPd6x5Wi16eZ
	 T0URH9Vv45mpbG6NaRuAGhxQYk5PnNi6nxmwsm5JkQwEWynXiz5ODq1PfIo++vls3p
	 MtaICJCnPo6Zj/5EBQN8gEOGsJsJFR+lVLiJOVhWYo/K5b9K+gK/6TjrA0rrben6Ud
	 sTHdoBBwGyulA==
Date: Tue, 21 Apr 2026 18:13:17 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
	vikash.garodia@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch,
	dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
	mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <aedw5VUJvwVkYfF5@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex>
 <adOcMsk8a_Clb4WZ@sumit-xelite>
 <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
 <adYElwM6eT5T8hZM@trex>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adYElwM6eT5T8hZM@trex>
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
	TAGGED_FROM(0.00)[bounces-35138-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9C4F43AD34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 09:32:39AM +0200, Jorge Ramirez wrote:
> On 07/04/26 15:14:22, Trilok Soni wrote:
> > On 4/6/2026 4:42 AM, Sumit Garg wrote:
> > > Hi Jorge,
> > > 
> > > On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> > >> On 27/03/26 18:40:39, Sumit Garg wrote:
> > >>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >>>
> > >>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > >>> TZ service allows to support multiple TZ implementation backends like QTEE
> > >>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > >>> backend service.
> > >>
> > >> OP-TEE based PAS service relies on the linux driver to configure the
> > >> iommu (just as it is done on the no_tz case). This generic patch does
> > >> not cover that requirement.
> > > 
> > > That's exactly the reason why the kodiak EL2 dtso disables venus by
> > > default in patch #1 due to missing IOMMU configuration.
> > > 
> > >>
> > >> Because of that, it is probably better if the commit message doesnt
> > >> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> > >> implement the same restrictions that QTEE (ie, iommu configuration).
> > > 
> > > The scope for this patch is to just adopt the generic PAS layer without
> > > affecting the client functionality.
> 
> the patchset cover letter + the commit message + the OP-TEE pull request
> being referenced gives the ilusion to users that with the current set
> they will get something functional (they will get a broken video
> platform instead if they try to use OP-TEE).
> 
> That was the point I was making: IMO the commit message walks on a thin
> line of "completeness"
> 
> QTEE and OP-TEE at this time implement different use cases (Venus with
> QTEE runs with Linux on EL1 , OP-TEE runs with Linux on EL2). So maybe
> worth mentioning this divergence.
> 

Sure, I can extend the cover letter to say media support with Linux at
EL2 is missing for both OP-TEE and QTEE which is being worked on as a
separate effort related to missing IOMMU support.

-Sumit

