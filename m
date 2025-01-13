Return-Path: <linux-wireless+bounces-17438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0328A0C114
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B46188548B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80241C3C15;
	Mon, 13 Jan 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QK3vikbD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6111C5D5D
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795583; cv=none; b=J5OSN93P1w3r2P123Dgg+HKpnQCvhjy7sFWrvpK81jKeqqER6UHUVgztnsloT43BA324AUGxk3Wb+p8sfndurOMdy+idJQcZKVQJefEU/MvDe6qd8a1pc4rvxdmfo63xp2LroHEGULtozxPU+KJaQj3UmaCg0sL/WaUThFG+Oiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795583; c=relaxed/simple;
	bh=G6UBJKi7Ta8Xy0fmuMU78RynvkiiC3RrQkdvjz4ciUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjLZWI+A5Q4ULT7apD2qwZfgfPUk6p+WE4btUffrWJxvKsjjoodgojTqrzPD80KWmZWy5WrCWINNthrr8MH1+dG+fz36lMEeOfRqn9lAUhV3l9Bnpr8cLyxdgl/RvrAcY2+/yfGxnCSg8qXM0dPMcf/zdyy+a9Qdn3H12dlruO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QK3vikbD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6NsX031364
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ojTs5gJGcCPM/zOZy1/aQkWrBjI1IfejHR/He+7LfTI=; b=QK3vikbDAqNwOPBM
	SFtSNUlh9fz0EIdxtoYJE6P2slbW01h0nPSMjq6GUzFEDzb8H/pDxFRQz9mdVmPB
	XxG3uNlhMUUqvhH9rCjbFyJFaDZIdSKKSI6ZVAquEG8a0uhmV9kc31456s1AigZ8
	y4eZnWlTqCQK2hEckGlI4/u9HQ6LgM8zJDmY3X+7vOt4l/D87Rnf/rRMJ5PatTdP
	sOSVL8flzfSERkG+AE4l2xLGcFzBavIRsqUkjF8o12XM7vutDLAHJK/r/m0nXWG8
	JKr426mRqCwlkEF20JarYyyM5jMX9lrbhuXfc4LxJTOYbT+oK5jrDWpNdjjk0Rf8
	ZlJ4jA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44549w8rdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:13:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so8312437a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736795580; x=1737400380;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojTs5gJGcCPM/zOZy1/aQkWrBjI1IfejHR/He+7LfTI=;
        b=Mq8Y2CDoyhKs/GAnk/bxzB6Njat3a03xeUi+I6XBJN3LkcOX68BHnSTsIWPdQPXY6D
         qeIAPvkK2zk3EwA2uMefIyNP55/jXmhY7phjeXcLLxeG6QXGP1MjNw+0RfKzztgaV4da
         AKHhf0CP6CO9m3JO/2Hp6VkO2to5BI4Akr5cE0nQDStb4wwPSz+1lKgIYudrvH0b4oFD
         8G4yE/f2p6ZkH8KjjubxR+raIrypISB/nuk1Z4L1ZxruaopFw/vB8Q1UgJsvMGXKUZ+I
         I58S9Hlgvn6JzVWig4uMHAtjlQtuO066IqVonEb62WAFn4l82QZTu2HJtp3NyBcYzy2l
         FQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlZEP/hJ0FIIIF0qFaKbMrc9wSMNEUrsXfuKrxl9SvJB9sc3iBEOQf67GMEyZ1h80B3bWFvm9/XPNHmJs7AA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeh/ApHh5DsN5Vv5J/4zv48QfbueKuzUvbBfb+BIrDbApinBuf
	zQl1fd6LUYaOKhdb+J6fPDMIDSn+b31jyaDfG+TGjyrE1/2Yhq9bVdTdBvWXgjSjss0U/7qj1TI
	52pV28ym9WsYHvYaSxHp6FQmRyeXcqwDZEIL5lAemCABOGZqOAPMOpDXiuxECwy9dJQ==
X-Gm-Gg: ASbGncux71Bekb6QkDvromG51IvnMt4lUPaBizj/Setc6IZkI3fj/0YsopEEja6+czQ
	nUnR/IHM7wM2OkcuDOTOy7FYW8JQwoUpx422e7C+MOUWuf3F609NHHo/OH+VYBpNDPDL2dTrvwO
	evx/ephLZYDAQT7CoFCc6KBdL2QX5n3NIV+cVPTZLrkG7Q2/qSSWjyTBpjrLQSljoXgNuMlXWo5
	OwwHCP/c5E3t8ee22agoOKeZ5I3EmnYz6UvxOCZuSgdADt1zbhP+Oyq0BqB0ZP0C+SgVRPzFUXo
	BqwL3ihm3ntHkswdIJrBqBknOh9RzyaFNTT0RDUPWvqW7Xf0VA==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:d380:fe66 with SMTP id adf61e73a8af0-1e88ce26ed3mr33573201637.0.1736795579575;
        Mon, 13 Jan 2025 11:12:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlqFZdhLJxpDnvcFS0QjJICPibuPNW3II6dpekmZMtvmZ5zP50C9Zm2YSwL2TkOMTSo+QZyA==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:d380:fe66 with SMTP id adf61e73a8af0-1e88ce26ed3mr33573161637.0.1736795579194;
        Mon, 13 Jan 2025 11:12:59 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40568dd7sm6208324b3a.40.2025.01.13.11.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:12:58 -0800 (PST)
Message-ID: <5925d874-1b8c-413a-a6ad-16d7ab299f4e@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:12:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] wifi: ath12k: fix firmware assert during reboot
 with hardware grouping
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-4-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-4-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: byTcbBkFDzEuyUBIL1sq5h_M7QPzts-K
X-Proofpoint-GUID: byTcbBkFDzEuyUBIL1sq5h_M7QPzts-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130154

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> At present, during PCI shutdown, the power down is only executed for a
> single device. However, when operating in a group, all devices need to be
> powered down simultaneously. Failure to do so will result in a firmware
> assertion.
> 
> Hence, introduce a new ath12k_pci_hw_group_power_down() and call it during
> power down. This will ensure that all partner devices are properly powered
> down.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 837be309cd45a2d037ee8c3bba8f7be0f457d6b2..7f6521a56ffc0f1e9687c94d6829a9c1f1887661 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1751,13 +1751,34 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>  	ath12k_core_free(ab);
>  }
>  
> +static void ath12k_pci_hw_group_power_down(struct ath12k_hw_group *ag)

don't you end up calling this for every device in the group?
what prevents ath12k_pci_power_down(ab, false) from being called multiple
times for the same ab?

> +{
> +	struct ath12k_base *ab;
> +	int i;
> +
> +	if (!ag)
> +		return;
> +
> +	mutex_lock(&ag->mutex);
> +
> +	for (i = 0; i < ag->num_devices; i++) {
> +		ab = ag->ab[i];
> +		if (!ab)
> +			continue;
> +
> +		ath12k_pci_power_down(ab, false);
> +	}
> +
> +	mutex_unlock(&ag->mutex);
> +}
> +
>  static void ath12k_pci_shutdown(struct pci_dev *pdev)
>  {
>  	struct ath12k_base *ab = pci_get_drvdata(pdev);
>  	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
>  
>  	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
> -	ath12k_pci_power_down(ab, false);
> +	ath12k_pci_hw_group_power_down(ab->ag);
>  }
>  
>  static __maybe_unused int ath12k_pci_pm_suspend(struct device *dev)
> 


