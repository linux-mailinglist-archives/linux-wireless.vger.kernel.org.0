Return-Path: <linux-wireless+bounces-9221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00590E206
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 05:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F421F2312A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B10A2139C7;
	Wed, 19 Jun 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LoyPKZKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59E502B1
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768458; cv=none; b=EKdR26PU6OGfdBIblCDs2yHtXqdEgEUgcqWI3eTpBxHNyGIPi8V4RfpNBEyq8rbFc8+wdcrml8uhjgWtEijACrGJUA4aLewQYkfyCdMw2YZxKpbNhAOx+3dT3EVEzzgfe3q/Q6tDmecdT+B3UA0eoCvqf47ctBZW4SFNl99qK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768458; c=relaxed/simple;
	bh=W62hpRRPLIbO9WFhISoFHnChsxrfjXsKFQ+DpT5FJXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ik1yUcNYuXDqGcMVn9/SeSdLfmaBx44R6KvtTw5wBJspQxW7iFtngEyt+7gB5uXwPWYnU+fs8lDZTXqTmGoKR+9vjGvR8nLaloPcvZ7Pesrx6ZQGDovdl/pDYk5pz6CauK5VDKAdujhGwRs+ZgPo7DVtG+AakSanpqhOrLPAk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LoyPKZKN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaNaH001119;
	Wed, 19 Jun 2024 03:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6PS6pgSqowtmSYVpHBn5Y+bGvvwHWd3ec5wuM8HblyY=; b=LoyPKZKNIArL160V
	BF5Xmslb9Ta6/FTNOhTVfyA0SMtl/Tn901bbMWLiUP+hVn7kS3jIATB9Z8DaOCfB
	3QLUvqq2nqlee/UNW0qYox+elcTsGa4hDpikTE/N9malVp55ZVIQvA50RTDww8Qj
	Kq0+1cmWLWRsurEGPsba0u2qNT1KJQnJqz7S1oyqvYn49taJKp0BoWicd2sC1Ebm
	My/2WsMnbcFRjsrd7CUygF82W5WnqLeTfAGYDSgAZ+mRuFx42x3GgMM4Q4NdKrKJ
	7RGJo3X74c4fw1O7ecUEi7tK42NShRkyNWcL5LTVjcmyoagOpOo5QyV2aZ1x9tnw
	/58WVw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja28hym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 03:40:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J3eoDg015429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 03:40:50 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 20:40:49 -0700
Message-ID: <5277edb6-cbb5-4b7f-8e2f-df702483021f@quicinc.com>
Date: Wed, 19 Jun 2024 09:10:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] wifi: ath12k: add factory test mode support
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
 <20240617052903.2720292-4-quic_aarasahu@quicinc.com>
 <1f760727-6395-40a9-b817-3c05a5760a10@quicinc.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <1f760727-6395-40a9-b817-3c05a5760a10@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _fSQT5PjqzAssZ5y_BuH6cNECBrO6-6n
X-Proofpoint-ORIG-GUID: _fSQT5PjqzAssZ5y_BuH6cNECBrO6-6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190026



On 6/18/2024 2:43 AM, Jeff Johnson wrote:
> On 6/16/2024 10:29 PM, Aaradhana Sahu wrote:
>> Add support to process factory test mode commands(FTM) for calibration.
>> By default firmware start with MISSION mode and to process the FTM commands
>> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
>> The pre-request is all the radios should be down before starting the test.
>>
>> All ath12k test mode interface related commands specified in enum
>> ath_tm_cmd.
>>
>> When start command ATH_TM_CMD_TESTMODE_START is received, ar state
>> is set to test Mode and FTM daemon sends test mode command to wifi
>> driver via cfg80211. Wifi driver sends these command to firmware as
>> wmi events. If it is segmented commands it will be broken down into
>> multiple segments and encoded with TLV header else it is sent to
>> firmware as it is.
>>
>> Firmware response via UTF events, wifi driver creates skb and send
>> to cfg80211, cfg80211 sends firmware response to FTM daemon via
>> netlink message.
>>
>> Command to boot in ftm mode
>> insmod ath12k ftm_mode=1
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
>> ---
> ...
>>  11 files changed, 560 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
> ...
>> +		ftm_cmd->seg_hdr.segmentinfo = le32_encode_bits(num_segments,
>> +								ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS) |
>> +					       le32_encode_bits(segnumber,
>> +								ATH12K_FTM_SEGHDR_CURRENT_SEQ);
> 
> ath12k-check warns:
> drivers/net/wireless/ath/ath12k/testmode.c:265: line length of 99 exceeds 90 columns
> drivers/net/wireless/ath/ath12k/testmode.c:267: line length of 95 exceeds 90 columns
> 
> suggest splitting the first line at the =
> 		ftm_cmd->seg_hdr.segmentinfo =
> 			le32_encode_bits(num_segments,
> 					 ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS) |
> 			le32_encode_bits(segnumber,
> 					 ATH12K_FTM_SEGHDR_CURRENT_SEQ);
> 

Sure, will update in the next version.

