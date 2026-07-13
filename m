Return-Path: <linux-wireless+bounces-38935-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pAxiGZ54VGp7mQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38935-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:33:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EF747430
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:33:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YEbxjzeV;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hcka8K6T;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38935-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38935-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411943012246
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60311256C8B;
	Mon, 13 Jul 2026 05:33:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D7191F98
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 05:33:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920794; cv=none; b=icL1zgz+CwsQm3n5jvMI4ZXA5ZGQ/sRpR1m0s43IcwnU+4Y8ZOEhtjw4tuAZaTO7hGRu7zmrTyZFBhaK809B6LubYOxHKk0hBvDq7Ek3WyWXgICPlRSRyettY5eWvybtvOqn5UxLWSTHSiLEnWPLTsa/z9OE0sQcSavecmrulzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920794; c=relaxed/simple;
	bh=NqiAWoq0S/v0o0ycD2poUlmy2YWusTrKvsPQGSfPHhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjBWyQa7QRf5h/WbJ7bUXdYyvOzxlfvPIFlFU/j7f06H/ySSYms8X7fGbNcSFV5qtQvwtFZaUIiIshzqZ2hHsWNLJvLdhMNR0PwBb9d7NLwFlK8MkldfqTlf26tr6ov6pqduZHeVqXPcqRL09Dg/y5q/naBjEjKM3Ym4PCAx6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YEbxjzeV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcka8K6T; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D39wAA4153667
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 05:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxXYALwNR63jw/rFRq7RT7Vad3vt++2jtWUcBG0sDDI=; b=YEbxjzeV1FFvLJNr
	iUlmjBq69Hpsn/I7ADVsBzI1/LRcn6O99wTD0IRYqII7V1au3FSwx8KAJJQOl3eY
	MAfJ1deyuLODXoVNRRU/XZ5F43y3w3em7OSURasBmK8v66gpiC7k264V3qtHZUNP
	svrwMISMRVs536+JuB4dVMI7td8pnB+X/pUinuB9aqtVsNxAjm6vbxoY1jh5mDIT
	ljwzhKOCjA11WRE8y24YENrUkgk/xCSDFIeUipCmw+I7IL8URYhRrpDPQjYebfmb
	nl8q4fAkhEo/Z4iQFPY9pLECNNyMY7/cOxJLafReBFt3xGDm+L+jCwGhZkkM5M6A
	fvSRWg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0gmd1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 05:33:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c8018f11fbso43616535ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783920792; x=1784525592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxXYALwNR63jw/rFRq7RT7Vad3vt++2jtWUcBG0sDDI=;
        b=hcka8K6TNrN/vYy+UE4kaAbAYTAWQ6kmKmPktXYqKfKpUc9K8xXSZoOlsJXF9GtaPU
         bwRL3EBbw9KxA/FLb4hDLUpFf71rhijkQT1LwZSNW2xIQ/1a9pp+M5SVRY738DZMx8IT
         Z3w7GBL354tuf9iBsYtX13XAK9B3vwSgB6ScEi9RFcDIAi6l+fNNMWRLPQdER0LspY6D
         +OnmXJubUH1D5t9B57ioMIUU7yWJbSOKP7J633Ol7k7q094FI5u0AKTighZwKrG6Q6VM
         nz2iQeHChFxhG9Dn+mFYyXrn7ws49G9SBlQQo/pEW0tXbHudd4WOD0WoqpCc3RXCAO98
         ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920792; x=1784525592;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxXYALwNR63jw/rFRq7RT7Vad3vt++2jtWUcBG0sDDI=;
        b=Oaw7yD4Mz4EUVGyF4jOmOUFaEeyCrRdzvd5R4T65VsQEHGE0BEiqhPRBOWNoiBAuaC
         YldXJfDoZCjjL28dlyWom9qhm368c0Hj1RiZ5PH2O2vBjdLzDgZ7vZwY9/yHAMXvEDJ0
         PN2v2deL8iC5OrESyfch5PeRRYj3KnHIjprRYyOdEf+xvwc5pJZJWVDm3wWkDrTnUggM
         9eok+8sqr9TXrcWA4bpRGQYS1SQBfYIraCxHZUpWuCGwHE+phZEiGz8qtng9hqkLlayc
         JgSkkWzPJsCwfA6w5ORTDooPB+HSCVIF3K57x4ozzfff05fdFvvZuZQILgZ1Xt+hbpwa
         5cYw==
X-Gm-Message-State: AOJu0Ywt4UDwlzqVKVo5RJTK9b4Qh+qC0623BaJ5VgIoLFgVOMAZreZi
	lbfvJNHyV8mqemsoyxqF9i1+641MKI2/A4LwTCdtW+t83wtYw/wQYdqx8JWSokvrOBFdp9zDoEj
	jLOpucFeB/Z2kfWJt+ey/7DaMF6Kq1ZI8IFYDSfjtf5xWzrcmZRgZ4/hiPagOrS7dNJfDOQ==
X-Gm-Gg: AfdE7cmnwDtMf96GsEtR90njV+3bcT0cmANm0g25Frm2ZOnenlt/QHPn9OB5VwDGAfz
	Wet5i0WUmPZlJrHLDjPmeIESNqFf0+wD+AgDcGu0VinmUlnK1w2em2GrEc+NpUHA05z540iRTk5
	B+pPpKgV8ir6YzQEaBpfUi2UQDt6MQ45cGMlXC5r8QkZJCbhkqT1Ubo90ScbsvvYGUE1XrAymNG
	J6RUeLLfDjuKxQhpMYDpXCjghDZXW/57x8VGBU3+RmBonxpNLfqqOhfWp24w/ZLYx5k+YTl+/YF
	Li41/QhTO4xtaRZMoh2H+RFEM1gnWjKGVerhL0WZslwWun6En8YQvzZRzbMyQKLgaEFz1/4X8pd
	CdOZ6hmSMnZFQhd50YApQ+rJZ2Bk0sO657n12GuIS3QbtX+TPz+40bu97vSd/c4scTDNWdCEZnz
	8ZB7E+jGI=
X-Received: by 2002:a17:903:1aeb:b0:2c9:97a8:aff5 with SMTP id d9443c01a7336-2ce9f4d41acmr85571515ad.46.1783920791606;
        Sun, 12 Jul 2026 22:33:11 -0700 (PDT)
X-Received: by 2002:a17:903:1aeb:b0:2c9:97a8:aff5 with SMTP id d9443c01a7336-2ce9f4d41acmr85571215ad.46.1783920791126;
        Sun, 12 Jul 2026 22:33:11 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c21429sm94046615ad.37.2026.07.12.22.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 22:33:10 -0700 (PDT)
Message-ID: <e94de910-0a15-4b82-b006-03da98305e9b@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:33:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix resource leak on error in ext IRQ setup
To: ZhaoJinming <zhaojinming@uniontech.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260622025659.1235658-1-zhaojinming@uniontech.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622025659.1235658-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a547898 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iHwBjlyiAAAA:8 a=7ikIpeOslSXNon0WtTsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-ORIG-GUID: K6UB3VUB5z0Zk6LsE3MhdcVz268Y141i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1NSBTYWx0ZWRfX/YJedpFH2yCH
 ntQxpRDYzgSMuV8npzozUZJ++5/C/2B8x86/8uEATUiaA/bP8tOhzWMl3EztHVTc+n2lCytAHP6
 782SwXYlPaTdNo0XmdqS+6E/WPFgnlGImMHM1h11I5RyoCKXF532F7K2OE8TO5Cli8IpOsJb8n/
 BgmRCl61RfyCqh7pWVeCrgtzYjFzjGgU+xVh5ExTcQiyCRrvlja3iFKheyVaHaI1EuvjmmXYE5J
 /vbOpGPVxzR7aIKHJ0ADYMNXXEfV1zbTiXNu28cPQt1wauW9Z4ranfi02EimNB7b0BOJselq0e6
 R2g6zjNs0NtuNRb6Vt63XY1fkUxAHH5ySe2JH5Q7CKfx5IpNL9WCSeuix65tv2VEUBxi3spz7AZ
 4kgMj+yWt3xCbccrp9Ogwdinzrhf4JbW+ZmCC3p8oZhxX/wfYchVd66GsBgMs0HEZlX3bLLR+Cm
 ffGmxkhVv0wIudnqdmA==
X-Proofpoint-GUID: K6UB3VUB5z0Zk6LsE3MhdcVz268Y141i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1NSBTYWx0ZWRfXwaGIK6tk4Ltx
 D7a4XPI1tG+6Y/f8EHJgGyX4fAG3a+fQC+b2z9jB69jGyOOy8Onx1KO/4BylOYdnYt6d9JJKqcS
 0z+6hYgJn1KlNimx9LPePE2m+huuTcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38935-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,uniontech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A49EF747430



On 6/22/2026 10:56 AM, ZhaoJinming wrote:
> In ath11k_ahb_config_irq(), when a CE request_irq() fails, the function
> returns the error immediately without freeing the CE IRQs that were
> successfully registered in previous loop iterations. The probe error
> path does not call ath11k_ahb_free_irq() either, so the previously
> registered CE IRQ handlers remain attached to the interrupt lines and
> are never released.
> 
> In ath11k_ahb_config_ext_irq(), when an external request_irq() fails,
> the error is only logged and the loop continues. The function then
> returns 0 indicating success, leaving the device in a partially
> configured state where some external IRQs are not registered. This
> causes enable_irq()/disable_irq()/free_irq() to be called on
> unregistered IRQs during runtime and remove/shutdown, triggering
> WARN_ON(!desc->action), and missing interrupt handlers lead to data
> loss.
> 
> Additionally, if alloc_netdev_dummy() fails for a later IRQ group, the
> function returns -ENOMEM without freeing the ext IRQs and napi_ndev
> that were successfully set up for earlier groups.
> 
> Fix all three issues: propagate the error up to the caller and unwind
> all successfully registered IRQs and allocated resources on failure.
> 
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 30 ++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index f566d699d074..041c0fefe8c8 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -536,8 +536,10 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
>  		irq_grp->grp_id = i;
>  
>  		irq_grp->napi_ndev = alloc_netdev_dummy(0);
> -		if (!irq_grp->napi_ndev)
> -			return -ENOMEM;
> +		if (!irq_grp->napi_ndev) {
> +			irq_grp->num_irq = 0;
> +			goto err_request_irq;
> +		}
>  
>  		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
>  			       ath11k_ahb_ext_grp_napi_poll);
> @@ -600,11 +602,25 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
>  			if (ret) {
>  				ath11k_err(ab, "failed request_irq for %d\n",
>  					   irq);
> +				irq_grp->num_irq = j;
> +				goto err_request_irq;
>  			}
>  		}
>  	}
>  
>  	return 0;
> +
> +err_request_irq:
> +	for ( ; i >= 0; i--) {
> +		irq_grp = &ab->ext_irq_grp[i];

this does not compile since irq_grp is a local variable defined inside the for loop above.

> +		for (j = irq_grp->num_irq - 1; j >= 0; j--)
> +			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
> +		if (irq_grp->napi_ndev) {
> +			netif_napi_del(&irq_grp->napi);
> +			free_netdev(irq_grp->napi_ndev);
> +		}
> +	}
> +	return ret;
>  }
>  
>  static int ath11k_ahb_config_irq(struct ath11k_base *ab)
> @@ -629,8 +645,16 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
>  		ret = request_irq(irq, ath11k_ahb_ce_interrupt_handler,
>  				  IRQF_TRIGGER_RISING, irq_name[irq_idx],
>  				  ce_pipe);
> -		if (ret)
> +		if (ret) {
> +			ath11k_err(ab, "failed request_irq for %d\n", irq);
> +			for (i--; i >= 0; i--) {
> +				if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
> +					continue;
> +				free_irq(ab->irq_num[ATH11K_IRQ_CE0_OFFSET + i],
> +					 &ab->ce.ce_pipe[i]);
> +			}
>  			return ret;
> +		}
>  
>  		ab->irq_num[irq_idx] = irq;
>  	}


