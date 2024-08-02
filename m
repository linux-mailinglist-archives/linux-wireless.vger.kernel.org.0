Return-Path: <linux-wireless+bounces-10868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57216945F8B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B205285400
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F11DAC77;
	Fri,  2 Aug 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z6j7hOgz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CE2101A0
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609694; cv=none; b=m/4IWXRjeSjoaybg4WYyEtpz3+IvUwgqYXAEQdgRygYJY//02nhnzMS8C0jsY3bWx87iIfAk75avZ3A2YyMUh+RDIwA5QBzQ/k63gsj7YUFi2WpwGsgTQbX4f5gklmiTj1JYiFUlTe++ynR9GontzVHcp2CjscfFtuztso0f4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609694; c=relaxed/simple;
	bh=KbZ47yKE+hYJyLZGc9UYG3piwTbb3FR/E5VKKJ2617M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PzzmTkVN+DMrA2+rcPeMiLNPDcdPvtAn3yBc8hn9ECnki6YXCi2frtR3b5ehvPk4WB6gyVr+fcjQcmxv9oIO2swjv3a6Yej+0oFPlWadfePEcNFd+Vl1zzwHGz5PlK4mneRi/bePteHHAKRzXQePcnop7avO8iWzbG2AnkqsgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z6j7hOgz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Labam009572;
	Fri, 2 Aug 2024 14:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xflzM5BXEgKQKVqZgivCYSC/QQl4LsCTJeBvJWHODhQ=; b=Z6j7hOgzWc3OR7aq
	TSgQTNtdMoDz3iXhi0QJVobaQtF3T8sNuGDJT5fQUr/mxFY3D/VVx0Ay0M9ACHFt
	IS7nsSclmNLc45mLdU1oiqPrkgYobjsHk1UcwdymuDY3FtvjCT2ZHbN0CKWQ51+E
	2ihzwZCT6a/H3qrKgtrxKgNKIZ83mxIer15CvrL0L5ZHD+DsSkmrK4e/aJ88cD9+
	0v6Sodg5JJpeVzNJ/Gb3xGN/sXeSkhR9a2xIhEeReKvs8OMlkIBAlCIkSAbKAdfG
	kwQp6abYq9BM2ggUHk94QWpW43+S1b70wolFaOkojikqwPrQjtLlaERd51tsAHFm
	tWG8yQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rje6hw32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 14:41:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 472EfTgs024895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 14:41:29 GMT
Received: from [10.111.177.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 Aug 2024
 07:41:29 -0700
Message-ID: <430403ca-ac75-4b02-990d-63fc24d9b979@quicinc.com>
Date: Fri, 2 Aug 2024 07:41:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] wifi: ath12k: report station mode signal strength
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240801112853.85508-1-quic_lingbok@quicinc.com>
 <20240801112853.85508-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240801112853.85508-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v-W1u_9H9ndvJ-jRASeytuwJvM6oRVnG
X-Proofpoint-ORIG-GUID: v-W1u_9H9ndvJ-jRASeytuwJvM6oRVnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020101

On 8/1/2024 4:28 AM, Lingbo Kong wrote:
> Currently, the signal strength of "iw dev xxx station dump" always show an
> invalid value.
> 
> This is because signal strength is only set in ath12k_mgmt_rx_event()
> function, and not set for received data packet. So, change to get signal
> from firmware and report to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct signal strength.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  36 ms
>         rx bytes:       61571
>         rx packets:     336
>         tx bytes:       28204
>         tx packets:     205
>         tx retries:     49
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      83
>         rx drop misc:   66
>         signal:         -24 dBm
>         beacon signal avg:      -22 dBm
> 
> For WCN7850, the firmware supports db2dbm, so not need to add noise floor.
> For QCN9274, the firmware not support db2dbm, so need to add noise floor.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



