Return-Path: <linux-wireless+bounces-13963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9199F2DD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2501F21B57
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E131F6699;
	Tue, 15 Oct 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mgLejmyG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5F1F669D
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010293; cv=none; b=lsOEO3LY0B0EJ5AMjqlDus46gJ7VL4DJWM0jiIPkBECTal4fz4YQEk5zGRb0DxtJC6urTsYevWQ5tiEBuOp4mAjvpTAQExrOBxGN0xUnEPuUBE4JF1s+EJxJTaBBGb9ZHZ+V6DINL2Ed0XgESqtO1OG6lPp2pNIHIdh+/UB8dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010293; c=relaxed/simple;
	bh=GN7CgCU08n0fxts5taQSsr3W8qMB64TN9B7PXpr8lOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m9NVP2ApdK35oXQVpE3IBrljyZDJwtbxkHjxyQEImUaOAV1g4rtfNfdxcY1U3dA+YX0tqvA8uPSS0WaoR3cfz5FSRQbvfAHQTT1Rca5ndxlz1zVOwfUvqabtl7yaXLC03WELH6E1UDo3UUJtbHTh86pimTsJncT+p6vTgvg0Cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mgLejmyG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBS9le031245;
	Tue, 15 Oct 2024 16:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TjKsJQOKyMHGX3oDEW9ZILq+YlIuJebWQPFLX1vJYQs=; b=mgLejmyGhKpCjzLK
	cXmJ/jSudOUR478ZzQD1T0eZsto6N1v3GAtzN6lq2u31xo/iOLnPFTuyejsSCLZ2
	G4kocDeUgxXW2lmBbG4B3BEhaP9xF2ljU4wsmZ1CyUcpc3E0OvY21zRhzdNjnqH3
	KAr+LitNBCsuJTrMna7bJUTcyJeq1IGZvJQXKY/KWc7o5PatCG9mcn6BchTQ1gqh
	I2aVEPvXB5LdhNuVslIA1vvLwIo4OPPpUEU71cd+224i7zHawkxllK4ebHo2OYxD
	2qQ2HbeAnEjeosKLx3p+vMzlBy6eRZp/iicuc+NJkanV0qih6dOeRw1Rc+MOj+dY
	xOpPaA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd906mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:38:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FGc7Ke010969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:38:07 GMT
Received: from [10.48.240.238] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 09:38:07 -0700
Message-ID: <81f38361-b289-4fc9-8be9-f1fa59195468@quicinc.com>
Date: Tue, 15 Oct 2024 09:38:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] wifi: ath12k: add 11d scan offload support and
 handle country code for WCN7850
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241008065638.1142-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241008065638.1142-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a1fOGpro587Nu0omuyeIO-zxxZAXqgV_
X-Proofpoint-ORIG-GUID: a1fOGpro587Nu0omuyeIO-zxxZAXqgV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150114

On 10/7/2024 11:56 PM, Kang Yang wrote:
> This patch-set is mainly does four things:
> 1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
> 2. Implement 11d scan offload, and report country code to firmware by
> WMI command WMI_SET_CURRENT_COUNTRY_CMDID.
> 3. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
> 4. Store country code, and update it to firmware after device recovery.
> 
> With this patch-set, WCN7850 can do 11d offload scan and update country
> code to firmware successfully.
> 
> Note: This patch-set is an old patch-set in public review written by
> Wen Gong. Just resend it for him.
> Link: https://patchwork.kernel.org/project/linux-wireless/cover/20230914090746.23560-1-quic_wgong@quicinc.com/
> 
> v4: rebase on tag: ath-202410072115.
> v3:
>     1. use wiphy::mtx lock instead of adding a new lock(patch#2).
>     2. rename struct according to wmi naming convention(patch#1, #2).
>     3. update copyright in reg.h
>     4. modifiy patch#3, #4 due to struct name change.
> v2: change per Jeff.
>     1. change alpha2 length from 3 to 2.
>     2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.
> 
> Wen Gong (4):
>   wifi: ath12k: add configure country code for WCN7850
>   wifi: ath12k: add 11d scan offload support
>   wifi: ath12k: use correct WMI command to set country code for WCN7850
>   wifi: ath12k: store and send country code to firmware after recovery
> 
>  drivers/net/wireless/ath/ath12k/core.c |  34 ++++-
>  drivers/net/wireless/ath/ath12k/core.h |  17 +++
>  drivers/net/wireless/ath/ath12k/hw.c   |   6 +
>  drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
>  drivers/net/wireless/ath/ath12k/reg.c  |  70 ++++++++---
>  drivers/net/wireless/ath/ath12k/reg.h  |   4 +-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
>  10 files changed, 480 insertions(+), 22 deletions(-)
> 
> 
> base-commit: b9545f4570fcfebe982439de7c9106e55b4bf756

using current ath/main:
Applying: wifi: ath12k: add configure country code for WCN7850
Applying: wifi: ath12k: add 11d scan offload support
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.c
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/mac.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Auto-merging drivers/net/wireless/ath/ath12k/core.c
Patch failed at 0002 wifi: ath12k: add 11d scan offload support

Looks like this conflicts with Kalle's locking rework, can you please rebase
again?

/jeff

