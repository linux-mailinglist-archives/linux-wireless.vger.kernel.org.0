Return-Path: <linux-wireless+bounces-1740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D482B351
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F47B21F3A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AAB524A5;
	Thu, 11 Jan 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ejJbGzW0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB69524A3
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BDIUEY009070;
	Thu, 11 Jan 2024 16:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2/31ducCo/Mc9BgvIqoie7X5lgvj+f9xXKBXGD8rqoc=; b=ej
	JbGzW0GMMc67nzYOqI4Kt2RxPiUqF0iE8KVdoaf53wdF5mq6BwaI9l5MZIbjOENK
	Q4NBbGKpQefU+n/lLZMUmZHV7mQ9uGiq6GPf5CtH4lutEKgjqZ0iuKueGStY6apa
	ClXVaSmv2PL9CVKKOJNOTf+AqmHENpSGyUymwRfqBpveV2Mwab+cdSGx3P4mqLqJ
	GWg7R3wjo8QWGi4MyfUy+4nLuDp+T8d9LYqiStPAjsRczmjI6abd0E88WDzemPyY
	8ABRjM5QCFIF5FcGrk7G4XndFHcYP+t2NYvh7o2Yvt8qoLJmxdYVYA446H2AVlLk
	Pa17bX5ugd98i21PeBYA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vja9y1g2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:49:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BGnsaD008515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:49:54 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 08:49:53 -0800
Message-ID: <eb6e411a-9842-4546-be6e-f533022e0230@quicinc.com>
Date: Thu, 11 Jan 2024 08:49:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] wifi: ath11k: add support for 6 GHz station for
 various modes : LPI, SP and VLP
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
 <87mstbam42.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87mstbam42.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qne1rDcDCWs5MUVo0ei7sMkDdiM16LCj
X-Proofpoint-GUID: qne1rDcDCWs5MUVo0ei7sMkDdiM16LCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110132

On 1/11/2024 8:08 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> This introduced some new concept:
>> power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
>> power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
>> power spectral density(psd)
>>
>> This patchset is to implement the new rules for 6 GHz band in
>> ath11k.
>>
>> ath11k parsed the reg rules from new WMI event
>> WMI_REG_CHAN_LIST_CC_EXT_EVENTID and parse the
>> transmit power envelope element in beacon of AP
>> and then set new WMI command WMI_VDEV_SET_TPC_POWER_CMDID
>> to firmware when connect to 6G AP, also support backward
>> compatibility with firmware which not support new wmi
>> cmd WMI_VDEV_SET_TPC_POWER_CMDID.
>>
>> v10:
>>  1. [PATCH 02/12] wifi: ath11k: store cur_regulatory_info for each radio
>>   a. s/muti/multi/
>>  2. [PATCH v9 09/12] wifi: ath11k: fill parameters for vdev set tpc power WMI command
>>   a. add idle_ps check when calculating EIRP.
> 
> I don't see Jeff's ack in patches 1, 11 and 12. Jeff, are you ok with
> these?

I failed to go back and add my ack after you said you'd make the
copyright change locally.

> 
> I did some changes in the pending branch, below is a some kind of list
> of the changes. The changed patches are available in the pending branch
> (tag ath-pending-202401111604):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=pending
> 
> multiple patches
> 
> o whitespace changes, especially adding empty line before after if and
>   for statements (also in other pathches)
> 
> patch 1
> 
> o remove unneeded parenthesis
> 
> patch 2
> 
> o ath11k_reg_reset_info(): invert if check
> 
> o ath11k_reg_reset_info(), ath11k_reg_handle_chan_list(),
>   ath11k_reg_get_ar_vdev_type(), ath11k_reg_is_world_alpha:
>        move to reg.c, I did also consider renaming these to use
>        ath11k_wmi_ prefix but thought that reg.c is more approriate
>        place for them
> 
> patch 11
> 
> o remove comments from enum wmi_tlv_cmd_id
> 
> o other cosmetic changes in wmi.h
> 

Reviewed the pending changes
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



