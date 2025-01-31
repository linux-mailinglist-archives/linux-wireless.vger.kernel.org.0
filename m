Return-Path: <linux-wireless+bounces-18242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F8A23934
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 06:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A7A7A3816
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 05:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A52BA4B;
	Fri, 31 Jan 2025 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B86AWmcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2B1F94A
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738300054; cv=none; b=UwfZ+au7RfaHiuky/d3LURiFPipMewCXlaQtCY9eyRF23TRqXLx7WkcNTSl6JiJFKeCxqT98Cg1764BIXsKSAXoYLXMmdPTBalfzpUH7naAmG4KVk/YcqcD5P3Hn+sMAfVXF9rEhXIkQLTj2rN5zEJQf6i/vpL1cNdu8NgK2Xhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738300054; c=relaxed/simple;
	bh=WqR100jeiXbW4Gkh2IATdPQ82FCTXch9si2IrS8JRdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rt/LuQjXOj85ynU2/ixDf/P9MYM7Dm8dHYt5A+wOerkb60t6AnTnuUAliKoYaRAtcsJKn7y3w7Mz+pIMCL0u/lwPhT56zKYwNQPVg7cYHHjqVCKsUlUbLbFdm55zrZs8Y2jz7ZR4+C4gFgAlc1oNZ03OhPgRAUp1eDnvOqhyltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B86AWmcW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1cjD011684
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 05:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8D7O0wDLWwIoiTAJ43L7yF1fTstKav2NoIU106kB9ds=; b=B86AWmcWCvlMm0ZY
	gaFjo9PtPuuJZ+My6orYLgc57MejuwmyEiuakbtXaq26SmNYxszqMwUm6UXbrtyn
	gaoXzFwcpVNEs+MRzqJRYbGxZhHv8MPhwD+/LCB7kfi9IZeG0ObyBxij666so+5d
	46D9U7JXKaF98zOe3fnbh3/FmkJGp12Mqk3W3lMNdreoCpHFJ2naPfBzgMeJO8nB
	PJx2OMntt+ILWF/5d1CYd/Bu1Dfm/T1gVFvnLGRU0/oj/97Or6oR8Yv9g3NQXGjS
	gWc7wx8QGznpBXNrdz8PdsR/AqshG62zttb/mfCaeAM/4RT7AIEMz8lCO6MKWeqZ
	MjRspw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7k0y4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 05:07:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso3216495a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 21:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738300051; x=1738904851;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D7O0wDLWwIoiTAJ43L7yF1fTstKav2NoIU106kB9ds=;
        b=VXL06K/nFXGNSQRojml9Rs0O0cY/HJwrPuBTHue5x0ZBg2FgzqE+FV6WCca6wPdM8d
         GiKQAg3l8MH28lLPw4JJkNb6jXO4LY/n8MjWNw33PvaHiXoRYuZbj//sFzVzW2VzPEj2
         ZjY2eOI0XLHlJet2KusYqa62Ud6wp0H7ubL5fieO+P1gd1EPwWs11w+5mM1d8MO1rZNA
         vdSNMzlcz1S5xI0z5tZJ7BCuplU51CsDhVtc+LyJjNGIbZafYi8dM3YptUn/RFIK1R0x
         AcKelua8qcCBPi+JxBf1etG26M5fiQa5WLsLMBp0Yb2wlJlbbJ+X8iWqJdN5KYiL0N6i
         Vomw==
X-Gm-Message-State: AOJu0YwpqIKfJIv8EdaHtLNDeKtXFjO3RHfiycCkCiNAG8vs4BlcBfDU
	4NA3DZ3jSs47XihJKIID6NYdLh/RaORssvemDf4Dmu1Bx9PEYSyJmXBOK43NXYfhAThNOcTTdzZ
	b+wh+NtI6PMHhnS90zbGFz8Hy/8f5nODeJk8qZG5ouqzftbgFO/E0RB9QxNDt1l/lPVR2gedFJg
	==
X-Gm-Gg: ASbGncuTJ4EM/cfWK5av+hDQbfIrjCtv59FOEBPpvnJqoQXlLv7F6o4VWck8Yx9RZ1f
	aUKeagfW4lD7k3WjH7DXkzPLxbmyUwkyFUKlIVVWXnPPIWbfbvx1BPJz/58PYmMNEJThIsQy/me
	eMdhwZOVZ3RVEJNyHTs9DAM78zdmFohPAOz/4H2/+l0ksQIOISy5IpaCk8aKZYFyfoGpObGWUMB
	TES+zcfgIXUKD392mwFc1EB6mXUtCZDCjL5q3zIISwlo5bEuzaXlFjJhXlcuyunAvYT1mY1fLrb
	EnbY91h76/nox5lznsIkKxQOp5tDsPT078BMy7U=
X-Received: by 2002:a17:90b:2812:b0:2ee:5a82:433a with SMTP id 98e67ed59e1d1-2f84642e62bmr9074935a91.17.1738300050904;
        Thu, 30 Jan 2025 21:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA1FYtzRkkLSS/Ovc1AAVNkvhN3G9XQbbiP2WUWRjecNejoovDCQXr5+0UlhLcsqz1kQ31lQ==
X-Received: by 2002:a17:90b:2812:b0:2ee:5a82:433a with SMTP id 98e67ed59e1d1-2f84642e62bmr9074909a91.17.1738300050453;
        Thu, 30 Jan 2025 21:07:30 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33007dbsm22377365ad.184.2025.01.30.21.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 21:07:30 -0800 (PST)
Message-ID: <51e3c2e0-4497-4037-9c13-d3782d04232c@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 10:37:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: Dump additional PDEV receive rate
 HTT stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
 <20250113071758.19589-4-quic_lingbok@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250113071758.19589-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tO8GVQWCRbQwXLwLaWdW-2_9nfxWOiTo
X-Proofpoint-GUID: tO8GVQWCRbQwXLwLaWdW-2_9nfxWOiTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_01,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=762 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310034

On 1/13/25 12:47, Lingbo Kong wrote:
> Support to dump additional PDEV receive rate stats through HTT debugfs
> stats type 30.
> 
> Sample output:
> ------------------
> echo 30 > /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats
> HTT_RX_PDEV_RATE_EXT_STATS_TLV:
> rssi_mgmt_in_dbm = -48
> rx_stbc_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_ofdma_rx_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_11ax_su_txbf_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:9, 6:72, 7:41, 8:1, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_11ax_mu_txbf_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_11ax_dl_ofdma_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_bw_ext =  0:1395, 1:0, 2:0, 3:0, 4:0
> rx_su_punctured_mode =  0:0, 1:0, 2:0, 3:0, 4:0
> rx_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:14, 6:149, 7:44, 8:1, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> rx_gi_ext[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:14, 6:149, 7:44, 8:1, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_gi_ext[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_gi_ext[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> rx_gi_ext[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_ofdma_rx_gi_ext[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_ofdma_rx_gi_ext[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_ofdma_rx_gi_ext[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_ofdma_rx_gi_ext[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong<quic_lingbok@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya


