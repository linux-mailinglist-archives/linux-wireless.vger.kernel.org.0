Return-Path: <linux-wireless+bounces-6671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC28ACFC2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFED1F21B9A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5815219D;
	Mon, 22 Apr 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H5l1rqA5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4E14F124
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796966; cv=none; b=q7gLj6s5wn6Qa8wvC/9Kyz40FokUnQCDBrxxkwGsH7jIPSXuAb9HYBhU7muyGzgv9GeuGKOYUaiqW7vLugIlIfggOu8zYQZfUsX67DPfwviv0VVY+GZl7U2GqJahmlF9zJQYd24hXT0ORorNoo6xPPlD5jR7oul9ONfjEhGD9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796966; c=relaxed/simple;
	bh=qKlleNWESbSuOmVfyGCJTjidAo/z0liXZdOg/zVRudg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oii/lwJDsWBJtU0xUUzjm3QDV7nvx7kuClowjVoEX/5VpmlTaPb0Ef2569glnW3W4dTSWNV8MZpHIfdT3X1nLcgydR1CT+9PJ/Mlafvspkl0ol/FiX2wMRj7+5U063F56BiR6TRQ5e1nyhDH9CtTSmWlOVetSiPZ/BGjYsGMrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H5l1rqA5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9ObG5025795;
	Mon, 22 Apr 2024 14:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=x/zEVgxPKSdqrMJCwVoTCE40GZRD5t3DQ7qTAS76jXc=; b=H5
	l1rqA5uyuggKdNvYKahje42WH1t7E2edjH3R66+1ugrZUhw1a/Qdm+8Hxd4lv9Ts
	FiVUZ7bboX8X5yI2vzoLlpCl3RSsLn4wi48WemB7qfgYIbbL/4LEj1lDl4ptgqqn
	87DcWrY7no1naO7gXxabMIxFFRW3gxJ1owmsAjmi3foeDQtVq2a+7jEh9IfLhn9H
	HuOqUuAHbImdACZDau9JNvUgFjfXhT93Rk2ax7qmDCuffZUWJnYwGv73cNZUGN28
	fZVX2AtqfTRFXNCgMs0a7089Grv44pjdrwbDjITjfTPNzk0SsVwBFa5dR3smcF2+
	K0qWTdVJXexzXaCfz7gw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82gsu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:42:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MEge7u025723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:42:40 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 07:42:39 -0700
Message-ID: <57a5d352-76fe-4aba-972e-e1e288d0a55a@quicinc.com>
Date: Mon, 22 Apr 2024 07:42:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: read single_chip_mlo_support parameter
 from QMI PHY capability
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
 <20240418125609.3867730-2-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418125609.3867730-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: popMfKOIbFKj85uim34XIy0RzsjVBSDE
X-Proofpoint-ORIG-GUID: popMfKOIbFKj85uim34XIy0RzsjVBSDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220064

On 4/18/2024 5:56 AM, Raj Kumar Bhagat wrote:
> New parameter 'single_chip_mlo_support' was added in QMI PHY
> capability response message. This is an optional parameter added
> in QCN9274 firmware. This parameter states if the firmware
> supports Single-Link Operation (SLO) and Multi-Link Operation (MLO)
> within the same device.
> 
> If single_chip_mlo_support = 1, then intra device SLO/MLO is supported
> in the firmware.
> If single_chip_mlo_support = 0, then intra device SLO/MLO is not
> supported in the firmware.
> 
> Hence, add support to read 'single_chip_mlo_support' parameter from
> the QMI PHY capability response message.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



