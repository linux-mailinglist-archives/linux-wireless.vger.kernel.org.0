Return-Path: <linux-wireless+bounces-30400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC082CF9170
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08FE5301D94E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B1339B30;
	Tue,  6 Jan 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sf0H6cqp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IykGjSoR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8233985D
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711930; cv=none; b=rSG+eZVlimszwbbfpw00QUpcNUmBkIj85PeQLioYQhMC7bzBqCe4Xlw0gfBVE1YXUrAYuqncVBnbHZKZbxc3eLd4Ic/7+T9LjhTW3junJtLiqFyrtPx4cwDM366/K7BZLd1d1044LwlSnVi+ytM/Snq1exzAeRE27M11KWsxoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711930; c=relaxed/simple;
	bh=Z2vVwRiPo0gEoYXTZH4t11wGN/Tn5JozwEyw1oHDH8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5qQCNw8KCEs9BWCdC2C97ahkjhky24a13VHKDSOnFita6LlZMNJlNSF0NWrG8Hp1Vx+d49DdfjwmYpJhWw8IqnnbyUDbdibO7HLP7FDPbzJzNTBCOFsqhJNLTaCN4xe1UemBOrw6XvybMQIPwLwBZDjsuQcLXzCeQP6fAwomhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sf0H6cqp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IykGjSoR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606AFmcU3271888
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VEBV7n97ph8tbccL/nG4wraJiTrfV/5iBUEwTycIVcY=; b=Sf0H6cqpruxQ+NJ2
	qN/rdGkYCJoAllca1t1EV5OfocDSzvn7izD/F+pPLV7EOyb0kz+hxdWfPQi++Mzn
	vVq8APsY0YHKW6eQldoLY9pA/jpnlAtUAjb+kXlEUjwgCijkoyDsBmfN/b50KBVp
	ezz2TPJ3PWD+qssPWVusVg/NIMusZ1IotOjhjJsL7LH67LWFNyhXmF/jawNSAWz8
	cjaXrWEFSmu33RPdzHYHBG+mh2SrqZZtRo3pbJXdzwzbvfUTanNS2O9vVCe2SLtK
	KNyXck7z+6soUVR9mmPFVs2G90XPEqDiuk4BZkMI9piUEW95ao7uBawo6+5s8sOB
	Ujgjvw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv03p62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:05:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso1680107a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767711927; x=1768316727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEBV7n97ph8tbccL/nG4wraJiTrfV/5iBUEwTycIVcY=;
        b=IykGjSoRcklBDrHtV3V+iy03ZkF9hKJczuEpD7CssZOI2qJU2xGW0jUwzXQJKmQFFQ
         rq7MMDT9YAm6St+YfdfjDlLqjbxtez9d2CJDYU0jdDHN0OvniannBpoDOrTSESJAjlrt
         +cgZCIdMt6wyDMTMZgsHyENjgV22V3JWsse0SkszRSRjqHR6B9F3AvsgzmABXEzfOqIm
         N4xx+FjkuR3SUMUCRwW0de2ISqcNVDBOsaYLGwvgf2084scCZ7dgPyPE8eNsIP0R45Bu
         2pHYDHgJvpqk1QVczO3Qwnof+6KYNVdhvplkqwjx+cYA6CkxUtwXr3Wq+85m3eHGdLGI
         FGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711927; x=1768316727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEBV7n97ph8tbccL/nG4wraJiTrfV/5iBUEwTycIVcY=;
        b=d2mLmUsDnRhbjlBLVt7vLXgHPfuFwlRj+E0dT7+L3stmBxUHcn3NnI2vMUXACFA18+
         rQWVyf1jlnYr6k7GCNaOHBwY1+6CqJ2nQ7qfLmmPjjLhPXChIAZ2KrtU1ljHeh/xPiRQ
         Pzicn/k0C+F8Aqr2xqUr4ye7yX/0a94cA0/RI7wfYiVsOrHVxL+wYjVKJBT+t5Navurq
         qNKSVcmZsnC3LLli5Mjk2c3puFVqQ/vJc6hIuhdNtIusAhC3a8AjMft1WYTNZ5kH2cxo
         67C/H+oBQ3Pzd81JCKnEsFG4FiD8Oq35ADm9Ta0DyU8jey+DZOWdwVL+LiINrLUACk/S
         FIIA==
X-Gm-Message-State: AOJu0Yy95poVYcVNHX46vkwI06xe55izmEaZJNCKNhhhYkiZUUz4DgZB
	PaG4fm9Y0FEQ/MDoHd2zv2lQ5UhpxRDq6Yhk4B0myZnzja4gzX2SadJwxa9gHUtrAES1LXpfWxG
	aB+aGH0Sr/lO3PWnNsIw6SpvtWO9DTY0yKPEoCRJJOX6s0cvMdgYyoZzJ6bbFBvUN9RIk7w==
X-Gm-Gg: AY/fxX4hKYwDvG6CDc6AeJ5J9f5beaykE+l6Fl0wU90XiTqcMiuuOvRQGPl1/6tHv0s
	Uw+LV/3EAqZI4scMLeqSx+NqNdnOjJsSMzilOizTgFAGqsFCUZQPfVyxdlhOmkxIfobfIbx2S+Z
	6Jkr5ulnSNgbrrQaiQlhv/jDQHTZe1OtTByAhpCw6coMMN2PXxY6px8vkemZ0LuRArfvYv0ht94
	aikoRDt7gP86JL6A9Nx37fmy70LaE9NM+N8FJ0x/AtZ6jwf+SeuENVlM4cQV5MQrty0HuR6n7XV
	hC/8P6wmUVtoXqA2kBL4D8a+Vb3mLPSJaOnpJj4p14UZ0a8IVDL2acvgYpg81LAB6+YORLB9bx3
	0ZSddStO2EQUcp9KFfD1d6mGpPJjlYaa8oJmD1Yzx
X-Received: by 2002:a05:6a00:a907:b0:7e8:4433:8fb4 with SMTP id d2e1a72fcca58-818830dcc64mr2817498b3a.60.1767711927318;
        Tue, 06 Jan 2026 07:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLd0FpgG+jvrAG+hzuzPoD2fxiwH5xRD5ySSy+bwZzVBJEK/TAo4ROfjJnDNVWcfTtar1BHw==
X-Received: by 2002:a05:6a00:a907:b0:7e8:4433:8fb4 with SMTP id d2e1a72fcca58-818830dcc64mr2817470b3a.60.1767711926779;
        Tue, 06 Jan 2026 07:05:26 -0800 (PST)
Received: from [192.168.1.2] ([122.177.246.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de6405sm2485070b3a.61.2026.01.06.07.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:05:26 -0800 (PST)
Message-ID: <2fab8d57-3763-4840-bade-24366b9e880f@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 20:35:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 7/9] wifi: mac80211: add support for
 EPPKE authentication protocol in non-AP STA mode
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
 <20260105072415.3472165-8-kavita.kavita@oss.qualcomm.com>
 <7092990c23a205543890beb4eb1e2bc96acbf194.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <7092990c23a205543890beb4eb1e2bc96acbf194.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695d24b8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ey2084AkhiuO1mQPI8bMSw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=X9DlPG6BI_bZMUsVVvcA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: rYDxkRguX8yNZ03YpsgOrq9b8BQkvPsu
X-Proofpoint-ORIG-GUID: rYDxkRguX8yNZ03YpsgOrq9b8BQkvPsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzMSBTYWx0ZWRfXwj3YDujwBzHb
 1FnMP4KSmyudfrBR2X4DvQf2SZKfKaMiD8y2UH0EwwH+1He6y0upfmgJapUdb7HbMz3iKvi2cnh
 +B//Tdt2lUQaDEFfqYoGCLBOSdAbeCttcOqMCOR+u9HE905FLWFllzpOUaa9vgyPMhf0JXOqhav
 bDCnsRE1eKdUpZBtJJ9OJiDGfSRN9vjA3CRTx7s5Q4j3iYJc7z+OI59n+jC8n33ustdUYHfRHi7
 nlwsK8UxLJu01htQGx/Pnd6f7epF8XAo7QRb2wNCqEzeBbq5YOHv2V0jBuS08tgP1eR4pc4CpqS
 sxqmJIkb0xSNgsPyltRUzrEOmxrbIFCb+ShYjO2TDUcfHaQ64UaKBDgzpP3rxj/vWcbs8/15HDM
 WFLJv8cMiWm3fpC9ZNNNoUbJlmQ0Vcbio16AopcGDjroWD5lSs/oin/D4g7ppTFJfA/GIa7g/gE
 ibVqGMONoEheagTq7FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060131


On 1/5/2026 3:47 PM, Johannes Berg wrote:
> On Mon, 2026-01-05 at 12:54 +0530, Kavita Kavita wrote:
>> For EPPKE authentication, the Multi-Link element (MLE) must be included
>> in the Authentication frame body by userspace. If the MLE is not
>> present, reject the Authentication frame.
> Is this true? It seems mostly orthogonal whether or not EPPKE is
> enabled/allowed and MLO is actually used?
>
> Clearly if an MLO connection is requested (we see this outside the frame
> by including multiple links) then the MLE must be included since
> otherwise the calculation would be invalidated, but if an MLO connection
> isn't requested, then no MLE would be included by mac80211, so at least
> in theory we could trivially support that, and I'm not sure I see why we
> wouldn't?


This restriction is applicable only for MLO connection, not for non-MLO
connection. The commit message did not make this clear. I will
revise it to explicitly clarify that the requirement applies only when an
MLO connection is being established. Thanks.


>
>> @@ -1103,6 +1103,9 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
>>  		   !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
>>  					   extra, extra_len));
>>  
>> +	if (auth_alg == WLAN_AUTH_EPPKE && add_mle)
>> +		return;
>> +
>>  	/* 24 + 6 = header + auth_algo + auth_transaction + status_code */
>>  	skb = dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LEN +
>>  			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +
> This is also kind of a bad way to "reject" it, it doesn't - it seems to
> conclude but then doesn't send a frame so you get timeouts or something?


I added the rejection check here because ieee80211_send_auth() already does this for
other cases (e.g., dev_alloc_skb() failure). However, you are right about timeouts. I will
move the validation check early before setting up timeouts for authentication. Thank you.


>
> I think should just really reject it higher up even if that means
> duplicating the cfg80211_find_ext_elem() maybe.
>
> johannes

