Return-Path: <linux-wireless+bounces-31692-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLKJJW4Ji2kdPQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31692-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:33:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49B119AB7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D42302AD2C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2703164A5;
	Tue, 10 Feb 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fMMxRkfu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mq+HsdBN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0F3161BA
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719595; cv=none; b=mSTTnZ0HwjF6XCmRc4LbZdUqEJ9UBhcwoBISbJozFJ19fk5CVJ65GAiNk1zJdwFdFLZsVpwjbsMqR6IZNehjDeDL3h1GKSBqp1WUzcvbfo+CSDlb9TG0C41tLLgSB+w8bJcCmwWi/GZ+ZrHnzdg+UEx84Gf0sjSSErSr7lYhwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719595; c=relaxed/simple;
	bh=PZ+4ms1Od0a8P1/IPPsrMUIY+oes6VKZIRrYWrRQQzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJgbTKVl7DKh323hh+ewhzywxHLb91Sw8V6s3hJT+t7NFzkelnzTtuxXfYV0IRAXDuaHFzNEeSnmmXrsFGpcIWBIyhVNDBUsTxK7PK9lgqyw31ktgo4W999GeYtGV+z0wvk78CN6nRHXg0ooNHiPA+3rx7AYhHChC8ESg857kyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fMMxRkfu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mq+HsdBN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A9dx1w4102820
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j6If+2LyThvOC3FTVjXwlB7/vXOs1LKQfOLUoUxsMGA=; b=fMMxRkfu2p6Wn4FZ
	K/bac3Tmv1gGo5fwmDQI9EZJXTWBCc1kRA8OeHt+GQv53iYp25Fi/tncqeCnOidr
	3r7n5PCg3TK93gwfPmYNlQm+jxWhWUGoLcx0kzbA/SnKB0FYLAPsOSbMVYpQVmRm
	jelQx6KRROXmltuHPFZO+xTDx/T66uLtFT4N7J8XXJZmOH4D+lf4odca3eIAg4Ez
	/lOXnhWIv1AnEAGr5JiN8CHbMQI1rrpRFvamc4Cus8cDJFyxjpGKOQJ3eEGYA+4h
	dRnzErPLakUv9Dmb9GiYSnhfqGhJVSGiVyBa8zjb/yPQ0urWV0wFLXQ2IflAKpUf
	1SV+3w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7k61k7dy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:33:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3562692068aso2056482a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770719592; x=1771324392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6If+2LyThvOC3FTVjXwlB7/vXOs1LKQfOLUoUxsMGA=;
        b=Mq+HsdBN2+kJRmbhK7TWGlEC8W5/28eDYlfWj85FvcFdNbbxntAGCY95TNFfRHZVF+
         mR70O3TRh/g5IIhsyID/rSzS5fjGTcd7Vt0Mx4Lnb4LDy+VR2Wlu14jZhIDb2dpoc8XE
         M4i2nccU8QQPec6mWJe7Ilc6i/nfMoHtReKNeib1HJNb7iRHVWavPB3LoCZlUcjqnmAH
         DRuvb+z4OagL220wxH21Oyma84VJv3LrZMI2FLaKip8uXn2hsvLH2NGXpojcgxsao15D
         Q1+YLipYrKckn+dtABVfMngi3Z5Sn+a2uvhJSDT3cRjwcUbnCheHod+IR3p9FYYKygZ+
         MAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770719592; x=1771324392;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6If+2LyThvOC3FTVjXwlB7/vXOs1LKQfOLUoUxsMGA=;
        b=PjWYlrQAx9smJSDyTL6y8ygArIdiSTdGCn4XeCIl1hgku4xRGfe6AshAs27oF6l7pJ
         QuF4MQ0vmNW5mjVogeHwZ8NtgXryVPECthJmPFf9+59ObVa1qcnZyTA7Zy5s1ORWAFNe
         zG84v1NJWWmEevnDWmu0hJapD1i/bURS0EgRIYk+IW5GWQjluL4SB0bIiqAFsVxf18tT
         dIsIhz1dYz+JTFCMIeVsWXyZ+CmvJ+efI9WFFTHqv/MQqS+tUJaPcsVEmKYC/A9eGIyx
         ch0EEud8BLdmYZMpvg5MsNG4LnSktK1dwAzhk7jNbH99MHcH6Jl6Kx2DwgQtA++kWkCF
         SpZA==
X-Gm-Message-State: AOJu0YxCRNx/iZukicvHo/Su2j1V62d2ctAezJqp3nh6zqPs/iwn2Vhj
	T542IRKsDzlgpV3A2/drLsPpS83kIhEwf16sYYEpe2Z9bfGpTmesic2OGhtMPoVwlN8QjBRQnYU
	/vWk3v+oXNTIeN+LGTmwsFJtnOmh3aYM73M8wmrOnhXdU1yYoMGdkao3DqTDoD+mARbRNk1pyoU
	C4pQ==
X-Gm-Gg: AZuq6aLx/oRtDwE6+42dqJbAt3LUhBLTbUaKjcK9PAX90GGFnce62TJNySto4y6PUiZ
	ygmyqmIdHsE06hDcmJ74qGe9761cG6omqUt/6Fqq5mcwYsfYlxwqGGP4UtDAbO9zVjYMbb4ELko
	guFJszNaoguB1sUum/04Xge4y1bEMWDxr7VqHUiKuRz4wA38wRRyIIpS2mAOBeSD57SGtqGSkX+
	zeLIY5puxMAiGJiGD0zdhNgLxcKxgFu37CVT9aDxTzZ0cO0Ls5QZ6F7UXOMmBxWo+4yUckLEQaj
	SjcjaC0lai7N2lNjLVjD/od/P2ua8CKcwppyg+ftON93UStha1/iEGodiwTEH4fyE+BDtf7Qoq8
	ZlBZlftxG4c4vz+IibQHV9D/bc+mSKSD61An2qsF+UNIc30Rycd70y740UyFXeijs/wFUlP4Ke4
	GHucmvDBCqjr6dGKgr3oSCnFsTHbe6dwC/
X-Received: by 2002:a17:90b:4f84:b0:352:d933:5574 with SMTP id 98e67ed59e1d1-3566622a18bmr1691010a91.9.1770719592548;
        Tue, 10 Feb 2026 02:33:12 -0800 (PST)
X-Received: by 2002:a17:90b:4f84:b0:352:d933:5574 with SMTP id 98e67ed59e1d1-3566622a18bmr1690982a91.9.1770719591998;
        Tue, 10 Feb 2026 02:33:11 -0800 (PST)
Received: from [10.79.196.209] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e50d3dsm2142720a91.2.2026.02.10.02.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 02:33:11 -0800 (PST)
Message-ID: <7797f822-7743-446e-8bcf-e93511919f06@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 16:03:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
 <20260205112146.3997044-3-amith.a@oss.qualcomm.com>
 <6d5004e1e1af3f18c42c3a370db815fb4bf82b44.camel@sipsolutions.net>
From: Amith A <amith.a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6d5004e1e1af3f18c42c3a370db815fb4bf82b44.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M8lA6iws c=1 sm=1 tr=0 ts=698b0969 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=D50T-wDEKIOOzYLdNXUA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4OCBTYWx0ZWRfX00ZMVmfulVug
 00coaHiUI0dTEVtp13Fz8vf+/XswNALc065Dkjb+aflQ0j+S1hcKYlDpqYoa188tAVKE3KiZcsJ
 UqRjjAIKs8rLbPxDzZ2tn3dUw14TpPOQrRWp69P2zzN81b8unZRwjJn0IrIRhvs8EU6Wl/ApXKE
 Qo2pa1OMAqatgmnQMuv3fjPI68we99TRtyS2AFqkW55wszUsoUSS3LpQNDIMhmLMdPGKauV+AG8
 MTRpmJPZ0BOxuTbZvrJ95ZI85CPxK7Id+nrFqa3105b7ta/9+LtaR+cDKTWRgv0WSW6fqsvFQHg
 XlYodVO05tzyGwqeOkCOAj7/3STgGVU/k2GmIP/6c0JX+I5xvW+ZQtE2Vg8/NDaERPnQTGXTdNK
 NboSwObk4nWaYlYunGQJfn426p5mz2mouqqmilvyWzOvUHpDqb2C2jj8vWDXudgTE9lijnwk4Wv
 djhoxx28Dl5LKFK4z1g==
X-Proofpoint-GUID: pooNcRPRjG9qRqrHUM94ManpYnz-zc5y
X-Proofpoint-ORIG-GUID: pooNcRPRjG9qRqrHUM94ManpYnz-zc5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31692-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC49B119AB7
X-Rspamd-Action: no action



On 2/5/2026 5:51 PM, Johannes Berg wrote:
> On Thu, 2026-02-05 at 16:51 +0530, Amith A wrote:
>> +void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
>> +					 struct ieee80211_chanctx_conf *chanctx_conf,
>> +					 u32 incumbt_sig_intf_bmap)
>> +{
>> +	struct ieee80211_local *local = hw_to_local(hw);
>> +
>> +	trace_api_incumbent_signal_detected(local, chanctx_conf, incumbt_sig_intf_bmap);
>> +	cfg80211_incumbent_signal_notify(hw->wiphy,
>> +					 &chanctx_conf->def,
>> +					 incumbt_sig_intf_bmap,
>> +					 GFP_ATOMIC);
>> +}
>> +EXPORT_SYMBOL(ieee80211_incumbent_signal_detected);
> There's nothing here that couldn't be done directly by the driver
> (except tracing), do we even need this indirection? Caller could just
> call cfg80211 directly, no?
Will remove this in the next version and have the driver call the
cfg80211 API directly
>
> johannes


