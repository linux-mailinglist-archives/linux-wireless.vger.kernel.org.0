Return-Path: <linux-wireless+bounces-6558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B16BE8AA874
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 08:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D20B225A3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A20B65C;
	Fri, 19 Apr 2024 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OLxXdkyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753110F2
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508322; cv=none; b=Q1SllG9mOuPbSpzl0P8B0zMucr2QPsER7C0pT+yilU55j3aG+rbCPITCZtL2/IOyRk0ODq25R0V4/+J3x4/mOz+GXxJjrTQCDvXgtbUKSCEiFcVCJX1+tLxWOn8JYpEzN6Mk+8yVNFSodQuLNNcTlsGBWzwRFiI7gOphnemsHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508322; c=relaxed/simple;
	bh=UuePyBHdOC2iIqkvaWHMurirh0WayFr5HfkwuQalRTU=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=FXd3nJJ1EJhwFlQ+dQGG+ZvOCRor76qKkeWKFpG2eN3JjilLy7ETTnGebSfUxlXV4x4u2bCi8BL19my4tZhD12yQM1JjoGSeIJdqWv77He8ZkfDfa8MEHSKFRIETbTh/KefHq5fwGPpuYuDulMp0WDGpydEKwWyNHi9YZhZPOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OLxXdkyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J3di1m017732;
	Fri, 19 Apr 2024 06:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=wx68YUPrjLnD35NqlXwG
	izNFx0HzIB+u8ShWxGK62Y4=; b=OLxXdkypDpVE7I13rYLgPBigtNrvBwDWf50O
	Uqzg8aNE/1oH9MMUjdAGzBDUDsbTrCGYPw1juU+vWfO/PBuEAB8IG7rLTpaKWLYY
	uORtjMJjBnQNfK65vE1HVyD/aAYiu+0/hhwSGzKuF/WkhtK1eKxOD99elpBwewCJ
	guU9aDXyV663awftezkrdKxAzChkOBV9Bt/IWCjFiZQM65RjGf8ANp1ZeLitQnnb
	gOOyFkMRgeJfu2fosHPzNIVkxgdWlZEbT21Rg8NobHl9y7phjb3++9ugcyHv+022
	LlbX6xJAcpR09Ss25EC5m9XKplrA87VEW9ilqxW9WLw5A1C29w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk4vm9wyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 06:30:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J6UZAB008050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 06:30:35 GMT
Received: from [10.110.91.89] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 23:30:34 -0700
Message-ID: <91cbda07-0b93-4e0b-adaa-cd9b078a91b8@quicinc.com>
Date: Fri, 19 Apr 2024 14:30:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
From: Lingbo Kong <quic_lingbok@quicinc.com>
Subject: Fwd: [PATCH v8 0/4] wifi: ath12k: ACPI support
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a_IkWnqc4o5ZA_zJI5xY-yZ6CIysY5QY
X-Proofpoint-GUID: a_IkWnqc4o5ZA_zJI5xY-yZ6CIysY5QY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_03,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=884 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190047

 > -------- Forwarded Message --------
 > Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
 > Date: Fri, 19 Apr 2024 07:16:07 +0300
 > From: Kalle Valo <kvalo@kernel.org>
 > To: Jeff Johnson <quic_jjohnson@quicinc.com>
 > CC: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
 >
 > Jeff Johnson <quic_jjohnson@quicinc.com> writes:
 >
 > > On 4/18/2024 9:20 AM, Kalle Valo wrote:
 > >
 > >> From: Kalle Valo <quic_kvalo@quicinc.com>
 > >>
 > >> Through reading ACPI tables, implement Time-Average-SAR(TAS), BIOS
 > >> SAR, configuration of CCA threshold and band edge channel power
 > functionalities.
 > >> This is enabled only on WCN7850.
 > >>
 > >> TODO:
 > >>
 > >> * test with ACPI support in hardware (I don't have such hardware),
 > especially
 > >>   suspend and hibernation
 >
 > [...]
 >
 > > I can verify this doesn't crash my system, but apparently my ACPI
 > > doesn't have the underlying settings, so cannot verify actual
 > > functionality
 >
 > Thanks for testing. I hope Lingbo has a device with proper ACPI settings.
 >

yes, I'll apply these patch then test it.

 > > Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0:
 > > acpi_evaluate_dsm() failed Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel:
 > > ath12k_pci 0000:03:00.0: failed to get ACPI DSM data: -2 Apr 18
 > > 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi
 > > failed: -2
 >
 > I just want to verify that these are debug messages, right? Normal users
 > shouldn't see any ACPI errors if there are no ACPI settings in the 
system.
 >

Let me check it.

Best regards
Lingbo Kong

 > --
 > https://patchwork.kernel.org/project/linux-wireless/list/
 >
 > 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpat
 > ches

