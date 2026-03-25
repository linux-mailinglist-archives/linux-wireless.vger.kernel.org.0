Return-Path: <linux-wireless+bounces-33797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBFVHMVMw2nkpwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:47:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCC31ED45
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E1F303D330
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 02:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D079CD;
	Wed, 25 Mar 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqbUH/dw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsLbATXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16885F4F1
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406778; cv=none; b=mu1gLjKN2jNYFIJKjGWCr3o1Pm1Wa8ojiFN1y/OngBPc0XIhaeYvxVUWVSPr+79qnPaBUXRsYEyPm2cilw8tGmq4P4idXUI4aMREc407+357UATtIma6boP3X6Kl/sB2ZH1vCipIneF8Mt56OC56ef8RgoY8kBkIv86V05tqmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406778; c=relaxed/simple;
	bh=qglSYroY6FEBxllKEfCwyhaljdVayaBbkfbn0uZJqks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yu9Mn9LRltrsmTHWMhdQSnRs3IXL26irCqUW00vdmmMnwfFLrBIssm+ukscL96y1mZwuH19ib8TEODTHIQX49jTGg4hyzZ4qp7y9WuRi6CYL4xtCfUL4wRHSTBYtF/5JomVaFCwFz6rWuo0vYOOs87O9l7xGJn/H5A6V7NbrA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqbUH/dw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsLbATXL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJOTc11862315
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 02:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rb5+Zbj5c02Cn5QIhuY6tex032Gf8MbDrfH/+vmC5Mo=; b=aqbUH/dwNeasW8yW
	4okNacoj1e2m+gnzjSWndU8nL42S/li3SY67OgaCwVH6oqzjQpw/He/oL4S6zvx7
	cgP3TsgMo1Rq1y2dgOpWgwY17y3Y6/Tlct/aq6gxf8r4u2sx77l8UHiTDkLFX3yE
	OiLGXGCMwdklnTSec/j3nK8mH45TrkquNsxIMp+a25RTF6kSAdtRgufsA2+HsBrO
	4z2GpBoU4ieU34e12CN8LIZxHG9343pLq+GrQ/X6BoP/EWEy4ZTD2Uj3SLTRLx7Y
	DjYH4Iz2xAQ+xKag2clc3lciSN8G34Okcd680U7I3EeoLqOsOTASa0SW4Df91qB8
	AJAQHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40ras3mb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 02:46:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0b57e192bso978835ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 19:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774406775; x=1775011575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rb5+Zbj5c02Cn5QIhuY6tex032Gf8MbDrfH/+vmC5Mo=;
        b=OsLbATXLriszZhcE+cYtnOxJhkt2qQY5lJCk8J3zcFFx3YVTTPQagUPhI4ay2WyQ26
         5HlMt/2wiDJpGH1fzVF+tBWbC4Pv1pVgo7SbjVCFxdPDmhSDRxHT8KC96jq0Gkn0RHwe
         nUkRDtcpj20nPaqbxS6tD6KmfFLjK0rKfq73VjUgWb/0cwUlcxzaHw+m/xzZQmePdAbJ
         bekDAet2EI9fQerGGv/Y5tES8GQRqnDzyoZ+Bfb2HFJGsSvRYKuCRtXvi7Izx+MaEW1I
         ib84mfawwLI31mgc4O90FN/pcY2lw7yb0V2JWsSWk+ese6u7wLMXCL5LZbMpxwVxYGRy
         besg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774406775; x=1775011575;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rb5+Zbj5c02Cn5QIhuY6tex032Gf8MbDrfH/+vmC5Mo=;
        b=OV6aDdJSIaw6K9z8XTdXRn2MZS3A6+oP2IimxiLVYpCQPM+PgNl5Oxbf7Gg88EMJrz
         eQehLAmzzUZQEJ4Ytx1zLh9ET2A6pLLF/TduMU3m0oTzm1mCTxQqJAwy7fa2/hxxCsSw
         Bcnc980B2rwXbr08G77JSEEtlErn58Rxk6wJj01acOMTlZniU48TB/qfm4xgYQnKRnHI
         rS+yTYydvHfUwy/oAco1Fe1jSVTjbpDqoDDui+mSRl/WesjRJcnUZ8hSig4WPXJ1LWVD
         O+djDMdHPfDllLEqBvoXSBgJW9aTwUn3AlazV/kJdniyfZ3xQLA8flTAsAh3HvTiT38n
         0nlg==
X-Forwarded-Encrypted: i=1; AJvYcCWFef/B88udlJa7IljFQqAY4CBm/2XDKh9eZBvcZi+MOYOZTnbTKwQq7kiDp7VCyk29vthvYD2RSwijNpgWpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymkI/fSA8DsScjFJx9LulJyLK6gl3wTVIChPUmWaC4IbT7bfsV
	jud3Ow2eTzGCj6sjdhv4oarozZ/6u3LoACYKttBjaQzsbY3wVHR9HmhSZmeomXuV7jH8+92PKcs
	4eqkrR9J06FDsRfYfS05UCCe/INFZJeSf8iIx7NGQokoeOQv6QKmWTqpdw78I+Bj8JQRF/Q==
X-Gm-Gg: ATEYQzwHtuT6FBE4/smueSK0z5+EbPb40X62TRusqqlTM2khDJ4alvnoKi686d5dpYb
	J1OSXVTA0VFL9AP1+zK5KWawM6/ImWZGkmGZv2G4VsdRPULWxYvQkeRf4UpNqywogg/Kwtk/i07
	I1msCGLkvA+CjwLi+vTmzgpDTmA06YWMBOANm2ZX8RXLhb6acGmtD+KiwBCHT/BLB5ph9sJv5ml
	E/h92g0yFgxAt0pWaCPkz8AlFOylgiYLosdvlWe6n/+9rpP1ovxUq5TomDuTKg4jjXD3WSKKNO8
	jRjEZHsQy9Mooa5VBQSqd7J0TZ5xCa7mDq5FcFQPm2QF9y2DyHZ2XxLy2ikXswOfFGxhFn5tGkf
	UosQDGqt1AoDjcd6f5wY/c9hcskun9tkEpZnT6gh/q+JAD/e8X/BDLAqVpfkBE/9Yz67p38pauG
	bBaHqnf4lROj4ZB2WGhx8=
X-Received: by 2002:a17:903:90e:b0:2ae:7efa:c8a7 with SMTP id d9443c01a7336-2b0b0989314mr20954555ad.9.1774406774992;
        Tue, 24 Mar 2026 19:46:14 -0700 (PDT)
X-Received: by 2002:a17:903:90e:b0:2ae:7efa:c8a7 with SMTP id d9443c01a7336-2b0b0989314mr20954275ad.9.1774406774373;
        Tue, 24 Mar 2026 19:46:14 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm205902515ad.60.2026.03.24.19.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 19:46:14 -0700 (PDT)
Message-ID: <1c20551c-2cc3-418d-ad18-3a0bcead8b73@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 10:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: desc_va endianness problem
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ab0Y9v6BkH4HDrFr@FUE-ALEWI-WINX>
 <d0db7062-f428-410d-a704-395d67bd4554@oss.qualcomm.com>
 <acEh4vckyl6bq29l@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <acEh4vckyl6bq29l@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c34c78 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=LFIDOt4Pvek44OkmB0cA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: TO3K7elXJseHpkXURZgDP9QtuO83pNsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxOSBTYWx0ZWRfX43bnT5fcTEGZ
 cUQ7ajO34NmzMrwpX+17rvTbcp6xZ8D0fGaWVL/sdIMb2/sI/l1y4RGPkrY6hRxO3QoBoT34Vfp
 PMvA+daz9AWYyNX1R7Yd6hyDcjcUNYPJKRkXC38AxV6ggXESuASWEUsbSzNgQUl9+gOpjjHWjEl
 XLjoGsgUoej3sKOTk6R5RWXLqSVnMe5YpWE0+eurrPEpDIFd128uTKkveblGnTBd08+lOEaK8lu
 URnFqNud0ToKEuTko6Zd8Y6l1FrzaOoxfqFgzRZ8FT29w1VoOaT1CYAAv0eBCCG2HXiRppfKkp3
 Tp9F2s/lCsD5lciwcelFs5D6GvZbAVncqSbfXUJR/YKIgcYUZpFQhR5D+FP4TuCzklaTm0C8F+w
 0CrjMeLIZaHBr4Pf455JYHSx4M/XNLJtFC9ramK52624rD98VcvbaX/+3ibaVJK9rQCSBEphan8
 wMF74TKw0Uop7XLxS2A==
X-Proofpoint-GUID: TO3K7elXJseHpkXURZgDP9QtuO83pNsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250019
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
	TAGGED_FROM(0.00)[bounces-33797-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,root:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C5CCC31ED45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/2026 7:20 PM, Alexander Wilhelm wrote:
> On Mon, Mar 23, 2026 at 05:31:03PM +0800, Baochen Qiang wrote:
>>
>>
>> On 3/20/2026 5:52 PM, Alexander Wilhelm wrote:
>>> Hello ath12k developers,
>>>
>>> I have another fix for the big endian platform, but unfortunately the data types
>>> do not match here, so I need your support. The problem is the following: the
>>> structs `hal_reo_dest_ring`, `hal_wbm_completion_ring`, and
>>> `hal_wbm_release_ring_cc_rx` all define the members `buf_va_lo` and `buf_va_hi`
>>> as `__le32`. At first glance this seems correct, because the entire structure
>>> contains only little endian fields. The local variable `desc_va` in each
>>> function (see patch below) is of type `u64`, so it makes sense that I would need
>>> to convert from little endian to CPU endian. Unfortunately, this leads to the
>>> following crashes, in `tx_completion` and `rx_process_wbm`, respectivally:
>>>
>>>
>>>     Kernel attempted to read user page (40dcdf) - exploit attempt? (uid: 0)
>>>     BUG: Unable to handle kernel data access on read at 0x0040dcdf
>>>     Faulting instruction address: 0xe209290c
>>>     Oops: Kernel access of bad area, sig: 11 [#1]
>>>     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
>>>     Modules linked in: ath12k(O) mac80211(O) cfg80211(O) compat(O) ...
>>>     CPU: 1 PID: 10200 Comm: jshn Tainted: G           O       6.6.73 #0
>>>     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
>>>     NIP:  e209290c LR: e2092854 CTR: c08d3190
>>>     REGS: dffe3d40 TRAP: 0300   Tainted: G           O        (6.6.73)
>>>     MSR:  00029002 <CE,EE,ME>  CR: 44004804  XER: 00000000
>>>     DEAR: 0040dcdf ESR: 00000000 
>>>     GPR00: e2092854 dffe3e30 c328a500 e2092854 0040dcce 00000008 00070000 cf900000 
>>>     GPR08: 00000000 cf900004 40000000 c8e52c4c c08d3190 1002801c 0fcf5000 c0ab85f8 
>>>     GPR16: d0d1f7a0 c12a9080 00000001 df7b7f80 00000003 cf900000 e1bc0000 e1ccb988 
>>>     GPR24: ffffffff c8ed0000 e1cc0220 00000000 c8ec0000 c8ec0000 c8ec0f50 c8ec0000 
>>>     NIP [e209290c] ath12k_dp_tx_completion_handler+0x22c/0x720 [ath12k]
>>>     LR [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k]
>>>     Call Trace:
>>>     [dffe3e30] [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k] (unreliable)
>>>     [dffe3e80] [e208fe18] ath12k_dp_service_srng+0x58/0x380 [ath12k]
>>>     [dffe3ed0] [e20a1490] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
>>>     [dffe3f00] [c067404c] __napi_poll+0x4c/0x260
>>>     [dffe3f30] [c06746f8] net_rx_action+0x188/0x340
>>>     [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
>>>     [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
>>>     [d0f2fb70] [00000000] 0x0
>>>     [d0f2fb90] [c003a7d0] irq_exit+0x70/0xa0
>>>     [d0f2fba0] [c0000c84] ExternalInput+0x144/0x160
>>>     --- interrupt: 500 at percpu_counter_add_batch+0x9c/0x150
>>>     NIP:  c0425e8c LR: c01a5964 CTR: c01764e0
>>>     REGS: d0f2fbb0 TRAP: 0500   Tainted: G           O        (6.6.73)
>>>     MSR:  00029002 <CE,EE,ME>  CR: 48008802  XER: 20000000
>>>
>>>     GPR00: c01a5a00 d0f2fca0 c328a500 c1db7300 dffc0f20 00000000 fffffffc 00021002 
>>>     GPR08: 1e763000 e1091054 00000007 c12b0530 88002808 1002801c 0fcf5000 c0ab85f8 
>>>     GPR16: d0d1f7a0 dffc0f20 00000000 000003fe 00000000 f92412bd 00000003 c9525480 
>>>     GPR24: d0f2fd74 c8a501f8 c12b0530 00029002 00000007 00000000 0000000b c1db7300 
>>>     NIP [c0425e8c] percpu_counter_add_batch+0x9c/0x150
>>>     LR [c01a5964] unmap_page_range+0x484/0x820
>>>     --- interrupt: 500
>>>     [d0f2fca0] [00000001] 0x1 (unreliable)
>>>     [d0f2fcd0] [c01a5a00] unmap_page_range+0x520/0x820
>>>     [d0f2fd60] [c01a5d9c] unmap_vmas+0x9c/0xe0
>>>     [d0f2fda0] [c01afef4] exit_mmap+0xb4/0x2a0
>>>     [d0f2fe40] [c0031610] mmput+0x40/0x140
>>>     [d0f2fe60] [c0038df4] do_exit+0x2b4/0x990
>>>     [d0f2feb0] [c00396c4] do_group_exit+0x34/0xa0
>>>     [d0f2fed0] [c0039748] sys_exit_group+0x18/0x20
>>>     [d0f2fee0] [c000dbac] system_call_exception+0xac/0x1f0
>>>     [d0f2ff00] [c00110e8] ret_from_syscall+0x0/0x28
>>>     --- interrupt: c00 at 0xfded438
>>>     NIP:  0fded438 LR: 0ff23958 CTR: 0fd94930
>>>     REGS: d0f2ff10 TRAP: 0c00   Tainted: G           O        (6.6.73)
>>>     MSR:  0002f902 <CE,EE,PR,FP,ME>  CR: 28002402  XER: 20000000
>>>
>>>     GPR00: 000000ea bff93390 b0316520 00000000 113e8af0 113e8af0 00000000 00000000 
>>>     GPR08: 00000000 00000000 00000000 ffffffff b02ccb04 1002801c 100a0000 bfbc4260 
>>>     GPR16: 114974b0 00000000 114a4de0 00000000 b02cc900 00000001 00000000 00000001 
>>>     GPR24: 0ff239a0 00000000 00000001 00000000 b030f52c fffff000 0ff23958 00000000 
>>>     NIP [0fded438] 0xfded438
>>>     LR [0ff23958] 0xff23958
>>>     --- interrupt: c00
>>>     Code: 512a421e 2e140000 512a463e 40f20008 555b9f3e 39350004 754a4000 7c804c2c 41c20224 7c87442c 2c040000 41c20230 <88a40011> 7fc3f378 83a40008 8a640010
>>>     ---[ end trace 0000000000000000 ]---
>>>
>>>     Kernel panic - not syncing: Fatal exception
>>>     ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>
>>>
>>>     user@root:~# Kernel attempted to read user page (c011de) - exploit attempt? (uid: 0)
>>>     BUG: Unable to handle kernel data access on read at 0x00c011de
>>>     Faulting instruction address: 0xe1e3dc44
>>>     Oops: Kernel access of bad area, sig: 11 [#1]
>>>     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
>>>     Modules linked in: ...
>>>     CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O       6.6.73 #0
>>>     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
>>>     NIP:  e1e3dc44 LR: e1e3dc30 CTR: c08d40e0
>>>     REGS: dffe3ce0 TRAP: 0300   Tainted: G           O        (6.6.73)
>>>     MSR:  00029002 <CE,EE,ME>  CR: 44004402  XER: 00000000
>>>     DEAR: 00c011de ESR: 00000000 
>>>     GPR00: e1e33154 dffe3dd0 c1870000 00000000 cebe0000 00000000 00000000 00c011ce 
>>>     GPR08: 00000001 00000000 00020000 c30a294c c08d40e0 00000000 00000001 00000000 
>>>     GPR16: e1ce2668 c9270000 c9269a18 c92664d0 e1ce26dc 00000000 babababa dffe3df4 
>>>     GPR24: 00000040 00000000 c9266480 dffe3dec dffe3e04 c9260000 00c011ce c9269a18 
>>>     NIP [e1e3dc44] ath12k_dp_rx_process_wbm_err+0x124/0x600 [ath12k]
>>>     LR [e1e3dc30] ath12k_dp_rx_process_wbm_err+0x110/0x600 [ath12k]
>>>     Call Trace:
>>>     [dffe3dd0] [c0ab8e30] 0xc0ab8e30 (unreliable)
>>>     [dffe3e80] [e1e33154] ath12k_dp_service_srng+0x314/0x380 [ath12k]
>>>     [dffe3ed0] [e1e44540] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
>>>     [dffe3f00] [c0674c7c] __napi_poll+0x4c/0x260
>>>     [dffe3f30] [c0675328] net_rx_action+0x188/0x340
>>>     [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
>>>     [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
>>>     [c18c7e10] [c12b040c] 0xc12b040c
>>>     [c18c7e30] [c003a7d0] irq_exit+0x70/0xa0
>>>     [c18c7e40] [c0000c84] ExternalInput+0x144/0x160
>>>     --- interrupt: 500 at arch_cpu_idle+0x24/0x50
>>>     NIP:  c00071f4 LR: c00071f4 CTR: c000fe14
>>>     REGS: c18c7e50 TRAP: 0500   Tainted: G           O        (6.6.73)
>>>     MSR:  0002b002 <CE,EE,FP,ME>  CR: 84000402  XER: 00000000
>>>
>>>     GPR00: c08cc978 c18c7f40 c1870000 00000005 00000001 40000000 c328becc c12b0530 
>>>     GPR08: c12b0530 c000fe14 0098ca91 00154674 24000402 00000000 00000001 00000000 
>>>     GPR16: 00000000 00000000 c00119a0 dffee5f0 00000001 00000000 ffffffff c1050254 
>>>     GPR24: c12c0000 c0011970 c0011940 c12d0000 00000004 c12b040c c12b0000 00000001 
>>>     NIP [c00071f4] arch_cpu_idle+0x24/0x50
>>>     LR [c00071f4] arch_cpu_idle+0x24/0x50
>>>     --- interrupt: 500
>>>     [c18c7f40] [c0a367e0] 0xc0a367e0 (unreliable)
>>>     [c18c7f50] [c08cc978] default_idle_call+0x38/0x58
>>>     [c18c7f60] [c007b3b0] do_idle+0xf0/0x130
>>>     [c18c7f80] [c007b580] cpu_startup_entry+0x30/0x40
>>>     [c18c7fa0] [c001325c] start_secondary+0x48c/0x930
>>>     [c18c7ff0] [c0002870] __secondary_start+0x90/0xdc
>>>     Code: 7fa3eb78 4bfcba59 7c641b79 41c20144 38a10044 7fa3eb78 4bfcdb85 7c651b79 40c2026c 83c10058 2c1e0000 41c202d0 <813e0010> 7c09b000 41c20010 7e84a378
>>>     ---[ end trace 0000000000000000 ]---
>>>
>>>     Kernel panic - not syncing: Fatal exception
>>>     ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>
>>>
>>> My fix, as shown in the patch below, is to remove the conversion. But then the
>>> member variables `buf_va_lo` and `buf_va_hi` must be `u32`, which is obviously
>>> wrong. Alternatively, `desc_va` must be `__le64`, but that is likely also
>>> incorrect, because the address is simply dereferenced, and this clearly requires
>>> CPU endianness. What I also do not fully understand is who actually fills these
>>> addresses and at which stage this happens. I hope you can help clarify this so
>>> that I can provide a correct patch for this issue afterward.
>>>
>>>
>>
>> hmm, i am not sure here, but can you please try
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
>> index 1c82d927d27b..f142759a217b 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp.c
>> @@ -1246,7 +1246,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
>>
>>                         /* Update descriptor VA in SPT */
>>                         rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
>> -                       *rx_desc_addr = &rx_descs[j];
>> +                       *rx_desc_addr = (struct ath12k_rx_desc_info
>> *)cpu_to_le64(&rx_descs[j]);
>>                 }
>>         }
>>
>> @@ -1286,7 +1286,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
>>                                 /* Update descriptor VA in SPT */
>>                                 tx_desc_addr =
>>                                         ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
>> -                               *tx_desc_addr = &tx_descs[j];
>> +                               *tx_desc_addr = (struct ath12k_tx_desc_info
>> *)cpu_to_le64(&tx_descs[j]);
>>                         }
>>                 }
>>                 spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
>>
> 
> Hi Baochen,
> 
> It actually worked, although the solution isn't entirely clean. Sparse
> consequently complains with:
> 
>     dp.c:1249:42: warning: cast from restricted __le64
>     dp.c:1289:50: warning: cast from restricted __le64
> 
> To be honest, I also don't quite understand why the struct pointer has to be in
> little endian at this point. The function `ath12k_dp_cc_get_desc_addr_ptr`
> returns an offset from the `vaddr` inside the `spt_info` struct, stored as a
> `u64`. But dereferencing it suddenly treats it as little endian. Shouldn't
> `vaddr` itself perhaps be a `__le64`?

that piece of memory is for direct access by the target, so yes I think 'vaddr' should be
defined as __le64.

> 
> 
> Best regards
> Alexander Wilhelm


