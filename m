Return-Path: <linux-wireless+bounces-32807-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FJQErimr2l2bQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32807-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 06:06:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D78245633
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 06:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27C9A304A56B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 05:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735E3BD63D;
	Tue, 10 Mar 2026 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDkpv5S/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8112BF3E2;
	Tue, 10 Mar 2026 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119116; cv=none; b=nn9xqZM6QKoRL4byhG0tKmQSTR1VUIn9uG7DQKulWtp+D9inhn7fve2VF6R3S4x7ndNHlCoSGlSOGOLWomXtFkIhz3SYT3tr51lmh0quSP0fIUZ0OGY4HckmCmt9ZFmz9qGZs+n4Y/zC1RStDdYc4FP1T7Bw+CI6du2m1A0ftoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119116; c=relaxed/simple;
	bh=2U0QJW1GAlzSLhrIMqY8NiJx4ObQV5OXd1GxUWWfmx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNtGHh4KSxOQwwALSucSUPAnWTOyjn18sM+ybuEcy0tMS8YNThy4PQDZI2jboO4pz4BO0Iv/gQRn7hi4ehSc2cqRIX4P3kboEc0mlZNFMEGujzQso5bD3Ku0H9i5BtG++8M3SuzpYz24+Ex3wq68iRiVWNMtPqbfrD1MHiA8IyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDkpv5S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470BAC19423;
	Tue, 10 Mar 2026 05:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773119116;
	bh=2U0QJW1GAlzSLhrIMqY8NiJx4ObQV5OXd1GxUWWfmx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDkpv5S/dhAYS41lOL8eQcR9GtZoGAD/xkpGuJcpwltHlzyfBouIvIEWoqbSs/Wsx
	 yl6HZjGTIgD4XeNbhrF8MZdbcG9xvx5FJXfxZYHLuZMBwX01gzKKIKyOV4DSh+mQgr
	 wJnQFQezVsAyDvkQqBZA7Y67hZ0v8AG3P4N9aBpsjmwKMAAsX96R3F4xxD2/+JGYNw
	 O+CiVvgDppcffVy9K2KbjQDj0b7Dvr2CP4mka7R73fm928CFJjhJjdIpzMvegQrass
	 Nlfhd4bIklNwUKvNaP8rT+kM3dHqh6OsULUC/lsx25hzqCFPQs6rQLUBCNhjV1eek2
	 9uUQheT5PpbEw==
Date: Tue, 10 Mar 2026 10:34:57 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
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
	pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 11/14] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <aa-meTJ4_xl4PKS0@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-12-sumit.garg@kernel.org>
 <aa6O5tir4kVIe0eZ@trex>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6O5tir4kVIe0eZ@trex>
X-Rspamd-Queue-Id: 07D78245633
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32807-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:12:06AM +0100, Jorge Ramirez wrote:
> On 06/03/26 16:20:24, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_firmware.c |  9 +++++----
> >  drivers/media/platform/qcom/venus/firmware.c     | 11 ++++++-----
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 5f408024e967..b3c5281aea91 100644
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
> 
> are the calls to set_remote_state required?
> 0 is not the IRIS/VENUS remote processor.
> 
> If it is legacy, maybe they can be phased out?

Vikash, Dikshita,

Do you know the background of this set_remote_state calls?

BTW, the scope of this patch-set is to not change existing subsystem
drivers behaviour but just to enable the generic PAS interface. So
any driver changes can be taken as a follow up work.

-Sumit

> 
> 
> >  int iris_set_hw_state(struct iris_core *core, bool resume)
> >  {
> > -	return qcom_scm_set_remote_state(resume, 0);
> > +	return qcom_pas_set_remote_state(resume, 0);
> >  }
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 1de7436713ed..3a38ff985822 100644
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
> > +		ret = qcom_pas_set_remote_state(resume, 0);
> >  		if (resume && ret == -EINVAL)
> >  			ret = 0;
> >  		return ret;
> 

