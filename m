Return-Path: <linux-wireless+bounces-37832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FM1SBK3kMGquYQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 07:52:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2368C44D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 07:52:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NXNcNLC9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Y+VOdylj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37832-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37832-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08EDA30BB997
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF83D6695;
	Tue, 16 Jun 2026 05:52:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561533CFF7D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 05:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589121; cv=none; b=gvS5eMRl45ttN/Wgy07PKq+OFkBUPpeLlkHmBr4OXWlBH5F0DzWZb8qd6aY7aA9s2CpdntfnyJIR5wmlYjFm43If5MTQVYtK6x0fFEF7yrqwCC7dOm0ifbCwY71OOQdpaYE+XHvMtyIPmFdAdobrhArLeEUuuUkKT07R1tyW4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589121; c=relaxed/simple;
	bh=PN5kFPFKTNSejW9lkqrQ9LY3WQMt3M0F3vap+BuYYpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi2t+CXB7q1K0uvvcgJ1OPCkoJaMsZQ4+nEkQsNQde+Y9HgAYXqZEfBoJ57yC+vBLIlARrYg/4KZnU9hc5LnGO02u0ONmIKLyVIjXUN9i6tN3hsMJv0OjlPpJFZlr8vTDajldsS/lG9R+ROlRMOyxHmq55+/tGSk4xCO4Kq10Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXNcNLC9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+VOdylj; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xfA11790347
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 05:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NTwtydChUQAyklm/gAQGK2Eydni2CX8i9kQ4nvHiFeE=; b=NXNcNLC9rrG7zpds
	mbO2FGCF7tgDehGnAPL9af18A0x+APrC9UhIAsMFI9cjAKpkpevs8mI1zaibmlzO
	TaKVcAKP20zzpipP9XHV9Fb7HNIfWT2RPcz57cf/l8Utbl0W42+4p8oUNnnhsr5L
	cwfV0hm1nCsBjuhdbGT/P1XF9wqGCNeiA/63TDAoEzOfXPr3RgH7of9sADIB3ha2
	+Qt6z/QtwkmA7OdbHoHhQgMHsUbIGWbUtUSsGlr3eVnZOAmeIiAVfLqYAOhm9xNE
	bMmpAhHY3hy+s8CCFlO22i7kahk9BZkwD4/d906JhkREMoFeNa3IkGa0Nzo0TWCb
	GojCvA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0n2dv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 05:51:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c6a2ee8cc9so469295ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781589119; x=1782193919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTwtydChUQAyklm/gAQGK2Eydni2CX8i9kQ4nvHiFeE=;
        b=Y+VOdyljmjIpNKVbke9uXkFdve+x4i/jraHg7FXh1SPYeO76aqSuItIpkw9I+yxW9O
         XMw5v6K8kWVn1LGAKk4hfFNz73Da/vd4A8SeWV/KhRdxhvQ4aRB1VO3ptbA3dGNjQyPb
         7L5+uPK1AOrpEJZWsdHVlbUd98LUxpngazwVaaHaZ5mbcAXs8qI3PmTCvMwktfpdkFXA
         phLSGiIMin4TtULInsbCoBX5eq9hTL8sg4xJkCLpFcAhedBVh2JODRbqCkAcXfmvMdRR
         hcUdxnSUBhKuXUtWAol2WXcQY8RC6ppIMNG+VY4njTpi13tcp8SZb1V4EyCKLLc5Unkt
         lmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589119; x=1782193919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTwtydChUQAyklm/gAQGK2Eydni2CX8i9kQ4nvHiFeE=;
        b=mmM/VPeF6FwKTEcu3hvQ9EebB4bVzt1pwL0O9kq5aySlDQG3as/qSnvFdigdn5WN3w
         3IRTpMogGsTp7vouCWVe+LXFZLnZ7iICfjfmc+a9fNm3e76r9NBwkuaPe3W5b7XIGEtl
         2UCMRd9ypZ0u9O5NBhH28rzgoi3gmdsKZ/JZK1X2hZuWoRHmeFltuaUb7xCWdyxxw9NB
         W3vRAqAw571gJr+QRIgTir+knyFh7I1mkmcoEC6zvdPHklSBghxAhzTnPl6VkbDP3RSk
         +fPODKp0KlVfQx6YEorT2zTLlVpDhTJkLpq0re4I+5L3uGW1cTH6wIBfN/EnHHKATT7u
         WWcw==
X-Gm-Message-State: AOJu0YzIDAlzgKVGWDFa80rpapVhF9iI3y/6LYXOYb5X/a14yZMa8tM6
	Cw0Voz/eETcuLfAzu2XFMsqXeYAXT47XBfEHlaTCGq2yQjtNdOJU7OKNzBw0admeZBxxuQJKcz3
	uSM7p82Vf5YK4z2tGb7DmA9XXlEK8uZJBIG8eLbKarN6k5X2W/LoPHkL9d7vA905F2yLgAw==
X-Gm-Gg: Acq92OEVQI7WrSAEwX86SeLXE7Se+Mspwhgg4Vp2FjgvE4VvrSVJgsQkQ7dXXtWgM3X
	kTaPKv2/6pSsusY/+v4cyC9V+pWvvs8pQL0QspPNbfNHcO/ph9gFaC0BTos/k2VOp/V3vcN1zKa
	MwvGixGonIz7MuND19PH8z9Vyudhqt670WUJB4K0orAD8uivMCEnhpnX6TBITzZ0I+P3dPd9b3X
	amO16faOtTrMqo1KIhSrAnjz8lebBQV1nC1sso1RaZItn5CdFz8ukzixqYJ8rTxrjozrzYt2aBg
	WmvKNq/XaN43G3ZQNq3VpziJiXgPeD3JV/j9mdZx57JOEg+BVZFWpOgKF6Vq7gMzqaH4uEB5Qay
	IUExGTba2iTgLL65gSBWONrvjMrmLR7rU990sG+/lE5JhXb/tqn69sf7TBrpJlvwr+fVy3g==
X-Received: by 2002:a17:903:37c6:b0:2bf:211c:4980 with SMTP id d9443c01a7336-2c69a21d1f2mr23438735ad.35.1781589118854;
        Mon, 15 Jun 2026 22:51:58 -0700 (PDT)
X-Received: by 2002:a17:903:37c6:b0:2bf:211c:4980 with SMTP id d9443c01a7336-2c69a21d1f2mr23438505ad.35.1781589118354;
        Mon, 15 Jun 2026 22:51:58 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.19.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a47f8sm112621785ad.47.2026.06.15.22.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 22:51:57 -0700 (PDT)
Message-ID: <9ed73ed4-3c52-4841-821f-0fae12f452dc@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:21:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: correct monitor destination ring
 size
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260616040653.3985702-1-aaradhana.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260616040653.3985702-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX/YDljh6clu7Y
 c20I0YQ+YMTP3wuQulF7Iky87ppD7PNwZKgDe74UNetkgDlvoTqBzuE5ovYyF9ymOsmuOBTRLBZ
 VDr7/nFeiCy7ZGSg3rC+z6pgoK9Sw+4=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a30e47f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=z+7zcDXV3Faa9n+rlPmSWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Vof7ml1Sp1nGWk4UEeMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX8BmYhrKmp+CH
 fR1a7INziJXSldnTZ7bdueRabct7gIMUusa+zKGSqNUKUSSpWxGTbml70SK9RX2RQG+4Z4zJGA0
 NWe6qENtFsPqfT4jYm9FP44bSgMLyZ+eg5CSH0YHqxMnVInugzd6qL8IRsI4FHb7MVJh3arBk5s
 tVgIoP3MKHI7DjORAmKlpZuo5fAGEJcj0Kcicqz1sdX0l0cH7em5aKnWta/rj9pMvxWOrEw/zAT
 U9J/nFbM1xb5C9QqnuZ3H57X3b3Uci4dER5OfNmxcQZgbAVzBrF7kna+TWghLpB/mO+GEkYNrZc
 weerAKBwI+8udFDkXcFlRXTYxK52KvUFKNRuoR/PJYsmaXKbIfnxJx1G5zZA+ikwsWnaUrBd5Pq
 TXp1YNRoVmPKL+4n5+xeTZ+ZYpxOBIeiXJuPKe7NuxVnCaR531qy+0Ftb+l6fO0zq2Jp/t92fgb
 I982jYAaNZ+5di1hX4w==
X-Proofpoint-GUID: PYlx2W53sR4_3yfsCfuGpjnhPsIWlpSZ
X-Proofpoint-ORIG-GUID: PYlx2W53sR4_3yfsCfuGpjnhPsIWlpSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160055
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
	TAGGED_FROM(0.00)[bounces-37832-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62A2368C44D



On 6/16/2026 9:36 AM, Aaradhana Sahu wrote:
> The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
> which is a typo. The intended value is 8192, consistent with all other ring
> sizes in the table being powers of two.
> 
> Correct the monitor destination ring size to 8192.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

fixes tag?

The rest LGTM

> ---
>   drivers/net/wireless/ath/ath12k/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 742d4fd1b598..b488bd8fea9a 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -49,7 +49,7 @@ ath12k_mem_profile_based_param ath12k_mem_profile_based_param[] = {
>   		.dp_params = {
>   			.tx_comp_ring_size = 32768,
>   			.rxdma_monitor_buf_ring_size = 4096,
> -			.rxdma_monitor_dst_ring_size = 8092,
> +			.rxdma_monitor_dst_ring_size = 8192,
>   			.num_pool_tx_desc = 32768,
>   			.rx_desc_count = 12288,
>   		},
> 
> base-commit: 83f028be15fe071efbee8e27837538d6cca77e87

