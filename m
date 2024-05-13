Return-Path: <linux-wireless+bounces-7614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D4E8C4888
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0BA282ACF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670E80BE3;
	Mon, 13 May 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Icm9dR9W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE829D02
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633711; cv=none; b=Dj7xTa5aMIaFFWzE1TZf4Y3cbbMAXf45WDpLH4HsBh8ZRlxdLoCfw73EBRFuCNQHLIyPeU2mtr6JozT1e5lmzMkfT+vjXH772WVMn51V2oVFFgR2S9RngVpVSU5pMWxOwi235u9mkG7tFzUErybJtcym+sMzGFbiuDiSZIbVuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633711; c=relaxed/simple;
	bh=4h2smqfu1BgssN3Yrr1uCLbuSh6D8xvZ6S+aqD6Y4s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tLvCPNSxabB6kPctvT9FBkyXfyeCyxgbyiRUalTlyQkNug/eIL4kRCzVWHk5yUESpM5JPbEKgzd4fYZRaIrPmfmJ+LUrdconbdRnUUpHrw/xSvMn/+2LFBBMDFL4FdT3pH+Xd4EZwENCvUt2f9pIlZEi2VDDh2q2qPOzROl3b7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Icm9dR9W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8T8g003249;
	Mon, 13 May 2024 20:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+685nWWh2QNUSFRVZIswThV4BrxdkazQm5cuj68UX8g=; b=Ic
	m9dR9WrUaDuUoXpb6Q6+kuG/OnRuLN8JsFyAchpY7xo4Ee+tLCx+2sp7hFK1WXrX
	LvMaCt2GQcU/CYzdGUj4Bd+mfPMwBElE+blVW2Iztl0/HITPugok1Wdh/Y1bGVqA
	//fMRvHaQA/igodhbWKRaTXpEXJLzGPT7DX+SnKHk6RmnDYitMQUPMW8psexr80J
	8XeRE1T/NOL49kuiE1GiYBhawJxKPTTVsa6Pc0ibvZP1NFultDtGo7QPSyEbcpAV
	g1mU2a1RSb5eL2nZqfXPyVcHopVrPv4hapxF6H7VYDkweGSPlXX2h23Q6RXzO1M+
	5Q2c770lM7oEJX58qBKA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3j28h5a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:55:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKt3n8020340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:55:03 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:55:00 -0700
Message-ID: <4ce44353-994e-4ae5-8f5a-9bb19d31ba9d@quicinc.com>
Date: Mon, 13 May 2024 13:54:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/10] wifi: ath12k: add support for 160 MHz bandwidth
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-10-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-10-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ATFUaZ5zbxchVfMViVEB760BvcDbsdmb
X-Proofpoint-GUID: ATFUaZ5zbxchVfMViVEB760BvcDbsdmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130143

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Add support to configure maximum NSS in 160 MHz bandwidth.
> Firmware advertizes support for handling NSS ratio information

s/advertizes /advertises /

(one of the exceptions where US English doesn't use z)

> as a part of service ready ext event using nss_ratio_enabled
> flag. Save this information in ath12k_pdev_cap to calculate
> NSS ratio.
> 
> Additionally, reorder the code by moving
> ath12k_peer_assoc_h_phymode() before ath12k_peer_assoc_h_vht()
> to ensure that arg->peer_phymode correctly reflects the bandwidth
> in the max NSS calculation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


