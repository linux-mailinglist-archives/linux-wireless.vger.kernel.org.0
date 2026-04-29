Return-Path: <linux-wireless+bounces-35618-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PJpI1oI8mnhmwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35618-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:32:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10978494DF9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF5530DE932
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40953FCB2D;
	Wed, 29 Apr 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQYPFip/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghYWj/AE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23893F7AB7
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469132; cv=none; b=PzxEsIIWzqrlxdAmX+lGTPvIkobsobo72CmxfULEKXml2isAhEnGwWqFNn6pQpGspsivA0h6jzkdlugaJ1i+Mh8x35L/U95VeBINg1r96ymrKAUD6G8BGthBKZD01Ylj4p4SA+58O49DOKnSsq6lWduHgQyk8X7DBioZgt7bN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469132; c=relaxed/simple;
	bh=MgBynsG615Gay9WuPdHInOpVB6+mXWxzVoohqxlsbEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPS15sg7wgwwXZX5nwHI18M8LhGjvlZK2ymbRlwwxEpqXFY3FAztQhiULt8gDp4X3FXfaADe8geQMBTbegvb8aKiuQRemS2465x7MwCN08BJVAxCFbqLdr1mWU4YAUo/JxmAU7De2dbR2ajCNsdwIvg8y43LSujTbg+G36Ia7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQYPFip/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghYWj/AE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pulx3752544
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tESQm7/a22Cxh8QWHH7UiC0w
	dXJ6q1GIcYXgrhUKjnI=; b=DQYPFip/26hMD9exGNiQGhlON3S2bUV+8JfEYY9J
	Zx8ygITz/GtbM469Eq0PdgOS2noAWfj2Sra+9IJKYoatpUNmxT2vk/EsA/zewz2f
	THlpaOd9s5w5FK9gJadkUJhwBybrPpVTrPDBCChPn7ppTjgtxcjVg7F8obba83nV
	77cLKYPNgxlpc8k8OudwNa5NpdrfDgrI5yeoXlvjSJLCFfJIU7YcMa5bLJmoW2Sg
	ia/16AVPOY++1fIkbEzclcTHiZgEntPqkZ4Rh5OYP7CsqWjZ1Jx7GfTpA57LYOOx
	LUXrkAuHeqmYafFkaYwgBfiYgxjLHaEybXL/AE//v8vRBA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1hnut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:25:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a90510a6d1so6688215ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777469129; x=1778073929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tESQm7/a22Cxh8QWHH7UiC0wdXJ6q1GIcYXgrhUKjnI=;
        b=ghYWj/AE+KXRIK0lqI3fOapYN0VEEX+0vlgjOsWv6mM5EiwKwWWmTVn48X3D+yj4P7
         6oXnjEpw6fN+gk1mO7vNiMe2UWlDm7qW72bC2NHXdGmlEkt83jkywSwQMotPIbOhqr+c
         iqRh+edv8tEck5cS+HecL2npN6M5V/gSntABouoUDusjt19ORtuY/ygRh09epIoIDdWJ
         dMmKOXwbFd+7qU4zwoG1Csrx4G11Y9MU6/3lV4sGyQzehIB6gJzCFC40WeLrGHawiEOu
         Ckef5PlCDI76xk8dOzzZD1uf+cLonZyFOcytmxhf6msfu0vBnTm4LLtnaIND1N11CRwb
         V0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469129; x=1778073929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tESQm7/a22Cxh8QWHH7UiC0wdXJ6q1GIcYXgrhUKjnI=;
        b=NjwhPttAvJ5xMSNtJitmcUt6glhC+zl+6F+SQBMsoCHJuV7Iea3duRLq6WtmHRynYq
         SczZSxhSp5H6S1nQ8eK5gRFeMsYb78o9Ia3sjPMh0KZupVgzX1Lia5bfIrpxobIPiZ6F
         np/dqbH+kYmWaFRlLYKeb8a1OpNdqxluSwf0DPbEi/7X1xFIm0qad8CVvUSTyCECwjDt
         1GXQySJB0FTyT7wNMTR9iWxQ2XF00asnE3bRLfQs6/65i+kin8i2svC7cGUg1E8DKDhF
         PWPmR0c4UYWPIby+Bh/XshdxLjjNNIkABLRO0BPtWyoBkgu+/0cbvhTvmFiHchNRqstR
         36+w==
X-Forwarded-Encrypted: i=1; AFNElJ/03/DcoBwN9aiceooRna6W5BVv4YAbkdTCp04HYMvX9Q3PLAsZ0JFAXVVDXVOTjQUE02RhNyxZVj3EDWPZDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwziyPm0sK8ClFxbNuIynrRl4z2XpflLv/W82xbgFT+OOQhcxcc
	8hGrrr1GdbgOmJwkh6k2l63LeLQLTVUpjkewtob6Y14g7oz4A/RYouPEo9tQR9GH3ioA4aDD4zM
	lSC2qluZDmBwHcEFJPNmqM2oDcJO3DqZIbVzEE7hWcOKxP2ZHcq73qQ4AVREySHuWqy+gYw==
X-Gm-Gg: AeBDiesLpQRfgwmpcPlT/ILCDqL9SUqeNlAVjAgeZcYK6rxTS02nbto8zTW+HsAl3nw
	iEoTkXlKtFeXyE8ezgM3qglR8Z99LLCskx3IQtlKSIAThscWeOAQZEejO+6KIoaVlHcRMEZQXtO
	M/ElznwfBxWycU3CTlGa7lwqkx4QUS5o7F2i409e6nFmcH1DqXDoBHhummZVjziKnX2qDKZWgjf
	sJ5+dxX/hANG9j8V0DBAZjF3NZy+uBxmD10MpcpcY9yPm5O74GZiFzFHSH0++7GFcpg9d39p3EN
	szhO6EaXWUSUC1gEFaq7luriFB0P6NaS50OE317XdgK7R1wqXTNRznY+sLXYtC55dKcIwDMuNZo
	HT6lnSpdnKR4N1c5gdIRqigg2ojGZwF6lTGCiDjg0TQB28nxrd8CJiQVXrbw=
X-Received: by 2002:a17:902:ef06:b0:2b9:6cde:c345 with SMTP id d9443c01a7336-2b98823923cmr28867115ad.18.1777469128669;
        Wed, 29 Apr 2026 06:25:28 -0700 (PDT)
X-Received: by 2002:a17:902:ef06:b0:2b9:6cde:c345 with SMTP id d9443c01a7336-2b98823923cmr28866375ad.18.1777469128039;
        Wed, 29 Apr 2026 06:25:28 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f4e7sm24343015ad.39.2026.04.29.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:25:27 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:55:12 +0530
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
Subject: Re: [PATCH v4 05/15] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
Message-ID: <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-6-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-6-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f206c9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=OiisSXWjcB2wRZQgg0QA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNiBTYWx0ZWRfX1GLK2mIzM6h/
 3b9rkY3NZbC+49yWyrZi1Ce2W/cPk+cHmX+vitKDkvNhNrX3DCxELfWIuASOs7SvzXkdKwRsHPm
 RmB2VMioHfBbXJsK4ltkKHIPTidU5vwIvyv3VW1fnHIC0HIUJSjyDfXpypzn6Ibu1v3thpK3eGk
 oKqw7u/YiuV7CvKGo0FIUem1djbRuMIZXPOotIBMoCPdNdOv19zK1qj+ltwkJjwkvLOxfJgfodp
 xcCgxXPpq4F5UPKip9uHg50hc16NAtgHGMZhX5JStW/7XC/4zc1l6+V47orLYW0lBRHEAomG5W1
 1l5kPQpbbpsjZonI1Uiz0f/LeFpPxo8TreuCtA03wMBHZO54t7Vnn8LAEwIvrM3ENQJQ9ZFDT6w
 ZY9J77v8rJ6/k8ZyxwfyC844wxUardd8h/Sq6rg/8v8QMG2mXI7Dx1t0MRqfxBODj6DBQyXznqg
 hfygtp34wnq2YYoTMcg==
X-Proofpoint-GUID: gfmzy7jBQJn_g70_ZajjJmEPvMoSjM3o
X-Proofpoint-ORIG-GUID: gfmzy7jBQJn_g70_ZajjJmEPvMoSjM3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290136
X-Rspamd-Queue-Id: 10978494DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35618-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:53PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 51 +++++++++++++++---------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index da27d1d3c9da..847249c28c1b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

Can you check do we really need this header ?

>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> @@ -118,8 +119,8 @@ struct qcom_pas {
>  	struct qcom_rproc_ssr ssr_subdev;
>  	struct qcom_sysmon *sysmon;
>  
> -	struct qcom_scm_pas_context *pas_ctx;
> -	struct qcom_scm_pas_context *dtb_pas_ctx;
> +	struct qcom_pas_context *pas_ctx;
> +	struct qcom_pas_context *dtb_pas_ctx;
>  };
>  
>  static void qcom_pas_segment_dump(struct rproc *rproc,
> @@ -196,7 +197,7 @@ static int qcom_pas_shutdown_poll_decrypt(struct qcom_pas *pas)
>  
>  	do {
>  		msleep(QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS);
> -		ret = qcom_scm_pas_shutdown(pas->pas_id);
> +		ret = qcom_pas_shutdown(pas->pas_id);
>  	} while (ret == -EINVAL && --retry_num);
>  
>  	return ret;
> @@ -212,9 +213,9 @@ static int qcom_pas_unprepare(struct rproc *rproc)
>  	 * auth_and_reset() was successful, but in other cases clean it up
>  	 * here.
>  	 */
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  	return 0;
>  }
> @@ -228,9 +229,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
>  	pas->firmware = fw;
>  
>  	if (pas->lite_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_pas_id);
> +		qcom_pas_shutdown(pas->lite_pas_id);
>  	if (pas->lite_dtb_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
> +		qcom_pas_shutdown(pas->lite_dtb_pas_id);
>  
>  	if (pas->dtb_pas_id) {
>  		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
> @@ -250,7 +251,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  
>  release_dtb_metadata:
> -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  	release_firmware(pas->dtb_firmware);
>  
>  	return ret;
> @@ -310,7 +311,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  		if (ret)
>  			goto disable_px_supply;
>  
> -		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> +		ret = qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
>  		if (ret) {
>  			dev_err(pas->dev,
>  				"failed to authenticate dtb image and release reset\n");
> @@ -329,7 +330,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  	if (ret)
>  		goto release_pas_metadata;
>  
> -	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
> +	ret = qcom_pas_prepare_and_auth_reset(pas->pas_ctx);
>  	if (ret) {
>  		dev_err(pas->dev,
>  			"failed to authenticate image and release reset\n");
> @@ -339,13 +340,13 @@ static int qcom_pas_start(struct rproc *rproc)
>  	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
>  	if (ret == -ETIMEDOUT) {
>  		dev_err(pas->dev, "start timed out\n");
> -		qcom_scm_pas_shutdown(pas->pas_id);
> +		qcom_pas_shutdown(pas->pas_id);
>  		goto unmap_carveout;
>  	}
>  
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  	/* firmware is used to pass reference from qcom_pas_start(), drop it now */
>  	pas->firmware = NULL;
> @@ -355,9 +356,9 @@ static int qcom_pas_start(struct rproc *rproc)
>  unmap_carveout:
>  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
>  release_pas_metadata:
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  unmap_dtb_carveout:
>  	if (pas->dtb_pas_id)
> @@ -406,7 +407,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  	if (ret == -ETIMEDOUT)
>  		dev_err(pas->dev, "timed out on wait\n");
>  
> -	ret = qcom_scm_pas_shutdown(pas->pas_id);
> +	ret = qcom_pas_shutdown(pas->pas_id);
>  	if (ret && pas->decrypt_shutdown)
>  		ret = qcom_pas_shutdown_poll_decrypt(pas);
>  
> @@ -414,7 +415,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  		dev_err(pas->dev, "failed to shutdown: %d\n", ret);
>  
>  	if (pas->dtb_pas_id) {
> -		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
> +		ret = qcom_pas_shutdown(pas->dtb_pas_id);
>  		if (ret)
>  			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
>  
> @@ -484,11 +485,11 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
>  	 *
>  	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
>  	 * or not and if it is not having then we pass NULL and zero as input resource
> -	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
> +	 * table pointer and size respectively to the argument of qcom_pas_get_rsc_table()
>  	 * and this is even true for Qualcomm remote processor who does follow remoteproc
>  	 * framework.
>  	 */
> -	output_rt = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> +	output_rt = qcom_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
>  	ret = IS_ERR(output_rt) ? PTR_ERR(output_rt) : 0;
>  	if (ret) {
>  		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
> @@ -746,7 +747,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
>  	fw_name = desc->firmware_name;
> @@ -838,16 +839,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  
>  	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
>  
> -	pas->pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
> -						       pas->mem_phys, pas->mem_size);
> +	pas->pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
> +						   pas->mem_phys, pas->mem_size);
>  	if (IS_ERR(pas->pas_ctx)) {
>  		ret = PTR_ERR(pas->pas_ctx);
>  		goto remove_ssr_sysmon;
>  	}
>  
> -	pas->dtb_pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> -							   pas->dtb_mem_phys,
> -							   pas->dtb_mem_size);
> +	pas->dtb_pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> +						       pas->dtb_mem_phys,
> +						       pas->dtb_mem_size);
>  	if (IS_ERR(pas->dtb_pas_ctx)) {
>  		ret = PTR_ERR(pas->dtb_pas_ctx);
>  		goto remove_ssr_sysmon;
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
-- 
-Mukesh Ojha

