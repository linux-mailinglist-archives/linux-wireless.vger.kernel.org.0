Return-Path: <linux-wireless+bounces-37996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CdQIAHcqOmqt3AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:40:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DD86B49A9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:40:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QoSYddcl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ADwYCom+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37996-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37996-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 284013029896
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E23C3450;
	Tue, 23 Jun 2026 06:36:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958F3A4F2F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196613; cv=none; b=fUDhfAjBzQrhBWtM3l2jkkj6/zsjciW9oxH9u9eKDyjGxc90GfxMa3GelqkcPd7zZoImHDa/ZfgnUVDMnT0OXPIdQlMRyhptGPI4qG8lO4KRRxaZsxs9ks/sQmT/TxmVTFewbSSEfVriQK1tqG2xbmkKbcICr6boQYqKUcIiiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196613; c=relaxed/simple;
	bh=HvfT3V4qHXX4Q3TEtA3xjNzmOuZFUM0FjS2LbCWUzvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oml3X/mZqt55WaoUl7rfLEbGl0zp3DkLJ09J6lEgH95/51ZDEBAkISmc3jy663eNg5PQf+YnvBNEHR4bkfCEZaCYVJiFPjEJ+wW5SXXmCEWXUxXV3OYQUDh02NWNcA/7IcqNoSvbMAF2QM02OuNjx47vfBL60Xbq252R21tdZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QoSYddcl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADwYCom+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0hgoI839274
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d9/AbN3a7F22nio8mD/H32qBZ/8mBjgv27wzLG2E0Xs=; b=QoSYddclNH2b5vSx
	T3bUfNOkQdN7KyXCNuvnC4H2C9DB6KZpqvsU1GMb78VMlATWScg4d2Fsui5d/hwS
	HCIOU5Jt2OxKSNgvtdWkaDWHpNLfgE+Mxc09dQ4vITp0G7OyB+lRS4oM/6hZbJxu
	RDFlqbi5l3OHwoh40MiSSPjcSZnh/rEug2WVWFeIgSZWsmwvZIqtrh/g00g/jDZj
	ezDP+pvIfV6Kaoq2ukGkQA083OsbmMjoND530aHlliGg6IzRH5Vlm+WIPCqPqj20
	WjAE8CqOzAmuCCe9PenqJ3Bg8dNjMhZJ4I+2EPsfRv8CcfDZX8bxCD1RcAd/Cz3n
	8BGI0w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhuxp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:36:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8422ca754d8so3794396b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782196610; x=1782801410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9/AbN3a7F22nio8mD/H32qBZ/8mBjgv27wzLG2E0Xs=;
        b=ADwYCom+hXyrtI1vB7uPfHcKhDa3NG5TXxqQCau9J6PyHHtkxo+t7LjH3I43ye6Bd1
         4RqlrvL3JSaKaoH3OMY/mWxYBhl6CGLMJQSwhQgtMSuYTBLDZF67BNkr1jFH0r9lHg7c
         d2OMtlTM0cIFsR3XxgEPgx+p4KML6hC3PqvaBZvZU+rlm8+gB4k/5l7LJlRE7SrpYxFi
         pA09lGJADA47PkpQ4UBw0e1ie2/e0zWvSEijkqrCXJVB+K9XIxKO++RLGTnoUgDEmGIM
         xELjzl+YAcTmDlzMtJLIPcTieSe6qQ4MqbWhs4HM33dld4URDHhvv92mQPLDeV4jQP6U
         /HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196610; x=1782801410;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9/AbN3a7F22nio8mD/H32qBZ/8mBjgv27wzLG2E0Xs=;
        b=pTfXkkKFpvd3IFt2tSbcxVS7Le9MNP/j9kV7+bnKNrRA/W1fXJVdLOn2blOI/k37Hr
         ANk0PAIdxTLYgf+e0/vIyxp1JTdaBrnLQbYXtwMDZmPnCKGbU65WuKzrUPbmqvQRZYPc
         H93LpZ1UbDiAGYHGLeS4rqXAskAHyCBcNDeLLpO+J6h0lBEBlqH88Z1HsEy5N+2a7v1O
         YP7SqYP8pgJO9tw/aIpNPA6+N3gTY1vXV+/t5gLrz/4qTIduAU4rekPEt98nSvz7he/d
         YgfB88sxvFHRI2Vvr08nTQSd+N8BuULxBbAQLBo+EX1iwvYfmFnYmqIHdeSpLoOIRnNA
         t+eA==
X-Forwarded-Encrypted: i=1; AFNElJ9wjnCizMeAS4UkivUq9gIqQ42NTdZLIDG9B8/+7rF+uhMBH66SYCigxNVUzCj++bbViW8ILZfR9hUbGvvmLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnT/TIISDloTNddf0g6QtiXXnmPT1n1jjzWSUVyq8BNO6jux9
	HBalhXwAGSx3AEOcKj3Gx1iRDtWnQY8MxGmsKJsjSq94BQsMlDkX4vDbwjolN5ozZXUcDWWltSX
	r+xAYB1VUBduzV5w1Y0NTruyYgQLBPb3h0xj3CZ/rwQ2rUJeFNBkm3V41f3ZwvSoqE7tFjA==
X-Gm-Gg: AfdE7ckgYrylXQ0W+rRvQxSvUwi3MNQ2Uq7i4jkLtVjkPSASbmHSGmmyZ3X/6swrCOX
	cJupNxJM3w90VfM5kPIw1BpTzT9GaOvKIB94+9m66YFhGdgCWl5xSpu1TGb/U2sqalwFtSX4z/B
	y2NO4Y/YBEBnTLPpIa1VG3YktF2z8OaKIdVfijYsqF008AbneWlcLLWtx7AvJBW8yK5Q1mHDueN
	ALIv/cLLah20+qIX70cTwIvp19PU/pkweHKZFvfTIPFsA3BXkSJ1e9qq4D3F5j7a9omysh5ev9J
	LhRFJSAHT8xp5/yVN+3fd1q4EhSMNEAe75YMpOm11MBpr+AsGU7b0x4BlI/E2wFrcOe7NjJR+7F
	qpo+JWjDm7xiE/LKGcB4Us/lMGJSMuz12qVeAKztd5YN5bNGjV1I=
X-Received: by 2002:a05:6a00:3d56:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845625b56fcmr13936142b3a.41.1782196609770;
        Mon, 22 Jun 2026 23:36:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d56:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845625b56fcmr13936106b3a.41.1782196609327;
        Mon, 22 Jun 2026 23:36:49 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c2d9sm13066301b3a.6.2026.06.22.23.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:36:48 -0700 (PDT)
Message-ID: <89700bcd-150a-4730-a7f3-fb4ea2228689@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:06:42 +0530
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
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfXwanxE5+iRr6F
 4qcHACTEK6WjvyBalSfLdap5QDFD9eHAi18ZeMOCEaWMBVXmwpf148UiwOVMozXyoE1GgnQ6Y0p
 8fKuzSstFumMczH2MOVWmRdeacMBZQ4=
X-Proofpoint-ORIG-GUID: iQ94h7LjP-UB0OujZAZcC_2B-Bd8b-f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX8+mM40SPeZ5a
 Un4pZLb7uNW41aQ8u4635RIgZBagfnpng7IlhccitAxJdZEz/RE68CsnGis5GIUNdArjd+kfaqy
 aw9LL/UJOL+DZ+ICh1Q3n9bMvvePFYUf6wPVvjCnUkIhYw+YbWYdxUY8NFsxcG1Rj0e+uoGPQ0c
 Z/Hp5epVsorVREDFvnunhgKiTB/4Uj6I6DdFdCfjdqmmwoX/+psvERiu5Vz4TF/QzAJha1dJlEC
 RpW7LfCqeB0oCXrotvh75Xfp73lFDBbJY/Df/9AKmsxkb4bSedoMAitwMDQGY4Cds85L2I7mOvs
 +pGKpE+Gv2nIy+BGufM0HMrv9bAzemVFfqPLU9EfJ/w4Aos3JYpJ3/8ES6OiLBjIrXrU+1H8gQA
 xPUkVTIPwtYsQ/dECoI1GFxQxa5oRnhy2ZOQqiUJsDteYFe1ODZZDgmvjho00lfK7XnuifztVPE
 8YC1gadvpCsezHt8odA==
X-Proofpoint-GUID: iQ94h7LjP-UB0OujZAZcC_2B-Bd8b-f6
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a3a2982 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=SGTO9LZbqZ65YKTLchMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37996-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:git@danielhodges.dev,m:linux-wireless@vger.kernel.org,m:tglx@kernel.org,m:mingo@kernel.org,m:joe@perches.com,m:vthiagar@qca.qualcomm.com,m:rmani@qca.qualcomm.com,m:jouni@qca.qualcomm.com,m:kvalo@qca.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,danielhodges.dev:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86DD86B49A9

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

I am not familiar with ath6kl either, but while looking through the code,

aggr_reset_state() still calls timer_delete_sync() only when
aggr_conn->timer_scheduled is true. However aggr_timeout() clears
timer_scheduled near the beginning of the callback, before it walks
aggr_conn->rx_tid[] and updates aggr_conn->stat[].

So aggr_reset_state() can observe timer_scheduled == false while the
timer callback is still running, skip timer_delete_sync(), and then 
delete the TID state / allow aggr_conn to be freed. That still leaves 
the UAF window open.

I think timer_delete_sync() should be called unconditionally after the
aggr_conn NULL check, and timer_scheduled can then be cleared afterwards.


--
Ramesh

