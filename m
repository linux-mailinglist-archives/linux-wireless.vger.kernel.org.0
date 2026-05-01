Return-Path: <linux-wireless+bounces-35754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC7CKrS09GlaDwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 16:12:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF24AD244
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A36301AA5F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324D3C13F0;
	Fri,  1 May 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxgY0soV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD63A6EFF;
	Fri,  1 May 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644710; cv=none; b=ckRJVAa08IryTJntWqlnPSnMiUk3ZT/6x8GY6okV32GLK2N3gwVeiLfLba6nUZzB83p8sepGJarjXMmu5K2bDFGI+fOmAEc0Q5MLNHFGiYYCsjmqZW8Rn1wqE2t0nn03KlRJJ9A0HXkBHH3c+bMjfgT9hM+T3/WBRFWikIYzzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644710; c=relaxed/simple;
	bh=hcyctBNRRAQk+0InkpxlCS1lfZhqWYkgfIjb+wBB1nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCAnlhmzY/WOyMTU3pSHd27Snq6E8nvf4UdGESxThaYSqwwfBQ5SrwZuJu95bVg8XcAGfsL9gs3RfO03m8l4xHNM7+9jR3GOb9XM36WT5CYwKg7/Hik1dEmaDMATtnMObdpbhtQ+TQ8xxsdWFhlghV6c8KGgxVqP+cSRPo0TNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxgY0soV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B196C2BCB4;
	Fri,  1 May 2026 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777644709;
	bh=hcyctBNRRAQk+0InkpxlCS1lfZhqWYkgfIjb+wBB1nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxgY0soVS2v6o2/czfldpnU5z90SDBiFfUg0+Lx9jN4IzjA78vFM0PA7EuR7QtUXv
	 KTzVa20tzAgAgsyr+quSek2TYMS0jvllCBPIqOuE8JJ3IGSigLNnPV4LJT72OGMwmA
	 0uWuf+WHwYuQXVvG+9BEibd7pyALC0voy0vyK9NtFGm0frPZm/vioEzems/XFfz7Rz
	 +nriz1HsGO4t63crYPzKRzCKKyOO6qieoVJ3y+aVRM/FqhfouayJevY3ERPy6ePxm4
	 3NcvH7LktzUYWJ/2wD4b0MC2sn3fxEj9Y8ue3HQ7RHle5pMlGmSxk1lUPCj8Xq1+o4
	 Bv8gyJQsH346Q==
Date: Fri, 1 May 2026 19:41:32 +0530
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
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <afS0lAnzVW9jHsxi@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-11-sumit.garg@kernel.org>
 <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Queue-Id: 5ADF24AD244
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
	TAGGED_FROM(0.00)[bounces-35754-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
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

On Wed, Apr 29, 2026 at 07:29:54PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:58PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gdrivers/gpu/drm/msm/Kconfigpu/drm/msm/Kconfig
> > index 250246f81ea9..09469d56513b 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -21,6 +21,7 @@ config DRM_MSM
> >  	select SHMEM
> >  	select TMPFS
> >  	select QCOM_SCM
> 
> do we need this ?

Yeah we do..

> 
> > +	select QCOM_PAS
> >  	select QCOM_UBWC_CONFIG
> >  	select WANT_DEV_COREDUMP
> >  	select SND_SOC_HDMI_CODEC if SND_SOC
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > index 79acae11154a..b556da823897 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -5,7 +5,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <linux/cpumask.h>
> > -#include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/nvmem-consumer.h>
> >  #include <linux/slab.h>
> > @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
> >  	if (adreno_is_a506(adreno_gpu))
> >  		return 0;
> >  
> > -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> > +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> >  	if (ret)
> >  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
> >  			gpu->name, ret);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 66f80f2d12f9..6d68edf0578c 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/ascii85.h>
> >  #include <linux/interconnect.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> 
> do we need this ?
> 

..needed for qcom_scm_set_gpu_smmu_aperture() API.

> >  #include <linux/kernel.h>
> >  #include <linux/of_reserved_mem.h>
> > @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  		goto out;
> >  
> >  	/* Send the image to the secure world */
> > -	ret = qcom_scm_pas_auth_and_reset(pasid);
> > +	ret = qcom_pas_auth_and_reset(pasid);
> >  
> >  	/*
> > -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> > +	 * If the pas call returns -EOPNOTSUPP we assume that this target
> >  	 * doesn't need/support the zap shader so quietly fail
> >  	 */
> >  	if (ret == -EOPNOTSUPP)
> > @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
> >  	if (!zap_available)
> >  		return -ENODEV;
> >  
> > -	/* We need SCM to be able to load the firmware */
> > -	if (!qcom_scm_is_available()) {
> > -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> > +	/* We need PAS to be able to load the firmware */
> > +	if (!qcom_pas_is_available()) {
> > +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
> >  		return -EPROBE_DEFER;
> >  	}
> >  
> > -- 
> > 2.51.0
> > 
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> 
> 

Thanks.

-Sumit

