Return-Path: <linux-wireless+bounces-38879-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iuPvL+9pUmofPgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38879-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 18:06:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172257421ED
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 18:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JBB6zLqW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38879-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38879-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CCE300EFAC
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4713C3BFF;
	Sat, 11 Jul 2026 16:06:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4152C324C;
	Sat, 11 Jul 2026 16:06:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785965; cv=none; b=hXAHtrOhaS0UVJtEhoWmAkp1XhbpK++fPx4tQtbvNE7Kz8AaKw0Dac/xV7nL5UsPDK/U4y92Y7K1I1viBcSDUggQ/SLTVm/DG1OMpnoQIfotgZYo2FUHOoIO3m5omRaT8pS560hM61J9Z+nJocMuu5mQ5UGiPZCha2oSCUAr/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785965; c=relaxed/simple;
	bh=uD5DnDsB2Bp6HpTtDJbnIWWRRIPNNoT6jh1apZ5JvH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prv0ZQgYIZ+OgUBNrZFsdm/K00Hiyg7vlCX1hGfmOBLuwxmJzQF8JTfIYmYXuvsDoc7gzismcm4xChdFZnEuQDY3GVY1atIfQHbx8cxLSyTKj5JrDfPi3z3Bwcxn9/5AeIzc9cuu2S2YMxn9CNMmFDojlpn0fsJVKSW4pgQEds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBB6zLqW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE971F000E9;
	Sat, 11 Jul 2026 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783785963;
	bh=A5MkcfUlQgcZIZ87E15KISjwZ+iXqXcxXpv2BzvWE1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JBB6zLqWtlhjlxDMFgkPkhmoc7sOsT+vS+CP/gZ2bfgNUfVQTesD8GdSKYQ2AiBQU
	 dWAPPUrgI5nvERDLvniDjRWXey/6eRpqUblAChLPH2swU/zTU/BupHqaE/TB0ZqPgb
	 ipfQEbFRsYj50B7tHfufaEv9wz1flAloN+eNqihx7EqOqYF0d1WMeQ4mkuynkv8DvM
	 DQilz1HMOkpkimp4GrBcdUgrex8iFAl+uxD4WUTKZHX5DxEeAQS1QTfUewDjcWGSI2
	 /6S/WrOeWLnA6LsZEjxIAsQSvG4XQ2R6brKw40zihkJmCDbRknE73tFunNqmTxqZCF
	 O8gbOeIuR93tw==
Date: Sat, 11 Jul 2026 11:05:53 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, 
	sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, 
	abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, 
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, 
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, 
	mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, 
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, 
	vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, 
	amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, 
	apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <alJpc3nFX9D7_8i1@baldur>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702115835.167602-10-sumit.garg@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@os
 s.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38879-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,baldur:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 172257421ED

On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 

Please find an immutable branch with the dependencies for this patch at:
  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org

Alternatively, if you think there will be no conflicting patches in the
time leading up to next merge window provide an Ack and I can pick this
through the qcom tree.

Thanks,
Bjorn

> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 27 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> index af78a1775937..388c9bbc8136 100644
> --- a/drivers/media/platform/qcom/iris/Kconfig
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -1,14 +1,15 @@
>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER
> -        select QCOM_SCM
> -        select QCOM_UBWC_CONFIG
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER
> +	select QCOM_SCM
> +	select QCOM_PAS
> +	select QCOM_UBWC_CONFIG
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  This is a V4L2 driver for Qualcomm iris video accelerator
> +	  hardware. It accelerates decoding operations on various
> +	  Qualcomm SoCs.
> +	  To compile this driver as a module choose m here.
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 1a476146d758..ea9654dd679e 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
> @@ -80,7 +81,7 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
>  
> -	ret = qcom_scm_pas_auth_and_reset(IRIS_PAS_ID);
> +	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;
> @@ -94,7 +95,7 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(IRIS_PAS_ID);
> +			qcom_pas_shutdown(IRIS_PAS_ID);
>  			return ret;
>  		}
>  	}
> @@ -104,10 +105,10 @@ int iris_fw_load(struct iris_core *core)
>  
>  int iris_fw_unload(struct iris_core *core)
>  {
> -	return qcom_scm_pas_shutdown(IRIS_PAS_ID);
> +	return qcom_pas_shutdown(IRIS_PAS_ID);
>  }
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, 0);
>  }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index 63ee8c78dc6d..7997b8aa427a 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>  	select OF_DYNAMIC if ARCH_QCOM
>  	select QCOM_MDT_LOADER
>  	select QCOM_SCM
> +	select QCOM_PAS
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV
>  	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3a38ff985822 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, 0);
>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>  		return -EPROBE_DEFER;
>  
>  	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys = mem_phys;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>  	else
>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>  
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>  						     res->cp_nonpixel_start,
>  						     res->cp_nonpixel_size);
>  		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>  			dev_err(dev, "set virtual address ranges fail (%d)\n",
>  				ret);
>  			return ret;
> @@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
>  	int ret;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +		ret = qcom_pas_shutdown(VENUS_PAS_ID);
>  	else
>  		ret = venus_shutdown_no_tz(core);
>  
> -- 
> 2.53.0
> 

