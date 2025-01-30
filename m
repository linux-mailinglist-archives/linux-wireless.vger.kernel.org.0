Return-Path: <linux-wireless+bounces-18227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABFA2343C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29B87A33EE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7B1F0E2C;
	Thu, 30 Jan 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U9VipNld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56DA1514E4
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263457; cv=none; b=FdTT1np++1rzEErAljVFl6xwV2n/XLFp9UmtVlkpQlK7titVlgdw1/6AzRhvQANXKM0tSt4cyIJwL6+POcn0fKOk/J0/PN40JEJqorqmD69tpQ0xz/1uP0eaZ5w3vNb+g1itgl8y5LvtucnCOu8hMyb2hNIbUWrhDE4FHCQuljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263457; c=relaxed/simple;
	bh=xKVjO+DBLQqR9NnXt8CftOf626OcccVGBG288Hk/e9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtmtB4iJLVK5rh9X698zSsjmDOvAMhqq6bwckYH81HwUNJlZCpXwErgsb70+eukXCeDv87cDg1TUuBcEOBfTc0LSQwYJChLeIBwRZqNduRxVoGkAhcIwxldotu1Uxht1mIl/AAwZm4S/KeUC0XcRDyAOUDwSXW21DKBH9PoVmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U9VipNld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UFIqJl006845
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 18:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fiMHQ0z1wbr+JNPD50hh7kKgwucGaVyznKp+iYzAJgg=; b=U9VipNldWNJDJI8J
	MPZ6NKYfl4iCuugmpyGCTkTTYYgMnfypTigcgfg66658Oli5XMS/Ve7aB6c7CjPX
	l38GUHVEk4kPA0Ubsd3oWeOoXI/F7u0lfg+4ZJ9f8xtBYelC1g65w2MCvA/EdCzW
	SqANtiNzd1KpqG1unPMk6NH3zZpxWzaLsdftDJn3YAhBf9WU9FfJx34+rLvKHcoG
	4xHgHW7/dksEh58Xrpgkmmy+whg+ndILgv692f2OxpBQffjOHQJHuw+NN2QwB1Wc
	h+DThgqzrecBt9hxeKJaST59iVyWmiMU+aCJTgDmd8qyio+qkv65r+hMMY83BoYY
	I89DjA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gby28kp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 18:57:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so2208355a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 10:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738263453; x=1738868253;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiMHQ0z1wbr+JNPD50hh7kKgwucGaVyznKp+iYzAJgg=;
        b=WB56z9yeCYO6Yd06ImZGiWs9bec8f5ZY0ymiYM2tvvxg7GLbly3x3e2dRJim8XIxX7
         vexr+eSK754oHZRMrda0bMsPRq+jTKetzCwU4Qw9M0EmPJRRE+vWUA3UPhk8Xgg92ZYu
         BHvwZBCJB8+IcmieITO9iHbPwkYrRn+LHLdjreqNLNAaa0uCokCyhGrrzUY2rLCkaZtr
         pHgaNLWnDRke4OKP5/h7oJi7QgZmGPK0rgUlhHh6fUmB7E7nyuGUe7g/LKRuyVFP7V/M
         HlrlsIYrHYf4htz90CBskZO6p+aMBLO4i/FnSVyHNrorl2fe/rkjty7ZQtfBd+IJRGjy
         b2ow==
X-Forwarded-Encrypted: i=1; AJvYcCW3Z0b+9fIOUuzbt7vgZk8RJWLJt7foR8Q6c0fGonx3Z91J63z2RCz4nEjBgbNl5vRiXpi6Pl2TY8QhvzIvKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0ZdatHZsXWAn/oKDcul/rtBMaZBGLaCpZQlrLvjUgbtiDZq7
	5hEr1mDDxtWdspmlFSE08Tm2bwawU3PyMFrWwM+U8bZNRBYFk/EfWLf7YUFCMSxsv6V8znlEjOC
	OGhu80GGEjyGpAx8Bt6uqLtU9eW3rHSGbaL4Dh+1LV3RN8vESwxwnFDZt1aeE4MOfHFcMKrwfIw
	==
X-Gm-Gg: ASbGncvqJvH+sOiVAVw60mO9Boqa6lo7YlHGlUovBg4PNrTobpCRC8hG5iHrXUtU96I
	v5j/X4+56adnEKra0hBe4EdGa0geLDwrNiaBCxI6ho+YlIjt73ajNAxTwg5TjmUC+9OvggOFacb
	yT0x6n+AHGVMzdbyheSueKM9hzXrNF73m4mDVUO8n57TOm/8ck++qvE4JfXrNfNuhrCnSlxcmA5
	5tUWZ/+9hULQXtJZBF0hIKmu3TzqwtK4CGb/Z2S7B+wl//f9iR8mP3o9q9f+78IyhfkYtz4aCwx
	H3uihau0kjNWUo+zv9DDTSNQjrI2pT627nEe5r2TobJsl7SpDVPLB3Ttj0joDjw6WclsLEm6zg=
	=
X-Received: by 2002:a17:90b:53c8:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2f83abb3525mr11527663a91.6.1738263452809;
        Thu, 30 Jan 2025 10:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG273BYwPCYJOD7Mxuz4ETYiF2JHgiTLRjcgdzwlh75QgkyHtg29AyuhDibvbFwEv67cIBh4w==
X-Received: by 2002:a17:90b:53c8:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2f83abb3525mr11527636a91.6.1738263452421;
        Thu, 30 Jan 2025 10:57:32 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d450fsm2036646a91.28.2025.01.30.10.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 10:57:32 -0800 (PST)
Message-ID: <a1a65ff7-bb5c-4c90-98b6-7155b58e89c0@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 10:57:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Remi Pommarel <repk@triplefau.lt>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
References: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
 <9c12e9b9-35a4-47f1-bd17-6b4641de92a4@oss.qualcomm.com>
 <Z5s9CO_mmazq2Kg1@pilgrim>
 <94db4020-b1c7-4aee-b22c-6fe6d357e593@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <94db4020-b1c7-4aee-b22c-6fe6d357e593@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5tmoluwfPIKP_q43edn6sRhyQaINjyxJ
X-Proofpoint-ORIG-GUID: 5tmoluwfPIKP_q43edn6sRhyQaINjyxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=781 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300144

On 1/30/2025 1:18 AM, Aditya Kumar Singh wrote:
> On 1/30/25 14:19, Remi Pommarel wrote:
>> On Thu, Jan 30, 2025 at 12:21:54PM +0530, Aditya Kumar Singh wrote:
>>> On 1/29/25 22:25, Remi Pommarel wrote:
>>>> Currently in ath12k_mac_op_sta_statistics() there is the following
>>>> logic:
>>>>
>>>>       if (!arsta->txrate.legacy && !arsta->txrate.nss)
>>>>           return;
>>>>
>>>> Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
>>>> if it return for empty legacy and nss of arsta->txrate, then the other
>>>> stats after it will not be set.
>>>>
>>>> To address this issue remove the return and instead invert the logic to set
>>>> the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).
>>>>
>>>> The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
>>>> remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
>>>> commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
>>>> mac_op_sta_statistics").
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>
>>> MISSING_BLANK_LINE
>>> 'Tested-on:' tag missing blank line after it.
>>>
>>> You missed v1 comment? :)
>>
>> Yes sorry I think your mail never reached me, did you CC me ? Do you
>> need a respin ?
>>
> 
> No problem. No need of respin just because of this. I think Jeff can fix 
> in pending?
> 
> It's strange that the v1 reply appears to be delivered from my mail box 
> and it is sent to the list. I see even Jeff replying to that. But none 
> of those are captured in patchwork. Not sure.

it was only sent to the ath12k list
perhaps you need to include linux-wireless@vger.kernel.org

> 
> Anyways, v1 comment was regarding this blank line and one suggestion 
> that in future submissions, please use base commit tag.
> 

I've fixed the blank line in pending:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=c7b9df20d6a48a279f4b537920049094701da14b

