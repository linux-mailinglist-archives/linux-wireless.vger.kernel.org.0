Return-Path: <linux-wireless+bounces-33364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFHLFDDvuWkFPwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:17:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1F2B4999
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40BA304023F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3097E18DB0D;
	Wed, 18 Mar 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KmGyGi1o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbfgPOgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3F70830
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793069; cv=none; b=KwV+l05YMDUjZ6qbyCAp8DI29CdSM8VLuRZwRfF5r1/YK7Y/LKXzrRxPTwTxBeH5kToTbNZsxBFcj/U9VjM8zWVMuXj3EfsBHGKCJY+rlhHAK187jdLiBNOHgOhPBOCigSWvWka5sJJMHKdBFLOpWTs7lcL3FxKGE9e1pXLtitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793069; c=relaxed/simple;
	bh=pMzEFpBgPkJUxC29kYMMi15r+hM4G9FRX3nLEfSPDN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6T0jysf6JHio9mqpZMPXkXn6RaLErQiuhRx377bzbZneMd/xDR659FLJS68r2CR/lVH52phyfcd4qh5avCaHTNDV0w0WTJcsjWVmAN2vII+iarGVQRyhjrz+t3tILz+TcCV1PaM+tVvdfnz2k6Q66PSZ4tqjbkKc1Y6zXv7kD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KmGyGi1o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbfgPOgS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJRjj1370904
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OsEuIeYeunUYsxBkTNU3Sm5E54z1MAxMRTKCi/1j9sI=; b=KmGyGi1o9NzO7og5
	oqnSYYow0dmSh652yLmJVOP4f10dL1IcOPxreXJvDG6/7ycLDJ9jUf5RBVNHxNmn
	cCkI4fSv2IkHR9Y+gqgsXhrIVcDYaK/O3yAB9lTgos2H7pY1qQbWvZpBa2JdhzYf
	1wMOzySSgkxRP62E0LTRqMIyDSLkmXq84nRHgxKZ+ZecOsUi199Ji0cDVeabcDzZ
	FVNM1F4t6nK3X9cMD9gYwkwBCGoMAOeR1387TXgnNYcjzz7i0e5IqiIv+3q1lUG5
	Mp81eGNb5MmPHjVVXSPTSW+AI70O6/Gg3SKLCzZGlqdsF4KGfKK9kOdI/HeF9D0S
	hyE8GA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he2grv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:17:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bea3b0d83bso13189676eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773793066; x=1774397866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsEuIeYeunUYsxBkTNU3Sm5E54z1MAxMRTKCi/1j9sI=;
        b=IbfgPOgSjDJhjfvdR7/ybnH0ljqdYOmBMCVSY5m98ZJBV/Os1ga4mUvanlkOmhfnzf
         nr688GKEH5EZlY4M5AuzLeyAPPB5qbhHkb7ZXhErt5rfxpK/hyLgAxZcuatnMTrrxWfT
         xPgH5nCMvwUlND5IFVAPPOguqw/hyOnHY8uurrbA9kAH2NZmyF73ibqYiq2KUM/bJW01
         CpKjx5e613pwnhLcVEAX42yZQId4UVjiRoj///2XkgSeq0b5LLMBG7RfCzHAZFP7d4rU
         +CZ9Zb+6fa9w8b4/DvzUSMeDSPzgdOQJfwY5TUS18OOJQF0MYYiF3rNoD8fBCw30qpB1
         GYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773793066; x=1774397866;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsEuIeYeunUYsxBkTNU3Sm5E54z1MAxMRTKCi/1j9sI=;
        b=VhU9NPQXrBVf7xEqL3/sL1eIbNY5vfSwqTnNkId/xSVXlOK95G5mTzey9U66TN3rvW
         DSkMGSdB7zdNkGk7oA3f2cvpOPtgfkO8hH2WGiqaFuWVjAc9wUeCb5BUfVNj48GBPfXr
         Wf43cy7w1P1r6KhgwPxAHpLf66OH5wB/CG9UWeAFUzdLs3GmQEMtV2bFTxcATHaM9ldM
         Ix1hq/OHmnLOdT2qps6cwJ2wEUIdppDheuTYAgf/9bWwMzGp7GpQJi7MJ+Q/8ps2R2JC
         B0FqrpGvaY+2n5/B9Iqx7fDZ95GmcBXAlMIx40rKnSSwqflqP7JkqPJdukJhhPGSMIxf
         Gc6Q==
X-Gm-Message-State: AOJu0YzKd9Ip+4+0xt6kMmvXvYSXv5hQ5a9NNftnYwdmrX67cVBjIXUF
	9Up9fYS2qowf8/HaEUQaCgVWa2iGNBI4IsLoQgi5rRPGEDo4R7uxTkvZf00SEWfWCDWI2eiPYdC
	/PMZPN0wC4KNXpJdhXP1/t862p1mqvrTbZii7WYFw5gnh1X1PfSlYdEGKaUrfl7/4B/4adg==
X-Gm-Gg: ATEYQzydudG5dpQgx983ZckOJ9Mlic+TrdnjJbSHqNdZftmSyiDyX8HgSAsz9yzwEzP
	KQfkKdHRXeEHQ/3IVm6wP5/YGrH6RZusKQwgDoyOSSSasv/5Y880ea0hZ8n+Tji0X/a4TU+yqDb
	sn2a5Egj0Ct4uVN7pu+WQERYMwD7xnob4fAVLYIQGiPgmpyGFHGe8V+QRQ1ziOC0tIVUqlaZlTf
	KbsbkNDk3FhVmPPUue4wWnEH55wiSaLe1djsw5M57anIhfG1gviQN8yBJE6tN1+73mWQmF/1TkZ
	0l8baAQUPUqG4RSUFdc6J7J4I15rK+1zGIbYQtUG4CVuXI3Iu2jVoXwX+Z5ga/hQ2VQkHMSe2a1
	n31hG+Gm5PxxDj4iLQdoMFlizpnMA0jGvaQc9lnfb4BnIlXx/FAdDL7m0q8BCbtT9g6DT2hxnNy
	1rzld042KfdcF5Ug==
X-Received: by 2002:a05:7301:4b03:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2c0e4f90b9dmr829576eec.13.1773793065583;
        Tue, 17 Mar 2026 17:17:45 -0700 (PDT)
X-Received: by 2002:a05:7301:4b03:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2c0e4f90b9dmr829557eec.13.1773793064958;
        Tue, 17 Mar 2026 17:17:44 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e560fb5fsm1907343eec.31.2026.03.17.17.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 17:17:44 -0700 (PDT)
Message-ID: <bd262372-9930-4abe-8917-fd037623ed01@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 17:17:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix HE/EHT capability handling on big
 endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260317-fix-he-eht-capabilities-on-big-endian-v1-1-e7b937b32768@westermo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260317-fix-he-eht-capabilities-on-big-endian-v1-1-e7b937b32768@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ReiB_xaiPZf-rBGW7ho2WICzGnnHhyMe
X-Proofpoint-ORIG-GUID: ReiB_xaiPZf-rBGW7ho2WICzGnnHhyMe
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b9ef2a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=N9GNhs4bAAAA:8 a=YmICAkyFvM6EgTkIZ6oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAwMSBTYWx0ZWRfXxPHzlB3/UOxD
 axwt4Fo1VGyP9UE5YySwIJmo6Q1PrNB4s4bCtq/RcyvqLZutU4Bni5SeJYzI972IV5NOEQnXljQ
 zwikna6Ns3RVzBGa1eb0bjqtYl9P6qkpWqxUPNohe9Oq/XxPxpA3mho7rq2ju1L2tk4ResQlCuN
 feT3q2LdxiuqwqjVb/4telYn7SQseD5NNKvMbJvQn/eb911o+QpLDHYAgVH3E2MP2FvvBUq34/d
 hRS52RanRVjqEB55aLXzsDADYjJrFwAtZ+AbW/nKCoxEJpUKJj/txXwfNfBPmJaT0RHxaZQ9qpu
 mQxlJkY6nlBEPKmtLnwgXzR3tXM8CUDV1LvMbFNdWoph3QmD9sYKS/qSh5z+7EvG/2H1YahD08t
 z2zCrJCEqv7xwnJBLCDdoFrQsWLarIMv8jT+URnrtkDF3ZcqMg6UyI34UhNuzM6lWJUUcsSAHWr
 RUQByXnoUR9Try9uICg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180001
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33364-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,westermo.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A7D1F2B4999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/2026 3:59 AM, Alexander Wilhelm wrote:
> Currently the driver uses u32 data types for the HE/EHT capabilities in
> CPU‑native order. However, the ieee80211.h header defines these fields as
> u8 arrays. This causes the ieee80211 registration failure on big‑endian
> platforms, as shown in the following log:
> 
>     ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
>     ath12k_pci 0001:01:00.0: MSI vectors: 1
>     ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
>     ath12k_pci 0001:01:00.0: qmi dma allocation failed (29360128 B type 1), will try later with small size
>     ath12k_pci 0001:01:00.0: memory type 10 not supported
>     ath12k_pci 0001:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x1005 soc_id 0x401a2200
>     ath12k_pci 0001:01:00.0: fw_version 0x111300d6 fw_build_timestamp 2024-08-06 08:43 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
>     ath12k_pci 0001:01:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
>     ath12k_pci 0001:01:00.0: Invalid module id 2
>     ath12k_pci 0001:01:00.0: failed to parse tlv -22
>     ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
>     ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22
>     ath12k_pci 0001:01:00.0: failed to create pdev core: -22
>     ath12k_pci 0001:01:00.0: qmi failed set mode request, mode: 4, err = -110
>     ath12k_pci 0001:01:00.0: qmi failed to send wlan mode off
> 
> Use the __le32 data type for the HE/EHT capabilities instead and avoid
> swapping, so that both platform endiannesses are supported.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>

With this series applied I see with make W=1 C=1:
drivers/net/wireless/ath/ath12k/debugfs.c:413:65: warning: incorrect type in argument 1 (different base types)
drivers/net/wireless/ath/ath12k/debugfs.c:413:65:    expected unsigned int [usertype] v
drivers/net/wireless/ath/ath12k/debugfs.c:413:65:    got restricted __le32

From existing code:
f5c90ff80b4c0 (Sowmiya Sree Elavalagan 2025-01-30 11:41:04 +0530  413)  extra_mcs_supported = u32_get_bits(cap_band->he_cap_info[1],


