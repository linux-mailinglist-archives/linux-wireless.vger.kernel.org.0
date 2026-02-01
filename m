Return-Path: <linux-wireless+bounces-31422-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NwQBGKjfmnRbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31422-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 01:50:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B9C48B1
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 01:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6C73018298
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051F3A1B5;
	Sun,  1 Feb 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LeNR+h5P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VItg6EUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D71A9FA4
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769907038; cv=none; b=RPTUAoeSL9+N6mozKGflnQvYdvViIeAqNSNMidQZiXA2zC4RMAITZH54QGeEVPRWWEYjnYPGYTT6vPtOoqeSA4Jnr7YoVtvOpHTiWnou1JC714ITyfcWm6+Mr8iH49CnDkSezrDy9d4mv3bi9qzdk9lZ+Vt6WcBKXDFdndkb4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769907038; c=relaxed/simple;
	bh=71BrTrXWCUNj1eFd5jLZJaml3clJ4O6Cjw9F3Gb3Wc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JR5ZN2oLHnx4tFhaxCipDUkrFNwxbZ7PiNAWZLZJAhpCwE07XiWG2cZZtzJAxlXLAB3IV16lMocIe7cFiCGM7E5wUnMVumCsOtiCMo0DUzBft6auy2YFYfh0lBF4/ucF11MkFABkSlhAFK51HqeQkkeoVod5//DKX/aebt34AMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LeNR+h5P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VItg6EUt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VMo0bb2655140
	for <linux-wireless@vger.kernel.org>; Sun, 1 Feb 2026 00:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WO68ftgee5z1/FLvwCAiJ99FB+rImqpiZw3u2Ej4rwY=; b=LeNR+h5PhdeOfK5d
	WjJx8eg6Lp0RqRk4E1PF+a8vo0DMAIg7eAsxw7XSyEg2dfnXZat3E2fbQyyIx2Ve
	+vDlmrNbf9ZVPa0qpb9QjWmtvlHtH/7V7NTIJtiN61p1ZDbrLBwzJqVhLkV6IS5j
	Vp1Oq3GZz5MBhrRLrbOjQxsqrQJDn/QMpbcf5tMrH9TtkBSkWCP+d3m2J6OhaHra
	ImYs5hr7i0f1+C2ECiijEbu1ltMGsh1mpmXHSlknuLTGXygDSBwIt+Ja0SbPMWse
	aOAz72FoKtcDxQEfRiRrXk+q8RFW6UUnjmVw2dFcDjxmlYkjrGGi1/LpRjXOoeJJ
	WUzIhg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrsst8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 00:50:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so3508150eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769907034; x=1770511834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO68ftgee5z1/FLvwCAiJ99FB+rImqpiZw3u2Ej4rwY=;
        b=VItg6EUtRQz0FH+g+UjjMVWNI9jf53Maj0XXoln9ayAdMzeyT2HIYl5dIr4VabrtQJ
         TQ/kFXQrVX/FAEIse9Zw6wsDSARq+j7grr34V80/dS+oZDWrH40U5tk4IeE3HssyBvvJ
         pwUEKWl8H70Tn42zZuJ19lQJ4myDCBKH4eF8B30huv8S3+1zSMSMdhn4/gaNVdWymJuv
         47TT9mRQt6hyLsuPHxwGuA9iEJjh0xh53iXadRdMjCXABhuUgetnGFn/6TJtTNZ8hPUy
         B7ER9aZaWu+1XersVR2cKLoS51DOMVgG079VL85uIZmzaPeUUeDmpFJzSp5kurABRppY
         WQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769907034; x=1770511834;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO68ftgee5z1/FLvwCAiJ99FB+rImqpiZw3u2Ej4rwY=;
        b=hhuzBoWnjAQrnLw5+1Tzw8RR2Jqz0oNuqCZiIwySnAIAwksy24urixmJQs4kEGqFsk
         s8MOHbh72x8yAq7d5bNSIAa2qvQwxclYiTbDeYqHP6rZKJu26STf98kiiSWEPwIwj2np
         s1b9oJmrETZKLB2AqJFjISGIpXLeOhXvkASp1TE9dH5i646JbxtoBqNJyJehMjM2bdDb
         hwBPPCeaf+RCajcsWi0aUuEdY4Aj1ihCd2kASkIwU7sULUP0HNOP3abdW1CAyMAqvf0N
         r7D10DX2aGhu07ozYvy4r90HO7zT70sl1wwzntfkRycNlHvz6ljk0BVLeqRwYBJOt3Qn
         pjXA==
X-Gm-Message-State: AOJu0YyGki1uGLUUyIbV7a1fCXb7ltEyTbHOrE/jFyLvSRfkYMTzHOiR
	zDIU7akrJTid5gsnGktvw6uTr3qYeeDbrtKWej/xDqv7unTOwWn+Ev4+Io3NA4eOAN7/Q4JpZC5
	mLkSwbTTPWKKrWCS7DgO1UQEajWTglNXggdLclmij5Y9VLGVbTo6IcQ4GGPWiAq4fKUGQoA==
X-Gm-Gg: AZuq6aLtSoGzxdXPwxRcBiNzVP2d/5pnXFj7jt6iYZjKFcodEqwUpRtIiUcCuEfUEA8
	JXaPBWmNcxtWLuwvT7zdf6PGW4wlc76Lv0H7fc9CJaApsF40iy0cmlSeE/BHrlVtXFr49ArdGaS
	VuP7OeW4L+hL5KE7AcGD8GRsCxzCQcmdJyJfrN0yJf2j9gVDLCNsnCQ+vv54rqxYOwK8MAZNTkV
	nJ282/DXyQA3tVjsaZGULYY7CPLjn9TGU4n3y4a+d/ZqZVGw6FgrNh0gjtazJx5W5fk6fDrc8vC
	Z814fnyeSXYkuVv0bbIgaMP2m4qe9MyF33uPh6dO+64wzBE7LT8o1pbH+YkHe/n+w82yAtsqqve
	IjU7ZT1FonXUUNgBnBYKXhnhacXHYnrOMO80xS4qbYbe3d8nD94A4QRkOz2mdABmKcJ5OKbvLj/
	kfFQ==
X-Received: by 2002:a05:7300:bc11:b0:2b7:112:42af with SMTP id 5a478bee46e88-2b7c86502bdmr3111096eec.12.1769907034295;
        Sat, 31 Jan 2026 16:50:34 -0800 (PST)
X-Received: by 2002:a05:7300:bc11:b0:2b7:112:42af with SMTP id 5a478bee46e88-2b7c86502bdmr3111090eec.12.1769907033718;
        Sat, 31 Jan 2026 16:50:33 -0800 (PST)
Received: from [192.168.1.40] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm14845692c88.7.2026.01.31.16.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 16:50:33 -0800 (PST)
Message-ID: <ec01c2e7-d196-4d73-aef9-e3ff7e6490bc@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 16:50:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] wifi: nl80211/cfg80211: add LTF keyseed support for
 secure ranging
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-13-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-13-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m1GTdh4UdcMLSx3OpNsfJYf7m-KfyiRK
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=697ea35b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7FOjyav-ed4h5hHbLlAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDAwMyBTYWx0ZWRfX5OuRiG3IFAf/
 LTQ+L7v0BK88NXDNkgD+zJSZ9v5+W/qzJ3WtVohQngknjd4JiD2OY6A9+B5P2SbJTcLCANANcvM
 Y7POG6TnrHhXw3f6s8l2R6gtFdP7B4VOWegu3ZAgkiFKS0HNoGg4Q7qRnIHKqK+oUolhbycbGVA
 aaQkYA3LmVvZBjAsJ1R6a6pFQY3k7ineRNaZqB+SDJsoWxKDb12toZNCBJtNCgErnkRFPdnF6A3
 Kw0hUCObi3Y4zxpE5/usfaDaL2QnxHkp73BWwHeYqKwtPOmhstXxlnMNzfqvn/Gc33LzcQ1ilCB
 Xyz5H17PPBPehpAOow528aGlrMFuaPcXGrLFH1UDltTtoiCAzHOWXGqTpj3NbhY1JSJD8j9FHRe
 Jj/hUAKRdc4B7aRnbkoa4fO2N0vDHXqEhgITKMXQjBh7sftafNCLpJVkIaWtfU+6hpp5nILIFin
 DQcvg8NRCdnagLcZyVA==
X-Proofpoint-GUID: m1GTdh4UdcMLSx3OpNsfJYf7m-KfyiRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_05,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602010003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31422-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 637B9C48B1
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index dd45dda7e619..ea6b9c994455 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -800,6 +800,8 @@ struct key_params {
>  	u16 vlan_id;
>  	u32 cipher;
>  	enum nl80211_key_mode mode;
> +	const u8 *ltf_keyseed;
> +	int ltf_keyseed_len;

Warning: include/net/cfg80211.h:804 struct member 'ltf_keyseed' not described in 'key_params'
Warning: include/net/cfg80211.h:804 struct member 'ltf_keyseed_len' not described in 'key_params'


