Return-Path: <linux-wireless+bounces-23136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77834ABB3A9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 05:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C687A86B3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2F19DFA2;
	Mon, 19 May 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHSHMJyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384428E8
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747625815; cv=none; b=Pb7HOjFcA+SMiF+s4Ih3xetWnWxiy9Lin2HwwYVXgucIf5m5xv8asNWIKstva5PywjnyLcaaSZ/4QxmMrZbgGT0NEXgsfL7BkzXlplSKzYfubGidY7Ky7fbupcNYTjPvLv06/8P4IbSaa8C0vLI3kd8JlaGblh+SZDQnq7lgDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747625815; c=relaxed/simple;
	bh=+j6EBs9boEMy6T/SiUZuDEYwA2ml5wGmx9Soj+9D5jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVSBLgAtd7w3NuSc0UJUOZfWATukDx8F8y6smCfXG+nrEwfxeFZAFwiesg9RIivJGmUbNGiqNYrRQ5bCZmCFkZfT59BcF6wz/102WHuozwmN7PRUTaSdH3ZhNosjnfz/786fWV/QwGOanEYDVZtu29t6Q8qZ6uRUraqrRwB4aoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHSHMJyL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ILhYAl031155
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 03:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tx0z0Q+vLmuOiYnj6uOJoIt6Cok2EgqKjloGkG4l+J0=; b=QHSHMJyLtqRrDCOk
	hNm2R7wzonYuyA/98ozd/q+MZs6aT3Cec7KgVOZrcgklgHYXb8CtMm66kidp8KDE
	9FeIRAux415YRpr9srEo0+bllseVO/WY9TTX6TMnk9WbSV3WZ6CHwjoG7fwBLDCW
	XAy/kmZ7Jq/LlhPwMzEviEvu1a30m0ywkhHKxngxsyNixs7GPQqVXC+db6tfzLuF
	NXB+LMyHKpz4j1pQUWhFEGTyI4vAT1gM4/augDhvtkRPDyylZ8QRRd6bnpXC2fn6
	xCyIpdd6lnFWLvRhzDf4aDG8mJ+8DNcikMnAPdZtQUcweD2XJSLLvVh+TT6y4Xwl
	oCiuTg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjstwf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 03:36:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af9564001cbso2542623a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 18 May 2025 20:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747625810; x=1748230610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tx0z0Q+vLmuOiYnj6uOJoIt6Cok2EgqKjloGkG4l+J0=;
        b=uViRKkKELyK3gZeq33NUUY9ipSqmUUBwgOfTTGHTbQCvq7tZGtRfnWDfv+H3bflh4n
         LLA5fbX/sOeSqLn/VnTjTFSINVX0nHSRbnz9dlGZ0cATzlEPO5J62pio0hAYMD16B1X6
         u8axeKK1UB6nOr4GzMtPeAhHIHFH6tk/qRZbTrP5Eu2zubo/btU7bA1aPj18x8NTZu6c
         GLggxkm/qXaQ5sQjbXyqkgT9Q1H2fvwWvmDwOp5kUF/nMPz05kRMpEjkUFby1lUE3AbM
         5oD+rKp/pL8jKvgMY2TReLq1OhJF9Tj0C9l1lD0bmt20y7oX8qcA1v9HRwYGrZUPRlqR
         NV+w==
X-Gm-Message-State: AOJu0YyUl8xRhoAusyM/Un+fohxEa22DGGIhtrcg02Q11Cj7IIg75LSz
	kyQIdwJpSn0Reybs08Buy1C1C684mrIkayilWCfC+EyKJCOJ/aFw5pggNJJTYvhU8BUjLX4yWFZ
	6AE7u/QkmYNTkGWt6z1/uvxzOqWshQo5MeqOv5x7SXSjepatV41YDVZ6GRiZ/0SqJet8tlg==
X-Gm-Gg: ASbGnctr2x3eX+MnfEgooS/jbJrz+uXBBCF2gZvLolCFBascLZeybV96/vEhcijQLbw
	r/NqcWkBLtKSBwze4V83ZGZ5pWIa5Xo1Z+o8phsdoxrUCQWDWFwm+tT6LKEIjN8Udek5LaPKn1s
	etXxbrhKL7UeCn7ZxKWd1do6rXxE0bNHyyLUJwXo+4anqaUaU1PazEec4SMba14IVHjAZ3dOrsh
	eLqMt+kfodGNdvujWPwZe3pftN3VBSce9yg+CD/rNlsTNwG8HmtJaYRePH3DW0mTkU7KuBUk7Dp
	3/Y+jPc48ZMlRB57qtq1X3naDZrC/W6DFdp45R8VKOGmwihQxY4I
X-Received: by 2002:a17:902:e5ca:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-231d43d5526mr156987415ad.9.1747625810511;
        Sun, 18 May 2025 20:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqFqvAF5UB+fVYD0ZWqXG1/cjzbqexjTAP1GVf7lSAi+RnISws1iZ9K+8/EIT9d91skpOCjw==
X-Received: by 2002:a17:902:e5ca:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-231d43d5526mr156987035ad.9.1747625810001;
        Sun, 18 May 2025 20:36:50 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97db8sm50068375ad.110.2025.05.18.20.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 20:36:49 -0700 (PDT)
Message-ID: <b4138c8a-5b09-4d17-9151-bd60d511aca3@oss.qualcomm.com>
Date: Mon, 19 May 2025 09:06:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: combine channel list for
 split-phy devices in single-wiphy
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        aditya.kumar.singh@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
References: <20250506105624.466019-1-rameshkumar.sundaram@oss.qualcomm.com>
 <7db2e4b5-377c-4d3b-b51f-290accc9ddd9@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <7db2e4b5-377c-4d3b-b51f-290accc9ddd9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: swcILO5EEvnNinKv28Bf7Vv1nV6ejcHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDAzMSBTYWx0ZWRfX5ZvcUmC438YH
 Ror8w79NYn2LbKqg5VEt2pCUZlClCEwsEqyrE6+Wk9BKLNIELeeuewX9xmv8Hy4+p8cf0aoplMd
 HGC9lz3Fb9ZKjr1nfut5YH+ZvqoAEjuAr24n4WlH0CHFK7CfBNdwUxhsssoj95nENqg2ToZv32t
 FdPYk8B2O+432PnhvgLUeYYqc7YvnhFzEX23UZ1L71lbvMoFV213wPl7tWfTO+FtoVaK3MM9UW7
 UeG9TUqusQVX5vrBT/UWJNk08vBlOVP5s39h1BspU6Lye0ShUBhhoIKia0WgCBDr3fbbJMJV9An
 rwuoGqATROy7xE1ZCFSulbiQI/cQzJQysg24zQGPpubSG+84UBmqgzR522CzADzRSVtnSPxKo5a
 xMw5TpT7EGmpZhiPw8oz3p8W+MzBYXm6xSDFOFj/cA4Vp7OBPnzLKYoaog57I2FVu6d95FP3
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682aa753 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mNHDvxWOCiuYGhU9H0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: swcILO5EEvnNinKv28Bf7Vv1nV6ejcHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_01,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190031



On 5/15/2025 12:04 PM, Kang Yang wrote:
> 
> 
> On 5/6/2025 6:56 PM, Rameshkumar Sundaram wrote:
>> When two split-phy devices that support overlapping frequency ranges 
>> within
>> the same band are grouped into an ath12k hardware (HW) setup, they 
>> share a
>> common wiphy instance. Consequently, the channel list (wiphy->bands[])
>> becomes unified across all associated radios (ar).
>>
>> For reference, the devices are:
>> 2.4 GHz + 5 GHz Low Band
>> 5 GHz High Band + 6 GHz
>>
>> The first radio probed within the 5 GHz range (say 5 GHz Low Band) 
>> updates
>> its sband reference (&ar->mac.sbands[NL80211_BAND_5GHZ]) within
>> wiphy->bands[]. However, when the second 5 GHz radio (5 GHz High Band) is
>> probed, it replaces the existing wiphy->bands[] entry with its own 
>> sub-band
>> reference. As a result, wiphy->bands[] always reflects the channel list
>> from the most recently probed radio in that band, restricting supported
>> channels to those within its specific range for upper-layer.
>>
>> Fix this by updating the wiphy->bands[] to just enable the channels of
>> current radio when there exist a radio which already has set it.
>> This will make sure wiphy->bands[] holds reference of first radio which
>> got probed in 5 GHz band and subsequent radio just updates the channel 
>> list
>> in the same address space.
>>
>> Since same sband memory space is shared between radios of a band, while
>> determining the allowed frequency range of radio, its frequency limits
>> (ar->freq_range.start_freq, end_freq) should be used.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> 
> Offline sync with aditya:
> 
> This patch and patch [1][2] will make WCN7850 update regulatory rules 
> and trigger scan incorrectly.
> 
> They are based on the design that one chip only supports one band.
> 
> This design will limit WCN7850 to one band.
> During init, WCN7850 will be limited to one band(such as 5G band) due to 
> patch[1]. Then will only update 5G regulatory rules and trigger 5G scan.
> If manually set country code by "iw reg set XX", WCN7850 will be limited 
> to 2G band due to patch[2]. Then similar issue will happen.
> 
> 
> If QCN supports multi bands like WCN i think you will have the same 
> problem.
> 
> WIN team needs to figure a new design for this issue to support multi 
> bands on one chip too.
> 
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/? 
> h=pending&id=b7544de8a2984e61b95c58c1c6c1e8ce659b1021
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/? 
> h=pending&id=13324cecbb2c390a11f1fbfe87f3a5e62d6e4591
> 
> 
> 

Thanks for pointing this out. we're working on a new change which fixes 
the frequency range marking in [1] & [2] for multi-band ar's, Will re 
base this patch on top it once it lands in public.

>>
>> Signed-off-by: Rameshkumar Sundaram 
>> <rameshkumar.sundaram@oss.qualcomm.com>
>> ---
>>
>> *v2:
>>    - Fixed frequency conversion from KHZ to MHZ in freq_to_idx()
>>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 93 +++++++++++++++++++++++++--
>>   drivers/net/wireless/ath/ath12k/reg.c | 13 ++++
>>   drivers/net/wireless/ath/ath12k/wmi.c |  9 ++-
>>   3 files changed, 109 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/ 
>> wireless/ath/ath12k/mac.c
>> index 4dae941c9615..23cbf348e836 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -4131,8 +4131,9 @@ ath12k_mac_select_scan_device(struct 
>> ieee80211_hw *hw,
>>           band = NL80211_BAND_6GHZ;
>>       for_each_ar(ah, ar, i) {
>> -        /* TODO 5 GHz low high split changes */
>> -        if (ar->mac.sbands[band].channels)
>> +        if (ar->mac.sbands[band].channels &&
>> +            center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
>> +            center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))
> 
> 
> Though WCN7850 won't reach here, but this is also not good for those 
> chips who support multi bands.

