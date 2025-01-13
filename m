Return-Path: <linux-wireless+bounces-17437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD4A0C0FF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3A93A2F13
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA31C3F39;
	Mon, 13 Jan 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzY8EGoq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863051C4A0E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795245; cv=none; b=Ljwrt3wPZTkxwUR8JeeeD/rwLjkQK0Y99uqYK+cZcfHSXx+yF25Wehi50w5UdSt0O7XA70M/JgNrYwGww8/hEDEDWQ/5UfoBiXg4n6VBSEgt2TsJ+ldXcbZuMK3dQDtE9cWagtaejCBgiraemsrDAFtwe298+P2uMzpbQset2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795245; c=relaxed/simple;
	bh=+GGhgLaHIvklskkSOjsJ8gmNlajD7IZNeJ8ZnoQDmqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdn2CNTEVy/lZ+WlXuoGUvWNaK7hFZHwNWixMckkLJdUYmbvmra0nxw1Nsy8vxDZ/N5E7HQIVmMosQnGjb7Tpc7plzK6lsjHstNY3AlQgS7IqXP5LZXZ2HDUM/dL+K1DkLrdOTUpgIXCs0yU3y/r3CT4LuZgHHLFpa02z3mVHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzY8EGoq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIimqX007912
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VVt31jIMf2fqwBNkDuTpsZPmudwtSAvMPRIDpAYFFsY=; b=dzY8EGoq/XOKEJn/
	cFS6tMLzC0I9RUqOG3crsyJQIn3W3MHSEQkGhnoct6yp2KP+6eSpFrZlVmXgXiVX
	UoGymJhQUBskIANMWABR8fTJffm6heDraUuKovvzwtDsgqPIBmqJ1a2CgVAabbF/
	hgcU8qTW/nbFbj85yJ9C1oGBm7AxohfDTGK0voB4mHCzFAidWALKu2h6oES+XFnN
	FnXtoGpl18EXU/BzZ0yu9Y98zZrBaJxtEfyS/poL1yZPI0I2p2iDpSv+x2Ne5ZW0
	2U+dELd7020RDMQIwBdWJfIzm1onaKAPqeK4drgJDO2AmmA2dMbz/+fqhZ9PuGVn
	nHhRMw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4458cn0200-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:07:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso8169755a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736795241; x=1737400041;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVt31jIMf2fqwBNkDuTpsZPmudwtSAvMPRIDpAYFFsY=;
        b=waH9jbkTx6GUiDTnfyCzwuyCEDkZHh6pTuR/NWfAsUxUakzpqYLcYQ2vVFAtgS7aow
         MWDPzMWQvoVydxb/BQRAjP5Ev55OumOwvHb+xGs3ncSFXqiCVVE8+uG0sOpaRbtGUhdT
         biincZ9z71Eky9uUNjROqEuH66l3RKZdJUAUUL4UEJRgjc8IX83w786Sp9HcYnw04qeh
         Um4zVuggPhCNxNo2zR8XPfxa8vyX1GZWDi2/q0SUTy8uXWyHGAucSuYJeKuXY/JisPcG
         hISBmJBIQoTbMQ8NBWabTi4GYhMCXNE3fJyCDJ4LDimpzII3XYXE53OwuG7S4JNWHzFk
         748g==
X-Forwarded-Encrypted: i=1; AJvYcCUjN7DzWKPqHC7P3YsGUSPpRKTvv8QdCIHYJuiJX/4bf0hgxYIb7jROdEE8FE5ZS63mGDJKJghd3r7ZjxP8Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQwaTml4A0JDOu1ZnhT4W7tUGLTFXDT2lE6B8J4JBTv95yBrw
	ua0gZZKQjhA3i/STXLRgDHZKfYZ3Qg2SZ8Tn1L2fskWWOd+pwDXHDG4myp2dglke99uGWRlJ36R
	RazB2ADXPSeinmINyqfmpSWR7vY+DoSKtmWRXzlS+rggwvnbjH0PrFe9HGazqW9sUYA==
X-Gm-Gg: ASbGncuqo8w7oUYBsQ7qmQf3CVi8WfTafjxC1wrbOix9Kv8CUwba7T4w7QcIFsLQ2qv
	QQ1z9Nh368WaoWpKG2FgI0jJ5r9swv0+vQfiAwAIzkTg2mz4EK+bbcmfW6tA1KwZ7IxJLXAmNYT
	ld1wPz9pgQIZAQND7kfdzl0VfVhYrKcE2/9vr98Cl6OFYsCuDpnaHu4Hzrd59yu6zYSd+WiO2Jk
	r1Dyn70AHn0jPyOIMWoxhljUo9VFX5SYQTXL5pJZ/4nPipoYWFETt06oFGffBs/bYdl1i8cUDIQ
	ONVMrd7ImAh4vj0MrVCtTwKIYjo904SDMwUnzxB9hvI5VYuKgA==
X-Received: by 2002:a17:90b:1f81:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2f548f1a2admr26473645a91.23.1736795240949;
        Mon, 13 Jan 2025 11:07:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfDc/dUlPxqlC/mjZG9JvH84VnYG2P0s0u7Kj0m1pfhKfFGVcrrg4MS9vEMoqII6lPuemp1A==
X-Received: by 2002:a17:90b:1f81:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2f548f1a2admr26473614a91.23.1736795240537;
        Mon, 13 Jan 2025 11:07:20 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55946d676sm8185904a91.49.2025.01.13.11.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:07:20 -0800 (PST)
Message-ID: <83086043-d1e2-4a28-9cdc-2a1faf75f011@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:07:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] wifi: ath12k: fix failed to set mhi state error
 during reboot with hardware grouping
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-3-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-3-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5zDPYxXzhNo54AqU0dzUvhPRu3EDs3eo
X-Proofpoint-GUID: 5zDPYxXzhNo54AqU0dzUvhPRu3EDs3eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=915 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130153

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> With hardware grouping, during reboot, whenever a device is removed, it
> powers down itself and all its partner devices in the same group. Now this
> is done by all devices and hence there is multiple power down for devices
> and hence the following error messages can be seen:
> 
> ath12k_pci 0002:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
> ath12k_pci 0002:01:00.0: failed to set mhi state: POWER_OFF(3)
> ath12k_pci 0002:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
> ath12k_pci 0002:01:00.0: failed to set mhi state: DEINIT(1)
> ath12k_pci 0003:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
> ath12k_pci 0003:01:00.0: failed to set mhi state: POWER_OFF(3)
> ath12k_pci 0003:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
> ath12k_pci 0003:01:00.0: failed to set mhi state: DEINIT(1)
> ath12k_pci 0004:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
> ath12k_pci 0004:01:00.0: failed to set mhi state: POWER_OFF(3)
> 
> To prevent this, check if the ATH12K_PCI_FLAG_INIT_DONE flag is already
> set before powering down. If it is set, it indicates that another partner
> device has already performed the power down, and this device can skip this
> step.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



