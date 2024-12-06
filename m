Return-Path: <linux-wireless+bounces-15966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6309E6CBF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 12:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B082824B7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D251FC7E9;
	Fri,  6 Dec 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dy5rMnjI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9FF155C94;
	Fri,  6 Dec 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483270; cv=none; b=VjPzWPDkKkO4M8QMMRGN7N8iQMdHypVe4rynMgFPmQ933KkkpZdZHm5LeEDRy5n5DYpiM65deAKpqnJeUP76g8vyon5gZ0HZznCW4cabZMyVtlFxyGzX4oXG9MQhb0AiA4DJZPxPeFHY1A/VdWpWNAeoHkAzLlsgSl9WqQ7y/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483270; c=relaxed/simple;
	bh=y5vOAzuNQWniC5L3Do5/e/IVCLQaEme8W9EdB+yFzXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g29jR/Xpg0usg5/v5UsrAukQ/liRzzSH91ndsQ+TACZmtXpF4/KtSQtPEcKhOnwqDnayzkm9C/wkklNShTUTnz+bxNSJNOKIrphJOKU3bKQ3C/91SwbiVzKi2EbDuz22YfxF6dsh6SkWR5S5f/n7Bk+F8tyN8OgqcnMe/VQGtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dy5rMnjI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66kkrY016877;
	Fri, 6 Dec 2024 11:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1lLeIj9ZC2mS5g76o4o6f2hDmvee13oLz6cpCNvUnj8=; b=dy5rMnjIK+eVLGV0
	DRi3yvvhbGzm0GRgSVNXASuBB53vAacRbiImSrU42xFRiiUFtfYHMStJTfKZOtYi
	I3aT7wmNdWEbwwjQJtzlFWjSRKQBBBRSsk8HSO6NSHmugQdN64FRgGV9ZM6u+hto
	qpn3a67NQRov7lkdT+/bdsTOc0uoNwPYeQy9AMRlOrFyVcnbJ26cglVDDiLodQ5Y
	FoDoR5tItjU1LATal8Umo6pjqIWmmnNhP4rVTeibkSlsiqNeTY6F8D7AUqZK2wVr
	u9J226wOmU2KmpcUh4qlB9eXqCs4zoDEwSU8HIkFfeSVnnwJFkaegft8JrGLt2JC
	GfpkbA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbnmkbv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:07:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6B7f2x031107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 11:07:41 GMT
Received: from [10.151.41.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Dec 2024
 03:07:36 -0800
Message-ID: <0b2f8734-f502-42d7-bdc5-b0d382d2aa70@quicinc.com>
Date: Fri, 6 Dec 2024 16:37:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/22] wifi: ath12k: add Ath12k AHB driver support for
 IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <ou5kgedz5aga4dtda6k23uhybcjy7mfwie74p6q3qyn5bdajz7@ftejp7lqrise>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <ou5kgedz5aga4dtda6k23uhybcjy7mfwie74p6q3qyn5bdajz7@ftejp7lqrise>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eOj5rPgQ7y1SBrL_GUqGg7AwhE9HK2UZ
X-Proofpoint-GUID: eOj5rPgQ7y1SBrL_GUqGg7AwhE9HK2UZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060082

On 10/16/2024 12:27 PM, Krzysztof Kozlowski wrote:
> On Tue, Oct 15, 2024 at 11:56:15PM +0530, Raj Kumar Bhagat wrote:
>> Currently, Ath12k driver only supports WiFi devices that are based on
>> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
>> Ath12k AHB support for IPQ5332.
>>
>> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
>> device:
>> - Add hardware parameters for IPQ5332.
>> - CE and CMEM register address space in IPQ5332 is separate from WCSS
>>   register space. Hence, add logic to remap CE and CMEM register
>>   address.
>> - Add support for fixed QMI firmware memory for IPQ5332.
>> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>>   AHB support.
>>
>> Depends-On: [PATCH V7 0/5] remove unnecessary q6 clocks
>> Depends-On: [PATCH V2 0/4] Add new driver for WCSS secure PIL loading
>> Link: https://lore.kernel.org/all/20240820055618.267554-1-quic_gokulsri@quicinc.com/
>> Link: https://lore.kernel.org/all/20240829134021.1452711-1-quic_gokulsri@quicinc.com/
> 
> These are series targetting other subsystems. I do not understand why
> you created such dependency. It does not look needed and for sure is not
> good: nothing here can be tested, nothing can be applied.

To validate this series, the dependencies mentioned above were necessary, which
is why they were included.

Currently, the "[PATCH V7 0/5] remove unnecessary q6 clocks" has been merged,
so this dependency will not be required in the next version.

The "[PATCH V2 0/4] Add new driver for WCSS secure PIL loading" series is still
under review and is required for validation.

However, this series can still be applied and compiled without these dependencies.
Please let us know if we should remove the dependency in the next version.

