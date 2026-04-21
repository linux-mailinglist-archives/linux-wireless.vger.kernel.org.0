Return-Path: <linux-wireless+bounces-35115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zIv+K2UL52n13AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 07:30:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0494367E5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 07:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52C0300D955
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE952874F5;
	Tue, 21 Apr 2026 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdrcY/nj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jzxLcH8L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC0288C96
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749410; cv=none; b=aSKiasdvjeum/0s8QM1kbSV8h7h+DQE7eKwznrSuboVxdQRTPkbv/rK39vnGZXSj+s6B/hb1j35KMvr9/grNLYD9Zt9taXttAtAZ8IV7z96GoP/K24o5sedkAp04qZBhPHSD9xqrj5r8s5AActe4Z5KA+4bkAADkxSo7fGa/YCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749410; c=relaxed/simple;
	bh=A187TcPp1BoGM6xS8Cp1OE70A0dsu+ev7e8rD+gZFLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8FAfcilKIDwZIHu2520m8gQk5b96l5/YDX/jArHsjuskVG66KckQDU4Xf6uslAu7msZ1oy6Bsr1vWN2SVHS846ZDfFdNAheN/Uks3ytl590v+Do+kVT3ulpOHD0V5/+efmjZ5JiOyvOcRgcgK/EtR7crT9/mZCFeRt+lZk4BkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdrcY/nj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jzxLcH8L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L1N25b2281664
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 05:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RVII9DN81leMzQYL9YT3QxHsgikUgGmZbz/C9ipZ/hQ=; b=HdrcY/njjeBPOL/5
	Oadf5AI9pkDP9aWZ7luW6j5zkr8tNwBsMvbXDdQxQRzqdN4n7rrcvyIfEOfQHwjM
	3Qoehj0tebhEOioeN1PK7rBSAqQjEP0fGDK26FmG9zpKHYKoOO9YkC0ad6fIsU6w
	7QkD7BCG2uGRRXyqjX12EQrsRk7uTAtRh31vO2uRS1mGaboBiJ09jNINsHUsE9+m
	9nEAm4r5Carkt/qfp/3fvwgmOHO7gijPnVZIkAt3UoX+tqRit4fTWKk7yj1ZT6C3
	1ZMS9jtcj1lx+fu2x7qI3QYL/ooK20otEfJM/8QP64LzF3R7TaLM7WdXr4TGEkZN
	zb7NkA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh59bwry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 05:30:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da8eb0553so4301576a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776749407; x=1777354207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVII9DN81leMzQYL9YT3QxHsgikUgGmZbz/C9ipZ/hQ=;
        b=jzxLcH8LQk3XOVj8fMm9LcAhzftn0Hk3x+dFPC9ge9ELHT9L/fSD/BU/DHKDAV9ysD
         Qx763cATTbDwFAyvt2+6HRNAwVMMtsfzvopNDyN3hFXfxEmzcGyR5bJKnE0AONnqKD16
         NYG5PNJhJEQFssJc5v3NBz7xgEvOzJLkonjZWneBCAoCM756Em8aSUmA1EZYBkZrl/UO
         OfKgid2LuJ/4V6xsz5cYt2vTvZ5rmL/sx6V/7dN+RafmtbNz+XKthTjN24bXQzmLqYoZ
         IS66DcdhOUFovU3aByGkPbvbDsyi9x4i43BZIv09eu4n7PI2wqDUDU2zGya9vks5i1qw
         /KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776749407; x=1777354207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVII9DN81leMzQYL9YT3QxHsgikUgGmZbz/C9ipZ/hQ=;
        b=cUVujeb4YWpUlI8mTs2zAVh09xys8iIxfl3mblPtaAX+rxq10Bz1kviOy2pgsoBWuN
         w7ojS0wWs8LndTFWL0hQcIT5p8Og/x+FKolg0XAdYziGwGs8y/LNptwewZfet9Fzp1GD
         uq0qZspZRn3XLmCx58aeozNEzGbqznUxMbsdUvCVABOvMSvxy2Xi99R5d/HFEQKy+ElK
         ZS8jVvoCxQ+KAgUI8/sRQ/4B71midAWMZXaDUQ/5sZ76TG+h1weY+eK2jP/tIG5S0qXa
         XqY8HgsjsJ/LLAU8YfUrpGCmlW9Th5DP8Mu+TSlGAToLeS3TsquVGZDP/2QdqFeQks7d
         +kuA==
X-Gm-Message-State: AOJu0YyiUfZmiOURZEtfxtCNQbc3UTbCxgXs3FXRjJ7KRaML6KvNG4Kp
	iZlITynkKuQ/xy6I6QM/vKen9x/ZO4WHVbc7c7zvxTOGGCiC9Vi9x869uFJX9q0iPIJdgU2iFDh
	MNZaCVu7uRFSRZ5tGy8i/4mL6MgHLCFg1QLRX6rzlmvQf9VR0hv29TE0EbVPloiZ0pHY1PA==
X-Gm-Gg: AeBDiet+PozjDli6RKoqRKVxeWZDtXW9X4B+sS0RVhUaDpBUvjd1IIv8ZLd7IJesgd8
	TTByyUj71WtXz3b0ELSYFIJfbNnZAigbKhSeyi89+/pIrRdlP5nKIk1dzPqmcGWLsSsxVGTgckV
	4AGyK/IA051Ho2/388q4uktj3iwphMDsW47fLbnoa7cYWeUdTxYPUqT6oyUrY0rk5uhhkL+rpoT
	p6/OM5zUQS2b+NLMRuompXfoQ3f3EBaGDpwob2WQZbitXD25paOImtKQcCRU31rQMV7K1ArXVeX
	4UfYIbMDAoHOjZxyRlxHsn6rmfONmNG/wxvHbGGHdhxX/JCfdO3y+YgDrOcYkFqdW4c5BQVxzXw
	LsBK3c5pgwiGsqa9WOQHSHhe+vppugb3RzOZpElh8UPLq1CgTz0ITJXiXK0BlqfyADb7gkzjY
X-Received: by 2002:a17:90b:3c52:b0:35f:c5b8:ef6d with SMTP id 98e67ed59e1d1-3613ffce905mr12961650a91.3.1776749406617;
        Mon, 20 Apr 2026 22:30:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3c52:b0:35f:c5b8:ef6d with SMTP id 98e67ed59e1d1-3613ffce905mr12961616a91.3.1776749406107;
        Mon, 20 Apr 2026 22:30:06 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bafa9sm12235201a91.15.2026.04.20.22.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 22:30:05 -0700 (PDT)
Message-ID: <1ab8b8bf-054a-495a-9b64-e5dc870fc602@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 11:00:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix OF node refcount imbalance in
 WSI graph traversal
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ig2WoS0xdikE0l-E6NU3W9DrMsSt2h0h
X-Proofpoint-GUID: ig2WoS0xdikE0l-E6NU3W9DrMsSt2h0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA1MSBTYWx0ZWRfX7c8T/utcToUz
 dM1gsdOkYNfeQSa5dNR4X1f2ppl5XVP8ZCecsqsP9UnHXbvfKtZDD0mKabLRFNmbqQIovG1ZG5q
 1wadReF3r8eyz5tzswXQPMnoWB/DAikfu0BfgpgNEKDO1po1IaMZuNdi5dZ+kOZR249VYJF1Fw1
 SqUC3x7dkMJLFq6aDo8KNgY2clwJMM16qCyQe81KAsQU4V6BRdnV08WUs1ZdcPGI1QHgXPaHbOs
 oCVFvuqQuTlFvZpoCZWMHzM0chEjoMmCmhDSVL46sIozRuZ8+v8ZhoqyCx6eV8TRjN0JBSdsoDD
 MRkao6U2G44uiFp7bjkTUDPP7tNYRaiys/MphFR2Nzh2uUzXojRzMnj3k1d0gCk+uNBFGD6Ux3j
 v54U41LCLzb+7nhR4iRwAt43OnznkPOENAQXLQVQmQCSH1U8PoJFOJVhckHFYMVKNG+ayB7DT9g
 gtxTFdCq2QDBF6c8Piw==
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=69e70b5f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dnFkAXji-rmhat8NvRMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210051
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,0.0.0.0:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35115-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB0494367E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/2026 12:43 PM, Aaradhana Sahu wrote:
> ath12k_core_get_wsi_info() traverses the WSI (Wired Serial Interface)
> device graph starting from dev->of_node. The current code uses
> dev->of_node directly as the local traversal pointer and calls
> of_node_put() on error.
> 
> Since the driver does not own a reference to dev->of_node, dropping it
> during traversal results in the following OF refcount underflow:
> 
> OF: ERROR: of_node_release() detected bad of_node_put() on /soc@0/wifi@c000000
> CPU: 1 UID: 0 PID: 210 Comm: insmod Not tainted 6.19.0-rc4-next-20260109-00023-g797dd36dc178 #26 PREEMPT
> Hardware name: Qualcomm Technologies, Inc. IPQ5332 MI01.2 (DT)
> Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x60/0x80
>   dump_stack+0x18/0x24
>   of_node_release+0x164/0x1a0
>   kobject_put+0xb4/0x278
>   of_node_put+0x18/0x28
>   ath12k_core_init+0x29c/0x5d4 [ath12k]
>   ath12k_ahb_probe+0x950/0xc14 [ath12k]
>   platform_probe+0x5c/0xa4
>   really_probe+0xc0/0x3ec
>   __driver_probe_device+0x80/0x170
>   driver_probe_device+0x3c/0x120
>   __driver_attach+0xc4/0x218
> OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
> 
> Fix this by explicitly acquiring a reference to the starting node
> using of_node_get() and attaching automatic cleanup via
> __free(device_node).
> 
> Each discovered WSI node is stored in ag->wsi_node[] with its own
> of_node_get() reference. These references are later released in
> ath12k_core_free_wsi_info() during driver teardown.
> 
> Also remove unnecessary memset() of wsi_node array since cleanup now
> explicitly sets pointers to NULL.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 908c10c860e0 ("wifi: ath12k: parse multiple device information from Device Tree")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

