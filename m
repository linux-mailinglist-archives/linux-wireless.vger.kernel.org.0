Return-Path: <linux-wireless+bounces-30729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6BFD16D55
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 07:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEB6C3032CF0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD0122FAFD;
	Tue, 13 Jan 2026 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eUMI26eI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J16tyrFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FF31691A
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285537; cv=none; b=fJ1yCmuL66NBcdsPmkmQr5vTqPdS/8tRGeI0zWAZFE9ItNXMsUlvBeR2YTCMf/2g5pnrqL+mK8Vfs4h00LM6bbVfA6074n8CLIDc63uLNZy7xnRrx+baW4arMWHSZ/wzgGgIpYeQBaXwyccFGhLUUtowBEx32JqEx1h+xwNPZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285537; c=relaxed/simple;
	bh=Ko7tAkJwU0k0OBAi5/1O0Vq1h7aiGeOa8vloN4prKb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dt1HfEvmQKRdy/08Ew2Ja7mzE2AwCafpbZA8kvBG2PDL/DlVFPpbuiB84wLO8b2lOD9WybAP9uvk7fxn0eNZEnM/cOXnw4HSjuwdvukbhOKJTeBnvYYGDf8jyT7Le/buprl8+v/W+r2jhj8vinclsEV55NYaFEjZWKhuUUkrClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eUMI26eI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J16tyrFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN51gb2513592
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OkHNVItZ/1UwfstcS4GR94uyenvt+cwhq+Jmr9KeZ7I=; b=eUMI26eIPNt7UIVL
	lawtHb5uC7OAM5mPklXHpuhyiSzn4uzLnp4MjBwn9xfvNe5i6fhtjV9d3vQElUsH
	3I1fXPp+FyEyV/ScnoFxJmeYUKk2LyrTUmUfUiuN27RYCKUuWxS3atE/YXhDVsDG
	2TzwfxnbqMcg5MTMjCM4UCCbqQkTIDYnnl4Pgs933bYDmU7cN4jMZ8IfrOaO2aX9
	/Zsp2ObKuuZHyKgXS2LrQoRh0V7Y/wZF9o403bajzSF5is5uwOeWTyREgy2pPWVg
	n7GqrJcQMmTCiqm4kLpbOLa75eF0chdx0RasoqahXGdxpQhNfrAP0/m0eonoG/eQ
	TF1xRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6y8sms4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:25:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34aa6655510so7780301a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 22:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768285535; x=1768890335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkHNVItZ/1UwfstcS4GR94uyenvt+cwhq+Jmr9KeZ7I=;
        b=J16tyrFtQ8PltWw39GngfBqVV4jJW1InBi/stn8j6DDtWYtlIrkFB6w38EB7QTPCPo
         cVchEFAY88ap44ZfsZlpnAEDh7b4jw7vc+HVal0/15Hdlz/G2XC14xwWlkPJVX3cpFth
         qu8jICrHQT62CgR14aqPDNR+KKG7PpuwGSQPgmTChW9NssLZxU2EGMKDtxe4qKGmUyGk
         zpv+P3x5cfQuqlIPmhnnRXqFs7i6f63VIsdRhcPCUGc8KDrILFrSS94f2jwLaICYjdEz
         sjJwLNiQtxGgH7jT3mNmlzwpDuKKuQnMhvaUEKiEnfVsLTXN9/ZuraxyjI7wXs+8oAIj
         ohXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285535; x=1768890335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkHNVItZ/1UwfstcS4GR94uyenvt+cwhq+Jmr9KeZ7I=;
        b=erLn6jYlAix800OUykBHZuMbo0Q1kZRWXklb/+oDVNmqCrusBjW2sBsQFb3HgAz48+
         d/JMyg3sb/l+KOCBbvUiRHr0eII/oWONCkqarDHAt5gf+G0CWUBj0F2/oyughWg/OSjY
         hrgVsrrKcyRaMX93afII03828HZWRZ773HqKB89cIgT63J5AuPgSzeAc5U2orMK4erjA
         C4hm0kOrnGbsjb6Kt9uZXTMW8JWm2ItmGu09wemnnNzYupMBmnkfPmuckEjmgLaX+5EM
         m++9n4Ch35gjAEFCmkfTQof5XJCSc/Z3VxPuNf5bRmHoLiadqADk2ZplxPmeeZ8lYJcU
         vlLQ==
X-Gm-Message-State: AOJu0YwUsDqL56H7g2mWbKp4gUdb8Ajkj5CjsUE4TBdh/T3Ak/Xyt1n9
	7dy/q2LOhk4P/b5jWRyuWymgXbBXZI8pOTT8NtVrU299LISaolAh39FKmINe5MPtYeBSbnu5WcC
	aylaoWOka8kQL9ULZgMWuGjNLgpy71rKLdj4zSnQ8n+tNlRiJrggUMZDKQ0OET2TgICNpjw==
X-Gm-Gg: AY/fxX5MepeSd7misB/bF7bZXs8FL6UjRptkWSNlGNyZtaiwSvpOUVsZFiTC5XwF5sV
	8cvsmOJS4nrt5I860AqppvQTyNd/OjLuE72DCCuDCFeJ7i357cgclA2hGupMPpgGmsRsHnpx5Ui
	HUMFA9Vup0/zciUtPUZo4gVVJYbz09OG7VT+sbTQ6ojQKckSVr4V2RmijJ+88ZtxESvrQIJmLN4
	dO7BL9kOw6K113lCTNIHv+IxoUU8zmXYhpe/VF3eRXSGhgAcAnz6X+1Mc5rW5eY7+x6iLqE7Wmz
	ZJTAm/6dArQ9ZzxnyXwU7bZA8R17SS7xWHKBuauRHRYZKcvzQFf3FNxZc1MAshVyOl+WqmXVTSd
	SQXj01tOkaHNLfmOjxPPM+7RwRfZ0zT+h+34l9z+Cvi/LSFXeCblS6/oHSFJLBkL+arbz69qZYx
	Q1ijdNpNU=
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr17836439a91.35.1768285535001;
        Mon, 12 Jan 2026 22:25:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1MHEvI8Av26IuMHxcFI4hoLUJoG2pb+GiVY4W98DkoK2o8hbuGxpV9X299no8BLWYeENMHA==
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr17836414a91.35.1768285534506;
        Mon, 12 Jan 2026 22:25:34 -0800 (PST)
Received: from [10.133.33.243] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa78f4asm19087031a91.3.2026.01.12.22.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:25:34 -0800 (PST)
Message-ID: <a3c09622-ff18-4586-9891-1ac7fcdfb220@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 14:25:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix wrong P2P device link id
 issue
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TopWo7hnG11rjV-TIdD9paIkIjE2O5nk
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=6965e55f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ScEjb7IQ4rUrBPXD1VQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: TopWo7hnG11rjV-TIdD9paIkIjE2O5nk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfXw4ChGC99+JeV
 jmlTpCLMb8f30eGMiuX1eCQ70Kvnn963j4w1CeAPDczOOqS+8jhMI2acLWSnyfymA7bFb4EleRT
 qo+bhjd8GzZ1tvLwPuT/QBv9MrjkgXuyiQSHBltF/sUQGPxHW9G2aAwrmmyzTVIO4TbPAvJLME+
 OHJ2D/pehPyVRdBLqeBzRegikkl10avQ3pSrQkl1wFE7Oclt4Vdj5J98cgR7fB4rXhyn0jUEMVH
 cvf/xP/ppmSJT6WO4P4ms5ta6ki4pqx5YAdLE7M+8VLzthb6md9PFWgOTr7UbkOJKAjUE8rnx48
 VkqjRmh2JJ7crvA2HwRjeBQPFsYltrk2IX8KfN1X0LPtW3qONLz9NIGgKya3Bbs6KW0+L4LZYzg
 VlYYG/DmhXKmqTE6DJXWx1W5pM9pHmsMPEjkk9I0SfTG7nk+yHE6IkxPccZZHkvE8EwkIGkJFns
 Hig5M0OlHpBaPZagzUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130050



On 1/13/2026 1:46 PM, Yingying Tang wrote:
> Wrong P2P device link id value of 0 was introduced in ath12k_mac_op_tx() by [1].
> 
> During the P2P negotiation process, there is only one scan vdev with link ID 15.
> Currently, the device link ID is incorrectly set to 0 in ath12k_mac_op_tx()
> during the P2P negotiation process, which leads to TX failures.
> 
> Set the correct P2P device link ID to 15 to fix the TX failure issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 648a121bafa3 ("wifi: ath12k: ath12k_mac_op_tx(): MLO support") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index db351c922018..32cdf6d73ac0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8838,7 +8838,10 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>  			return;
>  		}
>  	} else {
> -		link_id = 0;
> +		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
> +			link_id = ATH12K_FIRST_SCAN_LINK;
> +		else
> +			link_id = 0;
>  	}
>  
>  	arvif = rcu_dereference(ahvif->link[link_id]);

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


