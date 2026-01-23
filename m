Return-Path: <linux-wireless+bounces-31134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFh7C2vTc2kCywAAu9opvQ
	(envelope-from <linux-wireless+bounces-31134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:00:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 802067A6DA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA9B301808A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F674C14;
	Fri, 23 Jan 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gN5RKBzV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NstZaONy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DF2110E
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198440; cv=none; b=cbmQQlVT+XHZ7JvouNnQ1IL8paJIyv0V3ddpTL4AOc5Q4StdnYgGgxBBoPc2g8wfyPPYX5UTNj4hu271P3Q6Z/tEmXenvPMdGCYrfpdupMn14nR4GdRIW6AAIQxru3Snaa0tDUFf1fD3o3QBNeX5sc9gs32cOzDppbaUWhfk29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198440; c=relaxed/simple;
	bh=Jlx0WUmbJekTjTOeEJeeFJJlaXazbBEvr2ppCn2/164=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdkm6hDLk9LhG2IXah5yTp20Br5OSIy6xw06/LwSGxDmfGtP1IcUu6tRhnllMNHf9Tt3X4vFIM3lj2ItUbLAZzM1WVwCS9dCY893eK4nQfaSsZWZAUkaPmB6ki7qJGmRbhHaNl8o0KXXP58oRzGnwztliqZlLnuSXuYfmE5vUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gN5RKBzV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NstZaONy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NEWuBA1267903
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gDyH+uSnLK+cP5O1ogpRmYzwRV+wyY5WhSpAAjsjTRs=; b=gN5RKBzVaabhLmo6
	kmetNsqRIn0W3MDmb1E9hYwAZ/CnB8XlKXUJTswgbXQ/L0mpLBP4+e+MoiQMbeKh
	6GaA/dMPpIwbO8QFOdZnVCK64c5iRBRjOYtCejLKzvWkn3JbO+g2Fj2VGvO1oa+d
	QGrv/o/C3TeBk31B3gPFmIN8Lvwd5HzyaaVTqSk1asndJ6g9xE0oCW8SVE4u0Vmd
	RtWARwIdB62nJeQkEv11TJUj+umMo/amdQAGYgSAwnensNmUiNIVlNsDwqQ81c2h
	eoVzWMJHByDZ1+NvMh0Tu3F5O8J9UZImhIImqmBqTBmT25iixCciVjOCC1iXDomJ
	PtefSg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv4v9adwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:00:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b722bc1be1so7458408eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 12:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769198438; x=1769803238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDyH+uSnLK+cP5O1ogpRmYzwRV+wyY5WhSpAAjsjTRs=;
        b=NstZaONygzXrklqFaqREucf9tV/Ci686INLEG6g3LblScDqmazUCklM9HwrU/gMd7x
         CwvKQsEgyBHwrYfB8vezWskdEuY0PK8XltUTQwUYvh+A4/MBmXguyoEYkPVn2qxDdaEO
         ENulz21WGOiCnAUhNYe0HS2GmhqsGhe3/URafXrV2eatjBXNLDz37SeJwBi+n6qauETu
         dggWDZXJd815rYjYdPJkdgfoT1Wsa/FIbl+QVzoVGV9vPfGwVKva9KYB5V85ggGxnk8c
         VMUPHCNCyohaLVccQYEwXevc1e5f6ccOOSi4ubOjA6+yEcM5uyI9J6RS8lxigzBlDch9
         NHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198438; x=1769803238;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDyH+uSnLK+cP5O1ogpRmYzwRV+wyY5WhSpAAjsjTRs=;
        b=w7Gy5zo4jAej/86odGMU6GjMdejUaBEFvHXk7HverKaaUe/HS3pZ2wN6cIvuyIkOsz
         wlnnUNlNPtwahLUbj9lQCM8C2kpzw5oagNL45EbADCDPqsX40UQPe1NM0FWz+pMaNKF9
         1PrHxpDohvSMEz3Dcjpo843V6bZIEklFoFP+Pl/BWbplHspDYnumv7GpUaFGNFkrHux1
         u88elxHStRfkTYw8XCInYpEUCSCdohRvKQiebpwrlz1szGTfjsj+UPFl0J+Zqx1sD8xj
         oqMNQ8WGkYqNKRMEH8dYLlkEEx8JdoEbpvcpGvNXQUSDe9L4vHeFrv7q6StdrWAZrzCO
         xTdg==
X-Forwarded-Encrypted: i=1; AJvYcCXcKTFDj8z89fPOV9H+HSF4g9b/cnfjcE3sVXlNr1nCUZoAOVY1BXnM9hVU5OqE29Cl9OgY961NyzAsuPXUoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRyT0DJ8gm1spRUoDcuX7FgF8XoDh/rFWRkyVkF3HqtJvSiqy
	duwjWzVeoPt8V1lm6ANzuA54eQIcLMaQldfmVAuRIMq47tF1B8TTN0ktJzmPP55x1H4tS1F6Yfy
	aV+fqflNwKoh281NAHUFEFs03EJsLKPRBEcGyaGwHDC1aIqzsvBZD8/WRzRREzxuueYbWjw==
X-Gm-Gg: AZuq6aIJTqpDSndxvE0LWoPFv+5O13C03YGOetstTgiYSHcoDllAzmhZqFsdkOTUQoL
	0mhppgEeAX2gVW0DCfGxgQjCpc/P6S1MHSXZSn7jhtmE0eZtgL48Jpe3Od2CmPyX/RWYvgvn/J4
	/xmYJ6s9h4CKJ/NBy2ak4q2CvS5yu0blGrS44uLaIV/wfficloLMoevqBlZJD6K8c4Ou+nBUBOy
	XD/o8l4DVfUI2qGyo0HdnueIHmgQlWOqp0l5CnmRS6F3qQM0g/IgOdVUvKgAyWBq+pZYmnI3qm+
	vYYc6qifXksLC5PGsFSIuask9T6wD0U87aVzSSJb1waWksm+PfIp11olczYJ1TDHp6gACNEnd4D
	4qmMhRYqQCEnLouqBqGACg1m5PX08OZhTcD3TGbrCDx+COUv3p82hKEAgpKFO8hUq741tqg+dlz
	WD
X-Received: by 2002:a05:7300:8188:b0:2b0:52ac:92fe with SMTP id 5a478bee46e88-2b742853526mr1480984eec.21.1769198437663;
        Fri, 23 Jan 2026 12:00:37 -0800 (PST)
X-Received: by 2002:a05:7300:8188:b0:2b0:52ac:92fe with SMTP id 5a478bee46e88-2b742853526mr1480953eec.21.1769198437105;
        Fri, 23 Jan 2026 12:00:37 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b749e301f0sm1985587eec.35.2026.01.23.12.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:00:36 -0800 (PST)
Message-ID: <460791be-6a4e-4098-bc74-effd31c8c593@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 12:00:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 wireless-next 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20251216162421.40066-5-johannes@sipsolutions.net>
 <20251216172421.5f35a099e950.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251216172421.5f35a099e950.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -PbdGolidlRJr52wz7kv2HLXp79_yYtq
X-Proofpoint-ORIG-GUID: -PbdGolidlRJr52wz7kv2HLXp79_yYtq
X-Authority-Analysis: v=2.4 cv=H7TWAuYi c=1 sm=1 tr=0 ts=6973d366 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=TfF-S1yVhH2Os_iwlykA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1MyBTYWx0ZWRfXyuhPJaMUz4SX
 XgCsu4xLNy8pb95UdSMM7aKQlwvShBxDj+/tiKZwKqfLfdrMTbvmFsqMkzUfNVjETKeKB7UeOWd
 7wZuAYR9dpCFi9T3tL/nWPzYtsfAC1f+mArwDMWtE0DrHaAnE142JwTW/MUmtXoR65l/Jww8jK2
 DjyKyxbtpXcotw21fBOS91zrIOwiSbAhaxI2J3CSMNcDLKnmljV9Eyr9j4WiHDAvUZx2qZ7bVEO
 zXjKdPnyvOvPasa4aCFqTpu14t7naly6hfpfJmxllnf+Jeuv3fYQLejNZ0f7ZG+QIMpG28fM/ZZ
 orp1yRsX4Fw+B4bYo5o+58VRCPda2EiQguDZ7RiggK9cwz26ggCH/BTvAqlkJ4V2VNFRaaEiHy+
 c4RTmKtAQGC0wsLSHCDQWFCjtVDB4CG3VPULg/c/gw6VDWZRGY6Lh4TY+Nf9rDa4zJ3bAbEfLvd
 IOxvz4ATjoX1G5iMwOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31134-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 802067A6DA
X-Rspamd-Action: no action

On 12/16/2025 8:23 AM, Johannes Berg wrote:
> +	static const u32 mcs_divisors[] = {
> +		[ 0] = 102399, /* 16.666666... */
> +		[ 1] =  51201, /*  8.333333... */
> +		[ 2] =  34134, /*  5.555555... */
> +		[ 3] =  25599, /*  4.166666... */
> +		[ 4] =  17067, /*  2.777777... */
> +		[ 5] =  12801, /*  2.083333... */
> +		[ 6] =  11377, /*  1.851725... */
> +		[ 7] =  10239, /*  1.666666... */
> +		[ 8] =   8532, /*  1.388888... */
> +		[ 9] =   7680, /*  1.250000... */

you probably already know this, but checkpatch doesn't like the first 10:
ERROR:SPACING: space prohibited after that open square bracket '['

> +		[10] =   6828, /*  1.111111... */
> +		[11] =   6144, /*  1.000000... */
> +		[12] =   5690, /*  0.926106... */
> +		[13] =   5120, /*  0.833333... */
> +		[14] = 409600, /* 66.666666... */
> +		[15] = 204800, /* 33.333333... */
> +		[17] =  38400, /*  6.250180... */
> +		[19] =  19200, /*  3.125090... */
> +		[20] =  15360, /*  2.500000... */
> +		[23] =   9600, /*  1.562545... */

(yes, I'm running your series through my automation since we are vetting our
additional UHR changes on top of yours)

/jeff

