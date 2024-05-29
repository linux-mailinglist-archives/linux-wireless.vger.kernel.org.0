Return-Path: <linux-wireless+bounces-8275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 462148D3D1B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C83B22C82
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA17184131;
	Wed, 29 May 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fIh9l1GF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACC156978
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001515; cv=none; b=UP8CWhDyXAvcQrArrJ123XQyjSWrDlIhMqjUPqBnefaeZh7N8kkwuyaF8sSdEpmfNQBPTDfPcWjTlHdfuQm3gTmtx6P9W+djag9fn04PBXf0QUAHA1YvjOtVL2HZ2PguDMan4Z2O2ZA2AFD0faRPVZ5RJg4BSkOETigHvhHBx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001515; c=relaxed/simple;
	bh=Wq12HBVQXGP7K7mAY3Jyuwiwg/6S7qFDbj+UYoCBRao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bXiAINUcXZZDuOVt1nsutPo+k2epVabzmVcn16ufVKIvdjDS8bwT16M4bavtcorEHptKyrEJD3thseNCCdECMBxCQDFeQXTJcsCOOGEuFOdwF6CO251QtSjrnxykLz30MH2b/hwU9upYQsqeFxGtrm480RFDyRNJqPnHY1ExwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fIh9l1GF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T9nOtS030893;
	Wed, 29 May 2024 16:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	urZPuhE4Ze5SpqIR+pZW/zf0Jx1npbUKRLTd268UZEo=; b=fIh9l1GFp5hxam79
	EQ61S8/UZZgtiEWbVLQ9VUSHkV0TM64tFKQkxAKwU5ff8M/aEUv0BOBIZvDCgcAc
	wCOYUpVMVoAFngAwQO26ra8rGlfbTar3z7c4b00PGLYM3RqzjvajEF0FHSWBmDl3
	BixX8Ptlv0V2bSaB3IRa52Vx1kMpUTDJ5Ut4PZRAj9jc/l2+tb//8vtmDrsFdhFD
	Z3HTL1dYT472RNoW8vmBAWyPga4LTqB6p2606qyQtCOT2xZlbgLuRl5Lc/bn5ijw
	6ZG1WRs5po4i2sJ8iKZIthnclq5PM0Mx/nHiaRYMzL0uScnQmqzXI2q3Wrmy7lTI
	eDXn/g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qhhsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:51:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TGpk0u014547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:51:46 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 09:51:45 -0700
Message-ID: <392f51d7-0831-4d77-9adb-1c2e84e0356d@quicinc.com>
Date: Wed, 29 May 2024 09:51:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Remove unused ath12k_base from ath12k_hw
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240529060939.4156281-1-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529060939.4156281-1-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RxnN8m-T-UQOvXE4Mb5Z3kT-W0FIlJeS
X-Proofpoint-ORIG-GUID: RxnN8m-T-UQOvXE4Mb5Z3kT-W0FIlJeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=838 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290116

On 5/28/2024 11:09 PM, Harshitha Prem wrote:
> Currently, device (ab) reference in hardware abstraction (ah)
> is not used anywhere. Also, with multiple device group abstraction,
> hardware abstraction would be coupled with device group abstraction
> rather than single device.
> 
> Hence, remove the ab reference from hardware abstraction.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> ---
> Depends-On: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in split-phy
> Link: https://lore.kernel.org/ath12k/20240529034405.2863150-1-quic_aarasahu@quicinc.com/
> ---
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


