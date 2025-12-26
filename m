Return-Path: <linux-wireless+bounces-30130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A28CDE850
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6AD300A863
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC72A1B2;
	Fri, 26 Dec 2025 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cB80F/xh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVUWm/qD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270321DA23
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766739956; cv=none; b=A4PUhudiBRh1RVkr0KD1x3t1U8ChTddMOHAXwdepkFg5t7f0zuYt10Ryq3k8uu6NLhASoRKUbxO4Ik31AHuNU2eYDfZ9qGSx8SpcGiEKZFuns7vNN9x50sPwNolOioypb2Zis4ceYXYkhdDLQbcqJ4AIwII93K8FHz4ipKOIDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766739956; c=relaxed/simple;
	bh=aAC9rHoo/tVOcmfFfXN4w9vPb1fDVu+JfyyXqvp5WHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQsks4sXFJUDQQhHC73aCIGb27kKtG5gQU3bF+25OdoW4qrVC2IcuHt0RN85/wQ0GRgjZLSHO0y89dYrp49LxyOh57pJP2J0hJvY46C3zipx+XtcdSEl91F/8eWOZIHZ8yZQyK2yRhGlmE6HFBq381DZVDzv+8x1u1erEHiooFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cB80F/xh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hVUWm/qD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BQ8baot1280905
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 09:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44zC/0IU6tJiVfDndTbTKY6GsLDZTSddBLOvUA0fMCM=; b=cB80F/xhrrGwXauU
	3D+MJmV5gusSJHbgvhXdfo+Kcn14KLoN3Nz/U4oGOMXRifjws3zGbDYVRY05MUet
	ZkLrjqAzSjeqmV3jKwkW82nGtBunbO/WU0p+WW+MQK+KUR6Gsy5UeFeY+qudaZkc
	9mIbVodBunSUgiPzhewYN0iS2YyQYQfiVYPTCvgTHfgN4H449XWm40/tAczC6fbB
	/mynfFye9yfpND5yKLRibZBfyX5cad44L68EcF0WNAiZdpJwtAZsfLG8vo7u60q7
	XFLJFL1rnpKa1BDHi61lSAxBck5jt5Pjn7Z4h8nnP+7afPgMN6742QIYM/fpAIJN
	ky+0Tw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8p4937u4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 09:05:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so8999758a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766739953; x=1767344753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44zC/0IU6tJiVfDndTbTKY6GsLDZTSddBLOvUA0fMCM=;
        b=hVUWm/qDCIW2KfCYjiVAXT6i+i8s+TEKITPL67z/lOXFJDDG9d7aVfAT6hJwLnnhgv
         C1Agxofby7OMuXPSS8TCXnuW/UFHRuQt2OLOiWM/tzwCfVX14rJJjEwTLeCytXXgFhWw
         fEu/oWBx7LFLs6x0fBkr8SXH5axZMI62f4rotYOz4pBpW2qjGco7tFOr6Ef757fx/Ni9
         9ut/LcKfaMv+VToNqWOp+V7WnRUM4FVcUMKJz5dpOdz2wQg+PAtSAvetBn9QuMCZV9l0
         2Mcxkqb9ee6VC9Ma4hMrcAWqjR3slt33kcvg0xBiScXQ0RqXiskbhycTw3Ae/u7W1g91
         wtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766739953; x=1767344753;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44zC/0IU6tJiVfDndTbTKY6GsLDZTSddBLOvUA0fMCM=;
        b=pxNiCKIpWqSUnKA26NBkJiFar/8lxM9kI/2TpH+MIve/KU/AV+2LcpNUflmX6b9qtX
         cupaGDLKKfXxFqbIbomJVVjgjji7Jm4+/xYYGhMdNRPHmwUpWqMG+x3TY9gQKklQFPBQ
         isqbNDzMFM8L5lgOKUD96aH2H/aa3E3KaVhZ5qPbA8DPIAdmOlGOwPuLa3QsYa7ggMiF
         lnWxbEMNcNRPYrB8HZw+coh/Xq4Ss6NI5RvUnMm3re0EJ7uuWHPylArZ4DsJGtfM7O3W
         2ZnYu166cgqZvO9kBzlQ8B9lAeuDDS7whyzcXvNbBe9vYfj1xA+xSnmdU4VzWdB7H8sg
         g+rg==
X-Gm-Message-State: AOJu0YxTkCHFKH7fld6l5KOe4WhBIO1YhSbyORDZy6B4OWxzkvsbmOWj
	/WK5bLQa4V9j90wf7KOjPg20BTuUaTsZkU9g2yywi8v0FaOsvSPjsxvhVjsq/zL6xqXx7FkUvkD
	vnyOL3r5FtNOWcrXftwNXMRj0lrmBMHozSS7UM0PQlRDBNWhekMxlOkKp0UjwR/6C+Llh2g==
X-Gm-Gg: AY/fxX4cHS8TDoOb9jsH5zqrlHc3Cj9ZL4wpaAZ7gexkO3U7qtP2/KkBUycqtO8v3RR
	yWadjpL/56W/Bv4JmxMe9liZUgos/l4z8BoWCmzbFFbUObFYzTcWwG6IRPGou0Lotcn+uEKDk5y
	HiuEFfsaXIwgpkIQCdLWlHambabecjt0XkpnoT3hf5tXGOo4JdeJQ4CIDUZKw6E1SpLiuGmLUMg
	OAM8ontAINJykXPhusKUfHOFExSuub22ipoFuIEEBBMxsgmYw6eFX8AzSAMjDmJYy0ylq2ES0JA
	Y21/KQBp9zASv9JLJGsGLtwx/S6eAMRs91xyHXDt6NQnEOTewUOld6GpOWfWn6x8uCd+vL2VMhI
	bAEeDd+k492lx1DgUjZNjDlxew+thbO3PXTM/cFoibkAjJFKjPQRt3fqsX0wDF/Of4UtD6MIx23
	f0bokBug==
X-Received: by 2002:a05:6a20:7284:b0:35e:6c3:c8d0 with SMTP id adf61e73a8af0-376a9ccba8emr21727985637.54.1766739952693;
        Fri, 26 Dec 2025 01:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYaMgX6xd5Gu3g0iB/rL6TWA6PLp1CSauZjVw7DX8caTOMAUvBqW9++G8pXWqTt+QFVS78aA==
X-Received: by 2002:a05:6a20:7284:b0:35e:6c3:c8d0 with SMTP id adf61e73a8af0-376a9ccba8emr21727962637.54.1766739952132;
        Fri, 26 Dec 2025 01:05:52 -0800 (PST)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a13f95sm18386314a12.9.2025.12.26.01.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 01:05:51 -0800 (PST)
Message-ID: <90fe1a15-9e22-468f-a1b8-3550212b78a7@oss.qualcomm.com>
Date: Fri, 26 Dec 2025 17:05:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: Qian Zhang <qian.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Yu Zhang <yu.zhang@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WagHcul6i2LOKvzbG7bkwP1ceWdUaC4P
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=694e4ff1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=W4cqpq0YkI6qXs7jkP8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDA4NCBTYWx0ZWRfXxbKCvKtd7gnu
 f0xHcax+7FwSZT2POwDbusLDHHblZO8M2t8x7oFOi4PrBkFT5HbWfRQmKGhzkwyB7r9REXKQpLl
 9WBCHBsOa4sEHJWmaogsycs3pI4WYMfbVyi3iqLfyDmslWNIPqvcQg3jFYflYedmarS7utrB0kk
 xbX0RoAkqnxCqtNNqlKeF6IS6rN5YQreTYB4WgNahixvTw7HE88Ccom+V1u6GmcAKMiFXVshY+/
 2vT09YE+cNeHTEgEw0pABNl++EEnQA35/VXdT1VHTMdwnlXR96VAY2+BtY9fY84EnhdlXw2u455
 CJA2pNsrStHSVQy7W2Lr+Gvt9sZ0K9yjp5zke/xEZstfBmAjjQMI7T73YmfO+LdlfC4Ytj8mIBI
 VD4iXDPAPDkxLZjILr7Dqcga/ykXdm2nXQhuFo5Bm9RaSE9RLHnOss5jjHLDqYMnQsUVjNq8mt0
 k+MTrckJfw9AOPlLZHg==
X-Proofpoint-GUID: WagHcul6i2LOKvzbG7bkwP1ceWdUaC4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_03,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260084



On 12/23/2025 5:27 PM, Qian Zhang wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> echo "<val> <bw> <periodicity> <method>"
>  >
> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
> 
> val: 0 - stop CFR capture
>      1 - start CFR capture
> bw: CFR capture bandwidth
>      0 - 20MHZ
>      1 - 40MHZ
>      2 - 80MHZ
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> method: Method used by hardware to collect the CFR dump.
>      0 - from the ACKs of QOS NULL packets.
> 
> To enable CFR capture for unassociated clients,
> 
> echo "<mac address> <val> <periodicity>"
>  > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> 
> Mac address: mac address of the client.
> Val: 0 - start CFR capture
>      1 - stop CFR capture
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> 
> To collect the cfr dump,
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> 
> Previous link:
> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
> 
> ---
> Changes in v4:
>  - Update patch 2/6

Details of changes is needed! General description like 'update' here does not help
understand the diff compared with your last revision.

> Changes in v3:
>  - Update related comments.
> Changes in v2:
>  - Update related comments.
> ---
> 
> Venkateswara Naralasetty (6):

The author in each individual patch is 'Qian Zhang <qian.zhang@oss.qualcomm.com>', please
check them.

>   wifi: ath11k: Add initialization and deinitialization sequence for CFR
>     module
>   wifi: ath11k: Register debugfs for CFR configuration
>   wifi: ath11k: Add support unassociated client CFR
>   wifi: ath11k: Register relayfs entries for CFR dump
>   wifi: ath11k: Register DBR event handler for CFR data
>   wifi: ath11k: Register handler for CFR capture event
> 
>  drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
>  drivers/net/wireless/ath/ath11k/Makefile      |    1 +
>  drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
>  drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
>  drivers/net/wireless/ath/ath11k/core.c        |   41 +-
>  drivers/net/wireless/ath/ath11k/core.h        |   19 +-
>  drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
>  drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
>  drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
>  drivers/net/wireless/ath/ath11k/debugfs_sta.c |  142 ++-
>  drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
>  drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
>  drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
>  drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
>  drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
>  15 files changed, 1832 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 
> 
> base-commit: 25f833fff81de4fbb9b5382806860b63768567e8


