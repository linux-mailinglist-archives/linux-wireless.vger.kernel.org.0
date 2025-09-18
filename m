Return-Path: <linux-wireless+bounces-27459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7447B83034
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F3E620358
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452ED27C162;
	Thu, 18 Sep 2025 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmIDrlxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84439292936
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173320; cv=none; b=HuL45g8FszyPumfojMAB6VboIDLJq09GKuDKKHJN0yfB8MX3t/pwJLA9/vUObvNXNbBlkYKaLfRTmGOguoz6X5a+T74e4RU24GqKA7sQVHOa145sWKpOoWTogRKEQozIs5vJKztCb5LI0RkY7RpA121DoG+o68cNZTTh7vK6CVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173320; c=relaxed/simple;
	bh=Y7D9Cw2q27SzwRil/BzlQnJKlea8RYkp2XIMXqYmTIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7YjPG3/JteKe6R0xYvXyXRCuInoIjw97oEs2qH+P+uEsK7TMY4Ig1aMm9m02UXgdgJs2Civd8uZezCdto/0qNLqCMTTNigPFSzaA3OHmmaj1dT0/Q0pNZlYvv7rpHIAibH0GkLa4Y/lhLwVYz/ScwtbJChNu0kZNZrXyhiwqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmIDrlxb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMbcl2013186
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T5LOYhtajDzTqhlpHd5ftqJpHde0crMjZzmyN2Y+aG0=; b=BmIDrlxbbEn7qjmQ
	BL3e+01YQiRFskMUE22idYzoB8K6Myy1nnACcJ9cawIdtXiOvH0NPOmIJAL7jMoR
	qmCp0JZZsfEE6GZnk6BcD8aGBxUI9Z9wDSRUgzHtoPVRmjTAH8SWlLz+nw7jR0vt
	oU4ppJ0NWTC8p2lcKO0FV8vVDAJiYhuDdkXNZwXs5HPeZjbBYGnjnSAdvTAi02w/
	kNOp3Y288sgD518g6zQlvSAviY2KEI/4mnFa6ZWC/xu3Bd2C60oJ2CpaJ0Mpnvvn
	WsZEKsFjppSS538yfzDCrplH04CSngd5ZghlWhb0LwvfO1QQQSAts8t2VP71z4l8
	QE8Alw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx0ys2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:28:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so531985a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 22:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758173315; x=1758778115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5LOYhtajDzTqhlpHd5ftqJpHde0crMjZzmyN2Y+aG0=;
        b=QYSAZk4FtGtMI+UEebG2ulNSOT/fhyd2BF0NcH+dIWgvQqoiHu+R0BU1oFUP+zWHZ6
         xcTBXRmncSEar2BT2Ww05mYDeZD22nbGpxj8nBxxdA2rJ/FxHEX+7zRWeToyCfLwS47u
         jHslZO8iRX+tRVblzsIF0iLsdIq2McjkqPSTA+UIYTOqyCm+OutXHBoqmajZdiDthOux
         PgchEV4ekUsTv7G2R4IW4KJeYZ/2Il+c86hF9L6L9In/nyi7zRp8AdX/CR2lh6kzj2WB
         cDs5w5G63YJALzpNcTHbg4M/13beJ8KyEi30uXPIz3FsZ9W4zJErXdAwm6D0uXfN5DHr
         v1IA==
X-Gm-Message-State: AOJu0YxnlcRfcQLqpJc2H/1yY90nua7UwN2g8bcPXkvduU+z9QvtOldv
	ptcKuCGYrWDSTEVEBqCsxyKJk0+vCu82p4+D3jOx6LiEVohp1Vh0P7/nb32KRXALlFQzEqRzV4h
	x/prS8i9dcrYwlDT/gikAJuf216qJ6pU96y2Qw7VGB2JjwlfcId/xXMkDtEuQa9dOLwvGjWb7ew
	3SBQ==
X-Gm-Gg: ASbGncsKjUg6ehlkTqJ40aop6eKPAYX9uByU/1ln8kHqxy5WljDX0EP7sFJhPiI3ZSg
	NgtyPjWJ0AQ0lwFv5CC7io/pXARcQhGFF77Fij9XyoLq1RABtN//WVW7tVgyv5S8zWhr5vF7BkS
	v86d4eVR0FnRQ9fwjMm2DCrJKaY3SUNBDVnjrRCMS56eESYRgfUgBlcq3t1l5szVptxYK+ijMUm
	r+DEj6lF8NMTtvQQu+B3+IUO/IcD41NUzYQgeFOLnfwQ80e20M5c3bwWQa2ZE7dNpa8r2xM4yaK
	rItsEmdPjLRiRAs+SZWSA/IzLUlBpQOFpI6eGPM9XmDJdh1dmE3VnKIaAAtyPN1INWClgziTzvI
	isHipEQ==
X-Received: by 2002:a17:90b:50:b0:327:b2a1:2964 with SMTP id 98e67ed59e1d1-32ee3f008e8mr6458153a91.15.1758173315358;
        Wed, 17 Sep 2025 22:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHswibhztsG1BwP2eDesVpF91dnsj/pntyJeZMSn3QPhFedll694Gp7MkUFWnZw6wUWst4YEw==
X-Received: by 2002:a17:90b:50:b0:327:b2a1:2964 with SMTP id 98e67ed59e1d1-32ee3f008e8mr6458123a91.15.1758173314878;
        Wed, 17 Sep 2025 22:28:34 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330606509e9sm1263171a91.9.2025.09.17.22.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:28:34 -0700 (PDT)
Message-ID: <d97cd03e-293d-91e3-ba30-a7015e14fed2@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 10:58:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix connection after GTK
 rekeying
Content-Language: en-US
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        alexey.klimov@linaro.org, johannes@sipsolutions.net
References: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5rOJwRzvRlBZ5-kx_hWe6FF9bB4uPMPO
X-Proofpoint-GUID: 5rOJwRzvRlBZ5-kx_hWe6FF9bB4uPMPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfX54HxVWk6Vaoe
 l+JOuCkMaZA2j1cY8iQZVb04tjZYO1I9WAFjCvpQhxeNHObdK6y7DqgQP/HEnYTRCBlVOpthAof
 2GuI+WAxdzQGFyT7jimK49c5x4R4FAQ5UV8kRq6+0T+nl3bKLPJFshnUk92UPtKtKzdkRNfrvNH
 DVFjQlgNiZCsioSeDr/TcRYkKg40Pzk2ZlU2l3g34GVqlsy0yEg8f+QIGwRvHuKcUDtgiousIGn
 +4xnUTpGqqFKHUBvAY48YYk1/0Wz5VQQQdlZR0+x22mQPakqn0aMZ7TPtYjMXS8vNFC9NhQUsmk
 N3YP8s8ZVmnmTWVz86CG38E7AM63gP5LQkcnylh7iaXRcEAAKyfoLQUy1ml5po7uO1TrLZFS9YM
 AoYoyjXd
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cb9884 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=JSNtCRjb9TMmkz79QN4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219



On 9/2/2025 8:02 PM, Loic Poulain wrote:
> It appears that not all hardware/firmware implementations support
> group key deletion correctly, which can lead to connection hangs
> and deauthentication following GTK rekeying (delete and install).
> 
> To avoid this issue, instead of attempting to delete the key using
> the special WMI_CIPHER_NONE value, we now replace the key with an
> invalid (random) value.
> 
> This behavior has been observed with WCN39xx chipsets.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> Reported-by: "Alexey Klimov" <alexey.klimov@linaro.org>
> Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

