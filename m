Return-Path: <linux-wireless+bounces-19699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E85BA4BC6F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A387A614B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9D1F2C34;
	Mon,  3 Mar 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TlM1zWui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA91F2B8E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997897; cv=none; b=dephGKK3IBmBAZDLDOyXi/jj0zFRHNY7FL7H7X5dnPx4nbADTvW5MrPHNp3IQgCFteJLNxPwdalb+za7OGv9oDajHzvz/45q4juhGrmonhM0CIanJ9a9t7vswgzWCwcwCj2IqPw6fHx3Doh5YtGRmx4IBDx3iYDxkqsVPCTbutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997897; c=relaxed/simple;
	bh=mZ9bXaBXIELMRwCbWnheSV1EP6JXXPx/M01ZRhSQJHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlDDJyxldjgi38gvk6q+kh3KYZ/EiNMuIa58bq+6kFdyv/bHSxHRL7r/1oT+XfHszGq3hoVAA5WxbeNZ4yLuvlNlH4+cE+vT1A+r8VUwPPAgVcLB1L5P3Ao/5H9fwKJeUifToGatHOty9MNGlNJOMmDtUoNEZvEzQS+dhk1G0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TlM1zWui; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522NKatK032681
	for <linux-wireless@vger.kernel.org>; Mon, 3 Mar 2025 10:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+v6RowI8p2XaEBSOcUfqm4BSxcSsncMZw0XrVYG3wnY=; b=TlM1zWui0kGdYUQq
	GdgqrtvYhn9MwOnN1uAl6q2n+77SPtV6l3hRLSmAZoF5Snx744Y/rihxFmccz8P1
	dHBkqTbAmlFRV7tAwVivs91xZ5H05qNmXgQ2houscA6EnVokSOv4zxZb77HH8M09
	dLCDuBu20xZ07IPeoUBFyRt3g+iGUoUbTs/NZT0GacjRPwruqXmc2OqW7fP9ZURO
	8TT3J1gLb69kggD0GVPn9nnZ2002qLJa03DcWuB6ZkoU95soWbJItS4EBTcK6jJ4
	aENI61bq800d9qh1Xgp6pCZOaiau39V1WHszmt45jnPois10RCg4m4mav7utf8f3
	gnpyMQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k4dq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 10:31:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223725a1e76so48950335ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 02:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997894; x=1741602694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+v6RowI8p2XaEBSOcUfqm4BSxcSsncMZw0XrVYG3wnY=;
        b=sQLabrI6CTBPXCkHTxEEROZ0OPm8W8iSc3ciiGM3DD2TsKO9KMB8PCA8rk2y6gQ4B2
         YFZdnrmDdBJtYtHc5smf2SZhu7Y3XnNyDNrdeAC9E2zXNrozFZb6pOMp1HgD8Lxcw0mn
         j87vfHIFxKjEy7/JeWIN5HqgIqGIKQc30pPlytpxCzZ4wx22z9IwewEWes33NcWPkFlS
         j1xAsX9L99aBSsZQ3v2FgzD4F1jw5UbobEOq6uBeYzMO+vTlV2vZ9BSWXxPMd+1l36+6
         SYyjLXRI32VvA3tI1CepMTA8lRophZKSv51dk9p18QXLawUem9+Alz0kRiSJRV+WxQuc
         p1kQ==
X-Gm-Message-State: AOJu0Yyx2QxW/1gqUxuCVevS8R1QTnqR0cNr1lf4fCauGmsdl7B8hINz
	u9GuXHRzeWoieTjWChwwhdxUceYvGwzA8ILlhkZuIdKN2OZyRPJSUPSAujoJsRA4ajdFwR2+Tcr
	qXqDrEcXg/cVFDugThjQ/OIyhyRB5rejt0c0G51vQeWYUwkCRwWsjry79CfSzYwDAaw==
X-Gm-Gg: ASbGncubjrecVjL7n7VI4xe+nBmax5kwQfm0J5vBQWh5rrvRXehErQEpv/vt+2DiyZO
	IS27GHtjMgCc/qzLSLzLRdPlriA6Tqh9y38kvpBfwQAHuELCzdCECmYzWVRu/RK/UUjFTA05gYZ
	DCdloKFEZHSAbjXINUCdMIksXxI/GVAYslQysQeFRfIjY9yuLIbORmOaKvXvx2ZVZHt+cmJYKj8
	RLvCLeiVQwC7Pf8Q2JJwZgQmMThNjq6tfAFo155ccIaadXfeMbR3EcucMeQZfX2UROhO8S/BXPz
	0E8pSSxufS+glHbvUEkA5V3R/VheS9n7AMml1NGk/Ndz2RNlhNBl3EJN
X-Received: by 2002:a17:903:18f:b0:223:5577:3a41 with SMTP id d9443c01a7336-22368fa57a3mr173980615ad.9.1740997893843;
        Mon, 03 Mar 2025 02:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNVI4JlkpIfWLH6f4/0kTgkrFwnIJf8hpggfr8EaVfdEdEmG/5VJfWu8//Xgzvy6/7LQ7iqw==
X-Received: by 2002:a17:903:18f:b0:223:5577:3a41 with SMTP id d9443c01a7336-22368fa57a3mr173980345ad.9.1740997893500;
        Mon, 03 Mar 2025 02:31:33 -0800 (PST)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d529fsm74683445ad.48.2025.03.03.02.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:31:33 -0800 (PST)
Message-ID: <3721748d-a260-4088-a606-e851c417a0c3@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 16:01:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: cfg80211: Add support to get EMLSR
 capabilities of non-AP MLD
To: Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
References: <20250117170416.2907530-1-quic_ramess@quicinc.com>
 <20250117170416.2907530-2-quic_ramess@quicinc.com>
 <66e4ec1984c816bd8e0a95a8bced753d780e30fe.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <66e4ec1984c816bd8e0a95a8bced753d780e30fe.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lCBV6hfrQE81KKWYBCTlVI10KNYCwyPW
X-Proofpoint-ORIG-GUID: lCBV6hfrQE81KKWYBCTlVI10KNYCwyPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=896 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030080



On 2/28/2025 6:02 PM, Johannes Berg wrote:
> On Fri, 2025-01-17 at 22:34 +0530, Rameshkumar Sundaram wrote:
>>
>>   include/net/cfg80211.h |  5 +++++
>>   net/wireless/nl80211.c | 12 ++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index 363d7dd2255a..7a80dbf37881 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -1756,6 +1756,9 @@ struct cfg80211_ttlm_params {
>>    * @supported_oper_classes_len: number of supported operating classes
>>    * @support_p2p_ps: information if station supports P2P PS mechanism
>>    * @airtime_weight: airtime scheduler weight for this station
>> + * @eml_cap_present: Specifies if EML capabilities field (@eml_cap) is
>> + *	present/updated
>> + * @eml_cap: EML capabilities of this station
>>    * @link_sta_params: link related params.
>>    */
>>   struct station_parameters {
>> @@ -1780,6 +1783,8 @@ struct station_parameters {
>>   	u8 supported_oper_classes_len;
>>   	int support_p2p_ps;
>>   	u16 airtime_weight;
>> +	bool eml_cap_present;
>> +	u16 eml_cap;
>>   	struct link_station_parameters link_sta_params;
>>   };
> 
> OK, I get that this is the minimal change that actually makes this work,
> but it seems a bit lazy to me. Allow me to explain: You don't actually
> _want_ - nor even implement in patch 3 - this changing at any point in
> runtime. OTOH, you _do_ need it to change after the station is
> allocated, because in auth frame exchange you don't have the information
> yet, and that's when the MLD is added.
> 
> So I really think this ought to be accompanied with a change to
> cfg80211_check_station_change() that disallows changing this while the
> station is already associated?
> 

Yes, That's correct thanks for pointing it out, will add changes to 
disallow modification if STA is already associated (i.e. if != 
CFG80211_STA_AP_CLIENT_UNASSOC)

> johannes
> 

-- 
--
Ramesh


