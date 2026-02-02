Return-Path: <linux-wireless+bounces-31476-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DpmD7XjgGleCAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31476-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:49:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995DECFC36
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3083032999
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1113876A0;
	Mon,  2 Feb 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUZIq28N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wn1I+e9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84D263C8C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054253; cv=none; b=Crj4mbPGSiSuQwkk61SJ1l4HzVwZnnJ/mlqk7bkIkeDpS91CR/P4xkv7LIp25krsXB1vbnFi/Oo/e/bVmsBfpDcP2oQtsTFcFws4d5d3MSgnZL67/suyoXaPTuAEX9/qhki+gX74vjYvEUy3uLbLmRFXdurtDRLzgrvqN6DQLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054253; c=relaxed/simple;
	bh=MadfUEivFObYW03Suhtj4dHd2J7d4FvV7N2UluD+JMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEVTmjWUKpIkSCDceYnAq+gdLWX10r+MUWEJXzZgL83C/BlXrMtXrEjIzE00lSi3mmRclTUGnJ/dfdx81vqTzGSzh8GcpjVVoqOi74APr9G2hlbeR9jWjnvkBpnThSRGhJMuNxP6hydd2sbO8dWVpn/fdrOMjNEq9TlZVBrfT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUZIq28N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wn1I+e9E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CVCv3255010
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 17:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MxqepRj0G4enqqTyn4jlbqrvcvn1b7ZS9iUNGds+wlk=; b=lUZIq28NfFH28r11
	OsZV6fBAtQaLNg3huqnQlVHc7loH20200eEVkRp59ksq4H/onY8yJfnIJdeebiuE
	Z7e16pwOy5OOgvtRgRQzf5p68RakoOzj/G+a+Ag148LH4yesdwlzrojWeROEJ77V
	SH70B6zyAY/m/fW9RWcr4zpjJSsjtVQCAV+MRA1P8SPx+JQw0FR4yuJmvZMYG8Ik
	nkpDKZlb4bI6gzBtPkfOLKcMk4qZvj1OfkHaz3/x2uXjUxMzZVaYBpWyKo4sEvPj
	OxGTFAky2TKPs+eYF5eQqYU4YSHmn/ovQL5D6utK+/KMFKuef7J3OS6C0Y1MrUin
	2UOlQQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0kgykm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 17:44:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f48cec0ccso3915060b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 09:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770054250; x=1770659050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxqepRj0G4enqqTyn4jlbqrvcvn1b7ZS9iUNGds+wlk=;
        b=Wn1I+e9ES0YjhJ6yu2mjR0aIRNKfXLxhOoqcT+k7S2HA1+93jYisqORClv5VZjLwSd
         flZ8OBv00TrMNdor/qmvwaJcU/t4I7IHTNRecqeZOUArSoh7dukSpxQrCu2B0DYPpiUY
         3U1k0NmTt+Hb5Oj7Zw0nKZkFnRGNsFo4kdZjiSW0pxUZ6oOLf4bjX+wF5+lW+prDBp47
         yMvNs1fHD8TWvm6XoaOxjo6MlAUaJHsUT7KVmc2wlcr7gvLCckS5riwk6z1CbQOeRav2
         IV16ezz6MSsNmoFCknxP6yLxQv2vSRO1d1b3MF5L8NeM1/9h/UV43iqzCweOp2y4ctbc
         2AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054250; x=1770659050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxqepRj0G4enqqTyn4jlbqrvcvn1b7ZS9iUNGds+wlk=;
        b=LrpYWGB/QNbw2Rz808AOa82uTAoN22R5hOBWTYtJX7jCpzCwjhPKH3kxl+ahaIFtgn
         uK9tSEk30Qi9W3wupOufjcTdtKoB0NtkZvjF6AQRQyy+STBiOsDs9BpEMYJ31jb8iapY
         0VO8yi66bqHg2kjnpSUoHtNc66G4Kz0eNTC/kF13lE7dVYUq/JHehwXtikIKOUi5DfWt
         yQ0etJzZ1ipL1NRZ6tW7eakaZu2Jv+s52yxiiZV8JgwmUWzDWxCUegC0DGmLyb0B3XfU
         AiPe1uv2zZijuYvYvU5F34BFk9fhRSRhsjaugfOWeT74NpqT8rmBiQYYDKOdUDTOh/jH
         u2Lg==
X-Gm-Message-State: AOJu0YzhyX2KUhVJEGrZJxvTjxlu/0ArDXPmO7a2ZYQE7b+EUIYyKEO3
	qOXSVJ6kF5WnfDseAGPFIL0mRm3b2HMUd+xup7IBAT+8dJbP6drSI1TvmO8xVHehY7c3URE0lPT
	A9xvH++tvMJbvvRnfCIOiem9m0AJajk/uPav6TaMj2xS1jfXQ8ZtoqYLI1IiwDbyob1l5fa4bZ9
	uuzA==
X-Gm-Gg: AZuq6aJciXDV1LzyCX6C77ZaWH2wpKzhwlVC2Bu+bzrUBmvy36BSRtG3ypwAx7VEaCu
	hU3eu2L5h/hlAHwr0KFIxMm34z7ci8t+CNnU91ej1HWiB38RWH3EyDDIDoufpDleiGG9PSDZ4G2
	y6ab1SUX6La01Q/t5wC8fIADje7suHks4nI3jhhOwTFzcNXDbg18RwvYGl75kFqdiptC9fGNG9a
	IVPonTuumFsDgKjYts6ZNttouj7KZR3fIzv+SiLvVG7vevLxzldZlYwvovMCzOhxILWUXr19O4x
	2GD2MQy3RUHvq5nAoq3M121ylwIB+1WS/1eLJx2od0K5vRp0tI2Y1nTSt9WEcy1R0Fb2Lo0eS3q
	ezY4j/qQYT77eVaw2kgKcV5gqPjDyqczb58ZRfqOtQVPYXoSsrlEsgWMaciRX
X-Received: by 2002:a05:6a00:3984:b0:821:8492:7f66 with SMTP id d2e1a72fcca58-823ab692d78mr12130957b3a.22.1770054250352;
        Mon, 02 Feb 2026 09:44:10 -0800 (PST)
X-Received: by 2002:a05:6a00:3984:b0:821:8492:7f66 with SMTP id d2e1a72fcca58-823ab692d78mr12130941b3a.22.1770054249858;
        Mon, 02 Feb 2026 09:44:09 -0800 (PST)
Received: from [192.168.225.142] ([157.49.220.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c21112sm16210367b3a.54.2026.02.02.09.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:44:09 -0800 (PST)
Message-ID: <1bdb7797-624e-464e-b46d-82f5d089da8e@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 23:14:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Ranging support enhancements
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=6980e26b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=QJnItKZWF5a8ZOS8l1mWfA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=a3y4mG3raMVpnNqucggA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MCBTYWx0ZWRfX2ojc/OHAKQot
 VzAi5AJKQtHQ4WyF+8sVk2rlf5KWGCQ2kwm1IIA2JYXRlGsL32w+9JfyRm5pzzvw4y9mRFo0pbQ
 V7g77yHdVTMPJyXub59OL/12xGNsrDhm9l98bobLIOuGlkAFz9zilu8eHmMUeJNyiwlvS2w+nJN
 xUliN0xbrOJEKk+JpQSiJiu4HzTnHSJpALexzOhqkhJ8uYmyoRJkO8QsP+ASDdg9d8BFxZgDYqx
 zcwBbWzooWsiDKGcZk0JQKCor/lNzkDIMCIThfIFBuW/IXHZcMdfy0jz8axAPwJ3kdBk0fpttqi
 rk4m4+Wq/8VIaLzAqFQveHRYKQTnVqwdztfb2X5XTZt9chDLlqhQVYF6kpHemteI5ZJb/RPp+Pu
 SZLAQgNqeLftgqFAAQhvbz0ViL69QcUVcYyLJ2cOB6QfW5ffzgh7HVPnIJZmnkeUdSyrJMbKGh+
 qH4OR16PKl6VbM1ZieQ==
X-Proofpoint-GUID: fFEMDTnNUUXWmLR5ujAzG0TYk7JY0OMt
X-Proofpoint-ORIG-GUID: fFEMDTnNUUXWmLR5ujAzG0TYk7JY0OMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31476-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 995DECFC36
X-Rspamd-Action: no action



On 1/30/2026 9:30 PM, Peddolla Harshavardhan Reddy wrote:
> This patch series introduces Fine Timing Measurement (FTM)
> enhancements and Proximity Detection (PD) capabilities. The
> implementation follows the Wi-Fi Alliance "PR Implementation
> Consideration Draft 1.9 Rev 1" specification and extends the
> existing peer measurement framework with advanced ranging
> features.
> 
> Kavita Kavita (1):
>    mac80211_hwsim: Add support for extended FTM ranging
> 
> Peddolla Harshavardhan Reddy (12):
>    wifi: nl80211/cfg80211: Allow RSTA role to be enabled without LMR
>      request
>    wifi: nl80211/cfg80211: add proximity detection capabilities to PMSR
>    wifi: nl80211/cfg80211: add continuous ranging and PD request support
>    wifi: nl80211/cfg80211: extend PMSR FTM response for proximity ranging
>    wifi: nl80211/cfg80211: add peer measurement abort command
>    wifi: nl80211/cfg80211: add role-based PD peer limits
>    wifi: nl80211/cfg80211: add ingress/egress distance thresholds for FTM
>    wifi: nl80211/cfg80211: add PD-specific bandwidth capabilities for FTM
>    wifi: nl80211/cfg80211: add FTM range report negotiation support
>    wifi: nl80211/cfg80211: add result reporting control for PD requests
>    wifi: nl80211/cfg80211: add MAC randomization support for PD requests
>    wifi: nl80211/cfg80211: add LTF keyseed support for secure ranging
> 
>   drivers/net/wireless/virtual/mac80211_hwsim.c | 141 +++++++++++++
>   include/net/cfg80211.h                        | 163 ++++++++++++++-
>   include/uapi/linux/nl80211.h                  | 177 +++++++++++++++-
>   net/wireless/nl80211.c                        |  87 ++++++++
>   net/wireless/nl80211.h                        |   1 +
>   net/wireless/pmsr.c                           | 194 ++++++++++++++++--
>   6 files changed, 738 insertions(+), 25 deletions(-)
> 

Pls add branch tag in all the patches in the series.

Vasanth

