Return-Path: <linux-wireless+bounces-2842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B52A842AAD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BB6B214F1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E163129A87;
	Tue, 30 Jan 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f9lpICob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A012836C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635151; cv=none; b=s0vG85I6qVucF5u57oO6C6VyXnBtoxY6t623eDZOa76LEtZGLYVo2D5P9GvhwltVm/OA6wjJMEIyjCn7uc+R98AqboragZlsQOqtvbupKnhtrkzpujLQ/5Gnr0Qm7jCqvMf4MZUrjLKzriG2/nto+XpEN9xGhSkQwj7aUIq5/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635151; c=relaxed/simple;
	bh=bHw9CUCd59RkrH2nD4zBVj9dC3roXFao/X5QufVKfVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6h0DRZa9ciDcLeFA2fcfw9Hs6OCFiTwJzS715/fx3KhI2Ps6c6b51tfGksKDAsZ+CFN+FlwVxE4ePyaNfeAWHxZICsjS0sAY0r67cJWzTalI7DXM8tNlZ/zcTILTBkowGqlEQn8/xM0A0CvaYjeH+n9lyTHiCKSG+S/nFLhHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f9lpICob; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UEEh1K022856;
	Tue, 30 Jan 2024 17:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N0dBUJdr/gkAbZDnoxlz/C1JUW2fjuwJk7SMDzlUC+g=; b=f9
	lpICobsSL1opP8SbwbHP0kN1s7v4jkJFPM9KHfAg6g/qC8EpLO2+NdvB0Ee629H+
	o8Whc2iUHk8D+EYiLZi10FiJmGDGneikrUK7jEhN1jd3KNqZ119NcwN5CrJI6PXw
	N23/x1afcQ2vVj4fpody70quFDj4AWkDSR1CQg2p0obA9K17IUYGc7oasEILkOzH
	vhctDUVwzCARD+lGcxzxmG9eZ8x8UjRctoq7tf6Se1y4lLkfJV69hN2R4Avl7/Tq
	cV68WLIS9XAnkwYKW28p27128DhalTVOje8/6yQTTLNLm0vfAsr2Yz/D2eMr+Uw2
	K7TAPMMn7BN3KDVR7yHg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxtp31key-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:19:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UHJ4x8013815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:19:04 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:19:04 -0800
Message-ID: <954b9ad2-be0d-4421-b20f-5b3e48dd673a@quicinc.com>
Date: Tue, 30 Jan 2024 09:19:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN
 from 256 to 512
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-8-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-8-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F5A3yNb8h44Rk8hfgHaaV_j9guc5OOqZ
X-Proofpoint-GUID: F5A3yNb8h44Rk8hfgHaaV_j9guc5OOqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=849 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300125

On 1/29/2024 8:02 PM, Kang Yang wrote:
> Mac80211 needs more space for P2P scan ie in P2P mode, 256 is not
> enough, resize it to 512.
> 
> Also delete the duplicate macro definitions in wmi.h.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


