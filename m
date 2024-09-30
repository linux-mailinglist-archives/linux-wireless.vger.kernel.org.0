Return-Path: <linux-wireless+bounces-13342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5A98AEF2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 23:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7181F225A5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 21:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5D18E031;
	Mon, 30 Sep 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OWoXBfP5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCAA17C7B6
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731289; cv=none; b=AaKYnJtqzDut/TEgOPOrqzgdV0ycZo5XrsLEVkLJjo2F/+fzxgLl/Z2/3efkEGZAyQ65n+aUWmC3cXgfKgMKd1sY+D5UoIKN3Iq7YVMjncNcnQMz9hfDm6ejom3OWJj8ionPYnMEVQmiYhSN1jymYTb9iq2a1I5HGEpc0NkyYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731289; c=relaxed/simple;
	bh=8bixiM5Oj4kMSK82BcEXhk/rH4DWNRr9AVnx/75pDkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t6Anub7It59WKU9qfQxyzNaGQYh1ER/V/i6nf7G9Tr1Vn5sBrKGmRvyoUx8QhY4MjhFKx9e0WSS26ocO076mQasoYeRpWBZwjTik2X52AgZv+ns3vhGKH9bhaZ//U2ZW+JmguCyACIiD0o+A3Yn579RH165R18pL+ebJnKucYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OWoXBfP5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UB5fjG008325;
	Mon, 30 Sep 2024 21:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NFxlcXRgHKQwl6FNEnXx9vGS3+IHH80cugczq/NoXIA=; b=OWoXBfP5Rqbugdcw
	yvgVtbnsqlWILSdgz6q6X0QxmqH6uAzUYkTZITNCYVjhb8BkehDRXmEU0FDyHHiq
	UJDTci+28cGztWHjiSvVfpDBSRBV2afi7AOMaQcbQi4MxsxWRfmgO8CKLylJBJZh
	Th0lMo3L0397miO15U4I5NvnspTicIrmFm5I/jn7zmoJODkkMBnqS19KSqoKINjp
	qW4Anbwgj89fiq36wWKCr7b+IAK4kIkTqKOQACm0EGzdAPVOCSIXaD2FDESZw9G1
	nf/TX+9GT8BQm9wVjEFl6fhsTKSO7Vf+JCKASFDoe9JP8BUphAG9en6DIUuOnUBW
	J1Zqcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9vu61p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 21:21:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48ULLMno017683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 21:21:22 GMT
Received: from [10.111.183.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Sep
 2024 14:21:22 -0700
Message-ID: <91b58719-3e8f-4a80-9be1-b998603244b3@quicinc.com>
Date: Mon, 30 Sep 2024 14:21:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240918212056.4137076-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240918212056.4137076-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IZILpXcBLoDjKOOvMBkxhNxidkg5gc8m
X-Proofpoint-ORIG-GUID: IZILpXcBLoDjKOOvMBkxhNxidkg5gc8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409300152

On 9/18/2024 2:20 PM, Pradeep Kumar Chitrapu wrote:
> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v8:
>  - rebase and resolve KASAN warnings reported by Jeff in v7, in patch 6/9.
> 
> changes in v7:
>  - rebase and remove patch 01/10 which was merged already.
> 
> changes in v6:
>  - Change comment in patch 01/10 to represent only AP mode
>    implementation.
> 
> changes in v5:
>  - Fix column length to 80 in patch 01/10
>  - Fix advertises spelling in patch 09/10
>  - Fix choosing spelling in patch 10/10
> 
> changes in v4:
>  - Fix ath12k-check warnings in patch 2/10 and 7/10
>  - remove "hostapd" reference in patches 2/10 and 3/10
>  - remove redundant prerequisite-patch-id's in cover letter
> 
> changes in v3:
>  - address review comments for fixing ath12k-check issues.
> 
> changes in v2:
>  - Amend mac80211 patch description as the patch is not specific
>    to AP mode.
>  - Amend EHT MU-MIMO patch description to specify future support
>    for STA mode.
> 
> Pradeep Kumar Chitrapu (9):
>   wifi: ath12k: push HE MU-MIMO params to hardware
>   wifi: ath12k: push EHT MU-MIMO params to hardware
>   wifi: ath12k: move HE MCS mapper to a separate function
>   wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>   wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>   wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>   wifi: ath12k: clean up 80P80 support
>   wifi: ath12k: add support for 160 MHz bandwidth
>   wifi: ath12k: add extended NSS bandwidth support for 160 MHz
> 
>  drivers/net/wireless/ath/ath12k/core.h |    2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 1052 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
>  5 files changed, 985 insertions(+), 208 deletions(-)
> 
> 
> base-commit: 92de67902177c2ea65000a87a6b24fed17d48a18

Although this series applies cleanly to ath/main, it does not apply cleanly to
ath/ath12k-mlo. So dropping this until ath12k-mlo is mainlined so that your
series can be rebased on that.


