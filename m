Return-Path: <linux-wireless+bounces-34485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNFsNbMw1WmU2AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:28:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523283B1D86
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C5A30668B4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CE3BAD9B;
	Tue,  7 Apr 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3SC89L8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vf0IEm9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2273BE17B
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578964; cv=none; b=O+iqznSFjg3/T0oXgfC5GeBTmVsKdk8ZkW7Wt+0HMs8IZYCipbKVsTrv9x55sOva5khe6PpH8iIe7B/jGBaznNnuho3HkJ/WQG9mgPx181kHsQzVfxA4VVeu6B3929JOTTQGY1fX2tr2CXkme08OfqEy3ko+uitJ9lQ2Ux6V07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578964; c=relaxed/simple;
	bh=l6PqMC1tU/9FWgFi0iJnydwoLsoUrMMaIPF5BVWrc+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA2ppW21M6xSmfbskP91cRov11KUEmw+ZNLLJa0JE997R7Wx8W1AbDJ60on6yIWu4mu/vVdhgD0b/ZJPUPPN3bOCd5Mrk8UMsAUJlKfpbZuYPM1Kyk5dmwWvs6CqbODyPYM9lmcgqUYVKYbvcWx5FsZb61tHAxc9CNFwP1dvMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3SC89L8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vf0IEm9C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637COjOf3816869
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 16:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pVFqvNNdVvKctQ9L5qqutBnT5udGV6zQ0WX7R1ghubQ=; b=O3SC89L8Ht9aX3xu
	ZzGAqfWGA+PVzi5JavzPUSBxxQDINmlY9UYFiYpgku2qpREcCXD/5NjWOMGA9SYk
	sBn16yWi7FrX7tXRtF0oSnqh0MrjHWblxYL8oaqFBlujb9lafBmNVL7c4+Ul2zgD
	r0wcB35EKQ9Prdick7KdGA/K8CEvqnOLqRprGMESZJFk66hQ/wabIS2PXobyJQ+b
	4RkLYBfWLb/eX9YdYujdrwekGyrOhML+yJergbfA1Ek7GDFTD+eM9Pjo/I9gSZWv
	CHrLbz/sL3Ut0+IX/KONE1qjLoKlwRc5d3fU+pXdH/rlzxBjW8QMOFQ8SVvQcocG
	ZslnJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4um9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 16:22:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0c30b51bfso112477695ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775578959; x=1776183759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVFqvNNdVvKctQ9L5qqutBnT5udGV6zQ0WX7R1ghubQ=;
        b=Vf0IEm9CNVbidNBSEj7LtUYG46hbLi3NS5twGP/8u4Kt6ciayIxFvW8orV1rBgJNyp
         C7MLkRzREkIg8IikfOiQY1Q3gA4b2cGNFSiK9JusIOY/xCEI9ocrcHE65Dl6Zj/rcAqR
         ImUpTEufNqbawp4Tnqa2/m+S2kMw3Z8D0/loQzOJBC5GwxR97Avd1F3F3QqM7e6WDwXg
         m9N67KbNkB4err0RSjkrE68TSAnyHvugzjhJj3Zkts9Wcm5Stw6oZymXMi9HAXM0PzvA
         ki0G+CO++8OEwenPduzY6psxqJ/JOwpsoDg7Op/w4fcJXgSy9Emj/JOCiyqfo/s1DJtb
         WbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578959; x=1776183759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVFqvNNdVvKctQ9L5qqutBnT5udGV6zQ0WX7R1ghubQ=;
        b=dKSwHQoqj3fBBp18pQhoBHRADbROW3syuessRXwg/IxgP4N2RPaag7FVdeivew09tU
         O5gw39N2WTzasGMA2ASSs+LFgpMud+i0iQsMU9xwlAVBuj98fTJ1GgrBJuRCFjMyFOIf
         uhXq+VZOUGcojlnI00v/Z3P2E8e96tYayj59dC1gKkYMZbTD5dLYAZewCY7NsOVJFBbC
         EONfpmctjdxtShqAed/OgCJsCha3VcENJiQMXK53AzY/4OcQyxLi3O+3lvYITyy0vriw
         DnZY6ZJJdtpZWUpsjWZuqi0AGoqQfR3xn4+3x+0eJ15LSJOVPigTQfYCRSlAK48HwEvb
         U/Rw==
X-Gm-Message-State: AOJu0YzBCTRURklI3QN7xSqLo50wZX6xJDz0IbzMVBUZyxpf5RwA4uAW
	PBiYfTqlPk5Zbn40TizrMYBtyD/p29Zl8saK0mgLMi8AuqursZcjriB5UHiRseV7wRUnaGI4rqx
	AcOMT30GWkvAVT+OOFmcs//4QDKcPdApPEphJlNS4AGJJYCwEzOJGMHmtZSl7p41tnQFR3w==
X-Gm-Gg: AeBDies3zVlGo6O8Oe3fp7fiX/4VrSEHRB/gQNAN3eI1mzfc5sHqnqaRiOoi885d95M
	VSw17r38M7YI7PuXdzL5I+u9hpELMbaI27nWSMJxBQfxZxZnkwvEWyVffGiV3Ah8R/raTQXTXhf
	QAWjK9MlGG/X24VRKTpYFmvAWMtP4sO7l9D0DH2OHd/xPVIrsmCubTghICbPZALAicueQs5bVL4
	6hINyWwZ/n2eiDIl+DDBtHv+TAuM2I3vXTogwIULE3kHuchZGYYvIB3rWSkL1f57RIPnttEsqcE
	aDW5A/CIz/dxEK3RmeI9BJ6CcnAOLuTm22dEpl6kaSByqK0E+4tm75aDfnOe2C3XCyij3HqRKwb
	+KbFYlUc+pM1bhtk9m+o2MssrGvnE2Zo/SMVuHD+f+7WrodwFtQdA2tJitgKwuOvykQ==
X-Received: by 2002:a17:902:c409:b0:2b2:4f43:b498 with SMTP id d9443c01a7336-2b2817361bdmr198081485ad.13.1775578959161;
        Tue, 07 Apr 2026 09:22:39 -0700 (PDT)
X-Received: by 2002:a17:902:c409:b0:2b2:4f43:b498 with SMTP id d9443c01a7336-2b2817361bdmr198080935ad.13.1775578958289;
        Tue, 07 Apr 2026 09:22:38 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af31sm172747805ad.52.2026.04.07.09.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 09:22:37 -0700 (PDT)
Message-ID: <be871892-cb95-4316-bdf4-4609f1c46d0b@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 21:52:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 4/6] wifi: ath12k: add ath12k_hw_regs for
 IPQ5424
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
 <20260407-ath12k-ipq5424-v5-4-8e96aa660ec4@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-4-8e96aa660ec4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d52f50 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PSaGKYAotCzfqHVnBd8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qZOslbRns41TunY61iru3qUGZ9zoMj_V
X-Proofpoint-ORIG-GUID: qZOslbRns41TunY61iru3qUGZ9zoMj_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NyBTYWx0ZWRfX/TUQHh9Fm2oB
 yuWDeq7t4aQi+wo4vNXaZGJ5NMxPEHTekPWKdtr6BYPryyQAglOhb9ERuh+l3wpiQvDLnV0WhWx
 wiQbhioZDZZtWl/whFxT1v+BpJ6rQPqBwhiXyt9yVMrlQOAAIpLUBKZ29TsA9vUu37qRXJtckde
 UsMrj6sxCkRYEfeJFcC8ezCa5m1N5+ZxWgEbZ21yKB4mN/kGkq8sI5CLdPICz+9SS1B+2NAblX6
 sfa53Z1cP1dE/sIsF4usq8+Sbfv2luosFCEP6R1voPPPrBZjnBovaNandfR1gkUI3VZ3ppNKG3k
 z/HGkmhAvvGCcZvnd1ylUtfCYlPQ7RZjBlCwarvrqZpS4UFS1b7I/WKCWgUpecIQEW73p/6YakZ
 0cjJdOfPL0UIeOj6/0OJLyPDR9/l03ykzVHhq5DrSfAxI01CumkVEADcFrgzQzszkLr2qGGQTfv
 SpE5LiLMwLFE/nvv+xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070147
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34485-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,quicinc.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 523283B1D86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 10:56 AM, Raj Kumar Bhagat wrote:
> From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> 
> Add register addresses (ath12k_hw_regs) for ath12k AHB based
> WiFi 7 device IPQ5424.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  2 +-
>   drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
>   .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++++
>   .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
>   4 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
> index c2cc99a83f09..a0a1902fb491 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
> @@ -55,7 +55,7 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
>   		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
>   		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
>   		.hal_params = &ath12k_hw_hal_params_ipq5332,
> -		.hw_regs = NULL,
> +		.hw_regs = &ipq5424_regs,
>   	},
>   };
>   
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
> index 9337225a5253..3d9386198893 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
> @@ -364,6 +364,9 @@
>   #define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
>   #define HAL_IPQ5332_CE_SIZE		0x100000
>   
> +#define HAL_IPQ5424_CE_WFSS_REG_BASE	0x200000
> +#define HAL_IPQ5424_CE_SIZE		0x100000
> +
>   #define HAL_RX_MAX_BA_WINDOW	256
>   
>   #define HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC	(100 * 1000)
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
> index 41c918eb1767..ba9ce1e718e8 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
> @@ -484,6 +484,94 @@ const struct ath12k_hw_regs ipq5332_regs = {
>   		HAL_IPQ5332_CE_WFSS_REG_BASE,
>   };
>   
> +const struct ath12k_hw_regs ipq5424_regs = {
> +	/* SW2TCL(x) R0 ring configuration address */
> +	.tcl1_ring_id = 0x00000918,
> +	.tcl1_ring_misc = 0x00000920,
> +	.tcl1_ring_tp_addr_lsb = 0x0000092c,
> +	.tcl1_ring_tp_addr_msb = 0x00000930,
> +	.tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
> +	.tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
> +	.tcl1_ring_msi1_base_lsb = 0x00000958,
> +	.tcl1_ring_msi1_base_msb = 0x0000095c,
> +	.tcl1_ring_base_lsb = 0x00000910,
> +	.tcl1_ring_base_msb = 0x00000914,
> +	.tcl1_ring_msi1_data = 0x00000960,
> +	.tcl2_ring_base_lsb = 0x00000988,
> +	.tcl_ring_base_lsb = 0x00000b68,
> +
> +	/* TCL STATUS ring address */
> +	.tcl_status_ring_base_lsb = 0x00000d48,
> +
> +	/* REO DEST ring address */
> +	.reo2_ring_base = 0x00000578,
> +	.reo1_misc_ctrl_addr = 0x00000b9c,
> +	.reo1_sw_cookie_cfg0 = 0x0000006c,
> +	.reo1_sw_cookie_cfg1 = 0x00000070,
> +	.reo1_qdesc_lut_base0 = 0x00000074,
> +	.reo1_qdesc_lut_base1 = 0x00000078,
> +	.reo1_ring_base_lsb = 0x00000500,
> +	.reo1_ring_base_msb = 0x00000504,
> +	.reo1_ring_id = 0x00000508,
> +	.reo1_ring_misc = 0x00000510,
> +	.reo1_ring_hp_addr_lsb = 0x00000514,
> +	.reo1_ring_hp_addr_msb = 0x00000518,
> +	.reo1_ring_producer_int_setup = 0x00000524,
> +	.reo1_ring_msi1_base_lsb = 0x00000548,
> +	.reo1_ring_msi1_base_msb = 0x0000054C,
> +	.reo1_ring_msi1_data = 0x00000550,
> +	.reo1_aging_thres_ix0 = 0x00000B28,
> +	.reo1_aging_thres_ix1 = 0x00000B2C,
> +	.reo1_aging_thres_ix2 = 0x00000B30,
> +	.reo1_aging_thres_ix3 = 0x00000B34,
> +
> +	/* REO Exception ring address */
> +	.reo2_sw0_ring_base = 0x000008c0,
> +
> +	/* REO Reinject ring address */
> +	.sw2reo_ring_base = 0x00000320,
> +	.sw2reo1_ring_base = 0x00000398,
> +
> +	/* REO cmd ring address */
> +	.reo_cmd_ring_base = 0x000002A8,
> +
> +	/* REO status ring address */
> +	.reo_status_ring_base = 0x00000aa0,
> +
> +	/* WBM idle link ring address */
> +	.wbm_idle_ring_base_lsb = 0x00000d3c,
> +	.wbm_idle_ring_misc_addr = 0x00000d4c,
> +	.wbm_r0_idle_list_cntl_addr = 0x00000240,
> +	.wbm_r0_idle_list_size_addr = 0x00000244,
> +	.wbm_scattered_ring_base_lsb = 0x00000250,
> +	.wbm_scattered_ring_base_msb = 0x00000254,
> +	.wbm_scattered_desc_head_info_ix0 = 0x00000260,
> +	.wbm_scattered_desc_head_info_ix1	= 0x00000264,
> +	.wbm_scattered_desc_tail_info_ix0 = 0x00000270,
> +	.wbm_scattered_desc_tail_info_ix1 = 0x00000274,
> +	.wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
> +
> +	/* SW2WBM release ring address */
> +	.wbm_sw_release_ring_base_lsb = 0x0000037c,
> +
> +	/* WBM2SW release ring address */
> +	.wbm0_release_ring_base_lsb = 0x00000e08,
> +	.wbm1_release_ring_base_lsb = 0x00000e80,
> +
> +	/* PPE release ring address */
> +	.ppe_rel_ring_base = 0x0000046c,
> +
> +	/* CE address */
> +	.umac_ce0_src_reg_base = 0x00200000 -
> +		HAL_IPQ5424_CE_WFSS_REG_BASE,
> +	.umac_ce0_dest_reg_base = 0x00201000 -
> +		HAL_IPQ5424_CE_WFSS_REG_BASE,
> +	.umac_ce1_src_reg_base = 0x00202000 -
> +		HAL_IPQ5424_CE_WFSS_REG_BASE,
> +	.umac_ce1_dest_reg_base = 0x00203000 -
> +		HAL_IPQ5424_CE_WFSS_REG_BASE,
> +};
> +
>   static inline
>   bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc)
>   {
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
> index 08c0a0469474..03cf3792d523 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
> @@ -17,6 +17,7 @@ extern const struct hal_ops hal_qcn9274_ops;
>   extern const struct ath12k_hw_regs qcn9274_v1_regs;
>   extern const struct ath12k_hw_regs qcn9274_v2_regs;
>   extern const struct ath12k_hw_regs ipq5332_regs;
> +extern const struct ath12k_hw_regs ipq5424_regs;
>   extern const struct ath12k_hal_tcl_to_wbm_rbm_map
>   ath12k_hal_tcl_to_wbm_rbm_map_qcn9274[DP_TCL_NUM_RING_MAX];
>   extern const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274;
> 


Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


