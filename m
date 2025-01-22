Return-Path: <linux-wireless+bounces-17838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E873A1967B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 17:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA1F188D3CD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B14616EBE8;
	Wed, 22 Jan 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RG070ziD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAF149E17
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563443; cv=none; b=E+WJtq0KsygHnt5sCJG47QyYQ3XTidgik/2cC+IXo9rkuYZSFt36ECXUi1wT4lb7cnncTSK935eZ7DkE0sMWa2IbTTm1wLOlLBh38W1nyPBvgEZuqYtXT18lmvKI+TXnu/2ovX4u4u40l/V5n4B0oIj82wBRGIfLwuCYyLwJ2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563443; c=relaxed/simple;
	bh=F/TuF0G2TCP1J6w3ZyFyxRPKRPEGrX9u8Vlk+ZP9l14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU4UL2SV2iBs4R2FeqEw/5vpyil5+XN51L1iUrDMnAbG4GwhgfdRSmFuiU9M2Hgaa2pySF1KTu1NkTxdpfdob+NqwhBcVI7IrfriuF542uAzmvVcYln81mOiv3BD8RM6LYcVzc0pFtGgRw/Miz3wXAAbjugxkTMpH1TJR+ydpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RG070ziD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MB2eFL013660
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vGbqRWVfjeWOlmkECg3ADo7b9Ai3dFw3hjCLzyfU23s=; b=RG070ziDAE1gjeXT
	9FlTcjxOxkTxLqGd3LboEN3ByqeEwOL5Ue6C9mshkWnUPuFakNHgTs8Mac+Co5n2
	GtRnePj7YYjy23MIltelg0NuLXrDyx+/nc5pcxyjNKt01JimXO3GzgaIQuWQ4Tta
	deFH2ZUyDZy51jMWEAeJc6r97FlnoRd7+BlhoapyNxH8B5Pdi56ke+rMuJZ+opG9
	EhTUUxS3NBbe9ie/Gz+Bhfm0VKD/Jj9wVKomV9Y/NRWBGrjXOueSJj4CSIGhg0FX
	iykq+AtIX4nR1Q2t8xoa0kAkVqHx3ng8NywvDPjfnAI+GWH65rT4WI5VwPgZISDI
	vu0XSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ayf28s2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:30:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21681a2c0d5so129007225ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 08:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737563440; x=1738168240;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGbqRWVfjeWOlmkECg3ADo7b9Ai3dFw3hjCLzyfU23s=;
        b=gqHVX5dM0s8aoSFq9JdjFJ6I3sK0UP+4AHHwP++eLSpqK9KLJvWQ439BirmOxrsVfm
         rdBs7gPCr/oPjKinQT3wkdkd4jN45qMSON9B7t1Ba8Piszz1OHGWU5QtU1wEor4ws1mL
         FdqExWZbRgb1HAVScJ84zl98RyD644Ty21Gg6ssapA9Fc0O0ls69xO8W1wUEei+SR1OF
         fAsGj3NUZhdsM/h4z3fCX+LkUI0Gz7LBY3XtoJnauCxLv/xhtBFYSC4ma+dh5YGZ20C4
         RWkYMznkVK5uD3Mv0EYwzVI7Hz3g+rKkh+cuD/1kRo6/EtLFBtYzaOkw8rIXrHPclsiq
         ZC7g==
X-Forwarded-Encrypted: i=1; AJvYcCVkEi6JVBYmwMJHuLL+f+d5c83i9vcrVhHRXUtpIqmdL42EgRLSvEtHLXDpIaR0u6lNgWvXoMMFxj09tsURjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KqN+80euml0X1QZzEEahhqz11xE1kBFWLTZsjb9DGimvDCgC
	jg27a0vBUaJcPyIAE9OhQccn2h1jjOhuvIJiXYJUzVwMs/yEWimf6goegLDvVI522BeP5LDEqpv
	rAvouWvHKZB2kmphiP7Kcz2p+7imjkfCaHrhXjTDEWlGMfiOo4DyXT1l8lkB3q7kTYQ==
X-Gm-Gg: ASbGnctFoiEQgwGxxaR5CjHaVDvw7+Wflm5kQR7K8zmoHqSJ2pNSJIeT43Np4u44ylQ
	nWgM4oTlkTVTBLAPnoY3x5xn619HnDKWQn7k99golwoiSu5VqOVO0LHytXuYkOZ8gdeREvT4NX0
	Dy1AoDgH7rUJQ+0jfF2FyejgTmX/UQuIKj8Lr/qveMfW2BbBxkIIJVIPFVM8fLPD0BknWb36x/s
	4Uqk4j1m0pMkP0FrVMvd8TijXqnNeEUaVY6WCHGFZ48eUbK3kBgRHesNghcDjaJtMrdELnD/0+r
	ZdrTPOiKUFt7ROOhRlcxdFpX3vnsKg==
X-Received: by 2002:a17:902:e80a:b0:216:6769:9ed7 with SMTP id d9443c01a7336-21c355c7dc2mr368167335ad.40.1737563439719;
        Wed, 22 Jan 2025 08:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECTYYoplVzBJ6wjKTC7k40I9OooX0AIs8FVPjZJ1CMDAfg1vLRLjHYKmiVXbGP9Crknvalkw==
X-Received: by 2002:a17:902:e80a:b0:216:6769:9ed7 with SMTP id d9443c01a7336-21c355c7dc2mr368166835ad.40.1737563439343;
        Wed, 22 Jan 2025 08:30:39 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d40273bsm98666785ad.213.2025.01.22.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 08:30:38 -0800 (PST)
Message-ID: <b6f99b64-3b11-4a4e-8995-fa18aa4ea203@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 22:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix memory leak in ath12k_pci_remove()
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250122084756.817548-1-quic_miaoqing@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250122084756.817548-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Qo_ke-p9d6uuwFYpbatYmN45D5Vajt7Z
X-Proofpoint-ORIG-GUID: Qo_ke-p9d6uuwFYpbatYmN45D5Vajt7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=704 clxscore=1015 suspectscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220121

On 1/22/25 14:17, Miaoqing Pan wrote:
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1725,6 +1725,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>   	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
>   		ath12k_pci_power_down(ab, false);
>   		ath12k_qmi_deinit_service(ab);
> +		ath12k_fw_unmap(ab);
>   		ath12k_core_hw_group_unassign(ab);
>   		goto qmi_fail;
>   	}

Instead of this, why not move the "qmi_fail:" label above unmap() ?

-- 
Aditya

