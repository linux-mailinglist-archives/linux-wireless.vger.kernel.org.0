Return-Path: <linux-wireless+bounces-18276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A880DA251D4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 05:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37054160F7C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 04:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E625A62B;
	Mon,  3 Feb 2025 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFyjy6jo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0C481B3
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738555715; cv=none; b=HpkNClELDz+2RY1O7eHuivRUPp+gnvsBrlrAzdbz9bop+bsvhHKnJ0b1VckVPX6JIKkaXk/0Gj9fSFK41Xu/9LyKgoYC16K/U40Gz+ehWeoV4svnQ9WExWmRNlKuDv0jgH1xl09SxxxWKk/lZI8a82ab8mjSIJ0ci9E7LgvdaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738555715; c=relaxed/simple;
	bh=iZRN/DiRSZjlVEOscn6KJCWsGIPXOJVx5430FCcbD6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCbDPWeuGjS+PZHPiPvVoT+hnZQNNm74rLnMlbTAlgD+09UoHxTS8RABbO7G9aHUfBXZfamcUgaPsIyq2hBiusjetQwUCFY7QMGNScxpRlnX2H/9Em4iiNQQLCCTbTgTZL7n/wIMmC5SPn8vY4c8tW/Q+IelDiOAamPUbyHQuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFyjy6jo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51309iUP009904
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 04:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+AMughmxCTXks1HYIHZ3mVLbjoQWFQspKRk1Y3eZTAE=; b=kFyjy6jocBQo4UYj
	6IwZ5OfV8e6OrLr9hJCGMpk6Lc1qsxefZquoC478X2ehzDPxVSeRv6NHuBU7qk8/
	szD/R3rzjgnofxzgoyLYxuoryUbswVdSUABqDhK2hS0sWNXbH9iGlYQurKFUF55Y
	NImQz36mY9JmFd60I3zUGAJfPjzk1SYHdYSqRB0xG5m3/U4aIdj127eFaVnLJrs0
	w7n/bE0bsbR0nrBsBEwGsJCxcZaPeTmdW8mbLfjvZONZdjHn2P6ra50GaQf3F750
	ujwlrwhEphpe6B6Nwe7bENhhjsp47qRke1sCD1Xuos4MaK6CLPKS2J8SSULtOl0G
	IMuxBQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd8rb50e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 04:08:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f780a3d6e5so7678504a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2025 20:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738555712; x=1739160512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AMughmxCTXks1HYIHZ3mVLbjoQWFQspKRk1Y3eZTAE=;
        b=pG6LPx8dszSC309H69NxDooMhXqV7KoWLYoDgRuWbtdVXUuqWUx7WDQXCYQPQIn5aa
         fupOWulZikTzAuUvB6YZTfCxIrU7EZqnnxbuPI0FULG9aechBC8GlXE2TtCbwaHy81hN
         v1+o/pvSjB7obsz/puevT7RHzKR3/U5lOUxHqM5lAXfTFyNDjMMP0+mM3ZgiiXkMA4BM
         9UmzUoIUQw+QiVXTrMu7VMOJ3SAVSaFp++x9m3rgGNP7NBdw5JU22rZubwi8BSEHZMbg
         zqN034tvQMeR72I7nWsRziMkFaKT5oQUrLxQ19mIDOeWdzMWBOuvgZ2djrzjWvi2jX11
         RwwA==
X-Gm-Message-State: AOJu0YyIoYDywEVmg1XbBfD4OI+Q1swmLbUOlzLUqO3uKxGmJ4/wn8E3
	bprsMlDxwhQKFEE6ZsbA3jvmcQcrvEoi86arbiQmT2aVDU6/DvmyObuddjc0m6KfcR6MY3A3oF2
	u2LMdnbF/Gb8K5k0d3oUV52DlZX9zfL9VHX1XPLMWi4mhVJxDthe4jd6+iOu+DXBcv5Zh0cg+Cg
	==
X-Gm-Gg: ASbGncsAfA4ox/+B073seC1d8PFxICHVs/qC94b9ws29/adl9uFpRZMnqPwqKEfQkjp
	GOsk5flrwKaH5EJKw/0r2mJVTYY4C5FRiTnyHzAI0fEiggZ+Y8Wl46e5d41Un/pfxHylbpnqByy
	0HUK9NHmfyrXIEEUBaRdIWZWXQzaWhoEllBiML9rpCClBrQ9on/X9q3jiqXD9Zyh3Hq9ukZTBAC
	zc9Hk56gEc5Oy7RFU2KeDUHSdM43vgn2Bnt1PU4EVbaZjOCu/UHHNtKqZzfSqBi4MurGuNTM2mf
	t/3ozqrvMt4BNw5BdylZsv+20M1I0ZQnUMJwVXQ=
X-Received: by 2002:a17:90b:2802:b0:2f7:ef57:c7df with SMTP id 98e67ed59e1d1-2f83abaf38bmr32210969a91.7.1738555712251;
        Sun, 02 Feb 2025 20:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCeP5NJC6LFubfmD2Sj5atF6siwhzfidW4q7YCOyvfqHClVK7EgpGt2GHCe4+X5+6gzzbD0A==
X-Received: by 2002:a17:90b:2802:b0:2f7:ef57:c7df with SMTP id 98e67ed59e1d1-2f83abaf38bmr32210937a91.7.1738555711660;
        Sun, 02 Feb 2025 20:08:31 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848aa0874sm7854416a91.32.2025.02.02.20.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 20:08:31 -0800 (PST)
Message-ID: <e0cfabf5-a858-4069-928b-ba4dc86f307d@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 09:38:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and
 bit mask definitions
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203025016.3851279-1-quic_bmahalin@quicinc.com>
 <20250203025016.3851279-2-quic_bmahalin@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250203025016.3851279-2-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZiZLeJCCxeV2L2AqayeLablPo_bnqWAu
X-Proofpoint-ORIG-GUID: ZiZLeJCCxeV2L2AqayeLablPo_bnqWAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030033

On 2/3/25 08:20, Balamurugan Mahalingam wrote:
> Update the HTT_TCL_METADATA version to the latest version (2)
> as the bit definitions have changed a little to support more
> features. This new version allows the host to submit a packet with
> more information to the firmware. Firmware uses this additional
> information to do special processing for certain frames.
> 
> All the firmware binaries available in upstream/public are compatible with
> this HTT version update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam<quic_bmahalin@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

