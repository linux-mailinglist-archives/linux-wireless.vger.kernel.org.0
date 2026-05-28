Return-Path: <linux-wireless+bounces-37046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LreGNGQF2oUJggAu9opvQ
	(envelope-from <linux-wireless+bounces-37046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 02:48:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2C5EB643
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 02:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BB383026C9F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD9214A9B;
	Thu, 28 May 2026 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCDbjVLU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VllA4qLw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65551E520A
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929156; cv=none; b=bPv+FwGyCzxWKuwnolqkaR80iOmvvpNM1QRXGMsobb/PhssXMp4fyzL//6Ds/g0CDS1hGHqTQnYWpEXzEq6Vw31ceSwnpPX/pCoA41Fr56k3OYLl87VVF3EmmJmZ5ACgKxMkS2Tvc9/qt6CFhgLo39okRELrScfxtDzryatZ184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929156; c=relaxed/simple;
	bh=05QqU/jEQwJoFG+mO/rjMRFHfZtoF4/epizlmxL67So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKKi6600sO+K/G3VVq8gSWCopVm25Ft6IOlgTgEO0LZEgiXiRaSSroAx2TDa6WBgfKSoWzXBmaB5hnvWzJdwKJae2NslM9s9sj9w7d44Hoa3b5YPAB+8zacSi0C20xiEesxNWPPBopqHnYCk+d0ItcbefshjMMTRPKHqMAKeEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCDbjVLU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VllA4qLw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKm1Cj2931818
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 00:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ww07WFF3YPrpWf+fR/6iF9smQfSTkIU+So8v5m0OXv4=; b=eCDbjVLU6PvRniNI
	RmR0Tb95Bcq4bifKiQNwlnFnR5bpAj831FnkMt+zLVdTnI3hnMFlCDcaIr82FOV3
	r0RLw+TWS7Ch33w92NoVbSKNlgK8OFozrqNVM72rucXC+rIg95ffdeumM2SGUjzh
	Z44daHfMmj4gy/YChWf9o9yHov0i6bBTsaAne733XXIh8/3qEziHGzNxrzoXVOrn
	k//MfVbfDXVpkQTQE9awDZf81H9WxEjv3wlxWKs9c3ptNMxg6/5TTQQfwmWh4wfj
	zhX1YITKvEixXdEEe+kKVWU0197lFoUXCiE0IgG+Eey5SSeXe6P+S8ZvkpB83z6A
	CtOhKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yagq7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 00:45:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8292a9605aso5859580a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779929152; x=1780533952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ww07WFF3YPrpWf+fR/6iF9smQfSTkIU+So8v5m0OXv4=;
        b=VllA4qLwl++3FLvLR5jjehoTETxBAqQTCvWZuaBrwPWDy4e/ZSJTgxvgNJrNT3bgAB
         HhcGd9hUpfHN0EkdouaK7jRfuYFe+HDGJ6cMdJJB/YpCov9PKbive/yr8F8Ai6rDWbTL
         CfB3pXGWIClhpvJshbYWcfKAoaxdhhNBhAwXmZNdKAqR5QlL3reC216r50l/0Q1P8tE3
         YSmd+DnRPx2zDWt1Nr1zXewUUZVrrtpqCqed1aVP1dxZ902WVKTQGUU+a1UcTQ1iWIHJ
         F7A8ggCF3bb2WszY/8V8BV/rYjNLmF+aEzMidR4dEdYkq+MIjltoMmHFAG09B5EiLrZo
         w2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929152; x=1780533952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww07WFF3YPrpWf+fR/6iF9smQfSTkIU+So8v5m0OXv4=;
        b=e1kNWBDlazAAMvkDUqs3+4Vz8Q1SvypUEfEdATyF6vthXBcGHco4+Cr/M54uCpwZwY
         mOtnBbiTVx8zB6SwIxgLDufZxxKl3qD/QEGFYqmdI1OGEzNAt55QnFDUOA2V9VZEgaZM
         /3j0PbrPD81nzUpvnPGonI3WEKJPpHye1cEYVU9N1X++ot4UY6a7hBDrA25rFXfZtSQ1
         gNHV2ACaZI3VQI7u3ik2dZ0p/vsn4JBsRAxXnYpXHTuW2+7Rl2urIfpUjzfiS8ZP0QnD
         Pb8JCr+uHKqTNBQA2s+0oHEovf/XDjrKAmGqzNWjQHhIFaAJ5btX5Kk6iyvysuZQjMZA
         Azqg==
X-Forwarded-Encrypted: i=1; AFNElJ+PwDnk9bw4t2YfMg0a9l/ZTAv6Wzlu3Af2jrdqEQEJHiWGyZfSfEaAW1hxIrV+xvrApfKVLuwnUP03BUNsog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTRHnSEPOH9vOySnYIeNOuU7cG4w0U5hwQogRLOQ+bxI/zF96
	UkEbTB986Y33Dzh/kHzu2iUUc8QRkRLaAprkPDxE1z1v3VeJEEZduWduwUtM8JwhrVDVIXKmmtz
	q9wztXVQm9ZfSbeI6s0wu9B3GCXT0sscqyDhYP1MLwzlH/xGTolKm//hghtwqQACTsDMl
X-Gm-Gg: Acq92OEtoVfyO229ooKLMT7VuOeuDioPKfdMnMp7irf8kDcbcJ4EFooJvaTyTfZxZzB
	WBMzmpxQ4aSeguT0r0Fn6oeQX7NhQxV3pm4ZNT3OxIqMAJuiCcx+fIHo1zUkj2Rm9oaTshXyiqY
	eTWTTlCYkBpsX9cpOgW9HoMmWjITxvB0bDP6eF+pjkL3JvouY1FvPj5gJLGrcNytZ8xOY84LuiD
	2ng22V/OROhaA2Aa3G2W7HdXMwiJBqZaJgOuJkgDQYZXq4DSfsIRXHKFB2JqJQtCM5d1rNyFWJl
	m3dqQdTyFnhaPfbLkk59zW0rAR5cTXbJRrOt3Op43+6Eiuw2I414ibC25B1aLmEzNl8T6VNk93u
	uVPvxTl+wn0g7vZllhwDgbX62DV7vqUA5hcOQ4SxbRSEjq8rFXcCj9NKv493Db97eDg==
X-Received: by 2002:a05:6a21:62c7:b0:39c:787:f196 with SMTP id adf61e73a8af0-3b328c98e02mr24963277637.16.1779929151948;
        Wed, 27 May 2026 17:45:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c7:b0:39c:787:f196 with SMTP id adf61e73a8af0-3b328c98e02mr24963191637.16.1779929151242;
        Wed, 27 May 2026 17:45:51 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.113.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852056db34sm13818380a12.27.2026.05.27.17.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 17:45:50 -0700 (PDT)
Message-ID: <37fb075c-3f48-4a7c-b05d-090b0b09e04a@oss.qualcomm.com>
Date: Thu, 28 May 2026 10:45:32 +1000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/15] firmware: qcom: Add a generic PAS service
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
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
 <20260522115936.201208-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <20260522115936.201208-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fCRyDNGmFBFBRD-ZphU6rTLDX7j6c1wN
X-Proofpoint-ORIG-GUID: fCRyDNGmFBFBRD-ZphU6rTLDX7j6c1wN
X-Authority-Analysis: v=2.4 cv=CaE4Irrl c=1 sm=1 tr=0 ts=6a179041 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IFwJeMpPFr8wNHPVhPWmWw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=u9mUgAEo1hX0okWHN2UA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNCBTYWx0ZWRfX9Dr0cBf6AGRt
 u3uGPbwkCvv/7CUWMSslw3dzl87WuvtQ5eH4jUe5dsmDKa8+EHxEoHPQ4hHjqZtZCP6t/qjTkoA
 NCJvY+mfj/Jt+XWIh/6G/a11JQu63S+29TIWYkkKRfWu8agmLxB6fJDBwj/UHGuS+8LLFUCQQ55
 EJypJscgc2t+vTMOvscVLCmVo6qNSuYwmDwIVZZz3pSyW1XWENow6yXC3AxVVcdxaNUTJg3QZxe
 cBmB7UKz7q7jJTL1Trx9du92EMwbXqk4FYTkjPPAjbmiYWBY4FqxpQHEF7n7YkO2bJcQwpVHH9J
 hziLy5DU0sb/urFfBFDFGaHyTp1lI/5Hx330XdgY+JxvvaUxr3bY2OgpHZGmVIXluz5qrBI6NG/
 s2aE8Q2lSAXp2x+RRuwTFch35DUSYBjJMvD8eX7AFiCwEmMnZAj5oDVTnfgzJmlrdYs3LpBJen4
 A0x8BVgIojXBE1Y2w7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280004
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-37046-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amirreza.zarrabi@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17E2C5EB643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sumit,

On 5/22/2026 9:59 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 291 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_pas.h       |  50 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  43 ++++
>  5 files changed, 393 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a..9f66cc774508 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -6,6 +6,14 @@
>  
>  menu "Qualcomm firmware drivers"
>  
> +config QCOM_PAS
> +	tristate "Qualcomm generic PAS interface driver"
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
> index 000000000000..bc6c42f2b3c6
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/device/devres.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "qcom_pas.h"
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
> + * Return: The new PAS context, or ERR_PTR() on failure.
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
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_init_image);
> +
> +/**
> + * qcom_pas_metadata_release() - release metadata context
> + * @ctx:	pas context
> + */
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
> +{
> +	if (!ops_ptr || !ctx || !ctx->ptr)
> +		return;
> +
> +	ops_ptr->metadata_release(ops_ptr->dev, ctx);
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
> + * Return: 0 on success.
> + */
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
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
> +	if (!ops_ptr)
> +		return ERR_PTR(-ENODEV);
> +	if (!ctx)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
> +				      input_rt_size, output_rt_size);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
> +
> +/**
> + * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *			       and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
> +
> +/**
> + * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
> + *				       remote processor
> + *
> + * @ctx:	Context saved during call to devm_qcom_pas_context_alloc()
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
> +	if (!ops_ptr)
> +		return -ENODEV;
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_prepare_and_auth_reset);
> +
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_set_remote_state);
> +
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_shutdown(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->shutdown(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
> +
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: true if PAS is supported for this peripheral, otherwise false.
> + */
> +bool qcom_pas_supported(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return false;
> +
> +	return ops_ptr->supported(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_supported);
> +
> +bool qcom_pas_is_available(void)
> +{
> +	/*
> +	 * The barrier for ops_ptr is intended to synchronize the data stores
> +	 * for the ops data structure when client drivers are in parallel
> +	 * checking for PAS service availability.
> +	 *
> +	 * Once the PAS backend becomes available, it is allowed for multiple
> +	 * threads to enter TZ for parallel bringup of co-processors during
> +	 * boot.
> +	 */
> +	return !!smp_load_acquire(&ops_ptr);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_is_available);
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops)
> +{
> +	if (!qcom_pas_is_available())
> +		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +		smp_store_release(&ops_ptr, ops);
> +	else
> +		pr_err("qcom_pas: ops already registered by %s\n",
> +		       ops_ptr->drv_name);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
> +
> +void qcom_pas_ops_unregister(void)
> +{
> +	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +	smp_store_release(&ops_ptr, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm generic TZ PAS driver");
> diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..8643e2760602
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,50 @@
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
> +	int (*init_image)(struct device *dev, u32 pas_id, const void *metadata,
> +			  size_t size, struct qcom_pas_context *ctx);
> +	int (*mem_setup)(struct device *dev, u32 pas_id, phys_addr_t addr,
> +			 phys_addr_t size);
> +	void *(*get_rsc_table)(struct device *dev, struct qcom_pas_context *ctx,
> +			       void *input_rt, size_t input_rt_size,
> +			       size_t *output_rt_size);
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
> index 000000000000..65b1c9564458
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2015 Linaro Ltd.
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

I have a question about the shape of the generic PAS abstraction.

Looking at the current interface, it seems that pas_id is still treated as
the primary identity for most PAS operations, while struct qcom_pas_context
is used as optional extended state for the operations that need it. I can see
how this maps well to the existing SCM PAS interface and keeps the transition
simple.

However, I wonder if this makes the abstraction less generic in the long term.
Some callbacks in struct qcom_pas_ops receive only pas_id, while others
receive struct qcom_pas_context *ctx. This works as long as pas_id is
sufficient for those operations. But if a backend needs per-peripheral
private state for operations such as auth_and_reset,
shutdown, or set_remote_state, it would need to reconstruct that state from
pas_id or maintain a separate pas_id to backend-context mapping.

Would it be cleaner to make struct qcom_pas_context the common
per-peripheral object and pass it consistently to all per-peripheral callbacks?
Existing backends could still use ctx->pas_id, but future backends would not
need to perform a separate lookup only because the callback was passed a raw
pas_id.

I also wonder whether struct qcom_pas_context is exposing some
implementation-specific state. Fields such as ptr, phys, size, and
use_tzmem seem to describe how the current SCM/QTEE implementations manage
metadata memory, rather than generic PAS state. For another backend, the
per-operation state might be a tee_shm, an FF-A memory handle, shared or lent
memory state, or something else transport-specific.

Would it make sense to keep only the common PAS fields in
struct qcom_pas_context, such as dev, pas_id, and possibly the firmware
memory address/size if those are truly generic, and add a backend-private
pointer for implementation-specific state?

I may be missing a reason why the pas_id-only callbacks are preferred, but if
this is intended to be the long-term generic PAS layer rather than mainly a
shim over the existing SCM API shape, using the context consistently and keeping
backend-specific state private seems easier to extend.

Regards,
Amir

