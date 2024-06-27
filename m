Return-Path: <linux-wireless+bounces-9672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A991AF16
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 20:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5204728B52B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D419A298;
	Thu, 27 Jun 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ODEByM9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCAD1CD31
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512999; cv=none; b=sLFMQVjo6UPgaANuCws/sJ+ac2Ux22YDxVeP/i3kYbjFLg5Ro2zx2GJLoNprHZFGeS6FnktJ7YfxUBSHq2jsPa5NQEv5TbE5ACjb5kVe5J/LIkeQ4xRvK5csdcursjE6IMpFfB75QdqJsEiqEcWV3+AhvW56jjsoAXiC9fTGyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512999; c=relaxed/simple;
	bh=UjUSWJHH2Y0/5Qb1/NQbZ92AvFpb43ibQkhesIupK44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=puaIHxua8yDlMhgH8WhsNSxDOE6bnqbqW+RdpO5kFz/ea9QvL0xp9/bLvRixAfiatWfX1FBwv2LHTn28zwEOB3UpXzq7uv8vrSzJMcFsrzO67gJAYdjyv99NZ3FrA9SC1czL62sIO+0eEbEbxwlbxo1aVf3uwIypfNZgdSV1J+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ODEByM9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RBeIQF023502;
	Thu, 27 Jun 2024 18:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JpbleYAslI1zFFxkc8UhYKmB5BMTJaOvLOp/rXMwRk=; b=ODEByM9EptbAN5uy
	PEjiMn5kYKn1FioqNnuxSALfTDFEmdASVjcquzJuM1rn0ZMHNmtsedWxGeGLbbOJ
	MiNt6Qrv/9oDX63yb83w62+GF30Oc4rxY5CnT/Ju2plXYAkZ+dNk4me9Rv/Po9z5
	LxIxdjmAcsCcDVwBZWx9G0KiDXdOyqG2r3qWNOumzSPrh6AifUmnHFJmypKw/k1C
	Aj9Yg9uwVmLHL7cKNABZLkN47eJWI4w7czwvFFT7HZ3xAbozdtDZJPeyy/BSUYMr
	cphtidxWHtIMxfhL8AKouyKby/n7uCDMiJav6Lxp4GajC9XcB0DZAhYYEP9sqaK8
	KheF+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400f90mfu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 18:29:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RITo4j015081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 18:29:50 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 11:29:49 -0700
Message-ID: <7ac1fa0d-0c5c-4f24-9ec1-4e80e785254f@quicinc.com>
Date: Thu, 27 Jun 2024 11:29:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] wifi: ath12k: add factory test mode support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Aaradhana Sahu <quic_aarasahu@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240624095305.37189-4-quic_aarasahu@quicinc.com>
 <171951023642.2426772.2204079316674415145.kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171951023642.2426772.2204079316674415145.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CGdtMPY4xWRf41N7ffD7RsYebj5ImLoZ
X-Proofpoint-GUID: CGdtMPY4xWRf41N7ffD7RsYebj5ImLoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270138

On 6/27/2024 10:43 AM, Kalle Valo wrote:
> Aaradhana Sahu <quic_aarasahu@quicinc.com> wrote:
> 
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
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Now that the wow patchset was applied I saw a new warning:
> 
> drivers/net/wireless/ath/ath12k/wow.c: In function 'ath12k_wow_op_resume':
> drivers/net/wireless/ath/ath12k/wow.c:982:17: warning: enumeration value 'ATH12K_HW_STATE_TM' not handled in switch [-Wswitch]
> 
> I fixed it adding the new state to ath12k_wow_op_resume(), please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=882f310572b27564412e1d6158d1e9709861b7a7
> 
LGTM, thanks!

