Return-Path: <linux-wireless+bounces-9802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C49F91EB6C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1E3282314
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A42F29;
	Mon,  1 Jul 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a+sxM63y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF93172BCE
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877314; cv=none; b=eQJv86kqSjDDNEueihZRUHqpjf231qiIoHO5eIr4NE/2G7j7URCQJcCEvty5AIw5XSOzNEV6hBpKS7yg5Zv+mueB8B2KR6Zab8FvxZ9d8CM8lw7Q5lL65BTbYrjgVG6UW963VtDb7dPjiiP5woz8VWuoYWpoBk11nk3R43q0ZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877314; c=relaxed/simple;
	bh=wrTsG68+XfdMwbhPtscDuyAso2mhMNyKeBujkbOe3aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aHrFbeQXJCtTgEr5bEtRrx8bzxtYNRn3XmyT6nRFzW4ZKEeVQ87KPhljwLQXzLUrjPHzPfBC6Y0aTXR52deOYFXinbwflYgU7inmE1olvyyEjKU2JyzBIaC8ucD9u/BwEAX2xpEuBjuCE+EifLxIHkHw0JfM3OQ2nlsOFZsrkNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a+sxM63y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461MHo5Q011558;
	Mon, 1 Jul 2024 23:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVkVx3abE25oLESSQoZfCpts4y37czRjzssyxY6SlX4=; b=a+sxM63y36HsaJFv
	GPJ/SepYjbknTgTcz4PZmIYQeuB5JWBaWb0aZLzuBnJ+XiQ3uOBREKWgvXX/nUoi
	3dyYel7EqzKTlLOgaiyYlmvtMie2ykPalVjR+hn6Era/sQbtV7u/NY1BZAbIziXx
	jTXu19t49tj+ZR9rGtfIRR+JF2sEK/uMXRzkt+/VTYpwsBZB6PAX+RUX9OvMzzcB
	mPY9Y8mbKjd83tJElKFy8CanT7T+eVXpZcCmSXu6XYH9Kg9LBKg4R19evXqRMMa9
	Db99ME7xl+cR+2ivBe/PakhxJndtbiZwXOzZr1HUuZNe/U5zOnRKjLrd3D2Tq6aG
	ZoG9VQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402996nnu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:41:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461NfmwC020606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:41:48 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 16:41:47 -0700
Message-ID: <d62415b5-6ded-4ae3-85a4-88e093c3505c@quicinc.com>
Date: Mon, 1 Jul 2024 16:41:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] wifi: ath12k: Add ath12k_get_num_hw api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
 <20240628095139.292952-4-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240628095139.292952-4-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ztZWp-ePN01TsPP1cPyv40y1P_rioZZy
X-Proofpoint-ORIG-GUID: ztZWp-ePN01TsPP1cPyv40y1P_rioZZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=607
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407010176

On 6/28/2024 2:51 AM, Harshitha Prem wrote:
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
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


