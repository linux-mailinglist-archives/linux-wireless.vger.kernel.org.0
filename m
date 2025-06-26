Return-Path: <linux-wireless+bounces-24562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E1AEA398
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16283B99D6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCD21507F;
	Thu, 26 Jun 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxtsjcMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B320F087
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955902; cv=none; b=ArNWIrjCVy3i/eryJb0/1qlbGf101zYhFLzIDQO8eo8Efdg9RZb0n/ZKg9zLMfSvI5I090gRyGcX8ZvR6n6waFtDX4JucYUTZ+oRdmbHObfEg6ENyayEQhLugPsnwTVG1VRFb4YQP8uqCxVan00EsMABhs7yMOrWK/YwXD3TM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955902; c=relaxed/simple;
	bh=otmGiPyRcsaRheCI210PDw5jFdN/YH8ewWhEyPAqHN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioxn075MevEq3opAUVf68LOzwxf0k0pwZSQGZerItuqcL1VVBLS353HCVd1w1CRynFvWCzjMdGDAeWBCUMfA11UcSS2X2HB0EdZ9exAbrzdWpX1Be0AZ6077zutp/LAyJmPF1/rTwqPBuJWgg8jX8OT5eIpSlus2ZPYdGkn2t/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CxtsjcMA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9cv1o026634
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ds5OIBbeNrEMt6KG9DFB3gNzCj+lz0ilvqEPiQA344=; b=CxtsjcMAZ006oS80
	533AEL//NhGDYWiQFz+DwVSvXZ2NRcM4DbBX5KhjKD8atNKwTTw/88uDrqkrDQFq
	CSRyzMfeiYRKQfJzhEGgqxPR3XJDACPMaXdCN/dAQ2Ofj4WWwJCD8P49lM2vyaNp
	wH87FM3YdqpNDe+dn4ZlVIqLygRGdcRT57qzEC8OKaj1wBtuyYrsLLm2KEIPFjMQ
	h8yOP72lw3VXNpDGYMhKhje0essOJkkLSqw/WP5D/rfM6fGARwnhJuyE/4wsAuAJ
	DXIqfMHytujXUYPNbEmFOSdt8zKS6VGnUwBr49i3LelR7qQCkcLek7gz7zqSjSQR
	ISeGFQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5w6jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:38:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-236725af87fso15641415ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955898; x=1751560698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ds5OIBbeNrEMt6KG9DFB3gNzCj+lz0ilvqEPiQA344=;
        b=xHLVE37rHBi++nC1cUCUKAa5KFRhGVamHixeZ4rtcKD8TiycmPA0trx5ja1dBrnXmJ
         Jjuo/WlFab2Qdt1w3VipKDbYisqWWhhPcQWIYTwLE2dGAE3GYmB8V+crWrT1mU6nb/6o
         9GVelNVJ6BYOdrBLgj2ct3eMRQ5PsFQGbzsIkfBQ8AvLGu+4iUL8eADVCMo9nbcfZRgX
         wV0PMO2SbL3XtFIwW5djrv+02p9avnvBpGeOtCtO4VRo66GMKCFlIAprihRI/xD0zh9v
         5Ikv3mDsUUp7YBsll4LopiEL0K6WHhlTUXidjLbl/m7rbxwEzkGpY9tJxHU5UDn2Uuys
         A1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV7gzVaJaZ5rc9cItflPC3z4wZN1hH73qli3MYrkXrLmLcE8ifUZrhnNDsRzhFGBSGN3jpSx/IERNXiZ1oybw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzykQV2e7ffRvySMeE4mEM9k7ydtq9IQWrD94ShUr4id8Yeg0I6
	XAn38fDMi3VzLw548Rzeq6WCY4rjNFm9pJAwjN/7SN6H9o1Ygwu0oG8IgH4im5NyiqhjmlXyxtr
	NS1/4xfZyevLHYU674uk7c3V9CTBs99kGd4b4a5QKSWNr4VG8IIbNdndUORCdVCAcokByzIkkHI
	jH9w==
X-Gm-Gg: ASbGncuqWivDP7Sb30ps6CB5zp95fsyvvOU4ZBcaqWZjc47+GmZxXZRnj/i8ugOxNl8
	EyWRwUXrhHWD6ehfpPsIz+rV/0nCqzh2jTOgvaznd+1qwMIAV4PbBrWlBTi8b8O8jeGHv/fykn4
	CP+vWxSAmz8RxCRaWLaBZcTBJe4dmXyTDd5rqLTOwRIuaZ9b215AONHCxTkJzeGT8eZM0ocAy1r
	/cXxfFAmyKMMBIqSy//qFwLC3Ei5dQv225Ip4ZfvLGWe62vQFd/Sd5oYC/Rpv2kpQ6XrLOzQy4M
	J9n8GBfKTwkEw1DTB5tYvJ1BmtbW1AXwryW4Jv/vQzAf/M/+NxEfYotzSFx75fUuo6eOVQU=
X-Received: by 2002:a17:903:2985:b0:224:24d3:6103 with SMTP id d9443c01a7336-23abe462f3bmr5850475ad.35.1750955897887;
        Thu, 26 Jun 2025 09:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHTg5bU2RCynjfPOJov4HiYgc9/oR7gcvFmbmqvfPAlowElQPIS12aIx/PZTAcUpaQOcITUA==
X-Received: by 2002:a17:903:2985:b0:224:24d3:6103 with SMTP id d9443c01a7336-23abe462f3bmr5850115ad.35.1750955897475;
        Thu, 26 Jun 2025 09:38:17 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.255.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3daf4csm2003995ad.112.2025.06.26.09.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 09:38:17 -0700 (PDT)
Message-ID: <8625ddf5-d362-cffa-efd0-0ada8e547700@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 22:08:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][next] wifi: ath11k: Make read-only const array svc_id
 static const
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250619082010.1834109-1-colin.i.king@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250619082010.1834109-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ummNiC47GgXwib6QUYxqxYoM1Hf-oQGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0MSBTYWx0ZWRfX13yINpu3up0Q
 mLdnuhvlJXr05Rn018Vpg7emVFlarUcl48R4kTRHdEN3LFUxY/yeBSOsCDdmN/xVqJuzsifFb8o
 JX3xlLliBEeV1YP/tqEYJd+05zfnsZJeoXgU6DhbB2GwEGMUdZoBnmuyAV0nfyFA1QyHSigK3/X
 6QkW2Xs+XI0HS4sRGBSvGWXLICBHmr0oHdBKg+5jws/WbYbQxPsTXh9lf4wDKCOhuI7O6ipn8Z3
 OFKq7iQmymeG6ipr8yN8uyVvhrTDjPw6WW+dQUO9rlFGSjxnQCzarwyZZ0IXHEXdYTBug43NVZ9
 87mKt3ZLlc2CEV3lSHYBeMcMrVCW9UG0297jE2nAZTc9gW3dFidjrdDksg1grXw9Di7COE9Zqdx
 +IBGqPaSbn+Hj9lSh2vbJ+rWDdE9FYhaKtHRKbi+HYRlSeEUdmlGDRV+oG84S5BMrxSFn6zr
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685d777b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=/xG1ZwzdjF5UbGEDupzz2A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=8b412UgErZc1wa3ZSjAA:9 a=QEXdDO2ut3YA:10 a=LXDWoPVop_EA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ummNiC47GgXwib6QUYxqxYoM1Hf-oQGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=764 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260141



On 6/19/2025 1:50 PM, Colin Ian King wrote:
> Don't populate the read-only array svc_id on the stack at run time,
> instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

