Return-Path: <linux-wireless+bounces-17970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CEA1CD70
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79537A3347
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722A1509BD;
	Sun, 26 Jan 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAW7lAlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151A45948
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737916302; cv=none; b=eACccIhREDoBxziNZczqoz+pi+p8HnMKv7CuTPo83UHBajMmnDpRnLCWf4wcM0wECGLz49DmoczDcswS/arVvlFf70LUJ3EBl1PQMKurcoNKR50w9wvJT4G4oyVWe8YELnDfV+Nk0GrE4w5ntSPj6mEIx/UmV1WrrGEpbwQSWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737916302; c=relaxed/simple;
	bh=QzBAPB22KF7FuTVH5V8/Wp7I8rmVsErNsYwFVhjg1vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpSUtKq2+UKCmUwscjpxVx7qF+JCEI4B9qYNSBq09qbto/GCPP+msMDbLD5N/YEcdEiWaqWolsiJWGca35stXDEWqpcOlif3QMz8MbsJY4aPOVEn1n5XlZ8kZRsWDz1vpW7l7lIs05cIoasF4mdCxIC4zDkSdMkhaKez12VBjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAW7lAlh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QINFGq003967
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pud9PNRzD3MI/cZaRiKgG8KDXkfED8iswD139srnImw=; b=hAW7lAlhfQDg3c/R
	vYx1YGZSSfeiuA9g7t5ZT76496dTY1uzbLEImPjPDOJsHZMxxtflKaRGwbXbBDWr
	eTVuuyGk1dci4tpmZSYhKHloTF0D75mf2jjvmX9L9ldgP3Xhouos5zvYOdBgeRzK
	NP9mcX0o+uk9d0csBQxUa5M1rPuwLftwzdoFK5F7uB8iOcTxYCvIV5yYdT/GA03+
	QoramRI4dHWZ4/NtNAwrrtB8tHs9XKSChxjuaNQpzufwCxsyDnqBH5HS8rtC37wy
	2xIYP0Yj2jsqnMUGAmi+bh07wYoaW7bXqHRj86jFPCxYcJzY44svbxD5gXm3hmMs
	i3vANQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs1pt5f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:31:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so10607167a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737916297; x=1738521097;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pud9PNRzD3MI/cZaRiKgG8KDXkfED8iswD139srnImw=;
        b=wdC9Dk6K4GaQGqeh2HBB/zPkbZ0iCPbZfwSoxLdL+v/5+q/lw0k44QCAFnQexe8C01
         JdY2JANEMy/UKRRqlDsTEKzS2hiOiuiN7Sqhet0VeSbPozzgRzCriKWcHwJHASrwF3Yc
         FG4hbJvqtKBVxjj1KYvOgDK/QbV0VUPPZ0hDl5s9HLGX/LrckbvYsZnQkBZrGzzB5Egy
         TI90NAc+pwpYUKXJr37ySId4Rq/Z5MP7+02K98FIvcYtBAtTdppQhPCG+yAl1UeN2Uc5
         sGY40ve7H5jhQUPuiwbv5od/5qIW96/oEDSL56LQ3hfMw2DXsdKqxp+r0VEFjxrjd64y
         cZNg==
X-Forwarded-Encrypted: i=1; AJvYcCUWVCTVedGESu05s8GBRSHo8qbD9EUFB6n3SemH4X9c6rdO0hS4un6ov25rRIMoAPo4d3zamFCLuV689lFAkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6OBqsUI4iTyCUu/SRLPEdXKOHojxUkCwUfu2SQ9X6AyOch+x
	zAnQ+W8hR1rlzpzN4hpnlJgDW6+Mvtx3ZKkk+qSHj+bcNLwNE27ZryuUSqx5dYyItKnTaS0bT3x
	9NcIJjnXklLfqKVpbSaD3aG/VrmCXQ0beeaKqCOewz9sn8yE4zPSK7NAFI/9OmIrIJQ==
X-Gm-Gg: ASbGncvhwk2OwbI6XaTahHY+81QjaPx+P9wmRd2BEhk1/+T/dlQcGwj67IbpFCuMFAb
	DIRFUJixJAPfwVz/otO3zX98V28OO047yICWzeqYBhTlTD0jN/v/SLxPFtwyg4z7RoOt7ghc5tN
	6uOrCpxe/0mg+ExlChukLDrZbgJOVMXgUi1o9TyJD7vymZ6sbKxdWRFEzErPbU+QWrOhizafC0N
	e+3kgEzeucGA4QkXyUaJZmmjEMO/Wo05ZxRVfufL8ttqyaKqHw/+vs2wPecW76bmbDlPS1weop1
	ieUx0ToAlfwodUFrBQA1Q0+mA6wr/6wsHBA2dOBuNYRRR51pk5qUicui8zZPCJLCSVu8glZWoQ=
	=
X-Received: by 2002:a17:90b:5244:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f782cb58c3mr63699417a91.18.1737916296995;
        Sun, 26 Jan 2025 10:31:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8M/rAM+9mO1LI7JuFdJJ4HCifG7IRN2A7evzv5QhhiiEsTUKLj3nd77QPQ12zTll45lKhvQ==
X-Received: by 2002:a17:90b:5244:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f782cb58c3mr63699389a91.18.1737916296622;
        Sun, 26 Jan 2025 10:31:36 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44530sm6088931a91.7.2025.01.26.10.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 10:31:36 -0800 (PST)
Message-ID: <c101bebe-ee13-4f34-b7b2-c044396726ff@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:31:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
To: Remi Pommarel <repk@triplefau.lt>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <a4bdebd14f5dbec653b75277097917910344f244.1737142154.git.repk@triplefau.lt>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a4bdebd14f5dbec653b75277097917910344f244.1737142154.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _b4Q6p9k3xf8GtXuoGO9y9Tm8k6lz0u5
X-Proofpoint-ORIG-GUID: _b4Q6p9k3xf8GtXuoGO9y9Tm8k6lz0u5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=987
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501260150

On 1/17/2025 11:30 AM, Remi Pommarel wrote:
> Currently in ath12k_mac_op_sta_statistics() there is the following
> logic:
> 
>     if (!arsta->txrate.legacy && !arsta->txrate.nss)
>         return;
> 
> Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
> if it return for empty legacy and nss of arsta->txrate, then the other
> stats after it will not be set.
> 
> To address this issue remove the return and instead invert the logic to set
> the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).
> 
> The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
> remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
> commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
> mac_op_sta_statistics").
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index d493ec812055..cbc79ec7ac47 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8912,21 +8912,20 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	sinfo->tx_duration = arsta->tx_duration;
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
>  
> -	if (!arsta->txrate.legacy && !arsta->txrate.nss)
> -		return;
> -
> -	if (arsta->txrate.legacy) {
> -		sinfo->txrate.legacy = arsta->txrate.legacy;
> -	} else {
> -		sinfo->txrate.mcs = arsta->txrate.mcs;
> -		sinfo->txrate.nss = arsta->txrate.nss;
> -		sinfo->txrate.bw = arsta->txrate.bw;
> -		sinfo->txrate.he_gi = arsta->txrate.he_gi;
> -		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
> -		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
> -	}
> -	sinfo->txrate.flags = arsta->txrate.flags;
> -	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
> +	if (arsta->txrate.legacy || arsta->txrate.nss) {
> +		if (arsta->txrate.legacy) {
> +			sinfo->txrate.legacy = arsta->txrate.legacy;
> +		} else {
> +			sinfo->txrate.mcs = arsta->txrate.mcs;
> +			sinfo->txrate.nss = arsta->txrate.nss;
> +			sinfo->txrate.bw = arsta->txrate.bw;
> +			sinfo->txrate.he_gi = arsta->txrate.he_gi;
> +			sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
> +			sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
> +		}
> +		sinfo->txrate.flags = arsta->txrate.flags;
> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
> +	}
>  
>  	/* TODO: Use real NF instead of default one. */
>  	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;

This patch conflicts with the following that is in the pending branch:
https://patchwork.kernel.org/project/linux-wireless/patch/20250115063537.35797-2-quic_lingbok@quicinc.com/

The pending patch adds eht settings:
+		sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+		sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;

The pending branch will be promoted to ath-next & main soon, so please rebase
after that occurs

/jeff

