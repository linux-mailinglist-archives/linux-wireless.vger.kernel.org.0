Return-Path: <linux-wireless+bounces-37906-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7EnHGrppNGrCXQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37906-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:57:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECE6A2D69
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:57:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=X07FYeW5;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RG5Z0gnS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37906-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37906-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6821D3048571
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88B2DC32C;
	Thu, 18 Jun 2026 21:55:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47463254A5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 21:55:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819741; cv=none; b=gM2IsA4qZe2mcce4kuZtmcam/bUxYdzrZkpzIR7IMe0YoLxqtGAjdcY0qZm7fom7o1Jgbf8FKOeRdQnXzlCynGxo05Wp2oBV5pchfU6WpPOaAOEaH6fDvZxR2A3yPv1h+NMPE0ytqcCVvL/fVilgGVMK1Bkvkji0rF5ugPk9a4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819741; c=relaxed/simple;
	bh=Cbh7yMu02gWFAqvQBXkQS/CSLQG0i/YKJpQqxJfzxhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWnnBfAKMKoljI8CXhgLakqTeDEm155fjzwKLTXrjjEsA0vqdLLGZU036VEXA/qKrEy1nwcbBvyQv03d9axibex4+n/yECWnsMHV9c+GUvn/OEzCWqSb2f+uuCEiu3aTO1J9nmUNPx8LWw3LyQ3neFgukXNXGsIqIndzInI4Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X07FYeW5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RG5Z0gnS; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ILs9Lj2444125
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 21:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNsa7I9Vt4mc8undy3jW445YkhGT6jOLPD/WUCSW4VM=; b=X07FYeW5m4O3SVUq
	WI47OZK6qiwRiKZZCu+Yw0gLudL5lMuG2kga/jxOph4Wcg9LC/QUIuT33n9OHuPy
	oMzv7ECaULszW2NIPyszKZ6mvf9t8U7/zwwodcmYaEG3tNd+XJN8GTiYe31B/RH0
	m411CCbRsImHcxRgavJtXyReEJUh+1SbxG/7s30AobH8oEaIpES3MaIE3GxlrGzC
	RNWwHCJfXqxZ/d55xrckgI7DAwLCKSVqVq0R26AreKm72ovgyO64YeJFr+E7hnWh
	6dFVKCpegglsP0UmMU71t5jCthlcIexoxqAxzdOxoevcJEtqUo1EmKIA4iEXvI2n
	JQksGw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn4341x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 21:55:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-138455d7e20so2729687c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781819738; x=1782424538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNsa7I9Vt4mc8undy3jW445YkhGT6jOLPD/WUCSW4VM=;
        b=RG5Z0gnS6xIgsbITVQNEecPTtQadPfwIXAnCbYGo5YoXZL1K65Bz5+JR4B7OtfE8XS
         fEncI/IGpGcAfJQLsMCgDRZajH7rp2JMKjGGUMtKbKa+cy/sV1dIfV+5XGaIKY4e5GK1
         cS1NlbYSat4qQOxfgmofdbe4rvanO2zhiPPcnu87jpmpDGJAD2T8azCIM25spDgHn/Ns
         7sW9JT6e2y+ySlGUnfQpuharM2ntqhvZKgWvwaW03RjME3ygMgViIlvFfGjA+jER8Cmb
         Kb5wAAz/AbVkA2oYapCCQB+AO+vx6y5MEYixENyCM4zxaLHEovxN/RJkffnyfpE9s09z
         UUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781819738; x=1782424538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNsa7I9Vt4mc8undy3jW445YkhGT6jOLPD/WUCSW4VM=;
        b=d/pvuM7dhzrzpPv/ITrqnKCFABu91zgS9Lzus514O6rezJKjIno/VLU0cLRWHnxcFX
         lMMHxrmLSasxb7ykUKr8ezRjguP82BiV8nAhGSur12Po6nrIJeDxoCDGmId/TKuvV1XU
         bmWz2cvcrfbt3NkgXKI+gzxYDabaQcsGUnWl8xpXi5FDewo6+KHWzLMHHZO2A3MPUt/3
         rcUlio7oxTmWJrWwb5tJXfS7JSn4F5waNwfNmdsb7IioDV+e7eCFiJPTeJzFpZTNhMn5
         JPu5wXRItLMOWwjhWu80kgNVtNKKPwhr61fXFvP54UzPmGFEWfaHHC1OvnUQVXmsTQfa
         8NrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SQr8zvvrJniQnKFVVqT+5fczJdQkDcLXA5kIMRX9xEpRK6ADL8FJz9Bp3TVAcfk/RQWeU+6PRnB6gUnLfxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztw9JegPGvo5WHtjog9kZFs5yzTff/O4+q3Y+i6KciXWx3rLVW
	lASYXTRujWYrwBIDfUSwpnKm9oXHs8XjZyfpkBU4853NBBUlM4DpRhT6rDCFmRTJJed3wtpjhhd
	olRFQyUWdK1W957kmwpJydK0AFucPt/eSQayPOBMtSnTGVSTishUjaAzi7BJ0T9jUb6K/oPIm5D
	/TMw==
X-Gm-Gg: AfdE7cl6nOkYWVRWnbsZlJXvvO3lr2Xf86wes2FyHR1q6BxNYlvyB1V4XaUcR02ZygN
	f9zUcMwg/L4AodDbWqYrNkAXIbjcSKRhgukaYkgtJ8TZZW+Q/LwXTkLcl2wUXvq396wvsPTmsod
	8LYXSXLloMEeRYMMmYSVrUTkCLmiQNZzM9UQOM/sdSrWtL+Kw7w2wgIJaKm7+H87brgTFd8IUxV
	cmULMGqgu/2DhJzmu4AqG0kvx3vCFRqwZ1aJIEMNLttkdMfGlvRKKDprqR9ycAOc1MlaaMiLJ+D
	uJslfqFVgsLjMQZ/5XywoYyLemRT7oNR+B3AIaND+0AOrBpSduWsyLWs0tqldeDSZFJMCnTBLa2
	4irN1yrXUVjaDmfTv3DGLRNxas7YyaSvooIrnBJ175YarQTCgQvLzrNE7dnKGO0hUBHgs0cUBBk
	YjrvE=
X-Received: by 2002:a05:7022:41a2:b0:136:e639:9c05 with SMTP id a92af1059eb24-139a217155dmr1087419c88.31.1781819737745;
        Thu, 18 Jun 2026 14:55:37 -0700 (PDT)
X-Received: by 2002:a05:7022:41a2:b0:136:e639:9c05 with SMTP id a92af1059eb24-139a217155dmr1087398c88.31.1781819737185;
        Thu, 18 Jun 2026 14:55:37 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139a367f73asm312545c88.15.2026.06.18.14.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 14:55:36 -0700 (PDT)
Message-ID: <9c08b419-7180-4ecf-8a9d-026a80cbb98a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath9k: mark PN9Data as const
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20260616030652.635121-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616030652.635121-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX+7FWO2kMR7wH
 jbqVUOlB3zu0bpnjdQy/X66a6w/mK3COFX10pQjBL8avoDNDKUEYKC/d3tvJUeCGPtF34lyAUxW
 FnCZeRz78vLRLV/YKlJbRdbBc6JjlqeR2fgiMqrjrY3REQ1geKL8foGAMj9AG7qu0s7CN3Y73IG
 Y/ZFNo9R77sl3OFew3OAeafQxEguelhMPI35zPt8jyIqcvulwFPM9hC8m6LuLuM0idfd17Wd18P
 wILIvxQVXOlK0akYiLSQJBsU3Rf/agK+ugXcSctdEKeSiKZtLefg6wYZx6No7PG+ZnTTJjV4mV1
 YWAazV8Lgo3u5cy7AJYu/2cvtP0vUG3+fsW0aWxvxvEFcWZWofZ6AsiOn0dliEdle/sOk52XJvt
 mUQaCnc12y5oD23C99EWq4pV+6z6OuIGJab6DjKBZoJuhXIHCx+MUDV+GdyTUJkeK2TNeCr7Qma
 cQiJL5cq7gwlPeCmRPA==
X-Proofpoint-ORIG-GUID: u5NomEOKIhyzO2NEor2JlNXbDHWKuPiX
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a34695a cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=xOomHs3cNmDTsBMdfcEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: u5NomEOKIhyzO2NEor2JlNXbDHWKuPiX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX5SDMdakKqvGV
 pnCRnCx0svbNAEgEbqwjOJI7hvSX/8sJUbcWaldcFEOMB24tbtj9pbAmZtcn1oexkdQ1QkAn55k
 AWOXeE2f5Y7lRnTb01spPv4S7oOAHFk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37906-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0ECE6A2D69

On 6/15/2026 8:06 PM, Rosen Penev wrote:
> PN9Data is a read-only lookup table and is never modified.  Adding const
> lets the compiler place it in .rodata and prevents accidental writes.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/tx99.c | 16 ++++++++--------
>  drivers/net/wireless/ath/ath9k/xmit.c |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/tx99.c b/drivers/net/wireless/ath/ath9k/tx99.c
> index f2144fd39093..b52d84f6cbc9 100644
> --- a/drivers/net/wireless/ath/ath9k/tx99.c
> +++ b/drivers/net/wireless/ath/ath9k/tx99.c
> @@ -39,14 +39,14 @@ static void ath9k_tx99_stop(struct ath_softc *sc)
> 
>  static struct sk_buff *ath9k_build_tx99_skb(struct ath_softc *sc)
>  {
> -	static u8 PN9Data[] = {0xff, 0x87, 0xb8, 0x59, 0xb7, 0xa1, 0xcc, 0x24,
> -			       0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, 0xea, 0x50,
> -			       0x2a, 0xbe, 0xb4, 0x1b, 0xb6, 0xb0, 0x5d, 0xf1,
> -			       0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, 0x53, 0x18,
> -			       0x0c, 0xca, 0xc9, 0xfb, 0x49, 0x37, 0xe5, 0xa8,
> -			       0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, 0x18, 0x84,
> -			       0x02, 0x23, 0x23, 0xab, 0x63, 0x89, 0x51, 0xb3,
> -			       0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, 0xfb, 0xc0};
> +	static const u8 PN9Data[] = {0xff, 0x87, 0xb8, 0x59, 0xb7, 0xa1, 0xcc, 0x24,
> +			             0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, 0xea, 0x50,
> +			             0x2a, 0xbe, 0xb4, 0x1b, 0xb6, 0xb0, 0x5d, 0xf1,
> +			             0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, 0x53, 0x18,
> +			             0x0c, 0xca, 0xc9, 0xfb, 0x49, 0x37, 0xe5, 0xa8,
> +			             0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, 0x18, 0x84,
> +			             0x02, 0x23, 0x23, 0xab, 0x63, 0x89, 0x51, 0xb3,
> +			             0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, 0xfb, 0xc0};
>  	u32 len = 1200;
>  	struct ieee80211_tx_rate *rate;
>  	struct ieee80211_hw *hw = sc->hw;
> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
> index 89d8b3178784..57e451548958 100644
> --- a/drivers/net/wireless/ath/ath9k/xmit.c
> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> @@ -41,7 +41,7 @@
>  #define ATH9K_PWRTBL_11NG_HT_SHIFT      12
> 
> 
> -static u16 bits_per_symbol[][2] = {
> +static const u16 bits_per_symbol[][2] = {

unrelated change not mentioned in the commit text?

>  	/* 20MHz 40MHz */
>  	{    26,   54 },     /*  0: BPSK */
>  	{    52,  108 },     /*  1: QPSK 1/2 */
> --
> 2.54.0


