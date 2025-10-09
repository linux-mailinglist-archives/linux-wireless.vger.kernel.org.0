Return-Path: <linux-wireless+bounces-27898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA52BC7CC3
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 09:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C261882341
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F232D0622;
	Thu,  9 Oct 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jaO4Wkut"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA1260565
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996365; cv=none; b=rPTo+XToIRImjPDvlx00evriIPGTyATFsz5w0dAulH8YDyeWa9JfGgesX436jRbIOA0WoNvemHyemLEiv225mBu6HB42HO/RUf4vuxBG9zHmBoyM3qaF2qo9l6dG2TAklqxuXIkEy2Ka/CpPC51bL9ybOb/NBLHRjZ1UEjpFVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996365; c=relaxed/simple;
	bh=CWBLoEiMwNJ6UjJ4yqShyaIMDyoqpCUF+WZPpji529s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk+lzog+V8E88l8Bi6iQ+h5sBteEdt//xlkDTWSMcx3vETfuqGhlUKT6HXrHXDrLAJogC9L0NIpYc+U6lniGKsErPgFyJFqJnVUEEiLvulAAjWavyw4ojgGdHE7kNYr1jb/USetaRp8DftQ+tp4SzsX+XigWlLsMGnIhL3UYhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jaO4Wkut; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996F4jP006539
	for <linux-wireless@vger.kernel.org>; Thu, 9 Oct 2025 07:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sjBxU5GmKJljpC5RlW25Sr2TYBc+Ri11gCihrueEv90=; b=jaO4Wkuth7JtrG/f
	4v/VoPGv+JQJ4KNSOcUhSON3q7OIbhOa9x3bkAEf4pwvSCGUg4F3eZN9BESiHo0/
	hVlN/EnBDQ9G/W35939sQaX3o2B1v+W2ggKParT7vJyAgA3YXSj85+pYvJqfOVCG
	0ucQxTYtKNDW4MLzAUWdipJpPg3GeTSVarUsYyWGukGnmOj64rvhtf4lj0Ve5vVP
	LaoA7POaiv1uVy2o+Jc0sX1aRQoTECg5Pfgq28SloiHXzU9xxJX/k/I0T9mgCuof
	yAOQR+0/dsIx46UgpseXLCQwx/bBvqPfqoVVHyYSFlJqyXqOm2kP8uvs2covWtBP
	odjg2g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u1xmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 07:52:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eed7bdff0so12472195ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 00:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996361; x=1760601161;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjBxU5GmKJljpC5RlW25Sr2TYBc+Ri11gCihrueEv90=;
        b=CSwCMJiS6yycrbkFZ1sb0P+RsbpvVFDx2bTbGbLkuH7Sn447kI9QD/UU1YVEa5wovJ
         J1qZ3MRyIm2Y5jyatGweMmWWMbBMBCvLhzL1QdcraKFc18Xt+5ITckaNVHWe9/8IC1ua
         DbZ44QbH1rnSrw9spfqyFkJVn+h6rEQmb0R+4OfP3RkfYCSILCQokbuSe2j6+Efv2pYO
         +wH+1/tdX1hz2xuwhjbTA6/wC0UtT2TJlq+6I6dsGe41h9A9Rasb21ASDlYRoB/MNKPA
         iQ4PVLMUQ/PKScHXzhkCGwk0nZCbVfiycH+zP3Ar6Hh4W5tLzcYeMZUWC7967JDiLpsv
         xznQ==
X-Gm-Message-State: AOJu0YzkggBsQIvWxowhdweQotJU8zLUq5qXKQtFaV/mvG/ibpfThKYE
	4xykbULB/X3UFC5cghJT4qL9zpQYRA5CNbR8e9gCte4Zbc5nvJzn67cBmDyTv184vzs7AsX4vjD
	4BYv6iKEhpqT+1w60PnFK6JAO0vHbl7Ve2jufOcJ2ezFsd08n/SNmz6IBKYVy8+ue5Gc5AA==
X-Gm-Gg: ASbGncuK+LfqqSHJNfZFOF6fdyXKhSAK//VeOHQfG/RjZoHWJ+e4/a1ncWYfSPP66Dl
	/KO8+nZEYyrHpu/ide4wLX9GmvCMB22F3SmNCX8KeyZ13jszSkog4aAlmBR1nF9cplb5ztR3L1w
	Ana1vCmNc/kFaUbjJflXpXn22eG+x3QWE3jLFVov5h8PXopZOeRi00LUQPLlcCRM7Qcim/Bspe0
	Cus8JQmHtxaY8VVs9vZuMwid7PQLHtL9AvDr3UNPSJSVzk86y9DhPH4zfJ9riqv/3uhmeYzYxkU
	Vmy/bRESyYgRuDoKTbQuhM8n8FNyYCfBNtL8eNLZ7CA5WFNM9na2VpuGOGzgoB9c0V34HA4k8sj
	FLqMSnjQzM8AzULyl1tpW3OVgg4h8LuXj8Qpt6wuveAg=
X-Received: by 2002:a17:903:2c03:b0:279:b2cf:26b0 with SMTP id d9443c01a7336-28ec9c97450mr130060165ad.14.1759996360595;
        Thu, 09 Oct 2025 00:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp8+6ovArh7jZS4tcGwwokh9/VJpOZgph5nDQI4KG2pGwZUoAIVvoiD6PI+5CSXtkxXLHORw==
X-Received: by 2002:a17:903:2c03:b0:279:b2cf:26b0 with SMTP id d9443c01a7336-28ec9c97450mr130059915ad.14.1759996360160;
        Thu, 09 Oct 2025 00:52:40 -0700 (PDT)
Received: from [10.133.33.228] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b66sm19682165ad.124.2025.10.09.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:52:39 -0700 (PDT)
Message-ID: <d2c0cc75-6ec3-4566-ab5c-1757d1a753de@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 15:52:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V16 2/2] wifi: ath12k: fix TX and RX MCS rate
 configurations in HE mode
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
 <20251002000732.1916364-3-quic_pradeepc@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251002000732.1916364-3-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e769ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=ZkQ9Z5jrJcQJduYU1mwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bK4OxqbEWmup864s4qkUbyZqCl9nmVjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0F9PzPOzSXOg
 1GFHbIpwLhh0PfpQqBpsRIGKEeBze5Y3Q5AOEfhwJ9FDlYITO0eV8H7OdpkUyjDnodPflQ5lCdu
 PUXl/WEvwuSuzVsMsnIhjzQkAPsEaQve58meuf1vxY3o8Dhvhx2pjSaYteJCpnZLYRMBm1QI6rh
 gtuzzeqdspR5zGrGIXbpsogByugDTvfYxVxBNqubhQ7zzEsRYEisAIjuFOXfxvPiFiHCVHf+ttj
 iMnB5NnvhY63LKIWqjHHtVIseD4N26PrYgluJAFDeRPd+3pM0NANZ91cVqpL4fz1EQQ3DbQkWjq
 1IEmsncbJM8to99tYhKSrzN4cTRBsWr20rmHB2mQH4sTjJQhuhsRFLD2U1LfLqlC0BaJzntJEx8
 +tqDPRFPIA8WiiO/YvoHpMetFgTSDw==
X-Proofpoint-ORIG-GUID: bK4OxqbEWmup864s4qkUbyZqCl9nmVjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/2/2025 8:07 AM, Pradeep Kumar Chitrapu wrote:
> Currently, the TX and RX MCS rate configurations per peer are
> reversed when sent to the firmware. As a result, RX MCS rates
> are configured for TX, and vice versa. This commit rectifies
> the configuration to match what the firmware expects.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 0d425a1bc0ab..19be450b42ff 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2624,9 +2624,8 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
>  	switch (link_sta->bandwidth) {
>  	case IEEE80211_STA_RX_BW_160:
>  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
> -		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
> -
>  		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
> +		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;

missing recalculation of v for TX MCS 160 before assignment to
arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160]:

		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);

>  		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
>  
>  		arg->peer_he_mcs_count++;
> @@ -2636,10 +2635,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
>  
>  	default:
>  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
> +		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
>  		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
>  
>  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
> -		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
>  		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
>  
>  		arg->peer_he_mcs_count++;


