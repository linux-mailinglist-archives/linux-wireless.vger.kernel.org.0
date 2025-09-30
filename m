Return-Path: <linux-wireless+bounces-27750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF3BAD09A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF747323BD6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7F2DF158;
	Tue, 30 Sep 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgeQOB87"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8A2F7AB9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238345; cv=none; b=Hv9yGgxV0vQD6oEnOfKANIDd9NfuSGsoqSx3vO+Rw5PJaNTub5c2eZFNIkGs3jKdqKYH8tf6Xs6Lrn1fbHHCA25fJUPxhVLEYcYJhKzuzl57jqfw6yTJTCcforZjM0/swwd4W0R8Ha1YxasExULNhhG4Nf6dVuQBEwoIbB1bcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238345; c=relaxed/simple;
	bh=QHVvuczASH6NuJ52NJiPVuljSxUgsCT13CT7Dn4GieQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1POnsAzjj6ypZMrOJ0ppSC7L18gjT4iQ4uXIahYs0K2HciJN4SKlYp5+3Ynjfclmx+fSlYlUpn+IXXCGfalJY2ZS1NEdC3px2bNe0SkZpKq3IjbGq8d32CbxH53833AC/pzxAFyo7dVoCG6U4LsWQIchf8YVuS8bDcPuBUeQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NgeQOB87; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBVsxt012433
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1UF3xPVizitXHcEN+gFFFp6aHN9M/76f8O6UvUpKNjI=; b=NgeQOB87nrQAOCKW
	Nyj5+k8+d8hnHfDcYkdyC6CjQECnNzWxuugTgJPXnE+k40FP7XZ/a6rsoCjZrLwQ
	EBkaMcBEMjO9QLGO/Yf6yOqfL2V48eJ8zMSfH9GVIQxu6WqfmjfWF2qL21L2O8V+
	s3ZHRubfWFn6gbAx+oxjLr6x1HpbQOe8QDiH1xvJR73F1LkRcFO1ObpnpyrWS2Qb
	6U9Wk1BiOiv6Ge0ZTtLQbaC+M7jpCH9xdyyvGWreE4k4tl072tgCWc2vRtk1nTx1
	nXNssUzWQ53BM+B1h1aTQEMcdm7sp4I/8JH5+PJ7w7tlfrFGGiA/iMIfCyXulA3r
	eEmcJg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a611sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:19:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78427dae77eso2507272b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 06:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238339; x=1759843139;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UF3xPVizitXHcEN+gFFFp6aHN9M/76f8O6UvUpKNjI=;
        b=Iyqdn5VIJ96v19y+SIay6wVuTbRzDwhq6aJAr8K6jgX7XQenGwhkBpZU23bjQly0xA
         qB56ZhIc9sQeG7vcAR7V8AMLX1HEAhPj0ZuYKuLIFn++DbGAy9y5lBwyWL4buc1nlUDN
         rpEsrkf/V7put/T5F+LhuwL8jx1CEAU7JYlWXrQS1IXcAuppJ/Tp2wGm/9UTNAdTBjYg
         ndW8Rn516VloSg+QcgjjBz9KKC8lC0SYxsQCWdDG6BZzKppaxAEuh3ZvjZjuthHIpJ3a
         3mWoGu48j2SzeOLCRwjVxPDtL8nDPX+YWFFENBLQ8szFUMCqO5Ads+6ZQoP2L2nuzTXy
         R5QA==
X-Gm-Message-State: AOJu0Yx93zczRfCWHPYqKoDBtPRNxu5p+Vw4/R2egaXMIbA5Ltm1m+gw
	kviRcSqlwDNXWtNmJFRotTmAPqidBWg9Ww+yzjDa8FYohkt/y2ilRHLsFSSt3aTxfyP7DAevypk
	ihwr+1tYVnlFIF5M3Ee+oYRCb8fAXW2DSdJB8g11015sUzasCx4wCiGo4ytqFMz+0g2dtdw==
X-Gm-Gg: ASbGncsLlx0Ku70N0qAL3zdbYnGrQjku2w/CFO+Q19lBuO1CUN3A1rIerpPBorJEOBx
	iHCR4wjDXOODBug803NKjSIhfne9gKKEtEIINz/bB0OYsTvV4S7z7aBHdX1yX1djH2U32wCb6Yc
	eWxvmKu8NHlTxX+SqvLXMVpv3BhsN0QfwdPx8mmg9a457e9JMhUKk9AMaGWEL2SXK6/gPNypAqi
	lWS9WQBxDkcbS/gXO6L/yiqdBrnnyFrR9I2kbzAOn8v+82FhZoTyW9Bcc8Z+ftzmq8wQtzDL7rJ
	yywhnhDKOiJaIT7TL969NhcFJt08iAImC8TEihXcxmtoWEvjlMb5fsrW/9ea5j7FaZyOyF5QE38
	F4XtAJ2OKLJtahJ7hWEQN2XOrL6fG2WRajlfhrlBYpvk=
X-Received: by 2002:a05:6a20:734e:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-2e7da45e875mr28048878637.52.1759238338959;
        Tue, 30 Sep 2025 06:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXByZqzBxvKKJLmwX8Ti+9nx4OdQkh6CDH5fI10SzUo2K2oW1vRRmLuDdghH3eTHG+u62peQ==
X-Received: by 2002:a05:6a20:734e:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-2e7da45e875mr28048833637.52.1759238338368;
        Tue, 30 Sep 2025 06:18:58 -0700 (PDT)
Received: from [10.133.33.195] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-783ad5e988csm6463432b3a.18.2025.09.30.06.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:18:58 -0700 (PDT)
Message-ID: <a4df6fd1-6ae4-44b1-8f3d-4c8ec23c4e62@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 21:18:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng v4 0/6] wifi: ath12k: Modularization of objects
 for Next Generation Driver
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250930131005.2884253-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dbd8c4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wCY2apRfTzfgVPxwIycA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: jOTVGFaptykDY2dU9kdQ62prLJ3mrHwv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX+Srqv97MfxOH
 do9WacREd4uyEW5YcsU/EYfYpIhsettF85mEWMHAgPt/4IqtZ8UA5I7J93kKY7h24SOHjc1d3ay
 zHGTqVZloko+7De3N7bN+7fBmpAfn2BnQ/GO+o7ItGRuAI132ZkVregEbZJehxrc5174dRPB55f
 jZqXOz3iBfyAfU1I2AQtIhy+X4mnbSnKeL7mJYMNbIyD0nsvy+511vySiq8VxzEGRksAyXfOw38
 kJ+7Z74TFKRg/MO8k5agjOJHO28UJUddOsdGLOeaNP9XAOPXzDTH7Zk+YPAB9Vg+mkVllakAkqb
 O3dB5iZ6iOpppIRpJWk96AztDtNo/nlDayVTaz7A6UCggbH06Ernle6/90wf0hXRtEBxoggLEXt
 BzI8B/cphtE+oTkJe/Z9GUyyEpj9ag==
X-Proofpoint-ORIG-GUID: jOTVGFaptykDY2dU9kdQ62prLJ3mrHwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033



On 9/30/2025 9:09 PM, Ripan Deuri wrote:
> The primary purpose of the patches in this series is modularization of
> object structures along with their allocation and initialization APIs.
> 
> Patches in this series are made to achieve the following:
> 1. Modularization of device object to have a separate DP object in order
>    to support chipsets of different hardware architectures
> 2. Refactor hardware group and vif structures to optimize data
>    path operations for future extensions
> 3. Add framework to support architecture specific interrupt handling and
>    ieee80211_ops registration
> 
> These changes are intended to provide a base framework for the data path,
> allowing the data path to remain flexible for future extensions in Next
> Generation driver development.
> ---
> Changes in v4:
>      - Use ath12k_dp_vif_to_dp_link_vif() in patch 6/6
> Changes in v3:
>      - Use dp arch ops to invoke arch specific service srng handler
> Changes in v2:
>      - Invoke ext irq setup/cleanup from dp device alloc/free to fix
>      suspend and resume call trace for wcn7850 in patch 5/6
> ---
> Harsh Kumar Bijlani (1):
>   wifi: ath12k: Refactor ath12k_vif structure
> 
> Ripan Deuri (5):
>   wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
>   wifi: ath12k: Support arch-specific DP device allocation
>   wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
>   wifi: ath12k: Add framework for hardware specific ieee80211_ops
>     registration
>   wifi: ath12k: Add framework for hardware specific DP interrupt handler
> 
>  drivers/net/wireless/ath/ath12k/ahb.c         |  22 +-
>  drivers/net/wireless/ath/ath12k/ahb.h         |   4 +-
>  drivers/net/wireless/ath/ath12k/cmn_defs.h    |  19 +
>  drivers/net/wireless/ath/ath12k/core.c        |  19 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  39 +-
>  drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
>  drivers/net/wireless/ath/ath12k/debugfs_sta.c |   3 +-
>  drivers/net/wireless/ath/ath12k/dp.c          | 145 +++++---
>  drivers/net/wireless/ath/ath12k/dp.h          |  32 +-
>  drivers/net/wireless/ath/ath12k/dp_cmn.h      |  50 +++
>  drivers/net/wireless/ath/ath12k/dp_htt.c      |  22 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c      |  15 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  20 +-
>  drivers/net/wireless/ath/ath12k/mac.c         | 339 +++++++++---------
>  drivers/net/wireless/ath/ath12k/mac.h         | 131 ++++++-
>  drivers/net/wireless/ath/ath12k/pci.c         |  23 +-
>  drivers/net/wireless/ath/ath12k/pci.h         |   4 +-
>  drivers/net/wireless/ath/ath12k/peer.c        |  10 +-
>  drivers/net/wireless/ath/ath12k/testmode.c    |   3 +-
>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c   |   4 +
>  drivers/net/wireless/ath/ath12k/wifi7/core.c  |  24 ++
>  drivers/net/wireless/ath/ath12k/wifi7/core.h  |  11 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  40 ++-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   9 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  88 +++--
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  29 +-
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  62 ++++
>  drivers/net/wireless/ath/ath12k/wifi7/pci.c   |   4 +
>  drivers/net/wireless/ath/ath12k/wmi.c         |   5 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |   5 +-
>  drivers/net/wireless/ath/ath12k/wow.c         |   5 +-
>  31 files changed, 849 insertions(+), 340 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h
> 
> 
> base-commit: 972f34d54015a4a16aa9e6a081bafabb6f9bf95c

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>



