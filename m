Return-Path: <linux-wireless+bounces-7067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159D8B7F41
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5250EB22ED4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794341802DA;
	Tue, 30 Apr 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xw91aIDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AB175560
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499445; cv=none; b=hc/eqhpWp5FF6QO3CdHSpsdlRy3ZAnKrBCZcsqksizdBPgcNlfAi5TxyLGcBNRR3qBeY1H0FU2113sWHAY8pFiDJFFXo5Xdw7dRpjox7tDH6pMHLcr9qAbWFDGIIpGCfVbJlhmuqxsbxtwrbUOYYgVBaakp00H4em5Xkz8Vdzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499445; c=relaxed/simple;
	bh=sw10DxRqo0FTpvthUma2QJPXXZncip8iPTsnOOtB+ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oYz58A+J5wnhZwksUPAO/bT89et++m5viVv7CEfNGLc8pmHxvR2Jp23xsIKj069RRP96oz/4x6ZXlwr7+OVHSrjj2sY9TRDBCjoTnmx7sqpXRBG+R5wkIkLkR316AtvsRGN1aju0r15Z9FhrtyPVX/ajCqLZ0JR231khYxQP8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xw91aIDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U8Ju93021331;
	Tue, 30 Apr 2024 17:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U/CwnoxZ5GtMudGM3SQsLOA0jz1cr6SN0cIWEketjXA=; b=Xw
	91aIDY8TqdC3osQ74Zt6zxlIichNqOeI5A96A+jy7dYVjoBvpuwPtKyNIbfxC2ar
	8fHzOShp6un5qjggKnqsgo0+YnF0nM1Ys67sGoBdGdAKlu98WoFBfERr5CHqAkiW
	L0JLbgv/TZsRr8av1pZKAob46QkQP8ORs1pUeK3ngV4HUUvkcnj1iMBb9AZ+6yUU
	QdKcNTXfPP/I4b3StCTdQcaBbewPWIBpICl5Ep2Mviizc3hVDFVbIiwHUV+mQOuK
	3N1IOlmSxrdt3ad92uSZNtbOM6x7rwXapUMOLpakw2iZF7PNkh2pPQM+Bq3kMryD
	Km+Sm/Dopx6qswjF4sNQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hhfek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 17:50:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UHoUEK024314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 17:50:30 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 10:50:29 -0700
Message-ID: <27e74c02-7ac6-40ba-b3d7-a303079246d7@quicinc.com>
Date: Tue, 30 Apr 2024 10:50:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Don't drop tx_status in failure case
Content-Language: en-US
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sven Eckelmann <sven@narfation.org>,
        Sarika Sharma <quic_sarishar@quicinc.com>
References: <20240430074313.885807-1-quic_kathirve@quicinc.com>
 <20240430074313.885807-2-quic_kathirve@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430074313.885807-2-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fPnzT2u_-KI8dWI1lwhMiHBe7W-q5oYW
X-Proofpoint-ORIG-GUID: fPnzT2u_-KI8dWI1lwhMiHBe7W-q5oYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300128

On 4/30/2024 12:43 AM, Karthikeyan Kathirvel wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> When a station idles for a long time, hostapd will try to send
> a QoS Null frame to the station as "poll". NL80211_CMD_PROBE_CLIENT
> is used for this purpose.
> And the skb will be added to ack_status_frame - waiting for a
> completion via ieee80211_report_ack_skb().
> 
> But when the peer was already removed before the tx_complete arrives,
> the peer will be missing. And when using dev_kfree_skb_any (instead
> of going through mac80211), the entry will stay inside
> ack_status_frames thus not clean up related information in its
> internal data structures. This IDR will therefore run full after
> 8K request were generated for such clients.
> At this point, the access point will then just stall and not allow
> any new clients because idr_alloc() for ack_status_frame will fail.
> 
> ieee80211_free_txskb() on the other hand will (when required) call
> ieee80211_report_ack_skb() and make sure that (when required) remove
> the entry from the ack_status_frame and clean up related
> information in its internal data structures.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Link: https://lore.kernel.org/r/20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


