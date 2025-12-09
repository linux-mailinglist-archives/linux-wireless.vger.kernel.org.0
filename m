Return-Path: <linux-wireless+bounces-29625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A013CB0752
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 16:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A8430826A5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F772D47FF;
	Tue,  9 Dec 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXhioQas";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FHLYeMMO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8252DF70F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295246; cv=none; b=NAUmn7R2TPl4SaLw9DrAMStHN1g9pFMOPuZmGxnCmaOrS8Xh497OKKe3av2kifuQR8FSYW1ZCrLbR2yZk578kSAe+y7t4zQKpuSNueVhYP9jVJLAzIN1XaRCwhh/0Hj3qMOOlv/FqglEw228gq56eTE0wkVcBsPmd5MjoCYZwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295246; c=relaxed/simple;
	bh=lAA44fPZ+EdgJuey2t5vEPwQ7JCLgJhCXwin1+pD5es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib2T+YCFqG5Ho7rX0GRtW9+NvJPoFlYVfZCAfo6U8HIrcHvdZZjnnHDTicvBg4Jj3vHuUpdEhy92pqaieUvV7XH7QzQA2FqNSSsK1+vu7jIblHA2xH1PjIRU88Ne1hhe/jAZGL6FknAsV8GD3Rv6/8uKxYqmDpUR1gdo4PhU4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXhioQas; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FHLYeMMO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9FhdbF517262
	for <linux-wireless@vger.kernel.org>; Tue, 9 Dec 2025 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDHkj3CwoCQL6wJWOKPjGCsfcQFkvee6eMCgSP3pCQc=; b=WXhioQasmjcCm9iz
	Sn7wLcl6RiRm/Dl6N9GIRF4mHJckZqbq7ig8uw5nxiZ2bfKo+07RigJmnXisssN/
	yaDAYxYFgmM0D2IvV8blD3Tk/V3yV9y8isrbcb6agxemT29NmtnnGj8Df/eBawAO
	81ZZWW+F1Aiin5NNGNXy1YSqOmHQaTmlvw678LlMoWoTlxrgL42lfXT7o0dzwbWm
	ctbEAZsqCJ771ItbEzF0dAgfLjZRo5nBDUmw4n26XGNGp909Uu/oz+NUAIfKIjyJ
	g20Yo4XNXGD/+xBiTa9BgvD8rphHenvFUC29iDZ8y4FARv3uHg4KDPfJHRDQ09Eb
	qntGeQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axmg60fxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 15:47:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471737e673so7064162a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 07:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765295242; x=1765900042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDHkj3CwoCQL6wJWOKPjGCsfcQFkvee6eMCgSP3pCQc=;
        b=FHLYeMMOxw2hQb4FwYBuoSV5h2ntApaJ3tJ+cqdeGfyZg/wuZ6QE0LElLNsb45upzq
         y2jCygWY/GvffPgK/MHkLdlUS0U7aj8mCKdIZXrGSgLXvZCVAKtnbDNElOOwMQRU6hsu
         cD3kE1HIonwbURQpKJmwWHpdWyj3AxwSkpGBYVvBezrWQ6ZsPHs1QS+C563RJF0c5MED
         fHj3evy0muogN++FA0dmejgeiXWuMmamZK3Wwgev3dci2TQbuPZ1LJAVNX0GCAoWYsiZ
         nMsR0NfR9E4ae9ZpKN5jiOe+H0Y/es929yn29acIpPKQG0ZF9Szk85wOPFIBpMvs7265
         SSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765295242; x=1765900042;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDHkj3CwoCQL6wJWOKPjGCsfcQFkvee6eMCgSP3pCQc=;
        b=aMDSHUEHfu0ByJurLjK8mYl2+cdrxe6lx6KcQweUxLVtAne0x4WM17DJ0ktahxALNf
         ORI4fy1Ds+cpng9XSPB3r+xbtIrucaDgDg6c5VHaFZZuXiFZgAUWupzuiiJdxGG6TVZJ
         4yiKVXHJNdDux1OBkR/yW90JZcUM25dRZNxsd31+rUo0Q4c5sl3LbWj3NC/Tq8ZHMaJA
         xfTyPPDZkyPgl0/r20sRx9xMhq64yzB1nynuKIRPwnDgubNzRUtMY3fuMblMOB+Fh7Tj
         6Acgyc0/MqKroAe0VIwK2D1qy0GDQw/gknv4NF0JB+H3JLLF/woyT3pXVaYq6pxaxRFw
         Ei4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSXsnA6MCRg3Pw6YrC+BqxRN31Lm95cLR7SEMm6tRGuH0ut9FRy+BBhW7mV5F6IxTa0mFCYi/zQ5lANT3k4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YysZdeLCrYokUUalLgT7V25n8cF8ineWrWA0A/vnhRexbVItXDG
	/d6u44fsjdAlJ7Qg/7Orh4aZ29cjvVzZvvebqFg5PsRgiunZbmXb7SQdblXEIkj3cuiFq4SA/d4
	gqCzmxiqyPBWj/yF8xBglJavgIJYjjEOBvama56SJKsIq/0ihM4ZBOoY3brstpmZ08cK4dg==
X-Gm-Gg: AY/fxX582Fv9m92zRq6dyYShBLiQUMOibxXv9Px5wsfDXq0eqQ4XXcp/VTmMsBuFv/w
	mpbTCCIjS0XdwT5jPAa7ZrPHYObzokyA9yNrgpzUqr5wuyiIMfjFYgc3k34A9de2CBfvUkhprAW
	f/HlbBp2RDhTUlfQjLfbgLs0yco9yvq/ROcatZUMhD/77iC0sx+ZjPdSoiX4Yx5Lyse2K4GDN7r
	SOo/mP7U10CYmp8r/oGNx1yIfjlVVwwtNFsTH+NX69MDDHJx0X8J5uxYh6EgiM9Mr4b7+7sBl69
	lPq2xDAtKVcN4+bqoZsCIbxlCGXeqI0YuCbi8L7iu37dIV24p5ZardeOPWROm9hytzwu8AyL/Z0
	e1sMaFOtXRnEL4BJJIusK73ptCIh9wDrt/2FWPuNaoCWh9HRDrWa66kMkuiwhx+wnl3yqvQ==
X-Received: by 2002:a05:7301:1906:b0:2a4:3593:c7c6 with SMTP id 5a478bee46e88-2abc70fa21emr8054973eec.6.1765295242103;
        Tue, 09 Dec 2025 07:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhrMcLrAfPV8e9p+ctKvu2z65Q8ub97vqIxMWVyLeOFWssQ0s0J2qpalQgDpvc7C9ctW7Uww==
X-Received: by 2002:a05:7301:1906:b0:2a4:3593:c7c6 with SMTP id 5a478bee46e88-2abc70fa21emr8054946eec.6.1765295241549;
        Tue, 09 Dec 2025 07:47:21 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87aa5fcsm44776850eec.3.2025.12.09.07.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 07:47:21 -0800 (PST)
Message-ID: <cb81444a-2dea-47f1-985d-ad406633804b@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 07:47:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "wifi: ath12k: Enable REO queue lookup table
 feature on QCN9274 hw2.0"
To: Oliver Sedlbauer <os@dev.tdt.de>, stable@vger.kernel.org
Cc: quic_rajkbhag@quicinc.com, Jeff Johnson <jjohnson@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251208103152.236840-1-os@dev.tdt.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251208103152.236840-1-os@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDExNyBTYWx0ZWRfXwAR/3+DjYtNq
 yo72Kop+W7YiEXXr1Sx1GQZt9RSD85/P+FTvLVBd5AchK/4Ot1giyNT6YOmJgbu++pUDoOmgh5o
 5oJNbrSv2vZAI1Kxqa/n80V/iUS6VPIyeN7Z5cx+v1cSThI9d70U5Q2r3t9LytIx09UoQYJm8tX
 IDP4zZ4UZonI8IEo5vtREley5SbuNKmjh47v6ZQJjqU2f60+aWW+q9pJSD4rCvpT/j8JU3+ZuX0
 FPs7JEBMt0IUB+3W2HDjkLivEKv2PoTrx73ooy1JXmVPRF6hz+x3L+2A95s818Qt+u1VvZxXAVs
 UgrTBuqIG512yD0K0jGEX+EFPtTmcbrZt4IAO7H1yvIyGmD9eFdJd/WvyU0WMQ03E+ipY18L9UH
 fzUwHToO7rS3iC+mBqloHCDVOeOgRQ==
X-Authority-Analysis: v=2.4 cv=IZWKmGqa c=1 sm=1 tr=0 ts=6938448b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yIxbBWfxqtjDTp5mS7gA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: kzs8e-gPGt6w4xQN9A76LuAOokPy456S
X-Proofpoint-GUID: kzs8e-gPGt6w4xQN9A76LuAOokPy456S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512090117

On 12/8/2025 2:31 AM, Oliver Sedlbauer wrote:
> This reverts commit 3b5e5185881edf4ee5a1af575e3aedac4a38a764.
> 
> The REO queue lookup table feature was enabled in 6.12.y due to an
> upstream backport, but it causes severe RX performance degradation on
> QCN9274 hw2.0 devices.
> 
> With this feature enabled, the vast majority of received packets are
> dropped, reducing throughput drastically and making the device nearly
> unusable.
> 
> Reverting this change restores full RX performance.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 3b5e5185881e ("wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0")
> Signed-off-by: Oliver Sedlbauer <os@dev.tdt.de>
> ---
> Note:
> This commit reverts a backport that was not a fix. The backported change
> breaks previously working behavior on QCN9274 hw2.0 devices and should
> not have been applied to the 6.12.y stable kernel.
> 
>  drivers/net/wireless/ath/ath12k/hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
> index 057ef2d282b2..e3eb22bb9e1c 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1084,7 +1084,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.download_calib = true,
>  		.supports_suspend = false,
>  		.tcl_ring_retry = true,
> -		.reoq_lut_support = true,
> +		.reoq_lut_support = false,
>  		.supports_shadow_regs = false,
>  
>  		.num_tcl_banks = 48,

Stable team:

The issue with enabling this feature has been fixed in the mainline with:
afcefc58fdfd ("wifi: ath12k: Fix packets received in WBM error ring with REO
LUT enabled")

Hence this patch should not be reverted in the mainline.

But it is difficult to backport that patch, so the original patch should be
reverted in all of the stable trees where it was backported:
6.6, 6.12, 6.15, 6.16

/jeff

