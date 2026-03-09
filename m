Return-Path: <linux-wireless+bounces-32754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFlGGsyArmlfFQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:11:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B942355CA
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 460DA300BE15
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8536B053;
	Mon,  9 Mar 2026 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyIOucgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CA2EB0F;
	Mon,  9 Mar 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043797; cv=none; b=XzsHEQfs5saiqcZeYhGD+Dqziu5Liyf8GnG4ubUFMiR56qnke1H83t67ZKhQ1Jab0zF8KJRQ/ec0JtYAJHcG+VYQyinWTyiXslGux8YHWd6eA/PieCsQXs6iYUFMZkUCulKWAiaPTTpUbTnWRAsEKdfPSQHsoV8/MzDLgnFhVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043797; c=relaxed/simple;
	bh=32FowEX4GYXUvlI6q5fHoPOHKDUD+8ybU58sR9odc3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D234cCKP4pCTzYsBNN6XAbGaiTrJ6EamYs8ZAdwmzXr0K98V1+FmtYjfbQ15KviqAdcp7vcKYuZcvjj4UTmb0iQ9Wymi65WrmD6RSmMCpb7sm59czn9dQOK6bp8tIm1rX0hFwkUq8B236YHLlcE2TBoxda2akD4DhUBD7+3VUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyIOucgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4ADC4CEF7;
	Mon,  9 Mar 2026 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043797;
	bh=32FowEX4GYXUvlI6q5fHoPOHKDUD+8ybU58sR9odc3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyIOucgKAfmefa18DFYskVEvdTUmMUUmT8HnBszC9g+/3mu1ac4DRo0flCYJxEj76
	 p271mDlGTOPyxk4+0+GHdecUdSQAZOM+L8gTNBNBGZwQHPKV8vC1thWGJZPeZBX8pr
	 3X16t3RsqMIU6jLyG1xNhwWvWI5MieFe0lPzQJVGZ4F14tpOazzwn0lmuYQV9/WBGI
	 HbVW0WlB742mIaR5ZW5z1fUpVHoaFEKrkIJaxV8wBnVjVXySu/7AfHLJAFTi3Qe+Mc
	 W8hZg9dDIi4OWOFOSpENXZiP4Xr06c8ndff9g0yDDNCYcEa/Ggxfoc0bZVbfvGxE79
	 J4OdC2YwDMUEQ==
Date: Mon, 9 Mar 2026 13:39:38 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
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
	trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 01/14] arm64: dts: qcom: kodiak: Add EL2 overlay
Message-ID: <aa6AQtR4oEfomWPj@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-2-sumit.garg@kernel.org>
 <20260309080049.si3vzro4z6qn7ewz@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309080049.si3vzro4z6qn7ewz@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Queue-Id: 65B942355CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32754-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:url,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:30:49PM +0530, Mukesh Ojha wrote:
> On Fri, Mar 06, 2026 at 04:20:14PM +0530, Sumit Garg wrote:
> > From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > 
> > All the existing variants Kodiak boards are using Gunyah hypervisor
> > which means that, so far, Linux-based OS could only boot in EL1 on those
> > devices.  However, it is possible for us to boot Linux at EL2 on these
> > devices [1].
> > 
> > When running under Gunyah, the remote processor firmware IOMMU
> > streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
> > managed by the consumer of this DeviceTree. Therefore, describe the
> > firmware streams for each remote processor.
> > 
> > Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
> > devices to create -el2.dtb for each of them alongside "normal" dtb.
> > 
> > [1]
> > https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > [SG: watchdog fixup]
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Thanks for posting, I was about to add kodiak to the already existing
> list monaco, talos here
> https://lore.kernel.org/lkml/20260127-talos-el2-overlay-v2-0-b6a2266532c4@oss.qualcomm.com/
> 
> but did you really miss linux-kernel@vger.kernel.org or is it
> intentional ?

Ah I see, I missed that list. Will add in v2. BTW, this patch in the
series can be applied independently since it will work with existing
SCM interfaces provided by QTEE.

-Sumit

> 
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile        |  2 ++
> >  arch/arm64/boot/dts/qcom/kodiak-el2.dtso | 35 ++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index f80b5d9cf1e8..09a7f943190e 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -139,6 +139,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-radxa-dragon-q6a.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> > +qcs6490-rb3gen2-el2-dtbs := qcs6490-rb3gen2.dtb kodiak-el2.dtbo
> > +dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-el2.dtb
> >  
> >  qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
> >  qcs6490-rb3gen2-industrial-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo
> > diff --git a/arch/arm64/boot/dts/qcom/kodiak-el2.dtso b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> > new file mode 100644
> > index 000000000000..0b3a69a0d765
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Kodiak specific modifications required to boot in EL2.
> > + */
> > +
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&gpu_zap_shader {
> > +	status = "disabled";
> > +};
> > +
> > +&remoteproc_adsp {
> > +	iommus = <&apps_smmu 0x1800 0x0>;
> > +};
> > +
> > +&remoteproc_cdsp {
> > +	iommus = <&apps_smmu 0x11a0 0x0400>;
> > +};
> > +
> > +&remoteproc_wpss {
> > +	iommus = <&apps_smmu 0x1c03 0x1>,
> > +		 <&apps_smmu 0x1c83 0x1>;
> > +};
> > +
> > +&venus {
> > +	status = "disabled";
> > +};
> > +
> > +&watchdog {
> > +	status = "okay";
> > +};
> > -- 
> > 2.51.0
> > 
> 
> -- 
> -Mukesh Ojha
> 

