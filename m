Return-Path: <linux-wireless+bounces-7057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BD8B7C7F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DA91C20128
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA91527B1;
	Tue, 30 Apr 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOp+44uR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E6770F5
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493292; cv=none; b=OmOF1je3EBuR65Kobuu5dr4ZcYGgF0pkaeGptcW6O1ciLkA+DJ2PmVFN5EfeFWOdchNKOpvjxAhcaq2l/XKrvhXdl27ZZohIFHwNtEXJG72jp8vKneea0x99XpSoa2UFNcAHadMXx9KjJ2EPALpzC7geEgUKYGacg3fe+mGiKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493292; c=relaxed/simple;
	bh=b8WSAzOrhR6CioalFJnWiEK7scJ+EzyroCBTXha+0Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YVPxOgDBASGWXpiiE9JC3vxo1e1JiYfGF/Q/NwcOo8H1pshBvPsp8fHk5+z3269ScynMoPGSLgQnSSCL/INW+LQ/OAFth+DgnZYHUYCYy0IACoZhuaNlcp26Uv/ezI07Rvm1fE/d3nfIVKYNbbvZi6kRn7dpkmHD49pJRS5VejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZOp+44uR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UBLQe8005826;
	Tue, 30 Apr 2024 16:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4gcdE53NTXRPWhE6gsy1Z0IeQnrLnMuqLbdz0kglihg=; b=ZO
	p+44uR00ws1dc95BJkf5C1CbwAH3ZEkdzXLBno8t2vdERs4Qcqpd4347LtFTHjsz
	pPnp9thc5uUU/wJ0005QLHjEpVBCi7SMgr5l0j0PQs1VoeFecWpY0wVSQ+gqSp3i
	mu9kHxe+exugu+V1XWRG3MLqHq/19bfeISBBqTMGPjxatjWmrZ7hrzF65KNjAou6
	Mdb58iQapL4tJy9s/UTfiil4EeOpGh4KxKIw5k5W8RJZc9LSi2VXqrl6Fqv0aJjo
	SJ2AyVfwIfKH6f0B2ukfcFAfD8yhi7NH2RkjEAAclZp7RCr1RCQPefOGkqBLWyd8
	TXIPTw2/noKFZDIDxFsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtyptgqjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:08:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UG83cs027891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:08:03 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 09:08:03 -0700
Message-ID: <3a42a9fb-8528-41fd-8c34-f2d9e13bc1dd@quicinc.com>
Date: Tue, 30 Apr 2024 09:08:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wifi: ath12k: Add multi device support for WBM idle
 ring buffer setup
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430054759.722620-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430054759.722620-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j8733fhB__FQfGGPVx9da1uS21DgGBZa
X-Proofpoint-ORIG-GUID: j8733fhB__FQfGGPVx9da1uS21DgGBZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300115

On 4/29/2024 10:47 PM, Karthikeyan Periyasamy wrote:
> Refactor the WBM idle ring buffer setup to scalable for inter device
> multi-link operation.
> 
> Note: This patchset rebased on top of below patch series
>  [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
>  Link: https://lore.kernel.org/all/20240425055759.1181165-1-quic_hprem@quicinc.com/
> 
> Karthikeyan Periyasamy (4):
>   wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer
>     manager
>   wifi: ath12k: Refactor idle ring descriptor setup
>   wifi: ath12k: use device index to advertise MLO parameter
>   wifi: ath12k: add multi device support for WBM idle ring buffer setup
> 
>  drivers/net/wireless/ath/ath12k/core.c  | 10 +++++++++
>  drivers/net/wireless/ath/ath12k/dp.c    | 27 ++++++++++++++++++++++---
>  drivers/net/wireless/ath/ath12k/dp.h    |  1 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c |  5 +++--
>  drivers/net/wireless/ath/ath12k/hal.c   |  5 +++--
>  drivers/net/wireless/ath/ath12k/hal.h   | 21 ++++++++++---------
>  drivers/net/wireless/ath/ath12k/qmi.c   |  4 ++--
>  7 files changed, 54 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 861928281f22a08e3d258ebcfe7159d729ec07d4
> prerequisite-patch-id: 4bc84a4f5b10ebc28db60c5167abdaf343a1619d
> prerequisite-patch-id: ea87d2f46dbd5e7c82d5df02934906e219aa8388
> prerequisite-patch-id: e08d8632dcde9e891d37b538832b4ecfed140d9e
> prerequisite-patch-id: bc2c9455c9175c27b8b68f6f41d468b258007478
> prerequisite-patch-id: 00966c65589af8a50078fea94630cbe355f0dacf
> prerequisite-patch-id: 4bd8ce903cd89ae536109922f65f128ed1d4307c
> prerequisite-patch-id: 54fe8eb540a77804c8befeb695b61756c133b56f
> prerequisite-patch-id: 06244ca08d9bed3834dc5315470a19d096d749ee
> prerequisite-patch-id: 8e7575808b1c498d81b606777153e0e2d4ee99bd
> prerequisite-patch-id: 1baa4ce64b2054e82e117cfbe29f85870def37c7
> prerequisite-patch-id: 733cb4a1e0d02079820d8306a3da88fe2d35b06c

My automation can't test this series since git reports:
fatal: bad object 861928281f22a08e3d258ebcfe7159d729ec07d4

Also note that the "device group abstraction" series itself has dependencies.

Using a base that isn't visible in the upstream ath.git is not helpful

/jeff

