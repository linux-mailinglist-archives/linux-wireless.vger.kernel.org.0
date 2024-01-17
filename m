Return-Path: <linux-wireless+bounces-2088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640A8301FA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF6CB22C64
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CE12E6F;
	Wed, 17 Jan 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EWvHpqsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7C1170D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482942; cv=none; b=hZG58Zx62TPm0PBCcyOhDtfRhkzSI2V/GoAMT3LHdJfOLaojzlrSZZQolF3J34SomUPjmIiiIoaz3MapjZCNTvnJlDlG1Vm+Wu7zmhAVZ/49E+jC6k9lWLJiCbhZ3DpnoDzMVcZ43cbRc5WP5A1IzlRN++R5Dk/gVgV6vzXC44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482942; c=relaxed/simple;
	bh=re9yfur5WXEaEFsGduvn3vqUGHhVvynQmRiIR159tdU=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=bSgpP+u2V841Iv+mf4ndwuI+7g80MZZETZXcLs41eLDMfMuxh7IesXY7IjOAeeNnjE5q8Yj3m0IdyWkTJDNqJQ7vqLh2sw8sWJrIrKWeYebsklM6/s+caJ3wrHzkAm4NK2WE4x8DsWk9PbB9qO0xQgSpxNIWTne5QTIPjVvrh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EWvHpqsl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H6cVls022031;
	Wed, 17 Jan 2024 09:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TKL69xHVpkYC4jBDgrX39I6XFRRzyUFFR9HVSRdrjiI=; b=EW
	vHpqslC0xqjg8pP/WuKc+objRKbGBcz05ptuLL/a1hL4sI2u1r3pKAQIUkIP/hpW
	rWAKGXhtwBBWek79GTwT++K5rdCyqH+mUhR/96fD+WZDnzyzuE0lask0WbRs20F2
	4MVLxgIueL73nZNqKBEm8RJWWIZs5z1Wv2wY3VLeP+/cu1Cn+t5O5ORNMbejblzQ
	41NeqJFaN+VEW5vm52AXHF0dt9r+sq/G1pgblkPRsJcYb/CbSFfJmpfYaep5THkE
	VSX8KgaK9DTY10HZhs2XFfgcEzOVJEBzy1Led8BKboOz3RnBT+/OluSlYRKWcPNO
	0bf/vN7n2/RBb2jYKmWg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak0wu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 09:15:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H9FZC6014361
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 09:15:35 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 01:15:34 -0800
Message-ID: <da4cb6c3-4941-4efb-aff6-4948ed311b99@quicinc.com>
Date: Wed, 17 Jan 2024 17:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add support for collecting firmware log
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240115023726.2866-1-quic_bqiang@quicinc.com>
 <87ttnc5oar.fsf@kernel.org>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87ttnc5oar.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: un5XB6o1pzi7hAzxdVRj3KRSUvKTx7RB
X-Proofpoint-GUID: un5XB6o1pzi7hAzxdVRj3KRSUvKTx7RB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=849 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170063



On 1/17/2024 4:58 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> Currently there is no way to collect firmware log because firmware
>> does not send it to host. Also host does not handle WMI_DIAG_EVENTID
>> which is used by firmware to upload firmware log.
>>
>> So add support for it by firstly enabling firmware log upload via a
>> QMI message, and secondly processing WMI DIAG event to expose it to
>> userspace via trace event.
>>
>> This change applies to both WCN7850 and QCN9274.
>>
>> Tested-on: WCN7850 hw2.0 PCI
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> I did some cosmetic changes like reverse xmas tree, debug messages etc.
> 
>> +static int ath12k_qmi_wlanfw_wlan_ini_send(struct ath12k_base *ab, bool enable)
> 
> As enable was always true I removed it. We can add it back later if it's
> needed.
> 
>> +struct qmi_wlanfw_wlan_ini_req_msg_v01 {
>> +	/* Must be set to true if enablefwlog is being passed */
>> +	u8 enablefwlog_valid;
>> +	u8 enablefwlog;
> 
> 'enablefwlog' is really awkward and it's used in several places, why not
> 'enable_fwlog' which is far more readable? I could change that in the
> pending branch.
Yes, Kalle, it is more readable by changing enablefwlog to enable_fwlog.

> 

