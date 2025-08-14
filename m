Return-Path: <linux-wireless+bounces-26389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F16B2701A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA687AE455
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5E248F4F;
	Thu, 14 Aug 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBke3Rmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9921C176
	for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202719; cv=none; b=eV5AQt90vM9ml7lkev7e0HvDTBfQDNpMI2vtA5KRhBB2U+OgY+WB4dMZobidVzYE4/0DloS2zdV0C9q16k/PpZDp+2GyNdZMnriTjy04GDoi9eO3KkeqpwGHiO8cx/ivWRWoMWY0BTOREo7FA6Zkdast0YxW3LQ6qOHyBdSTwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202719; c=relaxed/simple;
	bh=bvtkOPBITybadD6tKV66MaQdSTKk4bVmPqTmK1dZ7aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQAv9mPD2k01xWDMiNWz5lYAGtbi74F8DyDllcWrjCffS1psTFxsaIK/CL4J4pa2mHbF+MjbY4wxgeBDCKGTR++Rn7khHVF6stNmpMq9c3wHWmyLpAsXBhatD+AkEtwpbD/l9Wrp+0rG+qqsLun6qAnkZSJDgRlINjNlXOd/UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBke3Rmz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EI90e4031866
	for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 20:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bvtkOPBITybadD6tKV66MaQdSTKk4bVmPqTmK1dZ7aw=; b=lBke3RmzsD/DhNEi
	wAcR2r6F19eFapjsDKP+Qg9Vml2p4k4M3/l7FwDAYEO/6i1Fpqsw8YWvcg2eFOff
	lWuw0Q7eo2GMIqSUy3dWjHXXOB6/v0/vQ0P7vrqazkXZurJYivVCdTiul7uEKClh
	O7OG3zdE139tUBHkqqso6DDaPdU+LsM2aurvZswwtap0TdGfHdnG5eBmtR/KsLjb
	an3Mr6lV1ZFP15fvCcLM0dddvXrQpdGUYaSsj/N3MRNNJsb8uvDTp/4AB8v0PvR8
	LM7EmPtAezqVI3Q6GfvlRiSjhZHBJC9pqIqsQGUtnw+kRIeIP5Hr6333P8ulWhn9
	i8GLpQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4n1qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 20:18:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471754bd26so850778a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 13:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202715; x=1755807515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvtkOPBITybadD6tKV66MaQdSTKk4bVmPqTmK1dZ7aw=;
        b=wWqK0bzS7GJzY0OKELb7KdHgoaqv7kv9tcUfA4HUr7OJdXwxgGns6DqqCP5webS/E7
         Mgm7bYT6p0lsGa3zNmebExgsgOI+P8JexPVnC1k6taG4nMQRXuNAzUmPjNqRY9K0B8rf
         QYs13Vatq50jk3AE6EktnMqJqBzwsEHBlmc1MPPtQTPEHdlkrhy/9qdtDn1SWvqye8Kc
         o5UDfBgjJ5G9mHhF6xHQvZzc16ZOhGksCuQLZ9lF6qeR0xu+z1QFowTtp08P25/eTlia
         i/9eD7M65h/huCSeiFW30wDsfAe5KQbPdfmXdYvicdm0vjMSgSVlk5lcZR9zNtC2c/vj
         EVow==
X-Gm-Message-State: AOJu0YyvXAk1nr1WjQCC0Je4/byq/f/+Q9Kw8Utkas529nc6wbTRwxHt
	cxkanQjTKBQYzo2R2HVyze1zMu4ib7KziLUBdsYWC36RsSRJYiE9JZNx7gl5x+AvAjGOr8UjuU8
	Tv6fFE0sxSfPDryylpbpSSZh4VQra2PmvZkYviH+k0rMJ/sZ0Kw/Tf1wyFj4sN1RcXtiSas2zoO
	vI2Q==
X-Gm-Gg: ASbGnctEGH8pjJwaEcX+oW9Kv2eYNH5ZUTziWkplsYgeuN2tqsD8fd+jbH00Pe0/q7D
	YwedDui5nq06SkI/A54BMOr9Sjk1h9qFnuWH8GTwJfxG9CVC5MTN54kUiZwRRAmltkt1j1RLJoc
	xhrmn0DanX5SOksYUHmFTtk89aLX+WXYjtepAD3MnuOUkt7T9obVyBq6tR4yZBKuT5oHvwX6YYK
	hOlMV+9IJmsWfvGWHgPzUZu9g3P3h2D120exuIuu9t6ma8vezFF3YVBKdxuOkNMLDsMV07CRDpc
	4DS/AEV2vvEDaq6IytX3jS8LYLv9KwI3qKmK4LAOkBz2hQCTydDRX1M82qVOOL1A1VBsA4Zt7z0
	nfhxckhECG6bPKo1fO6Pymw==
X-Received: by 2002:a17:903:2d0:b0:241:ff36:552d with SMTP id d9443c01a7336-2446a2d18damr4858145ad.1.1755202715060;
        Thu, 14 Aug 2025 13:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEfd2HTevBRxB7VZMYBCOp4BeD6MfUvufzJp+BU/q3z5MuuX+9afmWDPK1rWTt9frpFyMgng==
X-Received: by 2002:a17:903:2d0:b0:241:ff36:552d with SMTP id d9443c01a7336-2446a2d18damr4857755ad.1.1755202714598;
        Thu, 14 Aug 2025 13:18:34 -0700 (PDT)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24311635d8csm48042205ad.26.2025.08.14.13.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:18:34 -0700 (PDT)
Message-ID: <7b8aa88f-6bdf-46a5-ad65-bd02b9c3505a@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 13:18:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: nl80211: Add EHT fixed Tx rate
 support
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Aloka Dixit <aloka.dixit@oss.qualcomm.com>
References: <20250812213652.3763535-1-muna.sinada@oss.qualcomm.com>
 <db364a7e-0877-4069-9c06-26ab6ad4acd2@freebox.fr>
Content-Language: en-GB
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
In-Reply-To: <db364a7e-0877-4069-9c06-26ab6ad4acd2@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Onsg8kVzJp-dI5tDpIrqZEkBmj-ymD1r
X-Proofpoint-ORIG-GUID: Onsg8kVzJp-dI5tDpIrqZEkBmj-ymD1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX0jP8Ru9jvfae
 rjNDtld6TTq2uofHeKbIuUJyWqAn9ePwy9GTbXNtMSIucix2jMixeTv6NDdsiBarlqnp67hik9j
 WA+5HJaE1Pdsj/Whd7rGsXNdBvVF4LywAF7lZrTjgbk8CTBwpeHr3TaBl0o9Gr57SAqbOQu4u3T
 goXozB3Tcb5b+0HyWCM3l4w4cRs/N8aDlmF9QGVUzV37v7PEiY4im72TnI1joyc2MZCwdXPr+OL
 Mqfb3HAEWSmwx9G5mTs7PIerDdsYHoiEaOIW+okktBm49iigMlBLyL3H6RBY0TviqI5sfbJ33HX
 kTp1UY04A0FZOmQQXZ9lXsG+dNS3fQHxaaFKsgJhUEWfHQqW21zYqLMRs3JjCE8QywwNzHdDGtM
 GDg+7krG
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689e449c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5e47P9vxOgH06Nn_BfwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/13/2025 7:26 AM, Pablo MARTIN-GOMEZ wrote:
> On 12/08/2025 23:36, Muna Sinada wrote:
>> Add new attributes to support EHT MCS/NSS Tx rates and EHT GI/LTF.
>> Parse EHT fixed MCS/NSS Tx rates and EHT GI/LTF values passed by the
>> userspace, validate and add as part of cfg80211_bitrate_mask.
>>
>> MCS mask is constructed by new function, eht_build_mcs_mask(). Max NSS
>> supported for MCS rates of 7, 9, 11 and 13 is utilized to set MCS
>> bitmask for each NSS. MCS rates 14, and 15 if supported, are set only
>> for NSS = 0.
>>
>> Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
>> ---
>>   include/net/cfg80211.h       |   3 +
>>   include/uapi/linux/nl80211.h |  32 ++++++
>>   net/wireless/nl80211.c       | 214 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 246 insertions(+), 3 deletions(-)
> [...]
thank you for your review, will sent updated patch addressing comments
shortly.

-Muna

