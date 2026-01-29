Return-Path: <linux-wireless+bounces-31337-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGPdAPaWe2nOGAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31337-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 18:20:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B19B2C42
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 18:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D57AC3005AAA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784FC1B4138;
	Thu, 29 Jan 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoQ07cAI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJrjf6nt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AF2877D8
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707251; cv=none; b=k0h1tsLhEgM1Kn/oTVmwbwBZgg8O3Yn30dSPTbIzLn+MvR8pCMETg6y77f8A/V4DEgBb9Jea9K7r9EknQ52p+U/dRlmQdDSmvE+YmSxBtnq7QGOrKwng4+xawfChnwPUR4pwMKwoWdyBrIYrsMcNoYeBdaDnmM5s6Ux6SJbIKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707251; c=relaxed/simple;
	bh=GZGnRO0uWX2ckjYVIesofUn+siCPhMoRuAZcHNWbO8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SdQSzq+Nf+i6jQNSeBO6P1BHWe+4weIBOxAdE1qnWGjbfmPe5pwHw40H1hap1w95f5rMVFdG7d9IjFui5ds0DQACFWgY8n/BJruKgyfNq7bbO2vVTier4IwH/Ze672G8wTqZeOpf7VGHiYflGl14pTILB86jk5RZ9k9Bq/R7ZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoQ07cAI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJrjf6nt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TG21aB3733124
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 17:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sLV67yD5nGv85CM8sWD4JC5bnWMsTTj+NA7kbrxJIEI=; b=GoQ07cAItryRZK2i
	qHUfDAD1wF54eFvF4JM34YzU2vPiKyRevqM9B+/BxLJ/dQmIWG8Hzxsr/YySQqgi
	z1coNJSCfNUnVvyDwjGd54jaEo01KVtt8ZPYsmZv3eYoRrjRb4V+cl6xbBPEi4SN
	2TmX/thHzeXRJAu4XWvwgVrEvxmVoyTSam/5sE60aRrjy2jDgxymEPbCM9/TZF8u
	OewLEQMoifjx63Ph/mXfNMkxVx1JNOFneImJ76mPjLsMPT1Sqplc1F1ZNnvhweGB
	BxZQG9TU41y3FP2zpwVErzE5hR6VcJ4TnvXuWLNfYtfTGbkhmfy1SAuUmduFaasD
	5JpLxw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0aqd8aw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 17:20:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so931364a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769707248; x=1770312048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLV67yD5nGv85CM8sWD4JC5bnWMsTTj+NA7kbrxJIEI=;
        b=GJrjf6ntrSE3hi7gqY1CUMGROxyPrtlGaXSBDmZoeu3dXNqKh/1bXHktyntgNr1Cag
         dvrfmtsV/f8QKH5tFTF+WPA+ZoaEUhProrj1PrssHGyUkZ7osQDTjyp1lKgzbhJET/sP
         QTNuN9QUKHSHcCFbLKLU5g1NmI0RrRSDvhpTKKQLNhnI6yy8Wn+6URN/vjhMHE+a/3H5
         HRbtwbkHeQP+gmSHgzjWFnJ8taS93xU2wGlpvXViRBl3fzpsbFL7D7JA3LYe35MgXe4E
         7DmuDYT3x1GRTo3giSlzzcdVgKUF/1idqMYPWZo/wCDBKPixQKu52HeP91TyPyXNfWO7
         5p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707248; x=1770312048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLV67yD5nGv85CM8sWD4JC5bnWMsTTj+NA7kbrxJIEI=;
        b=r4vFcrlG4qKfNpAyGVTMuHgUDzAFRj9g3bBm03sUmIc8sidH17mFYklgSGXCwMpkd6
         RF5gqrg6sjBZbEMwwaG9HskLAljAw/uMq6UadbSyii9jIPsKg7/ba65W62G7HIavN3FY
         yrYtXuWNE1hSz1Iwrk15O1+heyFWyNTHPE3fvUKSDZhhCklDysObAJHlDfHfRWJI+6Bn
         /ldMPwzrYMs6uFJiiy+xs/WXpYKZ/j3ntQe8Vo8uzmIHkCRlpybC9CtjhKQEzg9XSCHF
         h6e7/dazD4W8veI9Im+nj8jl2+/RmwItxbQnRjHfnQHRpGDFQMrtChm7ZMmG6a1c2mg8
         9cnw==
X-Forwarded-Encrypted: i=1; AJvYcCXvafzjIuXC4yggbNF05pU0DiIdwerXrS2opf1ZSb5I3MrTEicq/7dQTSdXpk/nT2lvr2CL74lEz4ozd7KpQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfW1t8MShIQ5R4qWFT3BJ9h0IbKaSd9r6RCi4+wXouMFmsLZ8p
	+rDPJYN0+EltSMc7A+nTu/uW/L9i6fu4WjQjf1flQigDBLvQpl3tFsc+7YqgP+yY+5JWN8u6Eja
	opJt4f/vuIS0nIDo9F7Kd3/0sc8dxHKCoJr9hIsoh8dKm1OcleE5076qfAKzIBQTSLi1PwQ==
X-Gm-Gg: AZuq6aJ+yCSzn+uAz0w1Lk1D//ulAh7rmPZtUf7GXLV8IYxlOnwKiW0ZObJNiIETczt
	FMmKbAtg2UirPINdMFdWWO02y/sK2JYMuP1HNT0vqMGo1WerYh+ujaIw6kgatXNLOksafDUoZt+
	3ixZsu3gmXILRcc+ZPEJXGdG682GB/hjvpIdqOVo447w1m/4s7WjxGR849ArOeDSxPrxyGK5HXS
	5tMF1gIXgEpPItTKYzC+P5ts6jVSkETHSGWQqoKw0sDMj+vnCQSbIPcMe545lm4l0I66QL5SQSO
	47ZElgztOg/5/Hhj5SaWuSpGudc8yOjovMQvhSufSGn/L1knByxW5pxLMqNcNC/b7olhwO3zxVi
	Zq2N8lzGhkJ5rj0vxiMZUMSvFqIlrDTAbuI+7PpfBnDTe1jWCpforeUK8U7LQ363i429+kyVvQD
	IyCkukb/HCH313jirKrAEbRw+NEWFTW05G5UFuIA==
X-Received: by 2002:a17:90a:e7cc:b0:341:8491:472a with SMTP id 98e67ed59e1d1-3543b2ebd48mr191206a91.4.1769707247739;
        Thu, 29 Jan 2026 09:20:47 -0800 (PST)
X-Received: by 2002:a17:90a:e7cc:b0:341:8491:472a with SMTP id 98e67ed59e1d1-3543b2ebd48mr191173a91.4.1769707246964;
        Thu, 29 Jan 2026 09:20:46 -0800 (PST)
Received: from [10.50.27.148] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3cc71bsm5706286a91.11.2026.01.29.09.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 09:20:46 -0800 (PST)
Message-ID: <8dac659b-6d92-4e5b-8079-cc837c91b7ef@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 22:50:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v5 3/3] wifi: mac80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
 <20260129092039.09be5776db3d.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
 <104f3cd9-581c-402e-b4c3-898f1deaef5b@oss.qualcomm.com>
 <0d07eb7e74de33ff36fa11efde1323c3f81fb0b3.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <0d07eb7e74de33ff36fa11efde1323c3f81fb0b3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QmNEwHjHgSmtjaqvZVeG4W1n8cqjabre
X-Proofpoint-GUID: QmNEwHjHgSmtjaqvZVeG4W1n8cqjabre
X-Authority-Analysis: v=2.4 cv=GNAF0+NK c=1 sm=1 tr=0 ts=697b96f0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DvyHLG99ymdBBJ7HCV8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfXx6L6jhL4WKL1
 MgZi1u5fPuiJXNkbznORNwJn6QmnjzzKBlZ4dhjUBHR9cAVJQUsk+0elnmDtKsFqqUKkOq8uo++
 PRSK0gtOfdVrX/OIkxxe7APYCMKiZtdfWFxmWrdFDjjVmuVxUYKAzjdQeMegvLzFadEVU2vROGP
 FPSnUhgPlmNM5bH2RT7wSGtPC5N9kj96gAFxJPZV2sIDuVsifoWuDSSCxYHSUcJRxunYkGTEpQz
 ulex70rMTg5sFKBtJrhLD5b8DJUKNVLHivbrBNs+sKKAPJ4oZd7C5f4APf2WTKb1nshL6jPnf5t
 DC+2MI/T4Ez3ZN1ZzT+n7cLYi1vg5Ir64GTR36bR10BlHFUv5G6JPied03SV+t6ADTYsw4pddRQ
 qpe/CwF07j/vWstp0sWh8psGKyEqJhWFQ6vJSFSAO7c2qdiPAWqPw8n2TT7c3y2j6tM09GbPkqq
 wVDovQmm1mOUyRWHEMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31337-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 99B19B2C42
X-Rspamd-Action: no action



On 1/29/2026 10:15 PM, Johannes Berg wrote:
> On Thu, 2026-01-29 at 22:13 +0530, Karthikeyan Kathirvel wrote:
>>
>>> +		if (ieee80211_uhr_capa_size_ok(data, len, true)) {
>>
>> here it should be false isn't it ? since here UHR cap processed for STA
> 
> I _think_ I've been consistent in that 'ap=true' means it's processed
> *from* the AP?
> 
> johannes

Got it, can you please modify it to from_ap in ieee80211_uhr_capa_size_ok()

/KK

