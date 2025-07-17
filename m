Return-Path: <linux-wireless+bounces-25621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E754AB0937A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12261C48053
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B428FFD2;
	Thu, 17 Jul 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j/KqD/ng"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C30287254
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773977; cv=none; b=LYwhe9PpBhbtz2D6zXujuj9yNgSlj7QaKxGYtKz9TG1VrF+pnhVnXt8ymhvUnFSW/pc3EoRdVamo7ND3Bl7/Iy3OVYB313nhPmy3EecUG3rz42IeN/35us/tBmY31q1s+PzT/OlcZRO12XzvbWWjUamTMCqPgwObUsSE4gjlgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773977; c=relaxed/simple;
	bh=vr7iY4jEYdgul0kVxeOh8sD8Bcp3Dp8PmTQtbzP1uOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDSHgSJCkEcVnj0zIZhANQdasYkRCArn8Qiy68OCSV3iDL7/BDBY+AIA6miiMUwxyG+k4gae2Fnxsnf4lrTVMo643hHWaiv+oVobStAvCs+TPrTpOXlFXoygv2oeM3hovzyl/uJGca6+PHRUlFD0faPELds2WPk4BaBbdnQzN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j/KqD/ng; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCWOlj008487
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	55RDTNygMlCBI5mFI9RZR2EapDsighyZM84JT7RE1Cs=; b=j/KqD/ngQe1faVpR
	EC3yuWbGyXSqfKywCfYXjs5lv2KQypreIMLvM8liFfWSpj9R31fHt0hklky+tQlL
	kYABv0D9xvswH2hvtDepL6UTW67oo/udGnEXSUrlwVslBlSJ0I02fzuVpYYb1S6i
	h2OCOMx/ctD5SijtbsE2dhkxJyg+Bjj9RVFTZBFAyKzzmp9f1mljusTd9nbl9oEu
	QN9HW6gCCssDXoiB4AtYKT+Iq4uLJFkq9nRbltJ6d3CoQ9GWRF2y9Am0iPumLqP1
	hOjwC7An73wuYAHU1c3cez1+ydNT8D5xmeWlISFLhUilmifByHNaStAertjAlshW
	59hJQw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb8pma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:39:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2354ba59eb6so16338605ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 10:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773973; x=1753378773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55RDTNygMlCBI5mFI9RZR2EapDsighyZM84JT7RE1Cs=;
        b=f2TP/sm4aXO/Mj6z8oGPdZb5dg2NpODxduYhQ/urJnBjqxD22tl2seOMCkhV6e46jU
         rfyG1UeLrH+SBBNypPIZJ5pzaq7L4b7mVNpTZNCzZToVXxc0gB4nRtEq65Gfqg6j4F9U
         omm8h5ruQqcnRZgAqJXBzkSENQzzLgaRT6XDnEnJC4prAUrRWWCUKTo4Ti8glrbtgXTf
         NghWfFRqfZEecDLuOh1QgHC7qfjNHi95RQKsom668VExNJ0DpprFMcysQf/CmD9b/X3u
         bS40tmSkRiSGE00VE9/d01JT+ZF51OG6XfDFA0e2ycd56zZryUm/61k253Gh2AQrebCb
         FyqQ==
X-Gm-Message-State: AOJu0YxahXtrA9cpvJx7umXlbqPGXev1hxEk6ob9FAEvgVviFVrJOvMY
	Rm+MB1H9KtksnvzUW9bQWWZS3ylPiiJtN0xfUD4ZOwRrwYL0X00yZBd5k6PV7Mb3s2w5LPn9lco
	64DOO1siQTj9cdz/PiVpTIAdVy5U791jgkp+ln06JewK3m7mgRlK9KzoOy+iN8deYD9UsMMQ6ka
	XqRw==
X-Gm-Gg: ASbGncvDmVAx7t4NlusWaQtKPJZ0u/yuhV6OCS82/JPsCR4hKMcZgeooGRRyvF39h8x
	6pMtHUqqHxYIi7NPydclqFYHpMRTSEMaCzsAOzH+oo2tB02taS1TtljmI0U9x7OTQR5EDlPi3+4
	NAlz/mUT1JrOe5MnfVMtotavQSgzwMGqI9D+OC3GUH4bQP7BAMdmn1JutZDSyPpK7bcQ6facM9f
	UTtq93LYqC+/pXuMc1tMjo3U3hHg2ATK7VZVCTkjJu1NK6ci6HNod4Uh9wWSAnPCCLqKcebdxeZ
	0F1FxaxM3zF/SJ6x5T1mKetxoJtjw2WJ9jUVt91ECS3fvtKSAXeEDDZeRqOqDrJmN46Rashi4Sl
	rNZiReNFMmaYl
X-Received: by 2002:a17:903:1aeb:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23e2572af07mr106171285ad.30.1752773973573;
        Thu, 17 Jul 2025 10:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeuY6VI9uuLprQ+Nr5x3foPCimOeA4RpDHNRcdV0qThrTuIhejOKoACDRfjbPzR+hCdl21ug==
X-Received: by 2002:a17:903:1aeb:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23e2572af07mr106170905ad.30.1752773973072;
        Thu, 17 Jul 2025 10:39:33 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.215.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322cd2sm143006055ad.99.2025.07.17.10.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 10:39:32 -0700 (PDT)
Message-ID: <d191062a-f9af-7f00-35fb-677504ec4cc2@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 23:09:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: Extend support to parse wmi
 service bit
Content-Language: en-US
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SiboJ-C7-uYTiUPCTbzQaMvnx13c-UAM
X-Proofpoint-ORIG-GUID: SiboJ-C7-uYTiUPCTbzQaMvnx13c-UAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1NSBTYWx0ZWRfX3Xs1Hd+wKBAq
 Tzt0TnSN6CyOSpyKTSXWnUW5NI0NvDfrBaHlG27Rh7drpPFcwnTBfYmQZzIM2exPk4wMRlV8iTc
 cBQ7Rjw+QowRzRehcnqUsVnVS30xetlZLpD/oPv9Arh19CwuX2MJOyA3P7yOdL8z+G5pUfbCAyk
 ECH9mxcuhPVPpYeZ9J0ufYAtjjsD9JBeTSNsAeUsgJAIBpBKnuHptP0YxKVTNBlnJUzimxj2Mct
 mY3ODYHKCwvWJSec0tNTimjzg2IjUVqieGySWYZb7RJEJU35Tb1TxCOunsPzvtUFrQDwqYDz+Gq
 qjEN+j6m/0xSraYTpC3vXTZr5wjMJ5mTtWl/LClMD6O6iHbCdSS1Q9KtfVUOLsF4ZDoIKdJHyMW
 s4pC++U+hljzFhw4uyJiPmxJhUrIgocEDp+y5YDktYgdyti9tBMVxcRBYzFNkrdwFXV1KkTz
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68793557 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=yGYHVi08oRoRdJ9zovgz5A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dHrHj1FnWLW9-lTSwmEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170155



On 7/17/2025 11:05 PM, Tamizh Chelvam Raja wrote:
> Extend support to parse wmi service bit till the last value firmware
> is advertising and use endian conversion while accessing the
> wmi_ext2_service_bitmap value in ath12k_wmi_tlv_services_parser().
> 
> Tamizh Chelvam Raja (2):
>    wifi: ath12k: fix endianness handling while accessing wmi service bit
>    wifi: ath12k: Add support to parse max ext2 wmi service bit
> 
>   v2:
>     * Modified commit log as per review comments.
> 
>   drivers/net/wireless/ath/ath12k/wmi.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

