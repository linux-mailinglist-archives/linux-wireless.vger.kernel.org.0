Return-Path: <linux-wireless+bounces-31252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GDqFidveWkHxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:06:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A289B9C228
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3B2301112D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 02:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13D2586FE;
	Wed, 28 Jan 2026 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxNVw8q8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mw0+JkSd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB692280A58
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565967; cv=none; b=VrdjiPWImwj0aL20G55rv5/0zNx62ESQQQpH4u5h7t/hN8xYqG78ERod+ROeBKLUzK9jZPl1Ofucn52RCd62kJSvi+lGnaZbLNKbYiJi89QouUWjBdIqJwiJcdyJohU/qf+lX+jTqKppqK4yP6vvm15bIX5qxZ12jS/rUFrA/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565967; c=relaxed/simple;
	bh=T0fQwoejAhhI4wk3axXcAVjWhuykPOvo0Rvmn/qnurE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYNkhDM8d/TH8fu8VQV3IEaH+6ClhDn+E0DTrL5vn6HdOvnuWCGvF62xjdaQfSafFEK8F93R1dsmIHsxxyWY09GQU5MbrgqaMaSMh+aPrQ8Ox1cKlBhtJ3YWi8MLqD36kLGpsB6A2s305ZfhRIz7qB+k8yznolOhTjuKgyQUxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxNVw8q8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mw0+JkSd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHDto41980951
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7GdfNWoQOx2wbL3Rpbp8KJiedIwRL0vwTYCw5YiGsLA=; b=cxNVw8q81T+fRzUW
	uLDkKfYJ4rqck1I81Ootw3yDRBa4v1C/VwIfh5C8GD6jQoY319IjS8Hc2afekdIZ
	mWE4cIkSv9SKt8ZPNzrz65Hu4NucTU9sj60M6wVP5xLqXmDUnxx2L+GQX3l6MHAK
	rsTEiMl4fObpC6oBZVe4hs44pSyCaJItj8YY0B/Qj2nBtIbe8ws5zvAWPs2oUIVC
	ccJeCxeXX+ZzVHFVIgpN1HANRhcHrgc67fPup5JP5KqpNB+zscprnZDEYDJIPXcR
	GNVWaG7GtfZ1sUgR7ylQRGdqruI27OuFZYjGsqy1G6YymBgAUqfItsVbrGExPGsC
	BwbvIw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1jx1j4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:06:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso3319788a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769565964; x=1770170764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GdfNWoQOx2wbL3Rpbp8KJiedIwRL0vwTYCw5YiGsLA=;
        b=Mw0+JkSdOv6+A8G8EYlB3ZTQ1txYlXNLAMDfDU8vTI7onaNZU8YsIEc0jrJGCdaO4Z
         rNsC7gLIZfcMaPNjW8QYyZ7+Wgy8HppTe916LYlRZSxf9HMN/goe3phaxgYSB906TAJ2
         gxx6t7dIxLdHoC9PLRE0fV0jxoOa0z+fthZIJGoTOxDfddxHBiGYkwYtHaqBTGwx7el4
         Kd1GbcCGK2yQMzEEKHK96GSEIigc5u5RPPERb6aAX4FWB23ZOPSBnkpYqK1AMmH/Fh0V
         uMeB2v86nX1EVeGb72Fl6OpSFVg1NT25kZ7lOGwZXqiTSsgKGSk27gO6eGeoA9oyxgLr
         dSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769565964; x=1770170764;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GdfNWoQOx2wbL3Rpbp8KJiedIwRL0vwTYCw5YiGsLA=;
        b=xOI6mi9j/n5p847MeIvuj2Cie6LAUG1kVw79Le/F5SFXUxydFSA1KR4+G7FqWjuNWJ
         5OPZL2ptVmbOCv2EJlU9IRIdpOCsP5CQK0EiwpiWcYKqcZxFPqiC85fDCiimtBKzegKH
         tmJwfyYD5bi6soAVElPhLP5Vx3Ks9MVDPcmeR/Ra/oni06kcf2IIHWigftm7aFswspiA
         aQwYY3t6QZSMXqgSKbi3cP/e5f3eB1E6bQfzxNRkY/qemmzcd9PjDo08rl++e3VPfX/c
         sIS3IxQ4wFeaLxu3hQ8d8qjxIjpVJvI400tc7wRqaWe15K+rek5zrWU0CJhixKQuQjeW
         SdRw==
X-Gm-Message-State: AOJu0Yw0hvuxPUkh25fqO/61r0eg3e3+hTbbvGSQpRWEIaz6EC7+HvaJ
	+S3RfSz+cm+pjD8SwPgz5pF56u+pC3vWeG7IBQIXyU3lhmsyPQ8nXFpQiLJMqJKvyzbmQzUAD1z
	Eo3ImUsVBtYNHckGxvTA34HFnIwgjvAnQWkCJENkiye6nIDmp7zFpXNc24NEtevmb3f+Lsw==
X-Gm-Gg: AZuq6aLSIqNgzfSmQoZVhWS9fh2pMhRG9K94SxQCIFPg4240JBcE56SRA1QsBmzGTOg
	iyCWa3aVPrYg+ON7Naj63xD0+QdXfrd7TsyIeZlf07DI1Revo2MHGnjRl1gmKwCUoIcey+QeUJd
	FuyfMpeO34eYMblw+b4m23Et7hR6C/iKAy8JSbzt3AAe1gFPLDn51uWaDDcFiuRqfYQEvzrDejB
	feIrIBz0khxnxhP43qXqWRA/a2QQkko5jqbMoEkdVCABSplnNFLlrmOKDdD9yGx9PVg16oWRUbH
	dbaO/fmMBovKOP56mzcpBVNtQHu9ep2MQ+vR1cAdyJEDkRrH1RUU8USGJJqf8MMIeH1WlIndNa3
	fG5B3PP1hweB5rtps5b7KurS8l/Am6DiHvoFBvinXS97Eqg9ijWmLY8KRB674Fo6tU7Z6IPc=
X-Received: by 2002:a05:6a20:4310:b0:38b:e890:2f36 with SMTP id adf61e73a8af0-38ec63ea641mr3733001637.46.1769565964327;
        Tue, 27 Jan 2026 18:06:04 -0800 (PST)
X-Received: by 2002:a05:6a20:4310:b0:38b:e890:2f36 with SMTP id adf61e73a8af0-38ec63ea641mr3732961637.46.1769565963640;
        Tue, 27 Jan 2026 18:06:03 -0800 (PST)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642afbeaf3sm606356a12.33.2026.01.27.18.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 18:06:03 -0800 (PST)
Message-ID: <14d34890-93de-428e-aa40-e81fc182fb27@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:06:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath12k: fix wrong TID passed when
 stopping AMPDU session
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Pablo Martin-Gomez <pmartin-gomez@freebox.fr>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260126173655.1369715-1-pmartin-gomez@freebox.fr>
 <9c418260-b67a-48aa-80c6-6a03c91e4ba3@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9c418260-b67a-48aa-80c6-6a03c91e4ba3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pg6Ixy2BnrcOFb-U8Lyk7NhIjXOb8c7Y
X-Authority-Analysis: v=2.4 cv=duPWylg4 c=1 sm=1 tr=0 ts=69796f0d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Mtm5E0ZguzLvzxQ5De8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAxMyBTYWx0ZWRfX7jdWrsJJA2of
 XXSjTC5Pbvq6OfqBDENwQGyZ5iLqgS67nCSU0IMFRs0/O0bJQwVYDIZpvVpF+o7f0B7OCG7OSIY
 hzt3VrVBjttrjGVzZOPYusrhbCoPRsHAqY5YDKmCve+xb5hpYKVwwXD45ezO9TwEqWJfSIAKOm0
 JHP3XzE4cmGwmuEoWDvcY9mmVVpvyU7oSt0YU4WkGlqTX2E5zLOKp/dQAF7dnZGGkU+V2bZ2mtZ
 eazkbHMkSdfMuwdXO11TjygScQdvrSknBkEuPtx54nffjKY6CyRUmBrn/Rhc/cTZSmWTJwe+owj
 IC4RNME+QQN7wEMaM9QAjz8M3qYq18t4WA1Axn5RFeMT4bgCrc9r1IQ87JSFkYJzkN2LtGYNcKO
 QD8bdzZqhL57n7XeX4jRDx4qFgTeB0yWbOQ9LLETdYcqmOHNoXgcaU/4O8KPcruM4AiOg/FNSJt
 uZKk3+ByJB1PXLggrFA==
X-Proofpoint-GUID: pg6Ixy2BnrcOFb-U8Lyk7NhIjXOb8c7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280013
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31252-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A289B9C228
X-Rspamd-Action: no action



On 1/28/2026 7:39 AM, Jeff Johnson wrote:
> On 1/26/2026 9:36 AM, Pablo Martin-Gomez wrote:
>> When handling a DELBA request, ath12k_dp_rx_ampdu_stop() calls
>> ath12k_peer_rx_tid_reo_update() to tear down the BA session for the
>> specified TID. However, it currently passes peer->rx_tid instead of the
>> entry corresponding to params->tid.
>>
>> Since peer->rx_tid is an array, this decays to a pointer to the first
>> element, effectively operating on TID 0 regardless of the TID in the
>> DELBA request. As a result, the BA session for TID 0 is stopped while
>> the intended TID remains active.
>>
>> This leads to incorrect BA session state and may significantly reduce
>> RX throughput, as traffic that should use aggregation falls back to a
>> BA window size of 1 on TID 0.
>>
>> Fix this by passing the correct TID entry:
>>   &peer->rx_tid[params->tid]
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
>> ---
>>  drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> index d28d8ffec0f8..f2327c82953b 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> @@ -1289,7 +1289,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
>>  		return 0;
>>  	}
>>  
>> -	ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
>> +	ret = ath12k_peer_rx_tid_reo_update(ar, peer, &peer->rx_tid[params->tid], 1, 0, false);
> 
> like the ath11k change, this also triggers ath12k-check:
> drivers/net/wireless/ath/ath12k/dp_rx.c:1292: line length of 95 exceeds 90 columns
> 
> I'll break this line when I process the patch
> 
>>  	spin_unlock_bh(&ab->base_lock);
>>  	if (ret) {
>>  		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


