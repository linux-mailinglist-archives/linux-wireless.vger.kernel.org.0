Return-Path: <linux-wireless+bounces-35462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L59L8uE8GlwUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:58:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFE48205B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCDA316B832
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEA2550D5;
	Tue, 28 Apr 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dm6CWF+B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FA0V8r3Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53F2D47E9
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367867; cv=none; b=u7vok5h+fESZ56rdDEH1UBsxMUJNqXycOjSCCfuWDm1iy4mhxpv81CZ55jXYAI/cR/ZNgDT/+2K3XRJUOc1e4TlPgD6FMgerLEcIBQFzFHoKBvedH8oVtVqSQA3nug+VPpK5wzhnjKOSDBdK53ON9QRnfWPwVFtb0zkHLR3amD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367867; c=relaxed/simple;
	bh=/tNJHR2QHwq8T9fhOMSyiPpV8MWyVVEz0IixIAVSd4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzkqs4cvn7uiZpJTZ6lf+zBK43XHn4K3ly7BaP9hGd9sN41ImFmjZxR1YIJ4jhUfDmJarFVwoY5CszraKakTnHbvy4dMG9q+RyEuoZKTuwz2kRlErwXXxRQ8M3cP2QwybVNXFcGiV5vB9KV1zTZ8sgFB4EpOqZbQUBC6BuJYlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dm6CWF+B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FA0V8r3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S42xua1329658
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RpYWAkdN7rieA60ORfT2K03Z+LJAuh5GLkhLpxz8IIc=; b=dm6CWF+B1gucVTfm
	nKpL2VyHCQnICkJmAbuk/AmFmRVs1vzHymqGSOg8ND/piXbhXBaMDPcGOC2lDdWI
	VEyZbNSnroSsB9A4hK/TIGJT9YFV7oMyfv2IWqZwDkMz5X8cpJugSvyq/FJEc+FJ
	3qjlBY0x+hyvLKUvpOTh627uF5HT3oJZGPtjrtaMImD9OZnPyJyXbjZQHfEFOrDe
	wTdxWsdaVma3v5d7+BLtcKN2LqJbiTiS19o4ESqlfymObLdEAuK1krPdzCgYwmbL
	V5H6gRECfSsHApgZkh3/TYjZEzbpnzCD7ACLS3AJUzSG4Al3c5WvVj1+IuGtT11K
	dyQ4/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhah44a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:17:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso12759742a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777367864; x=1777972664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpYWAkdN7rieA60ORfT2K03Z+LJAuh5GLkhLpxz8IIc=;
        b=FA0V8r3Y87mwUk6iV5430Wmn/Re9awW4qfjzNn/cWRR4VxbEIG1/jzUfDYBPrbErMj
         3JiIAVhvsTRcV8EtCCZsNbSMn2fMDJ1e+xoDp0CfN5cdSG3cokN491hBqeQImzy2A4Cw
         WMhNfi+GZQmw9KQvKBBYC06e+U0T2s02LkniAoYZo8TVKHc4m5P2F70yln9HIg8/eO6i
         bRBNiwMC6vZOq37zUsEUGXkycDr3yJLDj3XjLQOOo+zvFVlvSH+wdqU3iHjUtCNDMhjc
         KuOxwaKrry3PIX8JYPj4Py0CLw9xl2qSkH6G6anv8XSIqgtiwJe8mr6oA1wFMSfP2TGy
         2wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367864; x=1777972664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpYWAkdN7rieA60ORfT2K03Z+LJAuh5GLkhLpxz8IIc=;
        b=qT4IK9hwl0Ga8BNAxyHT0S8gfhZ4lDLcYgtw5ANRRZcwZNVEzkR9v/LNYA5i6A1cic
         K666+1DNHa8UtjvunzeCFPHa6EjmdFBHnNbRGPoHqFKA9E3tJFobR/VsSvyCPgWu7lFH
         8OFUKL3zfetWeR/tKkOfwcAnpUucfVWuJSdnzYNDcXq1Xm1nLvRNgo46zop6jQfDtOl/
         YMrvjtweProEDYKCmOyZt3W8Oo7XWBCT9rJQM55oAj58KAAE+VxiF9QWdAxZoV1zyjsb
         B6qICY2tUMK1IFwvLWCds3OuFPyk25Mbl+JWuEg6oEKmzNC01KylH0hYgAMpR8CJxkfc
         w5uw==
X-Gm-Message-State: AOJu0YyVKvJuVzMBmSrLFwHdX1bKi6VCiVcJC9Mkpzu2mN0RzdnYvkeQ
	uZGeDuKLDDK50ELLl/kTkbE99XyqKP6JzyMmqu8nN8KtlVni57wFS74u9yysXRrnjA8jOZYDS37
	njnS0pCqRyOSdcSWXOuHnu3MC5JPAxB2mgcjL18ERNo/Hx2IUID1AZE2JBCpP/8BpmwzI6cEBNc
	+zXA==
X-Gm-Gg: AeBDiesI5pmfc6wqWWlyY/hqMBg4I/flA0YtHoN6xO8rjzyK63zGOIs3HEEPB6e6Na3
	YhxOa0BvooKAf5VXkeIISOX2dk8il0WBPS8mgFDaEJeoCwIF1fSv1kyzggg63KQKfP12vwMr0ym
	2HMwFF4sHv8R6ayVmEwbgMd+k/Nk7qsG3t6vIzbrbvFuOkwEwUtOA02WoNbV5aDxEZcPKCGMBzK
	Ooz7a7edeHbcxQAPELzgzTMwuZtWPSXdaiDqrvwfnTV9zkWUS0g7xezJqPUnC8oXlpxNAYQIbOa
	RaJU+J0PIClTSUdv26Non1DQBU18T0/tMPcpDXHUqwReaM/9/WFM38J56ekrYplNjbUvWrPd78R
	xoC0FiN3Gf8mML94w1qXZjGCQXVyISLFOcd1QoMcOWOELhXo/LG7E4N5qJS8picXE
X-Received: by 2002:a05:6a20:72a4:b0:3a2:d436:aca7 with SMTP id adf61e73a8af0-3a39c2888a1mr2989328637.40.1777367864058;
        Tue, 28 Apr 2026 02:17:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a4:b0:3a2:d436:aca7 with SMTP id adf61e73a8af0-3a39c2888a1mr2989298637.40.1777367863565;
        Tue, 28 Apr 2026 02:17:43 -0700 (PDT)
Received: from [10.204.116.209] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc29b73absm1935201a12.10.2026.04.28.02.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:17:43 -0700 (PDT)
Message-ID: <72d9d5c6-de7a-4ca1-9d4f-1df82afc4f58@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 14:47:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: indicate
 (Re)Association frame encryption to userspace
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
 <20260427150735.2391680-2-kavita.kavita@oss.qualcomm.com>
 <0fb5e4ef6fca8b099fa0614085dd8b3acb911510.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <0fb5e4ef6fca8b099fa0614085dd8b3acb911510.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfXznKAHnLBwWH4
 ttVRAbbZH4M97IJvUypozAlAVdqvGcgojqrX29gC10BlWfz5iC3RRGmTzq/+Qas+iwzKnLYF+dG
 NVD8Og1l8D0RjZORTMtoyaawqRVmRKF2bheJlbaIiC6A/uTdo7glmSzXRV8jeI8pmUUQ64bf+Zz
 pb7rPCO15unEaUmzrtmN48DwjD2F4DOVIVkLFv+QWi4PlAYc/tpeuegZReryqdzxHRmrnCWuUJc
 D8bxggecxsNSMZiXxUhwUTgdAuuu106VMhIVGySnVp95JO24Jx5IKfihIMDCynwBynXyT2lhree
 t3WGh55UpvicetZnHcGOrBl18kVKWUAp+Sa+X2a7uv82F8oEu1gmWbdgagPEXMZWeq3wF/A1N8y
 zgBXbfdITwpAFByHM1yVesiy1C4Nf54hgq97st7eMGIx9x0SXb9QuUvy1c1Sol7ogDZ8+2YXleR
 rVqaxsltdIjkRz+SG+A==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f07b39 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=12pZ6qSvWqqQDCh3aTgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3U6hS9YElAhEZlr8Ppuya3wPASoisMfh
X-Proofpoint-ORIG-GUID: 3U6hS9YElAhEZlr8Ppuya3wPASoisMfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280082
X-Rspamd-Queue-Id: 19AFE48205B
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35462-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/28/2026 1:09 PM, Johannes Berg wrote:
> On Mon, 2026-04-27 at 20:37 +0530, Kavita Kavita wrote:
>>
>> Mark NL80211_ATTR_ASSOC_ENCRYPTED with NLA_REJECT in the nl80211
>> policy to reject any attempt by userspace to send this attribute.
> 
> This is not necessary, it's the default given
> 
>         [0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },


Agreed, I missed it. I will remove it in the next version. Thank you.


> 
> johannes


