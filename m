Return-Path: <linux-wireless+bounces-35745-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GA/AjKq9GmBDQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35745-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 15:27:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFAF4ACB62
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968C5301A90C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC2139BFFE;
	Fri,  1 May 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks9s1mZI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCF33EF;
	Fri,  1 May 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642028; cv=none; b=BREC5jtlhomovGqd9l6K9zD5H9kDE8Hdt1HQSp99qobhGwleY/7zvacF8m8jbvA0VwUc0UO6Oz4imarLa5HOx+dwvSTl96V+aBuxAJkrsWvdfV3fNizlhNKJXij2oZ3a6BQV6tLqvCdGqVKKx76YV/xKmD2lsJG8wOwD4vv328w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642028; c=relaxed/simple;
	bh=cecY22npZ8O09cZUaB8M0VENwxo6jF899E2WK/sGM8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THfRSWzYKQdnMnc5FNa7S+Vjzn1hQfl2fslwufIumWFF2b8SqKWCrSk0pf6CV9zHgD/+fdIA3L9QTBDHs9AciGMztiIXF52bisv2RzpbuD7huiwASTMsT+rFaARq3uT2jfueX4ZUSxJhKWiLEbqM0kVdzghArdLPyoYBlO1skWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks9s1mZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09DDC2BCB4;
	Fri,  1 May 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777642028;
	bh=cecY22npZ8O09cZUaB8M0VENwxo6jF899E2WK/sGM8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks9s1mZIkV8HxwO4Mq2+M0rNhz33rtPZ+PEpQg8O0T7agTQM/ie+qo1rwFzMc+b+A
	 VqDH4/+JcAgC//FSDTXVNeTLY3ZnVf6ao0PPeE2eDyKLB70fqAtG1BZGKK4J4NwVYM
	 OfaQriqJVci3Be7SKDrYFRY61OXwF0wXPYEyzsVt5ayiFhEFxMW1q5daFboq3L7XMO
	 64Cx2hTxZcYCLazmmG5vv2hGIZnAcTrMTjhtB+7TrKmtFgXcpfm7HFnitN26O/Gx8U
	 JOUfHUQd9G+45ryjeV+BQBCvFltUxfgmsGCNc+KFS0VD58QfpBufJUzuhvutKP50DW
	 4FZ/nGOcO+OnA==
Date: Fri, 1 May 2026 18:56:50 +0530
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
Subject: Re: [PATCH v4 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <afSqGp-yzZip7q-j@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-12-sumit.garg@kernel.org>
 <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Queue-Id: 9CFAF4ACB62
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35745-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]

On Wed, Apr 29, 2026 at 01:07:14AM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:59PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Along with that pass proper PAS ID to set_remote_state API. As per testing
> > the SCM backend just ignores it while OP-TEE makes use of it to for proper
> > book keeping purpose.
> 
> When we use 'Along with' or 'while at it', patch is doing two things and
> not one.

Okay, I will split this into 2.

> 
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
> >  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
> >  drivers/media/platform/qcom/venus/Kconfig     |  1 +
> >  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
> >  4 files changed, 25 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> > index 3c803a05305a..f54b759c18aa 100644
> > --- a/drivers/media/platform/qcom/iris/Kconfig
> > +++ b/drivers/media/platform/qcom/iris/Kconfig
> > @@ -1,13 +1,14 @@
> >  config VIDEO_QCOM_IRIS
> > -        tristate "Qualcomm iris V4L2 decoder driver"
> > -        depends on VIDEO_DEV
> > -        depends on ARCH_QCOM || COMPILE_TEST
> > -        select V4L2_MEM2MEM_DEV
> > -        select QCOM_MDT_LOADER if ARCH_QCOM
> > -        select QCOM_SCM
> > -        select VIDEOBUF2_DMA_CONTIG
> > -        help
> > -          This is a V4L2 driver for Qualcomm iris video accelerator
> > -          hardware. It accelerates decoding operations on various
> > -          Qualcomm SoCs.
> > -          To compile this driver as a module choose m here.
> > +	tristate "Qualcomm iris V4L2 decoder driver"
> > +	depends on VIDEO_DEV
> > +	depends on ARCH_QCOM || COMPILE_TEST
> > +	select V4L2_MEM2MEM_DEV
> > +	select QCOM_MDT_LOADER if ARCH_QCOM
> > +	select QCOM_SCM
> > +	select QCOM_PAS
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	help
> > +	  This is a V4L2 driver for Qualcomm iris video accelerator
> > +	  hardware. It accelerates decoding operations on various
> > +	  Qualcomm SoCs.
> > +	  To compile this driver as a module choose m here.
> 
> Here, Space replaced by Tabs just for one line.., should be fine.

Yeah, spaces aren't meant here.

> 
> 
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 5f408024e967..856fa6a79064 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/firmware.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_reserved_mem.h>
> > @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> > +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
> >  	if (ret)  {
> >  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> >  		return ret;
> > @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
> >  						     cp_config->cp_nonpixel_size);
> >  		if (ret) {
> >  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> > -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
> >  			return ret;
> >  		}
> >  	}
> > @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
> >  
> >  int iris_fw_unload(struct iris_core *core)
> >  {
> > -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
> >  }
> >  
> >  int iris_set_hw_state(struct iris_core *core, bool resume)
> >  {
> > -	return qcom_scm_set_remote_state(resume, 0);
> > +	return qcom_pas_set_remote_state(resume, core->irisi_platform_data->pas_id);
> 
> 
> Should be a separate change for qcom_pas_set_remote_state()
> 
> >  }
> > diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> > index ffb731ecd48c..574172724e8f 100644
> > --- a/drivers/media/platform/qcom/venus/Kconfig
> > +++ b/drivers/media/platform/qcom/venus/Kconfig
> > @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
> >  	select OF_DYNAMIC if ARCH_QCOM
> >  	select QCOM_MDT_LOADER if ARCH_QCOM
> >  	select QCOM_SCM
> > +	select QCOM_PAS
> >  	select VIDEOBUF2_DMA_CONTIG
> >  	select V4L2_MEM2MEM_DEV
> >  	help
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 1de7436713ed..3c0727ea137d 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_device.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/sizes.h>
> >  #include <linux/soc/qcom/mdt_loader.h>
> > @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
> >  	int ret;
> >  
> >  	if (core->use_tz) {
> > -		ret = qcom_scm_set_remote_state(resume, 0);
> > +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
> 
> This too..
> 
> >  		if (resume && ret == -EINVAL)
> >  			ret = 0;
> >  		return ret;
> > @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
> >  	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> > -	    (core->use_tz && !qcom_scm_is_available()))
> > +	    (core->use_tz && !qcom_pas_is_available()))
> >  		return -EPROBE_DEFER;
> >  
> >  	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> > @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
> >  	core->fw.mem_phys = mem_phys;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> > +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> >  	else
> >  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
> >  
> > @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
> >  						     res->cp_nonpixel_start,
> >  						     res->cp_nonpixel_size);
> >  		if (ret) {
> > -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> > +			qcom_pas_shutdown(VENUS_PAS_ID);
> >  			dev_err(dev, "set virtual address ranges fail (%d)\n",
> >  				ret);
> >  			return ret;
> > @@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
> >  	int ret;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
> > +		ret = qcom_pas_shutdown(VENUS_PAS_ID);
> >  	else
> >  		ret = venus_shutdown_no_tz(core);
> >  
> > -- 
> > 2.51.0
> 
> with above change
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 

Thanks.

-Sumit

