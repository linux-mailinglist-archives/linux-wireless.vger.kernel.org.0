Return-Path: <linux-wireless+bounces-36744-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CABaFq+pDmr6AwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36744-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:43:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF059F958
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84133004635
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683E3955E2;
	Thu, 21 May 2026 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGbvrLaL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLEJkKJd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E653356A38
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345662; cv=none; b=sR+tyM+koNptXABsL8ZgPiZ2MW70dc66Kvqw75bCMkPQdkA+/qmajwghazMbQF8e9yi3yxKi+Mg8oYjJ9VKSzsYsjdQRXGAqAHbw+zQnSDP9rLqQRqqA09s6tVUU/XeKCOW68il82fqmLlnKj0t7SBmmp7j0DL1vP6/9SJBlrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345662; c=relaxed/simple;
	bh=Bg3wv+G7Rugf8pCuJ1KGip4ySS7+uJ2LCfo3GU+OnGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAdy9e8HFWIBacDB8ak2TLJuU5rHhGcitqIGvOMexdUSE7PCs3l1V09VA/9dX//fooT7e77WtJ9OhT+0U12BuyeI5Py/zTPAWuXFVIKVIiDLsLyjSquoCxjHuxqfu3gITpQxyCXPlWnlorA9uIR23Qi1V4gmyUso5pC/nNsUwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGbvrLaL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NLEJkKJd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6Pdor1798819
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=; b=pGbvrLaL78us87ZC
	qoWvxsv7V2INxu/+LYewLf/Dj9+tEUXahR+lOB1X0Jn6fABWHOWTXz9IjuiptX63
	LDHkSGIRTxjXwrGYwGXEnQeETck4YSzpAKVmctSzjxA3Q5MHR1sSW2h8P3AO3uIB
	olClDTEjvs2c6UwO6AWstv3MzUE/DaqWAMcx/rbLwes0tAHjMYdL9Ju1yvFsH4td
	FamEMvDSnYWQQAPHrWkbljA26w1wV12BpCN7fks9DapiFsrMUxOlofal82eKGD9O
	y/eg1qOLPXIDCixysfptgpB//Pt+S6sQhrBHY1FLK4Go4EQ8hqIV9bfHbMLRiMF+
	EAoVPQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu3j6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:40:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so58539125ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779345658; x=1779950458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=;
        b=NLEJkKJdNGk9hNab8JbNRaIeDsk1OJMuHzQsZDsTH1WkQZb/8fYkbAGJWoqQKEcmb8
         ZNjqpkBErqQjXUFjXuM3LC/ue3K2zVbC30Ym3Hdlb1uBdDyPdULQsV95QM2MfPNa/Chh
         fN9j04129tWz9HAPYhOAO2JJyqUkCKSeU/5M4Q/D+qrC/1DmUNqbaXF8ZVdlIrz54VY1
         KThMvvmALegLIM/QXLmQhQibZdgJWhyzquHqtOdKXThxc2VRTeFUBQxHPeA6dlCi6ikc
         1Q1cvoK27goHL3o6ezhIenvI7h4tC5t3OIv7WDoT2kDLzb502VYARlIsen+TqYYzIIQe
         7x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345658; x=1779950458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=;
        b=hb89S1/4JuRvESpwZmnNdgR3QONchLdL6D92r7Q0VLmMqUJsga+R1RHjKfW0SWK8Jb
         0+YydHQWyV/W1Dcn6sLDAfGpngimECqhAj+mhVAjzMmrUe3hFjFHIsOJTFWKf4H1BgWx
         KI7xQ03JBX51rfAiB+LXIXLkWAz2rmlO0C/FRxwKT97ZX0nLBoxQI3UQk+JWbTnCghl9
         zT/U52ubVSPBrLZf5CK3B8Hhse66WRRUg3bUe35y3o5sfM5ZByd5+qqJSWGZmfM7zUmU
         NJ/xWj44ICZB19XXDVKRI5Oor5WRWu5aRbJiYugckdmW7aIIdVwSbaxyx3exmo+27Cum
         a8Cg==
X-Forwarded-Encrypted: i=1; AFNElJ8NEYX4CJOnywEc/H+nWAMOJZANpp4Obi9EoLRsfJX+U9KpNtsIfKHJCROlrjfniiDySDKQQDj6Za3hQ1jRwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDAK/yFI0LHPrYW76mmylRx+ERKbLk6kz4MBZUH6mbdlL+dQj
	L9+T6JuxpErYIWIIlRk0rDmEnqakWEENb1IYuj7Vjt8HG4GPQBT08ibKcXuQrF7fhplaVLkLY3X
	ulc3rKDp6F3Jw5KSpidw731Tp0yDYcHaRut9S/wfdf27Dca2EEVhAUcnVhDme6Eglta1JJw==
X-Gm-Gg: Acq92OFy6PM4i0NdbFZRl9mWz0aeA1E+MO3EIKR9Ht7Py2y2z7/swhLwKi5jZgvJXhu
	ots/4Oy58fthYU1iNDqW74rhogyEzQLzNwpmqa64mEl+H/t9q8iQ7nEr8uX1f0N+KZ/8tdNM/I2
	yWYdLGqGQmGAilI8nJdb3bZHHs8XIc0+mdiyexGsWOU4tH9XyPXjY1mu7wtYFKizUHy3nXmCtEZ
	xXA++UaCCDjOHaIvgekK2RM5VyOrs0CkT3CDer9OO2nyGe7g8P6mtusxPwDwVtu+dBvpXY+ODGx
	UntbW7uurVqfHtqsFllaPHpejuMEhaTmZnLnNA/HhWa1AYOljuzVZ0h6RSOZX3Ia55bTv5GuyYO
	hUzVbRdE21UUH/IxHl7P/Ufig2zcqkDVYhXLx2ZguP6ZInynAw6VnH6fN
X-Received: by 2002:a17:902:db07:b0:2bd:9a27:70f1 with SMTP id d9443c01a7336-2bea3367915mr15247485ad.30.1779345658563;
        Wed, 20 May 2026 23:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:2bd:9a27:70f1 with SMTP id d9443c01a7336-2bea3367915mr15246705ad.30.1779345657978;
        Wed, 20 May 2026 23:40:57 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8698sm234673925ad.40.2026.05.20.23.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 23:40:57 -0700 (PDT)
Message-ID: <07cdbd20-f0c5-4be5-878a-ef23dc633767@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:10:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>, pgujjula@qti.qualcomm.com
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-12-sumit.garg@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260518072856.22790-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MSBTYWx0ZWRfX928EwD7VwQtP
 h0H7UFzq9AQnxH/2YM0ZO64+rnsxywGofSLweSu0wU9/KyqOPOqrJLLx2soKB8AuImbi4xGWX8r
 dCMVYsgEf2FClE6O+5MgTi2WLaN8eunlI8+1mLns5YU86oYEGIxbccFsvVmLGk4TmN6OCwxv9bd
 p8nRuqBxgtu6ffScPQnTflNtsAO4BU8e7bnVFr2jp2gm8A9DRzSWaAA3C0VHGQwmSBt2GX0KEFc
 whRP8VqgDv97ekvyC1Hr60i+rNHF1cPqAT7A+9MFH/z/U4bpexbG6soTBtOh/BU9IlMrZjYs6uW
 xI82qJoSCImmdUP7pqDNjrp7GNCbeKtd6gvcNae1l5x0GxrGLZUS/xJv/pnw6VflFNw0CREh7EO
 y69PRL2tQ6pAO1bMl1+H7gEZWy87n2X8RRdljWCRp8LMO5GnnqiGesflIWg+6ZbVt5KZmqKS5R5
 wpgUm7BQV1QJjXIOTwA==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0ea8fb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=X+kW/DRse7pI7A4riirJBw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=WXTWxIQM56r_4Oy2wpoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: lhz_tsejSeSUnJy1BXq2ktKh7xbDMORa
X-Proofpoint-ORIG-GUID: lhz_tsejSeSUnJy1BXq2ktKh7xbDMORa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210061
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36744-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikash.garodia@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B5EF059F958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/18/2026 12:58 PM, Sumit Garg wrote:
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..b3c5281aea91 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/of_address.h>
>   #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>   		return -ENOMEM;
>   	}
>   
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>   	if (ret)  {
>   		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>   		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>   						     cp_config->cp_nonpixel_size);
>   		if (ret) {
>   			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>   			return ret;
>   		}
>   	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>   
>   int iris_fw_unload(struct iris_core *core)
>   {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>   }
>   
>   int iris_set_hw_state(struct iris_core *core, bool resume)
>   {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, 0);
>   }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index 63ee8c78dc6d..7997b8aa427a 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>   	select OF_DYNAMIC if ARCH_QCOM
>   	select QCOM_MDT_LOADER
>   	select QCOM_SCM
> +	select QCOM_PAS
>   	select VIDEOBUF2_DMA_CONTIG
>   	select V4L2_MEM2MEM_DEV
>   	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3a38ff985822 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>   #include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/sizes.h>
>   #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>   	int ret;
>   
>   	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, 0);
>   		if (resume && ret == -EINVAL)
>   			ret = 0;
>   		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>   	int ret;
>   
>   	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>   		return -EPROBE_DEFER;
>   
>   	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>   	core->fw.mem_phys = mem_phys;
>   
>   	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>   	else
>   		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>   
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>   						     res->cp_nonpixel_start,
>   						     res->cp_nonpixel_size);
>   		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>   			dev_err(dev, "set virtual address ranges fail (%d)\n",
>   				ret);
>   			return ret;


API "qcom_scm_mem_protect_video_var() would also need this migration, 
any reason not to consider that ?

Could you please check, if any such usage of legacy *scm* APIs, like the 
one i pointed above, can be enforced to err out at compile time ?

Regards,
Vikash

