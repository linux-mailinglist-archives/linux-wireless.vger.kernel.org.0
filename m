Return-Path: <linux-wireless+bounces-2746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B030C84187A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4122839C6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815B1E4A7;
	Tue, 30 Jan 2024 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QEkky1C5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4294360AE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578806; cv=none; b=OjgKEnp+kEwGCCAEH5uqkqgO1xPuv8LPVs+oOahnYc2jmOplMvPHHehH6VAxC+uHThfM1Uk1ToQrVar40Xkjp6B77DCy8AWAkXZQuie+nwXk5f+baGkrgaEf3HL26v51OgTswuG3pPAHn+7HOKXBO8UNE6ceFm96sz50CjThx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578806; c=relaxed/simple;
	bh=yXrRslj1Xlgn4XOVmECmzTqfqBWFB+m+wKJ+oK/DYss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KlZg+FYiJ32/ll7qPlcehqF8qJEaxHN2hf0mQrydmyHiFQ7lDmv9rVqJDyz/EM+ybuQzFFNlYsaxFkaAa/vcIWAbeNZrHp8ru86fS3SV6Sx+zgWtKGQ4DCJt9+dDCltMlNc3PKlxkU7FlcNuOsGBydiJdnLvQhURAlCVUCLWs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QEkky1C5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U1VjM9021696;
	Tue, 30 Jan 2024 01:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZPtRUycgAa9lXETMoy5ixhUG1iXxm5wZI9cIOjvtUzI=; b=QE
	kky1C5MK+5C2rH0uTlSfAylNxM+0hM3PUObLpXu7mfbSIwH673acwaLOK86LvB7s
	vj4HHA3Yrxa21rTnbELlTkejSnKnoX2FyqyEek9fkse5UK4OVi9u4b9ZA/QoY58c
	02cxIzxTRrcFEyCcyH08xwylo951WSueuSc1PM2cmgWSKDWFn+CNx4Ue2DneEdkX
	vxFdzom7mIhDjNGNXlKfVe0GxbtbRtfX1BtNhfM5mSdFDqxqvA1RlCeU++vKxzsF
	/mT2Tk+IEjjIWw6R1H2b2eonGXMsypwDLiKEbMIQ/OzB0jHsDjQzdTo4dFLVeA5L
	xnCaa2aeXplQkf7Smb8Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86htbsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:39:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1dtiq030169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:39:55 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:39:55 -0800
Message-ID: <c48df22b-e04f-4c51-bb7d-36eb9b2282af@quicinc.com>
Date: Mon, 29 Jan 2024 17:39:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] wifi: ath12k: fix broken structure
 wmi_vdev_create_cmd
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129101453.368494-1-quic_kangyang@quicinc.com>
 <20240129101453.368494-8-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129101453.368494-8-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -SXh-Rn9hPUHsXF7zLkEUB409_7Iz-h3
X-Proofpoint-GUID: -SXh-Rn9hPUHsXF7zLkEUB409_7Iz-h3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=733
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300009

On 1/29/2024 2:14 AM, Kang Yang wrote:
> Current structure wmi_vdev_create_cmd is not matched to the firmware
> definition. So update it.
> 
> And update vdev_stats_id_valid for vdev_stats_id.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

FYI IMO this and the 08/11 patch should go first since they are fixing
pre-existing code independent of the P2P feature (the P2P code just
exposed the flaws) -- hence why I'm ack'ing these first


