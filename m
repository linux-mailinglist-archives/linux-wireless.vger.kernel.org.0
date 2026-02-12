Return-Path: <linux-wireless+bounces-31773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJf4FGjrjWnG8gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:02:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE112EB7A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25EFA3016EEE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA55286400;
	Thu, 12 Feb 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVH+lzwC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9AzD4GE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2C29CE9
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908492; cv=none; b=nar0orFlvfqAOT8pnnwEZM/vXUBIVK4JkaP+vLgl8o5jRO9DCgDi4D+zXA3FlSjiTqlH8JQZNv2RmPzf+XXIoamlLpmIY6+c98wQAzWMVqKxVKFH2VJJQQQvfj+JjBAXxMirK+i11+Tu9an2qF2zqnQVmCL1T+fLiFi9sxtXMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908492; c=relaxed/simple;
	bh=LWfPVJFhuZRaigIzhk5OdpvGw4AR/InmFYo5/gO3ktk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoifpBCaUMKmuy1ozKjMCR8GvpvWPpaIOA2Yq6LPVtKBC5ODM4PN7aqKSrVvGJNWAVZYppbWD/oJAmVnPPgrdEDhij9yH+jgZNgv/j3ZPKeRYPoAKHSnJvfc8EQxMTD3b0+/h1QuWrbMAfhWNk2LsW26S7J5qscWihkPN6uxHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVH+lzwC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9AzD4GE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRiY11580898
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 15:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Td8TkWhaFGm2U4+qFTUwHeU05QZK/KaVCrS+oH4rQ4Y=; b=YVH+lzwCwaaTjQUD
	pgCzHVxmFw0NmNAqwG5GeoX5m3rr0pvjBdYdxZia4OXbTQFTOX1dMiOIhW3JUxYt
	uAP/F7shw6cHXBEqVuz9XLlq/FPTbNGJzoxGiw4o0u+NXkf0jnzU9kqJTuqbDTZh
	DrRv7HmOhsY9wuIYZORwy7XbMEaLSIWQB4H+6HA1o8VK939EAgttKlkvNC9W8Dca
	TgpRHmHmzYln7VoqA9oW+SOdJrr/l6/IZhdvPcXM98QFJSiWvFx+qHY4ifFPNr2S
	WdPkatyhMLP92Fv9Slx5A2f+9gMP37yx/i0eBeqfVFqxnf9TGrhOYsGHxCRYhtER
	DLI9MQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y9budap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 15:01:29 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d18e652149so4139614a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770908488; x=1771513288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Td8TkWhaFGm2U4+qFTUwHeU05QZK/KaVCrS+oH4rQ4Y=;
        b=c9AzD4GEFFa6/dLccobpiU6Sb7qQ61O7Zj25ysxiWPvcyU+dzKu2S92f2IZCJ4usDt
         cN9eyEEzGJnCuNjK8HqnGtvDfpz6X5Ke+8WxnfpE5JevMpaqVPuHT/UNrIgVNTApdF6m
         WX4fkAUfNCyqijShZ6QzbkUGiGxNlT+PkCuf8D78dd3btMCMNDVOYN8Dc65e8OFvLlmm
         raHD9ZOnreJjvb/WDksX3slVd0CwK3BpjC+BXj11lMtEVq2bkmu0JICNZDu/EFBj+gZu
         4K7FZrssNayx54fX2T9DZW/EvP5ZKZN+JIQfNCpIXIWWmhJuSYj3g8oEhSAqd39tP3z2
         m8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908488; x=1771513288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td8TkWhaFGm2U4+qFTUwHeU05QZK/KaVCrS+oH4rQ4Y=;
        b=bzK1V+NrW2j/IB6/TEE+fV0veWZqYG5I+xiH4Khv+jrsfcjmsdhhGkw6BeDGmrH7X3
         /j2LZqnZhJmfzZT4RDu1CKf33RvyJ4fiXIYdhc4IO6D22oW8amrERm5T0ylT2EBNVytu
         gHH26ybOBm94uWYaZbEA8lk6o7axQlKgtNMsITrE4dJNdASXbp2D7mTzC/NQYRZLoHC/
         ZUZsquq2yUfaPa6kHto3vhQq2Yhm9wwFv/3uua3vo40gnEdj54GPODU/cHidH3t/LG21
         WSVe4HTK7tOFRlVBZeSSgL6p5r4MQYkg3NscfUVs0MLh0U8xaMk8agU4dRh4+6gfDBdm
         /VCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXstpghcRqPpcPLaaxD06n87ASJTbKYW1lJkjcWHkCEGRaRoe8DI148XkrExTG7773vmRoTYIW8vLxZKUUl1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+kslkXU5+y7aSCVWQ1rOsTe8tGeIiwUdw6I3Y+ONQsY3z6gv
	VOEeuEcnsFv96YhONANqX1SpjGzeUt+XNfbx+xaIV1HmUHdifEtCIvyAQtlJFyfGDsc+G78fItT
	mvGI0/W9qKLeWJJjMMO9XsGacDIYRppopfK4Tl0NvN1vUFqrvQJsVSr4yf7jlkIhdjjaiD3/qBu
	eBPQ==
X-Gm-Gg: AZuq6aItxDJ8/jnshLcquuQ+6UjVX/nLIhzHK4zYp0nk6KQENZcfs/VW0WD45Qu0F+x
	N1ubkjQaG+uucgPP1HJ43L4AIgUC1xxw7kk7aaGeMGbSbl3A3ofb1pFamTnSOD4azNBBcQqHQ2p
	n8KBQ//2wh83tWkrQTvtVwBkXU7SCBDWSqDqHKCP01ER4+SGjxVuLnZqIdAu6iR2X/32YSlOjaj
	CtVfqVKpECgRwx34n+FivTEw6mvUhJPEiNXEifFjUpyeW9LvnL6wlrFUKo52yU+LNgBenHJMePz
	o06wfJBLoF8N1SiXE2GdTfQhxurBTjKcYHebz3VcVsiWf4Bu2EorLXS+PwNAPPCWn5xeFiJcJI2
	TYyivwrEPPXwvBp11Vn/63EilnYdhx6hJoAXf6Ym7RjZVee5Jn0S2WLr76YM36aBjUYd/IVOsa6
	jIE+8=
X-Received: by 2002:a05:6830:2b25:b0:7cf:d0f6:a1eb with SMTP id 46e09a7af769-7d4b29884b4mr1211331a34.1.1770908485922;
        Thu, 12 Feb 2026 07:01:25 -0800 (PST)
X-Received: by 2002:a05:6830:2b25:b0:7cf:d0f6:a1eb with SMTP id 46e09a7af769-7d4b29884b4mr1211260a34.1.1770908485219;
        Thu, 12 Feb 2026 07:01:25 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65a3cec9e7asm1834360a12.12.2026.02.12.07.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:01:23 -0800 (PST)
Message-ID: <f028462c-ae31-4fa5-b414-e03d3a73fdf4@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 16:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Silence remoteproc probe deferral prints
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BbPVE7t2 c=1 sm=1 tr=0 ts=698deb49 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=IsMmzSx_pjv120c435IA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: V3ZnjoXP2Kc8U4b_ynBGUNo_8LU1pBTe
X-Proofpoint-ORIG-GUID: V3ZnjoXP2Kc8U4b_ynBGUNo_8LU1pBTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDExNSBTYWx0ZWRfX7xck+ipb4B9k
 qFR4oCMsLPKoIDSvKdC2Y/IpaB8FLuCLDE9U3bvBUGPxv6w+6sjoJPq2BTbI7D18+6eoKHZ1QBq
 Ujldgl/c1bKMiWke69NVvWNn23S8YJ2XvLiPeLRknETj3fW8MCFOorYiynycg02bKGb4Y3GHEvp
 QHS1ikpCigyKachYDEtooHuwfcp2V4l1NTKd5cuSbKwcnnHl2iLoWy5cmJwW6kz0qQWB7PTSx28
 V8BdZa0bZEBYUQKTdznb4CUsrb5R3fOAAe3Q4RKGbbXDQuU5oSfurLaRdXt3a2TZrmDRdn6lvWw
 EyC4pGijuv+d2g4jmlG7z/M9LlbLwFUKgbfo1RukgRWpNE4b9gh6oZHcHMZ+DHAyp/OOc4rgxOV
 4UiuZtHt6ptB6eps+HNiP0MU2MJVTbD3WTBRUSGGq+qrtpFtYaA7ljEQ7rcQ1EQJl6r4zfVmZjI
 oiQH1m/2GpppYtW/8VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-31773-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: 4EBE112EB7A
X-Rspamd-Action: no action

On 2/12/26 3:52 PM, Bjorn Andersson wrote:
> Upon failing to resolve the remoteproc phandle one ath11k_dbg() and one
> ath11k_err() is used to tell the user about the (presumably) temporary
> failure.
> 
> Reduce the log spam by removing the duplicate print and switching to
> dev_err_probe(), in line with how ath12k handles this error.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 8dfe9b40c12626649639fc1dd9da0e5e0c2dcaf1..08d3a0c8f105b26b1548c5d6006f6ea162fe58ff 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -807,10 +807,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
>  	}
>  
>  	prproc = rproc_get_by_phandle(rproc_phandle);
> -	if (!prproc) {
> -		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
> -		return -EPROBE_DEFER;
> -	}
> +	if (!prproc)
> +		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER, "failed to get rproc\n");

I'd like to think this doesn't really change the behavior, but I'd rather
see this that in-house print functions..


>  	ab_ahb->tgt_rproc = prproc;
>  
>  	return 0;
> @@ -1190,10 +1188,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>  	ath11k_ahb_init_qmi_ce_config(ab);
>  
>  	ret = ath11k_core_get_rproc(ab);
> -	if (ret) {
> -		ath11k_err(ab, "failed to get rproc: %d\n", ret);
> +	if (ret)
>  		goto err_ce_free;
> -	}

If the rproc handle is unavailable at this point, we undo quite a bit of work
in .probe.. would it make sense to move this check way above?

Konrad

