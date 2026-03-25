Return-Path: <linux-wireless+bounces-33806-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F6ZH1pmw2nLqgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33806-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:36:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5731FB3C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8446B3054B94
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 04:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023E309DDF;
	Wed, 25 Mar 2026 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxXtUFqX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clDNrIpq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64452F9985
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413268; cv=none; b=fsFVLcv0NfxS0V3oostPulVc9ZN2wVfvcJ7DHaDiBxzcF5Cesw2bnak6skI8/okvwWVJ0QvFFxoJLYc/UJvMd/CFOOJarcMYfwa3d2OQlQM6bdA8kqbIEIs1JAYEyvMx/U0J++T0voLhYYv8DumwTdgUkvm4MlvvnHxbB79HncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413268; c=relaxed/simple;
	bh=HlMYOavZlom+8UZN2xckPAC6WFBM+19NyvW+PYf27tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpDSoD/DZi0fbbj5PZzpCCYmI+ar9Ic10ex/OYq2pGX4rBkxyWHdHFWaPhZNulaxSAyGY4Whf5bArIP0N37TT7Wa2dA9nCIUh9kMf6Bia2jpvkozLHXQXusjgUKBuLqr+jFybc99psrjZjIeeqGPfekBBrRkhGufkk9gdX4kaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxXtUFqX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=clDNrIpq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJOXkq1862459
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EHUp7/16YUMBtKGES+yYYqc2
	0LzNJsKIcI6vCitDSoc=; b=UxXtUFqX1/6g2nxsMa/K3D44muLA4QP/qfif7ikK
	0PfGqXPH2DkXPdFnv2JwH9dBZrMi+CJqXZ0Fx5kAQPk9xIyNvrptcTe2T39UgZRD
	PqQ9HCtVYJnygYaIfjzbz/TXWLO5j1HuJqsSRgROj20zluZNW1VYdXF495ZZnzmo
	kQW5B/W7yOkgLxG3oM1WyUL0pFOI4P4e6nmddPEUOF8OeK5190ahq1G2S+KRAZLx
	FjtOUwxDpHveFbF9HNRmUu11f7KytW5gnm2N/GHuedbMnGAxOs/bt4U7Z2UpMdLK
	7xeadyqyfvYZQ6/nJzG5hnrxVaUQfMPYQJzdZGp34rGkDA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rasdt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:34:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50917996cfaso133432261cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774413264; x=1775018064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHUp7/16YUMBtKGES+yYYqc20LzNJsKIcI6vCitDSoc=;
        b=clDNrIpqUCNGjlX/2AeX//JhDezeWoIJO2ftoDRICVxfp5pUwECWRovFwdRHJoX5ma
         UREm35ug8PJL87nkwPkXV587opJEB2FqAxVKXsBJRz6Ct209PLt6KGkuKv5E01O+L5Xw
         uXNuiXYiEC3hghzrsFrejaRJI1FnTAEU9gr4Z5rjESO22V2o1YmUT+dckBZ8vZYDzoIn
         zQSBuuWl4i6Dyhs2DYz+mcDLZR+O3YsI+bfjecoXMJBWcQtCIj7qejWut1oG7hG41D6Y
         Slq8G+unvxYxMOjK+F7CjBJ1YXfZ5pH7+0AEFQ52RE82s8k6+4tGJUSgVigyQ4jSDGmB
         QQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774413264; x=1775018064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHUp7/16YUMBtKGES+yYYqc20LzNJsKIcI6vCitDSoc=;
        b=FuXFVhS8gyTD8ydgPJvj/QzRF29iJUzH1nMV9jYF4QQZ+HwHpilnGB0cF0YqWacGGT
         5Txnr7TT4OHp9F8+vvVrYkYqGoGmXBlbXsyVaNcWGiXgqcrsAsm2zPKuuOL8sSJsOJoJ
         XRc+QRE2rJ6JaROLZHXdSFSw1CLRZa5QPgvpwawQWVwuPL4l7sdGr+Aspzqh51Nn0fKj
         RwKyhacfnncfr2VxpX9iaBkraRz5aXFVvAo4ARhpXupmYTk3Bn3iRdrGJYXBqcrQMjia
         sYNzKy0m8PJLeDHGp5XBnrAODptka4EK9OuJV6F5980pmGWEPiMrULMOROaIX5Ku/XAI
         guYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrNIDQUMSnklJfRhzi8Cn2m0/+sZ61qUcN7OEsL/j8FuzP3/ONheFF84YkfydZL3si6f2xflEA8OIdRAEn/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLpnIDObKBOFx4IGbGhqHUmU05fJ/mfsOIds2Lmk3ZFOlqNt6
	HwxI2JiEhgtDFBCyYuQt1SLob6V8UowRpSt3NzEr2h1FBgCSpMegQQi8VBfGfwW2RRldHXKbc+0
	N1PKUJgf2xZ5dt7mGLKaA8vGQAR9inLPn/wwlrCDuC1SE7BsjZxsH5eUab9E7cH8sLdI3tg==
X-Gm-Gg: ATEYQzzIy9sbkdLdjDFyRrEhWSKy2bNn7S+Ydq4ycVn96w+WG7JUbSkOCnS/87dugJD
	KXrpAngeAr8ySXUkg5QYsK9pXS448UtDGDrzHbEHoWkYKC8YjIJXI7kp7fT4tuoqamsSsOyrxA9
	NoQdF61X2DtEQROQF8jMppo+tDck+4XNlBWHhk8xZkoM85tIRTVkhZCCsa+SHwxEXOK9wkje46C
	EgqE9hmRvbi9/5q0FzlweR2IY6pTX7WJ7bJNwx5x1lf9bDH/NO9GChbfRcF5jc87lvHoqUp336u
	i5eaUsl05ByhdqRJ06VdficTgCf66rskWWjWB8GfiOxtk86aOELJYk5RA/34BWx3piWh1rYUDJh
	t7Rjs9NygEZYzhLMFncqg1jjfnyVk9Tlf1vXVeBtEjXyRnXylR4WhleTfQ9x6fFRMrUvUAqYv2e
	o3TUstHgMdfX+np4eP5CnL/NXJCMi3rxm9DXc=
X-Received: by 2002:a05:622a:4ce:b0:509:1987:7626 with SMTP id d75a77b69052e-50b80ed53b8mr28888261cf.68.1774413263880;
        Tue, 24 Mar 2026 21:34:23 -0700 (PDT)
X-Received: by 2002:a05:622a:4ce:b0:509:1987:7626 with SMTP id d75a77b69052e-50b80ed53b8mr28888091cf.68.1774413263409;
        Tue, 24 Mar 2026 21:34:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207500sm3648167e87.41.2026.03.24.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:34:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:34:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
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
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 10/14] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <v4ffww2r4ljqqbmvsc5jcr4ztqjbpfb42xryjeuz4abqiwup3a@2gfeelhjzzz4>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-11-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306105027.290375-11-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c365d0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=kPJGyq6PTXsXdZOMel8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: F054Vg68x-O0U6XvyE7HCzuSKXedpryX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyOCBTYWx0ZWRfX9KfOul4LRYcJ
 GBijbIKcoYo3UpihbhCDn8GHlzGZP7qFG6LJAsy8nimUiRmTS6tIXukvJvhjI7+Tmp3NmwOv1nH
 K9IpfpfcwTnTaDGkIr6Qd6/rwe9uFPbRvYG88vZEg8NZOzLWVPz/UqFICCRdax6L2op21zbnioi
 n6NA1N8L54+ZhDxa2zEXb7FF6mKouqp4BEwk/eWACA71ZkxSFOpFH8A3C3Kh2RceGmvgNDy3eJ7
 OnAuLxHzMiIK9WfXrmDW2wv6KijImejjriBTYKeiQElJMtud1HgZCUXlO5GOTRMspEXgN9yXxzr
 F0fwedMy/PnR0dSxytNAjNGtDqssaICOIifqRpQasPVGWcUIgU1/IMmmY4te1MZoQ5VTpQWpU1F
 3ifOrLkY/roTuRZQ2OxNE149ZN1frFSiP/RTSceOIEpWYhBM4sda3Y604hzHJXp+ip1mFre2VSQ
 d3rektlXXVG/ejffUQw==
X-Proofpoint-GUID: F054Vg68x-O0U6XvyE7HCzuSKXedpryX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250028
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33806-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35A5731FB3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 04:20:23PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index ef9fd6171af7..3283852f9a14 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>

Missing `select QCOM_PAS`.


>  #include <linux/pm_opp.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/slab.h>
> @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>  	if (adreno_is_a506(adreno_gpu))
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
>  	if (ret)
>  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
>  			gpu->name, ret);

-- 
With best wishes
Dmitry

