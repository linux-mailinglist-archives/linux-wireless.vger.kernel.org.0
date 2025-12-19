Return-Path: <linux-wireless+bounces-29922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA718CCF63F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124D13063154
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E8C1DA60F;
	Fri, 19 Dec 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzgvHOiQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="igxsQxzB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430A84039
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140356; cv=none; b=P5mR/g+we44pRK8slv+CqbkOhxsvDqAC/et5ImN9qgxlMVR5apecOE0tLZVpcT8j2h5qFS5M5a1WS5VnxYcf5Lucd93jO2h9xOFBfgM1gBrJMKoJD+/A2w7oXJaObinV+VLdidle0lkMhO/OR+oFV1F7sv3MboBQC4GXkEL8yx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140356; c=relaxed/simple;
	bh=pmrWiCZAuO3ryFpCSy8h21I1snSFgJ8nHpvPvt2lzlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+FXJB8U98d5E9TKshwbL0BK5ouWkhHP+fzBHWuP/CJKtHiPayNQ4XLhVQ6wIg0+dz1VDqkTv++sa9cdLZkWUvsCd2cRKLsK9I0jhpSbPwvqXfAhVMV+tDftRoDnJf1kyKD/C05tsMrHeiLicpKCYl6MYcdDvTpnyyBzw+p4D9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzgvHOiQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=igxsQxzB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4cJm53700761
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 10:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CWleTC0SGDLpFTiZtflst/tiPXLuIo+DturFwt6W6+o=; b=GzgvHOiQDgxPZ0fm
	MyZBTObyeQ3UtmtPfR3TGHN+xksPNt2qDdjIKreeQelw7Sky6VOhTNN0UIpc/PI+
	ObUMjIAYa2N4yFLf8oudbOczpYM2I27UQo/sStf7RxFgmUF9sbI4atWXs6duS0Wo
	M8BCIEnE3fQ2ZbJK9UORb+Vyx9u63gQYCfzjic3WridaA9zQpuI0uHEWKOff8wTQ
	Psh2IIdEiBzM3T7xKhTdeeVdCHYkxdOBWHaiJJMOKfPkGFEP8KEPirgu19bf1a6U
	MCHkdt4lbKRAhBai1VT6Fw4cx0xaWb5l9ZFqsnJdFcWsZbtyD9Scqzn/O7shd7uq
	Gh9+2g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ej97q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 10:32:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b9d73d57328so1871238a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 02:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766140353; x=1766745153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWleTC0SGDLpFTiZtflst/tiPXLuIo+DturFwt6W6+o=;
        b=igxsQxzBiK6RxcoQkmhPLvL4EpnD/rn02bxC304iKIgpoS3Z1lAPxVvBNH3nyQTSOz
         KWcXjG1UjxaQIuhvtgBCQRqwR8Ir0d27huk1SofTQFa4tYtdyyvSxHWAaIz2ep5iWtsE
         +WGWnLX5VKb2UV+TjDFu4kjJJIp5buzSixIYpSHWXln0mCfNjy0DtPtHn4c2UZdTNovF
         WqXuI26nYUy21t1qy6dyYp07vuqq751n0N41uKiMOH7z4Ar+XFxiRDy5Mqu1WTXB3ii+
         Fvuq3v8yRVrQcHXADAhGj9p8GlAqGxAO3jX34rUO+SZSFyCs7fcdFS2/dUPyE1rYy2GE
         vqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140353; x=1766745153;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWleTC0SGDLpFTiZtflst/tiPXLuIo+DturFwt6W6+o=;
        b=Qz//Qij1n+DfdyqhL+Fu+2sV89mf8k3Bo2NlmcBSrzg9KtCc9aj24UMmhewZrzFG+2
         5NKGJ373xkFhyJmoMhXl2d/SXZSoJ53p0n6e6jFEbdpYd7SrCpL6RUIC55u1ov7LkSRB
         IOms7EKEdzC6ifpdSmJ/2XkdO6LnW1edcqxZWqH92Tn1VmLTU5FqNto+/Bl6XzsIprcB
         H3DdnpSzdSttKCeXCvV7cf7TM/rdIJPiUCV8xK9YNK5AnCrlG0rVYu65yxbT2iXY2gpG
         1nLdB/M2EW1fSTENi4uhw7EET9OK66eIhv2wqEpsihq0DaKVKsJFzHHOUqiiOZZdVd5o
         UIgA==
X-Gm-Message-State: AOJu0YxQ90nYl7JusAqAHgcbw0tGfPN+cjBk2VVBkHr2HNjb7CSZsA4z
	DsLKfAIbPwC6W5PSxvGNBRl6pRvQwoQTTlreabSrKG8Ui1ViowKpgia4ij16NdxdWCpYgMPPGHk
	XV1t502KdGr5WHTbhSST2RXeLY9e8NmX1EqYKaaRPGrALU9smjij0tNwK+Y6PG3LRp3taXw==
X-Gm-Gg: AY/fxX597/wPhPdWrkHez5TKgX96s2A2mJRssfN/xR0LaCTO3ZHKCQUSXTuBLzjMlQG
	B+mMU+OfIRdSoYuZ2I1wER6DEieK0mtI9H9EpDrhzAvhuK8WIMc5lZZGHJy1jJN4ETjfRT4V361
	83qBkCKMuHJ6QQdLtS4jtAEjQNeRdSvUUMMJGeAeCZUAotZ7paWiOSntShsiF1MqIPZOWR+fZVE
	LYZMvAcj1Llzk9TeNp4NJRu18YGrKlzHDCsSTO80F86NFUqvGMGFStJy8NxuYKX5d4J6wC2mYLO
	n/aeBypJAxNKAITCDewxos96XGY8h3oRIiHPqF0LL45EE+4ZCXFGBsH0BV7BPiX5VF5iZ7/snZ0
	sNtcGSMWVaBmdq8AvmxY5eG0kOAR6GQUcxTsH65rbJVOPf3LfnEDiDWHRaHQm0gIAN1iQ
X-Received: by 2002:a05:693c:40cf:b0:2b0:4cdd:61e4 with SMTP id 5a478bee46e88-2b05ec6d76emr2455953eec.24.1766140352992;
        Fri, 19 Dec 2025 02:32:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEJpp6nS5U1Dmv2MmJFxSnn22dIa+I/p3lLdNUxfL0SS2K9A+EKkd4Dg1ZKQFBc1ygPpUNqQ==
X-Received: by 2002:a05:693c:40cf:b0:2b0:4cdd:61e4 with SMTP id 5a478bee46e88-2b05ec6d76emr2455917eec.24.1766140352304;
        Fri, 19 Dec 2025 02:32:32 -0800 (PST)
Received: from [10.110.90.237] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffd5f86sm3884842eec.5.2025.12.19.02.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 02:32:31 -0800 (PST)
Message-ID: <dcd0c9e1-66ae-473b-ad37-5d028dc1bc16@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 18:32:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead of
 #ifdef CONFIG_PM_SLEEP
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s-keqwqzTZdqlA_5m9mbPvksjQFVl_9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4NiBTYWx0ZWRfX98uBYnJWRYqC
 6ZGVaDwVuMuPVF/EtmSvj84jkphvGAVOAcqK4roiGypeW9Tr4qcCiHc1v0P0/VsnZuG9E21+gXP
 YaNzrQAsCMKdiOkr/G1OWMCJNW5QKsSwWPgCcvLo/Cxz7wazaKK/tmnAIt84jgb+C2atMOiibtI
 HSrWVNbzG1bIdmuueuyK/BtY7ZwKCcPD2xNncovT7FF0nIKgInn17hIcEKp3xQNYeqaU4p+yaz7
 Q9IPv+s90Ld38X0iObjteWz55ZU3y06LgYuW3+kcwizsFYiQigR/rQtQzp42UT1YJ1NgnbCt6UU
 DnrbTlbON9DcYYVuhEYFJIXAu/FF8SfEtDu5Epq9isOtRffP+SGk0yC8Zg0mfd50E0CSyw4dYHI
 VxYrac5X51DNb63V8qDOp30Ywx4DIpvC2xDWd0LzwzStWlaKDpY1F3IwADFOxq0SCri3C35/muF
 oRNBRTzT0kCIwyUcq6A==
X-Proofpoint-ORIG-GUID: s-keqwqzTZdqlA_5m9mbPvksjQFVl_9S
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=694529c2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=htMSyHTI8o9V6KcsH7EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190086



On 12/17/2025 7:19 PM, Uwe Kleine-König wrote:
> This increases build coverage and removes an ugly #ifdef block.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I found the patch opportunity while looking in this driver for a different
> reason.
> 
> Best regards
> Uwe
> 
>  drivers/net/wireless/ath/ath10k/sdio.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index c06d50db40b8..3efe744c0c96 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
>  #endif
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  /* Empty handlers so that mmc subsystem doesn't remove us entirely during
>   * suspend. We instead follow cfg80211 suspend/resume handlers.
>   */
> @@ -2175,14 +2173,6 @@ static int ath10k_sdio_pm_resume(struct device *device)
>  static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
>  			 ath10k_sdio_pm_resume);
>  
> -#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
> -
> -#else
> -
> -#define ATH10K_SDIO_PM_OPS NULL
> -
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
>  {
>  	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
> @@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver = {
>  	.probe = ath10k_sdio_probe,
>  	.remove = ath10k_sdio_remove,
>  	.drv = {
> -		.pm = ATH10K_SDIO_PM_OPS,
> +		.pm = pm_sleep_ptr(&ath10k_sdio_pm_ops),
>  	},
>  };
>  module_sdio_driver(ath10k_sdio_driver);
> 

won't this cause defined-but-not-used warnings if CONFIG_PM_SLEEP not enabled?


> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8


