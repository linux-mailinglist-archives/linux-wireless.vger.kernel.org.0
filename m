Return-Path: <linux-wireless+bounces-6882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E808B2AA8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431E81C21E16
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26193155723;
	Thu, 25 Apr 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h24+62QT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52D153812
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080413; cv=none; b=NSIuvjHB/+jQcFIySrqYp7zmJgHcG6VBX8MYH9ZJCSyij03F0QtAQZ6YxUOQ6I/DXo/f3/EqCVxgBWGHZjmJkkd8MWxi5MDDcCPOgjtQ9ldgYitC4IfcvS+j6xNlhUL5UeNNcK5RLrCAYnd00lXinMbhcIe7PpY6jo8g9YPCLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080413; c=relaxed/simple;
	bh=4CTqnhYuQW4C0LIpFbRKPP4R/S0YYLdCUAytcrROadQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=avrAPH7U55/vrly0k6j8QC03XI3IsabzBkJKTsgcEIE/ia6AVDDpcASE821VqHl++HF1Fj6z8g8+enB7nD/H+9qeXKMg2SbpoMlUUnLGGvKpcBvA67C3S2VWqOnOjUjWt2myzni+mvza3jo2FV5alqS/PkZ4MBO2/1GXoXOmEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h24+62QT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLOLpP005748;
	Thu, 25 Apr 2024 21:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0wiLLNWTGUF/XQMJl4BlM9nBJo1VYRZFjqXcLArC0Uo=; b=h2
	4+62QTjPuBWaBT+Fwgmua7q0O3oLXroiEgqtR1EzsTJUR266k0cxUFuP86fi9hPi
	O1iO0Z4weYFTyq2Jyl/e8LH32gpiNFeULRtd6VGS4D7dvredyWF4N4S7ZkblGo8b
	itL2whGj4IdykY0tEhXx80mwOenRfmelY63jsEUH87GQoQ2x/oS36Ee3jpqZ5xYZ
	m/6osj9zJq48blOzaofDQYmQDV2aJ2vXqn6xcPqOmBXp1JRByzgWOia3ZxL4+Smt
	WMIWsBHcECQU0MdKOGI3DB06ncItIGr6sReJBMHmky0gQGiHmEwQjN881miNMt/Q
	zHphfQZNIytAD7UZU3PQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqx0383st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:26:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLQkWL013464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:26:46 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:26:45 -0700
Message-ID: <81b423bb-883f-4f29-90b9-6d3e46440018@quicinc.com>
Date: Thu, 25 Apr 2024 14:26:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] wifi: ath12k: Refactor core start api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-2-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-2-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JoJqC5G6eukBfs4xd5NuuPCL5mbWIE7d
X-Proofpoint-ORIG-GUID: JoJqC5G6eukBfs4xd5NuuPCL5mbWIE7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=777 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250155

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Hardware device group abstraction would be introduced, in future,
> where radios across different devices can be grouped together to
> support multi-link operation and register as a device group to mac80211.
> 
> Currently, ath12k_mac_allocate() and ath12k_mac_register() APIs are part
> of ath12k_core_start() and ath12k_core_pdev_create() respectively and are
> based on per device (ath12k_base). These APIs can be decoupled and moved
> out to ath12k_core_qmi_firmware_ready() itself.
> 
> This refactor would be helpful for device group abstraction when mac80211
> allocate and register will be changed from per device (ath12k_base) to
> per device group (ath12k_hw_group).
> 
> Add changes to move allocate and register APIs from existing one and modify
> corresponding deinit sequence.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


