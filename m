Return-Path: <linux-wireless+bounces-10308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263089340CB
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 18:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46311F213C8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6541822E1;
	Wed, 17 Jul 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="beoCzLIr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27C1802AC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235176; cv=none; b=r6nZr9bvFbG8xb9AYO1QIeeJAAl1KCzuSJQf1k0JyKoSJaJuh/Rf9en2amlqmTtwFihOteG7SUl4Ze87LlOnWmK3DDjjx2qs/3ns6MSFzgbn4FzGCEDG0jHpzrJC6YJNoCoAEAV/3wr7zHQ6t/8PBTBoH7lSiDsT8tZCzOe6X2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235176; c=relaxed/simple;
	bh=0MJiRmNYrlrXhKx50aUj8sipoX17THcZ7McKklWrtTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i1eVSxidVkJaBSpvbsEeiNzB700VlTGaZ0/+lTAXSogA7psAX5ypIM61TZDoEs91CMqpB7ELTUpdF2+F6QMZO6Y2nP9DL6BZDxZTD6SeZgXYBHKK734bRanprnv5F0SHe0V3nQa3GrrmMTXrq/pFWq6/VFadKWH4IXVYkei/S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=beoCzLIr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HF072n029217;
	Wed, 17 Jul 2024 16:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AYTXZwwCrHfaGQVCMa2Noj2yv2XOmp1CwRQtdZDfUgQ=; b=beoCzLIrSKSiVeZD
	brGNLWY0m65y6YV3yFIJK/RcamwK3lUjQwnN4F0zROU75r89LqfvJdE5Wihob9fg
	Qs7V2MPc1anZgnuL9QtiXJeaGnRWNRzyLsDGgeCXNN9g+E07Q+nDrug5AJssj19U
	yR00JgTtm7xGjKVt8+M+2+/K7HWkohSxaB88Y1xSTsILOq2hFsN4vYzRXnxDiiB5
	+HKtxBUH6W+UJ/qR9Jk6wvpKasVJPVWwiHH+usmh9f/OITqR/lp3qxfLpgla20Tx
	g4tEv9NVvZ0D4ruFcfnt521R2dbttS9HXEIw3HxT9jMoNsT6kQAIadIE1+rMtFFc
	nvnEFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwj1k5e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:52:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HGqpP2026183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:52:51 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 09:52:51 -0700
Message-ID: <18f5a47d-3bef-4cfe-af7a-0185f89ccc5d@quicinc.com>
Date: Wed, 17 Jul 2024 09:52:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] wifi: ath12k: Adjust the timing to access ACPI table
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240717111023.78798-1-quic_lingbok@quicinc.com>
 <20240717111023.78798-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240717111023.78798-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NkSPUTMdx7eA1NX9U97GtPAu5YV4wvpp
X-Proofpoint-ORIG-GUID: NkSPUTMdx7eA1NX9U97GtPAu5YV4wvpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=850 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170128

On 7/17/2024 4:10 AM, Lingbo Kong wrote:
> Currently, the timing for accessing the ACPI table is inappropriate.
> 
> Due to special ACPI requirements, the ACPI table must be obtained before
> downloading the board data file. Therefore, adjust the timing for accessing
> the ACPI table accordingly.
> 
> This patch will not affect QCN9274, because only WCN7850 supports ACPI.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


