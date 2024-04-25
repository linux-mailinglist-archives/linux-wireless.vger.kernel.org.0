Return-Path: <linux-wireless+bounces-6904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF88B2DB9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 01:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EE21C21DB2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB4156F3F;
	Thu, 25 Apr 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jFYV4rNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EB156979
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088415; cv=none; b=bdtMvR0ZmXlQeoi3jqUhU6L+1hEATrnYG1EoHlkwVrY6Ip/9FnuyVIhWuImW2Fctj94obZxBEeC78fr5Jat5xpoGuy5XhzhFtq7fnl8bLONglzlhFxtu0JvqUyxWHXMMZuM3IbGZLJszMoHjV7/wUcZKnkvnBCDSxIATZB3bc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088415; c=relaxed/simple;
	bh=DloogCk/MhcLK+4WrN56yni7/IC/jPKs2cnJiDJvOtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jZvJPtW4pqBhP8Kk6zETrm3z6AODSqIFXHZW7KAKkjG+zPAMGDMA6wJ33sqRa6D1FrOQM1Omq9EGpe7jE1g5A3PZbdiNmXpcn3uLGQNxihi+PNxZzpyeojslAuod+BljLDXl+uCGGdf8AU0lWyBGiHMPD7nc7xstMgU63KwRvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jFYV4rNE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PMrCWc021675;
	Thu, 25 Apr 2024 23:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BrKswKgr++bTBkMQ+U/VW7lYSiqCN4HDH3FHzaR1vlY=; b=jF
	YV4rNEJZvRDS7M2ym0zhSvhSzGq+Trl8JDWeg+9nacQR0rA6++0umGCRkrPFoJwc
	ltLo8LixsxviJ+jy9cnEGnGxFmW5TOk5bYvDAUus73JI9jhM8pRb9QUil1KF/ajB
	RT1CoQYvWIFkvJjpWju562e0G5gnSV0t4oNCqlaJJo6MqWFlJPHUAhIF3674pNBR
	rFSOQrE7Sz+mBkFvHoVl2gRoOjQaTbpQJ17wJOPE4J83ZnZD8sr6wx3FDkZPrwEd
	fFE3Yx+i9vgOIRLDxql4sdwdBn7/dB739j5lu5uPHdc8ym1siLajZyl63y66N/Cn
	AnlBX49e9s6Ck9I01cfg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqx038a7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:40:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PNe9wP007065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:40:09 GMT
Received: from [10.110.19.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 16:40:09 -0700
Message-ID: <d7b57775-711d-4180-b3de-5ab59aad0ec6@quicinc.com>
Date: Thu, 25 Apr 2024 16:40:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/6] wifi: ath12k: refactor SMPS configuration
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
 <20240425221902.11553-6-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425221902.11553-6-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ItivR5cf0pbE4u_neWpGvVhzcvoScmiV
X-Proofpoint-ORIG-GUID: ItivR5cf0pbE4u_neWpGvVhzcvoScmiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_22,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=828 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250173

On 4/25/2024 3:19 PM, Pradeep Kumar Chitrapu wrote:
> Move fetching SMPS value to a new function and use u16_get_bits
> to extract smps value from capabilities. This will help in

s/smps/SMPS/

> extending the functionality when SMPS support in 6 GHz band gets
> added in subsequent patches.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>


