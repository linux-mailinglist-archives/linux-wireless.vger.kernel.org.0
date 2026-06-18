Return-Path: <linux-wireless+bounces-37879-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XJXYKUlKM2qG/AUAu9opvQ
	(envelope-from <linux-wireless+bounces-37879-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 03:30:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A026F69D020
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 03:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="oziYE+/q";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UZ5o3y4e;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37879-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37879-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE069301C4A2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 01:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB502AF1D;
	Thu, 18 Jun 2026 01:30:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAF233955
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:30:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781746242; cv=none; b=bEYMBdd+PcO6PWmAd/RPLWpGC99lBZK54KlZNzscaGL+tgGbCHxGNEQbZoVskU3408szljPz8nfnWrlrMtxO/0IGte538gC4DYiH3E3xwtci2FaQtiuNRMm9Syb4bc1oAqGGEcTwHKvwu+drLFoQ0jFTvsvbRmyZz7caXOSaVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781746242; c=relaxed/simple;
	bh=xXWgGBgQoCldbXSorwbebvXAaddQF+ZKb/qrNLzOp9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XBFJ5qx47UDMPb8nTOr8BtcEQKpUfmOXL7pmLkBevDpXMQSEOLgPGwxJ+ASO7sItBgC6bG65mMNE5hi2kkNVYOp4TMKZMUnUiBl2X+xlT6n30SAi6YZ4+Ty7JwKL9XRpw5TbBoiFz01fXXXa7cLczgICSM/0+5Xvoh7kWhFRsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oziYE+/q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZ5o3y4e; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHd7eB329916
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iIhvmxaTT/WGeHYzztvI3zMkUGHJTXnzFOaumPvPxFc=; b=oziYE+/qTudazA3o
	xWayu+2R64MgeYdVieAJQwiyuJgsn9qHnETR9Ol2jGCk1Q3LujXbtqmQImvZ3dLw
	rlrPypdIIsnUrBposm7kyCqeAHn9VMshguXB0YneGReZZ43FSYW79mW2yR8r/3xQ
	xhqcTIY0DN5JYhu4jDPRxtXVpS0hh9BT6rLIoAlS08w8iW9tszOr6vsQWCUzhe8i
	c8VN8l8Jq3WdK7cT0l/nd0bGnOouLf0EOvvAO4kRqVjKV+NdwkdU/klfm39Ak7Tq
	qFmPPuouHa/1fYWGksrkL264VI8K6v/FUhGIoheQElNMxpYPN8aWsa2kJvXpSUxn
	mvVo6w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vjr5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:30:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ba395b047so1708199eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 18:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781746240; x=1782351040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iIhvmxaTT/WGeHYzztvI3zMkUGHJTXnzFOaumPvPxFc=;
        b=UZ5o3y4e2LzmNgDVxWIfTrVxhilryWDl0EeZWwJIZ6F4xf+tGkgJNJBAQmOlIzF5Ik
         24miwZQv+OIYqmcL57awuVakhIB0lVdiyhWvb+IYrsiYHOaIuSMzt1gWK4VqmlJkxEPB
         oY7poDSnLNr8Z+/0DbQ8/TiSi0GZCn6UhU/0mP8n1Oc1Ylw9pmhA+qfl3ymjd/etpY+Y
         vHSiDolNT48LR81IGP1l89luiXdygaG62oGzqS2ipA51tyEblUFsr17CaNfjXfHPWMp7
         jfkSkyZ8+aY2fQat/oengmWOtNYBF97+qj7w9bkpzn9Ah3sjILfiOXEdfssgs7/GUX/l
         oziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781746240; x=1782351040;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIhvmxaTT/WGeHYzztvI3zMkUGHJTXnzFOaumPvPxFc=;
        b=dDm2WxkaoCswA8/UH44tMZTY2O8Jo+0mANyGbadHVBoM8F73mOp9+4tWGKZc9H1FRo
         HTmvV/ZT/TsbjT7ChUDGdXg+MCuGTzLEACdDe1bh8kamTnUr6j90J9F6bPb8NKYoCUIa
         d4vLZjL8Ex5hbphRsMkqZn47DePwY9TrXHpoTzXD1Ju/GJU9121xvsNzr7s1RGwmeuV6
         z8ZqrUHgXp8xwIbwzJueBQ2kp5kKiDa8p+dA25TuHB3oQSndQVyredGel0NaNWrwwiYV
         R4IJn6fU2z2g2e40OeK+QmNj3k+HGdd/bYRtVUU6QvTo4N0MfVgHODZ5nLySjhBPwDQv
         krLA==
X-Forwarded-Encrypted: i=1; AFNElJ/H6OZWi28z4UxcOH2gkRNCaq1ztsFbw2ilMt71qK0d2BWmfcmhf9mGn7hHgBDb1BOvg8AgJqaX5qK0Aak6zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7sBJXql+X/+eiKp8Y+O0xWpkuUrdSX7oQ4f4VHwdPk7slihY
	KySA9oIr4P4piPKRa21QIA5z1hWF2R0EBdCPoiayclha/9CWLGxMhlyVvn9wb+mDsAkRQ49AQ76
	10fkm0/O/Dt63Dybk1Gywc80Q/H9q6bzURT4m69Uih8BX+LzRX9uOTW1httqRUkG37WlEYw==
X-Gm-Gg: AfdE7clLWVpEvgGfpZgnjPXHWJNbYaP/wN0IvYqK4CrkWdkix8rWmG/NzOvW7ebHu/O
	Xf8+/9meB5yotwDlUaGMOmi9pZMBYMRtENu1fdTbOEhMWud8PeQS+H3zsdFm3JWAl8X1O21JpQQ
	coktMUNSX4x/pj/kA+LqUp3jTXuiJwHZ0CIwFAljX5/VOWaHkfXArrHZKC1ldzgDwtjDXesZYmO
	ggNz2yZXbdadWER0rpAqsVokViOzDdQ/uju4bnMSZiArAbT2xwzo5mi0JKlmZPp9uGMtc8w+LdC
	cKPzBBMQypQVms+yEr0VBaZCw/0PqPkYX8KtB3TWRn5C9hj38cLRgjba1K+mZO6K/HFVEkiuk89
	RvsldqmIT1CF7CEKJNpnURZJHWESH/qSwgejKuuBdqcC82S9E1WyBMfHotskmL2ndLYKkAh1fei
	HFsqU=
X-Received: by 2002:a05:7300:1897:b0:30b:eb75:8a5a with SMTP id 5a478bee46e88-30bf09a16a4mr837074eec.25.1781746239899;
        Wed, 17 Jun 2026 18:30:39 -0700 (PDT)
X-Received: by 2002:a05:7300:1897:b0:30b:eb75:8a5a with SMTP id 5a478bee46e88-30bf09a16a4mr837056eec.25.1781746239369;
        Wed, 17 Jun 2026 18:30:39 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm26643423eec.4.2026.06.17.18.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 18:30:38 -0700 (PDT)
Message-ID: <e46348dc-a95e-496e-8b49-2838b25bf9f8@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:30:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
 <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nwsEgbew5pBNXCMumvO_q29RjJBYS_hD
X-Proofpoint-GUID: nwsEgbew5pBNXCMumvO_q29RjJBYS_hD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAxMSBTYWx0ZWRfXxVHwQf+NtLVO
 xPXPPP2vAgtBaAyWKWsmEMYDulcSDq2eQSa6w5gSiMZRYZ0NvvRff/uF3shjTDHgYtX9gamZchH
 WZK0jpxzmyVq/v59H0zrUEFz6es9HHUXahi+5p1UmbpC9+ZKv9OgJ3xE0ZGk6339aEtHBSMw0m3
 VRjiEZRG05Eah34Kjt5NOXtl2urXfHGvtcGbP7TozF8aH/afYoa4QqmCyD1GuxHRDJj7VkNcLLz
 0+X2m9pD2oXxS+alWkbchD0mGW2QxVnR3Oc+v1pEfq9HJycFwZ6y+i+KFox3RhNr619Zkj33bTE
 9ncPQEMn8Y6qZWgJ/ukVHCzcUuJSxXo7M5urdvqw2+2eUqzUusWHa4VVOjJjxCn6JrJL+xKoBeo
 2UCHNObnieLK9wWG3dDyaerNNDLMoq2tPWyy4OLYzxMqG3Fet2szKedf2CpF6FrdnfeI/q+12BH
 SqA50hpgO2eZyTAYjkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAxMSBTYWx0ZWRfX7LUu16GrCzZv
 XSQTvRzwyMkYT99L7c4UMELEy40SqkV7m6LaIfSUaVSn/2KgOja/rfOgk/DBdnzPosmLSyKhLrQ
 qWpUOEikfLjPT/VVvDiDMJ5ZLdQkCwk=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a334a40 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=ssj8URQz7FPryPeC8vIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180011
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37879-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:git@danielhodges.dev,m:linux-wireless@vger.kernel.org,m:tglx@kernel.org,m:mingo@kernel.org,m:joe@perches.com,m:vthiagar@qca.qualcomm.com,m:rmani@qca.qualcomm.com,m:jouni@qca.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A026F69D020

On 6/17/2026 6:26 PM, Jeff Johnson wrote:
> On 2/6/2026 10:52 AM, Daniel Hodges wrote:
>> The aggr_reset_state() function uses timer_delete() (non-synchronous)
>> for the aggregation timer before proceeding to delete TID state and
>> before the structure is freed by callers like aggr_module_destroy().
>>
>> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
>> is called, the callback will continue to access aggr_conn fields like
>> rx_tid[] and stat[] which may be freed immediately after by
>> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
>>
>> Additionally, the timer callback can re-arm itself via mod_timer() while
>> aggr_reset_state() is running, creating a more complex race condition.
>>
>> Use timer_delete_sync() instead to ensure any running timer callback
>> has completed before returning.
>>
>> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>> ---
>>  drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
>> index c3b06b515c4f..25ff5dec221c 100644
>> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
>> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
>> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>>  		return;
>>  
>>  	if (aggr_conn->timer_scheduled) {
>> -		timer_delete(&aggr_conn->timer);
>> +		timer_delete_sync(&aggr_conn->timer);
> 
> My review agent claims this still doesn't fix the UAF since aggr_timeout() can
> call mod_timer() to rearm itself and hence the timer can fire again.
> Instead it suggests timer_shutdown_sync() should be used since that prevents
> any rearm from taking effect.
> 
> But I'm not familiar with this driver so I don't know if there are reasons to
> not use timer_shutdown_sync(), i.e. if the timer will be reused again then
> timer_setup() will need to be called again.

Interesting enough, another iteration of the same agent says:
**The fix is correct.** `timer_delete_sync()` loops until the timer is both
not-running and not-pending — it handles the re-arm case because after the
callback calls `mod_timer()`, the sync loop picks that up and cancels it.

Gotta love our new AI-driven workflows...

/jeff

