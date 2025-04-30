Return-Path: <linux-wireless+bounces-22230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429BAA42D0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 08:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF742464AE0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A11C7017;
	Wed, 30 Apr 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jDPAM5FJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AB126BFF
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993144; cv=none; b=cifQzks0nN+h6FILUP/BYVVV58hFHvmTBs0eKLDRNvLtYqveov2PrgXZYMNSzVUTRCnFElOmKxUMJxyZm5cOM/mdOGCpSn8XEij/DPBIH3KiQTMQLblB5rGxO54vT1EEtzptF/gtEn5jpWOcRQK+YaK3psVUtz3YCqA511Y2Dgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993144; c=relaxed/simple;
	bh=SEWjuwkizDRhd926EaNVslyOK/zWjBAxAcHSp5BOfB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dknHy4Rwb2dhcLhYlIMjlDdGhFB/SkVtWo84U4PTR7/CWAZhda3J0v3rL96NE/HJVFn7WvuS4E3l8hM0IY6VhuHEcdikFOlUXGf10TVwrhUX61w6n6i7FoeZc2ZgOsEpw4ReJCS8B94ZFQP5K2G3DkZLdNBz9crhxyrAMsC+bNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jDPAM5FJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLagDi001219
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 06:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qhdZAfqJLdzz5mNg6DhyrEfY4eRZ7zUfKuRa7uPoXrc=; b=jDPAM5FJN4lEuOe8
	951w+jLJfWbyE4RP5vrVEmnpM9zQUeYqcFufzipNmf33BSDkIkT8dryxoRTs2sG2
	0ohQk7vgzyMrcw2asyE4idav1Ti84s5u2KDAVKKd9nblDmtAbaSrdOIWr2Ri3gJP
	ZFSrRDFabz4+FEcfS8MlDRmMbUR4KcAtAyzX+QyFbtuPeRTgdtARajU4z60CZLcb
	iPL26hkcY/0qTsCfBCNA0EZdFSbyZLQaZhDMMAg2reLtcmh46jTcVD3XpgdtQAFS
	2ns0JOIwTIsoOiAFgnqU45xhWL9pepT04Bhys6r025WRvjKLhzBQb1SDQWvF3SAr
	HWFgpA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u9ryg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 06:05:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3086107d023so5919804a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 23:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745993140; x=1746597940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhdZAfqJLdzz5mNg6DhyrEfY4eRZ7zUfKuRa7uPoXrc=;
        b=WGrPWC+01NHI5nHZe6imxwVcAvabpAGBxEwZnRmgOQ/QcoR5OkhvSFI3eJ/g/fdCGv
         YJ99P/LZn1l2C5jeZNQF+6HOcLcF7LrXLrPXMUmCFMqnOMPpXbvjzrKwhi4U3AcxXsxu
         34GUZlKi/BDmXh5JDlGuak1zDnFrcmHoUCHhza2SkfF9NLUPVRXdKjHmltIecSJcwhiA
         bI9EWanIVa0dacikGH9hMAoXtykbKrFdGOdROyqGFLhaEABmfNYjKlKw+zxXEZTv7V7i
         jAbnxwFzGvE8VjvLDRd6T9AFF4eOsUvsggj0uFdMXzQj+Hz++UqAXP/t/WVmvAAJB1Id
         0n5g==
X-Gm-Message-State: AOJu0YwitS+864/auCSpZ0wccVme8hBHHXPViSdTJV5WK/9e7D2z6JRZ
	+9CGiaB4qrNi0mB77tsx0s0rapXcrP9mRpS6LycXU84AmQrR+07ZST2Mew2TndEczSkF+YlrHft
	2ujOTG/JQsWji7ota/KPw2Yj5Wq+dj6AVdaLBvZYdXGPtHwOpC8Z5kbh3h6MXmQLN1NVYdnL8dA
	==
X-Gm-Gg: ASbGncu6pccMSal4IWjJ5USZqqXxXvBKH+3Ni/VSoKXdY8SVAv7l6iQi5e3gb/zk19c
	2DvWJheWCBmVLwkUlebgajc3FD0baa4oY29J2jU12ImH6pneV252EQfC3upyc00pvOQ4WMR1GIe
	M3y0XboF7IcZPJF1sf/j6Qnao8FJqNclU3O8yX9GogeahO7DJYnWgY+d6UB8NCMiQ5N0bqCTli/
	jaFknXQ5DmsLm0lUdXmDP78tpJU1L+aPTyIIcO5p6/xT0XwFQrWZaJfk1X56F2Z+Hb7oRlbEw9i
	I8Enf5bnFj/gaM6gUW43ouZqy9utcz+jslV1SPuWgF+agnwv+A==
X-Received: by 2002:a17:90b:5745:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-30a332f6c1bmr3095799a91.10.1745993139717;
        Tue, 29 Apr 2025 23:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhjcWpX4vZ+z4aH6FHg11dEcAiSDK7V05vXKXpqAj7i8rbUqH7RwyZyv3ZWoepwlFqcsT2qA==
X-Received: by 2002:a17:90b:5745:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-30a332f6c1bmr3095752a91.10.1745993139205;
        Tue, 29 Apr 2025 23:05:39 -0700 (PDT)
Received: from [10.151.40.150] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3471ef7asm714076a91.9.2025.04.29.23.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 23:05:38 -0700 (PDT)
Message-ID: <57064b98-5950-4b9e-8d76-265e56127dd1@oss.qualcomm.com>
Date: Wed, 30 Apr 2025 11:35:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be
 installed in hardware
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <D9J8O65N947J.Y0LSNAOS0AYG@gmail.com>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <D9J8O65N947J.Y0LSNAOS0AYG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vKoiI2DGjBXCwRR2a28-U9q1ytSMCRgr
X-Proofpoint-ORIG-GUID: vKoiI2DGjBXCwRR2a28-U9q1ytSMCRgr
X-Authority-Analysis: v=2.4 cv=UZZRSLSN c=1 sm=1 tr=0 ts=6811bdb5 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=pGegcu6JArvtW7RVeRQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA0MCBTYWx0ZWRfX2jUkkosNgh/Q qh9OiLi/QmaT1NxlMCY4mgqPPN7LtxylF390grE2zQfqcfDoi2BmOZc4hS1qqKw3V1b+8IBtr5F kmSsO+wDB2mhjN5XTxUndpxH5GzvF4IQgC0B3DFoiOidsqy58PXeIcJlxSddIrAu6epUM9EbB8p
 /7H+7HgouODTuN9JTr/NptCbpPopgEnRpZ8x1YGbw6DklZMHWgZgvkxi5j/vXQPlTqgks1XFXmu 3EXzf4KQ3zg9qO29gpxYVZZ1A44yYhzyKnTHlNuBDni/2mBVuih1+y+SQfq6XMWsN7kVZOIz+PD cN8H1KBIELIEubSzkqoAyhmdXQkruhjtEgR+afjswhk+AT7C9Lj6ZME07S3twMOQntk6MRDTfNw
 Q/Il9yQAdUpM5fMEFkrzzOZTuq6mYHc6nXMASLE53jOzYLxnLCya03Zgu6BPQe6iW088rCSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300040


On 4/29/2025 9:17 PM, Nicolas Escande wrote:
> On Mon Apr 21, 2025 at 1:47 PM CEST, Karthikeyan Kathirvel wrote:
>> Install beacon protection keys in hardware for AP modes only if hardware
>> supports it, as indicated by the WMI service bit
>> WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT. Allow keyidx up to 7, since
>> beacon protection uses keyidx 6 and 7.
>>
>> Control this feature by setting bit 0 of feature_enable_bitmap when sending
>> the WMI_BCN_TMPL_CMDID command to firmware.
>>
>> Check for the beacon protection enabled bit in both tx and non-tx profiles
>> for MBSSID cases. If set in either profile, enable the beacon protection
>> feature in firmware for transmitted vif.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
> [...]
>> @@ -4964,14 +4994,6 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   
>>   	lockdep_assert_wiphy(hw->wiphy);
>>   
>> -	/* BIP needs to be done in software */
>> -	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256) {
>> -		return 1;
>> -	}
>> -
>>   	if (key->keyidx > WMI_MAX_KEY_INDEX)
>>   		return -ENOSPC;
>>   
> This hunk seems to break station mode on QCN9274. Maybe on WCN7850 too ? I see
> that it was not tested against that HW.
>
> With that hunk I cannot receive broadcast trafic sent by the ap anymore.
> Generated by a simple "arping -b X.X.X.X -I br0" in my case.
>
> Replacing that hunk with something similar as what is done in CLO [0] seems to
> fix the issue:
>
> @@ -5575,13 +5605,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>   
>   	lockdep_assert_wiphy(hw->wiphy);
>   
> -	/* BIP needs to be done in software */
> -	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256) {
> +	/* IGTK needs to be done in host software */
> +	if (key->keyidx == 4 || key->keyidx == 5)
>   		return 1;
> -	}
>   
>   	if (key->keyidx > WMI_MAX_KEY_INDEX)
>   		return -ENOSPC;
>
>
> PS: I tested that with firmware PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
>
> [0] https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0/patches/ath12k/726-ath12k-add-beacon-protection-support-for-ath12k.patch?ref_type=heads

Thanks for catching this Nicolas, will check and get back on this


