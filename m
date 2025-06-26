Return-Path: <linux-wireless+bounces-24564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C592CAEA3F3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 19:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CA53B095B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19118871F;
	Thu, 26 Jun 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="faIyVdJB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39021B3935
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957290; cv=none; b=E6nNh3PyRwCSDe/NWzmoFqW+XlDAZWlZoznw7JtNIFzEgclBOe+YZ1NntUBDdIM3q/AOeClYEjeUTXzfSBoXPPI8ti7y+FwH/4iJSMRQuESeho4BtTtjFsOCUIUETQ6Bad7gVeamUnYiUBekjep1LOG1nNBd1I4wxs3tLAvDiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957290; c=relaxed/simple;
	bh=y7TvGQOVft2otZwpRj8+QJCETtao1sylSI0lV7VKBPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/99Dud4wrOMCUEADHv+CAjZFqdiPeOQMNE9/Pm1IUoJ077Oh3OeDE0F0ppk6wXrGLbrsLQ3udp6WmHt5ibyHp52gD35gR/g23D0n0KRlnXwqBNWQ+AcmkfXZ2X+/ekBm/oMjM1UCMoEr8N8FS2zOYWlW+HbspuZ2DuDrBBeNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faIyVdJB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QA0OLk008400
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CF3WGzhE+aCOxzpXb8QO3q3tol1cNtQp1vp+qcU6LNc=; b=faIyVdJB75ifZji7
	lbGf14agWJm2nRxVllGH5IcZ3X2Kjvx2IIDoQZRwbFO7JFK7aBkF7dS4ukxUaWkl
	SC/vBA/gNCMlI1ag1PyCeYR7/3yEoQewzrBgr5ehTt6krfdPoqT6rPXap1X+SC10
	IcOSDn+kVPOq+BMf7Av7ITevNVrpbfxcBTb2rwCfUxpCzKoI4g+oY5OqD77lsQGS
	6T2seFU01EngZD07aWVVytwNyEEPpBLOFVlBAEhImB6jC44QPaX5/2M9oqjH8kqu
	FXfMY+1WVt+nkXN9m0x6d/UZlVrdz+tlX1oVaOVF/036Fw+F/Qgm3PO94gNEnrdK
	cRXsUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqtgr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:01:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23692793178so10035765ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957286; x=1751562086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CF3WGzhE+aCOxzpXb8QO3q3tol1cNtQp1vp+qcU6LNc=;
        b=Yw1tT1MRNmOYAD7GDM408cXUvXSJy9XiLIcfXoeyASjNTI5i3hbvBJ7tOjatrf7ltp
         To5ephgRgeSSvnp4sAU2YQXebcq4kvZIk4xSDHUhnvVYJYeGdRl5rcJUZkLPOpb9yQpM
         XtpzDEnjlb4Y9RO47NS+xmUegjq92JQU6NXbuwOAWOPFgBiD0Zv2YNXGYHeuypbC3gTE
         mFwrtpqp2qRM8QsF4k9yzVO9RZua7ONSpiJzG/4eXdbGQVDFRziqLT2kZzDyosb7WADG
         yYQJ9n6cD+0WBarCvacFfjrow68BRPVnlc6ChsLivLCFaR+mGi0fsFCfAEurKPKBRdIA
         O40g==
X-Gm-Message-State: AOJu0YzzacSeAZsCdq2XUrbXYJ+NYndtj1by1XF/jhnWW7Dze4Sn9cb/
	zF5sOi4k9PSwnEpUE4zSsBSm6LMQ/QB4m4EN2FAS9bC7YDg13e4CGAG2fUbXhHs2XXQYaX/l4mx
	+DNbtZjuWLWxe7YJ6lgcsie2f+WR3cgCbzcuYa97vM05pj52P96ZzD/1h7qMAhb/0n1tdkg==
X-Gm-Gg: ASbGncv74gT+PAJGmskppDNcX6wQsgqMEVxzutFCB9rr5KMz69qZ7RmB7SqYTODJ6L1
	YP6rSysVHMQgyhdUBO0D/i3767TYdMGdbx0rWou88x9Z/wgr6xf2+JvlSKPuEMeoCKVwf5hulWt
	VzkanfTG2sI2AtgrxYN1GqKDl6P4jrO2eM2vVI9qhZBnhRAYGQsqLwwOwK0AErDneunBRrQ++Jq
	T/YP1iN2YjxCmenQaQ7ThIans7U2L3qaSH1aPLcRR0DrSED2B5e4maOT4jZLJxHUmwo067xKNaa
	pG3ZOLlB5vPs1bPXQijYlYGiUbe6BtmaVvoUtxxXKfCEdxoG2Ts03NmOI0nd4xLdzHHWW98=
X-Received: by 2002:a17:902:e54b:b0:234:9068:ed99 with SMTP id d9443c01a7336-23ac468217cmr676375ad.24.1750957285887;
        Thu, 26 Jun 2025 10:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6zvnpbhFjoE8MY0MbGluoHDEzdXqP7vAxIz1miQ05PBrQaeoc1+PwDSFkBzn09LhcY+DT+A==
X-Received: by 2002:a17:902:e54b:b0:234:9068:ed99 with SMTP id d9443c01a7336-23ac468217cmr674475ad.24.1750957284149;
        Thu, 26 Jun 2025 10:01:24 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.255.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe430ba2sm2342015ad.207.2025.06.26.10.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:01:23 -0700 (PDT)
Message-ID: <c10cdc33-14ad-abb0-1765-2f27dee55595@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 22:31:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Fix station association with
 Non-TX BSS
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: en5gk7DxxEiDiE7bz_XuiMF_76HpYVuK
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685d7ce7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=/xG1ZwzdjF5UbGEDupzz2A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=5MRXV6a3SOdtvRoyAP8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: en5gk7DxxEiDiE7bz_XuiMF_76HpYVuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0NSBTYWx0ZWRfX70wXaCTwtbKJ
 mRGXeTfSuHacRC5ls0/WD8LfCcSWWcqdxCwSQW4ckNLQ7EygJ4y3It+pWO6QEMXnB16T+nPCAIw
 t/ugKbgI9kyaH1Az03Vj1Z5L4q1daP41fe0g/GTZxiSqevcfcxx4A4TUDXjTBXt3Lm7Vura+5ew
 YO58nfKXovUnIA+HTNe8xLbobFQsvoQNxS5PMl3phJAc6R3mcA7cOBsd6q4AoPaRe5LRniEDXo9
 Zvg/lF4ban0TxNPt1mq85bEQPawj+WHi4EBS/SiOzKFsCVzicWU8EOCyiTGg/rs6Ur2DURZiIIq
 8K3c044HqsEs6Xb9+Xp/sqHyU5k0K3AP7dQQKOqSyeFvW2lXAfNpFj+36319tueVbhzgGFehmti
 3lm1j+JBKOm8PqVqdcUKu87ShiDfPJmmeLposmF9Vl/4+sigxsA34Y78fY/dJ5WX4iBFT3N6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=775 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260145



On 5/30/2025 9:26 AM, Rameshkumar Sundaram wrote:
> Currently, ath12k Station fails to associate to non-transmitting BSS of a
> Multiple BSS set as the scan results from mac80211 does not have
> information about the non-transmitting BSSes. Fix this by advertising
> driver's MBSSID capability.
> Also once STA associates to a Non-Transmitted BSS, instruct the firmware
> to keep track the Non-Tx Profile's presence in the MBSSID beacon
> transmitted by the Transmitting BSS.
> 
> Hari Chandrakanthan (1):
>    wifi: ath12k: Fix station association with MBSSID Non-TX BSS
> 
> Rameshkumar Sundaram (1):
>    wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 57 ++++++++++++++++++---------
>   1 file changed, 38 insertions(+), 19 deletions(-)
> 
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

