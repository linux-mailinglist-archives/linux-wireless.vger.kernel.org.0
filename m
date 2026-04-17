Return-Path: <linux-wireless+bounces-34915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH3qAs2V4WmwvAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 04:07:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A14161FE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 04:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7998307312C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC982DCF58;
	Fri, 17 Apr 2026 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DS8YLr5I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ou9zBZyU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85229B79B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391613; cv=none; b=snTZsb5iWv2Pr65WenOAdIDgaKv/Ra+UvpIW+fYl2vYU/D3IWtnxd8kGMJqz2ANyc6Txk7YXZcmIo8MB7tt5QuWIW3loLFoR0fmsTXXqZbhgDe2ysOlbhyUbiUORaHnJe4uJib9JXyt2msV9j+i15SU0qFmL0QumoPYwsRITxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391613; c=relaxed/simple;
	bh=6mYcDOkphAgjW6v+BiSpJFMr/psSzvaiSXyHLNVjDWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=senwWRpsXIFWa8qBJoTjPexjfiYzesWD4wNDzw8Tis6u0w0bZkQeeC7dHnJnsHbCQcKwJxaVHIIetlk90wv1hSVO9cws/1id5GxIsF1JTSrMY5rDuP28oNSUMlV6OfNzIIqXEojB6T0Z3/Dxig9vrRMNNW3hBj8ELQyzmZHA6YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DS8YLr5I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ou9zBZyU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H185wu667583
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 02:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ASVAs4SyLb39Qmi1wwnet3pJDyNwhLVO4o2D4jse6Mo=; b=DS8YLr5IYQSqlaq3
	mu3N39ApOYwDFd1Cxv2kmlNm6r0j7MncafSFFFTS1ubGDHeYJ9ViAAV8pvX25liX
	WvBG0g7lutS+OoQcDFUwz2Cw6s/dZMB7BzjAIvunCIHSqfqjk0j7GdxUPyZlYjBH
	ShYBisSmgrbnMF9ou1u6iej5SwjErQMNwGytjHx4QbOK2nvpl5rrE2NgBAGHlN2T
	9Oj6EUoCM9Sg9QbrypsnbrAL6IlyIQQ2g2e4+T/fIVJqpgCt50zlRQ8xAe4fuu5T
	BO9iXqCUEidzj7Y870gmANGHUIR2IEA2/AldrDWmS0NYP68nMzv0QjYT2K9BRtJe
	HUmChA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkaxcr4jw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 02:06:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so246892a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776391610; x=1776996410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASVAs4SyLb39Qmi1wwnet3pJDyNwhLVO4o2D4jse6Mo=;
        b=Ou9zBZyU6YNbsswq6SZ0oekifJZ267gUawW8kvRz6k6KYZI26qGk2rX9m2QuofSQ0b
         wQiKev4znsooKJvXld+1Z+a52PLfhKiYGg2F8h9l8wYD4YreWG3wdpddSBcWcH87wFlb
         QRfWVCG1Z3XOTvawM2s7YZqnqGP0l2NmmpUOVGsIs1FbYB1JB9q3bxQfIch9JZjgwFbV
         zvVSFjPKet3ln2ID7mC3kCVwZAj/LvDuhkl+8vNTECtGpaGY4Gmip0NqUBCUMtZJ4Qhv
         YrY5vwn8vm19ZkQKLk3gzeWg8ei4MZESnaVnyY3hdx4Tp6TxjBXZhMydpUUQKfBenjw7
         P7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391610; x=1776996410;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASVAs4SyLb39Qmi1wwnet3pJDyNwhLVO4o2D4jse6Mo=;
        b=Bi4C0E3ZhR+C00vmWrAHom3FokxSTI39YmVyBKvFn7k1HNG20ziIt8cYuz6M8+hl9u
         bIMGl1wXM7OOWjh02HE93Ix4zVgrEEjFBQNx4lPzRArZYOuI1taLzrDWQN8eKWLw9qUm
         jCkG7OWlxEcVLbWGqzlsSeQMD2Enf6DAh8uNJsDl00APjDqnD0h61dfXHg3H2Z6zeFwh
         9sQHmE/HrSB7ArU1MfwQxtRadMKUARflUE2S2FU9+rpXO88McabL2u+QXXglXriC8JGJ
         g+KFse+hPfERz/M7zWGQBwCF/HMDAh3DWUyo2Hw+IewnwXCiWP1NoxvVcNIyxvJkMhFf
         CcJQ==
X-Gm-Message-State: AOJu0YyJdSv9NKyM0M4WvILMo6j7LF47+humq8bSdJIIctEc5izNXqEd
	80ogHF/wliMWksOqOLy5eSCSRTe9fssRcVgFkyFusShZsiL96xLeqJXfDfjYMI93qxFt8px9OsH
	Y0Ee709w6kfnSntd8b9UJ315Ctvml/2XH3JEZRdzt1DExdu9p6lcjF7BFBr60Qc5ZGhnO0g==
X-Gm-Gg: AeBDiet1bdaKqWc0CJ9NgyL6vi5oq58Vvdf4ssgl4syqT9+AHHnah1vfjMLtCerDt5I
	7jNWf3UMJbmVAmxz7BMezxq7HanoSzbEzmRBvR8v9qsDLDxcBdcd9jQrzDbGHAPbZU5RdNBPOZm
	g+jKg1jlGwkS0lbnqYykFEO0pQhbOQzNf18ripvkmm7GE/dc6Km3MFxTtxdN1TpZ6LEGC59CTp4
	q/mnkyBjlKGW8W6f6AnEJWdPKezfQ/RLjiL4oFu09L91HNoV+u0K0zW4ILKNW59CuMnSPvDWgTB
	MapYp2LoFnUFsSd13ew2jUEd4c77wFVUoLKW5dZZszXDflWyX0lpRkiSshPPsvtkv1vo9AcZALn
	VG+5lzIT2M/e5+T7Pt0k1qOQquLS9+hr/sykqBaCDS75v46dgobme8ofL1T2r4H3fCgvZF3y7gr
	4N7noKzi12f2j4sLVkykNlInPzaB0A
X-Received: by 2002:a17:90b:53c3:b0:35d:a38a:a117 with SMTP id 98e67ed59e1d1-361404745f7mr844108a91.15.1776391610425;
        Thu, 16 Apr 2026 19:06:50 -0700 (PDT)
X-Received: by 2002:a17:90b:53c3:b0:35d:a38a:a117 with SMTP id 98e67ed59e1d1-361404745f7mr844081a91.15.1776391609930;
        Thu, 16 Apr 2026 19:06:49 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbbb4f9sm217482a91.6.2026.04.16.19.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 19:06:49 -0700 (PDT)
Message-ID: <3caa2840-4218-4880-8ce0-5bb29b2b62e5@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 10:06:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove macro
 HAL_RX_EHT_SIG_OFDMA_EB2_MCS
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260416-hal_rx_eht_sig_ofdma_eb2_mcs-v1-1-c44a3177deab@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260416-hal_rx_eht_sig_ofdma_eb2_mcs-v1-1-c44a3177deab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JcqMa0KV c=1 sm=1 tr=0 ts=69e195bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=TSGZlz6qhe5vOcDPnEcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAxOSBTYWx0ZWRfX0vsYr+kWTSQc
 KVh7aav06H6XWYRWyhco3oV8CvRfsl0cl99uhtDEFyBShVDzaUrGkScERoMJl36K+CCPnvXUb0H
 I10iPv4iy34PZbJPTwuQNuY7kb/Xt6D0k+BnagJTiTEg25iawJtLx5EloaW6fZWsbfl8V0GiGqV
 4AWLJnxmKSJhvxfNDpfVofkp7KaTi5PsU4K8Polcziof/F5joq3ntm6voskB6QiIvNVrFREw9cw
 ZG34CsKmBZOBd3/+E5GdiN4k05LuoSD4kDXt9L6V72RnC1cNS5/rkDfBmhhyCMYsKDjN5RruDCm
 OeVe+lXNXuf966begqmwI7y7WPf+shxnQRE0gZ3Jv6l24REj9P0CCPZtjNGFuyO9T/P/Dr84mzI
 Q2ZarJTRJrWNx3fI1iL7Fpa1PLfQT5gRbGhqoT0mQIk6DFyqYi8ixXUA4bxEgm/gcg0yREZwzQk
 41Q6Pl3J9Bs1rrUqXWQ==
X-Proofpoint-GUID: ZkQFKzDsdjx9-xFFObjmIpqYrPSTKIK7
X-Proofpoint-ORIG-GUID: ZkQFKzDsdjx9-xFFObjmIpqYrPSTKIK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170019
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34915-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 975A14161FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/17/2026 4:02 AM, Jeff Johnson wrote:
> Macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS unused, so remove it.
> 
> No functional change, compile Tested only.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> ---
> This issue was highlighted by AI review which noted that the
> HAL_RX_EHT_SIG_OFDMA_EB2_MCS macro misspelled GENMASK_ULL().
> However, rather than fix an unused macro, it seems "better" to just
> remove it.
> ---
>  drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
> index ac2a8ac03288..dd60626b3240 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
> @@ -559,7 +559,6 @@ struct hal_eht_sig_ofdma_cmn_eb1 {
>  #define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4		GENMASK_ULL(35, 27)
>  #define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5		GENMASK_ULL(44, 36)
>  #define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6		GENMASK_ULL(53, 45)
> -#define HAL_RX_EHT_SIG_OFDMA_EB2_MCS			GNEMASK_ULL(57, 54)
>  
>  struct hal_eht_sig_ofdma_cmn_eb2 {
>  	__le64 info0;
> 
> ---
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
> change-id: 20260405-hal_rx_eht_sig_ofdma_eb2_mcs-a22a27f955bb

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

> 
> 


