Return-Path: <linux-wireless+bounces-15497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60479D1FE5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 07:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E51B229C8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A321547E4;
	Tue, 19 Nov 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kUJWTdjW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE88153BD7
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996242; cv=none; b=GobKUnFvIcvP6dnqltnqaV1HnhsRCMR0QJ6mBXzIDoUhfF0joGvnNUyeb8px70seE3s84ahQ23uz1HY7mhKyOMUArjRcVHHW483bwzICa09aBllFzWerXh/8nr707HSQ7syOvCQN6TfK2HKX/MK8dJsAbeo4WfwSOS6AzKrN78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996242; c=relaxed/simple;
	bh=NlJMpxtotnaumPFE62XZG3nYnW46Pk27IEr13UIJO8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u2SuYe22nM1RebD/+MaB60ESTkSBg0M58CyO0AOQEHHRbTWprv9icHmZDwjwRwPDrZHbdGcYRlxfJeWFz5MH5pPfASlpfCzE38Z0YWq2Wa1kcA3EBA2oCYTfIxDSDMxyg2XGh9qD0gHCZLRrFY7GXmnhO1OrvIxazSGt4/Y3Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kUJWTdjW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGc6T022350;
	Tue, 19 Nov 2024 06:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rZnH/C4BZk2gZPof/aRGd1hwMaC66o9eYIWKMrnHlOs=; b=kUJWTdjWchNOwtfN
	SFAtcxZVgWno+lpc2UcT/mTeHwEkUrYbI5ZK4Xxjo5J/cJkmdKASXqV/bVx5UdH6
	lWvCalIoCsOTMDG1sWa5wUY83vCiZMmyWkMXvRTTkXpNI0tejYxAJP2Kp9vh3Jn8
	zcAubNnKnT5iely+6BhToVZx+khZq9jLQgaoKQ+b9D1m3PqfdyhRUSKjjquuF3d7
	tdj+VMSrcixFl9h2MEiRbftvFO2ltkkhWw3W3Bjk1sOasMlvSTXsFuMa87Scfe4P
	wnJQ1GmdQcDanYd/rc6CFXyYiHtBqJlhXuYIwQBqdXG+ZQLtcl8vWB35sdegyp9V
	H6N1zw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y61j2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ63xsK010233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:59 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 22:03:58 -0800
Message-ID: <3b7aec30-ac7b-49c7-923d-966eadbdc8fb@quicinc.com>
Date: Mon, 18 Nov 2024 22:03:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] wifi: ath12k: Avoid explicit type cast in monitor
 status parse handler
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
 <20241119003248.1579567-9-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241119003248.1579567-9-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZpttltOSTe3EQOil2oxWYGZruKiHV-sk
X-Proofpoint-ORIG-GUID: ZpttltOSTe3EQOil2oxWYGZruKiHV-sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=839 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190044

On 11/18/2024 4:32 PM, Karthikeyan Periyasamy wrote:
> Currently, monitor status parse procedure handles all the supported TLV
> tags. Each TLV tag has its own data structure for parsing. Now, this
> handler is passed the tlv_data as a u8 pointer, so explicit type cast
> conversion happens for every TLV tag parsing. Therefore, avoid the
> explicit type conversion by changing the tlv_data type from a u8 pointer
> to a const void pointer.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


