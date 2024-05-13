Return-Path: <linux-wireless+bounces-7617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3D8C48EC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 23:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F7AB23D3B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2F8593B;
	Mon, 13 May 2024 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FYeJDCGx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080378593E
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636052; cv=none; b=rFlEcaITUzwptSx4t6yN8a2FV6Ikg8IFNn1dpujkXxNmOCIdqw4ALgj97WNsYb/5VpcUPNXVt/F1ILe2aJ+kgz97/MZQZ4PszTRHAPMoCbIzWOsNWOMECe/91XyrnP9h0DieNlWgeLQsM92CAp+QQFrLS/CXvmtkQF5j6j0dgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636052; c=relaxed/simple;
	bh=uy7RFPlXmzeKGXr+HFRZozIM2EiKGrLqOOoEIXK3sx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sMRwDn0ustq4d2Ok0Wkk0svFcJATAPuevkid1+zhGs93ZG6ko43SQwPVzS7roA9MGwR2jZO1XEgE2fxAFvOPKBBC2FPqG0lbVDWFyUn+Y4TQ7j+dxASL+PUWSfmu5VfLtCPSVu0zRT4gbsTlGtWybjs1DL9XRjAFB47aNRoCS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FYeJDCGx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8vtf003187;
	Mon, 13 May 2024 21:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bzX8ezWmJu9SVh10wVS08QblP+e9V06MlCpSSPnTQ5Y=; b=FY
	eJDCGxZgKnuwRUh+HdcsnzTChEZj626JdydNXHxATkOncM79ROLkMIuCjW1L1DxN
	Yb2scJ0aUzh1dW/bUuGe39z38DiBAeNPVH/OQ2E8ukzGLWV8svl8vtI5j+8it3e1
	afwzdS6+PXvhGuo3UcX6Q64Y+tUgQiJuDJ7ap143vIGec7uWGZg1zH3PuDb2EnMa
	Zv1Uu3ihS/BXSdtsORoz7nhrCD1TQthVlUxq+KvDWjQjOVUsQ6XwXjo5mCHfxZeW
	/68CVJi85sWdqyfHE7i5dd9qMEzT+x5vZrVSad6p2cvxTpRQ97W9fUQiT53VEXkD
	gse2XchqRnJ+v+XnH1sw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21uhcfxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 21:34:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DLY4LI009158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 21:34:04 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 14:34:02 -0700
Message-ID: <a9d66ca6-fcb5-4bf0-abc5-e483518eecc2@quicinc.com>
Date: Mon, 13 May 2024 14:34:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
 <20240508173655.22191-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508173655.22191-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8-FQn34eFEZMPeK_VMjvh0mYtyighwal
X-Proofpoint-GUID: 8-FQn34eFEZMPeK_VMjvh0mYtyighwal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130148

On 5/8/2024 10:36 AM, Pradeep Kumar Chitrapu wrote:
> Parse SMPS configuration from IEs and configure. Without this,
> SMPS is not enabled for 6 GHz band. This is disabled for
> WCN7850 as hardware does not support it.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


