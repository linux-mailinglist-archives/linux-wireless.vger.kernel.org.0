Return-Path: <linux-wireless+bounces-6579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E88AB11D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143B01C21014
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467857D07F;
	Fri, 19 Apr 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Heakk5dJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F81E893
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538509; cv=none; b=rQgmOH7wG6XJy8asfcQLn6lmUSpvawfOoArM/0r4pKv3l4DX+vZZ4CrB0LcGZn4o2MFgtPYtkFrmgutY1ddSYOIh2hI/kyYjPSiaFV6yfaLdkDYZblgMDVZ50/gv6EgpsHnPGkEtnhuEe8/1vscIW9AxfaPG892Ppw3S3lIQ8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538509; c=relaxed/simple;
	bh=c/GQeH6BDu32LmeTeWi1nnGNMLtI1f7Dm9zr3tQW+rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZUrp3LKGXpbavUw8s4NSw/pAQaQVWOdtxdGb/9N39USivvQMAi0cXJHwlq7Jny6T5csISua7nph15IA6mLNwLrMiSHpF6+SLFPJnWmayqfWhahKQgXK1bR1dXfu89WDJ7tNDSH691B8kPSSrpFFH4Akgr5csNA1mK0DRy7akPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Heakk5dJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JCaEgh029208;
	Fri, 19 Apr 2024 14:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rWRnm8azf1sydL4ncq7o+kY1QatMq+6Hzv3zqm2S+7k=; b=He
	akk5dJGr/FubCWGoNBgyMplPRLLFEBj53BCOnipte+9e3+fz7v/FTX9NpTb8mT0k
	tP5Wqzgx3zGaelo2nR9tEi+EOCoOr2HTTNO0SDh6mdZkT/pYt67ffmQhg2Ebks/S
	ltklsTOLdwggjncpJAeOGlBH/tDE6x7vUdDPtl8/XzhYZdZV9hXXi6leQ6+UkKoh
	HY9z9D2TgCRYSbG5QUBUrpfOItkc1gSvcp2hPJm6LI4rHNlMr3fawmKxbp/QnfHX
	H1SEDpor2Ng8CMRmZIR9uhJiHjvatx/tj7zskRIrHEAvW8Rn4WQUu1i4WXEvAEWB
	mgBgKpdyiikWc8asPORQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk9s7a3rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:55:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JEt22O000668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:55:02 GMT
Received: from [10.110.56.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:55:02 -0700
Message-ID: <b2c4dd7b-f0c5-447b-bc2f-b1acb3a9f2c0@quicinc.com>
Date: Fri, 19 Apr 2024 07:55:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] wifi: ath12k: ACPI SAR support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
 <20240418162019.1246749-3-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418162019.1246749-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0uTfFWec4Vc9k0b61__ksvVzY2UR0WaL
X-Proofpoint-ORIG-GUID: 0uTfFWec4Vc9k0b61__ksvVzY2UR0WaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxlogscore=903 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190112

On 4/18/2024 9:20 AM, Kalle Valo wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> In order to enable ACPI SAR (Specific Absorption Rate), ath12k gets SAR and GEO
> offset tables from ACPI and sends the data to firmware using
> WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID and WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID
> commands.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


