Return-Path: <linux-wireless+bounces-28180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23286BFDBEE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 19:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CAE1883026
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9503F2C236D;
	Wed, 22 Oct 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nobq8lgH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AF2C21CF
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155960; cv=none; b=tXLHCxXL9vFN9SjdeaFA2iTLs+sS7DVUYYaIGKXFgkD0Q7w93lDUgPGqXy6mRQqxFm7H/6E189znofCy61ZW1rkJg4wV7bTRc5rhwe0de8G4EgzpGRQVE15a3NsrpW7jabK8fJySKhuN5PDElUNZzI9sj+vCdjdW2vA+Yszjfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155960; c=relaxed/simple;
	bh=u53rqfo/IBXTsdNbOFR5fKuvoPCWnTJ3WTaDqUmvok0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhQHldHxKl2+znyxOvFKbg8aMf6x+THTbP6jp9r71yio9Q2QhrGGwArZOPB6NbI3GBcu4i6X2DaNlhJYvhu+1YUoRstiONVH3aPu/bqorexAOx5sAoc+6I3ojIHu6PoO/VV1xdbHKCp9hUT9RN9zmSySJxJ6USdVtqZYDxaGMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nobq8lgH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9rwQa002287
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 17:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YVTDxUa5MCBjwGzNjh1dYppHFtbwKyHbDkblvk32S5U=; b=nobq8lgHykBF7Ui0
	92NzON6L1iETVxwcgtgXraWJbEsEE5sP/u2wOpHRSstUolkxBNli6Jc/cs5nwJzn
	GTwXyoWVaDp3q6BbUTJJGcWlhq8vER92w9+mZIsYkFzNhZYMGBZZjFgPAdkb6fs+
	rB1ypcz/j6VLBy9j+1Nwds54Maosf0nAyw9813lzdJVknBmjubMdP8TVDwa9AHSb
	1WaBFruQcdMuwmU9mwHdtt5pA4+x+pUh4k4IZZi7oGKTmOVF/UxYmdqSgOHj3pQP
	cBWMDs0oelx3qCnK2Co1uJs/MQvPS3K3zeu4D0QgNKHnbhcoRf6TxQ2UXp2vKSU8
	eR8geQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wb8mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 17:59:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55443b4110so833533a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 10:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155957; x=1761760757;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVTDxUa5MCBjwGzNjh1dYppHFtbwKyHbDkblvk32S5U=;
        b=qEHjF8UeDEqdaps4utQt4wekOyQ+cagdcUXh96BklvDi1TScHx4G+XC7xsZMFdEJl3
         bdGQVsD7wunlB5y8+wTaRgQ7NQeoBO4+iwV7XpbVQZw70DaVDC3f3iqfOaTOBbaG53F4
         eBWlmHt8NMWmg4auNWxLpPPFAvmpYJVnuXP4N5J7Exd+Fn/AnXuhV+fvr0qrMHrmRcEG
         ++rnQCFVBphYAzGWsy3q/TXpkGmc42+wajaS+8KkC+CB4zApebRCUSr2/w93/F7mdW0C
         fHRqNtnk5agc9ijn4izWdcBL8Zg3eqFr42cRlkmuWChiw+u8F/KETu5OuEUFbp8H+ukh
         qSkQ==
X-Gm-Message-State: AOJu0YwEu5OSZo3jmzfNzk4nDI7LncX6VP8SfJ6XHhrV45RtRnrgkbEQ
	7aNv+YEj1x/XBQxwCv+soEdzQITptyTiMH9cNIK7qRS++1sj7KJsVmokl91Mkqq4gDwtreeANt2
	juVop3ZEr1gzwqY2DWTtXx1SZJ85kFh1Tu4DjiM6jvRkLuWHEuBWRGmUhPDLH9GYaQ9zUdQ==
X-Gm-Gg: ASbGnctH5VjhIGXKhpuIkyrcK7rHutldpdnELKEWc/t9yLUspg1PN6ULfkX0B0+aoe6
	sxRgCb9enFK6tyBGUZjfFUcoWrXoixOInSn2G8PN0WmSmlqb+OjArnVRVNJLkt5sdgErqcgW1L9
	HooKRUiTNpxWwkv6+1l8QX4VKCVGOIzNg6TMlb+SNXmi7MOfYoGi361PBsTE3+86EpP2vr5WU2V
	jEnLrBRLzE/bzJe5Tn9SanSn1W3OmZs64KdWC8iT7YD5yo/V/0OKSK1bI0jTH5s784vOXYemlcM
	kwX9tcG8UeKGYe7i/pTFJfew98hJ6TzHt9qLoPBv5R2qFx2BUKYe2D/tBNi5pH8iZAkNmHIAqZo
	PUg3gzVCuEOwTmK2YdWLhPxmhGWC7oDipykY=
X-Received: by 2002:a05:6a21:6d9c:b0:339:bdbe:df98 with SMTP id adf61e73a8af0-33aa81c4325mr5628877637.28.1761155957185;
        Wed, 22 Oct 2025 10:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5y3u0xzYCHWDSlNnoOWL1sz7J3kf4Fz0/YdQwwpxY8t+Cj2GW2WwYobgvQLg6BVs7jiFv3w==
X-Received: by 2002:a05:6a21:6d9c:b0:339:bdbe:df98 with SMTP id adf61e73a8af0-33aa81c4325mr5628842637.28.1761155956737;
        Wed, 22 Oct 2025 10:59:16 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301230bdsm15132413b3a.75.2025.10.22.10.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:59:16 -0700 (PDT)
Message-ID: <28db1c63-c87d-41fb-aeb7-9cce0f083f2d@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 10:59:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath10k: Removed atomic iteration in bitrate
 mask clear.
To: Rory Little <rory@candelatech.com>, johannes@sipsolutions.net,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20240806004024.2014080-1-rory@candelatech.com>
 <20240806004024.2014080-3-rory@candelatech.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20240806004024.2014080-3-rory@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lmJ2XRSp1RY5OQJOIft_mOUMeG_jOfU7
X-Proofpoint-GUID: lmJ2XRSp1RY5OQJOIft_mOUMeG_jOfU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfXy5JDbu6dgyaE
 fZ5OwhIVZg3G4IYTTBvyWEIFnNkl2ggXrdT9WLRpYoT/LyzymjIuNVAe/SjR/eEY3t0ao8Z5MqT
 NPXpqzo6V4Xr9YcaatiBAPLx2+I4upnBiVCq9qjEGW3MNbCW09HwpPDabc6wTRIgsskf4OSDVla
 v8vMOhFgNHe6E/vfSDntdfR/aDK/BmGIsC/TTou2wPNfzKdAGA9lSA5JxUyHKpxY3vL2sVo94Il
 nSvWhr7oKR4oIQZr5tWz2vRlnVKav6L9uprkwOXFdQZJ3srsDLtAII/UsNjsA+Ez3tuV06BagrN
 i8Cik4oAbV577f/ilyPZ8WCU8uThLGV76udD9giTVwhpCDjs8pX9SapwE0p5xKDgm+29fPKa7+4
 JVBjxKAZWn75Li8tUq2KcnNmTgV1qw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f91b76 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uYVGJH5IAAAA:8 a=I2mjh__s8OsZQkTd-rwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ZkEWZNUrOYKkpCLSUeX7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 8/5/24 17:40, Rory Little wrote:
> This operation requires some blocking calls, which causes issues when
> attempting to guard this iteration's critical section with an RCU lock.
> Instead, we will take advantage of the held wiphy mutex to protect this
> operation.
> 
> Signed-off-by: Rory Little <rory@candelatech.com>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 7579a1cd7d15..a1a13b9ad465 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -9502,9 +9502,9 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
>  			     ar->normal_mode_fw.fw_file.fw_features);
>  	if (allow_pfr) {
>  		mutex_lock(&ar->conf_mutex);
> -		ieee80211_iterate_stations_atomic(ar->hw,
> -						  ath10k_mac_clr_bitrate_mask_iter,
> -						  arvif);
> +		ieee80211_iterate_stations_mtx(ar->hw,
> +					       ath10k_mac_clr_bitrate_mask_iter,
> +					       arvif);
>  		mutex_unlock(&ar->conf_mutex);
>  	}
>  

+ ath10k list

This was deferred back when Kalle was maintainer, and I'm now revisiting the backlog.
Is this still needed? And if so, is there a reason why the other instance of
ieee80211_iterate_stations_atomic() (which sets the mask) does not need to be
modified?

/jeff

