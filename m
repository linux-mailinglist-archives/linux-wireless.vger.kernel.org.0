Return-Path: <linux-wireless+bounces-17853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D00BA19F5A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 08:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E345162363
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CA20101E;
	Thu, 23 Jan 2025 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C1zUb/T1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3320B81D
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618445; cv=none; b=P+2x1lvUVYhS4kn5bjgrHkXq+ZBC0DD13cS46xUJYjq/IskC9d/spG/iTcQICEiik5I7k/paQ5UJjNHK2O5unbg8/kC0zS2gUJWeXzIENN6N6Omk4rT5z22fv3/HssncEP15ovZa3wBCe9tRusINiXgwyHPjDzy4TCnw4UcyHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618445; c=relaxed/simple;
	bh=M869c+aH7dq0/+Gw3o0lgv2gBMbV0NiZPXvV8DvClLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pTVRiomf+57+mW5pNBkh2crN44jiArnZtxBdxfSZkY8h8AawgsVq7gUwWH0a4g3PqtUjGYLK2ObJNvmpzGyPiF/ESAHF7GFtcS9XKWwYGOGbK4oLMAjyNopadnK7nA70HYEhzqzNcmYBXvGbxCJnPm2MO6A6XtLl3vnrdca5tgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C1zUb/T1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N4UamD006117;
	Thu, 23 Jan 2025 07:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QCh6fpRVxZfb0wcVdl8jvdbFvXgNIaZcScS8t+jItNI=; b=C1zUb/T10Zu3EIKo
	Md49JuBjEsBV1oghNLBGcislzTRjdiTke25dpAZWUQ4kjEb+UE2j4YAyEAQCwZig
	R+9teqazOMhkczywPTdussIZgybiwRLpVKKaOVyQOYKTrhuCJB3BI3hQSQ5h/9Gb
	NUkqko5bgNC4BTbkCkJEjGMUxrZIHTXyLtNfQD18/M2IqD6LclgJFdEjf19Pvu8a
	K5jueIXQk+DQffvq9wyYAVizU6z/RpwDmv/UilnyQ3BNCrCPIanbc7pkUXTsc74d
	zshO7ycNhmwaEU6NRlcf/U745NIGKkxqzJxZUUW11FqXsExYOD8x5FcdYDnbR/rI
	GcyTqQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bet8rcqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 07:47:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50N7lJgI002731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 07:47:19 GMT
Received: from [10.231.216.114] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 Jan
 2025 23:47:18 -0800
Message-ID: <e67e6d5f-f9cf-47b3-9374-e7d48d4b68d7@quicinc.com>
Date: Thu, 23 Jan 2025 15:47:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix memory leak in ath12k_pci_remove()
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250122084756.817548-1-quic_miaoqing@quicinc.com>
 <b6f99b64-3b11-4a4e-8995-fa18aa4ea203@oss.qualcomm.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <b6f99b64-3b11-4a4e-8995-fa18aa4ea203@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 45GgFZOG7GzmOYtsefYMWMJDP5Cf2gzm
X-Proofpoint-ORIG-GUID: 45GgFZOG7GzmOYtsefYMWMJDP5Cf2gzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=785 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230059



On 1/23/2025 12:30 AM, Aditya Kumar Singh wrote:
> On 1/22/25 14:17, Miaoqing Pan wrote:
>> --- a/drivers/net/wireless/ath/ath12k/pci.c
>> +++ b/drivers/net/wireless/ath/ath12k/pci.c
>> @@ -1725,6 +1725,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>>       if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
>>           ath12k_pci_power_down(ab, false);
>>           ath12k_qmi_deinit_service(ab);
>> +        ath12k_fw_unmap(ab);
>>           ath12k_core_hw_group_unassign(ab);
>>           goto qmi_fail;
>>       }
> 
> Instead of this, why not move the "qmi_fail:" label above unmap() ?
> 

Good catch, the code base is changed a lot since the v1.

