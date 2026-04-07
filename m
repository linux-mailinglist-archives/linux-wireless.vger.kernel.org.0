Return-Path: <linux-wireless+bounces-34486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOu5I9Uw1WmU2AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:29:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BD3B1D9D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93B243025F57
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033A13C457A;
	Tue,  7 Apr 2026 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIIXToDT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3fpakEU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729F3BC676
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579019; cv=none; b=TZL1yAWZhstLyYD5EljTQMtci04AdUBK0qRq4BxOJyVIlOkA8VeC6yceK7NY6YRY0fc+gDRttFmiqIVamLq2txovv7polCemIgtp2pC7UzzY3IDvlQH2GWjUPi4P87O4yHzSsdiS18VuI1A+IwwyXrVkX/ftapDs5gFhnVkIcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579019; c=relaxed/simple;
	bh=L60eVjl+lDg86S6kExry0yJcPktLDMV+jSg+o7VyCTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKtDxqAn2QuuWvIaE3292GXNCWUvJ4yGRoUVcRc9qMFo6pqMHQSiIwlth6r75KSzt3GMO3kidvWc9KfaB+rdVPswLZ+3xAYtAJXHTxaytGIB0g9ZbSVvlPXrMbMZezGsezpNCy4+kWf1toVg4uciH3IpGAZviwsAD7gRNt3yHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIIXToDT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I3fpakEU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DJTBb2550172
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 16:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hkHr1XsREMAC/KqxSvd8f5vKp1/h2jijCG0gdIOkT/U=; b=mIIXToDTXG/SBwgu
	pT4TJOaFqxdm2IT5srDr7iLf0n1O05WyoFrUCtTu4ZOPIHPSqHLVf/iCzHs4AEj4
	S3omEEik9hheiiNW3RTKRwueafQhHVKG8bObtRoYYbz2u8+Z9gZzXAERJLWobRmT
	NCVyyCNaTgrPqZslXQMwOFLR5F1uFH75tOoro4IuhreuEYpUPsD7iR+sJKFZNUdc
	+x0Jl6lz7wsKPFoP0EGoIYrmNVfI9/iXq5VSJl2Ovd0MilusaMJo36feFFRzxU2u
	3Zbyacu/U+KFc0Vs96bx407yDJoCd2SPCZuF5rldOfSyD4aPUA9yBdNwGVH78LdT
	H2tP0g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrebnhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 16:23:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0bf2b3879so137749515ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775579017; x=1776183817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkHr1XsREMAC/KqxSvd8f5vKp1/h2jijCG0gdIOkT/U=;
        b=I3fpakEUlE0uhNi4hNV1qUuSaM8UxgsU9eHjXvznRqGHWYiGeSeBzH5oE1myI6ffUT
         ts2mXUHCkYN8xTrtI7ZStFtLk5PXsmj/KVy1cScP3PU+o2qcMl3nEYpWCXJqEI03/IAN
         4vqQkB/O99hWqW64XlmSIgwwqusxXgzEvLEBtqJnV/B2PGp8tBYNohRkbw2k2DBAVY89
         KLf600rNtA2pNdjCKkTj6Bf8biZh6zRF80SNAjZHiW6JIjh5S9gYvgKj0jkgCnrmJh6T
         nJqTkrdA3AzkoAJd8AtVpKb1G0Kq7e2iN8TvDeQzRJUNc0KT38+MYAqeJkJ0/qLInIQ0
         tYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579017; x=1776183817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkHr1XsREMAC/KqxSvd8f5vKp1/h2jijCG0gdIOkT/U=;
        b=N5IAS1KvHH4EatOP72FEYHVyuKgNgJ84/mD0QByC3u1qkWwLtvQILlgn+syg3MEgfw
         ZQfxLCPAQyYz3Zo/YPhR6RETOmI3dPjxavSFaEqsQUWbGFwypZr9A6vs0FcP9bHVDdoh
         G3unNfskh9fphv+pP8A7Ysn71yfk0g1CVsyw3zhs8bhztg02ftjsztq4I/Ue8qjXaxed
         /NFf5huK7LA5yMF80MhLTe10E3SVl/C9OlBHuxt3GouTYeLY+QNJKZoxTo1qZxVQ7kId
         hw9Tw0NiBV+pMgJRFP2qmNcDSITaG9cNpKwBzHrpfHY3NEeTMlUlvivcVdCxk/k0n/h6
         GRrw==
X-Gm-Message-State: AOJu0YzfRqycAVEK2cucn6yWkxTiEcOsy85O38HOXUpIR8yY2QX0CHWK
	oTQSejpvz0lB5AEVNJ1NiJwFgGlG64NpvUV/fDwMJxs8edxelpZL8rbFFwO/lERvwVDFtIz+Rey
	oQRhV/bKhYgb3fyKoAeCQli8TfmKY938n7QUV/uBB1Kfd4yQ1ntqdtZMFecaLRpgzLIL9Kg==
X-Gm-Gg: AeBDiesY0Rffredd6HZ6WSvS+zWq0jsg4xYZf+U3gwlQYKbPZ8XVLUQM0PypXDjq/BZ
	6Ft2Zn4ChMhvwy7PFQy2EDPWC0GAI5GH1i+zz9AQojNnWsyB18yVpLfEnvj0TWr860Q7iFcP2wi
	01RnAzSRNYOwi5XRicvdGdLzpH7wEIre8qgrLHqvXP5hebIRPq88yaQ35L+E65+FvoHeoFgkwlP
	ozFkUuQT6Evg9segFZItScTsj3kNI/Z7zKnI/1pzczHN7pp79NZjNwt1GcxXC9k/ngFaOs+c4ia
	Ap93R/lTc3OKXiHh4LyzP6fZ7lh0iezApVqN8UmJc/dzoS59WmF+StRHWsfPf8MWwEQLYI0eW3l
	x5hNHNhvn8jN+3s7HnIK7t49Puj9lyZf+fGBReztgqXHMtTMUlEyt5TT3AddbW7cfZA==
X-Received: by 2002:a17:903:40d2:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b281674f1emr185590715ad.10.1775579016594;
        Tue, 07 Apr 2026 09:23:36 -0700 (PDT)
X-Received: by 2002:a17:903:40d2:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b281674f1emr185590295ad.10.1775579016034;
        Tue, 07 Apr 2026 09:23:36 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d20bsm177228155ad.16.2026.04.07.09.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 09:23:35 -0700 (PDT)
Message-ID: <1e2b396a-5722-4c28-a3fd-3195b5155959@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 21:53:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 5/6] wifi: ath12k: Add CE remap hardware
 parameters for IPQ5424
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
 <20260407-ath12k-ipq5424-v5-5-8e96aa660ec4@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-5-8e96aa660ec4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d52f8a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=K0dzcbKyB1xs89kN7v0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aD1G-0rLS3D4W8p2wmCo8GupilBrX30c
X-Proofpoint-ORIG-GUID: aD1G-0rLS3D4W8p2wmCo8GupilBrX30c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NyBTYWx0ZWRfX5jK05p16RM5U
 SvWX5eA7wpLVmk0/SovjjuHOL47+f5iloRxOe03qaJnFdTM8Rpyu9aoaEz+zfmHlwO6nA9wxTfW
 OP2HpfryqL/CiED+TSlw5LS/TQgJ9BiRD/gV2KN1DaZ1UulVSLxcf+9Aiw2M4mh5zm7Gey0DNmJ
 RMefjiWnD0QZkMuSfVTSc+fa3KXxsisKLaQw05lSSQnvrxYGXiw1aZVXZhgmegOKbpONiRK4GT1
 XdsM7MV3g1Zi9Jbmm0Esve3o4jyqmJEJXRGSFnzD13v6kJT0+mkB7wav8TxnW1QrYLAtxiUhXTt
 zxskhJFt+mKurK2ncFoDMEiaEHsdEcSj7Gv7bonTP5KGbHyD5HcdjeRcqqMwpkR8CZXmCIEwS+b
 TmvMmv0vcTqrGPd1UPlgA5fxpsTHcG4xdD8b4bXAA0pqjurOK4AJ4rApLN1t83HAS+IPcTUZcpx
 Tm3yOuPnp8vbiqEMLAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070147
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34486-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,quicinc.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B6BD3B1D9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 10:56 AM, Raj Kumar Bhagat wrote:
> From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> 
> Add CE remap hardware parameters for Ath12k AHB device IPQ5424.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/ce.h       | 13 +++++++++----
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c | 22 +++++++++++++++++-----
>   2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
> index df4f2a4f8480..009cddf2d68d 100644
> --- a/drivers/net/wireless/ath/ath12k/ce.h
> +++ b/drivers/net/wireless/ath/ath12k/ce.h
> @@ -38,10 +38,15 @@
>   #define PIPEDIR_INOUT		3 /* bidirectional */
>   #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
>   
> -/* CE address/mask */
> -#define CE_HOST_IE_ADDRESS	0x75804C
> -#define CE_HOST_IE_2_ADDRESS	0x758050
> -#define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
> +/* IPQ5332 CE address/mask */
> +#define CE_HOST_IPQ5332_IE_ADDRESS	0x75804C
> +#define CE_HOST_IPQ5332_IE_2_ADDRESS	0x758050
> +#define CE_HOST_IPQ5332_IE_3_ADDRESS	CE_HOST_IPQ5332_IE_ADDRESS
> +
> +/* IPQ5424 CE address/mask */
> +#define CE_HOST_IPQ5424_IE_ADDRESS	0x21804C
> +#define CE_HOST_IPQ5424_IE_2_ADDRESS	0x218050
> +#define CE_HOST_IPQ5424_IE_3_ADDRESS	CE_HOST_IPQ5424_IE_ADDRESS
>   
>   #define CE_HOST_IE_3_SHIFT	0xC
>   
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> index 2b5d1f7e9e04..cb3185850439 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> @@ -329,9 +329,15 @@ static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_wcn7850 = {
>   };
>   
>   static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5332 = {
> -	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
> -	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
> -	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
> +	.ie1_reg_addr = CE_HOST_IPQ5332_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
> +	.ie2_reg_addr = CE_HOST_IPQ5332_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
> +	.ie3_reg_addr = CE_HOST_IPQ5332_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
> +};
> +
> +static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5424 = {
> +	.ie1_reg_addr = CE_HOST_IPQ5424_IE_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
> +	.ie2_reg_addr = CE_HOST_IPQ5424_IE_2_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
> +	.ie3_reg_addr = CE_HOST_IPQ5424_IE_3_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
>   };
>   
>   static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
> @@ -340,6 +346,12 @@ static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
>   	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
>   };
>   
> +static const struct ce_remap ath12k_wifi7_ce_remap_ipq5424 = {
> +	.base = HAL_IPQ5424_CE_WFSS_REG_BASE,
> +	.size = HAL_IPQ5424_CE_SIZE,
> +	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
> +};
> +
>   static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>   	{
>   		.name = "qcn9274 hw1.0",
> @@ -824,8 +836,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>   		.iova_mask = 0,
>   		.supports_aspm = false,
>   
> -		.ce_ie_addr = NULL,
> -		.ce_remap = NULL,
> +		.ce_ie_addr = &ath12k_wifi7_ce_ie_addr_ipq5424,
> +		.ce_remap = &ath12k_wifi7_ce_remap_ipq5424,
>   		.bdf_addr_offset = 0x940000,
>   
>   		.current_cc_support = false,
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


