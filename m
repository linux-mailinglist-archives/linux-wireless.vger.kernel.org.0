Return-Path: <linux-wireless+bounces-32653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIqoOpIvq2n6aQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 20:48:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462D22736F
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 20:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EDF30879D0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1274301D2;
	Fri,  6 Mar 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TjQFsEg3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQeB0f6I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD13321D8
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826483; cv=none; b=m8Ov4gIb0UheuWgwYkX3CfIegKebnpGVo/R9bw0JMg+b+pvF/jpcebjnj4umqyzCM4TC0+Yjc0dEwauU3uBA9wmbNxb+hSSUe/HDvUcnNbOgvksyilGpu18r0CXtUf4RfY25tyho9p62M8SAy9gTjmNIiRCsDqapjC8fYVOXp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826483; c=relaxed/simple;
	bh=mlXqdU7Y+gm2DOh3IThXNBMGtYMXThi8ndZw5gyS2ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbbf+VTkBIechEKXWXTWdr9Q0/uSnlPaSrx1DSswh4m4ZAMQzAgESbLqRZG/rIT9W1Cm2DRHqOYkssGag8F6VELY9lub0XS/v/+zuDDTgKUBpyfVPu9khyzYFBl8ezdboVT22SjH2PMLGWaSHMzi9Bf7+XJn5o5Zde6QRe6d4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TjQFsEg3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PQeB0f6I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626H1mIL667899
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 19:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QI/LADBID+jqzAG3mtTdzJ4YzKT2Vu+d+JqTnL3p4aA=; b=TjQFsEg3+52Tkgyi
	+ks4OzAhzjzC/ve69IAeOdZ3dw7LnExFJpYA3gwtJqFOHtIxvVfjWINpZo/mvCNZ
	qEzNY4yw1XmiCEJ2889/fO7ULT1v2kXmg/34ipzGwCGTM/c8/sHFjvmhWxt4WK+l
	Z0aGz+D8+CQ9vklqjVtwmjC1j2nVkpNKBRH/ZtYoQQFz/krB2m0Dp6hPzAjxSIV5
	YsFbVBoQ2whPIInkv3cbSf7mrNAEbH+hBWy6xo/jCzgc1WAtFcj4DQ3DS5w3Hc+m
	NZmf46s+W1wKeZUw18EnGWiHmqUGAICtkD0thCP6sr6n0r/dNtrNihYKzngVcOX4
	NfDHew==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr2ye0je6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 19:47:59 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-127337c8e52so67509144c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772826479; x=1773431279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QI/LADBID+jqzAG3mtTdzJ4YzKT2Vu+d+JqTnL3p4aA=;
        b=PQeB0f6IByYJGgu8G/EgBv+0nxSp47HVIewy6MZKfnEMTFQpoZsPU+Wszkg71xepUy
         mPYkFDZAwsbTUP+HC3xKkqZCnO8EBoVJn+4QVAAly0HNu/nLCLxnFEAQIBvXT2mXCoqV
         XxwUOa3MsQU3D+m3ZqrsWrQ1Q2O4eriASdfMpoCeZPk7daDSr2TEHoSXlauEPPh+QVbm
         B+fL3kP4l758jJRz/XYgxJ9E+pQLFQn3uCiSX3py8zUvcP0fSHkZkjpZbEke0mZ57OnJ
         U8K2JtExYQQlH1k5W19r9B1X/M3gxH/fRHBEwQtUAlEO3wxrLh+I84Qvtl7C7kgtHD0a
         RVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826479; x=1773431279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QI/LADBID+jqzAG3mtTdzJ4YzKT2Vu+d+JqTnL3p4aA=;
        b=Xt/o6K8bSEV1Zr5XryyWXPI+NX0w7VqzdAnWR1LRJb9sMZtOksHJaeEg5feM2429wP
         4y2t+bzgtz/OK5KDnadJD4oW4DEuOqfivOsV7J8cBAn/j7ktD0G3hMwLatyrYEUoUd/h
         D4ABaSrv3jxWhURkZI3mRgIDwJp7kEoP4aC0slkaHiXOfXGrj3nTLEvBZI9Y0CXdJNXQ
         EaZhZAMd1sWW36ZSDnrhhuBaLolGDu5158p3BBZkn4LWWE6esiikICKEqnWBsaVUqXe5
         zinsdJcJ+NaI1YPRnuwBVY2Xdt+ieZpQ5I4cpiyVGh2DL60S9vODHlbITRsQ8DycKCnd
         7SYw==
X-Forwarded-Encrypted: i=1; AJvYcCW3kJSBYLTfmZis/99EK+Ae8r/9H+EXfhtwi61RMM0W4cWedswWu3MKKZdrA6isV740A1zUdU/McPa1aRv+Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YztnMDzCovTISo61b+hwkr8vJy+t3Pug1/IqwvpMMVIwlYio0bK
	Dje7G/ZHdzFGRnTDgLj/pWAaKA6sRNQ9T2ukoEmA7F5tjIEUaA4qN34huCsVfwsUOavi/STbxZK
	Nvd1h9OaAvTMYOl5ap3GFTca48MWxo/uCQMbbRQ58+XCXZZEZWP/kZdk1Xa/y/Me94e6GmA==
X-Gm-Gg: ATEYQzzXnhyHF/+Tf1dGoNElwOQDOlhrqTidkMEWGIMh3qiQfIfTDTPJ37V+G/auA7y
	bUbHj6/HaDJFKT54v12xm8ob34lO/cEcVy5JBiB6uwMzKMSRl3exnipH9POjH6rEs4EfFCihFYG
	NSzjqF8PwTTDqkFvL1ramM9cUagihhTvEmJ0OEsiMoUuJiYv55AwTvtvHkfdduvmzTJqMSp5Icp
	f2VtgH8MOLbiJ01YQxD2L79Ae5rnVbdreIT1zTmm/NdMA59lpGW59xgPL1XVZQa/7fe7ar10sRD
	JGMT42C2ltFjsFjffU7T1g1BMOS6N4kstkz3kzQrYyiUTyh5UhHOu0wFs3JQku+v7u81+tssq7O
	YctmxdpO86DtQBTaFPFoD+MnOt+qBQfJM9uSFAluMHbt9kgLeq9BFjrg=
X-Received: by 2002:a05:701b:424b:20b0:128:c958:96f3 with SMTP id a92af1059eb24-128c9589a19mr430768c88.38.1772826478925;
        Fri, 06 Mar 2026 11:47:58 -0800 (PST)
X-Received: by 2002:a05:701b:424b:20b0:128:c958:96f3 with SMTP id a92af1059eb24-128c9589a19mr430751c88.38.1772826478139;
        Fri, 06 Mar 2026 11:47:58 -0800 (PST)
Received: from [192.168.86.165] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c4065933sm1680909c88.16.2026.03.06.11.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 11:47:57 -0800 (PST)
Message-ID: <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 11:47:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE4NiBTYWx0ZWRfX/pCkst1esuRl
 Ht8xYazwSPivE/6h0GmFKWRSn3EcD+1XEWLJaPiwBX8inJ+/pvLYs8LegOCRI44P+qy+BLHzLYr
 2WphKPUOuj+39w4p0XjWabhIFyk+k/u/jNHzh5O5yXE2cCnZHbr2KIs0PKEaqlDU4Q8DME+nqgF
 xmQBZzp0WoVrjpjUGOp6eSKNYG8Ob7pqk+6luYHD3ccO5oH3IOV0dH+lTDxtljxeHZCY+4gZYBz
 zdugaZrMzlfUj0+E0Y0SWtNtj/tuCQB96C+0lcK3m4KPJwVnwHPmwBo9AD1m2MlKV/FXJZnpSYX
 KwgEF7cmmWo9rObGwvx4/r1cXmIR5E7F/exOyQYo366cSBLtViq2YPbHz1dKR8Cd745VV4/Lebt
 WRxT8RcdI3vATSMUDZfS+9WdRy2Zw3rzbvaVTDEpbwqs5/SmigIuRaksBz2nVCSvHTUHC5lSxDh
 jq1GJo/A8O/Fmi4xOhQ==
X-Authority-Analysis: v=2.4 cv=Bt+QAIX5 c=1 sm=1 tr=0 ts=69ab2f70 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FJ8yPOFpIDEbGAQ7SYQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: Y8bKb0EZvcboq1jOkvf9bJE6fp8RZ-In
X-Proofpoint-ORIG-GUID: Y8bKb0EZvcboq1jOkvf9bJE6fp8RZ-In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060186
X-Rspamd-Queue-Id: 5462D22736F
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
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-32653-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 2:50 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers.

You are using multiple conflicting terminologies here. In the first statement
you have used "non-standard" and immediately you have used "aren't complaint".

Which ARM document dictates that "standard" and "compliance" here? Are these
SCM calls are using the vendor space per the spec, and if yes what does
non-standard means here. 

 These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from
> Arm.
> 
> OP-TEE as an alternative trusted OS to QTEE can't support these non-

What is QTEE? 

> standard SCM calls. And even for newer architectures QTEE won't be able

meaning of architecture please? Are you referring ARMv9.x or SOC architecture
or software architecture? What does "newer" means? Is there
any example available in public or are you ready to share? 

> to support SCM calls either with FF-A requirements coming in. And with
> both OP-TEE and QTEE drivers well integrated in the TEE subsystem, it
> makes further sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.

I haven't checked cover letter in detail, but did you tested these patches
w/ the devices which doesn't support these new facilities? 

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 295 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>  5 files changed, 398 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a..8653639d06db 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -6,6 +6,14 @@
>  
>  menu "Qualcomm firmware drivers"
>  
> +config QCOM_PAS
> +	tristate
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware. It acts as the common layer with different TZ
> +	  backends plugged in whether it's an SCM implementation or a proper
> +	  TEE bus based PAS service implementation.
> +
>  config QCOM_SCM
>  	select QCOM_TZMEM
>  	tristate
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 0be40a1abc13..dc5ab45f906a 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> new file mode 100644
> index 000000000000..dc04ff1b6be0
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device/devres.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>

are you sure you are using functionalities from these header files?

I couldn't find slab.h usage quickly and also qcom_scm.h. Can you please confirm?

> +
> +#include "qcom_pas.h"
> +#include "qcom_scm.h"
> +
> +static struct qcom_pas_ops *ops_ptr;
> +
> +/**
> + * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
> + *				   context for a given peripheral
> + *
> + * PAS context is device-resource managed, so the caller does not need
> + * to worry about freeing the context memory.
> + *
> + * @dev:	  PAS firmware device
> + * @pas_id:	  peripheral authentication service id
> + * @mem_phys:	  Subsystem reserve memory start address
> + * @mem_size:	  Subsystem reserve memory size
> + *
> + * Returns: The new PAS context, or ERR_PTR() on failure.
> + */
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size)
> +{
> +	struct qcom_pas_context *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->dev = dev;
> +	ctx->pas_id = pas_id;
> +	ctx->mem_phys = mem_phys;
> +	ctx->mem_size = mem_size;
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(devm_qcom_pas_context_alloc);
> +
> +/**
> + * qcom_pas_init_image() - Initialize peripheral authentication service state
> + *			   machine for a given peripheral, using the metadata
> + * @pas_id:	peripheral authentication service id
> + * @metadata:	pointer to memory containing ELF header, program header table
> + *		and optional blob of data used for authenticating the metadata
> + *		and the rest of the firmware
> + * @size:	size of the metadata
> + * @ctx:	optional pas context
> + *
> + * Return: 0 on success.
> + *
> + * Upon successful return, the PAS metadata context (@ctx) will be used to
> + * track the metadata allocation, this needs to be released by invoking
> + * qcom_pas_metadata_release() by the caller.
> + */
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->init_image(ops_ptr->dev, pas_id,
> +					   metadata, size, ctx);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_init_image);
> +
> +/**
> + * qcom_pas_metadata_release() - release metadata context
> + * @ctx:	pas context
> + */
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
> +{
> +	if (!ctx || !ctx->ptr)
> +		return;
> +
> +	if (ops_ptr)
> +		ops_ptr->metadata_release(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
> +
> +/**
> + * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
> + *			  for firmware loading
> + * @pas_id:	peripheral authentication service id
> + * @addr:	start address of memory area to prepare
> + * @size:	size of the memory area to prepare
> + *
> + * Returns 0 on success.
> + */
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_mem_setup);
> +
> +/**
> + * qcom_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
> + *			      for a given peripheral.
> + *
> + * Qualcomm remote processor may rely on both static and dynamic resources for
> + * its functionality. Static resources typically refer to memory-mapped
> + * addresses required by the subsystem and are often embedded within the
> + * firmware binary and dynamic resources, such as shared memory in DDR etc.,
> + * are determined at runtime during the boot process.
> + *
> + * On Qualcomm Technologies devices, it's possible that static resources are
> + * not embedded in the firmware binary and instead are provided by TrustZone.
> + * However, dynamic resources are always expected to come from TrustZone. This

Is it confirmed that it will always come from Trustzone? Is it not possible
that it can come from trusted controller - bypassing the trustzone? Assuming that
such controller is never modified by anyone else including final device makers and
blessed by the trust boundaries. 

Is this design going to scale if we put the MCU doing the heavy lifting instead? 


> + * indicates that for Qualcomm devices, all resources (static and dynamic) will
> + * be provided by TrustZone PAS service.
> + *
> + * If the remote processor firmware binary does contain static resources, they
> + * should be passed in input_rt. These will be forwarded to TrustZone for
> + * authentication. TrustZone will then append the dynamic resources and return
> + * the complete resource table in output_rt_tzm.
> + *
> + * If the remote processor firmware binary does not include a resource table,
> + * the caller of this function should set input_rt as NULL and input_rt_size
> + * as zero respectively.
> + *
> + * More about documentation on resource table data structures can be found in
> + * include/linux/remoteproc.h
> + *
> + * @ctx:	    PAS context
> + * @pas_id:	    peripheral authentication service id
> + * @input_rt:       resource table buffer which is present in firmware binary
> + * @input_rt_size:  size of the resource table present in firmware binary
> + * @output_rt_size: TrustZone expects caller should pass worst case size for
> + *		    the output_rt_tzm.
> + *
> + * Return:
> + *  On success, returns a pointer to the allocated buffer containing the final
> + *  resource table and output_rt_size will have actual resource table size from
> + *  TrustZone. The caller is responsible for freeing the buffer. On failure,
> + *  returns ERR_PTR(-errno).
> + */
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt,
> +					      size_t input_rt_size,
> +					      size_t *output_rt_size)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
> +					      input_rt_size, output_rt_size);
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
> +
> +/**
> + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *				   and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
> +
> +/**
> + * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
> + *				       remote processor
> + *
> + * @ctx:	Context saved during call to qcom_scm_pas_context_init()
> + *
> + * This function performs the necessary steps to prepare a PAS subsystem,
> + * authenticate it using the provided metadata, and initiate a reset sequence.
> + *
> + * It should be used when Linux is in control setting up the IOMMU hardware
> + * for remote subsystem during secure firmware loading processes. The
> + * preparation step sets up a shmbridge over the firmware memory before
> + * TrustZone accesses the firmware memory region for authentication. The
> + * authentication step verifies the integrity and authenticity of the firmware
> + * or configuration using secure metadata. Finally, the reset step ensures the
> + * subsystem starts in a clean and sane state.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_prepare_and_auth_reset);
> +
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns 0 on success.
> + */
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_set_remote_state);
> +
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns 0 on success.
> + */
> +int qcom_pas_shutdown(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->shutdown(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
> +
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns true if PAS is supported for this peripheral, otherwise false.
> + */
> +bool qcom_pas_supported(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->supported(ops_ptr->dev, pas_id);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_supported);
> +
> +/**
> + * qcom_pas_is_available() - Check for PAS service
> + *
> + * Returns true on success.
> + */
> +bool qcom_pas_is_available(void)
> +{
> +	/* The barrier is needed to synchronize with client drivers. */
> +	return !!smp_load_acquire(&ops_ptr);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_is_available);
> +
> +/**
> + * qcom_pas_ops_register() - Register PAS service ops
> + * @ops:	PAS service ops pointer
> + */
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops)
> +{
> +	if (!qcom_pas_is_available())
> +		/* The barrier is needed to synchronize with client drivers. */
> +		smp_store_release(&ops_ptr, ops);
> +	else
> +		pr_err("qcom_pas: ops already registered\n");
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
> +
> +/**
> + * qcom_pas_ops_unregister() - Unregister PAS service ops
> + */
> +void qcom_pas_ops_unregister(void)
> +{
> +	/* The barrier is needed to synchronize with client drivers. */
> +	smp_store_release(&ops_ptr, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sumit Garg <sumit.garg@oss.qualcomm.com>");

What is the convention for Qualcomm authored drivers? In some drivers
I find that Qualcomm doesn't add MODULE_AUTHOR. Can Qualcomm community
clarify it here. I prefer consistency here for the Qualcomm submissions. 

> +MODULE_DESCRIPTION("Qualcomm common TZ PAS driver");
> diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..4ebed22178f8
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_INT_H
> +#define __QCOM_PAS_INT_H
> +
> +struct device;
> +
> +/**
> + * struct qcom_pas_ops - Qcom Peripheral Authentication Service (PAS) ops
> + * @drv_name:			PAS driver name.
> + * @dev:			PAS device pointer.
> + * @supported:			Peripheral supported callback.
> + * @init_image:			Peripheral image initialization callback.
> + * @mem_setup:			Peripheral memory setup callback.
> + * @get_rsc_table:		Peripheral get resource table callback.
> + * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
> + *				reset callback.
> + * @auth_and_reset:		Peripheral firmware authentication and reset
> + *				callback.
> + * @set_remote_state:		Peripheral set remote state callback.
> + * @shutdown:			Peripheral shutdown callback.
> + * @metadata_release:		Image metadata release callback.
> + */
> +struct qcom_pas_ops {
> +	const char *drv_name;
> +	struct device *dev;
> +	bool (*supported)(struct device *dev, u32 pas_id);
> +	int (*init_image)(struct device *dev, u32 pas_id,
> +			  const void *metadata, size_t size,
> +			  struct qcom_pas_context *ctx);
> +	int (*mem_setup)(struct device *dev, u32 pas_id,
> +			 phys_addr_t addr, phys_addr_t size);
> +	void *(*get_rsc_table)(struct device *dev,
> +			       struct qcom_pas_context *ctx,
> +			       void *input_rt,
> +			       size_t input_rt_size,
> +			       size_t *output_rt_size);

void * or resource_table * as return? 

> +	int (*prepare_and_auth_reset)(struct device *dev,
> +				      struct qcom_pas_context *ctx);
> +	int (*auth_and_reset)(struct device *dev, u32 pas_id);
> +	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
> +	int (*shutdown)(struct device *dev, u32 pas_id);
> +	void (*metadata_release)(struct device *dev,
> +				 struct qcom_pas_context *ctx);
> +};
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops);
> +void qcom_pas_ops_unregister(void);
> +
> +#endif /* __QCOM_PAS_INT_H */
> diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..ef7328ecfa47
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_H
> +#define __QCOM_PAS_H
> +
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct qcom_pas_context {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +	bool use_tzmem;
> +};
> +
> +bool qcom_pas_is_available(void);
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size);
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx);
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt, size_t input_rt_size,
> +					      size_t *output_rt_size);
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
> +int qcom_pas_auth_and_reset(u32 pas_id);
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id);
> +int qcom_pas_shutdown(u32 pas_id);
> +bool qcom_pas_supported(u32 pas_id);
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx);
> +
> +#endif /* __QCOM_PAS_H */


