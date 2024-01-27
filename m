Return-Path: <linux-wireless+bounces-2587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447883E86E
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213FB283289
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE91C2F;
	Sat, 27 Jan 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FGwqrqcB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5E1371
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315115; cv=none; b=msVKAluujjL/rJge9QvslAGjSHGGkgrCp9tqsXwgpzhXYIJNXtkShyjl78MCLyzRhcGf+2QFwdLkA/jsW9TyDavcBIgY/vi5koYIWU+9YPFYPYhdEs7rTDA2FMOV8BU7InzydMFFC7nZARZXtSmLO2uPRKEJpvLVWXdHeUZSqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315115; c=relaxed/simple;
	bh=nnEClQ8tVuPDUG4+SvjditLdWSmgyQI2zT7G9q+TiLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SqAuS6feHGcWtMuvLMbg7f9dP9HiNwF/NavIyib72BLOgfZtEvPamawoxP3bhbA7msDi6NryuuJLa/VxSefub7EAHQ4RlYVjzdv8UMmMCyfEFI/Cx5bHn5lOetRQyoHFQz+4GKmfU4lYc2gnw+wwi11YkDz6G80JyWhDAngmrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FGwqrqcB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R0H0Qq032394;
	Sat, 27 Jan 2024 00:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wzrm00QaGunc+hQJiP1hfEkIfsiOnqhKHNOlWdLK098=; b=FG
	wqrqcB4Yzo3R2VD7qXbPG3H04dZb2Eb629UG8iaKoFGwucdXmc8ts7bNSs/qrldq
	vqNqcSkYr9Hq1hRAH1Mj2atv6poopIxC5rUUUKhvtAIL5g+QAeMDZ6CyIlueuQUr
	Pan2m4wdOtm82WE4l7zYANvjeUmlghL6TsqKaxOROeJrqKRMFntDE60Whda2RpIy
	6as6uwPR3NM/s5sVJCT8mhFKVbMlPa71+vL4YrD3VwQIUpinEOLRZ8i2VAvm1Feq
	bPcslPgAVfY1Tuculg75HMeNaCAcwu4xqbQGGAlwIy2uvE6syIwKHb9eeD/EQ6Yt
	2MwD4dohe2HWPGNi3UUg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv6c8j7jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:25:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0P9R9011190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:25:09 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:25:08 -0800
Message-ID: <c3479244-4e12-451c-a20d-d1323e93056a@quicinc.com>
Date: Fri, 26 Jan 2024 16:25:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] wifi: ath12k: move peer delete after vdev stop
 of station for WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-9-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-9-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pN3LYMTnuCxZmrZrrwQoFwvHcO7bntp-
X-Proofpoint-ORIG-GUID: pN3LYMTnuCxZmrZrrwQoFwvHcO7bntp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=883
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401270001

On 1/26/2024 3:52 AM, Kang Yang wrote:
> In current code, when STA/P2P Client connect to AP/P2P GO, the WMI
> command sequence is:
> 
> peer_create->vdev_start->vdev_up
> 
> And sequence of STA/P2P Client disconnect from AP/P2P GO is:
> 
> peer_delete->vdev_down->vdev_stop
> 
> This sequence of disconnect is not opposite of connect. For STA or P2P
> GO, bss peer is not needed by firmware during handling vdev stop
> command. So with this sequence, STA and P2P GO can work normally.
> 
> But for P2P Client, firmware needs bss peer in some functions during
> handling vdev stop command. The opposite sequence of disconnect should
> be:
> 
> vdev_down->vdev_stop->peer_delete
> 
> So change the sequence of disconnect as above opposite sequence for
> WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


