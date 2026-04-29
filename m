Return-Path: <linux-wireless+bounces-35633-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPQzKpEQ8mmPngEAu9opvQ
	(envelope-from <linux-wireless+bounces-35633-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:07:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40892495575
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A667030B843A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B751A3160;
	Wed, 29 Apr 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZVjkz/bw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBnaAOXO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAA364E92
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471214; cv=none; b=XFyr7tPk66wSlpw/QWhGX9l/m3L3yUd4lTbm4vKMQ7tRB8+QcrGTk7LQxYqvgP5d673BuiKSV5Kb7Veg1uP6+/4Ed4T+X2o6cqXPhvHQDES448398eC5mJpW5jkK3qzMcb/71/BsRD9AGHIu084XlJyx3An/XTaxrA7TxlSmgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471214; c=relaxed/simple;
	bh=5yQPAUjn3VunEoidQeZB/XrTAnrzeavxXWZHanAVIvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtuJaUyVJMLpKgD9mCQ6JzubetPo0RhdPY/xUWAXTFl1zRlw5ukTdzeBM2NJ8XxqWhOzcbypJla+9ZXo/iWcAE/QPe7ie+f6TUcpkXjWHNFEE4j24Su25UkxOjUb4juEhJsS7wnbkuhofF6O9dUbx1RLCOaGKPfW9JHK3+mIV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZVjkz/bw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBnaAOXO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pnfY901607
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YKH9dv7wKtC1p8ZEO04m+kEL
	X8b+zwv/sQpT8PdfGig=; b=ZVjkz/bwitIknIzBQGGYWMnjd+c7U3oo1VDD3ojE
	amdiGSdp8vi58LpqyydYMnBfvL8uamZ8WIYrelSlx2yLPdTEBOa2u20SKht8H31S
	rCBw4E8wCS+ccd6xz/bLRB8HZ3sjjR/CxRL9FhkuuOOdnvzRrymGZEyukKJ/adAg
	VXFsgNc/BcJCVi9QDz5cbpgzNVQMrf9kHGqjuSMKWUA68mslDXOcT1Scn3oUrQ0N
	VnucAWp6lTQ0s2WEiNpo1fwxuo1B4dYbqmecD2AHb2BbvD0DiQg309g1Nz6CblUF
	emwubpt8x6BGtRXRW72mh8KyG5jTGgq91yiJJSyh+Yx8gQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9hyns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:00:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f07078ff0so8638053b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471211; x=1778076011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
        b=QBnaAOXObISyRoShr1qq3LCMGfheq2m30a+xsaNiJjaxhf3GFvGibEIAl6YTMvLE2I
         SH23IxtHf8QWqayT5wAhENVZqZuibr2J0tZ9nDc+90KZAK860Fl7F+WnGKtOp4bJhxUT
         fzBk7+Y7fQx5GVlzPPbmAv6BA3KBfModclTCG+bSMLVVbtdhgjaqG5X/8LMWyNH6kYj5
         ZqJAZ8l81F2k7fLBleLBNq2v3Eiwu/qSY9watkYlf/1B8svcaMrZHpUbuJ2QfFddqi+3
         Q36lV9YS4ArmIUo/fsM0W1ivL6dFCFTcCUvD0pC6B26aws/TcyQ32lwinhaMS24X0tqI
         waCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471211; x=1778076011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
        b=eScueMijwhaPYMqf2AlZkn/wLpznkIm0lh0IdaxXnuXqjFp4TT18q7SS5Q59N15JYa
         WnrQsPj1pQ/6goST9cWcn1QeGXj7TRU/E+nwW+KUzOa+/UQbVdOboU6m3RyVLPzD+tSA
         xwiosMnKdp1kq8LPKyyThsVVsNipQC7SUeAEFkOKET0VpwNcgQOD+eUW3eqlMZ2txp6q
         e47vKZkPPJ8AJJxsXGwXkzd1aWFT2uBDf+2osUKxq+LLLcyaRQtqePFJeqOy17DpWzX6
         BCqfUyRKXjAzj+gHxbRgvZoaEDk8Rh2glZhtSe42TQ/0L2lyzdx2hvSmfxA2x2SOlqc7
         FqAw==
X-Forwarded-Encrypted: i=1; AFNElJ/g66F1B0ZLO/5DJtge+GMFPbI3VL1h1IROVtm2/YTKD7kKN2ywbAAHTVS037tcHFQ3HpgRtfAmX92lhmWbYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yenRQaH3MUhiWA619GQsMlVm2vzldQBiFEJtqBD+YhDOB0YV
	J0zun7lBdXI/2omSf0lou1yoMM41bjLNXjufav2oll26lyhBKczEffYclTeblbLME0i3Klj78U4
	ji7cpgeuEZGbBoj7MK7f+c6H2XNtVRHZKlVDU9cEXMtCxsTDp8eJnaZVq7nFc8FQeZU/3Uw==
X-Gm-Gg: AeBDiesMXRm6V9QuF86wAzdyrDlWBkLt8w4us9E2HxSNK5cUg2Eq8SakjPgolHYJjdK
	RTZFZ0V1e0R5jIyuWNlBWqYxhGDhcrQiRFiWGQ1EtTXbq66j2XTCSPuJ0TVNP/YPUoznQURaInl
	aWyVi2FV7AnJe7a6YR4BOIGTIATGPGwwUHQ40FQqY8d4QTJcYyibykFW3XohpDwZ+c8mawfw5Pm
	mpxUMUGQMZvS0IucPikZtW0r3cl4brOFjsqLtvKrlZFZ9zDFBbZjhTIw5+O1XqjTR2FBDHLAUEL
	r+T9vl755VbupQgd5ndTNUd4GYtZcVNdTnxjA3/iv3mGi/GydMQvvNVGZ6GZTJOhERUznSyqSGC
	BrLPU2tojAZp5dC8DNBm/8G2dBZXW50lzv5tixS+uxQdjE139b8YenpUmNJM=
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8578697b3a.29.1777471211040;
        Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8578551b3a.29.1777471210136;
        Wed, 29 Apr 2026 07:00:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80ec94sm2268304b3a.52.2026.04.29.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:00:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:29:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
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
Message-ID: <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-11-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-11-sumit.garg@kernel.org>
X-Proofpoint-GUID: 9-p3CP2phcaqJi7ne02hY2ZyB41tgHu2
X-Proofpoint-ORIG-GUID: 9-p3CP2phcaqJi7ne02hY2ZyB41tgHu2
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f20eeb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=DQeyY4SaC-8ekjbwpG4A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MSBTYWx0ZWRfX3GQ+DXKUs1d0
 XjP1LtDbWzRPz5LUEU55Nv+sh2XQwFtSDaZsqh82qlGoB41JKwE8GROS6XG/ghC5jiIsIGRWWDJ
 OdHxjud/FmsYnRtGUgt+g0cH+R4amSfHNBfoNJAhl0FlpMUX1Fzqpdn57hxiXCxQBnP/1ZuCSZz
 W1japR5d6IcWZkEBlp2M4OlOmqYBAvxpBBd2GcL3+cgoaScb/c7Vm2PBTHx/X4JNtMrC4a39eN8
 DY9regmPl5J65gl3OYK5Y3jRX/mjEtn9kokn/5RGb3xkuP3KJxlxYjPkyMrvAKS84O7+M4jfIRl
 MzonM+XgTvgX95SwdlkruJCnaFD05WEmOvPKMwgWsBuECIMUxDOKIqOYT/+S5+eaNNn//a/MLi6
 meJdt8xKECw8e7J9EiPftZm/gEg+JME/CN0meWT4kJ4SIiJBd/c+imL6ue51tu+/w4EwXyiN5nd
 BmP4/rWKHqcfN5kHx8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290141
X-Rspamd-Queue-Id: 40892495575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35633-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:58PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gdrivers/gpu/drm/msm/Kconfigpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM

do we need this ?

> +	select QCOM_PAS
>  	select QCOM_UBWC_CONFIG
>  	select WANT_DEV_COREDUMP
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 79acae11154a..b556da823897 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
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
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 66f80f2d12f9..6d68edf0578c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/ascii85.h>
>  #include <linux/interconnect.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

do we need this ?

>  #include <linux/kernel.h>
>  #include <linux/of_reserved_mem.h>
> @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  		goto out;
>  
>  	/* Send the image to the secure world */
> -	ret = qcom_scm_pas_auth_and_reset(pasid);
> +	ret = qcom_pas_auth_and_reset(pasid);
>  
>  	/*
> -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> +	 * If the pas call returns -EOPNOTSUPP we assume that this target
>  	 * doesn't need/support the zap shader so quietly fail
>  	 */
>  	if (ret == -EOPNOTSUPP)
> @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
>  	if (!zap_available)
>  		return -ENODEV;
>  
> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
>  		return -EPROBE_DEFER;
>  	}
>  
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> 

-- 
-Mukesh Ojha

