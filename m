Return-Path: <linux-wireless+bounces-31828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDbHIjcmkGkvWgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 08:37:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E544413B512
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4E030087BE
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196926738D;
	Sat, 14 Feb 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrcwirtx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QA3e9ioe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F81EA84
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771054644; cv=none; b=BdsPuGApVjJfNm2kImm1b1dDOO8grNNMNQZ8UXj3SjlwX4wBLscjFfu9bW5yiERi/lWIFk998x+speVZGv4DZ+HPflxo8x1atN6ubpWPLRlJtGL4UDJQ5S3wH8VJNeT6Ty+R7SiC/UdAWY50d9rv7YOuWiQTLpxSXMT15p/4Ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771054644; c=relaxed/simple;
	bh=J4fcRxX6/wSr1CKQtPMTCcLVCPSU+bctpLSPHnlGbLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFxWFi+4ea4LqSxptWawFc2+W7gKh5XlIHUGX+olXHoGAWVoD/4GRKkx0UziwQuhGhnr1hMJw/j7RPXp5HbvrlgMiMNiWdsNy/zjxud9fPNQNV/2mL5fJRVtmnSHQ82H2ieDeYCo9La7wM5wyi7lbaF1fF5Kta2diMJ4xmwdG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hrcwirtx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QA3e9ioe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61E3jr0D1528251
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 07:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GvxcZvvEBjm9bUU8lv4oaTRMf+a6jsG93iUdGq5u5uQ=; b=hrcwirtxAjzmTJi9
	HrBT3r20bXrtMh7u9Za/twDpyWeGMhqG4c0vgfQEnF8fzJPq/dLai/bhEeESBmT5
	P5d+prn3VT/Mri3pYa8NOLgeSJv2r+WmzDK+m/ZrvFiwWbcuaQhGLtcLCNEkpxuu
	kJ4NxlfC3OjUDanCki2ubBAWt4F7zc/ypcR76KxAFHlc33EavJoLiYShKy6a4Rtj
	uLtWITQK/eB5XpzA0YFIRcf4VR0/DLUtxtWJ2su4FTmV8QQTQvVCNX+H4LRzpA/b
	kVp/Wfyon5qh2N4Omw17oapoZQLv0IDdyAyKtKF0L40exadIAyS5tP3i1j0DeXkJ
	GCqVLg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cahe60au2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 07:37:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6de1ee12a3so1264946a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771054641; x=1771659441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvxcZvvEBjm9bUU8lv4oaTRMf+a6jsG93iUdGq5u5uQ=;
        b=QA3e9ioefNLDy3OlpQTIHh0HWU8fX/ldQJkms5KiVLowZb8Xm35lCdRn3VtJRdhbg1
         avar/Yi6xXhGv4APjqrTRJM0E74jDjJhpBgcntq3r9N6nj98kjHkZ273W4MVednTqOQc
         yIABgWU3bo9Oqo9Gesww6RVmh66NkSI+GCbKnjUI/4Rlr8Q+mk6P2KnJb6rZXGHRJ6QB
         QOO7GioqYj2ZmlOYYV6J9r6hLgS05mq07xJpQeodE12b3hcEeTSi00rP4tFMK2kP0OcH
         hc2aeE86A0LWNX/YrF5EdymNB2kukvXNCbIVQ0Lrc6u5TaecDYama+swNj0I8O9wP7KO
         9e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771054641; x=1771659441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvxcZvvEBjm9bUU8lv4oaTRMf+a6jsG93iUdGq5u5uQ=;
        b=t9w+cdWqVTRKKQ4EvkSX1MJI0X2fduUgH3N8JS9apk2dodt1AuQQROWNJ7xhHJsfU4
         Aa/UUPRUoN7xt2jxmS2tMKykTNqUgGR11D14zjnOxt/iwPn5wH5P9FfQDvw+1Wu0jaqh
         4NGhNSGjuRp9DjtaGyRbLTXoumxfxfYpAvoEyoEOrKZk6ntNqP3BW6CfvFJo6qg1Y1ko
         OjP+ZyMmTnliey+9a4HTv4yFaS7mliRHeIaSXut+yKI0vywLuweUWzohx9dd8yyHrs4M
         KHXd7x8j+rq3f/ni3KP0IwDxWBj9Y8NNQ28T9WLVaM/qRzB4PVW91vR4LUU0C4x9arDc
         XQjg==
X-Gm-Message-State: AOJu0YxIV/3afRQiAnEmAF0sU7lJsv0bHpPDi7fhpQNo994TboU77LvI
	UrHQJUnGrUinUVglUA5mExnAJvylyh7Nk8ah1cvdoF6x+KNdj65ycU4sI0rBpXkh6lGRZZx4Fd4
	neAui4JrYqGklhtUts+K/lBQG1kMy/DuYMNoEoO1MBbyaADZehGJbywbHUyyEeRo5cNuvAA==
X-Gm-Gg: AZuq6aLpZCfoVzrUUsXko3Okvqdwxus6IkbYgpXoCv0EK86NROncC2IxEFh9xc/JLFY
	FaMUMHzyZvCQHZhemQMzdORg03+UgxD/d2vFjt7QsO209dRSjlqabjS+NwTrqNzC4hnBL2S5shO
	KMsARPQSgnGp4WgvPPsVnYbYme24lb8gjWNGuZH2WajHXEKNl9aVolz1y4Cp7nna4K+aKeOHyMu
	4zwEHZxKnPB12UeEUoM0KhJY1H1lgPk/7+q+A3CHGOc93JX/8Mmaul7xcEC0KXDaNAdMrh35oIi
	B8BjGHfKS8ZAtZ7hJLKAqRrdmr3JCCK0tIQgZ6PJmQBR/e8Tl2LN+wAIlfzqr3r1C7jQlTOl9AJ
	ldoSVOxXHsC33XZ2QAah5ptak0WgURz4j3ZK0YL2lNvWjooykvP7Xlq60LIWS
X-Received: by 2002:a05:6a00:1a17:b0:823:b1f:892e with SMTP id d2e1a72fcca58-824c95bf74amr3470194b3a.43.1771054640789;
        Fri, 13 Feb 2026 23:37:20 -0800 (PST)
X-Received: by 2002:a05:6a00:1a17:b0:823:b1f:892e with SMTP id d2e1a72fcca58-824c95bf74amr3470180b3a.43.1771054640310;
        Fri, 13 Feb 2026 23:37:20 -0800 (PST)
Received: from [192.168.29.35] ([49.37.217.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a29f0asm5940018b3a.9.2026.02.13.23.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 23:37:19 -0800 (PST)
Message-ID: <eadfa734-d74f-4886-8e2f-f3e1c1ee2faf@oss.qualcomm.com>
Date: Sat, 14 Feb 2026 13:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: set addr2/addr3 to link
 address for NULL packets to non-MLO stations
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
References: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
 <20251127140555.472327-3-suraj.kizhakkethil@oss.qualcomm.com>
 <557aea3a06c79c2d2e04649e43b48e0733d26347.camel@sipsolutions.net>
Content-Language: en-US
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
In-Reply-To: <557aea3a06c79c2d2e04649e43b48e0733d26347.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c5WmgB9l c=1 sm=1 tr=0 ts=69902631 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Tm7PKa9qPvAg+GBNAN2/+A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=hEjjkmx6ICMAIO4WIskA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: tFkPznUM6u-gBMhQPOXW-xhwvOChMFGX
X-Proofpoint-ORIG-GUID: tFkPznUM6u-gBMhQPOXW-xhwvOChMFGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDA1OCBTYWx0ZWRfXzGyqs78JCHwx
 ZXTckFl2Zs3WdJUQWHsC4V2O2zVFtZFtO4hYvAanhXl6sKM8xtco0Y/Y5cgg0B/8pDd2sDOM/lV
 ybMgbBX0Oo/KyTgTcwzdhnbhntDBMgY49aRrlexDesdTXvubfoxuaGbByb9JhLQqUWgDpPDMnaG
 Nmnoqnb6BrinZb+GBxrFGNoNJhNx4glsv6ZCVq/bijgqvEqTeYgUVElaoBZPZRWY2Cd5f/DjLo0
 kAZLQxH7Zzk83pXra+T2itpYMHr2waTUZSQ489lmA1DbzztGBt35ypcF0DJe6yWju/3WrxurvFC
 lgQevjYAvtlqEmBW4rYz+e208fu0NFuz4B2Dk4txU2hJlmm76Ufwqu8C3WKxeNmA0FQsecC0wEA
 QrImo6AS29jbmY+jgpv8qggInVmypjF5RphJEbKy8YlMRKqA1OUBQXYbb8BSqHxpLSgV8tLkqyM
 Uy/p8FE5EQDiY1rfmIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602140058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31828-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kizhakkethil@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E544413B512
X-Rspamd-Action: no action

On 08-Jan-26 5:50 PM, Johannes Berg wrote:
> On Thu, 2025-11-27 at 19:35 +0530, Suraj P Kizhakkethil wrote:
>> -	if (ieee80211_vif_is_mld(&sdata->vif))
>> -		info->control.flags |= IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
>> +	if (ieee80211_vif_is_mld(&sdata->vif)) {
>> +		if (sta->sta.mlo)
>> +			info->control.flags |=
>> +					IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
>> +		else
>> +			info->control.flags |=
>> +				u32_encode_bits(link_id,
>> +						IEEE80211_TX_CTRL_MLO_LINK);
>> +	}
> This whole conditional logic is now pretty messy, and we (and the
> compiler, for warnings) have to track that link_id is actually
> initialized on all paths, which seems unlikely to always go right ...
>
> I think you should set link_id = IEEE80211_LINK_UNSPECIFIED or the link
> according to the logic earlier, and then just always u32_encode_bits()
> unconditionally.


Thanks, I have incorporated the changes and sent out the next version. 
Sorry for the delayed response.



