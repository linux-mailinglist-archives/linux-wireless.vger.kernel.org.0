Return-Path: <linux-wireless+bounces-7855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDB8CA5F8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 03:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01795B21F3C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 01:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F163CF;
	Tue, 21 May 2024 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nn3ODDE5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8495BA47
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256336; cv=none; b=PV9XGgvA/QKINzocvGeV7D+a0jMkevEqjnbu7lGI+JXSBEs1cd06wFjbLu+xvpd7ytnfYGz3S9Xepe2MtAsB74Y1VX815XHqN1VvQyHQ8sp1fcAa8OKXMv33kSOHI5XOQ0mhVjwGdCU4aTF7O0Wof+/mX9Ow9AgHndabp7adcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256336; c=relaxed/simple;
	bh=PYyKmidCtP9DLIbJxnWuVH0Rppwk2kTFtBB9QxNKu08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oEZRcwPvvIWtviXN8onaz7uPtHiOpngs1PlkSjyK4p9MgXaBGPm/Kt44VF7piHQrBk5cQY1RQt26g5u1Bdh0vmOzQNd34E1eQhAnNYPEs+1eSjFKKq9HR8wIwtlK7HNx86XVvhH2nOr2e9Bh8XDVaKT6fls1syRhCikkZUxfrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nn3ODDE5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L0Nljt008286;
	Tue, 21 May 2024 01:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z2rR7iP4BLpQ5k6qU7WAbm9w/wIorJVlmfD0EJBZ+w0=; b=Nn
	3ODDE5wvInjQNWcknWSrvudqXQMJ+2KVHB6qdtso0xsPuhFm/IiiczzRGI6oP/yv
	Qh5pmbod6cAtj0Zznc0CIvuyD1CsOkHe0CDT+/sTTGQCqBmSCpNgYc6PouQtBs0h
	HwNmVCpnaR2Wm8m4Dzuu+oIjmfXTPJM0f3IP5ZMvIHT7lufmwPquX//vbrMNgT9J
	5ksQL4jKOGWH9Wv+5pm5T/4VyQ7WsXRQK2KGw+ROkiBoslhqJaN/JA+7elrMk6Es
	mJvMUXAO7OZUaH++J71c9/7AtGWeUAlKuNdqAHrdEehtH43fzZpOZ6rcXO+0Wm3p
	7mNfyjPR+5cEVYyErZoQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqamhxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 01:52:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L1qBDV011112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 01:52:11 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 18:52:10 -0700
Message-ID: <878c0f4e-130d-4852-b5ee-8ef59ed28331@quicinc.com>
Date: Mon, 20 May 2024 18:52:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Send QMI host capability after device group
 is ready
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240520131409.676931-1-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240520131409.676931-1-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M7SIUxCiPRB15Z60ww3GKxf17FOzzwrZ
X-Proofpoint-ORIG-GUID: M7SIUxCiPRB15Z60ww3GKxf17FOzzwrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=926 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405210014

On 5/20/2024 6:14 AM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> QMI host capability has the information regarding MLO parameters such as
> device_id, MLO capability, group id and the information of each devices
> involved in the group and sent immediately on QMI server arrive event.
> Currently, only one device is involved in the group and hence, single
> device information is sent as part of MLO capability of host.
> 
> But, in future when multi device group abstraction is introduced, host
> should send all the device information involved in the group as part
> of QMI MLO host capability rather than single device. Hence, sending
> QMI host capability immediately on server arrive of a device might not
> be ideal for multi device group abstraction as the details of other
> devices in the group would not be available.
> 
> Hence, once QMI server arrive event is received, request for QMI phy
> capabilities of device, and defer the host capability send for that device.
> After QMI phy capability is received for all the devices in the group
> trigger the host capability event for the deferred devices in the group.
> 
> Add changes to defer the QMI host capability event until the device
> group is ready and then resume the QMI exchange for all the device with
> host capabilities.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


