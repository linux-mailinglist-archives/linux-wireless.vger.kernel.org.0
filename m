Return-Path: <linux-wireless+bounces-17341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54EA09C16
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178CE169438
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB62214A82;
	Fri, 10 Jan 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDkuSbbC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7C2144A1
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538809; cv=none; b=ir9f2PPvH9mtx4NjiYzu6xRSrbiHcdVc7XE0YOfkSDeH2j5AN2HCyBn0bwJUfXhyqsYv8J/iCkNDo0BGkAvz7vSE4d4N76G7aEEdbYwqeKT/8QF6yYiagI/A5Zc3stKypmXxrfb/Ik7ryyDjV3yBLNBYQ3cv3KZNZMo6u5VG9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538809; c=relaxed/simple;
	bh=wa28l+23wXzTuGCVt70j8SO53cwUSuGC0MnyIlVvoME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8h/Cdmd1H6XX2Jv0A81jf3zmMHXCmI9MMz1uhNGWhYlGmAXy68gpdGmf4TEPOeR1Xlz5lhoTi75ygs7V1LJblzHPvQyOwAIMC1q5VUmxZURgOp3K3nagVb2jh4srd9Bkvf59ufJpukDyPFJUPpzNPw+WqnD30OUdJmKa7UiEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EDkuSbbC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AE6hkp020071
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yo06f47uK65b4AxrDNsmCYM281VxDEwL3Bi6Z4rW9Fs=; b=EDkuSbbCBYUbaoh4
	WGYw7brJK4uhBj7v8AEujR/KIFawly8ttfO7Tpe9Sfw+n8muzIQrLdmHYC+6oDSB
	P5HUrMVaS+H4HjvuzF2pcYr9WVxzIN0lb62R8FEtF6XyjFrFmjjzKZ0PxwDyQMD7
	g6/sb0n+ChR6k9xu04ZPoi9oaRTH4k9ZTL2mhf67YA6X6W5GKG/MAksm6rkC8XjZ
	WM5EMRb3xyWJCrW3UDEskgiWnY8IuC+mSuRX7CxQL4jzjdarXFdnK95NJtuyYlt4
	xOjTQCjU+7T+codQ83wVnqC4MEjhP1/y3vK7KHzaCXkqEloGnKw3wjGjK/4gvwvo
	jZVDPw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44351a8ug2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:53:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2161d5b3eb5so43568745ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736538805; x=1737143605;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo06f47uK65b4AxrDNsmCYM281VxDEwL3Bi6Z4rW9Fs=;
        b=fY23YYFPYH2s4ebNTkCjMu0rrWu8nmY289b3MEkRE9HysG4Ike4ihDLC4rYq3URuAq
         E3MzhRyu0/nEX0ibzawh5sckb5ikTa7dlNVlCbSYUQLIb8/o0XL5yI0py2sIck76ovny
         0YVGjT8FZbb+jU8fYkW4iQ+LQLjMNMCFVkVo5vs/uvND6a4Q08nPnR+zFwszIQV8GRDs
         GSWUWLNMjzq6uu6z1sfTxi1zsQgsRfA74Oc6dumxoU0vonUdA6M9AaWXLIOorKyIuyYF
         fShzIfb2cFJlV8pYvqiSRDTEctKpUwAOQxDr02YNbWsp0Lkywal2ZKvEYeIvBj3uANHV
         PICg==
X-Gm-Message-State: AOJu0YxoLUAG56HSpojJwxAsb1kakm498KloVB9gQh+YH/DCBp9571W/
	A8c64zxmEB8DPuvh7Vrii2DkxR+a8iUzO1GjBcyUued5ER4n8vI7RVtbCPIGoRiMyziuxyysvN5
	7CFhVEnXDA0Fs/OLE5/hZfQwEUPNpB6u5JWM0kxLcfB0AsWJzdodOmceGHWJGrs9kkXdrhCn7Zw
	==
X-Gm-Gg: ASbGncv9pZGAEiXKtTGuY4NuqckLTVrGz5IcMC3vXrgFOsyY/+7oVJfnpDyq76eAoRx
	LmDdjkmYH+GcTootsve4stVmE6dYb4MYWj/aG/2GU1qDQTk+nqKeDgdvgTZpxz8wPUDZGkXyZVL
	xLyb67dafHGRZ5iPfbOAp2WQMio8tjjJ/am72J1B20U2pHP0GIMH50iJzQrP/hnqo/2XbnIj++l
	J5SJo+WFPmaaIXsEPhsiuRiHxgnKt9zxT2/LIxn5Z/JBWuZ483fy2xKxo5qJs00GROaTWLZ5Px1
	tnpf8G/P9fc1v8pg7BvdbHAxIFPREGmHkursMgZNSvcDE6unYQ==
X-Received: by 2002:a05:6a21:2c15:b0:1e0:9cc2:84b1 with SMTP id adf61e73a8af0-1e88d09e13emr21983922637.30.1736538805245;
        Fri, 10 Jan 2025 11:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4zl5ZHJdET7l5Nz8ik1Pq4xvCbXdDljAN9Z9p9CwO+x1HduUPS22+SzOnS6i0jSopvaj3yw==
X-Received: by 2002:a05:6a21:2c15:b0:1e0:9cc2:84b1 with SMTP id adf61e73a8af0-1e88d09e13emr21983892637.30.1736538804834;
        Fri, 10 Jan 2025 11:53:24 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e591sm1878079b3a.126.2025.01.10.11.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 11:53:24 -0800 (PST)
Message-ID: <7378d01b-c4ac-4e67-a601-5030d3963e00@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 11:53:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] wifi: ath12k: Dump additional PDEV receive rate
 HTT stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241206133355.1990-1-quic_lingbok@quicinc.com>
 <20241206133355.1990-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241206133355.1990-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UJsOVClxzdKBLtysA6K9_APplz2LZHuw
X-Proofpoint-GUID: UJsOVClxzdKBLtysA6K9_APplz2LZHuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=985 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100153

On 12/6/2024 5:33 AM, Lingbo Kong wrote:
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
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

...

> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index 65e95d1e04e5..57376307959f 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
>  	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
> +	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT   = 30,
>  	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
>  	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
>  	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
> @@ -201,6 +202,7 @@ enum ath12k_dbg_htt_tlv_tag {
>  	HTT_STATS_HW_WAR_TAG				= 89,
>  	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
>  	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
> +	HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG        = 103,
>  	HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG	= 111,
>  	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
>  	HTT_STATS_DLPAGER_STATS_TAG			= 120,

both of those should used tab(s) to align the = to match the existing code


