Return-Path: <linux-wireless+bounces-37995-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bQ5/C2opOmpa3AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37995-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:36:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1B6B4930
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:36:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QnEWeU+R;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=XQqOz4kU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37995-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37995-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA8330488EC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9458340286;
	Tue, 23 Jun 2026 06:34:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C336344DB9
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:34:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196447; cv=none; b=iTbjSKxEcSKuWLuMABc+xPHm5c8IwHcGZi9+tkAnxkbRkryJDrZBRDyBtzrhSDwaT1Skpcu9oOKpSVk2UyNzyQrKKLG7nLP3gi1Uf625K/zekt38Rk2yqE9P9X5z7oHAvjaiOLDQ47g1GIwoFYguevvAe7doOzYLIzOxS4YIZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196447; c=relaxed/simple;
	bh=c41GS6byMdgzPlJMdkS6ltuAmcNP5Cpu8h+GhWoORiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqI7cAOx3CNVWZk4o/5NvgjtEogNfjAdAlDHlSkKN8WlXmkkO5eqGp2ioK1znUHXO19XwOM/ZvlR5aiKzZCO13pZfc3n5JNF6miOTNchz3n4t0KsCqh8B41jzi6Mi3Ssu6XfXF8xiKzQSxT1LrVkb3B5/8jnC9sEZUUu5jT3OO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnEWeU+R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQqOz4kU; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N1Y7L32672818
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RWx0gdwex8o21W9NKWEoQBE03/Z8wuoolfwNIjEcNC0=; b=QnEWeU+RNdBmYzjb
	yjV8ezRCkvGMiRrlnzjNRtMMfI59QNSM6VfY6YoWCZoCAnkE300qqgyCfb+3TrqP
	R1sx+1cxftHUSZivgVKmMbcbWwxtZwyTS03Ec3be4PbC9ajmG9okmlbFSapPCdPm
	gUXH2NeAiB13VH7kTsnDQemmBCEk6do5GUc03K7g17xiqPrt76kyeaVdLVtMm0/T
	Zo/ZikfMwBhRNYhS+SZe19D+ETU+NoIKamuZn7Xk9hwLzDjKVKhM6hfAgCTXfNRr
	0C0Zf4GX98CCPKFkbnWbXnJD4W9pxMyFGdBlku0Ly1Y78j2qaWg5d3uHN2k1k44l
	KlGghA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjgw32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:34:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so5847450a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782196444; x=1782801244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWx0gdwex8o21W9NKWEoQBE03/Z8wuoolfwNIjEcNC0=;
        b=XQqOz4kUF18Uv9xzl5Ynp3QuF/lx3bdH8lgRPrhKyg2lcNTzELjKf5h949Gy5gpG6P
         dfuWVicvDVzRjJvTGFLA4gBi6uiPl6sIAex8RpwJA0V+uDanQrqm9RAg7WdlZz8o+lGO
         BFZCh4V29wvENGDaTZUs3PFFceGEB5fmAT6411zzPI8SNa8C4vSqV/ptCj6Kovi9K8NV
         KuzsJMnmThwjXsZL9zzZln9A7odr9dgU/4J7VkMNHGvE3xNf4OzQUDHtXZpYbfbW9S2g
         r/K0RTUSLNSD+3BHU97KanboGyQbOM7WuAcPUqPbywxUxFcnxyQw39menS1GfSklx7py
         2puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196444; x=1782801244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWx0gdwex8o21W9NKWEoQBE03/Z8wuoolfwNIjEcNC0=;
        b=fdaIqTJ43Sl8SxIswf/coFwagTyvKotFUFEAkF/gI1MwmNHExZEf7YLDFWJDTpB5tu
         OHvwds4lwXx1bnr65ndWw0zYhXrvKdEfW5OSgHRVwmwbAqVv1Dnd32KnNYp1unEOoBdu
         zKqjWeJ7+ZdzG9rBpXnfv1VHMgZIJWHtNMpjqo77sCNMd/aw92RkE9nlhIRRIFx+O8iJ
         h4vnwMfTHXWv65I399QpKlEXo32n44Pa544ifp1OGJFeYkGXb+daouUEM/NEUdmPpeVJ
         TRUXpVZ37HIOnxODSXo6ykwl4SlY04erolDGix35Z3pE1+aBz+AFQPQC02suYVdvI2yt
         3e4w==
X-Forwarded-Encrypted: i=1; AHgh+RoEC/Aj23pnK+BT/uUsi8KIDf4NtAJds2U7Li/vzvTUP61zTh6trQtld1JoGSModEQvaCtHTYg+nvQwjOy2Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3HIn0Y1X53Fk/5YRis7Pgpb7RTRXMmRHUr0xzRxOJ2aErB25
	b2aZnWEQoXxoevYh6Kqz/SPOQ2KFhI2xWUCNwe8T7rFlprms1JXRmeM33BhRv+IcypzwKlzlbOU
	oJHWDOjJ2YqlhFqNnbLWNAHXoscwkFpNm7Vo86Cwuo9VIEKwoH+Inn+incRk2duczsTNm5A==
X-Gm-Gg: AfdE7ckOuzveWEm9OdBpnFnJXzFOvBAobHYA7a/IiJ5t0op1N4H5OWJZew8Cnk7r0K3
	1MLqtOVyFgY65yFX71t2D/wKJViL7eLrt1+XDTmKkb2m9CeQlxNN9FkCbN4vjY2MZcV8NO08HW5
	WINOcx4INePjtmc7pH5BY8YobpS3NXeHgmoM2oVNEQeZr5RZ2g0c9MEzX//Sr1SqWQ4/LNEsSKM
	InCVbCyJda4+aNC00oAJ7jiIbjz2/5eKYzw7CT4TQ5AVzfl6KDoICQUER7zgV31+kTYxjD+0KiJ
	9PzymMqJyig8cKAgfuMHwe4pwPEpSC6NKDqji46LsQSQtpg+ZIoRnoJsGn5kiqk2E6TJAUdhhDA
	Q2zlXBolZ4hXSDp225eIv0ZHd6XjKI6IiL5TqYri3R5et/AIDVgGOLQSxQSkZ
X-Received: by 2002:a17:90b:1f91:b0:37c:83ec:1641 with SMTP id 98e67ed59e1d1-37d4d71d7d0mr13004083a91.5.1782196444308;
        Mon, 22 Jun 2026 23:34:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1f91:b0:37c:83ec:1641 with SMTP id 98e67ed59e1d1-37d4d71d7d0mr13004063a91.5.1782196443843;
        Mon, 22 Jun 2026 23:34:03 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.36.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15df815csm12594916a91.15.2026.06.22.23.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:34:03 -0700 (PDT)
Message-ID: <cf96c4e1-cc42-4f2d-96f5-f5d6aadf9af0@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:03:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
To: Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, kvalo@qca.qualcomm.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX0SxObXI6zfQa
 6pYkIUqdQk1vgBW8qgLb1G7Ic5S9iYxq7IXvRCmR3kSQ+4jBh66dXpod7e/4b2N0ahtfGaWeWWw
 6h8OhThO9jlKNpt0t9VJ5H80vLT9V/CQccWG9uScyyKsKKtBvuNXPLrSokU3owXO7Sz/I9LSGWS
 lqFlw4ngp3bqxv+9Hp7TW6qrZw022bFuUZzLl6aEOl5xUde+kV/oi9ugn/23dMQPHnfryNoHdsr
 46FXxre3wwvQ7wU1IUqjq3qlrCiKx54qJx1UYUiitoMiWRKX3pB2S+6P58t0T/9H0XYB3dCFdbn
 Zkrs5mi2wvXsajtUUdgoc8SNO0mHFisRk92+3qTRufU3N//1lkR63ld85iDRYBHUAD54HMVEXRH
 Sf0BvSz2eG0YxhfQr52c4y22rQgG+tjwuz4NxkC9JPxNSbETmmVa4wKnQ4ccLSfrlflx7ffDB2i
 Kx4UwY3MljxDRTJ3sqA==
X-Proofpoint-GUID: QIEVB9U7qRM5edIZ675yPLwt7lRVNxOr
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a28dd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6/2MXK9rXRWb21GBy9lArw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yrwDRl_2H5AUk312M7UA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX5fdUQyczBUc+
 va+mTORuZq62K4vyQWmGofNeXwjN9767NrGC7MLKze/lu9uROYxDm1Fi0J0KoG3IFenj9TT/DaP
 Wf6yDJj6PFd0ehAgYKPlp1JPMhQvFwE=
X-Proofpoint-ORIG-GUID: QIEVB9U7qRM5edIZ675yPLwt7lRVNxOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230051
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37995-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:git@danielhodges.dev,m:linux-wireless@vger.kernel.org,m:tglx@kernel.org,m:mingo@kernel.org,m:joe@perches.com,m:vthiagar@qca.qualcomm.com,m:rmani@qca.qualcomm.com,m:jouni@qca.qualcomm.com,m:kvalo@qca.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,danielhodges.dev:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AB1B6B4930



On 2/7/2026 12:22 AM, Daniel Hodges wrote:
> The aggr_reset_state() function uses timer_delete() (non-synchronous)
> for the aggregation timer before proceeding to delete TID state and
> before the structure is freed by callers like aggr_module_destroy().
> 
> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
> is called, the callback will continue to access aggr_conn fields like
> rx_tid[] and stat[] which may be freed immediately after by
> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
> 
> Additionally, the timer callback can re-arm itself via mod_timer() while
> aggr_reset_state() is running, creating a more complex race condition.
> 
> Use timer_delete_sync() instead to ensure any running timer callback
> has completed before returning.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>   drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
> index c3b06b515c4f..25ff5dec221c 100644
> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>   		return;
>   
>   	if (aggr_conn->timer_scheduled) {
> -		timer_delete(&aggr_conn->timer);
> +		timer_delete_sync(&aggr_conn->timer);
>   		aggr_conn->timer_scheduled = false;
>   	}
>   

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

