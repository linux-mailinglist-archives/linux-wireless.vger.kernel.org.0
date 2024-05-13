Return-Path: <linux-wireless+bounces-7603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D298C45D9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839FE1C2252E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0692233E;
	Mon, 13 May 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z27/Xl2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0122339
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620649; cv=none; b=ZiIC+sV/cgtCqW/T4eb3EKGJG/yfNEHcftVwbjSEqN05ud2s9Im29LbPAeBQXOR7NSDju68RhKzM6YS9aoJ2zP9XWaFjCaYoVx1tWGJVq6rUlKaFkCvzpvZkNOH31Yc8NgtdosE8tHE2aIT37CxpoI8KKCupds9GBYD7QYj27XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620649; c=relaxed/simple;
	bh=y2ojy30QoRvU6y0azCJXoEyE5z63pt3w/fjJQQGP5DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JS4PqebVYxo0AqarRfniAgoX2s6nSZbJgeAw1VMUh2vkeu/kq6l/vYM8307SUdnLS6yFQF5NnP9bvSezXLkQXDPqsy1MMcm0FiOj9ekCbLK1bfa1j5wBqxvqYLQ8OW3O/9ViRSj7HYLZF+LpLn8V6Lt3qwf2FbLQevydFiYSr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z27/Xl2M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DCYAHA029260;
	Mon, 13 May 2024 17:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=I/dQG5q46d96/RraF89SE7oBLYzNSXOi4gxyHcJ0M0U=; b=Z2
	7/Xl2MSai4GNig5+t2EavWdO0xmvQ6KOScHJjl/VBzP61PqXGC09YijF2noYGxgI
	ysodjI5t6fDm6G0S4ZfsAixdyFcoFu+m2ACXVs/JeBOR7JjwRdApBsEQM82K5vMB
	atQBbk88WHHeu/3sBVoIlkM8vlg23DDnh7TBQMJtuNUU4+zbQtkw6+/KsjrwPMR9
	1nRzVkw/d83ktBH9AvYNJf2Xtzv/NgSFPTUPFzxAoLs7AOUhEIvDdQJDP3eGpoxE
	lCbWLExFmtCiJacACCANWA7s1F//pCcHZtglICpbWpwMsSARTvr9z6KznZwJ/hh2
	NhbxfORnIcwFbTlfB2ng==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21edc26r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:17:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DHHLNA031990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:17:21 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 10:17:20 -0700
Message-ID: <b69c3612-3d9c-491a-b98c-03b9997654d7@quicinc.com>
Date: Mon, 13 May 2024 10:17:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add Dynamic VLAN support
Content-Language: en-US
To: Muna Sinada <quic_msinada@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240506231752.942567-1-quic_msinada@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240506231752.942567-1-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OFoCWF-SWYAPTUXZMhNmAhryJ3tdy6kB
X-Proofpoint-ORIG-GUID: OFoCWF-SWYAPTUXZMhNmAhryJ3tdy6kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130113

On 5/6/2024 4:17 PM, Muna Sinada wrote:
> Add support for dynamic VLAN. VLAN group traffic is encapsulated and
> encrypted in mac80211 and driver needs to set flags for the VLAN group
> traffic to skip hardware encapsulation and encryption.
> 
> VLAN group traffic utilizes ext MSDU and HTT Metadata to set
> encapsulation type to RAW and encryption type to OPEN in order to
> inform firmware to skip hardware encapsulation and encryption.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>

My first test of this patch gave intermittent connectivity, but a second test
didn't show that, so I think my issues were actually with my home router.
So giving this:

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

However I do have one question:

> +struct hal_tx_msdu_metadata {
> +	__le32 info0;
> +	__le32 rsvd3[6];

why not rsvd0?

If that is OK, Kalle can change this in 'pending'

/jeff

