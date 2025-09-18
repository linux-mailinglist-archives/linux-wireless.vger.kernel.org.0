Return-Path: <linux-wireless+bounces-27473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1967B836F4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813ED1C82374
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719962EF662;
	Thu, 18 Sep 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XlaOY1Am"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA842EE5F4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182736; cv=none; b=i6n2nalymuS1swWaNND76i9cpA/+KY4sP3gwIPmd3ULumoNf44JufNUMXBLo4vJL1iXs/KRs3KSPEMqQwj4SBXcWJDdtG4VLNMo6rML/K7FRqrRVOlXb10fyzrHe03UBCKomdKeRtfSGiHR37AjaHJR03E8yzmo73GHg6r0ENhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182736; c=relaxed/simple;
	bh=taH+Ny8WdmfYbJnJllQtBl6x8QzOyo/tv7At52im+/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZh140Q9O+SLgh1meHft9BRxdOCdLMu/e6NEUB6eIZljehwyAyL9f386z4NgbbEfCk1WZng2nLLdhyAtDf3K9372PGNHDNI/YD7cnH/KvDPOziwKNm+B8udNyKcVmYhTZ5mN41pl/0BBeuIhNotww+fbdny0ICzzLELfb8JVgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XlaOY1Am; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I40Plk010735
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 08:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UkvTQXFNTrKWLcqS699MNYS9sYPJqv6Z/HFRx1ooKCY=; b=XlaOY1AmwnVPxhsY
	xlHN1zIiCwJfNvDohbMtyG0iSZuGVkqxCDdHC+OX7HpE7KglG96fyDy+z6qQhkpb
	le/6O0lcTRA5kjJirhubN8tZsLTsPFky4gN822a9jV1vbyl9hbXqk4WamsCSr9Kr
	scdDsjTv3FheQkGcPeg2/54FRrLY1u3cudIeiZ7Q2A7F6JFXsbCmvb+sBT7kI3Nl
	xPfKMhWHC9wTFa3ZO/rbbAXkswsJcOdq+jOeLsei8D1RQyVmMnKWd53i+ihEUNEW
	Sy6uxwu6gfW6WYbgKmLYtI2lt1yLlsln8N6SaYYMazYAhEf7ZnA9OMw7e1Y4paeu
	aKpJ1w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxwf47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 08:05:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54c46337c9so961162a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 01:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758182733; x=1758787533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkvTQXFNTrKWLcqS699MNYS9sYPJqv6Z/HFRx1ooKCY=;
        b=lPjKQyNE4j3Ldf51MYW2QYA8PS22WtUzsWjQBNnWu/7ZJhHoikWd25tFgL4UwAFr2A
         moa8tiSI/fLS/upy60yAga72yK0/8TnyW4I/oEUly+nowgz7NJ3dNb8X/MUHa4AjPxoo
         Y52ByzdbJsuH2AYTrdnSy96dV1srSM/TuYeut45xdVbP9e9HMry29wKcb9EAZ+RU1kya
         Sb4AeF7Hseh8dE4TDyFwFbZr/ZyIgQ+7wp0P6G36fxnPfIM2kxgZ0Qvoe1xyo1Tk6OvY
         rM7Y4BfoSwBF7yIolyzwK4xoTSUM3W53OMXag9hqaC1rz0oYo4MLXpfA0BKnFpLllezp
         CAFw==
X-Gm-Message-State: AOJu0YykBUfKV81OQ6OmZENi3TjPmjejfjTwBEh0HhYUbrE+Wwxtm6wM
	P5tuBEAW6D2Tky0PzyUbHwOV/2kyWDnbu0EdO2SKeADeyTDRpn8/HySWsczaaWhxAGpRYvBXv1j
	++aDOI4np79rJgxbKNtFHujt5AFmF5uiCS/Nmoo4luxkzeM4r1UJvlhwfOcaUzz7daQ+5xA==
X-Gm-Gg: ASbGncvoDkULaQzc8YNN/dE15rX7uTz4tBsatHzQtGJF7d4+BHGZDLrmtNWpI1XA/7A
	8kM+wSVkDWBT32KWvJ3MPhC56USJpa3lwC/QFoNL9PHN4orqKvgYZJqciAHXiEz15/TJ3wIwqIh
	kLN8B59cd1hpPqI+ADKTusEwo/eBsEZEFtTGop3kKzDaYm5f6pvrmvV9B6AjAYMmBbSMu7Sm8+t
	qD1Pzime9flNAiIorgi4wOju6TpJNiv8X0mfZ7Mywvv0GssUc/ZK1g01WkSiZ72lGt+71QWgqCE
	EVJ93RG6OKu7nWlT4GKxBt05JsKFlmr0CHu0YEORexBWyX4byqPkEE/BD/wGn+5+yt4Era6WLgp
	1grwWEFNZWoWwZ5oZGbSsdvswcrwl/LFP9ehR
X-Received: by 2002:a05:6a20:3942:b0:24e:84c9:e986 with SMTP id adf61e73a8af0-27a90dc398emr8017889637.15.1758182733040;
        Thu, 18 Sep 2025 01:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAI2GSbZnRKsXK+5wDP4AEX0WtvADto5IwnoyLzXfbeNOfMZ++8+Zso/G5O+QIRqZI7gCajA==
X-Received: by 2002:a05:6a20:3942:b0:24e:84c9:e986 with SMTP id adf61e73a8af0-27a90dc398emr8017852637.15.1758182732607;
        Thu, 18 Sep 2025 01:05:32 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3fd7easm1598084a12.30.2025.09.18.01.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 01:05:32 -0700 (PDT)
Message-ID: <7dabee21-97e0-4025-bc84-10a2c1247345@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:05:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V4] wifi: ath12k: report station mode per-chain
 signal strength
To: Lingbo Kong <lingbo.kong@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812030044.688-1-quic_lingbok@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812030044.688-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9rOpEwIezx+f
 mUTXHAZWugjP7KtTRY170Of/K9ChRyv0sDw9Oruxug+jjeSRrtvYeZVqf3LdMxC5OmT2T5LwJNx
 jyq4LKTLDLvqAJLfN61Rb5BLSRGY5WVFrQj2xZ9PyzGEm7Bb5MSIk7KmlQnLSfU4qeCsVGeM4TO
 vVXgM9tajddN/QaaoQvoKrfJfNS5PPe1KuY1wrQD4Y/GkhBaZb3vgnqBHU9Zwa5lVvI1wATz7cO
 QLKm2BjGkiBgCouIRMu1Ls3Ccu2OdJ1wYKzDW3NPy1nA4eeEL2W36xfb/N2Qz6HVJ/B0REEqI2V
 l084IBlha9DLVup8yEBlN8UBVYJH76Nu1hrao8JQYP0dClN+Hf8/+k8uhXlIG0LWxZuLjLRidd9
 og5Cjwzc
X-Proofpoint-ORIG-GUID: gRxIEfpzdwe4o5UHznde-aq6TBltwkPZ
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cbbd4d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pN-lpjZd9i1dOjWOSwIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: gRxIEfpzdwe4o5UHznde-aq6TBltwkPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/12/2025 11:00 AM, Lingbo Kong wrote:
> From: Lingbo Kong <lingbo.kong@oss.qualcomm.com>
> 
> Currently, command “iw wlan0 station dump” does not show per-chain signal
> strength.
> 
> This is because ath12k does not handle the num_per_chain_rssi and
> rssi_avg_beacon reported by firmware to ath12k.
> 
> To address this, update ath12k to send WMI_REQUEST_STATS_CMDID with the
> flag WMI_REQUEST_RSSI_PER_CHAIN_STAT to the firmware. Then, add logic to
> handle num_per_chain_rssi and rssi_avg_beacon in the
> ath12k_wmi_tlv_fw_stats_parse(), and assign the resulting per-chain signal
> strength to the chain_signal of struct station_info.
> 
> After that, "iw dev xxx station dump" shows the correct per-chain signal
> strength.
> Such as:
> 
> Station AA:BB:CC:DD:EE:FF (on wlan0)
>         inactive time:  212 ms
>         rx bytes:       10398
>         rx packets:     64
>         tx bytes:       4362
>         tx packets:     33
>         tx retries:     49
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      14
>         rx drop misc:   16
>         signal:         -45 [-51, -46] dBm
>         beacon signal avg:      -44 dBm
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219751
> Signed-off-by: Lingbo Kong <lingbo.kong@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


