Return-Path: <linux-wireless+bounces-32039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SRcAKyuEl2l6zgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:44:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F392F162EC6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328473017268
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 21:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEC7306480;
	Thu, 19 Feb 2026 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlkat/cm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="caImtUaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798E2E0914
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537448; cv=none; b=A9f+iaZALnyZ+A5FUZ40OmwmCKzkAVkRF7ja9HvuSWJsK8cEI8qFa6dXxgO2uRwCHatsd95bZ9ahE02jql5JB+zih/JfeNtDWVEm1BdwYACrH8IVsRWA+Jt65g9uA5IjU/viGK6hPrUgtZClcWQ5D8+ACOmfJ/DMp9lEq+lkDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537448; c=relaxed/simple;
	bh=ZlOrV2pSi6YWEAnFVhnd2cu85Us5/507/mieXYSeFMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TC6nfWmfXR04Y7Fg+FIxGEm01JrgzYpRM9thQNXK8kqCZdoQTau0vPL3fgs4/Vi8Kz6R1MK6E5OGraBOAzaoyFrpfBVjiacxpo2WVWpnEtgtzqwrx1lnxPkkjA0l+K6mxTiHVm72Az0wRkyIcXpdY80Bs9MupBKd/9z2mNJQE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlkat/cm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=caImtUaU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JKXtmH749381
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 21:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J97MP10b8g6XezEUSafkGrHBfJnrIsMKu0FinG57RvU=; b=hlkat/cmrzHHmYWj
	iJtbXRVm6Ycxei5WA9RNRb2hLmBscVZvelbLhFcUWG3jcBroQWScAPuBUSsQRFwy
	ivFUxgf/5MqEPjFC1yvJ2vDJxFFuByLQyLVCrwkK/0dp3CuGlZiYC5XQWJpuxHez
	rr8bKwYwyNR6YMxiuG7Zs0/5ackuOowmLYrgiSxsRB17yxYOV1/LOO3Q86Sprucd
	KNciJ/EeoCy3akequmcWm3JnyrciKXGNNMS6rnJVAE6o80uyInJWMOY1yPhwjOJ+
	SoiIP2xOgPMSi5oPmumJYtvcl3MIAtM+bVXdK98Yl4SHG4zvRqGTVsCfgXliK7tU
	1Mw3OQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce9ng85h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 21:44:06 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124a95b6f61so24494457c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771537445; x=1772142245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J97MP10b8g6XezEUSafkGrHBfJnrIsMKu0FinG57RvU=;
        b=caImtUaUFFJO+5+aRH+0kD30xyXSmRGekk46f8eYUxypLWtF2Io0Wm6XZekPQPPaFf
         OnPSqYcbO7n4It25gjS7048lpN4BqKuFvRahZ2yIeLeugqqwwDwn3ZtZr1zrGosAMtRl
         psVedahQnzftTAnQ1gPvLNTRd2PFb4vAnIAAX1XF1XtlHzIovJYwVImohE/+AiA7kEBo
         kpwLpolk5uIwumRFDZOyEFP9svMumHrgGuE/oiV4rroeeURt7Lmv9GAl/K1Au8mvmnn4
         RCcsMuw9fffzRPgWnC50ojShWGJloK6uQBt6llD7leclM0568Aj6u3yK6T23i98LOsWQ
         hqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771537445; x=1772142245;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J97MP10b8g6XezEUSafkGrHBfJnrIsMKu0FinG57RvU=;
        b=UNhHtsI/dHpZJJrVDiIyZHH1w4Wg6J7SfulNazg3xmnbyDGaT8CC41h8EdPzFO1JwJ
         g+lKJqiieW0yK8pBuWRsmBiJjP7IGGOq5GWi20nO5upv3+yg1hMNUEQb4JM68MezZe+9
         P/CpzYWG285Tc1YRYvywADIv8RFbBEvMLsWBUz32usvcbvKlD7L9aRCldJMgf0AEObft
         RaRd45SDl9zim4paI5bjnleU7zMcq5aBICun0jQY+tsAaTQly3vUD1/JdXUnJ1H3io+8
         UB5rUPGjrBdQqg4BUt0txIG6xabGgF+nT9C9BhU2mvLQcnBor6Y92BW52KM7Ez32aji4
         nHDg==
X-Gm-Message-State: AOJu0YwuG1WeB9bZkIuYAK55ZOmur1grcY/Z3ANcd1IslCL/RH1J4xi4
	3pTMToKNH6nzpYDmpWGezkVza1SuPQnx5aPH3D6L13+BpdrtbxflEWU4mUFzl/NewHM7/x5U8cm
	31/BVXCBUwpJ8S9ATlxfuXJ1CQJIyyVZhCnvR7JOArxS1qad1YemT9CBheHLKFQ4ntXg3LA==
X-Gm-Gg: AZuq6aI38GwmDhOKAto/ARmetOqDd6uTHgvdd+6C0l7mwMCw8Wln3RfU+PR29qPFkxE
	ItwcID5Bva4UoXgfy9Hipjk/tLZp/Q04RyZUBz4aV//GLIomJdg5u9uPzUv+ugJBLL4U0ctyTPN
	MXpGOF/uJmnnv/QhDFniuWikDziNRPIJeHDSMcNYGqy8J7fSlrJD8eDERs0wsMZwG/v7ltFxnZe
	MFqFdZGXlfMNdbN9E8XwUBLmCNLYTP+rwVX3gTR5hkEL02fku5dxS52WoP7LF3whp4G5aAVeQJS
	8YhpJ2ZdN7YncpqAMmG5pA/E636SlaR9BRWj7RoAbbD2Oo2kzrufNV95zbruLUI2sHKNxgUzeQ6
	elk9misrxlZbk3OR5ZX2MqV+d3+hNB9QDIFVjqNrw7a9YJi35Dp48lodhyfYpqzViFRrKYtSzXX
	SoohFRn5B9rbERFA==
X-Received: by 2002:a05:701a:c94e:b0:11b:9386:7ecd with SMTP id a92af1059eb24-12759a93e0dmr3760114c88.42.1771537445269;
        Thu, 19 Feb 2026 13:44:05 -0800 (PST)
X-Received: by 2002:a05:701a:c94e:b0:11b:9386:7ecd with SMTP id a92af1059eb24-12759a93e0dmr3760092c88.42.1771537444621;
        Thu, 19 Feb 2026 13:44:04 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc83e6sm23579410c88.15.2026.02.19.13.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:44:04 -0800 (PST)
Message-ID: <6d8849c2-a58c-4aea-863f-6e4c335ea4cc@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 13:44:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE5NiBTYWx0ZWRfX9urWMlRKHzFC
 UShPfmxMuUrXaTwUgOptNMQ48ywhKJGgj/pC+uHvsk5c8sEEk4o0NHh4AcfQsv2t8/3vEJ56rCC
 ksJvpZUK6bP+X3kxRzx9Qp9aqSg0Dpx0tDB+73w/me0h3XUQXhEUmXy8lrAAWMKESlxUoSTV7N/
 4qyREdvafHuWvOptvAJ8wOGfa9UZaztD3pTRZbKDjEj0axi9TEl6Z16Bny6GQpaNx8T3eDm5DYj
 8yhox9xTJAyJpYr2unvTiJMftE/EkSd3/17HWK75pFLVn27FZv1TQX5m1LqJTMKg0DplYEMSnAE
 6CNfUvaAISB+g7PhyNhO+g4lUfxOmQYN4pSfPmZYH7SIFau1Yx3aofesDDLSuvU6/o6/lpZngBN
 c+aCkVTFUWbtY7chpkBv6wmw7I3WTC7tDxPCiljK257yB4kjKdsvFymZtSaVgZ+4Z7AkmGXAqGv
 CmJcV4/VoqyFoDeR6rQ==
X-Proofpoint-ORIG-GUID: dvG1GR8l79nLk0fKrx60dXGcoa63D9LZ
X-Authority-Analysis: v=2.4 cv=Sbj6t/Ru c=1 sm=1 tr=0 ts=69978426 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=3NmSqTEJfTEM0WOFm6UA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: dvG1GR8l79nLk0fKrx60dXGcoa63D9LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190196
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32039-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F392F162EC6
X-Rspamd-Action: no action

On 2/18/2026 11:34 PM, Maharaja Kennadyrajan wrote:
> +int ath12k_thermal_register(struct ath12k_base *ab)
> +{
> +	struct ath12k *ar;
> +	int i, j, ret;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return 0;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		if (!ar)
> +			continue;
> +
> +		ar->thermal.hwmon_dev =
> +			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
> +							  "ath12k_hwmon", ar,
> +							  ath12k_hwmon_groups);

ath10k and ath11k use devm_hwmon_device_register_with_groups().
why doesn't ath12k do the same?
then the code below and in _unregister() that calls hwmon_device_unregister()
would be unnecessary since the objects would be reclaimed when the dev is
destroyed.

> +		if (IS_ERR(ar->thermal.hwmon_dev)) {
> +			ret = PTR_ERR(ar->thermal.hwmon_dev);
> +			ar->thermal.hwmon_dev = NULL;
> +			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
> +				   ret);
> +			for (j = i - 1; j >= 0; j--) {
> +				ar = ab->pdevs[i].ar;
> +				if (!ar)
> +					continue;
> +
> +				hwmon_device_unregister(ar->thermal.hwmon_dev);
> +				ar->thermal.hwmon_dev = NULL;
> +			}
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void ath12k_thermal_unregister(struct ath12k_base *ab)
> +{
> +	struct ath12k *ar;
> +	int i;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		if (!ar)
> +			continue;
> +
> +		if (ar->thermal.hwmon_dev) {
> +			hwmon_device_unregister(ar->thermal.hwmon_dev);
> +			ar->thermal.hwmon_dev = NULL;
> +		}
> +	}
> +}

