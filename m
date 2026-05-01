Return-Path: <linux-wireless+bounces-35751-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH6uEMay9GnVDgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35751-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 16:03:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EB4AD039
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 16:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDC943024A5A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45693BFE4C;
	Fri,  1 May 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIohrFyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB36256C70;
	Fri,  1 May 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643945; cv=none; b=MIOyrcTQGFDbV0i4fi0jA4RoE2p5qrmfRrpbic1DW+w9Nw+6n7aOcLEiSkmLISMwa+oBYiq9B/u8sxYq1O7eHv9oMZM9K8IW3i3eKEIj+QeQ/I6b9r5GZ+E0aNk+FRwttuV3ttboXsPUkca8UeIvqnq65pSXxDKbIjfK1/hyzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643945; c=relaxed/simple;
	bh=pyGGj8CgYj8YKM+1n+ffgeaGs4n29YMxEkBJUo1PKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhVREL/bDpmyeSYCA8jqyhssEkmU4KibBq0fdg6eSi5v1lH0BdAuGMOUw1L2EXfwkulz0zalZ4SeucGh4wqRrrw1IVpAuWNLH/+PmtrrR6Xb3eDORqxWE9kDksYHAACrbMhP/Ob1iO3d51NmXAS7JN3qTxutEUcBjKggHTlCQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIohrFyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A28EC2BCB4;
	Fri,  1 May 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777643945;
	bh=pyGGj8CgYj8YKM+1n+ffgeaGs4n29YMxEkBJUo1PKMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIohrFybibBQ29JXyaKkk7tpR9SY33a1ULDEXYO0ggJZPVBGjV4kol4a3Oo5KcigC
	 vvl9rtpktZmkYOvK0ZanKn5pBn6I40+FNXlG6+Q0fDXt4fhrSahOTWeDeIRNvDgAnr
	 qDfcMkpOLtgmvARVrNbe0mo8GqgtIXcSiA9pijs0QRaex7NWmA3+rEhaS4Lf7PSUmf
	 l21wV01YBfLy+sLbcNH30NUp0eRR29R3odnhq/LXGzgCEJ5UkDgZxxIFufJWtzHLv8
	 9lpiqvzMaJU41PHE5LzQZ5BOt4WzIJJADN2rcjfT6oC6zaFI9Mexu3hhwSvCsrIBBx
	 Wbtz6RzKcrZGA==
Date: Fri, 1 May 2026 19:28:48 +0530
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
Subject: Re: [PATCH v4 06/15] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
Message-ID: <afSxmNWWgvPkcMXT@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-7-sumit.garg@kernel.org>
 <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Queue-Id: 9E7EB4AD039
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
	TAGGED_FROM(0.00)[bounces-35751-lists,linux-wireless=lfdr.de];
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

On Wed, Apr 29, 2026 at 07:01:57PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:54PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > index ae78f5c7c1b6..96888007faa8 100644
> > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > @@ -34,6 +34,7 @@
> >  #include "qcom_pil_info.h"
> >  #include "qcom_q6v5.h"
> >  
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> 
> same here., whether it is needed now ?

Ditto, needed for qcom_scm_assign_mem().

> 
> >  
> >  #define MPSS_CRASH_REASON_SMEM		421
> > @@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >  	}
> >  
> >  	if (qproc->need_pas_mem_setup) {
> > -		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> > +		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> >  		if (ret) {
> >  			dev_err(qproc->dev,
> >  				"setting up mpss memory failed: %d\n", ret);
> > @@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
> >  	if (!desc)
> >  		return -EINVAL;
> >  
> > -	if (desc->need_mem_protection && !qcom_scm_is_available())
> > +	if (desc->need_mem_protection && !qcom_pas_is_available())
> >  		return -EPROBE_DEFER;
> >  
> >  	mba_image = desc->hexagon_mba_image;
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks.

-Sumit

