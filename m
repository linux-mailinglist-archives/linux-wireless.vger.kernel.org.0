Return-Path: <linux-wireless+bounces-20628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA52DA6B387
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 05:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EF27A3481
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BA1E3DCF;
	Fri, 21 Mar 2025 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyYjGOmL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDF1957FF
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529783; cv=none; b=UivakARt4J2fUrCgpXxqg+JF8ZR8EZ6NZaVPoQ8Xv84SLGvQn9yYEKtcsbhxGDN5eD85sMutYMKm0PMtJupS61hrpub6ZrYwlGPA7Z3HSVkfQQgE5vzrIgzXDk0ktSmUOdE8j5YDMc6xNKsZ0JTjbgymO5+4NOO+LgKCHbS1ZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529783; c=relaxed/simple;
	bh=8jgC6O5Rf5wrPIndxOK3S+gqzhuYxuqoOEjq38oFdKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLSNFTDX1O6v0R949C7RMKzt1ezYJu4LnDBUw/e4az8OVp2e5g4loCbdc6pBrT3BlQdkdUtSk0hs3qrKGEDAZ5cVdDyix1ut2vh7Fp4kt9SFG9g/0+BQGNdp3QLFl4AFLxd3UQO6PORA1ubzuU80hj6whPCTpexykzvGn+UK1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyYjGOmL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L1WV9g031491
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 04:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWfO2BcPvIMHXrjWEJOrynRVKuEBJtq4aHvLkmmDT70=; b=QyYjGOmLUpxclaAK
	dDWaouWtz19mMXVHiiBtHFF7Ox5e4xP5Is3hMPKf9opGpXUpy5H7xPAZH6aQ8JgR
	OkvR4z4sJTLj8HjaKMPByG2akwKsCI25J0Cleo3wlhaX1fGbmKOigHN9W1viKlPE
	vkEg38tSWf36Egc4sy28/6dKcYSUK3Sk7/ZP9ak1j4700OwBurVWOSQzcytX6S5+
	HbnfvwI4tmOBqAe5W9HK7Lud69c9LfZJyoA8NxbQajo+0CY1PVftr2XdR4XAcmAE
	RaIQZi1h1jDWlONlFAfcXFsGThsx6oWpiJ7SRH4NsiHD9XyT0a4JQAtcle+QBSPc
	06ka2A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmx0ha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 04:03:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so2477939a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 21:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742529779; x=1743134579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWfO2BcPvIMHXrjWEJOrynRVKuEBJtq4aHvLkmmDT70=;
        b=Jm4ijHbz8REstI4GMucnpeStgiF/mSU/1YS8Mny8odEd/7EOJU/g2VbFqiF9Wb0iUK
         naW6oKAxpklsLF+hys+WJZlbQYWsQCh7a/i2UkElr1o9PH4NhAJFYvW8ipyA5/V2A037
         Gk8+ExB93JL4AaClJ1p6BMyDsaGMKCiRSqhrlEhuA/Z+KGZcHL4rPKFcZ8XsTRgEUUGx
         FM58Se9v1zzBXgAWVMnNhd+NG0nsWMg4givYZpTYwNu5Htm/AIM3W8wgFNMS1+gcMF7h
         +99hQGfuseEXncZycxIYkfhL8zqKgd/qdQv0PmyLo6Vme0qV67Bb8tQiJd9ZxvwuImms
         BzjQ==
X-Gm-Message-State: AOJu0YzCDiMD47yShtWbHfY97yCR9Jls7SaYvWgrYm0V+dc5n94AWnD9
	fwN+ndcMHwZjq/zKTk/M1aJoqnJlAu9MtbuIKihb7xncDVQcJKSdqsWBASedmc1V0EtOAb4WN09
	0ztSOcDW/na9PQ2pDaof/0aRE5AuCNYRDOSJcqrBlFA6nqFz4Nx4p3/Gir0tpvAI5cQ==
X-Gm-Gg: ASbGncvXkEaROokfuZfhuIvFVB0EAGOXvtFk9lfCm+UBG4ySx2kbMqyLDcP6B8Fyt/J
	SGgkkbaHvTxgmLp2+yxuWYWLHTJPs7vbSWOtdBCbtC8hd22OjY0UImLfsKKa4AU3K5oqub4m/vX
	5F2fHrnWIR6c3zckfV9jQ4CqkbbZDZn9FR6BDFqv4Ue1AX36dJD1jFzItlPM6VkHrOnuXgB+8/N
	rHOvYMNBbXVR7bvbbD9HOOpow0t+bwihk/oqgmhQnMZQXUc93qtCQlIQNMYmz3XDhjZMyD/ArO9
	tmwqdIDD5C4uvYOt7oDNpkWWCbj42JlDxhfnmenXDZSuKGG8TOfSFaAnmsHMvweZ
X-Received: by 2002:a17:90b:3943:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-301d43c9272mr9424156a91.15.1742529779075;
        Thu, 20 Mar 2025 21:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEfWS1L0HjIr9WqT5+3VKK9Z3whZ1PxEMMo079UfL+36e8bxMvOO2G+eNOx5jd6ObvadbLA==
X-Received: by 2002:a17:90b:3943:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-301d43c9272mr9424116a91.15.1742529778596;
        Thu, 20 Mar 2025 21:02:58 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.201.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58b02csm4865226a91.17.2025.03.20.21.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 21:02:58 -0700 (PDT)
Message-ID: <df8149da-beb8-b06c-949a-025a29f9f84f@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:32:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: don't put ieee80211_chanctx_conf
 struct in ath12k_link_vif
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1qLVyEzEfLriLGdeDCN9XAu21VvmMLay
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dce4f4 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=13kUIL9uG/hLjppKjZ3b/g==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uvMg_fejPkrpZwH_nmEA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1qLVyEzEfLriLGdeDCN9XAu21VvmMLay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_01,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=728 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210026



On 3/21/2025 7:15 AM, Baochen Qiang wrote:
> ieee80211_chanctx_conf struct is not put at the end of ath12k_link_vif.
> Note ieee80211_chanctx_conf has flexible array member inside it, causing
> below warning with GCC-14:
> 
> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Although there is no issue for now since the array is not getting used,
> this should be fixed to avoid any potential data corruption issue in the
> future.
> 
> Remove this struct from ath12k_link_vif, fetch it from ieee80211_bss_conf
> instead when needed.
> 
> This change only applies to WCN7850, and should has no impact on other
> chipsets.
> 
> This is an alternative to the solution proposed in [1].
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://msgid.link/Z8-Snz86Xfwdlyd7@kspp # [1]
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

