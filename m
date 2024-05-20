Return-Path: <linux-wireless+bounces-7852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265248CA51D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4901F22032
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF036AFE;
	Mon, 20 May 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nerVsNQj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311D3611A
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248332; cv=none; b=tWcvQ3lYp/XPwlid7boaftNiJPmrOllL99d6Dd98ukWBtT51dcSJL+VAR9TrB/oohCP4usyLcVNT5qjFqbJBkpvn8VijboN2fLMY31yS8TQSoc+QyPpcMAeHw1mItTb0N6MdGRap9qyjaqTfV8/5MdIshrC3c1nSXUhYX2pbqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248332; c=relaxed/simple;
	bh=pwZ7wqxfl+KjV/o7unqvJHqcBmgA8S43HBCgbfVmA1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llVPO1xug/nkN2LLOePEFU2d3RkwPiyrt2lmh/cnFKZ2XbX9QcFGdFEB6Q0K2uTykhOvkZuSqJ0VAA+yH3LtisSMmw0YY3wDZQLnYA8nqosnueX6S+vz1GLz41Y4v/bfOOOQDymLhVH7Yph2xAAuuO/vGBSAZGeP3XNDhXwmUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nerVsNQj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KCGOgW009703;
	Mon, 20 May 2024 23:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IEiyZlZruIvNa/evEkblI1ovgzTNM+aWfOgSrCXxeo4=; b=ne
	rVsNQjJ69YsXuVXlAGfK2ZDv/4p0bqWLkhuv7uH7nc+duXuAvyj1xhK5Y9q1Qplj
	lEDsT6Yvc1Q4wEIKIgzyCRG/hGVtkMdiOzI5OMAJ9JWZzv29q9mNrutJmg0rnscI
	24riGbIOiLRjZEjcaf5byTj/Ay0z001EJBFHkG0s9OAP93HMwenNIPmGoq+OddDv
	gVDmJ67sEP/vz7fI54nCFOIc+YGPNyIS8FRhWmpJqoBh/UlN/4RB7yD3FP5tPFlG
	w650KNv8ltdzWUCwiH/Yr2iq3NbVxGGSCJnZcEHGzbm7AzjoVYUJ5MKKR2vaCuUf
	yNvWSVqFigI/8GxwHCng==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqamcqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 23:38:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KNck4A024030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 23:38:46 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 16:38:45 -0700
Message-ID: <e2522231-ff94-4917-bb47-bb970c309582@quicinc.com>
Date: Mon, 20 May 2024 16:38:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: change DMA direction while mapping
 reinjected packets
Content-Language: en-US
To: P Praneesh <quic_ppranees@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-2-quic_ppranees@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240520070045.631029-2-quic_ppranees@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RMxhMCsJP5Ms-9WhWlKaO7YdrajPrq9n
X-Proofpoint-ORIG-GUID: RMxhMCsJP5Ms-9WhWlKaO7YdrajPrq9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=669 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405200188

On 5/20/2024 12:00 AM, P Praneesh wrote:
> For fragmented packets, ath12k reassembles each fragment as a normal
> packet and then reinjects it into HW ring. In this case, the DMA
> direction should be DMA_TO_DEVICE, not DMA_FROM_DEVICE. Otherwise,
> an invalid payload may be reinjected into the HW and
> subsequently delivered to the host.
> 
> Given that arbitrary memory can be allocated to the skb buffer,
> knowledge about the data contained in the reinjected buffer is lacking.
> Consequently, there’s a risk of private information being leaked.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Co-developed-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



