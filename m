Return-Path: <linux-wireless+bounces-28349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A164EC17FEE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 03:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 450C6505B77
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47B184;
	Wed, 29 Oct 2025 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="moCLACVv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WBgMfq1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA242E8B60
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703368; cv=none; b=tE/Y0SqJqOWVLATNiZPsJQhtwud0hvJU/k3qsYDRzvKCjLRCMv8hmz42g1jSk4ez6O+e9gPpCXvC13rNZMF9VccMywmnmW89cEdhVcPVY0AFDmXbfM2O5lMhRtUQ4CX2yiADtpOiMFFV3WNUPSLFQaosgEhIXXbwHrwwels6CF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703368; c=relaxed/simple;
	bh=Pz7NzoD2T5f8kPsfdEb9COLkFyV5JhRt5+fFgrda5KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrwBJr45gQx2N/UsstwXYFkJGzLM0LSn+a8d2sAWRfzdgiewMWnZRf/QXv6OalGbLiPe/P8mxJYuHizEWIi6abCnxRi0DkgeTBsgBez0I2mXLbry356+07LMB2ZBwYkLyZDsTVWqWaMIVBsGoRKVxLhY9tpvifl8tNjx8e+Ll24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=moCLACVv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WBgMfq1x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJllYV2524097
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XHD3qAsYq7bk8sAiSss2ZM7l6bFmO2byTwWLdGl1uY=; b=moCLACVvtXJYioCm
	xM4rt6KPH9Mqtg0ZB5RMJqSan/DxiWnPwMHrqaD7A8XhwR2HdSusHkSpJECCUGSN
	J/gP3Chb8gOvReqNfc8JObnuRGpw0R7jXjVV95nN2YLwQW9xIWeMXV2AT6oczXzp
	x9SXOWec7dmmsinlgjlkXSr1aR0SjZo8M3q2+7iokPSCYYZ/azq1UkZMf8zcncGU
	FtK+N95fE6dytdHwaaRGIFugzaTLxedY1w3WEBMAI+/pz/io+/g74rqQhf7/+8sE
	PuuAEGE6EDUCPBFkJ2dTi3e1XMEP7xucQvMQBwg7cBPNJmqThLPH5ZdKJf6+hW4A
	/HT0gA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1rtwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:02:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so5696395a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761703365; x=1762308165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XHD3qAsYq7bk8sAiSss2ZM7l6bFmO2byTwWLdGl1uY=;
        b=WBgMfq1xHdkkZ08LAuUE5Y6MJtnnHpjlLHUh4ZKKpsvrlfA0wo8qkvWZR4TVtENvBn
         CYHahkQjz9Jcbav2Gbewla2h6mk9+uXIv1KfE9xE/Y1VgJyMtMhMOibHeWqBRQOKpG4h
         WBrRKydXXcm39YVxQ5C+vbf0qFhgdpy7xXk6/RD26kYymLvG9ZmKl3VCvqFu5/pSN4vR
         t6i6xB6Edb4sr/DarSYWHcmmpR0YrymK8kzFxqr2d7e186JMhCTinoaRTIKVtKVaLSAN
         2TXLpb1QZtoSOFnUMZBOS4hPFhwF8kxx+K45yrYZqr1S4cZKIQhCXs83DN1OwCYnvjd0
         H65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703365; x=1762308165;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XHD3qAsYq7bk8sAiSss2ZM7l6bFmO2byTwWLdGl1uY=;
        b=XlZZJZCwJxdQHmJIChpmfKJRo10DvaMSXOuwqj+CMWZJSvKpaMnlv3yj6mxk8SrxcC
         DRvZzBjsDPCC5VzM+CBTc2wEeeuvzijhzzI8+rUZNaSXymOrvRhb8aZdeE/v7IVVYpD4
         nbUuFTxRxzDahkqzjUP3OpQBxqnGfjn6Ab50vxyFf6OsdsofBmxQtwmb3Xbsh2rtRBIK
         Qth5UZvqhgLMCYm+xZ/bpfrkohvwG0b53tpEkElwMB20qehYlxkJ3eyzoShGqJB2W6m8
         1j20K6ODMoXvjOYIBB6fiZnfwv3DMf/7J0ePiOrd8+DpFfwaa8NMCpnDMNRaDPs3BHnA
         KlFw==
X-Gm-Message-State: AOJu0YxgfJKJbDGfrUI1rPcCSMltGsSqPKLqzV93ftRQEoVuFALucfPq
	BVKIsLXBkz2Am9sIf4Bl5FuAkRP0rFZ5xsRY0w0drN4aJ+eypGX3aivTow8FZqiGxDr3cof3LTw
	OO6Z40ury/0jB/0WoUrUhC/KJ2CPagR6CE0bKqRpz/M/q/cjHD/Yreff09aoKOdu+iAbkIzf2D6
	eAYA==
X-Gm-Gg: ASbGncsK+QpnI3eKndTfbqbhIkbPJEobjWDPAgCnm8aprzxxaB75ww02XK1bk7gFldv
	mQMvoP56c4omEAWHWNmVrZtDEGg3B1BzWXQeCl1WkoGwhw5IunDZhclO0k7Ib2lHrbIIch2ubxZ
	S/jFkgUtyee+YCwA6fT0shstibE7cqK5OMYEdVrOJu4tGhl2kTDUEDkMcTclfgTW2Gb3EdizvLV
	dmJzGD4c7wyRj7liMLSQnmWFIkU0QFhQqCwR8W1Js/rUmZjoM2dDJETsRED1IERuY1axNrHrkoM
	pSh9V1XzER0Cnf0NI+NBgqo6MM8D/UCMVuiRfmwhSixYlLSDiLiFzSpo252Z62S4pdrrs7NrsZ+
	28gFYFxvYhta6jwpnkMs++cGU/YgLsBoJB79bvHrgfbecU2bk6hEiWCR5xR8a
X-Received: by 2002:a17:90b:5285:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-3403a15d171mr1330238a91.1.1761703364840;
        Tue, 28 Oct 2025 19:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGcScMXLm268C0Dm3zeV/yJI6TOPZWieAH/ad6aJnRDTo8npsq612B2XwRMppYY/qaERJ3iA==
X-Received: by 2002:a17:90b:5285:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-3403a15d171mr1330204a91.1.1761703364290;
        Tue, 28 Oct 2025 19:02:44 -0700 (PDT)
Received: from [10.133.33.233] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408757csm13100312b3a.59.2025.10.28.19.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 19:02:44 -0700 (PDT)
Message-ID: <606e4570-46ad-454d-a018-3bf2dd582dc2@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:02:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix potential memory leak in
 ath12k_wow_arp_ns_offload()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cX2a6Tt0ildyK9zHjT3jaqSQK5coXaz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAxNCBTYWx0ZWRfXzeLhgHuB8emc
 praPbu/aWbMfmF0VbydG487wdyEnTa8UZiEQITTzWxBVX/1XuU4dwL4glT9xLLZIjtN+ZlN4oxA
 S4Otu6onvQqZRbkOGrfqEks+bDOi4H9JNWi9BgwMUq5OPkYR9YRATXN5ZpTSr90WVJ99Tbk26Ie
 T03//xlQMuFNQ2hw5JuC6Cx855EX2bLRwF9Ur4xMsU6OrTzbknRkKkvfwdjbLNc2ro+exERG9d8
 OVugeO4l2pdk0dlDn5l6ON3UtPCSN8uSQ1YsnUewgq4rMVdxbLbJpJcCRBXCW/0g5WufYRDZzGD
 wG5lLprKjBxqrUtMQYZ7Oj3ZYqAHmQ5cDDxX7+fbJlCIbao4v0jYfWqwv6zAh64pZJakxWHjt7F
 SJWMksnoiqu9GX7lArqi5x3n+2TOwA==
X-Proofpoint-ORIG-GUID: cX2a6Tt0ildyK9zHjT3jaqSQK5coXaz0
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=690175c5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QpG1ZDNR6MNC-5z7ugsA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290014



On 10/29/2025 1:04 AM, Abdun Nihaal wrote:
> When the call to ath12k_wmi_arp_ns_offload() fails, the temporary memory
> allocation for offload is not freed before returning. Fix that by
> freeing offload in the error path.
> 
> Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/net/wireless/ath/ath12k/wow.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
> index dce9bd0bcaef..e8481626f194 100644
> --- a/drivers/net/wireless/ath/ath12k/wow.c
> +++ b/drivers/net/wireless/ath/ath12k/wow.c
> @@ -758,6 +758,7 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
>  		if (ret) {
>  			ath12k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
>  				    arvif->vdev_id, enable, ret);
> +			kfree(offload);
>  			return ret;
>  		}
>  	}

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

