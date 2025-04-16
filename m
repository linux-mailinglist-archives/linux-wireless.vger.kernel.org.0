Return-Path: <linux-wireless+bounces-21585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4798A8AED0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 06:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E562E1898678
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856419DF98;
	Wed, 16 Apr 2025 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctcIeLDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFE32C8B
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744776259; cv=none; b=Qs8r601TKcq5nOodIpQRivlgKG99JvWJhtZi9LqxWZCif1nLwP/26F6IX16C0zhmx04cNkVmuVgSAD9ibSCanEGOlmutI1r5EXd+53nUcGbO1coVfEE37P5KasYiGbDckP1nt1GjO8aQxPugeMPQ6iVMHOpVd8GDMt5sjN8PZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744776259; c=relaxed/simple;
	bh=jS2w7q8yhxFdGVrL5jNPTp0KaTZA2FxTnUArSBG0A3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4MckgiP4vvI2HMsNXS/Tj3vGos10l1jUshw1MNLTeBdWnu11zidT0iR+SbbLvem9a9uuB5AaaLJQEE2SE8yB+4wSziM409Q4oF9kw/D6epnMAV+7TJBI5xODR2t8YD2NHWnO87eGWHS6Q3uHCqOH0nGJSUaP+6u/0AghfBXn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctcIeLDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FItkpp013140
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jhUKvNCjRFWyuOdy/mH5/vmgBZi9sPDt+oS3Cxapi1I=; b=ctcIeLDYx5nl8Did
	Q5o+grumf7hdZZG4sa9xHHHOSu5p7k1tRE7SLDMomsZ09IpHsHJ682h16YDeHUjl
	AbZbrki0HBvrad+OY7D9dLBx/cQ34YMFOgfVRXAyU7iKpG2tRF9J3Dpa7qZ6DuTN
	sTjWy6g2WJK/SfPmqVbSVkJtkhWJeH47C6uLU826HADl86yuOCMuIpHUC9tzDxR0
	QsDQwc8Ai9xB6qGcWNRM3dKFz0iZKO7IgGX0gZOiJxa3pgDfBmL9M+e9hdLOTejm
	VS6JqKbHkeE/sfROBh+PB8G6jQ7UivD9VYC5CextJyRSZplXPvzGrLXH7jXweQ+X
	3tc4ng==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6j9ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:04:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736cb72efd5so5504849b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 21:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744776256; x=1745381056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhUKvNCjRFWyuOdy/mH5/vmgBZi9sPDt+oS3Cxapi1I=;
        b=T5NvCzS9n4U+Wah/OpnL/v0MjWQOMphZ3InVUHUiKRfz/KjMcYuH6iPYWE9dGO1P+1
         8wGAtq+jxcxZHfluahttG+DsWW8ZCGW2f4HFu5ot0+G6FKwVHt2J8741iHMwXG9BHBw4
         DEOFXwxHoZtaWTse4KMGSP2Lsod/pfgq0+RbS69u6twrswwc+RURsWwvAruH1UVF5r7n
         gjitXGSP5PqJgsufqlIVrWrZMkkFv9LDMuOI32wgdQypO0VY0DemdfH6WzlAZDHQXchz
         vM3GlWc27+SXN18mTY0lzSpg6heCCHykIafqcnzWMb0MqmnunTjXHypCm21EZ20lV57o
         oaXg==
X-Gm-Message-State: AOJu0YwNzdEBv4PS12emYjAiKqBxPVSixjxFFg1LRevifqcReblVBqhE
	PZjVA5pwKXi6kGsDWS19KU+zKFU00BhnvpKGPQH3Dxv4FgWi1vx+LlCfAjnRxHIjjxMBqYOfGHP
	4o92Z/jd/DUs2rrzFbrEeeP8tpYafX8Cs2b7NSW3fxjOtcPDKODT0M93REGWLJS2fLQ==
X-Gm-Gg: ASbGncvddSqjrtgIZL192D1lwCVJ34yDh1BxmP9wHuf0H8EoT2ARD9JYsEjkO635Nym
	mBg3ql/FTJ66A40ZGwHBLEzH/K3BO5A47AMdIVT+EKkG01xcRnj9m73DAa8cIEA+fDq1dp8aFWO
	PF8ua0Ky0dLG1NmoxKsw+CP3dgCjD9UbF3x7yAaKPGjOoI0k/aeZ8QuwjSeR3JAGTwT3LcXEOrz
	EacW/PNx9GFPv0rUna284Gu5gma5KDIM2ht+ns5PXmT7fCfZnHlj78uHeLJJcJWHO2RHJXhgXVm
	0xZb1/tO+ugA4C6E9hW7+ejJRJc3tjPUwx3u2Bl/Pps796UhmBFG4w==
X-Received: by 2002:a05:6a21:174d:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-203b3fc17e7mr191943637.29.1744776255763;
        Tue, 15 Apr 2025 21:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH6oGs3hEZl+fV32U9ZXtXiZvyQ6spTGhEY40Ibu2s9I/iyZN7TUwOuxmcB+F6pmRKeg2pKQ==
X-Received: by 2002:a05:6a21:174d:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-203b3fc17e7mr191905637.29.1744776255328;
        Tue, 15 Apr 2025 21:04:15 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220c45dasm349041a12.23.2025.04.15.21.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 21:04:15 -0700 (PDT)
Message-ID: <f1dfefe4-8100-178a-2cb0-8ec1cda4337e@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 09:34:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 1/3] wifi: ath12k: Add helper function
 ath12k_mac_update_freq_range()
Content-Language: en-US
To: Rajat Soni <quic_rajson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
 <20250408042128.720263-2-quic_rajson@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408042128.720263-2-quic_rajson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C-wRuoFr1w3ijfdq0MxYdTI3RP08fUAI
X-Proofpoint-GUID: C-wRuoFr1w3ijfdq0MxYdTI3RP08fUAI
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67ff2c40 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3K7Z3hTJtzFxHNBfxTAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=977 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160031



On 4/8/2025 9:51 AM, Rajat Soni wrote:
> In a subsequent change, the frequency range needs to be updated with
> each regulatory update. Since the current function also modifies the
> DISABLED flag in the actual channel list, which should always align
> with hardware-supported start and end frequencies rather than the
> current operating ones, the existing function cannot be called again.
> Therefore, the logic for setting the frequency range needs to be
> refactored.
> 
> To address this, refactor the frequency setting part into a new
> helper function, ath12k_mac_update_freq_range(). Since this needs
> to be done independently of updating the DISABLED flag, call the new
> helper function ath12k_mac_update_freq_range() after updating the
> channel list for each band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

