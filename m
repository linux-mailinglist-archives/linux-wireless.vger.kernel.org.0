Return-Path: <linux-wireless+bounces-33490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAj9NMElvGkxtgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 17:35:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 342452CEE9A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D0943257624
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645693ED13D;
	Thu, 19 Mar 2026 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8lLtu1A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8QZHT9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEB3E9589
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937431; cv=none; b=W1aeviv2C48hb+DK9FqKFRwgi6Vd2LSGKhf5zw4iTvsN0Y9hGIcYlZKfKwqdhakmvy4YjEQ8HY2xDgImhmD0S+oX1Je9uNBfmhsU8G0VAuCj2Jtidnsb+5PjyaQltoUV7MXQAxd9KOoWNrl89bj+EPcN4G/7HkvOlCN7JvHzwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937431; c=relaxed/simple;
	bh=kCoAXdPnfQwrfHjZYMKY1Ps4+Gi8OopQRXeKsPORwsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9CogF2uBTQV0LgdM1oCkDP9hZE3P2/GMdvjYhMHpJ21Eb1p6XCJhyrmHeuHj7zD723RL32p2CviA/uEOIdDKS8XyYlo2DksPeTSZxIk5aV5Drp2ZO2glsddMN52snpUjPaA+wG+DlW+24ggoGES//i3FBMYSCoh2Pzwk7mWhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S8lLtu1A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e8QZHT9E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JF0ph42544562
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 16:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPcf2trL93E6xZUMO+BAJd0tDKLmZYatHQADeNtCTTE=; b=S8lLtu1Aefee93FX
	WDR0EOGMT0KpKx5fZ2wsr9BxY7iS7s4UIyQ5h1V/zy5+C5TPkr5DXjNKQXU35OFZ
	Bov6crWDX/mq+/9V6JFFiCuTGYnhKovGCWQok25yofUt/SMcpKW0bAkItQmHJteG
	k8d3khXzWH3bD2BHwyMWJ+VnhCb+UfI7n3znNLsh1wWSkbzcPkv/r+q8J4lBSmpC
	wv/STbVv5NhJ5FX3UFvFa+p90J5KduIkx2dZq940ETJBNuKq7ntv4erFUEIt8Xnu
	d+/AYxqt5GI9j5iPr66bddjGzmZpO9Pi2Gsox4HqHf1Fe4LwOeHbTUs5ECF9MJl+
	BJcr5A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0957tamh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 16:23:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae3badc00dso14577375ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773937424; x=1774542224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPcf2trL93E6xZUMO+BAJd0tDKLmZYatHQADeNtCTTE=;
        b=e8QZHT9ExcaNcrGo0vXjg673zxFn71OdmMbLDka+sWADrJ9WLy6AxjavbLF/dlk59u
         G3f2SNhRcP/JGvSMT9L92zt8/aJx156cDkH1JUALkEgNh4s58aVjBrZkm7dnC+3mSGt8
         YZ1ukljv30qlm8GWWcUagYMhqq4NNFPgF3xdydJoWhyqjrYTbsYzcUNpPghAfiPPuDrW
         UpkPOkcYB3Yr/K0qoEKoHCggY4ENmssSrxACfymmhvi0SvxGAkRdRUBiTsgHsBjymwzI
         TgJstKI4Qaj9obiyfwsYt8lQQf3dRkw/xnxiW6Qou/aTO5XzoXGjEE/TEy6Dj23sythM
         WMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937424; x=1774542224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPcf2trL93E6xZUMO+BAJd0tDKLmZYatHQADeNtCTTE=;
        b=UO2Ee/w4+IDeyshrJv960wkAVJvNJVUamDY8kqJUBcccJ6knorn6sjA6tzXvFTeo1a
         taCQ+X7M/uQOKnuzqZd/sSSksmBNa4WI6FjSihkk2MiOUfhVEMiGgGgNT4WHVxYQvNOh
         SRLvzjUH757EQ+5ZAu8xZ2k/O6FTsPVYN0jspJfhqS+VpOcKtE63flxkh+Lmdx9m4Nmw
         ABu7NLqf/YZUTbT9S/ylalJgjkLuowLCw4fd1lGUFSiJkyuVlNJSJtg9UpRFLrhggFwU
         OSf9tvQLMmq0ZSCb8sXccrN98lv1EzzOeubmc/wuvcIZJTqZMuf5SJekvYGIWvQdORkC
         2yrA==
X-Gm-Message-State: AOJu0Yxr9RU6dLuvB4PHhKxIEvskRff1nB5t2kXyzbOhFN4luOMetqjX
	aEPR3RLE7AtDgs0P0JVnOOtVb6TTMAX48SQhf3x24KrRJMr7tBzbSIm9i0gX2JoFW9CUK6cdA3P
	X6TbyuTlwnqNJmeU45eMR1QawPJqlU9vXi/smcvG1vyzYOVpsvAd7coG0BBVxltM573RA5A==
X-Gm-Gg: ATEYQzyTYH//zEISN8kmxkxlUVmkvYjF3+bvzHvSgNMuIUwHKKbyCmmR3lhesGDg8ZM
	pkYZIY0xShARXhRKNnRm5vEuJjLpFHBt4t6sXbXAKYEykVyLrSXYH6JrDcjxfjkrYqYRMDVcywb
	LU/zcB3Nm5mFiFk6wEVQZ7dMH0yE5V1w0IWOE/xL/BeGf6+oytRWatLbdG05D8AfJo21LapPJcB
	kfPPn6wqtAqEESdufpVuEKa/Q8YOEX4Hx70yRHWc7Aeec0eN46gMvtxFdkIxNpppgorAnIOS+OH
	VyWgRymW4k2JkP1k2rzhcfYzyXAoO4782smMM96MMlsUytlGq9itN6NInyLPyeA+/om+x8lb4gf
	ciXwXpLWs7iHDEWN8bDyEgnFU/lbFw2c6c2MvxybezF+Ji1/2Rlg7gcPWC7QkyX1c3Aqyxb1e
X-Received: by 2002:a17:903:1666:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b06e3dd456mr66987765ad.26.1773937424307;
        Thu, 19 Mar 2026 09:23:44 -0700 (PDT)
X-Received: by 2002:a17:903:1666:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b06e3dd456mr66987605ad.26.1773937423754;
        Thu, 19 Mar 2026 09:23:43 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.250.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e5694acsm5797420a12.24.2026.03.19.09.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 09:23:43 -0700 (PDT)
Message-ID: <2ad176e7-05f4-4ff8-877d-f72479c942ea@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 21:53:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: prepare REO update element only
 for primary link
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
 <8056cb5f-cdde-4890-b8cf-3b37d1c3483f@oss.qualcomm.com>
 <1a037a6b-f39d-4624-8f3d-1298da8c50bf@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <1a037a6b-f39d-4624-8f3d-1298da8c50bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UfQBfTrusCTUE3CdEN2Pigh5FMkE1YBc
X-Proofpoint-GUID: UfQBfTrusCTUE3CdEN2Pigh5FMkE1YBc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEzMCBTYWx0ZWRfX4M7lKuZPIvx4
 TlZWg0gf3eJyRAC9lQDw18FKtMRaimn4rjlHFCwqoSEebP7RqYF9ulU5+4FM3g3S6rAQeezrguh
 vuwZr9xgOOBoH067n9PeXJYGThgO5Li8Y2WPZiROluJ7VASnBvQWgyj0YLyJ2V3oIKT8lQI89DR
 uE4qbEuxdXZj+WNwmVtZn2VUHr6eQyvlX7TpxYy93NeA6b6/K0EEt+TlOqUHcgx67g5U1Fbqc5B
 lHE1aURna/ywnWwDktmXyvzJIz0sTfvYUCNDBdeHMa92Bu3UQRGNMHN2WV9ipOgCHxTuM9LobxS
 AtljsnelczaVhP02Nd3AZaX9TkkqqipY5Rzp1n3Or4AsyB6nixraId79UB45ZLJP70YbBiEXWLM
 Q0mnUazUpu73AS9mgb4zlrPhXLKECcfSdBziSb5MA+hlQPzVVvW2aRsxND7JR1BiSIKFg0MmGZk
 rb8EFmLTSm16tzS45Lw==
X-Authority-Analysis: v=2.4 cv=RZedyltv c=1 sm=1 tr=0 ts=69bc2311 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=t7h/bT458PYVitGB/2kRvw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w4kZ-GgywCtsffi29wMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190130
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33490-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 342452CEE9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/2026 7:44 PM, Jeff Johnson wrote:
> On 3/18/2026 8:46 PM, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 2/10/2026 8:37 AM, Baochen Qiang wrote:
>>> Commit [1] introduces dp->reo_cmd_update_rx_queue_list for the purpose
>>> of tracking all pending REO queue flush commands. The helper
>>> ath12k_dp_prepare_reo_update_elem() allocates an element and populates
>>> it with REO queue information, then add it to the list. The element would
>>> be helpful during clean up stage to finally unmap/free the corresponding
>>> REO queue buffer.
>>>
>>> In MLO scenarios with more than one links, for non dp_primary_link_only
>>> chips like WCN7850, that helper is called for each link peer. This
>>> results in multiple elements added to the list but all of them pointing
>>> to the same REO queue buffer. Consequently the same buffer gets
>>> unmap/freed multiple times:
>>>
>>> BUG kmalloc-2k (Tainted: G    B   W  O       ): Object already free
>>> -----------------------------------------------------------------------------
>>> Allocated in ath12k_wifi7_dp_rx_assign_reoq+0xce/0x280 [ath12k_wifi7] age=7436 cpu=10 pid=16130
>>>    __kmalloc_noprof
>>>    ath12k_wifi7_dp_rx_assign_reoq
>>>    ath12k_dp_rx_peer_tid_setup
>>>    ath12k_dp_peer_setup
>>>    ath12k_mac_station_add
>>>    ath12k_mac_op_sta_state
>>>    [...]
>>> Freed in ath12k_dp_rx_tid_cleanup.part.0+0x25/0x40 [ath12k] age=1 cpu=27 pid=16137
>>>    kfree
>>>    ath12k_dp_rx_tid_cleanup.part.0
>>>    ath12k_dp_rx_reo_cmd_list_cleanup
>>>    ath12k_dp_cmn_device_deinit
>>>    ath12k_core_stop
>>>    ath12k_core_hw_group_cleanup
>>>    ath12k_pci_remove
>>>
>>> Fix this by allowing list addition for primary link only. Note
>>> dp_primary_link_only chips like QCN9274 are not affected by this change,
>>> because that's what they were doing in the first place.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>>>
>>> Fixes: 3bf2e57e7d6c ("wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures") # [1]
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221011
>>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>
>> Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 
> Was there supposed to be a tag in front of that?
> 

Oops, sorry!

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

