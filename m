Return-Path: <linux-wireless+bounces-21211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91FA7EC90
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4F2446174
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841A2561D0;
	Mon,  7 Apr 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RKhKlcM+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC161AAA1F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051522; cv=none; b=aErx+z8KHiBvM9Kj3yAAC/iZFESw/ET1Vzc0ohMlFDfXd6giNlZD+oTuv9hS3zDOvX4HhtOo7Wloros+Bs1LCFTGGu2o+mkn2glccNb0ceNTd9G1/k90X1OGh2iG3Yt4Fq63+dR+tBoDlyHjGyG0zGxKweO8XSO+3oQlvEMwiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051522; c=relaxed/simple;
	bh=PgikKRs46m9TKHYsWtcHGXIrCkcscWlTAKZRcjtqc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhITC7ukXgdWbiJMjOB0yG0zSACB+cefx8iskVlsz/tqgXR5pE7KPQBUqeIyQByKpMJQ0hkS5CmcNMX8SjPBPSy8B93EZVFGevqZPQDWd6t8DXUAuFVp5gZVHtA2bw2cRO/JpC89+pLhIzc124OPum52ZlN5ZBnkiIEtDjtvd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RKhKlcM+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537IY6Vd016214
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 18:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CaTgF4a/34uclFeoWrPsrCmEq+pEEC8fdHAghCe2wqE=; b=RKhKlcM+kETrjZEK
	ii/p/I2zsOR5eV4qkbUZayHag9cccq8DlQ/ss0XDIHXyPLFijVzbVwboYSRHn/bF
	/4Bhh6C2OG9jyIEvc53xmttfM8K28dpYWCS8tCmSgevphF5IlTKsCk996YV7Ef+R
	V+u90ApRTSnVZl5H1/XxkDiOCwo1iw3S0Ss5EDGtRuOCOQS8l02hi3HUOzgGM3JB
	dF/9SyViyYyzIdmZt2wodBhJTwbpDqW1fLdGK7YjfZLTXVHSJmbVIW9gKIzLDIU2
	B6qanyKB/lWWlOeRkXYuSAX5w82eImG3NTKhl84G248pmuRHmedw+mAo2kcMTC7y
	I/hHlQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgd712-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 18:45:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-896c1845cb9so4170629a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 11:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051518; x=1744656318;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaTgF4a/34uclFeoWrPsrCmEq+pEEC8fdHAghCe2wqE=;
        b=fKGK+9+V99ZbhZ7EgfgnzFsSS9EtNeU0mmSRsXlBOJ8gmQPFS5//2hviTZKtMyrGPc
         lxtudkIu4/9rt2nYUIW4Rwx5J5zUdVTQ9zOXWtT78Jdo7ItlNegzGsZqlMRH7Chean3Z
         6iDT3My7jQVqk0YgiShu5xhgFkDxPy72323Nq+DLJIZGLXunoqjO02BwLmzJ6KO/i1bG
         cUmv+jA/9Zf23EC7mJg3CsaxK6oHKZHGXYGFkm6raM8wJEEm+AGzwuJzbit5ERQBLs27
         3cJKYc8wdrkJ9EhLQURSfYrKhyvMe8U1uMFbfwcCQ2ozPOw3dKlfIH7CGVvo9JpAKw+G
         kYKw==
X-Forwarded-Encrypted: i=1; AJvYcCVpGuHVUgweZTrHehTy/a36HutNLUSnWGpQHbrNQ2fzJ/KIYCN7Wlsmr52STHxILs50rVcDvXXCTaRS/sRXiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKlVQdSCCkXXyT61fLOAuT8G+THjfcIPgXj+lrswXL6JBwrCc
	0LYZZqbACM0Q7vtfLZ3i9sO8FWxmRZ0ijBahjFI9AKovKJCnEuekgYlWxwogcp+en0afbaCHN6D
	5RJ5GjwXJW920P3DqbNtnL5CS0cvKra4fkogY1j2NP1oyYojrY7N3SOHfY1gK/Su26Q==
X-Gm-Gg: ASbGncv8UbssWpKMuCaPz7TKnGATSna3eq5adFV8EA5ZbB9UcUlML839fessMKX5HI5
	qWEc3x26cdpguhIItSq62CMB/8pHPRCtuGAXo9lwpSbNUNJfQs7tZIqCrLGQJk3wzA8mYgCHUos
	JD6YD2DRKlVMX2JvYUKvBnDGfHSoBGUj1kUvn7mBgndeJBV/LvRUGzXRfOwBuP77kvoaFky4Ibf
	WK3Pl1vwIq7aC6eeS16twzDpLlCzlrMoNII43ugIozuoKWeF+4cU2mRymejLwlMuG8MO3+rdW55
	3nfy1W2iHXRPilHAaIvg9Ag0hj52mEMCFdFkBP4PnxUkgEV5XSAs1upGMg1+HWvMSnXM0AGxiz4
	MNUolLM+C
X-Received: by 2002:a17:90b:6cf:b0:306:b593:455e with SMTP id 98e67ed59e1d1-306d0be3b60mr680200a91.1.1744051517638;
        Mon, 07 Apr 2025 11:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH27ifd9SidaNf0mMnrpXJ3YfkJFEZ9H05V+CJJvNNT8LXGl1cdmrGIclx6qauZey72sUoYvQ==
X-Received: by 2002:a17:90b:6cf:b0:306:b593:455e with SMTP id 98e67ed59e1d1-306d0be3b60mr680176a91.1.1744051517273;
        Mon, 07 Apr 2025 11:45:17 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb90bedsm9449695a91.43.2025.04.07.11.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 11:45:17 -0700 (PDT)
Message-ID: <620d7c53-e8eb-4816-a9c2-d4bcd44b5d96@oss.qualcomm.com>
Date: Mon, 7 Apr 2025 11:45:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: ath12k: core.h: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <Z8-Snz86Xfwdlyd7@kspp> <202504071138.98D5B6E@keescook>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <202504071138.98D5B6E@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f41d3f cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=uvMg_fejPkrpZwH_nmEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pZ6Dk2rTILxloUENA7Epmw_nAyTRaTyQ
X-Proofpoint-GUID: pZ6Dk2rTILxloUENA7Epmw_nAyTRaTyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070130

On 4/7/2025 11:39 AM, Kees Cook wrote:
> On Tue, Mar 11, 2025 at 12:02:15PM +1030, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct ieee80211_chanctx_conf` is a flexible structure --a
>> structure that contains a flexible-array member.
>>
>> Fix 30 of the following warnings:
>>
>> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Hi, just checking in on this patch. Is some adjustment needed for this
> to land?
> 
> Thanks!

There is an alternate solution which should land in the next iteration of
linux-next (I just enabled the post-merge-window flow from ath-next)

https://lore.kernel.org/all/20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com/

/jeff

