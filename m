Return-Path: <linux-wireless+bounces-18306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A4EA25F66
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 17:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CD63A2D44
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F8F9D6;
	Mon,  3 Feb 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INuNE7S2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33E1D63DD
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598455; cv=none; b=HOLeGUv8tDK/euzCQNQ2HCPd7dRHR6wiBrLl0h9RL0VBIBc66xKwY63BfQaiLxJNgzveJdQOH9zU6zBAno/uovdmMBregA6bQuSqpbTZKTEkATjmjVDT0KyJOTY/4srF0QEDfxJlzulVCiOZWn5AiiWubunWE1JEciiWVPkAiY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598455; c=relaxed/simple;
	bh=cUGEmlTfZ3BrSF5qtygv8YXWvS68TAqz6anX8jgZkNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVhgKsu8JlPTRqr7WLO3IdLMDIxROkKyl1xg8bb/d9gXNWLZISwalQVP+Rd+9Zz8Hez6gVsNc8RYhLrZzxmGRzp2KojvyfzhBWdOh9Spn6ryRXTQHS7RWj9cIcYW8s+esQmSjtW9qI6lLP4OUUktR9qFvgUvQDHwKx73K/Evlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INuNE7S2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513EOKJT014396
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 16:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mfR4VKXyWrV0SBIXo4O5uvtC0k7une1HxqT58YlUyMo=; b=INuNE7S2K1gnpaoA
	tcHx5L5imZtJWKMblDUgO/VOkZd/x2O2OwH+Er7sG/V61a8SuOKzfmqHiSHUY/1/
	9FD7QhtBtFiO3h2aMOXkhdejN+J9JjZw3TrvzFrcwhXTITTUiS0wHXCPe/1tk4g8
	gcuAVOxRngrLgIQCZdckTudEPmhjQxBeynyODi38wKeXv16qO4O6KxlY6fpQGxBL
	NGHBhK9gVnI/wRMIdTt7u1b/YoSIq99HhSIeuDOZ4YVu/9c7IOp1AcaUSzG04Z3w
	GtLgpXx/gHuAPj8fuxgMZxdsBapfm/tJDK0PYfvZwxfF2/LbQsMOck6RGDWZkPZ1
	HUOSNw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqk4sm3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 16:00:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so8712341a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 08:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738598449; x=1739203249;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfR4VKXyWrV0SBIXo4O5uvtC0k7une1HxqT58YlUyMo=;
        b=nTjZ+osDIfkk5vqgu10mK/RCZRha/vLw2JSeY6kTGfIoQlxZKzeTcJAoFmRMA9pBqX
         fyvC5RpFYqt3zJgLjyjEpmR6FR0vSxNUSVyAIVgj0VPpr2abfJZaTLDXcNjwDMV3HIcI
         DfOYO37tKZtjHI8QyA78Vs/+YjxGcKQrhR8whM9DmJ6n3zbrKtnVnoj715I6lDTzCm5A
         S9c8I1tt3PNAAeMxqWg7h/YS4BAUMkkuli3TWW7zex0KSZVJ8ag0/1FJBs1WUUKtDjr1
         IITdg5OEjuEQ1ILT7/rpNQLKg2aDTGFEA1RP23XUjAWBKp8NuzZvjzePgYyS0dckFjwz
         MEHQ==
X-Gm-Message-State: AOJu0Yyyi6TF/oH0ReA03gGfOz1ZAk6tkxR9lC5VNH+wJMc6dXmaFSkP
	hHRU56a92w/CoGWZ0gkAVGkutsbNQ48SEfOpi/VZ+vMGFkXrzBv8/OmfkeZiz7i7MBWGdk+SVSG
	ZBkCSKGvvngSH62KNTDjQO0HUpXgAB9wzPXzSq5wkmfsuW8kMJ28mYpc084q4Ho4YljRCzY89kw
	==
X-Gm-Gg: ASbGncs2hWYCkZVDl33EkUZyCy92wLBUbvGtzGrNcQ/Al7TyOKtzQcaQO/IKug7beT0
	D8ypk8Qztd/X5eOacVZ5FEDQ4PfihxctU508dVt9BCwfzqRLfgpBnnzdg2sWTnD2O2DzwUqbXxU
	Gh8utkped0/WHFHytydxN2YJqvi2ohPm0iWXYFODdpN85q+n6h8Dm6+hz/Rht5JKLLzJlFBc199
	5ghbrcvzdmw09RW6Wsm8hOpHKVkL+rUbQLcWQdp2LQKuJpBrgV5TJbg5lznP0UUPh2FYptPVSIM
	9Q95cPxolV/8FAoKxxed5iFfaRSZUCciUgmo4vzQAw==
X-Received: by 2002:a17:90b:1f92:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2f83ac70dc9mr30680617a91.27.1738598448735;
        Mon, 03 Feb 2025 08:00:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBWw2JiHfto3mg8GUpLcoM+KR9w42+0ZaIJ+HnE11/NNyG7cl5PEKS/5hlxpQnQbjWFgC3/A==
X-Received: by 2002:a17:90b:1f92:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2f83ac70dc9mr30680556a91.27.1738598448165;
        Mon, 03 Feb 2025 08:00:48 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc98ae9sm12613925a91.10.2025.02.03.08.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 08:00:47 -0800 (PST)
Message-ID: <edcd9883-e2c9-411f-be8b-2060818f849d@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 21:30:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] wifi: ath12k: Add support for MLO Multicast
 handling in driver
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203075538.3982875-1-quic_bmahalin@quicinc.com>
 <20250203075538.3982875-3-quic_bmahalin@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250203075538.3982875-3-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UcJ-DHYli5zBhbeZGCIvZhf478ResJFG
X-Proofpoint-ORIG-GUID: UcJ-DHYli5zBhbeZGCIvZhf478ResJFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=802 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030117

On 2/3/25 13:25, Balamurugan Mahalingam wrote:
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7151,6 +7151,22 @@ static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
>   	spin_unlock_bh(&ar->data_lock);
>   }
>   
> +/* Note: called under rcu_read_lock() */
> +static void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
> +						    u8 link, struct sk_buff *skb,

Can we name the arg as link_id only to have clarity?


[..]

> +
> +skip_peer_find:
> +			ret = ath12k_dp_tx(tmp_ar, tmp_arvif,
> +					   msdu_copied, true, mcbc_gsn);
> +

Remove extra blank line?



-- 
Aditya

