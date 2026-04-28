Return-Path: <linux-wireless+bounces-35436-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jzrUEHch8GlhOwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35436-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:54:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A938547CF12
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 923CD300E27A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4C1DF25C;
	Tue, 28 Apr 2026 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oIy/OFMX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUxbMKp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D78287E
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344884; cv=none; b=um40IGsSqMTVG18KxBi8yD1HQLN5vT8UiajOglmGYUpL4UZQ3S0hBAZTI5lFs+NiY9ZieRQJR/uoE9ai1ntPtOW1O++8Ev+7jtEYjU+y4IUq+DHib8cYhQwB6ZVu5Fph84TO5CCb6cQU0zzJrLc6dhRYS2iaIl4cUvYoDW0mxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344884; c=relaxed/simple;
	bh=U4C0B60FehZyLl0SZL4PHou6gxw1btf88o6uszB/XNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhLAlCkc+NWKjXx5sBbrr/dz9Mf9Jmxeo84cKIGJxXH/k5tQ3Rgg1eudEjWpX5HeGTAqXdbHWxWiXalPnkRTlO/Yx9bGLLqa7JoWnkUzI7Jj1xGZLgW73ViE2uTzGRw4DJ6SLPW+IIVky9YUq1fV6iJtpHLondJn6fx4/Cv7g0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oIy/OFMX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UUxbMKp5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RMJJMI2913944
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dCrRRzdOxR7F+nlwBIfEECPWvo0hTjDusmQKaUluhuo=; b=oIy/OFMXI7wxLNCF
	Zdb4QTxTUuzaT+KMpmAaR4vqq/PwippWO98w5vbUAqHPn9lxNfu2f3yHpWeTpx61
	kxyWwnn3iIH2tzgZaR+tTF2kw7UDpEDAjTS1kNXNhQat7SkXEhe9NhAvbEs/F+0/
	LRu3L2iqozFpq5Cl2fcCzI3RMpxeckv6K6+PUQv2qPIYfPO7g76kc2VJDULJJubb
	NisBVpjwYwwGZOPXqbdvQ6ZtbpGPpgMVXJG3TO2Hi9eZkG4vPws2rq90UMFl+z/b
	ttuc+CzymFyRK3a1WY2asXjBnEuX/dDmvKHQ8WIYDaQp0o4aJMy37WJqxxVSHHfH
	Eq9sCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xme7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:54:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d83e7461so186433935ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777344881; x=1777949681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCrRRzdOxR7F+nlwBIfEECPWvo0hTjDusmQKaUluhuo=;
        b=UUxbMKp5yuLpECY7S/uEkRcSwdp+5QB8veyO+joHfXcqBSJaW+Uz+bzmNTOAVWBWfi
         FOi/2N3fqxkU7e2NuTtdCsHdknxcqhL/IsTC5EMg7sL/4mzwV5JovVRf943wAgGRE2pY
         w8xUpsArdOVu3IX30fuCoOJY7f8Pzckn7hl/RcbFt1tnPoljh3RerIH2mfVh7jOuhL7g
         wgRpgxxhIf0m5wCTcol0f+iflBFEngv+Xj1asQ+ewgTvrLCSB3mNeD3pBO86fGrJM6Zt
         YCndOpFdCMseMk/G6xlWkg1yjnFDyVy17GuErf3suSW1vT6Ww6L9mZHXhOAbQDu5RbYs
         AKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344881; x=1777949681;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCrRRzdOxR7F+nlwBIfEECPWvo0hTjDusmQKaUluhuo=;
        b=HLJGlpf/NKY3KXg/F54i37lzLXlGGAga+1DZ143V9cqMlkL0cMoKKRfZXc59CHnAAN
         JIAwx/ojrKSdzVu++2mCOfmnCpMzhfwWYKyhPllR8kC3+fLSUGQKarHBvYduwiVi98mO
         8yUSJX3GFXU97TXAC2Ifu9ig8ixhKWI25G3MEIRIqtcwfkH5AVrDwF6HFIBYrj35OBxH
         IxFQaG6rw4k6EsBcz9z+eJGgJAEMjzfi7KUcRLXgjRVbIJtv28K01s9qrJE4Yuoqt4Iz
         Cm5NLiLU4DX0LFlxj5wzSUjBXikJYitNzG2yS6+GAxJQGHIQVo6gsf9m0WVzmL5l+kck
         0InA==
X-Gm-Message-State: AOJu0YwwAo0S8gtOlMpXmf+uqjyv9XZeCfWFNqXlx5hsHqk7m1Cj3QB8
	Qi865sz2n+rqsL57SMd75fngSbByp8EmQE2896mdqOn4avNj7u+5EdG2YYi2J929xo+zmWqTfn1
	7r348deEJjwzkvFd/ZoNCNMs5GjFNSSrslDJgFCN7GnRQbFxS7WyDOy/ZZlhbGNgZQPjWog==
X-Gm-Gg: AeBDievxm1KW1m22kiML1hUo6qFB/gTvrbfvNZj6mckmIbweROG9yuwagp4p4uY9e+e
	XcubRNFiJeVvnn8yhJYZCjIlMFHB3001c5bbeYMpA6NIzboD7PccIiplPNHhMIDsiaf7OzWB4W9
	4AwCHunRKx30to21YDyREvjCvnp+r4V6lB3HXJnbKTXr+ItWPLOALajMMzQAX5+4lE0y4zmZO9V
	vP6j2f2QZ8uSGEE8S5KHH+snGUL/C6jHOClDt2G6EKpwnp/W0JtbWBeXk/+CWRmiUfFfjJEn1ap
	lxOBwW1rnrYvsO0JK9LGBsyVo2WlwruWjelu8THrkQNQrTFA7cxprOKjDqXtI6qDb3dBJG7DrUK
	RvvTiFfD44S+idhd3bAvw84p5zswP6VVROHtrT/lATExcmmJCdhVJIWpTUpbNXUnDh8Xx/VabPc
	fsqxFe9th32ye+DIDZIOYDvqJiIJnZSQ==
X-Received: by 2002:a17:902:b591:b0:2b4:5d51:ce96 with SMTP id d9443c01a7336-2b97c4aa50dmr8598265ad.24.1777344880871;
        Mon, 27 Apr 2026 19:54:40 -0700 (PDT)
X-Received: by 2002:a17:902:b591:b0:2b4:5d51:ce96 with SMTP id d9443c01a7336-2b97c4aa50dmr8598145ad.24.1777344880408;
        Mon, 27 Apr 2026 19:54:40 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac78792sm8566795ad.41.2026.04.27.19.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:54:40 -0700 (PDT)
Message-ID: <759ba445-c7a9-4f72-8128-6be62320e465@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:54:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: initialize RSSI dBm conversion
 event state
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260427103011.2983269-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260427103011.2983269-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7qnYcNuHoP7IHCqdWP-ABG1_gBuRHTZl
X-Proofpoint-ORIG-GUID: 7qnYcNuHoP7IHCqdWP-ABG1_gBuRHTZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyNSBTYWx0ZWRfX5QMYo87MFTct
 RixVfKC6hDVt8RvV3hD/QFp/z5SgRxkKHnoPLoe8F0szm85kiRBYXbkWIsjSLnTDlV2q3P6ijeC
 DrvofNLVvLYB1DaEvcog5qRH9KXO4BEWfIfPDb2WHFxPdYYmy4QDWcxKOKmBWwm4VnJe1hwERcD
 RsmnMyUM1OCo7PfbPJkPFZ6byhVKtkoSSNalCsGjAiSwDSsigvEiLEHqyjm41HVhLVVWQBeBgVZ
 s5Rg9PMFAyvlweAVyJmzGE6F3TUT4cIrSB0ssMPvlB6lD6PjiJXLVF+LKw9jtlUg82oR4dlajaQ
 i+LkpvOsTHHjljoz6UT6nxdwOShG5EKlfypKUkrDasji8OUI9xV8b7KedDsqwHBlg/xh3t1I+q+
 0o8qB+6AZtOM90i0/sLSgEaaPwjlbBRIEWnr2MsFWZF6xgV51uKxbsqjGj6Hh7NlV6KAqP/mw6t
 2TYGrc/WdxMnc7qko0Q==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69f02172 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_dLuOwf2joCYYqwKFIgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280025
X-Rspamd-Queue-Id: A938547CF12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35436-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/27/2026 6:30 PM, Rameshkumar Sundaram wrote:
> Currently, the RSSI dBm conversion event handler leaves struct
> ath12k_wmi_rssi_dbm_conv_info_arg uninitialized on the stack before
> calling the TLV parser. If one of the optional sub-TLVs is absent, the
> corresponding *_present flag retains stack garbage and later gets read
> in ath12k_wmi_update_rssi_offsets(). With UBSAN enabled this triggers an
> invalid-load report for _Bool:
> 
> UBSAN: invalid-load in drivers/net/wireless/ath/ath12k/wmi.c:9682:15
> load of value 9 is not a valid value for type '_Bool'
> Call Trace:
>  ath12k_wmi_rssi_dbm_conversion_params_info_event.cold+0x72/0x85 [ath12k]
>  ath12k_wmi_op_rx+0x1871/0x2ab0 [ath12k]
>  ath12k_htc_rx_completion_handler+0x44b/0x810 [ath12k]
>  ath12k_ce_recv_process_cb+0x554/0x9f0 [ath12k]
>  ath12k_ce_per_engine_service+0xbe/0xf0 [ath12k]
>  ath12k_pci_ce_workqueue+0x69/0x120 [ath12k]
> 
> Initialize the parsed event state to zero before passing it to the TLV
> parser so missing sub-TLVs correctly leave the presence flags false.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 0314ee81a91d ("wifi: ath12k: handle WMI event for real noise floor calculation")
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


