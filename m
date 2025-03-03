Return-Path: <linux-wireless+bounces-19700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E8A4BC85
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2537ABB78
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D9101C8;
	Mon,  3 Mar 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYZz3cGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569501F1905
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998112; cv=none; b=Q5bvM2BtNypqoCCuGrdXO8kc/bt+RZvzLuCnW704Z5nCTmM5u9kIXSPz88gGwNnTNFXvuRbqpM8e290daOzvu1HeGd7wfHEQ2wOoQcbYlacy7hqGwFh3eoCGMd5/IjtskJCnc3CQ+G2rXfP8UvMFzxVYet2DUJRrgwQdHP3DYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998112; c=relaxed/simple;
	bh=eXqvsedChMdSEDedCzdTL2VFTLdkePXoCfqP2++7oY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4VEjxp9XoD9y+87HLiKGWUGn7TDG20k/O163AMP5h7TmwzVdYOb3+KJCxIALU6NfEoLA2U65QAJmxp/8ztlhi5jjXUkl4j8YD7wbwHhwDUpLiEf/cM/UARYpMtcrbLSujhYbGwBB8f35jw/GHdf5p4RVvtRt/916dtlJ0lcasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYZz3cGQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523A51sX003375
	for <linux-wireless@vger.kernel.org>; Mon, 3 Mar 2025 10:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LNyPo97UPzZvF9mMIrMk+0mEIwcBZ7EcIK3SHWW2Nic=; b=LYZz3cGQ/yUSo0J1
	Iv2bG+sk9MnPwrl5YeECMBQsHzqtv1MeUqx7yYZrHVOdmpmwjO/y/PsHmmW76lXj
	5EOL8fGG+Ud3tv0s5/Z/lmgu4RNZboWyAL3b3g4b2XOjXYQkf642v2zVedB6jEjI
	Yg30E/xCAzgCjeihmnhfdT2jam44Ck36Hr9Yh+Po1xvWYPoACtP9DCobLqVGpTwZ
	YwPs7/A5tol/WbEqENqU+UOvpCHbt5k7FEYhN4kczc/DLugVC/oq0YX0+6fvGrNO
	agkwD6jo7Asc3RFu3B0lkGX0AYHOi8Bb75t28XutQmiB7usYYbIBQOM2o9Rs9uAw
	wx93rg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88vmsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 10:35:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso8626900a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 02:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998108; x=1741602908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNyPo97UPzZvF9mMIrMk+0mEIwcBZ7EcIK3SHWW2Nic=;
        b=Na8uJ0AkJ+V371QqgEWNN0+rbcR/liLZ2F56cMl5T2BgSQaLVUojc+0SFAxepKsDV+
         F4GSmO+mhtTYXlhIygSNvLCJBVpowbgF7YfJJrz8y96ngpfbL9jyNLZarSUtLgYwNVpG
         dY/k6qebV5f7i54YFdSQcnCvQqc+wr0Ab0UvnF9i6Z22+SUC4jiF9yRHFD4X4yY0VZMp
         hB3wFArxVe958e7p06gMEclS8/oyK6u8dS+YwSICPDAYgtZVFIMXBNkarh2CRttzsibJ
         4/GuaWjA9v2y5fTvHtpRM6ekD3aDP6XpNYs+88dYBiArDB5p1FtqF0qWvTgS+DmE0y6K
         UwEQ==
X-Gm-Message-State: AOJu0YyOg9L5gqQeRMvs+bMPtgsByzqGnMpz1+XbtLIK1C1VRGMIFIhI
	aIsg/DkPLl3LODOndmvQw3mAdimm0f3s99lpQjND8bh1WujPT69xs/jD8osUS9Cg102HWCwwyjB
	CKF/P6J7jaQ7y/NRP1PHDfD4Bsq8cecVlwnm7V7Eb6zKNRsyaspho147H6GRbsexLCDK+Q9vMRA
	==
X-Gm-Gg: ASbGncvv8SUjXPfYMqBVyJYZXHnkq+nNmPMbioJoMVuD2hqxHqQDZQ4xVD4FfJUsWSG
	BZT4Z/2vRQ41ystS9tWWhAXPnxAb4ZvFxiTNJRjGpEjv1AynhEPtM0o+DL3kcfFO+k7m8Io6MC5
	sJ1Tt/SP3gt2vBdokdk7F78Qw38UiP00kDy/DZbbv5Ck+m1DY4DkWYB/o0tj/e+rxYMHcs83INz
	C/xaY6x+ABcHkJgdxVQrApROm+fOQMEoFF0bKP+Q92pNDNq0vTJTtl7dO9uoeAhQj+beUSkwd1G
	DsMNz/Aa9x4jC3k0hCLwWmE7EktfaPGKcFutY3XXgwQ+JtfSU+BZmjar
X-Received: by 2002:a17:90b:1801:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2febac065cfmr17159587a91.32.1740998108242;
        Mon, 03 Mar 2025 02:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQV5vNMKSgyQo4Pt6OgzKlyznzJfawE26+KhJqccz79x90AT0E94qyC+Ud7Wq2VNghW2BCFQ==
X-Received: by 2002:a17:90b:1801:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2febac065cfmr17159569a91.32.1740998107885;
        Mon, 03 Mar 2025 02:35:07 -0800 (PST)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98d8sm10632336a91.8.2025.03.03.02.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:35:07 -0800 (PST)
Message-ID: <dbb750cf-b931-4ab8-876f-36e4e5e3bfb5@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 16:05:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: ath12k: update EMLSR capabilities of ML
 Station
To: Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
References: <20250117170416.2907530-1-quic_ramess@quicinc.com>
 <20250117170416.2907530-4-quic_ramess@quicinc.com>
 <cb41175353348bbc56791c3bb0c38a42ac4fc6d8.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <cb41175353348bbc56791c3bb0c38a42ac4fc6d8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iZGnfh9B4GWeVHH5jJL5sYALVqJ8r8AS
X-Proofpoint-GUID: iZGnfh9B4GWeVHH5jJL5sYALVqJ8r8AS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=667 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030081



On 2/28/2025 6:06 PM, Johannes Berg wrote:
> On Fri, 2025-01-17 at 22:34 +0530, Rameshkumar Sundaram wrote:
>>
>> +static u32 ath12k_wmi_get_emlsr_pad_delay_us(u16 eml_cap)
>> +{
>> +	/* IEEE Std 802.11be-2024 Table 9-417i—Encoding of the EMLSR
>> +	 * Padding Delay subfield.
>> +	 */
>> +	u32 pad_delay = u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
>> +	static const u32 pad_delay_us[EMLSR_PAD_DELAY_MAX] = {0, 32, 64, 128, 256};
>> +
>> +	if (pad_delay >= EMLSR_PAD_DELAY_MAX)
>> +		return 0;
>> +
>> +	return pad_delay_us[pad_delay];
>> +}
>> +
>> +static u32 ath12k_wmi_get_emlsr_trans_delay_us(u16 eml_cap)
>> +{
>> +	/* IEEE Std 802.11be-2024 Table 9-417j—Encoding of the EMLSR
>> +	 * Transition Delay subfield.
>> +	 */
>> +	u32 trans_delay = u16_get_bits(eml_cap,
>> +				       IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
>> +	static const u32 trans_delay_us[EMLSR_TRANS_DELAY_MAX] = {
>> +		0, 16, 32, 64, 128, 256
>> +	};
>> +
>> +	if (trans_delay >= EMLSR_TRANS_DELAY_MAX)
>> +		return 0;
>> +
>> +	return trans_delay_us[trans_delay];
>> +}
>> +
>> +static u32 ath12k_wmi_get_emlsr_trans_timeout_us(u16 eml_cap)
>> +{
>> +	/* IEEE Std 802.11be-2024 Table 9-417m—Encoding of the
>> +	 * Transition Timeout subfield.
>> +	 */
>> +	u8 timeout = u16_get_bits(eml_cap, IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
>> +	static const u32 trans_timeout_us[EML_TRANS_TIMEOUT_MAX] = {
>> +		0, 128, 256, 512,
>> +		TU_TO_USEC(1),
>> +		TU_TO_USEC((1U << 1)),
>> +		TU_TO_USEC((1U << 2)),
>> +		TU_TO_USEC((1U << 3)),
>> +		TU_TO_USEC((1U << 4)),
>> +		TU_TO_USEC((1U << 5)),
>> +		TU_TO_USEC((1U << 6)),
>> +	};
>> +
>> +	if (timeout >= EML_TRANS_TIMEOUT_MAX)
>> +		return 0;
>> +
>> +	return trans_timeout_us[timeout];
>> +}
>>
> 
> Some of these should probably be in ieee80211.h, and also - making a

Sure, will move all three get helpers to ieee80211.h and use it in driver.


> table of shifted values? That seems ... awkward at best?
> 
> static inline u32 ieee80211_emlsr_delay_in_us(u16 eml_cap)
> {
> 	/* IEEE Std 802.11be-2024 Table 9-417j—Encoding of the EMLSR
> 	 * Transition Delay subfield.
> 	 */
> 	u32 trans_delay = u16_get_bits(eml_cap,
> 				       IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
> 
> 
> 	/* invalid values also just use 0 */
> 	if (!trans_delay ||
> 	    trans_delay > IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
> 		return 0;
> 
> 	return 16 * (1 << (trans_delay - 1));
> }
> 
> seems a lot more effective?

Thanks for the suggestion, will remove the lookup tables and do direct 
computation.

> 
> johannes
> 

-- 
--
Ramesh


