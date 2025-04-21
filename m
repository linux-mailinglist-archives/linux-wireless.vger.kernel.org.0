Return-Path: <linux-wireless+bounces-21794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2ABA953F7
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487333B4F74
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3651CAA79;
	Mon, 21 Apr 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKzSFaGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28251D5CEA
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252276; cv=none; b=toEwNJGZx4Jv+Uw9RAVFD+VwWwMHds4XcjEpU2W3SIZ/VHt5lU0bi0eGpfKlvxJomeEjAok0iJhx7qNqWUZgo7cnDkgZsIyvTDABTfYLsz86LlDMLMGYOydHczBSJwN61hnctiDNrUzcmWpmr9Cr/cGtpIWvmZ195NDwPHvSOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252276; c=relaxed/simple;
	bh=IuVAiCUqOQwljwghRJ7fTQnhwcOP3MTiPdxnmqQFSgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpCDgPyN6rG1KbcR6w9p3HWD1Z6ihYT8t2sM7TMqse6a7qU/xwPsu0619MEV2ZoPd7wDXb1QDfa12KL+CrmyhBXupnPX8ozh81pdsLFTrrggBACANUVCp0b01BDUY8lNC49skhBy627oy/lhBC83R64/CyoizRJ4yJ/D068+RTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKzSFaGC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L9pb1p014438
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 16:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f8fbPD2NtxyIh3l37pou8fckx/G7NKhgopUfIfvtJ9Q=; b=ZKzSFaGC9+7cWVZw
	pCdeogtZYhAXa+6TkCWjMCcrLNv62cMslnbSK8Oj3A60xf8zik9BlDCT+QL7pM+0
	sQLJfYssBaBBB7I7HmmsTRvjt88zdrSzm8+MrjGVFi/+ADzlWR/BoNaKbUtYJO1P
	pieQVO8Sh3M1LM6WfuLoRyVgyLS1wl0Z6D8Xy5kpDMYtSGVmKB68nTD0azKc/pEh
	bSfOES/L9RsYW4H4MdLHsN+YkLhKH3axv0LVxaaXYzyz6WiqjioKvnCjMMyjG3V2
	gs2BNZ8gmsxsfwLtTQmrE6uxp6SK84TxG0hhhksbj5oEKB0/Nw3Ni9U40KtcxGs1
	F73aTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46435jcqjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 16:17:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3086107d023so4160989a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 09:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745252272; x=1745857072;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8fbPD2NtxyIh3l37pou8fckx/G7NKhgopUfIfvtJ9Q=;
        b=LJ++mYTUoyIuTPigTZknY8VVdDmk69ddgZSZAjoVGzdIJBOoghxUrZHl98AAhRgPLQ
         ti92/2HqYjd7Rw4vTTZFJY5NeLQ9Nmh+1Kfj+alWR1EWLKFQyLAa2KjnK2BA7U9pHefw
         85LohEZI2o2O1dyLKm0THog23tGk2GZOzgDp0d/6Ak0H/TKZf2Z6uX5EkVXdxPNXZgPK
         Ip4I4qRUcZHNhaFLJPt4lEVfhhHtTbipbjYOP0LphoW51qWcGDOXlb9siPV1P4ZVS9bU
         57fWetJVbsce+fegULCsSa45zS+n6zg4ABGJjwxKclw1K98O3pD/KHiKGqIS1V1aMOoK
         IekQ==
X-Gm-Message-State: AOJu0YzeIxLy1GDYhPbxtojZytUTcxn2jIUR3pcXwp75LpYzfhmuYam7
	hEQRcq2q2UwsHz8DCdR8wN9knCdd/GAPq3VxBf8IJS68UsJb4G7J5YTFcS52KfSrjNy38mTWnvM
	SToVgcP1r19yFMLugcQDZ4K61yHLZegFGqcGZcd6+nDwB8csXDsXGOqLzSpMS+PUIfg==
X-Gm-Gg: ASbGncvHEk21MmLLepqm0HD52ve44CcKQpoGqIvHofLGwjj87H3rDaCAUrVeqryekMg
	nysAQgfOKdzkZCCb32Yq9qC4sn/HDtWsWOAGGKLOG/knaqbH/Msre0a63K2Jn/+pKykspZEkphm
	qRQnCi8K1oLPalHRlMLojNASzrmbgbFc7FDLzCxWU8PsDOIPwzOD1BIvexExXVfY22/S4sL5eGN
	6o5nGk1IDOH1Q+xEA3lAEAHHz4uHWYpvn7E8Ee3G21CRF9uJ1L6FX8WYOVDACNC7FklFgH0Vspg
	mFfJZvKXswxa8Z/V0p2ssvq/O/yDb7wFW2WOOgzsuQwzn9gfxVNGkBCswOUbb3iLcBM=
X-Received: by 2002:a17:90b:51c2:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-3087bb56444mr18431236a91.11.1745252271842;
        Mon, 21 Apr 2025 09:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tD/NOmm7V6TL/yBnEhtvSCWTaIJQOX61r+dAwkEu2rf7ZlcsGmggnhC3PaKfz3fsM+1V4Q==
X-Received: by 2002:a17:90b:51c2:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-3087bb56444mr18431197a91.11.1745252271476;
        Mon, 21 Apr 2025 09:17:51 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df4ed27sm6803693a91.38.2025.04.21.09.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 09:17:51 -0700 (PDT)
Message-ID: <a7b5e80c-2ed4-4557-9304-8e5e0a6ee513@oss.qualcomm.com>
Date: Mon, 21 Apr 2025 09:17:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: ieee80211: define beacon protection
 bit field
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOYG00ZC c=1 sm=1 tr=0 ts=68066fb1 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=gC-mUCSe0qw8eRQpxs0A:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: MMmwWtgG5VFQTHw-ExXXsUZ9lcwgSjU8
X-Proofpoint-ORIG-GUID: MMmwWtgG5VFQTHw-ExXXsUZ9lcwgSjU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_08,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=912 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210127

On 4/21/2025 4:15 AM, Karthikeyan Kathirvel wrote:
> An AP supporting Beacon Protection should set bit 84 in
> the extended capabilities IE (9.4.2.25 in the 802.11be D7 spec).
> So the *4th* bit of the 10th byte should be checked to figure out
> whether beacon protection is enabled or disabled.
> 
> Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
> ---
>  include/linux/ieee80211.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 508d466de1cc..aef5a616d598 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -4087,6 +4087,9 @@ enum ieee80211_tdls_actioncode {
>  /* Defines support for enhanced multi-bssid advertisement*/
>  #define WLAN_EXT_CAPA11_EMA_SUPPORT	BIT(3)
>  
> +/* Enable Beacon Protection */
> +#define WLAN_EXT_CAPA11_BCN_PROTECT BIT(4)
> +
>  /* TDLS specific payload type in the LLC/SNAP header */
>  #define WLAN_TDLS_SNAP_RFTYPE	0x2
>  
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8

FYI there is a pending ath12k change that needs this definition
https://msgid.link/20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


