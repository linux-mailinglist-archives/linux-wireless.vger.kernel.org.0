Return-Path: <linux-wireless+bounces-37880-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eRhqLmhXM2qD/gUAu9opvQ
	(envelope-from <linux-wireless+bounces-37880-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 04:26:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C669D20E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 04:26:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZJVfheDE;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZHkEVhcE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37880-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37880-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2ABC3078A36
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 02:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E77230C360;
	Thu, 18 Jun 2026 02:26:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291023E320
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:26:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749599; cv=none; b=lIJowr69Kvp/NfuS4z0qIFnGpixW7FxyJHqsYWmlHz+djbvS1O08Tbc/QEboN3H/HnoLdToDF94zaoe7lHUUVR0CXA/pnPhXnV9SAG1i987XxhwgP7mPYE39ONfwgl4pXMc2tL/XPV9HJQwK77ahsLKop4I5vVwBSQCQKgIBuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749599; c=relaxed/simple;
	bh=Kxw8kKOKrRDyeLtmbzCsHduldjoxsLNr2BKRzB6zIh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq6YSUh8C+zIgfkOi4znYO08X62pbfFucwygeI5eJjAGrN50hEtm7rZL+6CycOHJ7CvO/pgkl1aVNDpRHvZ6HNhFO3fqamxUAEnDyK9+TNYC588cE8kQ3mLfAv3waMbJbOxs5+JcUP0wI3Gz/natTCJiL8m0ZcqNIUaUUCI0jy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJVfheDE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZHkEVhcE; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HIRToc1597080
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zKf0bmfDYppgB0e27FIJ8nukk3QgDh4nPI/Bw4DM2ng=; b=ZJVfheDEmc1IaMDG
	ZWacjI77NF1T8N8z8ShRjm6O0OL5IHZDXPwIUjsaz3TfPB30onNI7ocY7XmhHlIr
	CtQIhE9AtFthPO1PAPbYfup8q1CGVgc8YlNWgErWSQ1ElbWHjRphxO6MiVeg8Yjr
	2yB2kmJ3WntRwwzfVH5pURl2WoH9WsvnLIr48bSQfY1Za7At6wB+4s5T8piTA93m
	T7u06HmERQcNmwHEk5Y+ToGJ6IOyGtnF9NabQodbS2pc/IFPzq9SSPwsUz7DuX4i
	INeL5h4QIStcDJs0Q7IUdU6t50pRa+RqIWfGkjI4FyVnmK9+9o9csHJGABGo9rj1
	ERZqMg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk1e07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:26:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304b8d0ee63so1158258eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781749595; x=1782354395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKf0bmfDYppgB0e27FIJ8nukk3QgDh4nPI/Bw4DM2ng=;
        b=ZHkEVhcEEEu4rFcmGpfi+DprApqzP+MYVxLWx6p5x4fpfroo/bwelSGaN6TcsoQ3NZ
         thcnIWsHUFRNWrcjB+5/DR6lk0j3MXHbmbDq7nOx2PUOb+7aRQqhmQHVUydG8Hu6TnxF
         9+AgDeG+joH2uQwQuOtgXgaZrL/QVevVdhh/9+1XuUBue8xVovtnd0MfRoBogyie5HnY
         36CFw2PteqlaCxj2Z917tMOdGPoL6hC4MCM/ZS/CZ9XtViZzxSB8abB2IrUGAhOTNc3p
         3PKom53AMuws8UKz6EXXlRNaiH2Sl1hmNqFgMYj6Z0jqUmZLjN+v+w3pvTzLGx0n8I9o
         pNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781749595; x=1782354395;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKf0bmfDYppgB0e27FIJ8nukk3QgDh4nPI/Bw4DM2ng=;
        b=iQ1/9qccXmizTzXk+iG00JwhCpIY7WWQ8EpNOdI9OxQNM0O3FQVjEL09ibe955x0ml
         oNUestrZ8RymylWJ8QM3d9Z1ZXMz9nd7I/48ZXo4INknKr0fI1hA9OCY/sy7XFBqutDM
         xyfMJC7c1LvM4m4GDOOjVqUFK1YYNxxcU6KfY0bvMFmRTn56PHy1bMrFw0yHIvizj3Jh
         at9Rs7L+rYLJCTM6uq/+4MRbQlApAyYzV2ofVimjydGWY3EZfZYd+d3WWmOrHckGIUgC
         6sq7jZS/ryFNIpYE8UzTjLMgl2yA6DMKfUfUmqTQ29quhQEtpuJEbI7k60djSSED0WVF
         OlLg==
X-Gm-Message-State: AOJu0YyZcB/bRURbZj3ofrBYglno3O+7fnKohbX6NnovJJOC0VGMhwpT
	+glZyhZfpPQ5njAlQ5fY0dVefvUDiSAsCwGOP4sziRBXJVO+Hg6wdgQU0JSkFoTgAcDOY4Tb7+S
	S1VlYFKFeNkN2QVnqnsbCQB+htCN2xht5U7PZFUSFCAXo8Yse4LVQwMw9fp08i8XKonznqQ==
X-Gm-Gg: AfdE7cmNP8uF9YWzv6X5GpjHbQk1hdvs2ReOgDvS7if+zWrgyUOVwSUmp2QzrEUQtwh
	79bf6DwcDG5X4RKSqn3z4UAcJheInhqFT1GTRsnGHR7C26FlvMdVJZR6Z2L+at9MpJWdx6UHJG0
	zFe3+7KxwWFQy6uY1hFBGIlSSiCI191hqaGcFdW5nlOeiEf+fq6KkIyEJMy2nOZhQ/2OHjyOjIc
	xQLU5V4Pfk6ofCL4+LSWHfNMT/zvEwpz19Vc4Zq2BsId38FJrLPdLeU3cxfoApWuI/NfechAQ3K
	YqG09vUdbxTx1jXYfDYDMT5gXj/MH5ikdIN6x06iJmhFra1cyQAIODaZf1XjZhOq+0JIbY9xb9r
	FX4pEvuekSq1IqlxnZsj0lGwyG0fT46sW1pL/1qJPn06bvPuK5OZVvWoPoQBKm2sSVqhuYAWLxD
	tbSvw=
X-Received: by 2002:a05:7301:e8e:b0:30b:dd58:e155 with SMTP id 5a478bee46e88-30bf09208c4mr1257502eec.20.1781749595079;
        Wed, 17 Jun 2026 19:26:35 -0700 (PDT)
X-Received: by 2002:a05:7301:e8e:b0:30b:dd58:e155 with SMTP id 5a478bee46e88-30bf09208c4mr1257468eec.20.1781749594545;
        Wed, 17 Jun 2026 19:26:34 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bcbb684absm4654469eec.1.2026.06.17.19.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 19:26:34 -0700 (PDT)
Message-ID: <fb7d9a93-423c-4f05-9d3c-06e3ab25bbed@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 19:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] wifi: ath6kl: fix OOB read from firmware num_msg
 in TX complete handler
To: Tristan Madani <tristmd@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
 <20260421135009.348084-4-tristmd@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421135009.348084-4-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EnqCH84oFJqqQ1YVvn933XFdxr3L-J9K
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33575b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=J_-Nd1mkAAAA:8 a=I1eazs0kWn-z8uAMkgEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: EnqCH84oFJqqQ1YVvn933XFdxr3L-J9K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAyMCBTYWx0ZWRfX5BQ32NSKk6gj
 JFX4P2sAKUr7lN4EgnFgrP7G9LrrE98bNwyfjWNQRj/5KY8qsFcEb4dtYt5eETPmyPKaqK2Nfac
 Nucx9Tlph87BddffSm3vW5q3h71+J/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAyMCBTYWx0ZWRfXxCTDBI5yKlAA
 D1YTgEwgU7ZpzZ7I8IcnyMnDmP89by73CGxSW3Pd/vs+LExo4Orl8sCBGt+wrTcarwUKJHUIftM
 TqZvPRwRiD66ganaYX0VPjt6sTDGi3/Cf1opKchGQqKFKc+lwCw8VlzLL87Ks8mWOLSUjJdVrZF
 0bCbdBeOrppH/3a0Kz0i7jlwwLZpbbHxwzBjqVKWvPEmHDyFaQgb5FkpVNmcdTnnMIt42t1KW9w
 drkIi+UtVF2HldjngdttPJrXL1BCfSdHb9YGckDZv3lh1uliMSXgDBwg/efELc1J/2aYPO9dEo6
 wtKnu/p8ueObBt3hElnwEYfjJN/3l1SnMZvUvQ/ylFWz119mQVv1J8L+eK3vEs2Cu+Iz+us2aZ9
 1JaQ0Z9SHJsVfcXrNmci7RZ3zMEZyNR7tE5aC2XsNtN16+Iisu8HKPpYVsXHYazq5+Qtxr7/npC
 y2DHmQMjcoy7R3VtCwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180020
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37880-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,talencesecurity.com:email];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F1C669D20E

On 4/21/2026 6:50 AM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware-controlled num_msg field (u8, 0-255) drives the loop in
> ath6kl_wmi_tx_complete_event_rx() without validation against the buffer
> length. This allows out-of-bounds reads of up to 1020 bytes past the
> WMI event buffer when the firmware sends an inflated num_msg.
> 
> Add a check that the buffer is large enough to hold num_msg entries.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/ath/ath6kl/wmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
> index 1cafbac2938fe..f56722c5ef5f1 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.c
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.c
> @@ -484,6 +484,12 @@ static int ath6kl_wmi_tx_complete_event_rx(u8 *datap, int len)
>  
>  	evt = (struct wmi_tx_complete_event *) datap;
>  
> +	if (len < sizeof(*evt) ||
> +	    len < sizeof(*evt) + evt->num_msg * sizeof(struct tx_complete_msg_v1)) {
> +		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d for %u msgs\n",
> +			   len, evt->num_msg);

In the case where the first test is true, the logging of evt->num_msg will
still overread the buffer.

I think the logic would be more clear if it follows the pattern in the 2/3
patch, first validate the fixed portion of the struct is available, and then
separately validate the variable portion of the struct is available:

	if (len < sizeof(*evt) {
		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d\n",
			   len);
		return -EINVAL;
	}
		
	if (len < sizeof(*evt) + evt->num_msg * sizeof(struct tx_complete_msg_v1)) {
		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d for %u msgs\n",
			   len, evt->num_msg);
		return -EINVAL;
	}

>  	ath6kl_dbg(ATH6KL_DBG_WMI, "comp: %d %d %d\n",
>  		   evt->num_msg, evt->msg_len, evt->msg_type);
>  


