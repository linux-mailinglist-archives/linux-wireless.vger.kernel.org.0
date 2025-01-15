Return-Path: <linux-wireless+bounces-17522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DFBA117AE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 04:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E203A3FDF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 03:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA222DC57;
	Wed, 15 Jan 2025 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gn5mnh2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC720CCD9
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736910804; cv=none; b=hzZ98oH2Dk27kQrxPQeiyMOYtxneCgfffrq4AI5dzCn3zMiPi4Fp8tOlScLbDjP2YgpjHp/O7HoGD0i3RvixNZt9R7CcZcnvv2RUb3AH0ILgBJpgtVUrAvlT6W8orjjunXQAWX1g6CydCXyQpyBkMgHTB/+3K4S+iR4RJfsaT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736910804; c=relaxed/simple;
	bh=HTGgEVyo9rVPSElIQ7JFqcwJNQbNMW6oJsRqJfRDaxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CvUBRyt2BeYbHqG7aDjawmWdbtlQMefqDQUdjmT3X9kPa1kzfRyzTE8rjNcB6yT/8k9HLUsteb51+eK18UShloS1hY1zL7YpnOCdo2HZqeEp3FQnc8WIMogXtNoWHBew6a9OZIxeBtIE5XIVyaed2ERwQuaLY6w0eOFnNf1ZfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gn5mnh2O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EGj6it009324;
	Wed, 15 Jan 2025 03:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XS/JKT9zTxWXbUnChYk9fQx/VSsU9nRp0K9Z4+OCkoQ=; b=gn5mnh2OSTtj7atR
	YmPTsrkJ6li23CSf62UBVeTKNnXnPkuSDmqZZNICy2ek2UoVO8kNDxwRzfNslfv0
	FiRh4Cts4Qx6KEqaa/BU5+nuevcZB3HEbSqZGdsIi0gOzIzfywN0iyL3RI/EWIPD
	g4eWrRMl4X3QPbxjcTBNIgWSNuzSxZOPTIS0nvMhOoawt1uppT8J2/u8V8dKBSDl
	wN1b0fxvLKI3Z3gI9k4VMczpk2qNqDXvDsUekycF0sUH3G9tE9jgbAW7q8YQ4kMs
	SmttllTmMJOv1V+81OxQgxXa/1KUn4nBJ0fBVGF2PKbwW1cJegbpD44nfTQUERDr
	45YStQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445uqe182b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 03:13:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F3DIXD020197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 03:13:18 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 19:13:17 -0800
Message-ID: <06646c1f-1fb3-4a82-b1b6-f5a093253ea2@quicinc.com>
Date: Wed, 15 Jan 2025 08:43:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] wifi: ath12k: Factory test mode support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
 <dad05b94-05f7-4aa9-8271-d74dd743a748@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <dad05b94-05f7-4aa9-8271-d74dd743a748@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R8my3AKLJP9RcMtybbclxvmoqXS6Txoj
X-Proofpoint-ORIG-GUID: R8my3AKLJP9RcMtybbclxvmoqXS6Txoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_09,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150020



On 1/14/2025 5:36 AM, Jeff Johnson wrote:
> On 1/10/2025 3:18 AM, Aaradhana Sahu wrote:
>> Device is booted in factory test mode for calibration.
>> The commands are sent from userspace application, which
>> is sent to firmware using wmi commands. Firmware sends
>> the response to driver as wmi events and driver sends
>> these events to the application via netlink message.
>>
>> Also added changes related to correct pdev id access for
>> fw test cmd.
>>
>> Aaradhana Sahu (5):
>>   wifi: ath: create common testmode_i.h file for ath drivers
>>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>   wifi: ath12k: add factory test mode support
>>   wifi: ath12k: Fill pdev id for fw test cmd
>>   wifi: ath12k: Disable MLO in Factory Test Mode
>>
>> ---
>> v8:
>>   -Included change for assigning seg_hdr.pdev_id.
>>   -Moved if block to start of ath12k_core_hw_group_set_mlo_capable()
>> v7:
>>   -Updated copyright
>>   -Moved ath12k_ftm_check in ath12k_core_hw_group_set_mlo_capable()
>> v6:
>>   -Rebased on ToT
>>   -Updated copyright
>>   -Added patch[5/5]
>> v5:
>>   -Updated copyright
>>   -Fixed line length within 90 char
>> v4:
>>   -Rebased on latest ToT
>> v3:
>>   -Rebased on latest ToT
>>   -Updated Tested-on Tag
>>   -Removed second parameter of ath12k_core_start()
>>   -Updated copyright
>> v2:
>>   -Rebased on latest ath ToT
>> ---
>>
>>  drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
>>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>  drivers/net/wireless/ath/ath12k/core.c        |  30 +-
>>  drivers/net/wireless/ath/ath12k/core.h        |  13 +-
>>  drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
>>  drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
>>  drivers/net/wireless/ath/ath12k/mac.c         |  17 +-
>>  drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
>>  drivers/net/wireless/ath/ath12k/testmode.c    | 395 ++++++++++++++++++
>>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>  drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
>>  drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
>>  drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
>>  .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>>  14 files changed, 623 insertions(+), 85 deletions(-)
>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>
>>
>> base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
> 
> I wanted to pull this into the pending branch, but it conflicts with a patch
> already there. Can you rebase against ath/master-pending?
> 
Sure, will rebase and send new version.



