Return-Path: <linux-wireless+bounces-32644-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAmzIzTCqmlXWQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32644-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 13:01:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852522002B
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 13:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BCF0300D0C3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2F3803FC;
	Fri,  6 Mar 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLL2TD4o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N2FAthL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7F365A11
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798510; cv=none; b=E0tHmPLRxN+Hv4Xp3Ga4dolrgKOwFi4/zLCGeV7Hg+1KTOgQ6A+AvL5NoYJDGajtqXsoDYTCI4sycsxBZk5Ljtg09MGJFA6Iyta4oA3iNvK/55zfquT+OaaQdhABVOseNbuvvUF6SxTkdTN1pofjUVmhXx6eIDGAEdc7jAVfMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798510; c=relaxed/simple;
	bh=2E7ipbkfUjEljtuccQHPZAUc6AhC1u1UhYMiyRHXFmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfXeAz0hxd1CN1m8F8WK0+h2Lr5tg7C2/7Yn6U0ib4XU9GVfDkJoBh+pmo4o+aSWjLmKPSQDNPHvyjd5+f7E+hkWQyK/L39W/cYhawtcOUOih5tYi1uRp0IlFeDYfLs+qpP/5+o2R2WGGFd69sSE4E8BvWZ1pCDaobyZZVLrMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLL2TD4o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N2FAthL/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Bajcd3716439
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 12:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T5bGqi89mFUFrHCKGw/j9UK4xduPWvTzAqKlBJ9K1e0=; b=jLL2TD4o8kV++R7U
	fj3WXAdmbt58wmThP+QGlmotiGcaFWLBDPdMeACCyE6IzLXMRzX08YJL5hTQidH5
	BvgvWrMqoJefdJqixXuyTbozov24StU7kOypkM/8BTgzj0M/ot8DozINIP+bJFqV
	Wz4AV+PQu2cfQXeX6UJIpFsFEYjVHHwmcbXsfjYcuGdcJ4ZuWAmLgbYbvxOSKr1x
	nEo+Ec+PP7Pg15MUKXIGg6B/teyfynb2g/oVY3qNsqZWzRMVKjOK3cNogralH+ax
	n7tau+XylJrwiAVBBiowJhMZLEL1BStBXjTjlUR4lbK0eBxpa/jKJsEGB2ZEK5FF
	x5cqmw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqv98gex4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 12:01:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae4af66f40so63797005ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772798506; x=1773403306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5bGqi89mFUFrHCKGw/j9UK4xduPWvTzAqKlBJ9K1e0=;
        b=N2FAthL/ZhfMfyYJhpIs9yhCrTZvrm7CXCo48jaBK9AEq3OicMyIHu8zZOWqzM5WZ0
         fqyfjgVIpSH0uo/NRgnLnXBBbaJKhI2iKUrQEcdiFIWS5q97Jxk6uQGOx1xeeCcjC7Xw
         dLBPDGLLIUWWDNaVGFixKAIbsvMWoG7lMFgAqVEWlXH6oqOnfwzqDf5Avg/3GFekRbtE
         2wNexJkIieTfU6ESqc2OuMwOLlPm9EO1kXIepA5fccG7c3oGMqmF7q5p0Y2Lrt7SX6oc
         IhxW7eylNQRJL/aIX1Ia8w610eGf670BHC8t4LUVwhIbzXt4Z81ptsg1tiZbrqm4qlUb
         iEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798506; x=1773403306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5bGqi89mFUFrHCKGw/j9UK4xduPWvTzAqKlBJ9K1e0=;
        b=ZDRfd9iyYONh2397CzR9qaN10fYUV8syqYD4tM5N1V8TiRinNt3aVLtXKVd1G9h9SG
         XsB2XQwwfqzFReTy7rdVALFjVHtKcGT0Ws/iON4c1oc7cruwrUqyeZrXMQTKw4J/yOi8
         fYfBsCL+zh0DP3eDxl1h9zvkN8ClaM6htMhVHzm9XOb+GlAVGjcV4b+s9gDY2q2Q4Reg
         HJGII0l8u4Nr0RKFr0eqRIPjSgDjOL2+vSX4ppOfhDPaqGqaDu8is3jPTu0dr1yTMJqe
         GM6hQ4vmbIycPw9yuZk/zcmfTILN35S9cdHuRlGXcx/bYaU0pLFfbvtL0p66AjefcT7l
         vdPA==
X-Gm-Message-State: AOJu0YyMjAQwu2B/yqCSUcZnXH+gc716VXcaASskZrRDQ/O7KuN1Wmh1
	k/qZDunbNtreip/f/aKIuIwMprRfVA6+Y+MlgYzxYGRSxq3PKiFYIZiXRWwJPZaFvG+GgUXnVW9
	v/qLKvwGvVVBglBeBUSZogFmU2FXAJHvxaAU+EXIcZ6aYS/KFI5jAOo/O6S8EoU4eJ9+UNw==
X-Gm-Gg: ATEYQzzUFaK42IoL08sfMaRwqW9YDNpYTIJJkTjyKAHpIb+ZS+vn/V4NJ9/MVq/WTwo
	bqDinZPirx/26MnuOkeqw2y2BTcr/3wM6X6surXlYbi+yBy59v3U8w9BE1xLo5iBpaEAPsVjUq6
	Otw4jSgOTjfDSqbChfugbEZYbUHFknlSurrYIR40/23sBof5meTxwgC2ocgWwlBk+dJWV+gJL8S
	VSJMPVHAwOmQIeXOQLONJp/Uk3pEp+etjASVi/PdyBuKgE8R8XKYGZGs8gRGX6gxAlQBHEY15px
	TN78zr3u1D54xkDNIP15kezDBqmIwVtEwh7O3X9I1hrNHnLMggStT1RxRxJzYMX3pmsaYhKi9Oi
	GkhEMKu9K/S6PLgbX0tiHqTNxpdyqRaeI+QHv1fL6eQ1bSC7B1ZRjG0YTBPLJqL0=
X-Received: by 2002:a17:902:f78e:b0:2ae:6192:8da3 with SMTP id d9443c01a7336-2ae824623camr22163355ad.42.1772798505993;
        Fri, 06 Mar 2026 04:01:45 -0800 (PST)
X-Received: by 2002:a17:902:f78e:b0:2ae:6192:8da3 with SMTP id d9443c01a7336-2ae824623camr22162945ad.42.1772798505331;
        Fri, 06 Mar 2026 04:01:45 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e5c167sm16432005ad.1.2026.03.06.04.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 04:01:44 -0800 (PST)
Message-ID: <6679fdab-d3b6-41b1-b807-fb0909af6cbe@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 17:31:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v5 2/2] wifi: mac80211_hwsim: Add UHR
 capabilities to the driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20260304085343.1093993-3-karthikeyan.kathirvel@oss.qualcomm.com>
 <f256b3e7fa9227caf0bbd6696b81aa79b145945c.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <f256b3e7fa9227caf0bbd6696b81aa79b145945c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l4cRGRwFo3fZ90OjXjJFOoPNPAEdfKeR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNCBTYWx0ZWRfX7gJuZy8VJjME
 KFsmCP01WL0SmxN0euIXPp4T+wT4RIVBZWjABp/ZaC77h0BFZ4FLoP/JRaVNw5t5e/WI4cUGKhP
 BGRZXY5AD3c0oB+/kL+sFiTUVu78Xs8cDO9ngBw9xEINksXv/9IZP3MsBBxJpuOi1Gx9oPk4ZAy
 Cn1ZrlgQ/2tPYrTpCa8NqAW11fR3fzvFY34MSw+c24h8fKcd4HR25yhbb1sTW7kWccwmj6Zmg6z
 r8CdBzI/tqZ3EZN6ztEfkZu/We4ZEUEMId9YpqCDvqPYXKJC+rh+myCAOSsqlsxLTWhSMDARoeT
 VDBbtJ40DztCQ8cWtjMHk/dN0dpb1t/U6M7eFmrgiIWXgP9uPrPTZ4tYj6hqm543XMCUhaYdzy4
 P5hRrFQCQOEs6t/BB+Ur7inmx32EiJK1tnBHYdw8pW8NVdm/rAeHtN7EmHlXfDCZDEAVgbNesj1
 aUiugnE9Ydi65k4TznA==
X-Authority-Analysis: v=2.4 cv=LbcxKzfi c=1 sm=1 tr=0 ts=69aac22b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=SiGYLgrUxgJyI8PW2ecA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: l4cRGRwFo3fZ90OjXjJFOoPNPAEdfKeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060114
X-Rspamd-Queue-Id: 8852522002B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32644-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 3/4/2026 4:19 PM, Johannes Berg wrote:
> On Wed, 2026-03-04 at 14:23 +0530, Karthikeyan Kathirvel wrote:
>>
>> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
>> @@ -4478,6 +4478,43 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
>>   			},
>>   			/* PPE threshold information is not supported */
>>   		},
>> +		.uhr_cap = {
> 
> Missing from the context, but this is non-AP side.
> 
>> +			.has_uhr = true,
>> +			.mac = {
>> +				.mac_cap[0] =
>> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
>> +					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
> 
> "Reserved for a non-AP STA."
> 

Yes it is applicable only for Mobile AP, neither supported for AP or 
non-AP STA, but I see only this I have missed it, remaining seems to be 
correct at to my knowledge.

> Maybe we're just better off doing this as we implement features?
>
Agree! I will leave this decision to you :)

> I've applied patch 1 with some minor edits.
> 
Thanks :)

> johannes


