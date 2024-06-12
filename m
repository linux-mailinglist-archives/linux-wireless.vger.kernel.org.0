Return-Path: <linux-wireless+bounces-8890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE5905928
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 18:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B29C1C21D74
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832DD17D8B7;
	Wed, 12 Jun 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o1YZ/r38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A9181BA6
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211102; cv=none; b=CTg73astN4dqVhGJkPlOqaLKd+OSk2n1ggUittCdeuQCLHOJbAQyo1Dy+VG8P5UGvDI7UQFSwdbtvOH33FPgPiM0xA8a7TO4Htw7kzye7BhWAB3fSk5I2JAZiPc3DrDyGtYlvZ/wakP4nDEdNiYHcrfFO+13AI0XWvUHtuucoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211102; c=relaxed/simple;
	bh=eK4NbkS1xHuiWb44QQpk+mh06cmqZYsXP2MV+hXAQBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k8V1abz9XSGdLaGgsI9sFaUX9VkFuYn43EySNZqoArPeXK9/SN27jQZT2sj53xRbdQNV9ywOrdTsXFmVyLUfqz+qSC+BlXI9CnzioFKIO/Z/7mEbNdx+QwC+cps8N56H/h1YQp9tke9PsVdYdOQHcvu2UUn9HGecANkJ31lt01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o1YZ/r38; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CFND0m015964;
	Wed, 12 Jun 2024 16:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPOOL93oA55fvJx3l5V5jUffrMIfBbciFg91UPpmXiA=; b=o1YZ/r386P8jKT42
	YjVDJGG9EEqYVdz5WYAeLrT6CxRU2OV+nyfgQcwi27odhnB5JSDjJ+Sh+xtiRZyZ
	fg0dboMBFJ7jAPbmunR8u1VS9yXJuxZvTzBoaiSMfn4mkPhyzGKprR94wd45L5Yx
	BAAtozSIr2HiRAYMr+1G8XDzmUPeJw2MRu/stNVGKUbih/Ws+KpvbzXILu8q1BX0
	QrjtlQv1qGc9QpDmtZR2DPIFJKu5Tzw+1dJwFurvoeh00w/GRkFOqdM0eCFX9A7o
	BbezLXPhL54smjCdrxZQd9XTLX/9rNW++GRr0pK6aOBGHSwF8ZWBKZ5t1U7wicnb
	blgc2A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqe93gay2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 16:51:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CGpXZi026441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 16:51:33 GMT
Received: from [10.48.243.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 09:51:33 -0700
Message-ID: <cd77058f-7165-4342-893b-a59a3a18c3c5@quicinc.com>
Date: Wed, 12 Jun 2024 09:51:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] ath12k: Factory test mode support
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CarHVmVqP7xmin0i_6Pn_3dCn7ZD5GSs
X-Proofpoint-ORIG-GUID: CarHVmVqP7xmin0i_6Pn_3dCn7ZD5GSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120121

On 6/11/2024 1:34 AM, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> Aaradhana Sahu (3):
>   wifi: ath: create common testmode_i.h file for ath drivers
>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>   wifi: ath12k: add factory test mode support
> 
> Rajat Soni (1):
>   wifi: ath12k: Fill pdev id for fw test cmd
> 
> ---
> v3:
>   -Rebased on latest ToT
>   -Updated Tested-on Tag
>   -Removed second parameter of ath12k_core_start()
>   -Updated copyright
> v2:
>   -Rebased on latest ath ToT
> ---
> 
>  drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>  drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  13 +
>  drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>  drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>  drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>  drivers/net/wireless/ath/ath12k/testmode.c    | 422 ++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>  drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>  .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
>  13 files changed, 634 insertions(+), 74 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)
> 
> 
> base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6

FYI this series is not applying cleanly in my tree for validation:

Base: using specified base-commit a116bf2be795eb1db75fa6a48aa85c397be001a6
Applying: wifi: ath: create common testmode_i.h file for ath drivers
Using index info to reconstruct a base tree...
Patch failed at 0001 wifi: ath: create common testmode_i.h file for ath drivers
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: drivers/net/wireless/ath/ath11k/testmode_i.h:4
error: drivers/net/wireless/ath/ath11k/testmode_i.h: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

I initially used b4, but tried again directly with git, and it failed for me 
with both mechanisms.
Kalle, do you have any issues with this series?



