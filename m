Return-Path: <linux-wireless+bounces-32212-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAp7ApaEoGkakgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32212-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:36:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C41AC8D9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878223750D34
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1ED36895A;
	Thu, 26 Feb 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mk1ZiBs9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GUnVouLF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356842B747
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124588; cv=none; b=JAhXTdoqbX+042OryJa+IDjgxBhWMKDz2Ai2RoCkN0kWCemRPx4BWdus55JqfV/bz5pAsrfq0r1htcUxPL4CYemdhqBCO97W7nlKomVkaEY3PUqQEZL7VBQkL1qkIRCiI0++IOAK29tazzl4icV7f0PWoyU5SpZoD1X9MpVXMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124588; c=relaxed/simple;
	bh=mT46JMx6a6wWt0qTB6qdLerv8Sb3Hchw7kHgGLQ1GSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0NIGyIENwpeylK6EzrQw9s5F8klsBexqYxkeLMs1sC53T+gTkSCaXwtIgC/308Cr1M9371jfjfd6uUHwfN+yOotDENRcYCYMfGr5nz+qe5pvOCecdA6cOj7aXTquat60C5Nh0LuSHrg7xJwN5zE3X4CQN9fGJfYbG5XuYkAxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mk1ZiBs9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GUnVouLF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QGi26I1117359
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A+nThfeLCP259t+/2IwOeOxDQ1NX5wMFogITQX+GDLw=; b=mk1ZiBs9ca4L3Y1/
	wP5e1u8PTDL9f5P5nGhhTWmfWMMFQ3WQ3KY1Cngg5D8UgyBZ9GvOaNJvRP3rBIBs
	WVXfflIB530fVwbOVHJhi/PMCWZ04BcP+BtjYIYlp4nnq3VDV7lHIAwlQAGXSmD8
	WWtRJG3ZV/bDM4lxAqQP1InC8mExfQX50QFy50L3yE8UyUldx/SFOLcMPxZaYHms
	7nXjza1s02kBQT+A4I0baiJGCyN20HnXSYEl/Poyd6viPN+I9bjamNV63GL5w/lm
	DWTWO8xszCRBbbg7wiV1WRqwIJpJgPcriP77QvjkeMKWVmL3Jf1yuevlg7S7UCHq
	RENCKg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8u17qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:49:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35658758045so689238a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 08:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772124585; x=1772729385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+nThfeLCP259t+/2IwOeOxDQ1NX5wMFogITQX+GDLw=;
        b=GUnVouLFPI0JDgc/ZU2gxIpdqH6XyLpyuqqFAK2dEYW8jKYz+A3xvbcVeYzNmuJqV0
         ziKTlmKzJYhvy929bqgvpC8WK2Kc0lJNUeRyhHrbSwJ/U+Sk3BgBXkVa0G5TyU5zvabu
         O4jKM99RshHxfyeGqhVQNs0DZmfj3waAp6rp3I6IKygWEdJHBlWudNRVJf7DG2kLVscX
         uov4KVAyIBsJJ1EX5uNLDy2wGo8Vz46kMXrs12NhLHootegI8LS6qqPfWmtwNc+LpeAs
         MsyN5HorAZY/qD+bKwIMqlbssbim+I3ghtvlNGtcmN33bIKYuXv8wxWHDvM5F35OVqrn
         Okwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124585; x=1772729385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+nThfeLCP259t+/2IwOeOxDQ1NX5wMFogITQX+GDLw=;
        b=XRMTmyYznaxoSCa44P3E21AYt8DugBmC3c4ycix8vCQ3lB/wl/a8iKIfyaHDymR+vZ
         Z+KaVU5DT4secNvnRO+G4DgV4ppwT/mXyEpy5Ap7R/iCOaUEkVtaeSwg8qq6NwcP0k/g
         8T1gg7ZV6UDK8AYu1ScepAabalChHD2RqACSQLu8fBw2y76AxjJr9uiIU09aXHlG4enj
         IPNETwTeQQN48RulQ2413zntEO84NlmM1a2pE1W2RFLdZ/VV4z4mclI/VaOm1ds7dtoR
         KFID0JIKwaPFgI6t562lLSU2RwKqIHEsrU72MKk6XwsuD4Si3GdJvvllHA1OGPVOEfe+
         Ieeg==
X-Gm-Message-State: AOJu0YwxM7miovSoD2fmKSR20SRi+3frqBldGfCp5c5uSYPcL4hu34ZV
	y0rq+Duy5WgAXNo/j0JJFQXLUbAOGOisEY0F4TEmfMIE6IoS+1zH380cF/lnruDuzVc57k2+G+d
	jo1y654fw1zKWRCghHD6x5Acmt/vZ6e1uSKOR4kA05pJKIsgH3G/vFKC1vXNoPbOESsphD8IJ/O
	u6Ig==
X-Gm-Gg: ATEYQzyOcmdoWfqgEfBH/b8LSCPXtTA0f5+QDdDuMcYgLzwun8PJ4F23esAWjf2JSdu
	y0UhLbCyxp+0ymNgdI+un+EKqDkDe49Prdq/RoM4srVS9pcbq7M/CCdH9X9fMUQGGfgTOCkaXb1
	jPTr1O2HCBKBRSa5dWbiIEt1DXSlR/0dq7VeJh8LUkm7pBr5/tUlwfazfiKauWrfCAafFMR+fof
	i2fNLVTrZHh8+Rbyd4LC4cnwvGxGg+tP2XUKTsUbPR9JSnYE+uGvFrHeJez+sWQ4Adg7MAVmqPZ
	p+JCxEtFkYD6umxCtGQP6tGdC0Qj49i6IQXgpsUYKjKOyNg6WDCzL7X6dL1Y7YmxreIYdJPHHaR
	BXXuNGF6OnIq+blL6XIF6hgS2uiFutPf43rlU6wsbNfGhAmSd/CfFwVA=
X-Received: by 2002:a17:90b:1fcf:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-35928a5f6cbmr3932797a91.8.1772124584771;
        Thu, 26 Feb 2026 08:49:44 -0800 (PST)
X-Received: by 2002:a17:90b:1fcf:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-35928a5f6cbmr3932788a91.8.1772124584242;
        Thu, 26 Feb 2026 08:49:44 -0800 (PST)
Received: from [192.168.1.10] ([122.177.243.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm6493306a91.5.2026.02.26.08.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 08:49:43 -0800 (PST)
Message-ID: <15cd54d4-a663-423b-b4c5-9a058f5bc73d@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 22:19:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise support
 for IEEE 802.1X authentication protocol
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
 <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
 <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
 <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
 <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1MiBTYWx0ZWRfX+H5VMfyRQhPa
 vo5sg0Bi6w0U2fpL90TB6p6fImysUSksTsW5CxGoW0GZ4plz0P26thrGgbdGUAu9RjgghveSlOJ
 SOiiMwnwGrf5LXNoeSUhk9IXBXypWBUxJbGwIbx+jv4sLuANz6MbKvVnN4/Z0RGDObqYNBANc+f
 J96cZgsAoD5C9PRXM3K2Oq3SDecp+jpVOUTw8q0g9MQVIAmRSdcjbaOtDf7PhoiyWw/vPRPKWA7
 KnTZncVQUp71eC2kmbGa/hriB+uBHbxGUhczASjgckGalbfKj5J4vi1nZ1PreUOecqZEILYr4Sa
 /gxvdtLHNe/uYsu/ee3fqgqQKcKJQwNyXPUR/TyxU8OxpmGjE9biCnj99St7Keus9EqOrB9wCOa
 p2cSJwQoo5PRsX/PCHy8VajfDkTsMBnD/emvGixIc5IM9BZlcbJ3NA4X6grOHG3XY2rTCVYkKnl
 c6Xj7SnM38LQ0d40hRg==
X-Authority-Analysis: v=2.4 cv=O780fR9W c=1 sm=1 tr=0 ts=69a079aa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=RvLD6kXmVJWkDpkbezg6lg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=dDlXiOvfcutDdIe8n8UA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: O-17fSMz8AMgKcU9eJR6fm1XPloeMJck
X-Proofpoint-GUID: O-17fSMz8AMgKcU9eJR6fm1XPloeMJck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32212-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 540C41AC8D9
X-Rspamd-Action: no action



On 2/26/2026 7:23 PM, Johannes Berg wrote:
> On Thu, 2026-02-26 at 19:20 +0530, Kavita Kavita wrote:
>>
>> On 2/26/2026 2:06 PM, Johannes Berg wrote:
>>> On Thu, 2026-02-26 at 12:24 +0530, Kavita Kavita wrote:
>>>> Advertise support for the IEEE 802.1X authentication protocol in
>>>> mac80211_hwsim to enable testing scenarios.
>>>
>>> Do we even need this in drivers vs. mac80211 just setting it?
>>>
>>> All the code for it is in mac80211, so it shouldn't matter?
>>>
>>> I'd actually argue NL80211_EXT_FEATURE_EPPKE is the same, mac80211
>>> should set it instead of the driver (I didn't merge [1] yet anyway) and
>>> only NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION should be in the driver?
>>
>>
>> For (Re)Association frame encryption, additional changes are required in the
>> driver and firmware. Because of this dependency, we initially thought it was
>> best to let the driver set the EPPKE and IEEE 802.1X Authentication feature
>> flags as well.
>> However, since no lower-layer changes are actually needed for EPPKE and
>> IEEE 802.1X Authentication, these can safely be advertised directly in mac80211.
>> The driver should only set the (Re)Association frame encryption feature flag,
>> and mac80211 can then conditionally enable the EPPKE and IEEE 802.1X Authentication
>> feature flags based on that indication. 
>>
>> I will send the updated patch set with these changes. Thank you.
> 
> Right, works for me. Can you please also resend the hwsim patch for
> EPPKE/assoc frame encryption then, that I linked to earlier? Feel free
> to just put it into this patchset (instead of this one) of course.
> 
> I'm planning to apply the AAD/nonce fix soon, and then this can go in.


Sorry, I missed one case earlier. EPPKE mandates (Re)Association frame
encryption support, so we should only advertise EPPKE when the driver indicates
support for (Re)Association frame encryption in mac80211.

On the other hand, IEEE 802.1X Authentication can operate with or without
(Re)Association encryption support, as specified in IEEE P802.11bi/D4.0, clauses
12.16.5 and 12.16.8.2. I am thinking to advertise IEEE 802.1X Authentication
support directly from mac80211, without any (Re)Association encryption
support indication from the driver.


> 
> johannes


