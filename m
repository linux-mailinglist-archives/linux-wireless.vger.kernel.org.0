Return-Path: <linux-wireless+bounces-25617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6BFB092FE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF061893064
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4A1DF968;
	Thu, 17 Jul 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6xK2PZN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC7157A55
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772744; cv=none; b=jUcv+8AJldn43NQ5kxjwpfcOhT6dZpqfWvdyFO/taI4+/BTUr7Dv8Mxnomz1QxHvI2h3KEhB0vcd53O7N1Ca9RJbVKUmqUN7Cg412XGziMkszUtjRnQiQSZN2PV/HyGVmE9i5lTzecaq4wall94oH+l+zflZacMXD9Uax+xx5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772744; c=relaxed/simple;
	bh=bWQXjZEaWuRxRb78NXWUni58tU47j9OYrKhEc4RfIXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTjNDEBsAK0hKcnc9oc1znCikk0YtRM3Qsyg/7mGjVIONyitbAVvZXK2xGdsefW0s/HZUMVG1EsaK9vBfGNwXRnYsswhwWjTIDAdTfIKTEBhwoh42BDgBRhthfTJp0SDvdxfNUAd5rim85sSjCs+lbTYZM5oMncWI1sZh1OSQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6xK2PZN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC61s8021601
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9XlT7nxc6JQ1tKJDhgorEKTuVNVOvowVALDGJZ0r5c0=; b=E6xK2PZNUewxYH0G
	v727DbHCadIkAHyo21t6SnotdLNQyAuMWgFjq/6RS2fCG3/s33TL+NpTnH5Z8vTP
	gHbTH/aJBBTM5laNigsbnGWH5ckOqPKF+iM4yvo69+vNDjOtvrvwsNg223aiMLUv
	kvr8MtbUKTCbI5UacDQFWZa0JDNT2Qhw8Tdxx2kaP/4DsV/jhaq9oc4IR9CbOkbt
	tp1FxdYm06cYpoXdmTLszeS4yGKfFoHEX1iQVWxa6jZ8fdOgHrtD3/uWON1tUFPY
	Kw7reJk/uZYxxVlyto5TQ4mOSG84KHLuX9gzA67Ae+pj4DWIGY3/fVZAYV44GJu6
	3WQAZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpkp08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:19:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-756a4884dfcso1266738b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 10:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772741; x=1753377541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XlT7nxc6JQ1tKJDhgorEKTuVNVOvowVALDGJZ0r5c0=;
        b=Ca31KRPAOEqLoMX2aVAWL+bfi3uwAh1EBIeh6bSuXd1hRY27fK2k9WMYyMR53nZ5EF
         PULKpsF0WyeIqPF5RwOw4lVU/9mAg3aiCubL+qqxYNPFHxAPozOPOp2FZZ1n/YgHVqVs
         AtQn8DrRzLCUlt/4gjaeH2sQORluyoP1UV2+S2ZAATd71GM34/yxrB43p2Ct5dXuAt8s
         nF6fMA++ytH4qhEMpaflLoobYuCHenUIm8f1C2a3dmwBaWojYZ/sXg1InmIgoqyQjeO9
         0FFr7fp5W5ilBu+04Mrln4wLKpFlxiZPR40037dcdqnWnE2LEvqhulG7GWOPPT+JOrIA
         oKRg==
X-Gm-Message-State: AOJu0Yy9Tbtwr3y38YRIvqGisM1OR4HVveV9rRtx1LUqOvyKX7MJkxf4
	MgoVTxSZOO8uA+pam4JbpK756sfRpN6+auAbcjL6QdnvA8539CqBDM3ZGKOycI4HM/pMIwI/z+I
	MtrqsLUNJHrskQiLhWb1uUwP4DZNFdruhDY0uvDk+QPsyYdW4bhvHb+E/N5sprZMq78Mj+A==
X-Gm-Gg: ASbGncvQ0DIQTAV3jFXogl0TYpXheHsu8PO26XGpRMArSzdQs4/YIj1v4rSNxJPonA5
	sjsceHGPbeEvQB0bwnqIbkGdWDhX4fdhsBbHq1egEd/AzsaEBBGH9CqTyLvs++jHGUZOT+LGoS2
	SGcpcN2d2tNeQATsXQqSHMc9GAznXrvxSTiU5EZu56+TxsVXUmO+g4KQZqG/OmjaaYqx9L7BSmZ
	PEaFyfq3IE7GHKZoQjIbprT3JSR75hVrowNtW2W0h12gYxtwFWnLmEqO/RFG2zKeY+aWMgkrZ9l
	btJnmYqQflwQY26VqaoYe8dOLyx61m59f/BphRH/+7Dn/QfqJoBrGBcZHSkkx0v8RiMDEHOYEWn
	HXzoEJQ6+0lN8
X-Received: by 2002:a05:6a21:62c1:b0:216:1476:f5c with SMTP id adf61e73a8af0-23812b50d6cmr12243287637.25.1752772741032;
        Thu, 17 Jul 2025 10:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFifq7ZiJ4JF28/fehRceTkt0DWHZ74e8ph/w7Zsmkbk3PecjoZV3AUGicftUL61drIM2CuHQ==
X-Received: by 2002:a05:6a21:62c1:b0:216:1476:f5c with SMTP id adf61e73a8af0-23812b50d6cmr12243245637.25.1752772740567;
        Thu, 17 Jul 2025 10:19:00 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.215.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe57c03fsm16067771a12.20.2025.07.17.10.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 10:19:00 -0700 (PDT)
Message-ID: <d84a36c5-f8ce-9d4d-0dda-71997eb9a65e@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:48:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: Add support to parse max ext2
 wmi service bit
Content-Language: en-US
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250717064527.1829660-1-tamizh.raja@oss.qualcomm.com>
 <20250717064527.1829660-3-tamizh.raja@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250717064527.1829660-3-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MyBTYWx0ZWRfX2pvMz7/LIFsW
 X0wJlZBLFdBKvzRL0w/4CHNE7I2PPkkpXwkf6hlBFhMN9JmkL6YfMgrZNOMX4UNXeJ7siv79l1f
 jLVijr5VOj2T1nyajquUmikR2esRLBLM2Yxp9A28zsQ8MXeOEK7nWacFdawseaf0roszVvLHPKq
 aGJ9wS8pKXk7tXq7YB8ADp5x/PH4Pgr45uRjunwgi6K8wEpQC7QgwVtlzVovTSb8/r22I87KwnI
 2zHOE7aEZA5vFCN47bwlQLL6rrCvYmjdTRqdDIEb1ZScNlXJvnXAdJGE58aC5r8g4NRfe8SAUax
 PinbWh9eBs1wINmZTMwTqVn6IBdaLbkQEuXu60fM8Kwv9XX4r4h4lqvGnr7OmkuEfPCzhKo+fd2
 4JqMw0OB6ntY2oPX6mPNkkLU3Gg4vUg824HspNzbHMCftFTLk9+eD5wpVIn5LZ3UUjy0F6B7
X-Proofpoint-GUID: FrP5uC9a8kpGN4a7ytLxgQFco_P4blmD
X-Proofpoint-ORIG-GUID: FrP5uC9a8kpGN4a7ytLxgQFco_P4blmD
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68793086 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=yGYHVi08oRoRdJ9zovgz5A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7_BzqQrifIiNfE8oCEQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170153



On 7/17/2025 12:15 PM, Tamizh Chelvam Raja wrote:
> Update the host logic to dynamically parse WMI extended service
> bits beyond the current fixed size of 4 * 32 (i.e., 384 bits)
> after WMI_MAX_EXT_SERVICE (256).
> The current implementation misses service bits advertised beyond this
> range, leading to not enabling some of the features supported by firmware.
> 
> Implement dynamic length parsing to iterate up to the maximum
> service bit index advertised by the firmware.
> This ensures all supported features are correctly recognized and enabled.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Depends-On:
> [PATCH ath-next v5] wifi: ath12k: Fix using __le32_to_cpu() conversion while parsing wmi service bit

Anything which does not need to be part of the commit message should be added below
where diff stats is there. More over this depends on patch does not look correct
as it may try to refer a patch which is already part of this patch series :)

Vasanth

