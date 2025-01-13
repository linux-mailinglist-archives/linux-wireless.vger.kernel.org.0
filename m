Return-Path: <linux-wireless+bounces-17436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58567A0C0F9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A81699A1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115E1C5F0B;
	Mon, 13 Jan 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btsOp8PL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24981C3C15
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795208; cv=none; b=V/6RreER7M34gG83tdF+5btPoXBHIycHJskVc2b4BSLjEBBBf0IKx0/X2i1m/DSQWF1QcMI8T/xIteHpto9o1pUu2IL0KwRjxEvgtw1KxWcdsQNF5gagMK3AsdAYgBpLrBnGvflcmyil1M0NK2Q1Thre6bXGw8qC9ySX6TQ9ZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795208; c=relaxed/simple;
	bh=k8nNhxVKwh6Sm1JgUJTjfPEABUfiZy2tPdy/cHR7sEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISJmGdxODglOuGsEMY3i/yBJ4oITMhjPnUpTK4fvVkT0D/WSP2k+P+93NVZsm8sp/2oGN/TzahETDK62zuwTIuUMWG1aB8F+WLSE/AMKKGwjVE0XuUjUJ3rmmRLCYszxpbhXi2Gie5rCV2IUMg1H0er2LPUxmJTm4HZ0s5C0fTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btsOp8PL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCsbBR001497
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hjtjoV6Lsl1jRuoL+2xlFjDLFwJ3AA5fShbdt/8gqqM=; b=btsOp8PLn+HJ5utU
	8kC2fFb7gToQXZZBgeJlrqbBBPARrGPCmNnj3wU1X1DVcwtpNv1aMR1Lc5GqSKt5
	Psf9+QJfgpyGqqGaTPYAvecO9uUd8mJbvz+tZ/hY3Tu0QZe1PhgTbLxkEJkswsDq
	F18qSR8hE36bHH/jS6hXWxwZoFwMW868sdCuyG24F4ez6AmJodyeMQkAWn19Ev9x
	metZKnFMtCza6fDJC+oGxBsX+PLGOBZlLQw8sxSY9DjOaYZbG+wkD4m4fHG5P7MX
	IR1QS7zmkjl4iM3TxGY0dNpp2yHHp5O2Hn750W3FQabRdekdo4I7TqZ8HWgdWKHh
	biNSaA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44538jgw64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:06:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21655569152so88285445ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736795205; x=1737400005;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjtjoV6Lsl1jRuoL+2xlFjDLFwJ3AA5fShbdt/8gqqM=;
        b=D44lTRNQsVNOJfamlwrVSasQR1GEe8rs85fiHgDGqwvGjTcODOEmuF4GHR+GUrO7Hn
         WC23PPED3Yls3kEmrQ1oIPalD425XL1OOs9U+boA++MpcwFMxhYRP6W4wDt3AXBK7OQd
         TP2Ijy2VE2RJEBhsZWCveiIKBje8tLV3CM4B7bEPQ9vNexlt+GpsadKFrhD4GLHcDEKx
         Wbfa0Xh1wRjVEILtJ+v2XIB/yramq/pLK6WD8LJACf6WvQ+PoUek0/0Xg/MZvlVg55d2
         D7NK2i7Ppn8rNd8Sv6syqoZy7BLogggEGP70CuCyhd9+KdG96min5DCCRtQ0VtNCUOXw
         fkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHP/6bCv/JCQU7Nz6t/1imj55JND35GZct12mRH3vzImh1NIhr7Hk9KkoL1E5VJZIG0QFTzZG59O0PmM27WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgQ1idcEAhAs+0wAnfjS7+2dOnSR+c3mQaNHKKd6CTTQbdvfR
	QdTXAeFglqCIBA63Vt3lCe73OSDrDi2ddcFBSwB3f9bgQABxyiT6MRUR6564+Gbz3xFa+zHMWsJ
	L0oltjo6QvIFDYGuRziFNWkrEYl8HAaFmaPfkj536Yu5sX71NrwlSYDJG2pevc9u0WeNWZK/FCg
	==
X-Gm-Gg: ASbGnctwqUFLomGHUR/yLxm9VzyLBxOuPg78BmhOu4abVto2f7laGk+Tp/2kG6umj4c
	BNfyaj8cYHle4STaTNP7WnsbHCVSWe0wkCk4wKNZLNHAcQ7FoMx3vKnScu2UdIKXgHjMB5zNfkm
	PMkat+w+030Xf6eBvt6fO777px/KlcMtKzrcMkA7vPL3a6YSrdc6KT+JB98HF8rZKqN4SHOXo3d
	ntCvefcCv4TumeJPbcgVBpvw2wZzpT7mzK8n2DpyrWzSlUOlrDr1VfKrDPsb2zpf2oEGXAKa96m
	Rf0nIR6uyK1FbKRzZ2nZD8OTy4EW4jx2Pqshk7fzuP0gsRLHNA==
X-Received: by 2002:a17:902:ea09:b0:216:527b:5413 with SMTP id d9443c01a7336-21a83f67c04mr303130145ad.26.1736795204726;
        Mon, 13 Jan 2025 11:06:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRzxt5EbNETUNX8vMwf0g5LncayJf1TtA2U9zJ0Vc2Uat9XiRr5a3ApkJc+NNOzPe4VDCWlg==
X-Received: by 2002:a17:902:ea09:b0:216:527b:5413 with SMTP id d9443c01a7336-21a83f67c04mr303129785ad.26.1736795204333;
        Mon, 13 Jan 2025 11:06:44 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f26aab9sm56480925ad.256.2025.01.13.11.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:06:44 -0800 (PST)
Message-ID: <f1afb9f3-8f7f-4da6-989f-6183cd692bc9@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:06:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] wifi: ath12k: add reference counting for core
 attachment to hardware group
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-2-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-2-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9jZYb36nu55-IYfDGquhe3J6rY0PCQxt
X-Proofpoint-GUID: 9jZYb36nu55-IYfDGquhe3J6rY0PCQxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130153

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> Currently, driver does not manage reference counting for attaching and
> detaching cores to/from hardware groups. This can lead to issues when
> multiple cores are involved. Or with same core, attach/detach is called
> multiple times back to back.
> 
> Fix this issue by using reference counting.
> 
> With that, it is now ensured that the core is properly attached or detached
> from the hardware group and even back to back calls will not alter the
> count.
> 
> Additionally, add some debug logs during the attachment and detachment
> events for better debugging and tracking.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



