Return-Path: <linux-wireless+bounces-2840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C944842A9F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00F41F2609B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC226AC6;
	Tue, 30 Jan 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BdfO4LBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D06383B5
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634883; cv=none; b=ZvOwm8ZLlBd7TavFYSysgMgfKWTOwYSgOEL9nmbh+WYZJpEqbH8QpCpqseaxwQYyFAbrC8uES6TfWY+Tg3XjPlETsBjQBPmoDf8DycG0pqL4ZBb0Ts89hnWg4O/VAAnhNNoqQ4ks6zzQWQPCcF4wOiDGPfc/gz5qL1law9rfGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634883; c=relaxed/simple;
	bh=hkvIyCg9VIE+UpsV6ZFbbI20Du5Ab8P7cax34i1jfHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OdF+bc6hky56ZYqTm3E/s7p7FAFeQgUegHpfPYUtXMARO4EK/+VImyj5TxvmaQPADtIe6xGfPE4/MhtQQdB0UXnqnwzzXzBpQhd9JT2fVObOGYbMJv7p1OGhadU9TJ9pK+wV0MryoPrRZ6pO+PgnbqzcZyc2CndnEzEcmps83h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BdfO4LBj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9S6x4023347;
	Tue, 30 Jan 2024 17:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vBGk2egJQPpE0Tsw5+N5pjNE+8vWFz/oA0Thbx478/s=; b=Bd
	fO4LBjZT56pSRbY7u51XTWPjanfqeONQmYV4zAo0CBW6xiKzknl6Id69fYKomBwI
	1xm2qsWSQu8B9Fas7GkSLsHrChrcVUgcQCYEzf9o9uDPYD47qUij+6B6vbfEGRcR
	D8KqwDwrFNsoU7dop0nohH481MlBqiLrLspmTlZOQRSUSXhO2pExNEuHH0eLTXyY
	ZB1Nw+fNYFM4WlQxAigF5ZqHak48lzQPAXCG6zmYmxLUEAP9LvP0tXtHHPsdScLL
	4FdqOMPJ7pMDhn2J7LZej6IeJHnW0NR2UsUQrdXLDQLRr0/xzoox+6WVp8O+W+s8
	rUVpzLKw36OaRcmb9SYQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwwv95df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:14:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UHEb9b026953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:14:37 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:14:36 -0800
Message-ID: <603ad5e1-5e2e-4945-97bb-4908000a2f52@quicinc.com>
Date: Tue, 30 Jan 2024 09:14:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA
 event
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-6-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dxgOmKE98FEpRXur7N-93Fk3TUmCW06O
X-Proofpoint-ORIG-GUID: dxgOmKE98FEpRXur7N-93Fk3TUmCW06O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=698 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300127

On 1/29/2024 8:02 PM, Kang Yang wrote:
> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
> signal its absence due to power save timing, concurrent operation, or
> off-channel scanning. It is also used in the P2P Presence Request-Response
> mechanism.
> 
> The NoA attribute shall be present in the P2P IE in the beacon frames
> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
> or when the CTWindow is non-zero.
> 
> So add support to update P2P information after P2P GO is up through
> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
> 
> Create p2p.c and p2p.h for P2P related functions and definitions.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


