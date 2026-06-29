Return-Path: <linux-wireless+bounces-38233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xPtpIBzTQWpPuwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:06:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4886D5778
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:06:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CM7dw1US;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="ZOPK/o2C";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38233-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38233-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23F2301F9A9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE41240D568;
	Mon, 29 Jun 2026 02:05:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61041146A66
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782698745; cv=none; b=YVeyjIj+ao3Rc4Zw/8D9JbfNeZoHSVK6G3/ao/HZJd2GpCqjL60QM2djwSVUJOmS8dUcCnpurCzxc5kpA+jREVxdTYeir5JnNHNjYEbFjgz194jW63bd3vujR/8SxykS7V8jnULP6qdIq2TA8Wtcaz72kxUfSP8ANP62VaWZAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782698745; c=relaxed/simple;
	bh=xpkpV84XLT6iHiXtPFw/cG/NwUj3uraKfH6xFu2VbdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbcKLuv22NBR891hD/gZvD6RL5tjNjJc8uskgAM0ZHz+Fqo/I3oXeVURRorAvNL+N/fWY5k35PWmaknwwCsrX1g6RzUtvnZbWc7UNC+1uIIHtn7jc6vfuyimp2p67bSVdKxJHECCyfKcDm2wFMxpuShfde67r/rbWUdR+l3LHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CM7dw1US; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZOPK/o2C; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SNRQQU1150806
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o4abkKu4sQ1tJMRV3hdHTPzc0XMo2rKt10nW0yQvRv0=; b=CM7dw1USBOC8za5M
	8WHQ8e6WowdkgPjdF9gKRyeNvqhXitHg4AAbS6OJwqfbbQ4XirCjipZfmhZ3yZTW
	UOVIv2x4yDDCM+wBL1ZqfTT6oXMpfr93d3WKyqgme0h//21gRp/yqiPwNS91Ov+a
	/WESK//t1tMWHi3TjtmZijtNdlXp8QGUSYoVkDCh8CM9bKu0AOTPIgAmQw/MOIid
	YEzGt45CQWAVnh3Axv+rb8YoxVqqL14oE2Z2nxFKeLG4WqjylJfPYsU8JJv+epRG
	sRkY88lupqV1r1+9XXRyRQlfoIPtbwKXCf32kvl0X5wdhF4wQwqWNivxmCBS6IXk
	46fXkg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u744y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:05:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso612280a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782698742; x=1783303542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4abkKu4sQ1tJMRV3hdHTPzc0XMo2rKt10nW0yQvRv0=;
        b=ZOPK/o2CsJrHaE5FsP3XpOL4kbKoQrk9zyVyWPDE+xgihW4hvoRJiwybl7jNgViFSl
         me5TnfDwAnoUkPyjMZpLRWHngPXHh+e7IAUFDMU+17sh0c3qEQV7m/EykrUGyASstFdJ
         jIkVotYypdIiigS2z0Ep7A8/ioMbnIs9w5YqczlFlig96c2gNhOFYf7zdKwZ+c52LpoK
         lowLssH/lvj9WuxT1BwjDIk5jo9/jz86KHN/AbbdOS08hGJMQ33M+wOnf5Sv/0DSiLPg
         mIxll7iGAMA9Wq8TSDzJSTEKiu1NaGN+ULCryV5bZlyAzX3alZqEd16rhrDcC7GT4s3B
         oIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782698742; x=1783303542;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4abkKu4sQ1tJMRV3hdHTPzc0XMo2rKt10nW0yQvRv0=;
        b=nw/CYkHGXbkL0rpU16PdRxAtfllCRQPWkc7wntL73SEuMgfaYVv74KVYzlF9FYWTSg
         HWLcFjQwrGPuGLuMhDT/iR2DEsHAxDps57QeraEtAJ6HWJ4Jtf/HuGdEu2vmAT2AwEG+
         qjUVbRFY0f1CQuUoPTnqw9E+UJWjfa43R6vIKxZNCIaaoeG0iNmPsEEuHOEUlTrG1+zU
         50NhSN0PCosQJ4IDJKfD+0p18e+CHb5koZkE1Bl7tjwNmlaSnZ3dgftmjfqOvTADA8XB
         geWiO1LQM5XVhmZFqXqI5VVKZyOkraXMlrEPenZrq6X+oq513h85hedSeU+WiPYh7zxP
         7sTQ==
X-Gm-Message-State: AOJu0YyWDk1IdUTm/jS3F1KfNYSJWXw73K4wPaa6PwIVcoW2R2BOJf2v
	yT+SowCxFwAPxypRKYorkxS1MJY6YfG+67A9olMb5l3uSewm9+f0bRXf6QN/vE5Il81fN6EJR2v
	bf7bx+xU0CAVCoxd/Z/f8JoABVY8APaF7Cj5e7oRipWVffx7PW2dmGMZD/7OY1pEdyu/AYw==
X-Gm-Gg: AfdE7ckY2jGQVZX1ne4ao9PRMh9Uf4aF4BD5Ipr7/ZXk71F4kUicE49/MUKyRm1BCko
	if5cMq5H9H2Q8ZNyzkhsFxbmWiTEa7aryta2/p01dRXVC3gud44pxLKsrHOpkSDWC0QNy0y0hYq
	afnvD93Bga49pNOknu0Z8V40FKxQmDQ6OpVFvyhWKB32zgoCerfAbvZdDm1CjlRUbIiX058Hk4t
	m4Ebn2j05FVz6I/A0XgjAUsHmDA9JIs4FJUYDm6nTDGHV5msQHw8wLL0rX/srOuJ8ZS9/t0Q6wg
	SaVj+LALYr/F1qzzkhCSo5piAFP9acwQjsY+i4sv3QsY/WXTZkcOfI56CXtm5a+bUjbjsJqsZzu
	NyzPalX0cVc2zqWIA7sL+7FYQSpadELOukxqxKmZ+FpwPIweqX07iyVqGcil9dJI5hXTeHR8zG6
	hkYH43mQ==
X-Received: by 2002:a17:903:3b88:b0:2c1:ea95:8297 with SMTP id d9443c01a7336-2c7fc75a973mr134086165ad.7.1782698741815;
        Sun, 28 Jun 2026 19:05:41 -0700 (PDT)
X-Received: by 2002:a17:903:3b88:b0:2c1:ea95:8297 with SMTP id d9443c01a7336-2c7fc75a973mr134085915ad.7.1782698741312;
        Sun, 28 Jun 2026 19:05:41 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm5544705ad.2.2026.06.28.19.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 19:05:40 -0700 (PDT)
Message-ID: <67a43edd-2cff-487a-ae34-2129985bcba7@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:05:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: correct monitor-mode RX
 metadata handling
To: Sushant Butta <sushant.butta@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxNSBTYWx0ZWRfXzssxFa+t7xcJ
 G1pt29or5ln8UYs0RN41Rg7WDtWvNUmSdJSUoM0Vk2thu5aMq1IzZMEUpI7eq6IBocYhHJWjTcZ
 DoBnhGfG5ZHWpNqJmjwm/cpUUgbVO8s=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41d2f6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=k0c8v7JCAQ1gsNTydDoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Ahjuq5iGxPLRWGdY9io7OFJ2JuoVDDET
X-Proofpoint-ORIG-GUID: Ahjuq5iGxPLRWGdY9io7OFJ2JuoVDDET
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxNSBTYWx0ZWRfXyf2d8sQE3Z2Y
 EiBSt45ieghBPTf9BwfP4+cymwT9PizOGJfOjKAGZzFmIAXoPyAKI+OFMvzdbUPrXVZ+a7YWikp
 K317us9go2/J8M5813w0lUMnZNzr/qtZ+dpJVgZxcL1rJ0TkMTAMiVxLQhvCypeVAZp/rNViP1x
 cGmcoMCbXTAsThjCLwtUFQrNn34T+AIaqsOKjvRJ1AkAukDB1UrlIvydMyrYZx4A1XYBp7zI5fb
 b+OrMtTmoSb7VeNtO5hkVTIGItLnuR3gvXqIymEBIbbBhsE4THqH3KwZcDNLwMCaXuumjVhbFH0
 BPVwl2V1yQ8HhqIGqWf13RbsQWH8q0V7clve3VEK83nZYzf/h3U9FySfuqTZ02RRE7V8tx+hLJz
 bcEabedH9usO8xkPc2z2ZYYiKZLVyN2rCaltW5b88py+OO59mrCEaex4ST81BFNfNyRhsCdsONd
 1sBHGpERkRRiBXdKMLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290015
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38233-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sushant.butta@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE4886D5778



On 6/9/2026 2:48 PM, Sushant Butta wrote:
> This series fixes monitor-mode meta data handling in ath12k and trims dead code:
> 
> Monitor mode delivers raw 802.11 frames should not set RX_FLAG_8023 flag,
> and populate peer/link metadata in ieee80211_rx_status for monitor MSDUs.
> 
> Sushant Butta (2):
>   wifi: ath12k: Skip setting RX_FLAG_8023 for Ethernet-II (DIX) frames
>     in monitor mode
>   wifi: ath12k: Skip peer link info update in rx_status for monitor
>     MSDUs
> 
>  drivers/net/wireless/ath/ath12k/dp_mon.c      | 70 +------------------
>  drivers/net/wireless/ath/ath12k/dp_mon.h      |  4 +-
>  .../net/wireless/ath/ath12k/wifi7/dp_mon.c    |  7 +-
>  3 files changed, 4 insertions(+), 77 deletions(-)
> 
> 
> base-commit: 38b2fb7d2df16f5801f7d88a4739942b95a5f6aa

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


