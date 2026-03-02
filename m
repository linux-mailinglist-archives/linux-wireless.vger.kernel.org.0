Return-Path: <linux-wireless+bounces-32330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HgJPLkjopGlVvQUAu9opvQ
	(envelope-from <linux-wireless+bounces-32330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:30:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B131D24C3
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42C8C300D326
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293C26290;
	Mon,  2 Mar 2026 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OD2Tbpno";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NIt+dhf3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C02632
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415045; cv=none; b=P5omdjRLkUi7GpVnMbFzF24ZmdFZ+UPkk1rxzP/ezhAv/koGSvJp1HMKxXu9/1gasjfJiJduQnxnRguen9dGGxc+QcpHs9lO9XuPcXqCc69gYUwl4rny2p+IaMdcf/uDaAy6bBNYqmc7hz1Y1LRBnClH3w/Af68DIqryQWpJY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415045; c=relaxed/simple;
	bh=7YimznMlMqpcCaoCxb4058G0StupKbA+WZ2gMdsyYhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyEs/V7vQhdJK6rNXMj17X4w6PpSHS/5KbMbPPGjCxOqZhpjY8F8ZL55PzYfry59maoXogOQLhXrdY4PUV4E81y9dvIX0vL1JiHdMNcuAja7A6UnR/8SgU1uw+3AzywUm15TQpLlkQ1Hrxah1fzTXTYySdh+0MUlMWUdJoi/Tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OD2Tbpno; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NIt+dhf3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NQ4UR2353289
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 01:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kL/TuXcE9gf7aYW7lJRqr95c37rKLHGoDKsfTHS5Quo=; b=OD2TbpnoaXakn5WW
	yeZ3CkXuQNA9ZuZmamjgd7MioS3XzQV+LRacqVNQXc6YNOl/Qih4huLwHH8kcMN2
	8M9TK/cNNaZ0MzTJegTk5u/7XgP03TBoY2e8Xif1peVjsEzMBkLLwGwiD9plCaHZ
	CzyT52qcNjmoQEzPaT24hOZ8tAzaGNtqC6PyNc0JPpmjeb+FGtelwK0bYj4XguGS
	+9sUdy05TvleWH4LgPeT9RiIhrP4VJhPe1AYpx74bznYK6OflNd8+zeHhn0RMNX1
	WOCwsQHtMRsnOh0jk1LwWcO1+lyQkDqFLBfHuNiPHQz3/Ki9OsNDcDvmubmBemkj
	eKW89w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksfd3hvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 01:30:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35678f99c6eso2621902a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 17:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772415042; x=1773019842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kL/TuXcE9gf7aYW7lJRqr95c37rKLHGoDKsfTHS5Quo=;
        b=NIt+dhf3IfrAuKtM695OX5yG/sTmVuFgjZwAGKUopi/l3DMUdSOhYVKAJV4X0PAwSL
         9rKCq3tQXnJW546xZxg8liylqdaSflbnFmdu5PbyKmhm8ujretZaj3pIAMF16CbKVqbW
         UWwyrjZ0E5u2OTewLK56J7Y631rBySs6rbjhGV746PjKk2WvR+buJKcbaNrj+ZQF1U8/
         TrIbh+6fn84o8D02+uc+AlMfrV05bfX8xRwGA0dADd0zz/ygRbHm5j2If7KQm6f5tdhM
         fDxp6ibalqYToRur9SKJ98ew5P9VHs7LXVw+pfIoWJ6d6STjRfTet7Hulo6VIxr2heNE
         sXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772415042; x=1773019842;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL/TuXcE9gf7aYW7lJRqr95c37rKLHGoDKsfTHS5Quo=;
        b=C3OACLr/QY1gYYrfs8aEjXPFre5aLhmxJ8ogxWwWJnA3r2dbsjB6eBdz6xKYO+MVYI
         /SZCXA8eMgogiOmBHaSP9UanUS9GUssol7FA1YQSLcPK0uCuAMT0BvDDaT/EIT+TEO3C
         MXgCYvKUec5WEE09jopX1waZ98CNBil9UooLE//2l28cdDRB002+nX5rEpH4/n+AMX0n
         adWJMTrRX0nTHj50/qf933ZUCXeojwTs/Kj+7MuiVU9iuntFlyKrh4jxBcQ4414t2Sfm
         nHHi0QIWVTVgF1ByAwVF0Q8NQnLsxmULiISRT6AGrTc650U4drfszvT/55azBKiRxWnk
         irvw==
X-Gm-Message-State: AOJu0Yz+me3P+lWccFB0jc0N5aAp4E5DYIYjIm3feUjfMOgTm6JFk5Xv
	i5Y/CHnjn9HNPEz+BpxuRHLaO/DuJWKqB/1Z5WgVosLmGcq/+qTVZNWbHVZu/KxWCDnWA4T6O9S
	GuE3z1bkJuP0i9siA6NLlDqHGrvs8ldZygULd5YplkmZGQcaJo7wr2cNn9iBuM4DA5wC7AQ==
X-Gm-Gg: ATEYQzxCL/vyQBJheivLDzRoA5bMMO9me39swuqxg1j2NdA4LKp3JSbf0l+6QflscOK
	ZuntlofLaRW9WUxsZZol1FGHzOcVzqzctjilQ007zSxnqc3j39xBJvNeYXnF0w8NTFGjoPY4sgP
	nKztaxm6orKZaabrFyl6njZPy5P8QtDCbPnZDnNvC+eWpTdYey0ZT9i8YrTn+i6tLHUpXSz2Dtl
	oxsuYrkV7MxQRyzKJgonILakXVjQ/TRGxaV96eJfwqi++KbNkGdES5PUo0PL3oSkvY6gNIsaEwR
	fid15RfkaQLeZrhakwGVAGoKR3aALDhBOkuhxR1ruBr2PmTVp/TiGRnRotiJ1M5A09XWDR/w90g
	M3CCs61tQCMbZiovBvY+C6zIa8FoNI6/G4o1wpDjhEMpIxPOQntYfwqj5EYjiGcYc1IpDmOhh0V
	Wi1k+Mxqynr/y0qb/kUlw=
X-Received: by 2002:a17:90b:240e:b0:359:8d0d:5905 with SMTP id 98e67ed59e1d1-3598d0d5c70mr1239664a91.9.1772415041131;
        Sun, 01 Mar 2026 17:30:41 -0800 (PST)
X-Received: by 2002:a17:90b:240e:b0:359:8d0d:5905 with SMTP id 98e67ed59e1d1-3598d0d5c70mr1239632a91.9.1772415040565;
        Sun, 01 Mar 2026 17:30:40 -0800 (PST)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa65sm120951355ad.58.2026.03.01.17.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 17:30:40 -0800 (PST)
Message-ID: <c4cb8b56-717f-401d-8b98-5fec557a7abb@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 09:30:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: account TX stats only when ACK/BA
 status is present
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: s1JBdOfgO1Rq7qxAOF1GvZ3gmc5xCDYk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAxMSBTYWx0ZWRfXyh+DPppl27GR
 5vcyBWRY3kHmMpnLF8/yD/UrQBDBzwnevp/Z36NLmVfOO+eKRPztjALRbW4r7mLIuU9QE1TntcD
 FnHLXCTHGuA5XcbwAnqWJwriJif9DdAfKnoReQ0ccmm374NiHvExC/C9XjCSXCyofbEhqvoWGux
 7BVK/vhccJQgc77sQP4ibhECTtz+5dgbvQUiPUu6MECTFB+3ne2Ua1RLxYbDjk2dUwr3oMD3p6c
 32odhh10HxhPqP+XqVSr9FhJwbgCH6uC6BRevR+n9mvyxxvFNYhPbivbAaMKFi3kcjTYuwqjrKY
 RfU8T+v4xzAz92+rF98BcY2rCXN7G6vHwmzCRZWSP2CXeLv0MpyU3lGA/8qJNL3eIipOX9GTwY5
 XhxZsEhttMYonGqIp2DFiNjFe/K5+dQwf3OdbWE0c8msIyckxERQ4dsTOAaOXT+b6FGoeHOcHJI
 LZWr7O7EcO5QckbVsCg==
X-Authority-Analysis: v=2.4 cv=HKDO14tv c=1 sm=1 tr=0 ts=69a4e842 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CSDw-C9IAAAA:8 a=VLjYsMtYoAVcrLbv3zkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=wzwtrm5WU4lM03trS8pa:22
X-Proofpoint-GUID: s1JBdOfgO1Rq7qxAOF1GvZ3gmc5xCDYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32330-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1B131D24C3
X-Rspamd-Action: no action



On 2/26/2026 1:19 PM, Sarika Sharma wrote:
> The fields tx_retry_failed, tx_retry_count, and tx_duration are
> currently updated outside the HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS
> flag check. In certain scenarios, firmware delivers multiple PPDU
> statistics for the same PPDU, first without BA/ACK information, and
> later with BA/ACK status once it becomes available. As the same PPDU
> is processed again, these counters are updated a second time,
> resulting in duplicate TX statistics.
> 
> To address this, move the accounting of tx_retry_failed and
> tx_retry_count under the ACK/BA status flag check, and similarly gate
> tx_duration on the same path. This ensures that each PPDU contributes
> to these counters exactly once, avoids double counting, and provides
> consistent reporting in userspace tools such as station dump.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a0b963e1da5b ("wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv")
> Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_htt.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
> index cc71c5c5de5a..61c1c3b2350e 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_htt.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
> @@ -205,16 +205,9 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
>  	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
>  		return;
>  
> -	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
> +	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON))
>  		is_ampdu =
>  			HTT_USR_CMPLTN_IS_AMPDU(usr_stats->cmpltn_cmn.flags);
> -		tx_retry_failed =
> -			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
> -			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
> -		tx_retry_count =
> -			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
> -			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
> -	}
>  
>  	if (usr_stats->tlv_flags &
>  	    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS)) {
> @@ -223,10 +216,19 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
>  					  HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M);
>  		tid = le32_get_bits(usr_stats->ack_ba.info,
>  				    HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM);
> -	}
>  
> -	if (common->fes_duration_us)
> -		tx_duration = le32_to_cpu(common->fes_duration_us);
> +		if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
> +			tx_retry_failed =
> +				__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
> +				__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
> +			tx_retry_count =
> +				HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
> +				HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
> +		}
> +
> +		if (common->fes_duration_us)
> +			tx_duration = le32_to_cpu(common->fes_duration_us);
> +	}
>  
>  	user_rate = &usr_stats->rate;
>  	flags = HTT_USR_RATE_PREAMBLE(user_rate->rate_flags);
> 
> base-commit: 62f9b9b19939138c34ce0ac1e5d4969d617ecbb6

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


