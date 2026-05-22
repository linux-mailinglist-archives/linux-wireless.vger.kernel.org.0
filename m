Return-Path: <linux-wireless+bounces-36788-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACOvD/4EEGrQSgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36788-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:25:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01F5AFF72
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA9013010229
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 07:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642C38E8C4;
	Fri, 22 May 2026 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ0Md6du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA83905F8;
	Fri, 22 May 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434735; cv=none; b=G5zyycp9MpJazKWx39x4OSnlBEAvZ943jU+GI1nZUZeWoddEHDAjZuHxRCs701zEcLGyhbiQ5oauhUNEh54qqGVllj11uz5jeoFLwxgRB9f4a5o+sxM4FGqgVUUdBjO5IEu7YVxDWPQbczedyYqZJMae6l1Yb0Ljg5x3ESztt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434735; c=relaxed/simple;
	bh=DOvrmSPgKlxZCC7RbEphO179i76aYP0QFkgrS/bkgMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOP7OLrMdhfJw1CmP5Hw6DYR7cWNiE/dV2Ki1BkoC7T+yTnK9KXaZ/0SDgOc57hcc5UkVjQW0JLb1iM1BlfsmSdM2H0st2dZbzikvN7TpDM6Cca9IFyaY02Oe5ciaYDyNJ0dLGCSlDoIqzBrcv5qIycuCbsacs25kauNTWMiNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ0Md6du; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA79B1F00ADE;
	Fri, 22 May 2026 07:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779434733;
	bh=NyW+5g7DMTf1Y7Db+/rrVkUDzE+C2206FaaDl7KrUhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lJ0Md6duQ6sPRrIdwjugw9x6KqXsYx7A/mgn8Cm26WJcFPdIwrNirWmrk2y+oH2DM
	 nRv7+D4/S2JZp/c0qo9faz1evc/9eej9fLq963ZdIYUufsnOC2pMQ/13L13gggxNR3
	 EUeXdLQdS+9dclCJuCPVTSNZdvokzosq/nb6I/Qbhnz7JKjibv9yccuJHOmva5JwbO
	 hnHGt3w/xkw7QAbPEzDy7zNRl5g712M2FLXy235+wnO6t8lFKU3OgxRuwWcftpUw1a
	 3y3fJbv7Oy3hUuSWHdagmVRVVGStA5jyzIyeiXDnMUfK8/Ng3pFu4cVnUp9xxOYXR5
	 N56f0BQcFPhvg==
Date: Fri, 22 May 2026 12:55:15 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
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
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>, pgujjula@qti.qualcomm.com
Subject: Re: [PATCH v6 11/16] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <ahAE2_Eh-_H7ZtYq@sumit-xelite>
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-12-sumit.garg@kernel.org>
 <07cdbd20-f0c5-4be5-878a-ef23dc633767@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07cdbd20-f0c5-4be5-878a-ef23dc633767@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36788-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C01F5AFF72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vikash,

On Thu, May 21, 2026 at 12:10:41PM +0530, Vikash Garodia wrote:
> 
> On 5/18/2026 12:58 PM, Sumit Garg wrote:
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 5f408024e967..b3c5281aea91 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > @@ -4,6 +4,7 @@
> >    */
> >   #include <linux/firmware.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >   #include <linux/firmware/qcom/qcom_scm.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_reserved_mem.h>
> > @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
> >   		return -ENOMEM;
> >   	}
> > -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> > +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
> >   	if (ret)  {
> >   		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> >   		return ret;
> > @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
> >   						     cp_config->cp_nonpixel_size);
> >   		if (ret) {
> >   			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> > -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
> >   			return ret;
> >   		}
> >   	}
> > @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
> >   int iris_fw_unload(struct iris_core *core)
> >   {
> > -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
> >   }
> >   int iris_set_hw_state(struct iris_core *core, bool resume)
> >   {
> > -	return qcom_scm_set_remote_state(resume, 0);
> > +	return qcom_pas_set_remote_state(resume, 0);
> >   }
> > diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> > index 63ee8c78dc6d..7997b8aa427a 100644
> > --- a/drivers/media/platform/qcom/venus/Kconfig
> > +++ b/drivers/media/platform/qcom/venus/Kconfig
> > @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
> >   	select OF_DYNAMIC if ARCH_QCOM
> >   	select QCOM_MDT_LOADER
> >   	select QCOM_SCM
> > +	select QCOM_PAS
> >   	select VIDEOBUF2_DMA_CONTIG
> >   	select V4L2_MEM2MEM_DEV
> >   	help
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 1de7436713ed..3a38ff985822 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/of_reserved_mem.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/of_device.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >   #include <linux/firmware/qcom/qcom_scm.h>
> >   #include <linux/sizes.h>
> >   #include <linux/soc/qcom/mdt_loader.h>
> > @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
> >   	int ret;
> >   	if (core->use_tz) {
> > -		ret = qcom_scm_set_remote_state(resume, 0);
> > +		ret = qcom_pas_set_remote_state(resume, 0);
> >   		if (resume && ret == -EINVAL)
> >   			ret = 0;
> >   		return ret;
> > @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
> >   	int ret;
> >   	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> > -	    (core->use_tz && !qcom_scm_is_available()))
> > +	    (core->use_tz && !qcom_pas_is_available()))
> >   		return -EPROBE_DEFER;
> >   	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> > @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
> >   	core->fw.mem_phys = mem_phys;
> >   	if (core->use_tz)
> > -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> > +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> >   	else
> >   		ret = venus_boot_no_tz(core, mem_phys, mem_size);
> > @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
> >   						     res->cp_nonpixel_start,
> >   						     res->cp_nonpixel_size);
> >   		if (ret) {
> > -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> > +			qcom_pas_shutdown(VENUS_PAS_ID);
> >   			dev_err(dev, "set virtual address ranges fail (%d)\n",
> >   				ret);
> >   			return ret;
> 
> 
> API "qcom_scm_mem_protect_video_var() would also need this migration, any
> reason not to consider that ?

This SCM call is very specific to the media subsystem and don't align
with the generic PAS APIs. I rather think these kind of special SMCs can
rather be treated as SiP calls supported in TF-A but we have to analyze
if we even need these SCM calls for the open boot stack or not.

However, with OP-TEE there is still work in progress to enable media upstream
as Jorge posted in earlier versions on this patch-set due to IOMMU dependency.

> 
> Could you please check, if any such usage of legacy *scm* APIs, like the one
> i pointed above, can be enforced to err out at compile time ?

It will error out at runtime automatically since TF-A doesn't support
this SCM/SMC call as of now.

-Sumit

