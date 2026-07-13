Return-Path: <linux-wireless+bounces-38934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AiFRCXhwVGpFmAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 06:58:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 770947472C2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 06:58:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=e+APuPXb;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JbZNsYI6;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38934-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38934-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1B83010386
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BE34EF1F;
	Mon, 13 Jul 2026 04:58:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BD34B1B0
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 04:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918702; cv=none; b=UKwI+GZW8sB7DYe5jltCTot22spcQMH899OKljRzrNZjYQn+cIEvg37wIhhC5szKq95Dzfgf60flhKRzO8fWxyr5TXdRum8tY7XNFmgNY36vVbYTTTOiuoMIW0ob0CpElVnX1x+O/XRkcBi1T5shHdupinAm3nQE1FIt+xtNDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918702; c=relaxed/simple;
	bh=Rcn55AigOJlRYDWoqUy4GH6klil9Q4N/1bAsCRDHtyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlIS3/2OuW/pRsIOTosOZKyVRomDKPx4c096qNTZbhISVAF3aZQVdB6LRhZRvtHc6RV0NdUL9EVYzhwZqqS8E9AGcfbS20AXBlX0IzfWtt67qV4NxQL75Ab1Wh7AxT9CO2g86ZfmFIwOVG78Ab6x5vTLSsH+VMQLXfGWFuw5R4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e+APuPXb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JbZNsYI6; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D39vlX216651
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 04:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vspwlS95JYJHwDxCx1qplsZZEuintNFQ72bn7F0hGBU=; b=e+APuPXbz9DxGDzs
	DhisJ5rdIXXiRQMpJlwmnsVR/iEoZj2l4pDZW1uPAGd1OSEZyVtkKHNsO+HZCeBb
	9kXglqjkgRSbNDSkzJxPNDCq6m+NooojY4YTJx1tw6QbLvqv9NuTbFJc9U5v9Rsg
	T+44otJEaSJEEBKMGqlgOtEzi0kEfDdeKvlyRpQBH/vhAT8iPjtwbcj/JuSUKk1/
	gD0eETpfmP/FQml/Gpp6Jyzxim7bTiyt0C5wgKRbBIZyF/jht9P/7dsd/lNpYJMX
	yvOY4Eowh7+M5YrZCbzabSW2gF6qBVp9PXkj9vkz+qzuNuRFGRj3PzPq432fpTeu
	nxAG7Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr4a9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 04:58:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3810960140eso2646971a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 21:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783918699; x=1784523499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vspwlS95JYJHwDxCx1qplsZZEuintNFQ72bn7F0hGBU=;
        b=JbZNsYI6n2/v9NvzLA1jnt8EIoCwVE6XwRCO8jV1jdIS5ychzHENCSf0gT9lt24cUS
         mm7pzi9ReQIHWFbIDEH7O12lPYJI4HvXn2ujJ9Nk0s/loVJD8N1aqxpdwj+9R1SyxUOG
         bCUALQTI3MbX20KlyhMAdHUpgTMNDVe7cXOAXPULkinMCtd/+VKr/3RZyoltnuXA+/hm
         1rI+BD2ZSMIBSYX0BqQ9mHGYzQy6ZC/q6OdsbPygyRy+1S3QTsBERN/PAj+xXCaj5cwc
         fxqYj8MH8v83NN3+J2u1O8R7VwBZYDA03Q9q6drgd/Wmg/rUwrkb8GoIOmFTkHGxtXTU
         lzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783918699; x=1784523499;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vspwlS95JYJHwDxCx1qplsZZEuintNFQ72bn7F0hGBU=;
        b=Xow8EmdhBOIILeLMC6zrhnle1HeQSkLfMxDCyXFJki0oxDgL/Bh+21QSfTNRzCfdiq
         LucgG6f16spyGqrFjepKHDZVY+DhKFHJMOsepks49PzxHEaB96MCB5gmJFujYvQmMM6p
         VSRvI0FrR+kssduhnoHLrSUTfswwD4KyL6QRNt/KjHxZHMU26snSjPE4n6mkGzDa0Anb
         brsYefHIyrp1rZlwrsgte0MmZTKEPTUW2F0xrMeHh45JtCBx92USknB6OmghFqoGr8dx
         bFhFboDK/bsiU+BqQCQkFFAf/8gP6RR98bLhWty2O0KPoBfElxjX5QHkyXU0SSV9YCNR
         k5SA==
X-Gm-Message-State: AOJu0YyhiqxjGQcm/AhQkYsB05gJa+1diYWAEJK97YWXkChv5RGGCcH7
	57bK9+FBEbjs4TeEP1qnv0mBc8oqrHbk88EW5KVkQqLxLoy4TqI1iRaFHDbQ/Fcu8zAHCtCCbG+
	p2iEKB9EJAAPFCitUlTGlilRtytuEGSfTAmfqwYVteJ5DdkD31d5hIEGz0wjWDpd7LkyS8w==
X-Gm-Gg: AfdE7cmcuary5tYsxpnUvXET87tBWdUCWzz4jxQbnX5qGsrJ2AnnjSHmG9yK5BRUhVo
	aK0e0FR9yJ6AxzfQJEENWAjPBwowk4zjCKeRML+MyZol11bIQDBrHM1aazbDwhQC75aOgncKDLY
	fUm6DafCPRPjY62/a+TR3KpQ7KKmTjx1QansyoLaEG+U4zjReaG2Xe0APAQJ9ImPPxbasSnyVpG
	21CzJsCwcLvec5lZdwHhI3uZOrSfvsE878p7nfybCkBrkCbYo8LKLakuPbkheiRmH9mjQ4lP5IP
	CNPlaIb4UhnmwC43KOICJk8ItLk0wGD9ehVEsnyg2l5MnQmYEnSFwtVVzd9weQG49oD+xtoO5rm
	9bgXCX881ZZoC3fXEuQPTTD4jSe+UPhpfBNVWvqA9FGrxASUe0uQ=
X-Received: by 2002:a17:90b:3bc7:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-38dc77ee692mr8247068a91.26.1783918699248;
        Sun, 12 Jul 2026 21:58:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc7:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-38dc77ee692mr8247044a91.26.1783918698779;
        Sun, 12 Jul 2026 21:58:18 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm44958051eec.24.2026.07.12.21.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 21:58:18 -0700 (PDT)
Message-ID: <bcfe2b9c-3652-424c-bc3b-29aed334250e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:28:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: fix peer delete race in MLO
 scenario
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA0OCBTYWx0ZWRfX4fRTBMJVNLUz
 bWDx3yNn7CsfNbKP8OzFm1PUlBvKTYSEApxw0iOsZB3QY1ENF5XjcMhKUsbcDTjYTqd8bc5MIbR
 hfHWIh2XjxL9VNVmcVS919ttk9Z3NdM=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a54706b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CzddmEZrVGVg-aw9SIEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: LH7M9SEQa8vZrkcGIq1ievzxBtaZ3_8l
X-Proofpoint-ORIG-GUID: LH7M9SEQa8vZrkcGIq1ievzxBtaZ3_8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA0OCBTYWx0ZWRfX+nKz0eNRJN9M
 l87h25/wlQsAT/kMe0rHN9FXFQTnYsxssYwjGCrafifgxZblY6Y2NwOIVuRCGJsIEoFY9eWtRTT
 e08kXIJdaZnmYjtEtWoiLc+XWqKcQplfBXpB8B5lVtqo0L+QuuDwjGfTsTzYsvF6Jk8G/MrgC2t
 Y+c5HEWSWcXHrrIX5F9MNgzwtjzXCDeaTKwodshZn04m2L1cXL7vf5TeGaugyivj6cLTD5Ufurg
 O24PYA9vWHvt+JjrFHUkyXcFkcrheiXg5FxEYyHWdO9Pt2/oHBaR8HZC+itYBA1bSHnsMnbYD6a
 xrbLk3Egb1qpatsKicHwKxepX3XPDW9VkDXqQjIPmHf4PxRP+qQBoK8ySJ55s6FUWq8NdEknXPS
 2u80knsC+3X9BtQT/QKMjqxprf8WAgBKPKculhVPske5qtKWQkzRmOZs1Zh6lNpCunZAvXkUjRH
 wLTs1N0Q6fe6R+li3TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130048
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
	TAGGED_FROM(0.00)[bounces-38934-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 770947472C2

On 6/29/2026 12:31 PM, Baochen Qiang wrote:
> Patch 1 fixes a pre-existing UAF in ath12k_mac_vdev_create()'s
> err_peer_del rollback path.
> 
> Patch 2 fixes "Timeout in receiving peer delete response" on MLO
> disconnect, caused by a per-radio shared completion that gets
> clobbered between back-to-back WMI peer_delete sends.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Changes in v2:
> - rebased on ToT
> - patch 2/2: make ath12k_peer_delete_wait_register()
>               and ath12k_peer_delete_wait_unregister() static to peer.c
> - Link to v1: https://lore.kernel.org/r/20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com
> 
> ---
> Baochen Qiang (2):
>        wifi: ath12k: fix dp_link_peer dangling references on AP vdev rollback
>        wifi: ath12k: fix MLO peer delete race
> 
>   drivers/net/wireless/ath/ath12k/core.c |   2 +-
>   drivers/net/wireless/ath/ath12k/core.h |   5 +-
>   drivers/net/wireless/ath/ath12k/mac.c  |  20 +----
>   drivers/net/wireless/ath/ath12k/peer.c | 130 ++++++++++++++++++++++++++-------
>   drivers/net/wireless/ath/ath12k/peer.h |  14 +++-
>   drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
>   6 files changed, 133 insertions(+), 54 deletions(-)
> ---
> base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

