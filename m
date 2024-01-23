Return-Path: <linux-wireless+bounces-2380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E8838E35
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 13:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1232826F3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDE5D8EB;
	Tue, 23 Jan 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ketP9mxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A265D8F5
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011884; cv=none; b=VYWbo299U8Dgh9xImZu78aNe0t4r9JSVaShVMMiRl/XB7biRssYm+1VMEAoy0S1b8wwqtVad3YIhlPmlZCcsAhE1lWWsnVv25Lc/1HjAx3OifFmaQzSnvtrfKob37ZWrPqvKlNtqwzIsgk5HmbLcLkRuRfR6lmzQbpXOVRen5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011884; c=relaxed/simple;
	bh=ewIUfsXqgzZJND4D92tHwQ1DoMwSlp53WyKMDekk1Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l/aDoif1KgreIuFIUNHPRWffHFim8iv07RTqE9opkEDAgeXloEEiHsRaZbZuk0CpJ3JR2QURkie41BAGYnkFLnPshtwPsYWdcFb+c0JkysiFVwhF9dOvOsR3sGcbDcvo3vKXd3ZACzS/CcW+zdwlf+0tBP6mOvQd+8CEWRaug0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ketP9mxB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N5Mtp3027968;
	Tue, 23 Jan 2024 12:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GCW0j9BJepQthm+7VlZT9SLUFqUQG15+jgQaEKEhH7E=; b=ke
	tP9mxBqL3+M9UdD09WwY5qDlOKjTp8+Ey8ngJLsUB6jKa0Xnn2i+vjO9itE8ieos
	RgvFrt+CmT4GTFiFE0TpkwaZuxNcNOLpO7v17f9Zibf4O0jEtZO/lcJAPyQHz8l5
	YkfokmWWjBFE5xB6KWn/4T0TuhsZzBUbGmhqmeN/zQzXto7u5QcPdBCn+f4c6KCA
	mnxfiGvl9xJdHwXoYs+wONoO+xZUmA3qvTi4LtWRPYvdUn5KLR3uWK/lEsaCNWG5
	EzBThvpilO8j1qrIWPM4zk7gX0tl3nVsofpmmSZREBaCCiMQJeUR29lRoGDUVO9a
	0U7gm92C4yxHaSuW6r+Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt5sg8y9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:11:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NCBDjK032349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:11:13 GMT
Received: from [10.201.207.25] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 04:11:11 -0800
Message-ID: <b22a3c69-f7a6-8a89-a3da-ab776e5e57c9@quicinc.com>
Date: Tue, 23 Jan 2024 17:41:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath12k: add firmware-2.bin support
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240105164207.2906093-1-quic_rajkbhag@quicinc.com>
 <84a1fba8-b709-4bf5-8fc0-9d32d245f9ff@quicinc.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <84a1fba8-b709-4bf5-8fc0-9d32d245f9ff@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RPFo6htmZL9-ZBgk7y4Z9XdiJJmoNvGs
X-Proofpoint-ORIG-GUID: RPFo6htmZL9-ZBgk7y4Z9XdiJJmoNvGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230089

On 1/6/2024 12:06 AM, Jeff Johnson wrote:
> On 1/5/2024 8:42 AM, Raj Kumar Bhagat wrote:
>> Firmware IE containers can dynamically provide various information
>> what firmware supports. Also it can embed more than one image so
>> updating firmware is easy, user just needs to update one file in
>> /lib/firmware/.
>>
>> The firmware API 2 or higher will use the IE container format, the
>> current API 1 will not use the new format but it still is supported
>> for some time. Firmware API 2 files are named as firmware-2.bin
>> (which contains both amss.bin and m3.bin images) and API 1 files are
>> amss.bin and m3.bin.
>>
>> Currently ath12k PCI driver provides firmware binary (amss.bin) path to
>> MHI driver, MHI driver reads firmware from filesystem and boots it. Add
>> provision to read firmware files from ath12k driver and provide the amss.bin
>> firmware data and size to MHI using a pointer.
>>
>> Currently enum ath12k_fw_features is empty, the patches adding features will
>> add the flags.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/Makefile |   3 +-
>>  drivers/net/wireless/ath/ath12k/core.c   |  10 +-
>>  drivers/net/wireless/ath/ath12k/core.h   |  16 ++-
>>  drivers/net/wireless/ath/ath12k/fw.c     | 165 +++++++++++++++++++++++
>>  drivers/net/wireless/ath/ath12k/fw.h     |  27 ++++
>>  drivers/net/wireless/ath/ath12k/mhi.c    |  20 ++-
>>  drivers/net/wireless/ath/ath12k/qmi.c    |  51 ++++---
>>  7 files changed, 267 insertions(+), 25 deletions(-)
>>  create mode 100644 drivers/net/wireless/ath/ath12k/fw.c
>>  create mode 100644 drivers/net/wireless/ath/ath12k/fw.h
>>
> ...
>> +int ath12k_fw_map(struct ath12k_base *ab)
>> +{
>> +	int ret;
>> +
>> +	ret = ath12k_fw_request_firmware_api_n(ab, ATH12K_FW_API2_FILE);
>> +	if (ret == 0)
>> +		ab->fw.api_version = 2;
>> +	else
>> +		ab->fw.api_version = 1;
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_BOOT, "using fw api %d\n",
>> +		   ab->fw.api_version);
>> +
>> +	return 0;
> 
> since this always returns 0 perhaps make this a void function and remove
> the error checking from the caller?
> 
Will change to void in next version.

>> +}
>> +
>> +void ath12k_fw_unmap(struct ath12k_base *ab)
>> +{
>> +	release_firmware(ab->fw.fw);
> 
> should we memset the entire ab->fw struct to 0 so that there aren't any
> dangling pointers into the firmware buffer?
> 
Will memset entire ab->fw to 0, in next version.

>> +}
> 


