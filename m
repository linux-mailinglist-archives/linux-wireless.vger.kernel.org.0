Return-Path: <linux-wireless+bounces-11613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBA956764
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C131F25565
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3115E5AB;
	Mon, 19 Aug 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a3smlCVt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186215B55D
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060744; cv=none; b=On6uF1drpz+7BlwGdy7TU4Q/FlCoLLLF9HbO5LgfTyX4u90yDNgcDlCHn1irLixz+7ekzF7hdKqanoScJnSY/40qqC33sZxFvnKDKfppbskakQjNpRV0zSu03OzzS5R8gIGMMK/bg0EDshCrb8Ju2iKkrRkuP2UJRoW0PG43nfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060744; c=relaxed/simple;
	bh=B+alG2Qup606pPK8ehr4sycAgxGXVlTtyxls+7hSTPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f756DY++gwYLWEdC3J16SGm9il8TrJomehp27xThwHnUjNY4vbNgehcYKEYCpOFkVn32HEEOJXmqOj9itzpTpluYrvnFeLMPsUkoAMMdqqVm07FL8hGa6CANKO0cJj31JXny+BVXxFyV8WavRHeGhVMmlIue7UUL2OMwxVRl/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a3smlCVt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47INtaZt021043;
	Mon, 19 Aug 2024 09:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qSqwjhjjlmrKrc9ShaVdfdrNUt0XxZncU4eoCgLdrRA=; b=a3smlCVtnC75jaaN
	kwUfnoxvRjpuwSDgpmPs/tfpiqf0XqJOwHzm9MutXoJv2q2To2Muy4uU/7Nxlbl1
	YL3BoVx9dQ+LAro+MdTWZcMeJ8IO+z7oaYrkuYRo5EDSxeRlb4eyxSDYnvq8XhJP
	BXGd5O8Fk1IvmWir1uzI9lWbe6TTT39HawcOlamkBQcfokuGy5HGoax+pRhMw0nG
	sn8W8WP+OsGT9ybTlAN4bdAqrzyt6MGpdGrxkgGP2Rw40R/fi2DbSk3glHE+HBWc
	RXrk9L64x9LVE6K6K2MbydZB4BqAl+KNVYIlH2XmfTYTOhzki+CdfIFZaczkjpRO
	739xxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412k6gbq6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:45:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47J9jagR025362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:45:36 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 02:45:35 -0700
Message-ID: <e49b05be-7fdd-4007-9137-e46703812fa1@quicinc.com>
Date: Mon, 19 Aug 2024 17:45:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath10k: fix invalid VHT parameters
To: James Prestwood <prestwoj@gmail.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
 <603104a7-a1ea-43c2-b0d5-fd4e46a27fe6@gmail.com>
 <64c8a9c6-9da7-4e25-9245-490c9e7e21d2@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <64c8a9c6-9da7-4e25-9245-490c9e7e21d2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6sffpklpysCBA8KUPg2F0TL4rGLskuR4
X-Proofpoint-GUID: 6sffpklpysCBA8KUPg2F0TL4rGLskuR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_08,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190066



On 8/14/2024 11:46 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 7/15/24 5:38 AM, James Prestwood wrote:
>> Hi Baochen,
>>
>> I've compiled both changes and so far those messages are gone.
>>
>> Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2
> 
> I just noticed another one actually:
> 
> invalid vht params rate 585 100kbps nss 1 mcs 4
Ah :(

James, could you share some info about this? like hardware target, firmware version, AP model, and any specific steps to hit this.

> 
> Thanks,
> 
> James
> 
>>
>> On 7/10/24 7:03 PM, Baochen Qiang wrote:
>>> supported_vht_mcs_rate_nss1 and supported_vht_mcs_rate_nss2 in host do not
>>> align with firmware's definitions, resulting in some warnings. Fix them.
>>>
>>> Baochen Qiang (2):
>>>    wifi: ath10k: fix invalid VHT parameters in
>>>      supported_vht_mcs_rate_nss1
>>>    wifi: ath10k: fix invalid VHT parameters in
>>>      supported_vht_mcs_rate_nss2
>>>
>>>   drivers/net/wireless/ath/ath10k/mac.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>
>>> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

