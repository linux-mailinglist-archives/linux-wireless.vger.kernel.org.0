Return-Path: <linux-wireless+bounces-35630-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PfCIwsM8mkynQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35630-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:47:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D949515F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39F0D3002899
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC13FFAA7;
	Wed, 29 Apr 2026 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGzhSXE9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVuZO9+/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1833EBF18
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470233; cv=none; b=FHx8dF9RfdKtWHZemAwoHdfJVEtUKI5h+yoHp1jfWhSjjTl1AODn+tHgSccR7inX1+mQBQ5Mqr3aiD4BQPC25oNqWN7Zi0XI/brY9phv75DgZRtsreGbjUs+Y9+SgtV/Yo6eMpKoyflg7MGrH3Rzbsy7XUQTmiDuw7beptruFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470233; c=relaxed/simple;
	bh=+f2W0byu+VgJjsIBhy66bJHyN85fytLh2R/43wSGVUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDUwU4IDi2lxigpWRt6X2O3u1MxPzyxjl3eQxPeo6uWgENPlknO6Sof02/Cagq2aklyqZbTxUGKNJjfwQxdU3yx05TyLD/nlaWYvWEMFO7NPO4ddo/6FqRAyNi37CX4rPRLe36PTKaWQFdkpxGscRJfxIUV3MheS0Un87QqtwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGzhSXE9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kVuZO9+/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q0wE963229
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cuo4xCs+Nso8hPGN5nUCptMR
	sALAnh0wyrAaKAyxQ3Y=; b=UGzhSXE9TYwEoCe3o5G9PQphC8ttYY26Fo2LF0O5
	+66oGW0pUoGEOA6LZOG3uPuBclDYD3+Goy39d6kRD8bPKycGbACg/ZIsruC4EbW7
	LkOmnmtGJo20nIPdCJW4B137JylhFtiJ/Kyixc/X+z0gTrF203Ly7o/Nhhc2sVaL
	EzfLVO+pO3UCZHmCuycIN/CtAZAcz4LcuVeiUAAtCnh4fFLawDXoIZZeYi5yZT+I
	czUD3cguivawcB2g2tnYE+vVGgBRGuLh3FUE3+ZHjwETRXOnAUVcvaEkE5tgl732
	JJnQl5xEZ4x28C0O6SbW+PhJ6Vd/871B7ZfqnV6zwChS/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4ukyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:43:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso109814555ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777470225; x=1778075025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cuo4xCs+Nso8hPGN5nUCptMRsALAnh0wyrAaKAyxQ3Y=;
        b=kVuZO9+/mul2fENUabxZwULBLhpUaAH+T6gtUn5xTCTKVw9gZPePgJqz8Aov2UsxTw
         tBqmoqTr/9suz1a2+Ass3svmqUUcctuKJ9eElt6+YccyQLb+R8kqmIrIA/mTi/ZkmlmV
         bOIKERMT5UCROenKn3suHuolNd2F4N4rUZ4WJoB4Kt9/Zv6zQZKv8UAH1lZmyNpNOWoP
         R+hoD//j+vZrSLOgYnSHmTZ97/Wkki+xkc5r1/A597xveZleDjd5eTQz0K+PxCcxGxa5
         3h7iIRjuQQuIhQ2tYCrnq5Dts1uHbuhKHJhoqjBa+qUx0LmIe8h6ZEYuL4h0DRB3v6xc
         RtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470225; x=1778075025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cuo4xCs+Nso8hPGN5nUCptMRsALAnh0wyrAaKAyxQ3Y=;
        b=QRkDULYG3HrnbB5f5uaGqRp/9tSQV3Sn0QLlV59rrm1R3IzpI5OyNt6ApZyl1yKIEO
         8VWxGlQxABlnZbLFKf+EbBpb8pR/znq7XIou4Mn9Z49lQOrNO7MuhdTae5d7ouHpGutC
         IqPh1w6C5a2kfgUUZf8zNISWq0FCyTrUVADnxlE/oILLO3bvLqHdQmOYSG445JXGPpnr
         hGW4y2h3u3yRNkgQSFHODMDQJt9WuXu2ohK3bOCmy4CCm0tgfBiVkInR2/cjiqE96ZGt
         EKDeMntEtCw6hcMArvH8u3OPTMoxx4KmInHV891fFuuIcuBm9+u2ObeAZgC15O81Dyq4
         +YFA==
X-Forwarded-Encrypted: i=1; AFNElJ/6D5ngHO+ET+r4TV7+C1vXzpX/pKmpPxDd4CXM3Xy0WyVbOnr2XlkgW2ExCFnHcP4I2RpfCOdbiTDcvwwJug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQeitNBZrUhxg5R5sRx7jl5N6D0HIvzzGp7Qf/P6YLlF0idYI
	dSPizPVgEUIEJ58GH3NdnXQ3cDP66sQAR8ZoPkx7V9agXdsSe4HXjHIh69YFfRT9ok7MW2aA7fA
	F3PAX6EqBkOvwWFu0yLuJAzDT0cEDtxBsL9OoHIw4siNOs8zaCmyRkq4Wocr/K6HrXCjJQA==
X-Gm-Gg: AeBDietd/t/ctfbb5riuzpJlqkstc3E4yweh6z/zjpviZaTKb2lxJwbf86ePYE++4JR
	rjVF5mIjMy30dB5bWgWvHT7P3Gj0W5hh47EfyTBfdr1s4sxAejl5PUVTXXq0RQ0Hf7KJA8+cC5k
	6i2OeHFXSGA27vB5XqWJlGgeKqmWiQySMpP98wu25vYfvzR0SyMKhLCVsZhJ8lUa+6uzRZRbpvs
	BfYVGacDjOD355Mm/HC8ie+Mivdejnkoy1QY3Aye9Q+7de6NOs+YizTI0Dx8e630zTlfuys9+QY
	RcIKXZDDNJXJyilHpIZ5WnadX1pmJor+9+UxQRViBwd6e99djGZxV2hqdZBO19uoJaxx5VBEcb4
	ujNKoQJc59LGoLYxZ+sHSaecfmq+hXgxf5izLZvnna0xcwXCIaiY6lJ6nYzg=
X-Received: by 2002:a17:90b:268f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3649202ea13mr7870173a91.17.1777470224421;
        Wed, 29 Apr 2026 06:43:44 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3649202ea13mr7870101a91.17.1777470223790;
        Wed, 29 Apr 2026 06:43:43 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0115143sm3071343a91.3.2026.04.29.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:43:43 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:13:27 +0530
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 08/15] remoteproc: qcom_wcnss: Switch to generic PAS
 TZ APIs
Message-ID: <20260429134327.mna45febpcpakfbl@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-9-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-9-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzOSBTYWx0ZWRfXzwqvaZxngiAv
 FpUvjsxNTA8FMS49dMpuGA7gwJhocZNAUT6TwlTb162/4C4p8HKi4eVyM+C84tE+nylAo41aKM6
 YA/mlQih4SfVrLLVIUZs3TflmFyvnLyIFL9AIl0+Wqvt5Ic4KaGFwEVdEyf7a158hyFExGISYBA
 fm87Af7qAtBiq5ki0AJTEhpnSuK0hNR9NUVsKng5tbRArSdTY//65MX7FGiGcNYT6GJRVAf0/h+
 2UOCnoxKAWJRfVgIVajWeqqvZ14jjagNqrTcMwVMSLSEpO/zhiQf2Pv++Y5bpV5oUC/CaFjq7lg
 hstITXiRnZuiaphc63dfgc1uTKc1hcq3m0X/qfuWehHci5DePjY3q58D0sNIsnzyhoIMbmUWt+s
 BisE/AaxaXNi0S/+B2sK+JcLiGVQtJzVwMDj3iCy1gyUih7WJH9ETsjfGhswZv3Ddt9LGh3vSVs
 FrLPn3kvJIe9Po0wbcw==
X-Proofpoint-GUID: G9FiRQmPefPWEFIpEPT_4LmYvykuETme
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f20b11 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=FjfCcBgXQK_UEADaTeYA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: G9FiRQmPefPWEFIpEPT_4LmYvykuETme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290139
X-Rspamd-Queue-Id: 5F0D949515F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35630-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:56PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_wcnss.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 4add9037dbd5..0dbdd18ab3dd 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -19,7 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -257,7 +257,7 @@ static int wcnss_start(struct rproc *rproc)
>  	wcnss_indicate_nv_download(wcnss);
>  	wcnss_configure_iris(wcnss);
>  
> -	ret = qcom_scm_pas_auth_and_reset(WCNSS_PAS_ID);
> +	ret = qcom_pas_auth_and_reset(WCNSS_PAS_ID);
>  	if (ret) {
>  		dev_err(wcnss->dev,
>  			"failed to authenticate image and release reset\n");
> @@ -269,7 +269,7 @@ static int wcnss_start(struct rproc *rproc)
>  	if (wcnss->ready_irq > 0 && ret == 0) {
>  		/* We have a ready_irq, but it didn't fire in time. */
>  		dev_err(wcnss->dev, "start timed out\n");
> -		qcom_scm_pas_shutdown(WCNSS_PAS_ID);
> +		qcom_pas_shutdown(WCNSS_PAS_ID);
>  		ret = -ETIMEDOUT;
>  		goto disable_iris;
>  	}
> @@ -311,7 +311,7 @@ static int wcnss_stop(struct rproc *rproc)
>  					    0);
>  	}
>  
> -	ret = qcom_scm_pas_shutdown(WCNSS_PAS_ID);
> +	ret = qcom_pas_shutdown(WCNSS_PAS_ID);
>  	if (ret)
>  		dev_err(wcnss->dev, "failed to shutdown: %d\n", ret);
>  
> @@ -557,10 +557,10 @@ static int wcnss_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(&pdev->dev);
>  
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
> -	if (!qcom_scm_pas_supported(WCNSS_PAS_ID)) {
> +	if (!qcom_pas_supported(WCNSS_PAS_ID)) {
>  		dev_err(&pdev->dev, "PAS is not available for WCNSS\n");
>  		return -ENXIO;
>  	}

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

