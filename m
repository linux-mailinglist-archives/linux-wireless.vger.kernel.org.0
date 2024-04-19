Return-Path: <linux-wireless+bounces-6581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44248AB11F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A9F1C212B7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AFE7D07F;
	Fri, 19 Apr 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iLxXh+7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064311E893
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538540; cv=none; b=KK0uoAiDmSKzNz34CE0Tw7hXTRlmy+BjRMxSwIwc3dm8gvirFMEh1Jdu3jkRut0dN7FwBa/6XvJdyEqeEzZJ7Q252QvP4s2pYV9BEi4zdVzCd42Q39cWkSrf8XeQPY8Nwy7MDT8H6+gOPejvgab0Io2s9E8Tzd/cErK+WFSxN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538540; c=relaxed/simple;
	bh=0hcIcUKze4R1wuJRxi0X3zSgQeFUd1Gg3Gz60B60xJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MQJ1slo8NJYatMh5z9gpTYhyOzSpPvQ1GOUa+nfyEgKEjZ+eI78FCweqfrxifhFeCthEMzc5+YZEi1m8mOVmU7iXnzCgBeYFtekaTcJbckS1zmV1l9mr9IAze+T32E2M+B2DKrHxetlwR6mA4pMESiWxfRuwCruEvA6QyLS62hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iLxXh+7n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J9R8DT020722;
	Fri, 19 Apr 2024 14:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7PwKIillDqW2PxE/69AtrzMGuZqPPLn8J52Rt2ukngE=; b=iL
	xXh+7nJ8AxGTYdmPCplbpr70XR86pU/p5iKiDDzBsztH7+M5IcQs+9h7ecuL6RbQ
	qg1IrZqoLGE2JFVmIUP9VUq9uJQH3K+mB2ldFrUnI6lgjUkSgaDAqwpK+FH1degw
	Q8lPVHXjG1HxAEXMG6VJUpIFSNG6Wg3t+PpSNjg7xvkN0+VAFlpehxJA8shGkQNm
	2S3NsSRZejZEun5fMQhBK7PcwhdmF69ybJCEgQbvn5uxLyoMta/p6iZBDv8mlM3m
	sBCh+NJ4qfHHRUs2fnWHkPr+vmJYc2TY11vbvkpj7pVPAfyI+DpPK4KSxRRmDKvO
	xhtk7hHw2/gZTn9gK0Ow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkgd71ag9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:55:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JEtY0F005389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:55:34 GMT
Received: from [10.110.56.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:55:33 -0700
Message-ID: <edda92e8-0508-4028-a3c8-392355436c43@quicinc.com>
Date: Fri, 19 Apr 2024 07:55:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] wifi: ath12k: ACPI band edge channel power support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
 <20240418162019.1246749-5-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418162019.1246749-5-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vweodLGXdPW15VmYVV-kR33CQtafbVSQ
X-Proofpoint-ORIG-GUID: vweodLGXdPW15VmYVV-kR33CQtafbVSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=888 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190112

On 4/18/2024 9:20 AM, Kalle Valo wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Currently, ath12k does not have the ability to set band edge channel power
> for WCN7850. In order to support this, ath12k gets band edge channel power
> table in ath12k_acpi_dsm_get_data() function and sets pdev_id and
> param_type_id, then finally sends these data and
> WMI_PDEV_SET_BIOS_INTERFACE_CMDID to firmware to set band edge channel
> power.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


