Return-Path: <linux-wireless+bounces-29837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF6CC7F4E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A37D306B6E9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D52868AD;
	Wed, 17 Dec 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osvYTbGD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RWLUF4hL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310C33D500
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976219; cv=none; b=aRJtiD5pNhlw3SwKsLcgCdeosWbkv1byXuAg6Mn8geU2b1uia+2TueFnv0zjC/nlvZ/JxD3mar+0yNFgRF/Ijs9vdSde/89O1p0ByBO2JWW0bsIl28uXZNqBPld3weEjwrttoFjrN5tF24CvVHdlAtiGvoKi60LiODBdyi07ByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976219; c=relaxed/simple;
	bh=L9BDz9z47G6lKG/Vwunk88nwpahY36vzfB45Wh3dYkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Li3/TR6ID4kIAc4qxPnE0CAkweJRpyh7j6J66Du76lEDX7CXLwjZ1l7zrgDugBTie27yTz5keAl6ukXBUjD2HBypvcroFOQHllj7YW4Yz/C1pJWQt5TpXwH+/0yw7fFkrsWX593UcTo5xiEFdaq6N/O3t3GHqtTZdkqxJNAnQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osvYTbGD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RWLUF4hL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCL9UC2675128
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvo6Cizk5EUSn33xSF/fCZ+HVksEktFzfs/Oq8Dk7UE=; b=osvYTbGDES5SRSz7
	N/vLk7xQ1HPjKBINmZeTm2UCBQZTltYUX+GVqBqzOCqjLXFlNdn3iS6kWVUEEn7v
	kRSFmCbaGROv9ET1x5sV5BhuWCEu2PK2ITu7Q/Vdnae8cPbpnOaz8z4Aks8rfkTn
	meoKVAOt+gOpClkSLZL+cl+xamWFMf1MKO13w2zrhpiCvpn2GZeVRP1xWRV4dOFf
	PcNt3Z2/0uayRKADiaeAA0Y750mp3GsisKozWN0RB2TBWUOuvFDMThZwg8Ppo8AJ
	wZOV0/MXgWVVfTI5Pxq/lMV8FGXdqpzCTHTtEDJJhipQGnKTozh73CvECTGkLaIF
	S0t6hg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3myj1mum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:56:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a13be531b2so37567555ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765976217; x=1766581017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvo6Cizk5EUSn33xSF/fCZ+HVksEktFzfs/Oq8Dk7UE=;
        b=RWLUF4hLcHLunUvcge/xg5bt7UbqEVrLQaUA+U1DaO0uGdy67VburHO07Z633FEEq7
         Iu8/TdRvn9oLW4cD/qZq1sW8fISpRoTSpJQ0ClP7UMpPdRE5v9FH7roikyJ2ChttWub7
         xJm/uJVtWiLSeenVDwMS+5fv4Ftncz2Nak/iESnawf3DrC++qxEjGvyjyPFf2Vs6mJpD
         e2GkzT+dObcobBdTh6NTYwLw0ge7UnVe3L3VOuQ5WmNCeMRyIQT8Bvq3rJksKM/TG3uA
         2ELrnDom5NoX+ntEBObYrpOWE1cGUKE39dXwJxiMxrWZ3DaWF0+kztCnTa7n+Mljxr4h
         1AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976217; x=1766581017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvo6Cizk5EUSn33xSF/fCZ+HVksEktFzfs/Oq8Dk7UE=;
        b=IxGzop6SmdyZO5keNc14rH0nqrNLoaHsPQQpCWJTwQxR3IGrIi7+cwGabpU+cqoDAs
         N0SITlo9kLGQvVE0WOoW1BLoFc5xgQ4GFomo4jzt/44i0CNMhuKVdPd2fWc7IeXRSEvq
         +GCyRMhMo3qpfBAjGHXw927xne1JMT8Qn1L/ZCKK2d2BmO7n/d85b/kvJALlpPHvuX8q
         cIHct8PsLJL+oW1an4teDJlZVzuxzZmIqFH6lqtjCSrLd2LWhw65yrxZKjPkzBcIDS7w
         XknM5pFY2zZLFIONlIbh1lRFQh84yhDeJOs4Fhm7vBIEbH9FSNZxZGX2Y9pVJTaCu1PK
         DeQA==
X-Gm-Message-State: AOJu0YzPKLPpA+j6Si0j/GUtrMBXt63s8uSqsoUbgfxJLRM/8AO+AY91
	MX7hgvbpYww6zA/FMTGTklW4vzRyxqSBcZkntDiDyqErfWen3FS+9x3PcrmvrZT6IGSNxFrtZVo
	HdqLu2ZfpG+vSll1yICV0XMy4kADSrkppN6Ln/rQi3S3lFhwY7x0SWdSeWAgFqamJGgs4ug==
X-Gm-Gg: AY/fxX67MfIXGJtwe51ui9oSNZGAKjJdfIl21sjxF4WNbHyV0dNSyKv1Ooq2fTn7fLB
	rsZXNJVPAvQIpUiM14cI2FlBUw2oA7cg8Q+NLUL8OICJUkhHB5Vlz9xip+8oO/lYPyMFdrXX8JX
	+I+SP5NmafMvskTmjec8W3Ox7EMFALFaD7RrAz+EWeymu0xVLeTEZ6tN318pij3dnLeFZaC6uxy
	wWyy5g68zanJBHHFCUJZbViTpeqpryFQm3xvBGqBFn1BP24AapnFsuQNWbWG+dgB5D1cbmgMVZ/
	eEdfw1YxJODxe3XPEw9L5PH3jDmZeJzOlXi6CUni8tnVXJ3PS+Prwoi4VYmKLpuBUGVCU5utc2i
	SBlT1ath+adzwAWFAqxeGexy/Z9T50cBv+NyfSBcmX00aM517l5Q=
X-Received: by 2002:a17:902:ea0c:b0:2a1:325b:2cba with SMTP id d9443c01a7336-2a1325b2e27mr67785735ad.53.1765976216524;
        Wed, 17 Dec 2025 04:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzT3avEdYZxEyN9Zpoq4Q1UF1p2k2oALPt2iXnJlw3WLVeXAM7s1moIXioTtaDt+y2Q7ZPww==
X-Received: by 2002:a17:902:ea0c:b0:2a1:325b:2cba with SMTP id d9443c01a7336-2a1325b2e27mr67785605ad.53.1765976215902;
        Wed, 17 Dec 2025 04:56:55 -0800 (PST)
Received: from [10.151.41.188] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea01723bsm199757875ad.62.2025.12.17.04.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 04:56:55 -0800 (PST)
Message-ID: <49dc8567-d1af-4067-b0aa-5833414c61a0@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 18:26:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC wireless-next 02/13] wifi: ieee80211: Add UHR
 (802.11bn) definitions
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20251216062656.1738022-3-karthikeyan.kathirvel@oss.qualcomm.com>
 <94411a1f601b3b4cbc09cb780c37df9013f3b6bb.camel@sipsolutions.net>
 <3b58cd19-d522-4df3-880a-13fc26ebc642@oss.qualcomm.com>
 <c74d5c2c9327b265ed6cb48ebfdad3f687a2fa71.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <c74d5c2c9327b265ed6cb48ebfdad3f687a2fa71.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEwMCBTYWx0ZWRfX/p06zDcgYcKx
 1PW5ET6UswU1gUz1vu5Pu/vI2vnWys1aqcKuqwfU/z7+kIXm45b67HeKgcqz3SajMKLTAwi4iD2
 tgmxCmUeZwIlR8rKbUj5Oinchod3ETmG9jWc9DoABvd7EWscfPsYGgfyg4w1JIhJndg4sLeiAql
 1Xw01DbGdR1jsvzpnYtz6l1L6B8AwWb3fHdRALrFZ7kj1Wg6UcQPsGg1HVKtRNwZRJsTIFEIKwr
 VvMG7fFIcZyCLiNxyeoDcKnYC55UycwzI6nA3oTPuFuq0+CSEEUWWS7xhcI5l87E+zDR18WkVCN
 JlGoPjCQ1vPZucVJEwlYm7tD/ztGPvkz4EqtBhI+0HnZGSvDo0QPCIKKtEXAidrizbcM8zBpmuv
 ApnvMPK284YJIzkLUe+yStOwovh3Hg==
X-Proofpoint-ORIG-GUID: xXeFV3cTKXS0yZnYh6bCh0R_q-skcsL4
X-Authority-Analysis: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6942a899 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=d-QtcCtjiyddJGp_kzUA:9 a=QEXdDO2ut3YA:10
 a=QYH75iMubAgA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: xXeFV3cTKXS0yZnYh6bCh0R_q-skcsL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170100



On 12/17/2025 6:25 PM, Johannes Berg wrote:
> On Wed, 2025-12-17 at 18:24 +0530, Karthikeyan Kathirvel wrote:
>>>
>> Sure, I will change it to hex format. Last bit mask is fine right it is
>> from B32 - B55, what is wrong here ?
> 
> You'd need GENMASK_ULL()
> 
> johannes
Oops Sorry, thanks for pointing out :)

/KK

