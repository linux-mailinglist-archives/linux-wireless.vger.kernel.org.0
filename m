Return-Path: <linux-wireless+bounces-33715-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKMwLJYzwWm7RQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33715-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:35:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE352F1FAD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6393F3012B47
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B33A1A26;
	Mon, 23 Mar 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlhB9nVZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698E3AA182;
	Mon, 23 Mar 2026 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269329; cv=none; b=KPYrOOH+mtHRrcvBif28lYBPz/mXc7tNfK7/sQOiBLYZC3F2VQCoBg9+DP8TixQ8x5UsYfuuV53FxPJfEYMvbmU2wFsiLvSXO91Zx8+1ohpOBOA8zYb9KAMKvK158Ac5Rn0zCKIUz7r8OY0wQcOZZjOdiCFeh77mjnfh9nvG2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269329; c=relaxed/simple;
	bh=XApBBnOOJ5elwtHWxmuUDE0TpYF+/pV3i4s0gOrBn4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/dIvQQdqm28YGsQBYjDDMNBYD0R9vNObdKmp/cdG46UmHljJd48ppsWdepW5KF3ljc+vziuqSyy+8nixVxp3U5wStE16DvrwDYzjsPukB7RaOYaFcQCIbEONJP8WK40UwLiDVkUneyoHuc6llKzUspEy8GBi57TRuQi0acl4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlhB9nVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68E5C4CEF7;
	Mon, 23 Mar 2026 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774269328;
	bh=XApBBnOOJ5elwtHWxmuUDE0TpYF+/pV3i4s0gOrBn4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlhB9nVZJCPUurPUHX3n53uyZPTjebWMYxKOBXWmj7h7mKdR6Hw3Ja1TuoOUfAaAV
	 bdk9LheDCb+crooqJkKtSN1jcx5vyS1YmgbIu80kJKujowxa0JPBEirKu7b+Ij8aoP
	 UVPtnxT3E/isDy9NhWSnC8zaHLitzT7eKlMPhm6oTl94aqJWVsITJpHJUV3G+SL3DU
	 b+DY5ous6EJdv7oCGf38atKvYfY8Xfk1UDkxfHLFY+IqlT4gKFgEnyhPXZ2YiQ7o04
	 jD0Hy9szb3QpCy/nXiWhVc2r1n2GsUt2PIas9ZhDRGVUZn9isX6v1SvxUiH9O5lIo5
	 85o6XacVa8pUg==
Date: Mon, 23 Mar 2026 18:05:09 +0530
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
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 01/15] arm64: dts: qcom: kodiak: Add EL2 overlay
Message-ID: <acEzfd8I9UjByadc@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-2-sumit.garg@kernel.org>
 <20260313060451.hswg6snnnexchmzs@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313060451.hswg6snnnexchmzs@hu-mojha-hyd.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33715-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EE352F1FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:34:51AM +0530, Mukesh Ojha wrote:
> On Thu, Mar 12, 2026 at 11:57:42AM +0530, Sumit Garg wrote:
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
> 
> We may need to add for couple of more variants..

Sure, those can be follow up patches if Bjorn is happy to pick this one
independently.

> 
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
> 
> 
> rb3gen2 has modem as well, did we test that as well ?

OP-TEE don't have access to modem, it's locked down in XBL-SEC.

-Sumit

