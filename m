Return-Path: <linux-wireless+bounces-7407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20E8C1C54
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3852B282AA2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C913B7A7;
	Fri, 10 May 2024 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FO1atUtL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE833EE
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307400; cv=none; b=IgRBYUPc+fXhc2D7gEBn0xpsJoFWGbrF63TzxFSspI3HYpQOEJzel2kW/jGOQ7syPxWNvyj6FuWmeJlm1/Z+C6RtJMpxmWTUVfjFIZ1qjP7ZWd4ugsORNQUHoVash9ybr4+wSsMti/S0SwWTqfhWVFupfTfP6n3zzneO+9MYpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307400; c=relaxed/simple;
	bh=Sz9ic4xA8phfCsV3u0VriYa3qxxupZGeEopdydh49d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nBb/EMAizWWbBz68kpKOuPnm/48RcZh6phlw5wYNzYmqGXoNoG8gbC62My8A0nUaQNOz8ixmTEAtHWJQJgNe86+3qWjoMHneXsXbmWaOYztb6bt9JhIR7RHMFrJnheRvLi2g8ulObmA/aBjUciPKzdr08xJwoj2LqT3T+K1+7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FO1atUtL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1Al4V002547;
	Fri, 10 May 2024 02:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=umFSg273GRiYiXykMx/zI+GS5+NeuEZfrTB+UlN1tYI=; b=FO
	1atUtL2q4NBCiyVZpzViYdeJ2IePXot1VPpwM/PRC9L4xN3EGSr65mXJ8Z7HjrF7
	s/43jSrluudQGRlRriZNMrdMTGwW670Z8Cp+VoSRCbp+oB/5yGyJchl+Rcqxdu8l
	CAJZVmHkPDwwnSgN+VJ5kQ6+cpuAcAuC27NyBobnN55xXaBL5iLJVo870w95rvWD
	wHtm7rKsMls/cZpPpNUqUkDSv36MIG0H2/X1f6cOxBTeZLSTa3EfN0B1TWYRwOzm
	BRA9YuTEoyQ1RkD6NPPcjVAJ024hJt3IB0NjoxnWugDIyAYtaXhVpniCQmpZKE7o
	V87axwQLH/kAY77q+syg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w18bun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:16:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2GY0p026997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:16:34 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:16:34 -0700
Message-ID: <7d7701ec-c7c0-4bc1-a2ed-5d8085e7f534@quicinc.com>
Date: Thu, 9 May 2024 19:16:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] wifi: ath12k: Add ath12k_get_num_hw api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-4-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-4-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gWgcYx0Vd8c36ttgPPSXfpjpEwPYYh4R
X-Proofpoint-ORIG-GUID: gWgcYx0Vd8c36ttgPPSXfpjpEwPYYh4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=606
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:56 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, one or more ath12k_hw is part of device (ath12k_base) but
> in future, ath12k_hw would be part of device group (ath12k_hw_group).
> Hence, num_hw under device would be moved to device group.
> 
> To facilitate above transition, add helper ath12k_get_num_hw() api to
> get the number of radios per device. In future, this helper would be
> able to get the number of radios in a device group.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


